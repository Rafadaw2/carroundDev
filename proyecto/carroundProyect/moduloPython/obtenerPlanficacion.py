import sys
import json
import requests
from ortools.constraint_solver import pywrapcp, routing_enums_pb2

# --- CONFIGURACIÓN ---
API_KEY = 'TU_API_KEY'  # Sustituye por tu clave real
HORA_INICIO = 25200     # 07:00 AM en segundos

# --- 1. Leer JSON de entrada ---
with open(sys.argv[1], 'r') as f:
    datos = json.load(f)

conductores = datos['conductores']
servicios = datos['servicios']

# --- 2. Construir lista de ubicaciones (domicilios + recogidas + entregas) ---
ubicaciones = conductores + [s['recogida'] for s in servicios] + [s['entrega'] for s in servicios]

def construir_matriz(ubicaciones):
    puntos = "|".join([f"{u['latitud']},{u['longitud']}" for u in ubicaciones])
    url = (
        "https://maps.googleapis.com/maps/api/distancematrix/json"
        f"?origins={puntos}&destinations={puntos}&mode=transit&departure_time=1749070800&key={API_KEY}"
    )
    r = requests.get(url)
    data = r.json()
    matriz = []
    for fila in data["rows"]:
        matriz.append([
            e["duration"]["value"] if e["status"] == "OK" else 999999
            for e in fila["elements"]
        ])
    return matriz

matriz = construir_matriz(ubicaciones)

# --- 3. Preparar OR-Tools ---
n_conductores = len(conductores)
n_servicios = len(servicios)
total_nodos = len(ubicaciones)

manager = pywrapcp.RoutingIndexManager(total_nodos, n_conductores, list(range(n_conductores)))
routing = pywrapcp.RoutingModel(manager)

# Callback de coste
def coste_callback(from_index, to_index):
    f = manager.IndexToNode(from_index)
    t = manager.IndexToNode(to_index)
    return matriz[f][t]

transit_idx = routing.RegisterTransitCallback(coste_callback)
routing.SetArcCostEvaluatorOfAllVehicles(transit_idx)

# Reglas de recogida y entrega
for i, servicio in enumerate(servicios):
    rec = n_conductores + i
    ent = n_conductores + n_servicios + i
    routing.AddPickupAndDelivery(manager.NodeToIndex(rec), manager.NodeToIndex(ent))
    routing.solver().Add(
        routing.VehicleVar(manager.NodeToIndex(rec)) ==
        routing.VehicleVar(manager.NodeToIndex(ent))
    )

# Añadir dimensión de tiempo
routing.AddDimension(
    transit_idx,
    300,      # espera permitida (s)
    86400,    # jornada máxima
    False,
    "Time"
)
tiempo = routing.GetDimensionOrDie("Time")

# Hora de salida fija
for v in range(n_conductores):
    tiempo.CumulVar(routing.Start(v)).SetValue(HORA_INICIO)

# Estrategia de resolución
params = pywrapcp.DefaultRoutingSearchParameters()
params.first_solution_strategy = routing_enums_pb2.FirstSolutionStrategy.PATH_CHEAPEST_ARC

solution = routing.SolveWithParameters(params)

# --- 4. Resultado final ---
resultado = []

if solution:
    for v in range(n_conductores):
        idx = routing.Start(v)
        ruta = []
        while not routing.IsEnd(idx):
            nodo = manager.IndexToNode(idx)
            if nodo >= n_conductores:
                servicio_idx = (nodo - n_conductores) % n_servicios
                tipo = "recogida" if nodo < n_conductores + n_servicios else "entrega"
                servicio_id = servicios[servicio_idx]['id']
                hora = solution.Value(tiempo.CumulVar(idx))
                ruta.append({
                    "tipo": tipo,
                    "servicio_id": servicio_id,
                    "hora_estim": hora
                })
            idx = solution.Value(routing.NextVar(idx))
        resultado.append({
            "conductor_index": v,
            "ruta": ruta
        })

# --- 5. Imprimir JSON en stdout ---
print(json.dumps(resultado))
