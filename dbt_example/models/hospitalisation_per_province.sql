
with hospitalisation as (
select
    PROVINCE,
    REGION,
    sum(total_in),
    sum(total_in_icu),
    sum(total_in_resp),
    sum(total_in_ecmo),
    dateadd(week, 2, '{{ var("date") }}') as from_date,
    dateadd(week, 10, '{{ var("date") }}') as to_date
from {{ source('covid','hospitalisation') }}
where date_host > from_date and date_host < to_date
group by PROVINCE, REGION
)

select * from hospitalisation