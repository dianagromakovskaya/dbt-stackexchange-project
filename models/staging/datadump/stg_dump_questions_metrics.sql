select
    post_id as question_id,
    post_score as question_score,
    post_view_count as question_view_count,
    snapshot_date,
    post_site as question_site
from {{ ref('stg_posts_history_base') }}
where post_type = 'Question'