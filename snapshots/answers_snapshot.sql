{% snapshot answers_snapshot %}
    {{
    config(
        target_schema='snapshots',
        unique_key="concat(answer_site, ':', cast(answer_id as string))",
        strategy='timestamp',
        updated_at='answer_updated_at'
    )
    }}

    select * from {{ ref('stg_answers') }}
{% endsnapshot %}