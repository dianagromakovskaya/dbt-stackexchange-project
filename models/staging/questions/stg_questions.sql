with ranked as (
    select
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
        row_number() over (partition by question_id, question_site order by snapshot_date desc) rn
    from {{ ref('stg_questions_base') }}
)
select 
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
        question_site
from ranked
where rn = 1