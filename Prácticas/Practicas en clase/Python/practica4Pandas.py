import pandas as pd # type: ignore
data = [10, 20, 30, 40]
serie = pd.Series(data, index=['A', 'B', 'C', 'D'])
print(serie)