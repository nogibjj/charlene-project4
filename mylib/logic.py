from databricks import sql
import os

def querydb(input_name="'Water'",input_cat="type_1"):
    query=f"SELECT pokemon_name, type_1, type_2 from pokedex WHERE {input_cat}={input_name} ORDER BY attack DESC LIMIT 10;"
    with sql.connect(
        server_hostname=os.getenv("DATABRICKS_SERVER_HOSTNAME"),
        http_path=os.getenv("DATABRICKS_HTTP_PATH"),
        access_token=os.getenv("DATABRICKS_TOKEN")) as connection:

        with connection.cursor() as cursor:
            cursor.execute(query)
            result = cursor.fetchall()
        
            for row in result:
                print(row)
    return result