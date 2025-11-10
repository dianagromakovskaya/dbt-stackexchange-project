{% snapshot users_snapshot %}
    {{
    config(
        target_schema='snapshots',
        unique_key="concat(user_site, ':', cast(user_id as string))",
        strategy='check',
        check_cols=[
            'user_type',
            'user_website_url',
            'user_link',
            'user_display_name',
            'user_location'
        ]
    )
    }}

    select * from {{ ref('stg_users') }}
{% endsnapshot %}