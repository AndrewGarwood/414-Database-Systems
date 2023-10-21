/*
For each origin city, find the percentage of departing flights shorter than 3 hours.You should not include cancelled flights in your determination. (15 points)

Name the output columns origin_city and percentage. Order by percentage value, then city, ascending. Be careful to handle cities without any flights shorter than 3 hours. 
You should return 0 as the result for these cities, not NULL (which is shown as a blank cell in Azure) Report percentages as percentages not decimals 
(e.g., report 75.25 rather than 0.752534).
[Output relation cardinality: 327]
*/

/* failed attempt
WITH ORIGINCITIES AS 
    (SELECT F_sub.origin_city AS sub_origin_city, COUNT(*) AS num_flights
     FROM FLIGHTS as F_sub
     WHERE F_sub.canceled = 0 
     GROUP BY F_sub.origin_city)
SELECT DISTINCT F.origin_city AS origin_city, 100.0 * ISNULL(COUNT(*), 0) / O.num_flights AS percentage
FROM FLIGHTS as F, ORIGINCITIES as O
WHERE (F.actual_time < 180 OR F.actual_time IS NULL)
AND F.origin_city = O.sub_origin_city 
AND F.canceled = 0
GROUP BY F.origin_city, O.num_flights
ORDER BY percentage, origin_city ASC;
*/


select f2.origin_city as origin_city, ROUND(ISNULL(                              -- Round to 2 digits, replace null values with 0
                                            (SELECT COUNT(*) AS num_flights_sub_180
                                             FROM FLIGHTS as F1
                                             WHERE F1.actual_time < 180
                                             AND F1.origin_city = F2.origin_city -- for all origin cities in F2, we count # flights under 180 minutes
                                             AND F1.canceled = 0                 -- and not canceled
                                             GROUP BY F1.origin_city) 
                                                                     * 100.0 / COUNT(*), 0),  2) AS percentage
from FLIGHTS as F2
WHERE F2.canceled = 0   -- do not include canceled flights in calculation
group by F2.origin_city  
ORDER BY percentage, F2.origin_city ASC;




/*
Query Cardinality: 327

Query Time: 19s

Query's fisrt 20 rows:
origin_city             percentage
---------------------------------------
Guam TT                 0.000000000000
Pago Pago TT            0.000000000000
Aguadilla PR            28.900000000000
Anchorage AK            31.810000000000
San Juan PR             33.660000000000
Charlotte Amalie VI     39.560000000000
Ponce PR                40.980000000000
Fairbanks AK            50.120000000000
Kahului HI              53.510000000000
Honolulu HI             54.740000000000
San Francisco CA        55.830000000000
Los Angeles CA          56.080000000000
Seattle WA              57.610000000000
Long Beach CA           62.180000000000
New York NY             62.370000000000
Kona HI                 63.160000000000
Las Vegas NV            64.920000000000
Christiansted VI        65.100000000000
Newark NJ               65.850000000000
Plattsburgh NY          66.670000000000
Worcester MA            67.210000000000


Philadelphia PA         67.780000000000
San Diego CA            68.240000000000
Portland OR             68.810000000000
Lihue HI                69.100000000000
Boston MA               69.120000000000

*/
