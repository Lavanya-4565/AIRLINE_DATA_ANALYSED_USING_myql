-- display all records from dataset 
SELECT * FROM airline_schema.airline_passenger_satisfaction;
use airline_schema;

-- all unique passenger classes 
SELECT DISTINCT customer_class
FROM airline_passenger_satisfaction;

-- show only gender column
 SELECT gender FROM airline_passenger_satisfaction;
 
 -- showing gender age and class column
 SELECT gender,age,customer_class From airline_passenger_satisfaction;
 
-- no.of columns 
 SELECT COUNT(*) AS column_count
FROM information_schema.columns
WHERE table_schema = 'airline_schema'  -- Replace with your DB name
  AND table_name = 'airline_passenger_satisfaction';      -- Replace with your table name
  
 -- total no. of passengers
 SELECT COUNT(*) AS Total_Passengers
FROM airline_passenger_satisfaction;
 
-- first 20 rows
SELECT * FROM airline_passenger_satisfaction LIMIT 20; 
-- unique type of travel  
SELECT DISTINCT type_of_travel FROM airline_passenger_satisfaction;

-- Display passengers aged above 50
SELECT * FROM airline_passenger_satisfaction WHERE age>50;
SELECT count(*) FROM airline_passenger_satisfaction WHERE age>50;

-- passengers whose flight distance is greater than 1000.
SELECT * FROM airline_passenger_satisfaction WHERE flight_distance > 1000;
SELECT count(*) FROM airline_passenger_satisfaction WHERE flight_distance > 1000;

-- Display passengers who are dissatisfied. 
SELECT DISTINCT satisfaction FROM airline_passenger_satisfaction;
SELECT * FROM airline_passenger_satisfaction WHERE satisfaction != "satisfied";

-- Find all female passengers.
SELECT * FROM airline_passenger_satisfaction WHERE gender = "female";
SELECT count(*) FROM airline_passenger_satisfaction WHERE gender = "female";

-- Find all male passengers.
SELECT * FROM airline_passenger_satisfaction WHERE gender = "male";
SELECT count(*) FROM airline_passenger_satisfaction WHERE gender = "male";

-- Show passengers traveling in Business class.
SELECT * FROM airline_passenger_satisfaction WHERE customer_class = "business";

-- Find passengers traveling for Business Travel
SELECT * FROM airline_passenger_satisfaction WHERE type_of_travel = "business travel";

-- Find passengers aged between 20 and 40.
SELECT * FROM airline_passenger_satisfaction WHERE 20<age && age<40;

-- Show passengers whose departure delay exceeds 60 minutes.
SELECT * FROM airline_passenger_satisfaction WHERE departure_delay_in_minutes >60 ;

-- Find passengers whose arrival delay exceeds 30 minutes.
SELECT * FROM airline_passenger_satisfaction WHERE departure_arrival_time_convenient>30 ;

-- Display satisfied passengers in Business class.
SELECT * FROM airline_passenger_satisfaction WHERE customer_class = "business" && satisfaction = "satisfied";

-- Find dissatisfied customers in Economy class.
SELECT * FROM airline_passenger_satisfaction WHERE customer_class = "Eco" AND satisfaction != "satisfied";

SELECT customer_class, COUNT(*) AS Total
FROM airline_passenger_satisfaction
WHERE satisfaction = 'neutral or dissatisfied'
GROUP BY customer_class;

-- Show passengers whose flight distance is between 500 and 2000 km
SELECT * FROM airline_passenger_satisfaction WHERE flight_distance BETWEEN 500 AND 2000;










-- Level 3: Sorting and Limiting (21-25)
-- Sort passengers by age in ascending order.
SELECT * FROM airline_passenger_satisfaction ORDER BY age ASC;
SELECT COUNT(*) FROM airline_passenger_satisfaction;

-- Sort passengers by flight distance in descending order.
SELECT * FROM airline_passenger_satisfaction ORDER BY flight_distance DESC;

-- Find the top 10 passengers with the highest arrival delay.
SELECT * FROM airline_passenger_satisfaction ORDER BY departure_arrival_time_convenient DESC LIMIT 10;

-- Display the youngest 5 passengers.
SELECT * FROM airline_passenger_satisfaction ORDER BY age ASC LIMIT 5;

-- Show passengers sorted by satisfaction status and age. 
SELECT * FROM airline_passenger_satisfaction ORDER BY satisfaction ASC, age ASC;









-- Level 4: Aggregate Functions (26-35)
-- Find the average age of passengers.
SELECT AVG(age)
FROM airline_passenger_satisfaction;

-- Find the maximum flight distance.
SELECT MAX(flight_distance)
from airline_passenger_satisfaction;

