{{ config(materialized='table') }}

-- Get the latest timestamp for customerID
WITH LatestTimestamp AS (
  SELECT
    customer_id,
    MAX(timestamp) AS LatestTimeStamp
  FROM
    {{ source('web_tracking', 'pageviews') }} -- source table in dbt
  WHERE
    customer_id IS NOT NULL
  GROUP BY
    customer_id
),
-- Use the latest visitor ID for the same customer 
LatestVisitorID AS (
  SELECT
    LT.customer_id,
    PV.visitor_id,
    PV.timestamp
  FROM
    {{ source('web_tracking', 'pageviews') }} AS PV
  INNER JOIN
    LatestTimestamp AS LT
    ON PV.customer_id = LT.customer_id
    AND PV.timestamp = LT.LatestTimeStamp
)

SELECT
  PV.id AS PageViewsID,
  LV.visitor_id AS VisitorID,
  PV.device_type AS DeviceType,
  PV.timestamp AS PageViewTimeStamp,
  PV.page AS PageName,
  PV.customer_id AS CustomerID
FROM
  {{ source('web_tracking', 'pageviews') }} AS PV
LEFT JOIN
  LatestVisitorID AS LV
  ON PV.customer_id = LV.customer_id
ORDER BY
  PV.customer_id
