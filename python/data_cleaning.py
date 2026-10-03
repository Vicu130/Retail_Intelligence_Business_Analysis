import pandas as pd

file_path = 'data/raw/retail_intelligence_project.xlsx'
xls = pd.ExcelFile(file_path)
print(xls.sheet_names)  # Exibe os nomes das abas presentes no arquivo Excel

sales = pd.read_excel(file_path, sheet_name= "Sales")
products = pd.read_excel(file_path, sheet_name= "Products")
customers = pd.read_excel(file_path, sheet_name="Customers")
stores = pd.read_excel(file_path, sheet_name="Stores")
inventory = pd.read_excel(file_path, sheet_name="Inventory")
campaigns = pd.read_excel(file_path, sheet_name="Campaigns")

print(sales.info())  # Exibe informações sobre o DataFrame, incluindo o número de entradas, colunas e tipos de dados
print(sales.isnull().sum())  # Verifica se há valores nulos no DataFrame
print(sales.duplicated().sum())  # Verifica se há linhas duplicadas no  DataFrame
print((sales['quantity'] <= 0).sum())  # Verifica se há valores nulos ou negativos na coluna 'quantity'
expected_revenue = sales["quantity"] * sales["unit_price"] * (1 - sales['discount'].fillna(0))  # Calcula a receita esperada com base na quantidade, preço unitário e desconto
errors = sales[abs(sales["revenue"] - expected_revenue) > 0.01]  # Verifica se a receita corresponde à quantidade multiplicada pelo preço unitário
print(errors)

expected_profit = expected_revenue - sales["cost_total"]  # Calcula o lucro esperado com base na receita esperada e no custo total
profit_errors = sales[abs(sales["profit"] - expected_profit) > 0.01]  # Verifica se o lucro corresponde à receita esperada menos o custo total
print(profit_errors)


print("Quantidade <= 0:")
print((sales["quantity"] <= 0).sum())

print("\nDiscount nulo:")
print(sales["discount"].isnull().sum())

print("\nDiscount >= 50%:")
print((sales["discount"] >= 0.50).sum())

print("\nLinhas duplicadas:")
print(sales.duplicated().sum())

print("\nSale IDs duplicados:")
print(sales["sale_id"].duplicated().sum())

invalid_quantity = sales[sales["quantity"] <= 0]
print(invalid_quantity[["sale_id",
    "date",
    "product_id",
    "quantity",
    "unit_price",
    "discount",
    "revenue",
    "cost_total",
    "profit"]])  # Exibe as linhas com quantidade inválida, mostrando apenas as colunas relevantes

print(sales[sales["quantity"] <= 0]["quantity"].value_counts())

print(products.info())  # Exibe informações sobre o DataFrame de produtos
print(products["product_id"].duplicated().sum())  # Verifica se há IDs de produtos duplicados na tabela de produtos
print(((products['cost']) > (products['price'])).sum())

print(customers.info())  # Exibe informações sobre o DataFrame de clientes
print(customers["customer_id"].duplicated().sum())  # Verifica se há IDs de clientes duplicados na tabela de clientes
print((customers['age'] < 0).sum())  # Verifica se há idades negativas na tabela de clientes

print(stores.info())  # Exibe informações sobre o DataFrame de lojas
print(stores["store_id"].duplicated().sum())  # Verifica se há IDs de lojas duplicados na tabela de lojas
print(stores[['city', 'region']].duplicated().sum())  # Verifica se há cidades duplicadas na tabela de lojas

print(inventory.info())  # Exibe informações sobre o DataFrame de inventário
print((inventory["stock_units"] < 0).sum())  # Verifica se há quantidades de estoque negativas na tabela de inventário   

print(campaigns.info())  # Exibe informações sobre o DataFrame de campanhas

print(len(sales[sales['product_id'].isin(products['product_id']) == False]))  # Verifica se há produtos na tabela de vendas que não estão presentes na tabela de produtos
print(len(sales[sales['customer_id'].isin(customers['customer_id']) == False]))  # Verifica se há clientes na tabela de vendas que não estão presentes na tabela de clientes
print(len(sales[sales['store_id'].isin(stores['store_id']) == False]))  # Verifica se há lojas na tabela de vendas que não estão presentes na tabela de lojas
print(len(sales[(sales['campaign_id'] != 0) & (~sales['campaign_id'].isin(campaigns['campaign_id']))]))  # Verifica se há campanhas na tabela de vendas que não estão presentes na tabela de campanhas
print(sales[(sales['campaign_id'] != 0) & (~sales['campaign_id'].isin(campaigns['campaign_id']))]) 
print(f"Linhas originais em Sales: {len(sales)}")

sales = sales[sales["quantity"] > 0]
sales["discount"] = sales["discount"].fillna(0.0)
sales["revenue"] = round(expected_revenue, 2)
sales["profit"] = round(sales["revenue"] - sales["cost_total"], 2)

expected_revenue = sales["quantity"] * sales["unit_price"] * (1 - sales['discount'].fillna(0))
print((abs(sales["revenue"] - expected_revenue)>0.01).sum()) #Validação da receita após limpeza

expected_profit = expected_revenue - sales["cost_total"]
print((abs(sales["profit"] - expected_profit)>0.01).sum()) #Validação do lucro após limpeza

print(f"Linhas finais em Sales após limpeza: {len(sales)}")

processed_file_path = 'data/processed/cleaned_retail_intelligence_project.xlsx'

with pd.ExcelWriter(processed_file_path, engine="openpyxl") as writer:
    sales.to_excel(writer, sheet_name="Sales", index=False)
    products.to_excel(writer, sheet_name="Products", index=False)
    customers.to_excel(writer, sheet_name="Customers", index=False)
    stores.to_excel(writer, sheet_name="Stores", index=False)
    inventory.to_excel(writer, sheet_name="Inventory", index=False)
    campaigns.to_excel(writer, sheet_name="Campaigns", index=False)