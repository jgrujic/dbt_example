with muni_vacc_with_dates as (
select *,
      LAST_DAY(TO_DATE(CONCAT('20', substring(year_week, 1, 2) ), 'YYYY'), week) AS last_day_of_first_week,
      DATEADD( week, substring(year_week, 4, 2) - 1 , last_day_of_first_week ) AS last_day_of_the_week
from {{ source('covid', 'vacc_muni_cum') }}
),
province_added as(
select *, cases.province as province_name
from muni_vacc_with_dates as vacc
left join {{ source('covid','cases_muni_cum')}} as cases
on cases.nis5 = vacc.nis5
),
vaccination as (
select province_name, sum(cumul) as fully_vaccinated, '{{ var("date") }}' by_date, last_day_of_the_week
from province_added
where (dose='B' or dose='C')
group by province_name, last_day_of_the_week
having last_day_of_the_week >= by_date and last_day_of_the_week < dateadd(week, 1, by_date)
)
select * from vaccination

