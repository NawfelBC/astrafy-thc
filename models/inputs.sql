SELECT
    transactions.hash as transaction_hash,
    transactions.block_hash,
    transactions.block_number,
    transactions.block_timestamp,
    inputs.index,
    inputs.spent_transaction_hash,
    inputs.spent_output_index,
    inputs.script_asm,
    inputs.script_hex,
    inputs.sequence,
    inputs.required_signatures,
    inputs.type,
    inputs.addresses,
    inputs.value
FROM `astrafy-thc.dbt_nawfelbc.staging_table` as transactions,
    transactions.inputs as inputs