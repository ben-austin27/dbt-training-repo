{{ config(
    materialized='table'
) }}

SELECT VendorID
      ,RatecodeID
      ,DATE(lpep_pickup_datetime) as trip_date
      ,SUM(trip_distance) as trip_distance
      ,SUM(fare_amount) as fare_amount
FROM {{ref('fact_all_taxi_stg')}}
GROUP BY 1,2,3