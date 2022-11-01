{{config( materialized='table')}} -- This line allows our model to be rebuilt as a table on each run

-- This table is created from the union of inputs and outputs.
WITH inputs_outputs AS (
    SELECT
    array_to_string(inputs.addresses, ",") as address
    , -inputs.value as value -- Inputs are set negative so we can calculate the balance of each address by adding up (earnings + (- spendings))
    , is_coinbase
    FROM `bigquery-public-data.crypto_bitcoin_cash.transactions`, UNNEST(inputs) as inputs -- We use UNNEST to flatten the array
    UNION ALL
    SELECT
    array_to_string(outputs.addresses, ",") as address
    , outputs.value as value
    , is_coinbase
    FROM `bigquery-public-data.crypto_bitcoin_cash.transactions`, UNNEST(outputs) as outputs
)

SELECT
address 
, sum(value) as balance -- We do the sum of all values for each address to get its current balance
FROM inputs_outputs
WHERE is_coinbase = False -- We filter out all addresses that did at least one transaction via coinbase
GROUP BY 1
ORDER BY balance DESC
