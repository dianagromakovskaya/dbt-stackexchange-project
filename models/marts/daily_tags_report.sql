WITH daily_questions_stats AS (
    SELECT
      question_id,
      snapshot_date AS report_date,
      fs.question_view_count AS total_views,
      fs.question_score AS total_votes,
      fs.question_view_count - COALESCE(
        LAG(fs.question_view_count) OVER (PARTITION BY question_id ORDER BY snapshot_date),
        0
      ) AS question_views,
      fs.question_score - COALESCE(
        LAG(fs.question_score) OVER (PARTITION BY question_id ORDER BY snapshot_date),
        0
      ) AS question_votes
    FROM {{ ref('fct_questions_stats') }} fs
  ),
  question_to_tag AS (
    SELECT
      question_id,
      question_created_date,
      tag
    FROM {{ ref('dim_questions') }},
    unnest(question_tags_array) tag
  )
SELECT
    dqs.report_date,
    qtt.tag,
    COUNT(DISTINCT qtt.question_id) total_questions,
    SUM(dqs.total_views) total_views,
    SUM(dqs.total_votes) total_votes,
    SUM(dqs.question_views) question_views,
    SUM(dqs.question_votes) question_votes
FROM daily_questions_stats dqs
LEFT JOIN question_to_tag qtt
ON dqs.question_id = qtt.question_id
GROUP BY 1, 2

