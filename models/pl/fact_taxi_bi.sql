{{ config(
    materialized='view'
) }}

SELECT *
FROM {{ref('fact_taxi_day')}}