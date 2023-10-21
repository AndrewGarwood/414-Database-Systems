--- Question 4 ---

/*
(10 points) Find the names of all airlines that ever flew more than 1000 flights in one day 
(i.e., a specific day/month, but not any 24-hour period). 

Return only the names of the airlines. Do not return any duplicates (i.e., airlines with the exact 
same name).Name the output column name.

[Output relation cardinality: 12 rows]
*/

--- Start Query ---

SELECT DISTINCT C.name AS name
FROM FLIGHTS AS F, CARRIERS AS C
WHERE F.carrier_id = C.cid
GROUP BY F.day_of_month, C.name
HAVING COUNT(*) > 1000;

--- End Query ---

/* Making sense of this

	-- Using the DISTINCT keyword prevents a carrier's name from being listed more than once 
	   (they might have flew more than 1000 flights for more than a single day)

	-- The HAVING clause filters attributes in the GROUP BY clause. To be more specific, I believe 
	   it counts the tuples in the specified group. The tuples are grouped by the day of the month
	   and the carrier name. I believe each group would then correlate to a flight on a specific 
	   date with a specific carrier. I created a sample representation below (hope it's accurate).

	   flight id | date | Carrier name |
	   ---------------------------------
	   123         x      c1
	   244         x      c1
	   .
	   .
	   .
	   1001        x      c1 -- let flight with flight_id = 1001 be the 1001th flight on date x by 
	   .                        carrier c1. then c1 is selected (if it is not already selected)
	   .
	   1009        y      c2
	   .
	   .
	   .


    -- I believe the predicate F.carrier_id = C.cid allows us to access the carrier's name in 
       the CARRIERS table. Without it, we would only have access to the carrier_id, hence the
       join is necessary.
*/