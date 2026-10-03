# Retail Intelligence & Profitability Analytics

Projeto de Data Analytics desenvolvido para simular um cenário real de análise de dados numa empresa de retalho.

O objetivo é analisar vendas, rentabilidade, clientes, lojas, descontos, campanhas e inventário, utilizando um fluxo de trabalho completo de Data Analyst.

---

## 📌 Problema de negócio

A empresa pretende perceber se o crescimento das vendas está realmente a traduzir-se num crescimento sustentável da rentabilidade.

Para isso, a análise procura responder a questões como:

- Como evoluem as vendas e o lucro ao longo do tempo?
- Quais são os produtos e categorias com melhor desempenho?
- Que lojas geram mais receita e lucro?
- Como é que os descontos afetam a rentabilidade?
- Quais são os clientes com maior valor?
- Existem produtos com risco de rutura de stock?
- Existem produtos com excesso de stock?
- As campanhas geram apenas receita ou também lucro?
- Existem períodos em que a receita aumenta enquanto o lucro diminui?

---

## 🔄 Fluxo do projeto

O projeto segue um processo de análise de dados de ponta a ponta:

**Dados brutos**
→ **Python / Pandas**
→ **Limpeza e validação**
→ **MySQL** / **SQL**
→ **Power BI / DAX**
→ **Análise de negócio**
→ **Recomendações**

---

## 🛠️ Tecnologias utilizadas

- **Python**
- **Pandas**
- **MySQL**
- **SQL**
- **Power BI**
- **DAX**
- **Excel**
- **Git / GitHub**

---

# 📊 Dados

O projeto utiliza seis tabelas principais:

- **Sales** — transações de vendas
- **Products** — produtos e respetivos custos/preços
- **Customers** — informação dos clientes
- **Stores** — lojas e localização
- **Campaigns** — campanhas e descontos
- **Inventory** — stock por loja e produto

---

# 🐍 Python — Limpeza e validação

O Python é utilizado na fase inicial do projeto para preparar e validar os dados antes da análise.

Foram realizadas verificações como:

- valores nulos
- linhas duplicadas
- IDs inválidos
- quantidades inválidas
- consistência da receita
- consistência do lucro
- custos superiores ao preço de venda
- integridade das relações entre tabelas
- valores de desconto
- consistência dos dados de inventário

### Tratamento dos dados

Foram aplicadas algumas regras de limpeza:

- transações com `quantity <= 0` foram excluídas da análise de vendas
- descontos em falta foram considerados como `0%`
- descontos elevados foram mantidos para permitir analisar o seu impacto na rentabilidade
- a receita foi recalculada com base em:

```text
Receita = Quantidade × Preço Unitário × (1 − Desconto)
```
- o lucro foi recalculado através de:
```text
Lucro = Receita − Custo Total
```
O resultado da limpeza é guardado em:
```text
data/processed/cleaned_retail_intelligence_project.xlsx
```


# 🗄️ MySQL e SQL

Depois da limpeza, os dados são carregados para uma base de dados MySQL.

O ficheiro:

```text
sql/schema.sql
```

contém a estrutura das tabelas da base de dados.

As principais análises SQL encontram-se em:

```text
sql/queries/
```

### Análises realizadas

#### Desempenho mensal

`monthly_performance.sql`

Analisa:

* Receita
* Lucro
* Custos
* Unidades vendidas
* Número de encomendas
* Margem de lucro

#### Desempenho dos produtos

`products_performance.sql`

Analisa:

* Receita por produto
* Lucro por produto
* Margem de lucro
* Desconto médio
* Categorias

#### Desempenho das lojas

`store_performance.sql`

Compara as lojas através de:

* Receita
* Lucro
* Margem
* Desconto médio

#### Valor dos clientes

`customers_value.sql`

Analisa:

* Compras por cliente
* Receita por cliente
* Lucro por cliente
* Receita média por compra
* Margem de lucro

#### Impacto dos descontos

`discount_impact.sql`

Analisa a relação entre o nível de desconto e a margem de lucro.

#### Relação entre receita e lucro

`revenue_profit_relation.sql`

Procura períodos em que a receita aumenta enquanto o lucro diminui.

#### Estado do inventário

`inventory_status.sql`

Identifica situações de:

* Risco de rutura de stock
* Excesso de stock
* Stock saudável

---

