import csv

# def add_quotes(row):

#     output= ""
#     for i in row[1:]:
#         output = output + f"'{i}'"+","
    
#     return output[:-1]

def add_quotes(row):

    output= ""
    for i in row[1:5]:
        output = output + f"'{i}'"+","

    for i in row[5:]:
        output= output + i +','
    
    return output[:-1]

def add_quotes2(row):

    output= ""
    for i in row[1:5]:
        output = output + f"'{i}'"+","

    for i in row[5:17]:
        output= output + i +','
    
    return output[:-1]

def csv_to_oracle(csv_path, output_path, table_name):
    file = open(csv_path, 'r',encoding="utf8")
    data = list(csv.reader(file))
    
    with open(output_path, mode='a') as f:
        for row in data[1:]:
            row = add_quotes(row)
            row = f"insert into {table_name} values ({row});\n"
            f.write(row)

def csv_to_oracle_work(csv_path, output_path, table_name):
    file = open(csv_path, 'r',encoding="utf8")
    data = list(csv.reader(file))
    
    with open(output_path, mode='a') as f:
        for row in data[1:]:
            row = add_quotes2(row)
            row = f"insert into {table_name} values ({row});\n"
            f.write(row)

csv_to_oracle('data_clean/table2_cleaned.csv', 'load_data44.sql', 'modality')
csv_to_oracle_work('data_clean/Workforce_Stats_clean.csv', 'load_data44.sql', 'Workforce_EXT')
#csv_to_oracle('data_clean/GDHI_2021_clean.csv', 'load_data3.sql', 'GDHI_EXT')

