{{config( materialized='table')}}

-- This table is created from the union of inputs and outputs. Inputs are set negative
-- so we can calculate the balance of each address by adding up (earnings + (- spendings))
WITH inputs_outputs AS (
    SELECT
    array_to_string(inputs.addresses, ",") as address
    , -inputs.value as value
    FROM `astrafy-thc.dbt_nawfelbc.inputs` as inputs
    UNION ALL
    SELECT
    array_to_string(outputs.addresses, ",") as address
    , outputs.value as value
    FROM `astrafy-thc.dbt_nawfelbc.outputs` as outputs
)

SELECT
   address 
,   sum(value) as balance
FROM inputs_outputs
WHERE address NOT IN (
    -- Table listing all distinct addresses that had at least one transaction on Coinbase
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

