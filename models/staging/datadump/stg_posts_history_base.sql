with u as (
  {{ dbt_utils.union_relations(
      relations=[
        source('ai','posts_history'),
        source('datascience','posts_history'),
        source('genai','posts_history')
      ],
      source_column_name=none
  ) }}
),

transformed as (

  select 

    id as post_id,
     {{ get_post_type_description('post_type_id') }} post_type,
    accepted_answer_id post_accepted_answer_id,
    owner_user_id as post_owner_user_id,
    parent_id post_answer_question_id,
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
    site as post_site


  from u

)

select * from transformed