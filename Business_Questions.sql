use airline_delay;
----------------------------------------- Business Questions 
-- Overall Delay Causes (Summed in Minutes)
select 
sum(carrier_delay)  as total_carrier_delay,
sum(weather_delay) as total_weather_delay ,
sum(nas_delay) as total_nas_delay,
sum(security_delay) as total_security_delay,
sum(late_aircraft_delay) as total_late_aircraft_delay
from airline_delay where arr_cancelled = 0 and arr_diverted =0;

-- Delay Causes Per Airline
Select 
carrier , 
carrier_name ,
sum(carrier_delay)  as total_carrier_delay,
sum(weather_delay) as total_weather_delay ,
sum(nas_delay) as total_nas_delay,
sum(security_delay) as total_security_delay,
sum(late_aircraft_delay) as total_late_aircraft_delay
from airline_delay where arr_cancelled = 0 and arr_diverted = 0 
Group by carrier , carrier_name order by total_carrier_delay Desc;

-- How do monthly and seasonal trends affect delay rates?

select year , month   , 
  round(avg( arr_delay) , 2) as avg_Arr_delay , 
  sum( Case when arr_delay >=15 then 1 else 0 end)  as delay_15_min_count ,
  count(*) as total_flights,
  round(sum(case when  arr_delay >= 15 then 1 else 0 end ) * 100.0 / count(*)) as pct_delayed_15_min 
from airline_delay 
  where arr_delay = 0 and arr_diverted = 0 
  group by year , month 
  order by year , month ;
  
-- What percentage of flights are delayed 15+ minutes, canceled, or diverted by carrier and airport?

select airport , carrier , count(*) as total_flights , sum( case when arr_delay >= 15 then 1 else 0 end ) as delayed_15 ,
sum(arr_cancelled) as cancelled , 
sum(arr_diverted) as diverted ,
round(sum( case when arr_delay >= 15 then 1  else 0 end ) *100.0/count(*) , 2) as pct_delayed_15,
round(sum(arr_cancelled) * 100.0  / count(*) , 2) as pct_cancelled ,
round(sum(arr_diverted) * 100.0 / count(*) , 2) as pct_diverted 
from airline_delay 
group by carrier , airport 
order by pct_delayed_15 desc ;

-- Top Performing Airlines (On-Time %)
Select
  carrier, carrier_name ,
  COUNT(*) AS total,
  SUM(CASE WHEN arr_delay < 15 THEN 1 ELSE 0 END) AS on_time,
  ROUND(SUM(CASE WHEN arr_delay < 15 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS on_time_pct
from airline_delay
group by carrier , carrier_name
order by  on_time_pct DESC;






