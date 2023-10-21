-- q7
-- Express the same query as above, but do so without using a nested query. Again, name the output column carrier and 

-- order ascending by carrier. (8 points)

-- [Output relation cardinality: 4]

SELECT DISTINCT C.name AS carrier
FROM FLIGHTS AS F, CARRIERS AS C
WHERE C.cid = F.carrier_id
AND F.origin_city = 'Seattle WA'
AND F.dest_city = 'San Francisco CA'
ORDER BY carrier ASC;

/*
Query Cardinality: 4

Query Time: 3s

Query's fisrt 20 rows:

carrier
---------------------
Alaska Airlines Inc.
SkyWest Airlines Inc.
United Air Lines Inc.
Virgin America
*/