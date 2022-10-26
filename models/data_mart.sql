{{config( materialized='table')}}

WITH inputs_outputs AS (
   SELECT
    array_to_string(inputs.addresses, ",") as address
   , -inputs.value as value
   FROM `bigquery-public-data.crypto_bitcoin_cash.inputs` as inputs
   UNION ALL
   SELECT
    array_to_string(outputs.addresses, ",") as address
   , outputs.value as value
   FROM `bigquery-public-data.crypto_bitcoin_cash.outputs` as outputs
)

SELECT
   address 
,   sum(value) as balance
FROM inputs_outputs
WHERE address NOT IN (
    SELECT DISTINCT coinbase_addresses
    FROM(
        SELECT addresses, coinbase_addresses
        FROM(
            SELECT inputs,unnested_inputs.addresses
            FROM(
                SELECT inputs
                FROM `astrafy-thc.dbt_nawfelbc.staging_table`
            ), UNNEST(inputs) as unnested_inputs
        ), UNNEST(addresses) as coinbase_addresses
    )
)
GROUP BY 1
ORDER BY balance DESC

