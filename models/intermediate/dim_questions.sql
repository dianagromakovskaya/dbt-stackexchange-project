select
    {{ dbt_utils.generate_surrogate_key(['question_id', 'dbt_valid_from']) }} 
        as dim_question_sk,
    question_id,
    question_owner_user_id,
    question_tags_array,
    question_link,
    question_title,
    question_body,
    question_created_date,
    question_last_edit_date,
    question_closed_date,
    question_closed_reason,
    question_accepted_answer_id,
    snapshot_date,
    question_site,
    question_updated_at
from {{ ref('questions_snapshot') }}
where dbt_valid_to is null