-- Find the minimum flight distance.
SELECT MIN(flight_distance)
from airline_passenger_satisfaction;

-- Calculate total departure delay.
SELECT SUM(departure_delay_in_minutes)
FROM airline_passenger_satisfaction;

-- Calculate average arrival delay.
SELECT AVG(arrival_delay_in_minutes)
FROM airline_passenger_satisfaction;

-- Find the total number of satisfied passengers.
SELECT 
SUM(CASE 
        WHEN satisfaction ="satisfied" THEN 1
	    ELSE 0
    END) as SATISFIED
FROM airline_passenger_satisfaction;

-- Find the total number of dissatisfied passengers.
SELECT 
SUM(CASE 
        WHEN satisfaction ="neutral or dissatisfied" THEN 1
	    ELSE 0
    END) as SATISFIED
FROM airline_passenger_satisfaction;

-- Find average flight distance.
SELECT AVG(flight_distance)
from airline_passenger_satisfaction;

-- Find average departure delay for all passengers.
SELECT AVG(departure_delay_in_minutes)
FROM airline_passenger_satisfaction;

-- Find the highest arrival delay recorded
SELECT MAX(arrival_delay_in_minutes)
FROM airline_passenger_satisfaction;








-- Level 5: GROUP BY Analysis (36-45)

-- Count passengers in each class.
SELECT customer_class, COUNT(*) as passenger 
FROM airline_passenger_satisfaction
GROUP BY customer_class;

-- Count passengers by gender.
SELECT gender, COUNT(*) as passenger 
FROM airline_passenger_satisfaction
GROUP BY gender;

-- Find average age for each class.
SELECT customer_class, AVG(age) as AVG_AGE 
FROM airline_passenger_satisfaction
GROUP BY customer_class;

-- Find average flight distance for each class.
SELECT customer_class, AVG(flight_distance) as AVG_DISTANCE
FROM airline_passenger_satisfaction
GROUP BY customer_class;

-- Find average departure delay by travel type.
SELECT type_of_travel, AVG(departure_delay_in_minutes) as delay 
FROM airline_passenger_satisfaction
GROUP BY type_of_travel;

-- Count satisfied passengers in each class.
SELECT customer_class, SUM(CASE 
        WHEN satisfaction ="satisfied" THEN 1
	    ELSE 0
    END) as SATISFIED
FROM airline_passenger_satisfaction
GROUP BY customer_class;

-- Count dissatisfied passengers in each class.
SELECT customer_class, SUM(CASE 
        WHEN satisfaction ="neutral or dissatisfied" THEN 1
	    ELSE 0
    END) as disSATISFIED
FROM airline_passenger_satisfaction
GROUP BY customer_class;

-- Find average arrival delay by gender.
SELECT gender, AVG(arrival_delay_in_minutes) as avg_arrival_delay
FROM airline_passenger_satisfaction
GROUP BY gender;

-- Find the maximum flight distance in each class.
SELECT customer_class, MAX(flight_distance) as MAX_DISTANCE
FROM airline_passenger_satisfaction
GROUP BY customer_class;

-- Find average satisfaction rating for each class (if satisfaction is encoded numerically).
SELECT customer_class, ROUND(AVG(CASE 
        WHEN satisfaction ="satisfied" THEN 1
	    ELSE 0
    END)*100,2) as AVG_SATISFIED
FROM airline_passenger_satisfaction
GROUP BY customer_class;










-- Level 6: Business Insights (46-50)
-- Which class has the highest satisfaction rate?
SELECT customer_class, ROUND(AVG(CASE 
        WHEN satisfaction ="satisfied" THEN 1
	    ELSE 0
    END)*100,2) as satisfaction_rate
FROM airline_passenger_satisfaction
GROUP BY customer_class
ORDER BY satisfaction_rate DESC
LIMIT 1;

-- Does longer flight distance lead to higher satisfaction?
SELECT
CASE
    WHEN flight_distance < 1000 THEN 'Short Distance'
    WHEN flight_distance < 3000 THEN 'Medium Distance'
    ELSE 'Long Distance'
END AS distance_category,

ROUND(
AVG(
CASE
    WHEN satisfaction = 'satisfied' THEN 1
    ELSE 0
END
) * 100,2) AS satisfaction_rate

FROM airline_passenger_satisfaction
GROUP BY distance_category;

-- Compare average delays between satisfied and dissatisfied passengers
SELECT satisfaction,
       ROUND(AVG(departure_delay_in_minutes),2) AS avg_departure_delay,
       ROUND(AVG(arrival_delay_in_minutes),2) AS avg_arrival_delay
