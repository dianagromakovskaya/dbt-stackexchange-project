with u as (
  {{ dbt_utils.union_relations(
      relations=[
        source('ai','answers'),
        source('datascience','answers'),
        source('genai','answers')
      ],
      source_column_name=none
  ) }}
),
transformed as (

  select 
    answer_id,
    question_id answer_question_id,
    cast(JSON_VALUE(owner, '$.user_id') as int64) as answer_owner_user_id,
    is_accepted,
    {{ strip_html('body') }} as answer_body,
    DATETIME(TIMESTAMP_SECONDS(creation_date)) as answer_created_date,
    DATETIME(TIMESTAMP_SECONDS(CAST(last_edit_date AS INT64))) as answer_last_edit_date,
    score answer_score,
    snapshot_date,
    site as answer_site

  from u

)
select *
from transformed