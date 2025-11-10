select
    post_id answer_id,
    post_answer_question_id answer_question_id,
    post_score answer_score,
    snapshot_date,
    post_site answer_site
from {{ ref('stg_posts_history_base') }}
where post_type = 'Answer'