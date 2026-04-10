{{ config(
    materialized='incremental',
    incremental_strategy='merge'
) }}

select *
      ,_FILE_NAME  as source_file,
from {{source('zoomcamp', 'all_taxi_ext')}}

{% if is_incremental() %}
    where _FILE_NAME not in (
        select distinct source_file from {{ this }}
    )
{% endif %}