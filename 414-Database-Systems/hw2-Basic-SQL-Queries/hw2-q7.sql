--- Question 7 ---

/*
(10 points) Find the total capacity of all direct flights that fly between Seattle and 
San Francisco, CA on July 10th (i.e. Seattle to SF or SF to Seattle).

Name the output column capacity.

[Output relation cardinality: 1 row]
*/

--- Start Query ---

SELECT SUM(F.capacity) AS capacity
FROM FLIGHTS as F
WHERE F.day_of_month = 10
AND F.month_id = 7
AND ((F.origin_city = 'Seattle WA' AND F.dest_city = 'San Francisco CA') OR 
	(F.origin_city = 'San Francisco CA' AND F.dest_city = 'Seattle WA'));

--- End Query ---

/* Making sense of this

	-- Here, the parameters that matter are the date variables and capacity
	   Using the attr F.day_of_month, we look for day_of_month = 10 because that is the 10th day
	   of the month. Using the attr F.month_id, we can identify a month by its integer 
	   representation. In this case, month_id = 7 because July is the 7th month

    -- When looking for flights between Seattle and San Francisco, we can use the same logic as
       question 6. 

    -- I don't believe we need to group by anything. We are just summing a column after filtering
       out unnecessary tuples/flights/rows.
*/