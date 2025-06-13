
import sys
import json
import requests
from ortools.constraint_solver import pywrapcp, routing_enums_pb2
import time

# CLAVE DE LA AP Y NUMERO DE HORAS PERMITIDAS DE JORNADA
API_KEY = 'AIzaSyB2wKLunLGMaj30wVT40I5CiBR-8erSMeI'
HORA_INICIO = 28800  # 08:00 AM
MAX_SEGUNDOS_JORNADA = 24 * 3600

try:
    with open(sys.argv[1], 'r') as f:
        datos = json.load(f)
except Exception as e:
    print(json.dumps({"error": f"Error al leer el JSON: {e}"}), file=sys.stderr)
    sys.exit(1)
# OBTENEMOS LOS PARAMETROS PASADOS 
conductores = datos.get('conductores', [])
servicios = datos.get('servicios', [])
if not servicios or not conductores:
    print(json.dumps([]))
    sys.exit(0)

#CONSTRUIMOS LA MATRIZ PARA LA API DISTANCE MATRIX
def construir_matriz(ubicaciones, api_key):
    puntos = [f"{round(u['latitud'], 6)},{round(u['longitud'], 6)}" for u in ubicaciones]
    n = len(puntos)
    matriz = [[0] * n for _ in range(n)]
    departure_time = int(time.time()) + 60
    for i in range(n):
        dest_chunks = [puntos[j:j+25] for j in range(0, n, 25)]
        fila_completa = []
        for chunk in dest_chunks:
            orig_str = puntos[i]
            dest_str = "|".join(chunk)
            url = (f"https://maps.googleapis.com/maps/api/distancematrix/json?origins={orig_str}&destinations={dest_str}&mode=driving&departure_time={departure_time}&key={api_key}")
            try:
                r = requests.get(url, timeout=15)
                r.raise_for_status()
                bloque = r.json()
                if bloque['status'] != 'OK' or not bloque['rows']: raise ValueError(f"API Google: {bloque.get('error_message', bloque['status'])}")
                elementos = bloque['rows'][0]['elements']
                fila_completa.extend([(e.get('duration_in_traffic', e['duration'])['value'] if e['status'] == 'OK' else 9999999) for e in elementos])
            except Exception as e:
                print(json.dumps({"error": f"Fallo en matriz({i}): {e}"}), file=sys.stderr)
                sys.exit(1)
        matriz[i] = fila_completa
    return matriz

ubicaciones = conductores + [s['recogida'] for s in servicios] + [s['entrega'] for s in servicios]
matriz_tiempos = construir_matriz(ubicaciones, API_KEY)

#  3. Preparación y Resolución 
manager = pywrapcp.RoutingIndexManager(len(ubicaciones), len(conductores), list(range(len(conductores))), list(range(len(conductores))))
routing = pywrapcp.RoutingModel(manager)

nodos_recogida = set(range(len(conductores), len(conductores) + len(servicios)))
nodos_entrega = set(range(len(conductores) + len(servicios), len(ubicaciones)))
nodos_deposito = set(range(len(conductores)))

def coste_callback(from_index, to_index):
    from_node = manager.IndexToNode(from_index)
    to_node = manager.IndexToNode(to_index)
    es_vacio = from_node in nodos_deposito or from_node in nodos_entrega
    return matriz_tiempos[from_node][to_node] + 300 if es_vacio else matriz_tiempos[from_node][to_node]
transit_idx = routing.RegisterTransitCallback(coste_callback)
routing.SetArcCostEvaluatorOfAllVehicles(transit_idx)

# ==============================================================================
# ======================== AQUÍ ESTÁ LA CORRECCIÓN FINAL =======================
# ==============================================================================
# Cambiamos 'True' por 'False' para evitar la contradicción lógica.
# Le decimos al solver: "No fuerces el inicio a cero, yo me encargo".
routing.AddDimension(transit_idx, 0, MAX_SEGUNDOS_JORNADA, False, "Time")
time_dimension = routing.GetDimensionOrDie("Time")
time_dimension.SetGlobalSpanCostCoefficient(100)

# Ahora esta línea funcionará sin problemas
for v in range(len(conductores)):
    time_dimension.CumulVar(routing.Start(v)).SetRange(HORA_INICIO, HORA_INICIO)

def demand_callback(from_index):
    node = manager.IndexToNode(from_index)
    if node in nodos_recogida: return 1
    if node in nodos_entrega: return -1
    return 0
routing.AddDimensionWithVehicleCapacity(routing.RegisterUnaryTransitCallback(demand_callback), 0, [1] * len(conductores), True, 'Capacity')
for i in range(len(servicios)):
    p_idx = manager.NodeToIndex(len(conductores) + i)
    d_idx = manager.NodeToIndex(len(conductores) + len(servicios) + i)
    routing.AddPickupAndDelivery(p_idx, d_idx)

# --- RESOLVER ---
params = pywrapcp.DefaultRoutingSearchParameters()
params.first_solution_strategy = routing_enums_pb2.FirstSolutionStrategy.PARALLEL_CHEAPEST_INSERTION
params.local_search_metaheuristic = routing_enums_pb2.LocalSearchMetaheuristic.GUIDED_LOCAL_SEARCH
params.time_limit.FromSeconds(180)

solution = routing.SolveWithParameters(params)

# --- IMPRIMIR RESULTADO ---
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