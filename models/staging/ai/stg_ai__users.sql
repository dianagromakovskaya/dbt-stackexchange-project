with 

source as (

  select * from {{ source('ai', 'users') }}

),

transformed as (

  select 

    account_id as user_account_id,
    user_id,
    DATETIME(TIMESTAMP_SECONDS(last_access_date)) as user_last_access_date,
    reputation as user_reputation,
    DATETIME(TIMESTAMP_SECONDS(creation_date)) as user_created_date,
    user_type,
    website_url as user_website_url,
    link as user_link,
    display_name as user_display_name,
    location as user_location,
    snapshot_date


  from source

)

select * from transformed