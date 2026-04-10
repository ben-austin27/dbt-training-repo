{{ config(
    materialized='incremental',
    incremental_strategy='merge'
) }}

select VendorID
      ,RatecodeID
      ,lpep_pickup_datetime
      ,lpep_dropoff_datetime
      ,trip_distance
      ,fare_amount
      ,_FILE_NAME  as source_file
      ,load_ts as current_timestamp()
from {{source('zoomcamp', 'all_taxi_ext')}}

{% if is_incremental() %}
    where _FILE_NAME not in (
        select distinct source_file from {{ this }}
    )
{% endif %}