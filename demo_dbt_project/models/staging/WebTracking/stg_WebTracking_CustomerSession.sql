{{ config(materialized='table') }}


WITH RankedPageView AS (
  SELECT  
    CustomerID,
    PageName,
    PageViewTimeStamp,
    DeviceType, 
    VisitorID,
    LAG(PageViewTimeStamp) OVER (PARTITION BY CustomerID ORDER BY PageViewTimeStamp) AS PreviousTimeStamp
  FROM
    `aec-students.dbt_leosakay.stg_WebTracking_PageViews` AS pv
  WHERE
    pv.CustomerID IS NOT NULL
),
PreviousTimestamp AS (
  SELECT 
    pv.*, 
    CASE 
      WHEN (TIMESTAMP_DIFF(PageViewTimeStamp, PreviousTimeStamp, MINUTE) > 30) 
           OR PreviousTimeStamp IS NULL 
      THEN 1 
      ELSE 0 
    END AS IsNewSessionFlag,
    TIMESTAMP_DIFF(PageViewTimeStamp, PreviousTimeStamp, MINUTE) AS DiffInMin
  FROM 
    RankedPageView pv
),
SessionAssignment AS (
  SELECT 
    *,
    SUM(IsNewSessionFlag) OVER (PARTITION BY CustomerID ORDER BY PageViewTimeStamp) AS session_number
  FROM 
    PreviousTimestamp
),
SessionizedPageViews AS (
  SELECT
    CustomerID,
    PageName,
    PageViewTimeStamp,
    PreviousTimeStamp,
    IsNewSessionFlag,
    DeviceType, 
    VisitorID,
    session_number,
    CONCAT(CustomerID, '-', CAST(session_number AS STRING)) AS session_id,
    MIN(PageViewTimeStamp) OVER (PARTITION BY CustomerID, session_number) AS session_start_time,
    MAX(PageViewTimeStamp) OVER (PARTITION BY CustomerID, session_number) AS session_end_time
  FROM
    SessionAssignment
)

SELECT 
  CustomerID,
  PageName,
  PageViewTimeStamp,
  PreviousTimeStamp,
  IsNewSessionFlag,
  session_id as SessionID,
  session_start_time as SessionStartTime,
  session_end_time as SessionEndTime
FROM 
  SessionizedPageViews
ORDER BY 
  CustomerID, PageViewTimeStamp