# 📈 Power BI

Os resultados da análise são utilizados no Power BI para criar um dashboard interativo.

O ficheiro encontra-se em:

```text
powerbi/Retail_intelligence_analys.pbix
```

### Páginas do dashboard

#### 1. Executive Overview

Visão geral dos principais indicadores:

* Receita
* Lucro
* Margem
* Encomendas
* Unidades vendidas
* Evolução temporal

#### 2. Sales & Products

Análise de:

* Vendas ao longo do tempo
* Produtos
* Categorias
* Receita
* Lucro
* Margem

#### 3. Customers

Análise do comportamento e valor dos clientes.

#### 4. Stores

Comparação entre lojas através de:

* Receita
* Lucro
* Margem
* Descontos

#### 5. Inventory

Análise do stock e identificação de:

* Risco de rutura
* Excesso de stock
* Stock saudável

#### 6. Campaigns

Análise do desempenho das campanhas e do seu impacto na receita e rentabilidade.

---

# 📐 Principais medidas DAX

Algumas das principais medidas utilizadas no Power BI:

```DAX
Total Revenue = SUM(Sales[revenue])
```

```DAX
Total Profit = SUM(Sales[profit])
```

```DAX
Profit Margin = DIVIDE([Total Profit], [Total Revenue])
```

```DAX
Total Orders = DISTINCTCOUNT(Sales[sale_id])
```

```DAX
Average Order Value = DIVIDE([Total Revenue], [Total Orders])
```

---

# 📦 Inventário

O inventário é classificado com base no nível de stock e na velocidade média de vendas.

### Stock Risk

Um produto é considerado em risco de rutura quando:

```text
Stock Units <= Reorder Level
```

### Excess Stock

Um produto é considerado excesso de stock quando:

```text
Meses de stock >= 6
```

### Healthy

Produtos que não se enquadram nas duas situações anteriores são considerados como tendo stock saudável.

---

# 💡 Principais questões de negócio

A análise permite avaliar, entre outras, as seguintes situações:

* Crescimento da receita versus crescimento do lucro
* Produtos com elevada receita mas baixa margem
* Lojas com elevada receita mas menor rentabilidade
* Impacto dos descontos na margem
* Clientes de maior valor
* Produtos com risco de rutura
* Produtos com excesso de stock
* Rentabilidade das campanhas

---

# 📌 Recomendações de negócio

Com base nos resultados da análise, podem ser consideradas medidas como:

* Analisar descontos elevados que estejam a reduzir significativamente as margens
* Avaliar campanhas com base no lucro e não apenas na receita
* Comparar lojas utilizando simultaneamente receita, lucro e margem
* Melhorar a distribuição de stock entre lojas
* Identificar produtos com risco de rutura
* Reduzir excesso de stock
* Segmentar clientes com base em receita, frequência de compra e valor médio das encomendas

---

# 📁 Estrutura do projeto

```text
Data Analys/
│
├── analysis/
│   └── Retail_Intelligence_Business_Analysis.pdf
│
├── data/
│   ├── processed/
│   │   └── cleaned_retail_intelligence_project.xlsx
│   │
│   └── raw/
│       └── retail_intelligence_project.xlsx
│
├── powerbi/
│   └── Retail_intelligence_analys.pbix
│
├── python/
│   ├── data_cleaning.py
│   └── load_to_mysql.py
│
├── sql/
│   ├── queries/
│   │   ├── customers_value.sql
│   │   ├── discount_impact.sql
│   │   ├── inventory_status.sql
│   │   ├── monthly_performance.sql
│   │   ├── products_performance.sql
│   │   ├── revenue_profit_relation.sql
│   │   └── store_performance.sql
│   │
│   └── schema.sql
│
├── .gitignore
└── README.md
```

---

# 🎯 Resultado final

Este projeto demonstra um fluxo completo de Data Analytics:

**Data Cleaning → Data Validation → SQL → Data Modelling → DAX → Power BI → Business Analysis**

O objetivo não é apenas apresentar gráficos, mas transformar dados brutos em informação útil para apoiar decisões de negócio.

---

## 👨‍💻 Competências demonstradas

* Python
* Pandas
* Data Cleaning
* Data Validation
* SQL
* MySQL
* Power BI
* DAX
* Data Modelling
* Business Analysis
* Business Intelligence
* Git / GitHub
