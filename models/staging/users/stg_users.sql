with ranked as (
    select
        user_account_id,
        user_id,
        user_last_access_date,
        user_reputation,
        user_created_date,
        user_type,
        user_website_url,
        user_link,
        user_display_name,
        user_location,
        snapshot_date,
        user_site,
        row_number() over (partition by user_id, user_site order by snapshot_date desc) rn
    from {{ ref('stg_users_base') }}
)
select 
        user_account_id,
        user_id,
        user_last_access_date,
        user_reputation,
        user_created_date,
        user_type,
        user_website_url,
        user_link,
        user_display_name,
        user_location,
        snapshot_date,
        user_site
from ranked
where rn = 1