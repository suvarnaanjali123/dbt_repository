{{ config(materialized='incremental',unique_key='DORN_ID') }}
with example_2 as
    (select distinct SUNRISE_SUNSET,_MODIFIED,CIVIL_TWILIGHT, NAUTICAL_TWILIGHT, ASTRONOMICAL_TWILIGHT from {{source('DEVELOPER_DB','US_ACCIDENT_DATA_RAW_STAGE')}}
),
 ACCIDENT_DORN as(
        select  concat('D-', cast(seq_drn.nextval as varchar)) as DORN_ID,
        SUNRISE_SUNSET, CIVIL_TWILIGHT, NAUTICAL_TWILIGHT, ASTRONOMICAL_TWILIGHT , _MODIFIED as LOAD_TIME from example_2 order by DORN_ID
     )

select DORN_ID,SUNRISE_SUNSET, CIVIL_TWILIGHT, NAUTICAL_TWILIGHT, ASTRONOMICAL_TWILIGHT, LOAD_TIME from  ACCIDENT_DORN