use airline_delay;
-- ------------------------------------------- Data Cleaning

-- Delete rows with essential NULLs
DELETE from airline_delay where carrier is null or airport is null or arr_cancelled is null  or arr_delay is null;

-- Replace NULL arrival delays with 0 for valid flights
update airline_delay set arr_delay = 0 where arr_delay is null and arr_cancelled = 0  and arr_diverted = 0 ; 

-- Trim whitespace from carrier names
update airline_delay set carrier_name = TRIM(carrier_name);


