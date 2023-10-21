--- Question 6 ---

/*

(10 points) Find the maximum price of tickets between Seattle and New York, NY 
(i.e. Seattle to NY or NY to Seattle). Show the maximum price for each airline separately.

 Name the output columns carrier and max_price, in that order.

 [Output relation cardinality: 3 rows]

*/

--- Start Query ---

SELECT C.name AS carrier, MAX(F.price) AS max_price
FROM FLIGHTS AS F, CARRIERS AS C
WHERE F.carrier_id = C.cid
AND ((F.origin_city = 'Seattle WA' AND F.dest_city = 'New York NY') OR 
	(F.origin_city = 'New York NY' AND F.dest_city = 'Seattle WA'))
GROUP BY C.name; 

--- End Query ---

/* Making sense of this

	-- In the WHERE clause, we filter tuples (i.e. rows, flights) such that we only look at flights 
	   between Seattle and New York. Then we reorder the flights into groups based on carriers.
	   The MAX(F.price) function then finds the maximum price of a flight within each group.

	   It may look something like this:

	   carrier | origin city | destination city | price
	   ------------------------------------------------
	   c1        SEA           NY                 100
	   c1        SEA           NY                 150
	   c1        NY            SEA                300
	   c1        NY            SEA                200
	   .
	   .
	   c2        SEA           NY                 250
	   c2        NY            SEA                225

	   For c1, the max price would be 300, so the output would look like: (c1, 300)
	   For c2, the max price would be 250, so the output would look like: (c2, 250)

*/