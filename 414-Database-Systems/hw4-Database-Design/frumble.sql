
-- Create table for data given by no-good Mr. Frumble
CREATE TABLE SALES(name VARCHAR(30), discount VARCHAR(3), month VARCHAR(3), price INT);

.mode tabs

.import C:/Users/drewg/Desktop/mrFrumbleData.txt SALES

/*
	Using the queries below, we can determine if attributes form a functional dependency if the 
	output is 0 (or there is no output). We first join the sales table with itself. The queries
	below check if the premise of the relation determines a unique consequence.
	i.e. for A = subset of attributes and B = subset of attributes, A -> B implies that a distinct
	A determines a unique B. (I hope I described it right)

	A = premise = subset of attributes
	B = consequence = subset of attributes
	A -> B 
*/

SELECT COUNT(*) 
FROM SALES AS S1, SALES AS S2
WHERE S1.month = S2.month
AND S1.discount != S2.discount;
/*  month -> discount
	This is a Functional dependency. This FD means that month determines the discount rate.
*/

SELECT COUNT(*) 
FROM SALES AS S1, SALES AS S2
WHERE S1.name = S2.name
AND S1.price != S2.price;
/*  name -> price
	This is a Functional dependency. This FD means that name determines the price.
*/


--	Example of Functional Dependency that does not Exist
/*  
	A functional dependency does not exist if the subset of attributes in the premise do not 
	determine a unique subset of attributes in the consequence.

	Take the first query below, where we check if (name, discount) -> (month, price)
	We check if a distinct pair name, discount determine a unique pair price, month. This is not 
	a functional dependency because there exists two distinct consequences with the same premise.

		Here is a concrete example:
		name = 'bar1'; discount = '15%'' outputs multiple, distinct pairs of month, price.
        Output_1: month = 'apr' price = '19' | Output_2 = 'aug' price = '19'
        We can see the months are different which means the output is not unique so the relation
        name, discount -> month, price is NOT a functional dependency 
*/


---- NON FD QUERY ----
SELECT COUNT(*) 
FROM SALES AS S1, SALES AS S2
WHERE (S1.name = S2.name AND S1.discount = S2.discount)
AND (S1.price != S2.price OR S1.month != S2.month);
--name, discount -> price, month NOT a FD

SELECT COUNT(*) 
FROM SALES AS S1, SALES AS S2
WHERE S1.name = S2.name
AND (S1.discount != S2.discount
OR S1.month != S2.month
OR S1.price != S2.price); 
-- name -> discount, month, price NOT a FD

----------------------------------
---- CREATE BCNF TABLES -----
-----------------------------
-- R(name, discount, month, price)

-- R1 (name, price); R2 (name, discount month)
--                  R3(month, discount); R4(name, month)

-- R1, R3, R4 are the ones we want

-- Make R1 Table
CREATE TABLE NAMEPRICE(name VARCHAR(30) PRIMARY KEY, price INT);

-- Make R3 Table
CREATE TABLE MONTHDISCOUNT(month VARCHAR(3) PRIMARY KEY, discount VARCHAR(3));

-- Make R4 Table
CREATE TABLE NAMEMONTH(name VARCHAR(30) REFERENCES NAMEPRICE, month VARCHAR(3) REFERENCES MONTHDISCOUNT);

------------------------------------------
---- INSERT DATA INTO NEW TABLES ----
-------------------------------------
INSERT INTO NAMEPRICE(name, price)
SELECT DISTINCT name, price
FROM SALES;

SELECT COUNT(*) FROM NAMEPRICE; -- cardinality = 36 *** 

INSERT INTO MONTHDISCOUNT(month, discount)
SELECT DISTINCT month, discount
FROM SALES;

SELECT COUNT(*) FROM MONTHDISCOUNT; -- cardinality = 12 ***

INSERT INTO NAMEMONTH(name, month)
SELECT DISTINCT name, month
FROM SALES;

SELECT COUNT(*) FROM NAMEMONTH; -- cardinality = 426 ***

-- *** When I imported the data using .mod tabs, the column names were included in the data for some reason that
--     currently escapes me. So the query to calculate the cardinality includes an extra row so I subracted 1 to
--     get the numbers that are currently displayed 







-------------------------------
---- OTHER FD TESTING ----
--------------------------
/*
SELECT * 
FROM SALES AS S1, SALES AS S2
WHERE S1.name = S2.name
AND (S1.discount != S2.discount
OR S1.month != S2.month
OR S1.price != S2.price);
-- name -> disc, month, price

SELECT * 
FROM SALES AS S1, SALES AS S2
WHERE S1.month = S2.month
AND (S1.discount != S2.discount
OR S1.price != S2.price
OR S1.name != S2.name);
-- month -> name, disc, price


SELECT * 
FROM SALES AS S1, SALES AS S2
WHERE S1.month = S2.month
AND (S1.discount != S2.discount
OR S1.price = S2.price
OR S1.name != S2.name);
-- month, price -> name, discount ----------------------- not fd?

SELECT * 
FROM SALES AS S1, SALES AS S2
WHERE (S1.month != S2.month
OR S1.discount = S2.discount
OR S1.price != S2.price)
AND S1.name = S2.name;
-- name discount -> month price --------------------- wrong / not fd?

SELECT COUNT(*) 
FROM SALES AS S1, SALES AS S2
WHERE S1.discount != S2.discount
AND S1.price = S2.price;
-- discount -> price --- not fd

SELECT COUNT(*) 
FROM SALES AS S1, SALES AS S2
WHERE (S1.discount = S2.discount AND S1.price = S2.price)
AND (S1.month != S2.month OR S1.name != S2.name); 
--- disc, price -> month name, not fd
*/