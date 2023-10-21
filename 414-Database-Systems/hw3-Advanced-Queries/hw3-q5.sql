-- q5
--List all cities that cannot be reached from Seattle through a direct flight nor with one stop 
--(i.e., with any two flights that go through an intermediate city). Warning: this query might take a 
--while to execute. We will learn about how to speed this up in lecture. (15 points)

--Name the output column city. Order the output ascending by city.
--(You can assume all cities to be the collection of all origin_city or all dest_city)

--(Note: Do not worry if this query takes a while to execute. We are mostly concerned with the results)
--[Output relation cardinality: 3 or 4, depending on what you consider to be the set of all cities]
--*/

-- looks like we use something similar to previous query... 
-- Let F4.origin_city represent the destination of the second connecting flight. In the "diagram" below, it's City 3.
-- Start City (City 0) ------> City 1 ------> City 2 ------> City 3
SELECT DISTINCT F4.origin_city as city
FROM FLIGHTS AS F4
WHERE F4.origin_city NOT IN (SELECT DISTINCT F2.dest_city   -- Filter out one stop/single layover flights
                             FROM FLIGHTS AS F1, FLIGHTS AS F2
                             WHERE F1.origin_city = 'Seattle WA'
                             AND F1.dest_city = F2.origin_city) -- According to spec, we don't care about not going back to seattle, I think
AND  F4.origin_city NOT IN (SELECT DISTINCT F3.dest_city -- Filter out direct flights
                             FROM FLIGHTS AS F3
                             WHERE F3.origin_city = 'Seattle WA') -- Order of these two subqueries matter.Put the less complicated one first 
ORDER BY F4.origin_city ASC;                                      -- so that if it fails we do not spend time computing the second, more complicated subquery

/*
Query Cardinality: 4

Query Time: 53s

Query's fisrt 20 rows:

city
---------------------
Devils Lake ND
Hattiesburg/Laurel MS
St. Augustine FL
Victoria TX
*/






