with api as (
    select
        question_id,
        question_score,
        question_view_count,
        snapshot_date,
        question_site
    from {{ ref('stg_questions_base') }}
),
dump as (
    select
        question_id,
        question_score,
        question_view_count,
        snapshot_date,
        question_site
    from {{ ref('stg_dump_questions_metrics') }} 
)
select
    question_id,
    question_score,
    question_view_count,
    snapshot_date,
    question_site
from api
union all
select
    question_id,
    question_score,
    question_view_count,
    snapshot_date,
    question_site
from dump