select
    post_id as question_id,
    post_score as question_score,
    snapshot_date,
    post_site as question_site
from {{ ref('stg_posts_history_base') }}
where post_type = 'Question'