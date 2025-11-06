{{ dbt_utils.union_relations(
    relations=[
        ref('stg_ai__users'), 
        ref('stg_datascience__users'), 
        ref('stg_genai__users')
    ], 
    source_column_name=none
) }}