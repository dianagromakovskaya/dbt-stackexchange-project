{{
  config(
    materialized='incremental',
    partition_by = {
      "field": "snapshot_date",
      "data_type": "date"
    },
    incremental_strategy='insert_overwrite'
  )
}}
select
    *,
    current_datetime() as loaded_at
from {{ ref('stg_questions_metrics') }}

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
  -- (If event_time is NULL or the table is truncated, the condition will always be true and load all records)
where snapshot_date >= (select coalesce(max(snapshot_date), '1900-01-01') from {{ this }} )

{% endif %}