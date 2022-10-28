# <img src="https://user-images.githubusercontent.com/79513906/198054530-29587267-0d44-43bf-a90f-b29a4b27b3e8.png" width="50" height="50"> Astrafy THC

[Bitcoin Cash](https://bitcoincash.org/) is a cryptocurrency that allows more bytes to be included in each block relative to its common ancestor Bitcoin. There is a public [dataset](https://console.cloud.google.com/marketplace/product/bitcoin-cash/crypto-bitcoin-cash) on BigQuery that contains the blockchain data in their entirety with data pre-processed to be human-friendly and to support common use cases such as auditing, investigating, and researching the economic and financial properties of the system.

In this project, we will use tools such as BigQuery, dbt Cloud and Google Colab to :
- Materialise a staging table
- Materialise a data mart table
- Plot the data for visualization

## Staging table

In this first step, we materialise a [staging table](https://github.com/NawfelBC/astrafy-thc/blob/main/models/staging_table.sql) from the raw table “transactions” that only selects the last three months of data from this raw table.

<p align="center">
<img src="https://user-images.githubusercontent.com/79513906/198061119-b6084019-ee64-4c43-b178-2ce829dd8452.PNG" width="350" height="450">
<br><strong>Figure 1 : Schema of staging table</br></strong>
</p>

## Data mart

Then, we materialise a [data mart](https://github.com/NawfelBC/astrafy-thc/blob/main/models/data_mart.sql) table that gives the current balance for all addresses and exclude addresses that had at least one transaction on Coinbase.

<p align="center">
<img src="https://user-images.githubusercontent.com/79513906/198706051-c004fb00-e15e-47ce-af6d-5632c39ea0eb.PNG" width="500" height="350">
<br><strong>Figure 2 : Sample of data mart</br></strong>
</p>

## Analysis of data

As a last step, we create a [notebook](https://github.com/NawfelBC/astrafy-thc/blob/main/Bitcoin_transactions_analysis.ipynb) to display a graph and plot the amount of transactions per day in the last 3 months on the Y axis with the date on the X axis.

<p align="center">
<img src="https://user-images.githubusercontent.com/79513906/198706621-9c0fbbaa-5036-4470-ba76-338d99e22af0.PNG" width="350" height="250">
<br><strong>Figure 3 : Evolution of the number of transactions in the last 3 months</br></strong>
</p>

## Tools and services used :
- [BigQuery](https://cloud.google.com/bigquery)  
- [dbt Cloud](https://www.getdbt.com/product/what-is-dbt/)  
- [Google Colab](https://colab.research.google.com/)
