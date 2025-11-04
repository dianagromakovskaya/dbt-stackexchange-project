with 

source as (

  select * from {{ source('ai', 'answers') }}

),

transformed as (

  select 

    answer_id,
    question_id,
    cast(JSON_VALUE(owner, '$.user_id') as int64) as question_owner_user_id,
    is_accepted,
    body as answer_body,
    cast(creation_date as DATETIME) as answer_created_date,
    cast(last_edit_date AS DATETIME) as answer_last_edit_date,
    score answer_score,
    snapshot_date


  from source

)

select * from transformed