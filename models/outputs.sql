SELECT
    transactions.hash as transaction_hash,
    transactions.block_hash,
    transactions.block_number,
    transactions.block_timestamp,
    outputs.index,
    outputs.script_asm,
    outputs.script_hex,
    outputs.required_signatures,
    outputs.type,
    outputs.addresses,
    outputs.value
FROM `astrafy-thc.dbt_nawfelbc.staging_table` as transactions,
    transactions.outputs as outputs