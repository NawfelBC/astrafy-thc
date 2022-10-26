{{config( materialized='table')}}

SELECT CAST(staging_table.block_timestamp as DATE) as date, COUNT(*) as number_of_transactions
FROM `astrafy-thc.dbt_nawfelbc.staging_table` as staging_table
GROUP BY 1
ORDER BY 1