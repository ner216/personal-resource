import pandas as pd
import os

def load_csv():
    file_list = {}
    for idx,file in enumerate(os.listdir("data")):
        file_list[idx] = file
    
    print("Choose a data file to import: ")
    choice = int(input(f'{file_list} \n(int) > '))
    df = pd.read_csv(f'data/{file_list[choice]}')

    return df