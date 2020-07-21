

select
    O_ORDERDATE
    ,O_TOTALPRICE
    ,sum(O_TOTALPRICE)   over (partition by O_ORDERDATE order by O_ORDERDATE rows between unbounded preceding and current row) as cumulative_sales
from 
    "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS"
group by
    O_ORDERDATE
    ,O_TOTALPRICE