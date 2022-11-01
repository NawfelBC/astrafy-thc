{{config( materialized='table')}} -- This line allows our model to be rebuilt as a table on each run

SELECT *
FROM `bigquery-public-data.crypto_bitcoin_cash.transactions` as transactions
WHERE DATE(transactions.block_timestamp) BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 3 MONTH) AND CURRENT_DATE() -- We filter our data to keep just the last 3 months to this date
ORDER BY transactions.block_timestamp -- We order the data by the timestamp in ascending order
