{{ config(materialized='view') }}

select {{ dbt_utils.star(ref('stg_ai__questions')) }} from {{ ref('stg_ai__questions') }}
union all
select {{ dbt_utils.star(ref('stg_datascience__questions')) }} from {{ ref('stg_datascience__questions') }}
union all
select {{ dbt_utils.star(ref('stg_genai__questions')) }} from {{ ref('stg_genai__questions') }}