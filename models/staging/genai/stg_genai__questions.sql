with 

source as (

  select * from {{ source('genai', 'questions') }}

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
    {{ html_unescape('title') }} as question_title,
    {{ strip_html('body') }} as question_body,
    DATETIME(TIMESTAMP_SECONDS(creation_date)) as question_created_date,
    DATETIME(TIMESTAMP_SECONDS(CAST(last_edit_date AS INT64))) as question_last_edit_date,
    DATETIME(TIMESTAMP_SECONDS(CAST(closed_date AS INT64))) as question_closed_date,
    closed_reason as question_closed_reason,
    view_count question_view_count,
    score question_score,
    accepted_answer_id as question_accepted_answer_id,
    snapshot_date,
    'genai' as question_site


  from source

)

select * from transformed