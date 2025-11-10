select 
    post_id as question_id,
    post_owner_user_id as question_owner_user_id,
    post_question_link as question_link,
    post_title as question_title,
    post_body as question_body,
    post_created_date as question_created_date,
    post_last_edit_date as question_last_edit_date,
    post_closed_date as question_closed_date,
    post_accepted_answer_id as question_accepted_answer_id,
    snapshot_date,
    post_site as question_site,
    coalesce(post_last_edit_date, post_created_date) as question_updated_at 
from {{ ref('stg_posts_history_base') }}
where post_type = 'Question'