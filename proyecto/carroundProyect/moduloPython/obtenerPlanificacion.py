import sys
import json
import requests
from ortools.constraint_solver import pywrapcp, routing_enums_pb2
import math

API_KEY = 'AIzaSyB2wKLunLGMaj30wVT40I5CiBR-8erSMeI'
HORA_INICIO = 25200  # 07:00 AM en segundos

# --- 1. Leer JSON de entrada ---
with open(sys.argv[1], 'r') as f:
    datos = json.load(f)

conductores = list(datos['conductores'])
servicios = datos['servicios']
ubicaciones = conductores + [s['recogida'] for s in servicios] + [s['entrega'] for s in servicios]

def construir_matriz(ubicaciones):
    def fetch_block(origins, destinations):
        orig_str = "|".join(origins)
        dest_str = "|".join(destinations)
        url = (
            "https://maps.googleapis.com/maps/api/distancematrix/json"
            f"?origins={orig_str}&destinations={dest_str}&mode=driving&departure_time=now&key={API_KEY}"
        )
        r = requests.get(url)
        return r.json()

    puntos = [f"{round(u['latitud'], 6)},{round(u['longitud'], 6)}" for u in ubicaciones]
    n = len(puntos)
    matriz = []

    for i in range(n):
        fila = []
        for j in range(0, n, 10):
            bloque = fetch_block([puntos[i]], puntos[j:j+10])
            if "rows" not in bloque or len(bloque["rows"]) == 0:
                print(json.dumps({"error": "Matriz incompleta"}))
                sys.exit(1)
            elementos = bloque["rows"][0]["elements"]
            if len(elementos) != len(puntos[j:j+10]):
                print(json.dumps({"error": "Fila incompleta", "fila": i}))
                sys.exit(1)
            fila += [
                e["duration"]["value"] if e["status"] == "OK" else 999999
                for e in elementos
            ]
        if len(fila) != n:
            print(json.dumps({"error": "Fila no completa en matriz final"}))
            sys.exit(1)
        matriz.append(fila)

    if len(matriz) != n:
        print(json.dumps({"error": "Matriz incompleta final"}))
        sys.exit(1)
    return matriz

matriz = construir_matriz(ubicaciones)

# --- 3. Preparar OR-Tools ---
n_conductores = len(conductores)
n_servicios = len(servicios)
total_nodos = len(ubicaciones)

manager = pywrapcp.RoutingIndexManager(total_nodos, n_conductores, list(range(n_conductores)), list(range(n_conductores)))
routing = pywrapcp.RoutingModel(manager)

def coste_callback(from_index, to_index):
    f = manager.IndexToNode(from_index)
    t = manager.IndexToNode(to_index)
    return matriz[f][t]

transit_idx = routing.RegisterTransitCallback(coste_callback)
routing.SetArcCostEvaluatorOfAllVehicles(transit_idx)

routing.AddDimension(
    transit_idx,
    300,
    86400,
    False,
    "Time"
)
tiempo = routing.GetDimensionOrDie("Time")

for v in range(n_conductores):
    tiempo.CumulVar(routing.Start(v)).SetValue(HORA_INICIO)

for i, servicio in enumerate(servicios):
    rec = n_conductores + i
    ent = n_conductores + n_servicios + i

    pickup_index = manager.NodeToIndex(rec)
    delivery_index = manager.NodeToIndex(ent)

    routing.AddPickupAndDelivery(pickup_index, delivery_index)
    routing.solver().Add(routing.VehicleVar(pickup_index) == routing.VehicleVar(delivery_index))

    duracion_real = int(matriz[rec][ent] * 1.15)
    routing.solver().Add(
        tiempo.CumulVar(delivery_index) >= tiempo.CumulVar(pickup_index) + duracion_real
    )

params = pywrapcp.DefaultRoutingSearchParameters()
params.first_solution_strategy = routing_enums_pb2.FirstSolutionStrategy.PATH_CHEAPEST_ARC

solution = routing.SolveWithParameters(params)

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
else:
    print(json.dumps({"error": "No se encontró solución"}))
    sys.exit(1)

print(json.dumps(resultado))
