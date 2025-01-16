import pandas as pd  # type: ignore

# Crear el diccionario de datos
alumnos = {
    "Nombre": ["Circe", "Jose", "Carmen", "Circe", "Jose", "Carmen"],
    "Calificacion": [85, 90, 75, 75, 80, 90]
}

# Crear el DataFrame
df = pd.DataFrame(alumnos)

# Calcular el promedio de calificaciones por nombre
promedios = df.groupby("Nombre")["Calificacion"].mean()

# Imprimir los promedios
print(promedios)
