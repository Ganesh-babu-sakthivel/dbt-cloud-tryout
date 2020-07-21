
{{ 
    config(
        materialized    =   'incremental'
        , unique_key    =   "T_TIME_SK"
    )
}}



select 
    *
    from 
        "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."TIME_DIM"
    where 
        to_time(concat(T_HOUR::varchar , ':' , T_MINUTE , ':', T_SECOND) ) <= current_time


-- macro to check incremental logic

{% if is_incremental() %}
    and (to_time(concat(T_HOUR::varchar , ':' , T_MINUTE , ':', T_SECOND) )) > ( select max(to_time(concat(T_HOUR::varchar , ':' , T_MINUTE , ':', T_SECOND) ))  from {{ this }} )
{% endif %}