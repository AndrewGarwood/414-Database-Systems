-- q6
--List the names of carriers that operate flights from Seattle to San Francisco, CA. Return each carrier's name only once. 
--Use a nested query to answer this question. (7 points)

--Name the output column carrier. Order the output ascending by carrier.

--[Output relation cardinality: 4]

WITH SeaToSFFlights AS 
        (SELECT DISTINCT F1.carrier_id
         FROM FLIGHTS AS F1
         WHERE F1.origin_city = 'SEATTLE WA'
         AND F1.dest_city = 'San Francisco CA') 
SELECT DISTINCT C.name as carrier
FROM CARRIERS AS C, SeaToSFFlights AS F2
WHERE C.cid = F2.carrier_id
ORDER BY carrier ASC;

/*
Query Cardinality: 4

Query Time: 5s

Query's fisrt 20 rows:
carrier
---------------------
Alaska Airlines Inc.
SkyWest Airlines Inc.
United Air Lines Inc.
Virgin America
*/