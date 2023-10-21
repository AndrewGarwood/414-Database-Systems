


SELECT DISTINCT F.origin_city as city
FROM FLIGHTS AS F
WHERE 180 > ALL  (SELECT Fs.actual_time
                  FROM FLIGHTS as Fs
                  WHERE Fs.origin_city = F.origin_City)
AND F.canceled = 0
ORDER BY F.origin_city ASC;

/* 

Query Cardinality: 109

Query Runtime: 15s

Query's fisrt 20 rows: 

city
---------------------------------
Aberdeen SD
Abilene TX
Alpena MI
Ashland WV
Augusta GA
Barrow AK
Beaumont/Port Arthur TX
Bemidji MN
Bethel AK
Binghamton NY
Brainerd MN
Bristol/Johnson City/Kingsport TN
Butte MT
Carlsbad CA
Casper WY
Cedar City UT
Chico CA
College Station/Bryan TX
Columbia MO
Columbus GA
*/


/*
-- This is another way to do it
SELECT DISTINCT F.origin_city as city
FROM FLIGHTS AS F
WHERE F.origin_city NOT IN (SELECT DISTINCT Fs.origin_city
                            FROM FLIGHTS as Fs
                            WHERE Fs.actual_time >= (3* 60))
AND F.canceled = 0
ORDER BY F.origin_city ASC;
-- This takes 26s
-- 109 rows.
*/