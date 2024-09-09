
with source as (

    select * from {{ source('web_tracking', 'pageviews') }}

),

renamed as (

    select
        id as PageViewsID,   
          visitor_id as VisitorID,
        device_type as DeviceType,
        timestamp as PageViewTimeStamp,
        page As PageName,
        customer_id as CustomerID
  --Removed Columns      

    from source

)

select * from renameddbt