FROM airline_passenger_satisfaction
GROUP BY satisfaction;

-- Which travel type (Business Travel or Personal Travel) has higher satisfaction?
SELECT type_of_travel, ROUND(AVG(CASE 
        WHEN satisfaction ="satisfied" THEN 1
	    ELSE 0
    END)*100,2) as satisfaction_rate
FROM airline_passenger_satisfaction
GROUP BY type_of_travel
ORDER BY satisfaction_rate DESC
LIMIT 1;

-- Identify the top 5 factors most associated with passenger satisfaction by comparing average ratings of services such as:
-- Inflight wifi service
-- Food and drink
-- Seat comfort
-- Online boarding
-- Inflight entertainment
SELECT AVG(inflight_wifi_service),
       AVG(food_and_drink),
       AVG(seat_comfort),
       AVG(online_boarding),
       AVG(inflight_service),
       satisfaction
FROM airline_passenger_satisfaction
GROUP BY satisfaction;








-- Bonus Advanced Questions
-- Find the correlation between delays and satisfaction.
SELECT
CASE
    WHEN departure_delay_in_minutes = 0 THEN 'On Time'
    WHEN departure_delay_in_minutes <= 30 THEN 'Minor Delay'
    ELSE 'Major Delay'
END AS delay_category,

ROUND(
AVG(
CASE
    WHEN satisfaction = 'satisfied' THEN 1
    ELSE 0
END
) * 100,2) AS satisfaction_rate

FROM airline_passenger_satisfaction
GROUP BY delay_category;


-- Find passengers whose departure delay is above the average delay.
SELECT *
FROM airline_passenger_satisfaction
WHERE departure_delay_in_minutes >
(
    SELECT AVG(departure_delay_in_minutes)
    FROM airline_passenger_satisfaction
);

-- Find classes whose average satisfaction exceeds the overall average.
SELECT customer_class,
       ROUND(
           AVG(CASE
                   WHEN satisfaction='satisfied' THEN 1
                   ELSE 0
               END)*100,2
       ) AS satisfaction_rate
FROM airline_passenger_satisfaction
GROUP BY customer_class
HAVING AVG(CASE
               WHEN satisfaction='satisfied' THEN 1
               ELSE 0
           END)
       >
       (
           SELECT AVG(CASE
                          WHEN satisfaction='satisfied' THEN 1
                          ELSE 0
                      END)
           FROM airline_passenger_satisfaction
       );
       
       
-- Rank classes based on average satisfaction.
SELECT customer_class,
       satisfaction_rate,
       RANK() OVER (ORDER BY satisfaction_rate DESC) AS class_rank
FROM
(
    SELECT customer_class,
           ROUND(
               AVG(
                   CASE
                       WHEN satisfaction='satisfied' THEN 1
                       ELSE 0
                   END
               )*100,2
           ) AS satisfaction_rate
    FROM airline_passenger_satisfaction
    GROUP BY customer_class
) t ; -- every derived table must has its own alias   

-- Find the percentage of satisfied passengers in each class.
SELECT customer_class, ROUND(AVG(CASE 
        WHEN satisfaction ="satisfied" THEN 1
	    ELSE 0
    END)*100,2) as satisfaction_rate
FROM airline_passenger_satisfaction
GROUP BY customer_class;

-- Determine which service rating has the strongest impact on satisfaction.
-- "Online Boarding and Inflight Entertainment show the largest rating differences between satisfied and dissatisfied passengers, indicating they are the strongest drivers of satisfaction."

-- Identify passengers experiencing both departure and arrival delays.
SELECT satisfaction,
       COUNT(*) AS total_passengers
FROM airline_passenger_satisfaction
WHERE departure_delay_in_minutes > 0
  AND arrival_delay_in_minutes > 0
GROUP BY satisfaction;

-- Calculate satisfaction rate by age group.
SELECT CASE
           WHEN age<20 THEN "under 20"
           WHEN age>=20 AND age<40 THEN "20-40"
           WHEN age>=40 AND age<60 THEN "40-60"
           ELSE "ABOVE 60"
		END AS AGE_GROUP,
ROUND(AVG(CASE 
        WHEN satisfaction ="satisfied" THEN 1
	    ELSE 0
    END)*100,2) as satisfaction_rate
FROM airline_passenger_satisfaction
GROUP BY age_group;

-- Calculate satisfaction rate by gender.
SELECT gender, ROUND(AVG(CASE 
        WHEN satisfaction ="satisfied" THEN 1
	    ELSE 0
    END)*100,2) as satisfaction_rate
FROM airline_passenger_satisfaction
GROUP BY gender;


