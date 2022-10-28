{{config( materialized='table')}}

-- This table is created from the union of inputs and outputs.
-- Inputs are set negative so we can calculate the balance of each address by adding up (earnings + (- spendings))
WITH inputs_outputs AS (
    SELECT
    array_to_string(inputs.addresses, ",") as address
    , -inputs.value as value
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
WHERE is_coinbase = False -- We don't want to hold addresses that did at least one transaction via coinbase
GROUP BY 1
ORDER BY balance DESC