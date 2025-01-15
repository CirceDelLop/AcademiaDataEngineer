import pandas as pd # type: ignore
data = { 

    'Nombre': ['Ana', 'Juan', 'Luis'], 

    'Edad': [23, 30, 45], 

    'Ciudad': ['Madrid', 'Barcelona', 'Valencia'],

    'Salario': [3000, 4000, 5000] 
} 

df = pd.DataFrame(data) 
df['Salario'] = [3000, 4000, 5000] 

df['Edad'] = df['Edad'] + 1
print(df) 
