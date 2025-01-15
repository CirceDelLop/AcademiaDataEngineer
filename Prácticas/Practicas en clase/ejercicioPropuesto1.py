import pandas as pd  # type: ignore

# Archivos de entrada y salida
input_file = "ventas-x-ciudad.xlsx"
output_file = "ventas-x-ciudad.csv"

try:
    # Leer el archivo Excel
    data = pd.read_excel(input_file)
    
    # Guardar los datos como archivo CSV
    data.to_csv(output_file, index=False, encoding='utf-8')
    print(f"Archivo convertido exitosamente a {output_file}")
    
    # Leer el archivo CSV resultante
    df = pd.read_csv(output_file)
    
    # Agrupar ventas por ciudad y calcular la suma
    if 'Ciudad' in df.columns and 'Ventas' in df.columns:
        ventas_por_ciudad = df.groupby('Ciudad')['Ventas'].sum()
        print("Ventas por ciudad:")
        print(ventas_por_ciudad)
    else:
        print("El archivo no contiene las columnas necesarias ('Ciudad' y 'Ventas').")
except Exception as e:
    print(f"Error durante la ejecución: {e}")