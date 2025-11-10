{% snapshot questions_snapshot %}
    {{
    config(
        target_schema='snapshots',
        unique_key="concat(question_site, ':', cast(question_id as string))",
        strategy='timestamp',
        updated_at='question_updated_at'
    )
    }}

    select * from {{ ref('stg_questions') }}
{% endsnapshot %}