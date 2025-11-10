with u as (
  {{ dbt_utils.union_relations(
      relations=[
        source('ai','users'),
        source('datascience','users'),
        source('genai','users')
      ],
      source_column_name=none
  ) }}
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
    snapshot_date,
    site as user_site

  from u

)

select * from transformed