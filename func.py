import pandas as pd

def transform_df(df, start_year, end_year):

    vars = ['Apr', 'May', 'Jun', 'Jul', 'Aug','Sep','Oct','Nov', 'Dec', 'Jan', "Feb", 'Mar']

    df = pd.melt(df, id_vars=['Region', 'Org Code', 'Modality'], 
               value_vars=vars,var_name='Month', value_name='MedianWaitDays')

    next_year = ['Mar', 'Feb', 'Jan']
    df = df.assign(Year=df['Month'].apply(lambda x: end_year if x in next_year else start_year))

    df['Date'] = pd.to_datetime(df.Month + '-' + df.Year.astype(str), format='%b-%Y')

    df['Date'] = df['Date'].dt.to_period('M')

    return df