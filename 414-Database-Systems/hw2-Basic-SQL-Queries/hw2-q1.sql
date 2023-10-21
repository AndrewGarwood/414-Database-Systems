--- Question 1 ---

/*
(10 points) List the distinct flight numbers of all flights from Seattle to Boston by Alaska Airlines Inc. on Mondays. 
Also notice that, in the database, the city names include the state. So Seattle appears as Seattle WA. Please use the flight_num column 
instead of fid. Name the output column flight_num.
 [Hint: Output relation cardinality: 3 rows]
*/

--- Start Query ---

SELECT DISTINCT flight_num
FROM FLIGHTS AS f
WHERE f.origin_city = "Seattle WA" 
AND f.dest_city = "Boston MA" 
AND f.carrier_id = "AS" 
AND f.day_of_week = 1;

--- End Query ---

/* Making sense of this

	-- from the hint, the cardinality is 3. without the DISTINCT key word, we get an output with 
	   cardinality > 3 but only having 3 different 
	-- numbers. i.e. 12 printed multiple times. Using DISTINCT results in an output of 3 unique 
	   flight numbers 12, 24, 734

*/
