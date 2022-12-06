{{ config(materialized='incremental',unique_key='RES_ID') }}
 with example_2 as
    (select distinct AMENITY,_MODIFIED, BUMP,CROSSING,GIVE_WAY,JUNCTION,NO_EXIT,RAILWAY,ROUNDABOUT,STATION,
    STOP,TRAFFIC_CALMING,TRAFFIC_SIGNAL,TURNING_LOOP from {{source('DEVELOPER_DB','US_ACCIDENT_DATA_RAW_STAGE')}}
),
 ACCIDENT_RES as(
        select  concat('R-', cast(seq_reason.nextval as varchar)) as RES_ID,
        AMENITY, BUMP,CROSSING,GIVE_WAY,JUNCTION,NO_EXIT,RAILWAY,ROUNDABOUT,STATION,
        STOP,TRAFFIC_CALMING,TRAFFIC_SIGNAL,TURNING_LOOP ,_MODIFIED as LOAD_TIME from example_2
     )

select RES_ID,AMENITY,BUMP,CROSSING,GIVE_WAY,JUNCTION,NO_EXIT,RAILWAY,ROUNDABOUT,STATION,
STOP,TRAFFIC_CALMING,TRAFFIC_SIGNAL,TURNING_LOOP,LOAD_TIME from  ACCIDENT_RES