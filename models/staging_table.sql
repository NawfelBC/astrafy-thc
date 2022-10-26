{{config( materialized='table')}}

SELECT * FROM `bigquery-public-data.crypto_bitcoin_cash.transactions` as transactions
WHERE DATE(transactions.block_timestamp) BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 3 MONTH) AND CURRENT_DATE()