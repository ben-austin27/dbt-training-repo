{{config(materialized='view', location='europe-west2')}}

with stage_data as (
    SELECT VendorID
          ,trip_distance
    FROM {{source('zoomcamp', 'green_tripdata_2019_01_ext')}}
)

SELECT VendorID, SUM(trip_distance) as total_trip_distance
from stage_data
group by VendorID