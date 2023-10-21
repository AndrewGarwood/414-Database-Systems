--- Question 2 ---
/*

(10 points) Find all itineraries from Seattle to Boston on July 15th. Search only for itineraries that have one stop 
(i.e., flight 1: Seattle -> [somewhere], flight2: [somewhere] -> Boston). Both flights must depart on the same day (same day here means the date of flight) 
and must be with the same carrier. It's fine if the landing date is different from the departing date (i.e., in the case of an overnight flight). 
You don't need to check whether the first flight overlaps with the second one since the departing and arriving time of the flights are not provided.

The total flight time (actual_time) of the entire itinerary should be fewer than 7 hours (but notice that actual_time is in minutes).
For each itinerary, the query should return the name of the carrier, the first flight number, the origin and destination of that first flight,
the flight time, the second flight number, the origin and destination of the second flight, the second flight time, and finally the total flight time. 
Only count flight times here; do not include any layover time.

 Name the output columns name (as in the name of the carrier), f1_flight_num, f1_origin_city, f1_dest_city, f1_actual_time, f2_flight_num, f2_origin_city, 
 f2_dest_city, f2_actual_time, and actual_time as the total flight time. List the output columns in this order. [Output relation cardinality: 1472 rows]
*/


--- Start Query ---

SELECT c.name as name, 
f1.flight_num AS f1_flight_num, 
f1.origin_city AS f1_origin_city, 
f1.dest_city AS f1_dest_city, 
f1.actual_time AS f1_actual_time, 
f2.flight_num AS f2_flight_num, 
f2.origin_city AS f2_origin_city, 
f2.dest_city AS f2_dest_city, 
f2.actual_time AS f2_actual_time, 
(f1.actual_time + f2.actual_time) AS actual_time
FROM FLIGHTS AS f1, FLIGHTS as f2, CARRIERS AS c
WHERE f1.origin_city = 'Seattle WA' 
AND f2.dest_city = 'Boston MA' 
AND f1.dest_city = f2.origin_city
AND f1.month_id = 7
AND f2.month_id = 7
AND f1.day_of_month = 15
AND f2.day_of_month = 15
AND f1.carrier_id = f2.carrier_id 
AND f1.carrier_id = c.cid
AND (f1.actual_time + f2.actual_time) < (7 * 60);

--- End Query ---

/* Making sense of this

	-- The SELECT statement has a lot of variable aliasing (not sure if that is the right terminology)
	   so make column names correlating to flight variables.

    -- In the FROM clause, we join FLIGHTS with itself and CARRIERS
       I believe the self join allows us to compare data in the FLIGHTS table with other data in the FLIGHTS
       table. Nested Queries are bad. Joining with C allows us access to the carriers' names

    -- The WHERE clause . . .
       -- We make sure the flight is from Seattle to Boston
       -- We make sure that flight1 starts in Seattle (origin city) ; we do not care for 
          flight1's destination city.
       -- flight2's origin city must equal flight1's destination city. flight2's destination
          must be Boston. hence the 1 stop requirement.
       -- flight1 and flight2 must depart on the same date: July 15th
          We use the fact that July's month_id is 7
          day_of_month = 15 represents the 15th day of the month 
       -- flight1 and flight2 must be offered by the same carrier
       -- to satisfy the total flight time less than 7 hours, we convert hours to minutes in order to compare
          the time constraint with the flight times of flight1 and flight2. 

*/

--- CHECK CARDINALITY ---

-- SELECT COUNT(*)
-- FROM FLIGHTS AS f1, FLIGHTS as f2, CARRIERS as c 
-- WHERE f1.origin_city = 'Seattle WA' 
-- AND f2.dest_city = 'Boston MA' 
-- AND f1.dest_city = f2.origin_city
-- AND f1.month_id = 7
-- AND f2.month_id = 7
-- AND f1.day_of_month = 15
-- AND f2.day_of_month = 15
-- AND f1.carrier_id = f2.carrier_id 
-- AND f1.carrier_id = c.cid
-- AND (f1.actual_time + f2.actual_time) < (7 * 60);
