with 

source as (

  select * from {{ source('datascience', 'posts_history') }}

),

transformed as (

  select 

    id as post_id,
     {{ get_post_type_description('post_type_id') }} post_type,
    accepted_answer_id post_accepted_answer_id,
    owner_user_id as post_owner_user_id,
    SPLIT(
        REGEXP_REPLACE(tags, r'^\||\|$', ''),
        '|'
    ) AS post_tags_array,
    {{ html_unescape('title') }} as post_title,
    {{ strip_html('body') }} as post_body,
    DATETIME(creation_date) as post_created_date,
    DATETIME(last_edit_date) as post_last_edit_date,
    DATETIME(closed_date) as post_closed_date,
    view_count post_view_count,
    score post_score,
    cast('2024-04-01' as date) as snapshot_date,
    'datascience' as post_site

  from source

)

select * from transformed