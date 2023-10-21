--- Question 5 ---

/*
(10 points) Find all airlines that had more than 0.5% (= 0.005) of their flights out of Seattle 
canceled. Return the name of the airline and the percentage of canceled flights out of Seattle. 
Percentages should be outputted in percent format (3.5% as 3.5 not 0.035). Order the results by the
percentage of canceled flights in ascending order.

Name the output columns name and percentage, in that order.

[Output relation cardinality: 6 rows]
*/

--- Start Query ---

SELECT C.name AS name, AVG(F.canceled) * 100 AS percentage
FROM FLIGHTS as F, CARRIERS as C
WHERE F.carrier_id = C.cid
AND F.origin_city = 'Seattle WA'
GROUP BY C.name
HAVING percentage > 0.5
ORDER BY percentage ASC;

--- End Query ---


/* Making sense of this

	-- Using the aggregate function AVG allows us to calculate the average amount of flights 
	   canceled. I believe the function is equivalent to summing the elements in the canceled 
	   column (in this case the elements are 1 and 0, where 1 represents a canceled flight). 
	   Then the function divides by the total number of elements in that group (where groups
	   are based off of the carrier). 

	   So it may look something like this:

	   flight id | canceled | carrier | origin_city | 
	   ----------------------------------------------------
	   1           1          c1        "SEA" -- Let SEA represent "Seattle WA"
	   2           0          c1        "SEA"
	   3           0          c1        "SEA"
	   4           0          c1        "SEA"

	   so we have (number of canceled flights = 1 = sum of canceled column) and divide that by the 
	   total number of flights by the same carrier in order to calculate the percentage. in this  
	   trivial example we have 1 / 4 = 0.25 * 100 = 25% of flights were canceled. Neat.

	-- It is also notable that we defined percentage = AVG(F.canceled) * 100
	   This allowed us to use percentage as a variable of sorts that could be used in the HAVING
	   and ORDER BY statements

    -- When we order by ascending, the output is ordered by least to greatest i.e. the further down
       the output you go, the hire the canceled percentage is. 

*/