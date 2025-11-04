sources:
  - name: ai
    database: dbt-stackexchange-project
    schema: raw_data 
    tables:
      - name: ai_answers
      - name: ai_questions
      - name: ai_users
      - name: ai_posts_history
      - name: ai_users_history