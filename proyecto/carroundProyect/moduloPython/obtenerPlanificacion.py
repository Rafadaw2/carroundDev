
import sys
import json
import requests
from ortools.constraint_solver import pywrapcp, routing_enums_pb2
import time

# CLAVE DE LA AP Y NUMERO DE HORAS PERMITIDAS DE JORNADA
API_KEY = 'AIzaSyB2wKLunLGMaj30wVT40I5CiBR-8erSMeI'
HORA_INICIO = 28800  # 08:00 AM
MAX_SEGUNDOS_JORNADA = 24 * 3600

# OBTENEMOS EL JSON PASADO COMO PARAMETRO Y LO LEEMOS
try:
    with open(sys.argv[1], 'r') as f:
        datos = json.load(f)
except Exception as e:
    print(json.dumps({"error": f"Error al leer el JSON: {e}"}), file=sys.stderr)
    sys.exit(1)
# SACAMOS DEL JSON LOS CONDUCTOES Y LOS SERVICIOS 
conductores = datos.get('conductores', [])
servicios = datos.get('servicios', [])
if not servicios or not conductores:
    print(json.dumps([]))
    sys.exit(0)

#CONSTRUIMOS LA MATRIZ DE DISTANCIAS  DISTANCE MATRIX
def construir_matriz(ubicaciones, api_key):
    #Pasamos a string
    puntos = [f"{round(u['latitud'], 6)},{round(u['longitud'], 6)}" for u in ubicaciones]
    n = len(puntos)
    #Inicializamos la matriz a 0
    matriz = [[0] * n for _ in range(n)]
    #Le pasamos como hora para el calculo la actual mas 1 min para que sea mas real
    departure_time = int(time.time()) + 60
    # coomo tiene un maximo de 25 por llamda lo trocemaos y calculamos la distancia desde un origen a cada psoible destino
    for i in range(n):
        dest_chunks = [puntos[j:j+25] for j in range(0, n, 25)]
        fila_completa = []
        for chunk in dest_chunks:
            orig_str = puntos[i]
            dest_str = "|".join(chunk) #los une asi que es como lo requiere la api
            url = (f"https://maps.googleapis.com/maps/api/distancematrix/json?origins={orig_str}&destinations={dest_str}&mode=driving&departure_time={departure_time}&key={api_key}")
            try:
                r = requests.get(url, timeout=30)#lanzamos la peticiom
                r.raise_for_status()
                bloque = r.json()
                #manejo errores
                if bloque['status'] != 'OK' or not bloque['rows']: raise ValueError(f"API Google: {bloque.get('error_message', bloque['status'])}")
                elementos = bloque['rows'][0]['elements']# lo sacamos en una lista
                fila_completa.extend([(e.get('duration_in_traffic', e['duration'])['value'] if e['status'] == 'OK' else 9999999) for e in elementos])
            except Exception as e:
                print(json.dumps({"error": f"Fallo en matriz({i}): {e}"}), file=sys.stderr)
                sys.exit(1)
        matriz[i] = fila_completa
    return matriz

ubicaciones = conductores + [s['recogida'] for s in servicios] + [s['entrega'] for s in servicios]
matriz_tiempos = construir_matriz(ubicaciones, API_KEY)

#  con manager gestionamos el problema, le pasamos nuestros indices y el los traduce a lo que necesita
manager = pywrapcp.RoutingIndexManager(len(ubicaciones), len(conductores), list(range(len(conductores))), list(range(len(conductores))))
# routing permite manejar restricciones dimensiones...
routing = pywrapcp.RoutingModel(manager)
#Configuramos los nodos para ORLtolls, para que pueda indexar todo como necesita
nodos_recogida = set(range(len(conductores), len(conductores) + len(servicios)))
nodos_entrega = set(range(len(conductores) + len(servicios), len(ubicaciones)))
nodos_deposito = set(range(len(conductores)))

def coste_callback(from_index, to_index):
    from_node = manager.IndexToNode(from_index)
    to_node = manager.IndexToNode(to_index)
    es_vacio = from_node in nodos_deposito or from_node in nodos_entrega
    return matriz_tiempos[from_node][to_node] + 300 if es_vacio else matriz_tiempos[from_node][to_node]
transit_idx = routing.RegisterTransitCallback(coste_callback)#le pasamos la funcion de retraso al modelo
routing.SetArcCostEvaluatorOfAllVehicles(transit_idx)

routing.AddDimension(transit_idx, 0, MAX_SEGUNDOS_JORNADA, False, "Time")
time_dimension = routing.GetDimensionOrDie("Time")#añadimos una dimensasion de tiempo para tener en cuenta la jornada laboral
time_dimension.SetGlobalSpanCostCoefficient(100)# para terminar lo antes posible

# Fijamos la hora de inicio de la jornada
for v in range(len(conductores)):
    time_dimension.CumulVar(routing.Start(v)).SetRange(HORA_INICIO, HORA_INICIO)

def demand_callback(from_index):
    node = manager.IndexToNode(from_index)
    if node in nodos_recogida: return 1
    if node in nodos_entrega: return -1
    return 0
#le asignamos una capacidad de 1 para que así se vea forzado a dejar un vehículo antes de recoger otro
routing.AddDimensionWithVehicleCapacity(routing.RegisterUnaryTransitCallback(demand_callback), 0, [1] * len(conductores), True, 'Capacity')
for i in range(len(servicios)):
    p_idx = manager.NodeToIndex(len(conductores) + i)
    d_idx = manager.NodeToIndex(len(conductores) + len(servicios) + i)
    routing.AddPickupAndDelivery(p_idx, d_idx)#lo debe entregar el mismo

# fijamos los parametros
params = pywrapcp.DefaultRoutingSearchParameters()
#obtiene una primera solucion rapidamente
params.first_solution_strategy = routing_enums_pb2.FirstSolutionStrategy.PARALLEL_CHEAPEST_INSERTION
#busca mejoras
params.local_search_metaheuristic = routing_enums_pb2.LocalSearchMetaheuristic.GUIDED_LOCAL_SEARCH
#tiempo máximo
params.time_limit.FromSeconds(180)

#lanzamos  
solution = routing.SolveWithParameters(params)

# construimos un array con la planificacion
if solution:
    asignaciones = []
    for vehicle_id in range(len(conductores)):
        index = routing.Start(vehicle_id)
        if routing.IsEnd(solution.Value(routing.NextVar(index))): continue
        ruta = []
        while not routing.IsEnd(index):
            node = manager.IndexToNode(index)
            if node >= len(conductores):
                s_idx = (node - len(conductores)) % len(servicios)
                ruta.append({"tipo": "recogida" if node in nodos_recogida else "entrega", "servicio_id": servicios[s_idx]['id'], "hora_estim": solution.Value(time_dimension.CumulVar(index))})
            index = solution.Value(routing.NextVar(index))
        if ruta: asignaciones.append({"conductor_index": vehicle_id, "ruta": ruta,"id":conductores[vehicle_id]['id']})
    print(json.dumps(asignaciones, indent=2))
else:
    status_map = {0: 'NOT_SOLVED', 1: 'SUCCESS', 2: 'FAIL', 3: 'TIMEOUT', 4: 'INVALID'}
    print(json.dumps({"error": f"Sin solución. Estado: {status_map.get(routing.status(), 'UNKNOWN')}"}), file=sys.stderr)
    sys.exit(1)