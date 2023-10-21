-- q1,  --

WITH MaxTime AS 
    (SELECT Fs.origin_city AS origin_city, MAX(Fs.actual_time) AS actual_time
     FROM FLIGHTS as Fs
     GROUP BY Fs.origin_city)
SELECT DISTINCT F.origin_city, F.dest_city, F.actual_time
FROM FLIGHTS as F, MaxTime AS MT
WHERE F.origin_city = MT.origin_city 
AND F.actual_time = MT.actual_time;

/*
Query Cardinality: 334

Query Time: 17s

Query's fisrt 20 rows: 

Aberdeen SD         Minneapolis MN      106
Abilene TX          Dallas/Fort Worth TX    111
Adak Island AK      Anchorage AK        471
Aguadilla PR        New York NY         368
Akron OH            Atlanta GA          408
Albany GA           Atlanta GA          243
Albany NY           Atlanta GA          390
Albuquerque NM      Houston TX          492
Alexandria LA       Atlanta GA          391
Allentown/Bethlehem/Easton PA   Atlanta GA  456
Alpena MI           Detroit MI          80
Amarillo TX         Houston TX          390
Anchorage AK        Barrow AK           490
Appleton WI         Atlanta GA          405
Arcata/Eureka CA    San Francisco CA    476
Asheville NC        Chicago IL          279
Ashland WV          Cincinnati OH       84
Aspen CO            Los Angeles CA      304
Atlanta GA          Honolulu HI         649
Atlantic City NJ    Fort Lauderdale FL  212
*/