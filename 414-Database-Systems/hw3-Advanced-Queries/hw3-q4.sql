-- q4
-- List all cities that can be reached from Seattle through one stop (i.e., with any two flights that go 
-- through an intermediate city) but cannot be reached through a direct flight. Do not include Seattle 
-- as one of these destinations (even though you could get back with two flights). (15 points)

-- Name the output column city. Order the output ascending by city.

-- [Output relation cardinality: 256] ** block comment syntax was not working...


SELECT DISTINCT F3.dest_city AS city
FROM FLIGHTS AS F2, FLIGHTS AS F3
WHERE F3.dest_city NOT IN (SELECT DISTINCT DF.dest_city AS dest_city -- Filter out cities w/ direct flights from SEA
                           FROM FLIGHTS AS DF -- where DF = Direct Flights
                           WHERE DF.origin_city = 'Seattle WA')
AND F2.origin_city = 'Seattle WA'  -- starting in seattle
AND F2.dest_city = F3.origin_city  -- get flight layover/intermediate city
AND F3.dest_city != 'Seattle WA'   -- we aren't flying back to seattle
ORDER BY F3.dest_city ASC;

/*
Query Cardinality: 256

Query Time: 27s

Query's fisrt 20 rows:
city
-----------
Aberdeen SD
Abilene TX
Adak Island AK
Aguadilla PR
Akron OH
Albany GA
Albany NY
Alexandria LA
Allentown/Bethlehem/Easton PA
Alpena MI
Amarillo TX
Appleton WI
Arcata/Eureka CA
Asheville NC
Ashland WV
Aspen CO
Atlantic City NJ
Augusta GA
Bakersfield CA
Bangor ME

Barrow AK      -- I can't count. Plus the formatting on Azure is difficult
Baton Rouge LA
Beaumont/Port Arthur TX
Bemidji MN
Bend/Redmond OR
Bethel AK
Billings MT
Binghamton NY
Birmingham AL

*/
