--- Question 8 ---

/*
(10 points) Compute the total departure delay of each airline across all flights. Some departure 
delays may be negative (indicating an early departure); they should reduce the total, so you don't 
need to handle them specially. 

Name the output columns name and delay, in that order. 

[Output relation cardinality: 22 rows]
*/

--- Start Query ---

SELECT C.name AS name, SUM(F.departure_delay) AS delay
FROM FLIGHTS AS F, CARRIERS AS C
WHERE F.carrier_id = C.cid
GROUP BY C.name;

--- End Query ---

/* Making sense of this

	-- From my interpretation, we group all the flights/rows/tuples by their carrier, so we put
	   C.name in the group by clause. Then we can use the aggregate function SUM to calculate the
	   sum of all departure delays for each carrier

	   I think it would look something like this:

	   carrier | departure delay 
	   -------------------------
	   c1        10
	   c1        15
	   c1        5
	   c2        30
	   c2        50

	   So the output based on this trivial data would be (c1, 30), (c2, 80).

    -- Joining FLIGHTS and CARRIERS allows us to get the carrier name I believe.
*/