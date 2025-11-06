{{ dbt_utils.union_relations(
    relations=[
        ref('stg_ai__questions'), 
        ref('stg_datascience__questions'), 
        ref('stg_genai__questions')
    ], 
    source_column_name=none
) }}