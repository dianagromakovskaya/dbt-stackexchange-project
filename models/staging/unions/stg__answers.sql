{{ dbt_utils.union_relations(
    relations=[
        ref('stg_ai__answers'), 
        ref('stg_datascience__answers'), 
        ref('stg_genai__answers')
    ], 
    source_column_name=none
) }}