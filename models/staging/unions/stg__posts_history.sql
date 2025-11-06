{{ config(materialized='view') }}

{{ dbt_utils.union_relations(
    relations=[
        ref('stg_ai__posts_history'), 
        ref('stg_datascience__posts_history'), 
        ref('stg_genai__posts_history')
    ], 
    source_column_name=none
) }}