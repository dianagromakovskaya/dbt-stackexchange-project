select 
    post_id as answer_id,
    post_answer_question_id as answer_question_id,
    post_owner_user_id as answer_owner_user_id,
    post_body as answer_body,
    post_created_date as answer_created_date,
    post_last_edit_date as answer_last_edit_date,
    snapshot_date,
    post_site as answer_site
from {{ ref('stg_posts_history_base') }}
where post_type = 'Answer'