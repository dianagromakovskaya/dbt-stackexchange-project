with api as (
    select
        answer_id,
        answer_question_id,
        answer_score,
        snapshot_date,
        answer_site
    from {{ ref('stg_answers_base') }}
),
dump as (
    select
        answer_id,
        answer_question_id,
        answer_score,
        snapshot_date,
        answer_site
    from {{ ref('stg_dump_answers_metrics') }}    
)
select
    answer_id,
    answer_question_id,
    answer_score,
    snapshot_date,
    answer_site
from api
union all
select
    answer_id,
    answer_question_id,
    answer_score,
    snapshot_date,
    answer_site
from dump