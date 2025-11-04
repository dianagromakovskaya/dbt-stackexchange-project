with 

source as (

  select * from {{ source('ai', 'questions') }}

),

transformed as (

  select 

    question_id,
    cast(JSON_VALUE(owner, '$.user_id') as int64) as question_owner_user_id,
    (
        select array_agg(tag)
        from unnest(
        JSON_EXTRACT_ARRAY(replace(tags, "'", '"'))
        ) as tag
    ) as question_tags_array,
    link as question_link,
    title as question_title,
    body as question_body,
    cast(creation_date as DATETIME) as question_created_date,
    cast(last_edit_date AS DATETIME) as question_last_edit_date,
    view_count question_view_count,
    score question_score,
    snapshot_date


  from source

)

select * from transformed