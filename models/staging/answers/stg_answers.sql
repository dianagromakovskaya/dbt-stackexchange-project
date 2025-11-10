with ranked as (
    select 
    answer_id,
    answer_question_id,
    answer_owner_user_id,
    is_accepted,
    answer_body,
    answer_created_date,
    answer_last_edit_date,
    snapshot_date,
    answer_site,
    row_number() over (partition by answer_id, answer_site order by snapshot_date desc) rn
from {{ ref('stg_answers_base') }}
)
select 
    answer_id,
    answer_question_id,
    answer_owner_user_id,
    is_accepted,
    answer_body,
    answer_created_date,
    answer_last_edit_date,
    snapshot_date,
    answer_site
from ranked
where rn = 1