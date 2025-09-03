
-- Create and use the database
create database airline;
use airline;

-- Preview and basic info
select * from airline_delay;
select  COUNT(*) from airline_delay;
desc airline_delay;
select distinct carrier_name from airline_delay;
--------------------------------------------- Data Description
-- Minimum arrival delay
select min(arr_delay)  as min_delay from airline_delay;


-- Rows with NULLs in critical columns
select * from airline_delay where  arr_delay IS NULL OR
    carrier IS NULL OR
    airport IS NULL OR
    arr_cancelled IS NULL;
    
-- Top 10 most delayed flights
SELECT * from airline_delay where arr_delay is not null  order by arr_delay  desc limit 10;

-- Flights delayed due to weather
SELECT * from airline_delay where weather_delay is not null AND  weather_delay > 0;

-- Summary: total, cancelled, and diverted flights
SELECT count(*) as total_Flights , sum(arr_cancelled ) as total_cancelled , sum(arr_diverted) as total_diverted from airline_delay;

-- Flights over time
select year , month , count(*) as flight_count from airline_delay Group by year , month  Order by year , month ;


-- Flights per carrier
select carrier , carrier_name  , count(*)  as total_flights  from airline_delay  group by carrier_name , carrier order by total_flights;


-- Flights per airport
select airport , airport_name  , Count(*) as total_flights from airline_delay  group by airport , airport_name order by total_flights ;


-- Airports with highest average delays
select airport , airport_name  , round(avg(arr_delay),2) as avg_arrival_delay  from airline_delay  where  arr_cancelled = 0  and arr_delay is not null 
group by airport , airport_name  order by avg_arrival_delay  desc limit 10;



