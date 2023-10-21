--- Question 3 ---

/*
(10 points) Find the day of the week with the longest average arrival delay. Return the name of the day and the average delay.
 Name the output columns day_of_week and delay, in that order. (Hint: consider using LIMIT. Look up what it does!)
 [Output relation cardinality: 1 row]
 */

--- Start Query ---

SELECT W.day_of_week, AVG(F.arrival_delay) AS delay
FROM FLIGHTS AS F, WEEKDAYS AS W
WHERE F.day_of_week = W.did
GROUP BY W.day_of_week
ORDER BY AVG(F.arrival_delay) DESC
LIMIT 1;

--- End Query ---

/* Making sense of this

	Limit allows us to limit the output to one column. So while there would be data after the 
	first row (days with smaller avg delay) we limit it to 1 to get the day with the largest
	average delay
*/

-- NOTE -- select w.day_of_week gives the string while f.day_of_week gives the integer representation
---------- I'm assuming we want the string.