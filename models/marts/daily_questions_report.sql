WITH daily_questions_stats AS (
    SELECT
        question_id,
        snapshot_date AS report_date,
        fs.question_view_count AS total_views,
        fs.question_score AS total_votes,
        fs.question_view_count - COALESCE(
        LAG(fs.question_view_count) OVER (PARTITION BY question_id ORDER BY snapshot_date),
        0
        ) AS views,
        fs.question_score - COALESCE(
        LAG(fs.question_score) OVER (PARTITION BY question_id ORDER BY snapshot_date),
        0
        ) AS votes
    FROM {{ ref('fct_questions_stats') }} fs
)

SELECT
    dqs.report_date,
    dq.question_id,
    dq.question_created_date,
    dq.question_link,
    dq.question_title,
    dq.question_body,
    dq.question_tags_array,
    dqs.total_views,
    dqs.total_votes,
    dqs.views,
    dqs.votes
FROM {{ ref('dim_questions') }} dq
LEFT JOIN daily_questions_stats dqs
ON dq.question_id = dqs.question_id
