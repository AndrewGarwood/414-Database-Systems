
CREATE TABLE SALES(name VARCHAR(30), discount VARCHAR(3), month VARCHAR(3), price INT);

.mode tabs

.import C:/Users/drewg/Desktop/mrFrumbleData.txt SALES

SELECT * 
FROM SALES AS S1, SALES AS S2
WHERE S1.month = S2.month
AND S1.discount != S2.discount;
-- No output -> functional dependency.
-- FD Month -> Discount. I figured this out by looking at data.

SELECT * 
FROM SALES AS S1, SALES AS S2
WHERE S1.name = S2.name
AND S1.price != S2.price;
-- name -> price




SELECT COUNT(*) AS CARDINALITY  
FROM SALES AS S1, SALES AS S2
WHERE S1.name = S2.name
AND S1.price != S2.price; 
-- this is fd from above -- name -> price


---- NON FD QUERY ----
SELECT COUNT(*) 
FROM SALES AS S1, SALES AS S2
WHERE (S1.name = S2.name AND S1.discount = S2.discount)
AND (S1.price != S2.price OR S1.month != S2.month);
--name, discount -> price, month ------------------------ not fd

SELECT COUNT(*) 
FROM SALES AS S1, SALES AS S2
WHERE S1.name = S2.name
AND (S1.discount != S2.discount
OR S1.month != S2.month
OR S1.price != S2.price); ---------- not fd


---- CREATE BCNF TABLES -----

-- R(name, discount, month, price)

-- R1 (name, price); R2 (name, discount month)
--                  R3(month, discount); R4(name, month)
-- R1, R3, R4 are the ones we want

-- R1 Table
CREATE TABLE NAMEPRICE(name VARCHAR(30) PRIMARY KEY, price INT);

-- R3 Table
CREATE TABLE MONTHDISCOUNT(month VARCHAR(3) PRIMARY KEY, discount VARCHAR(3));

-- R4 Table
CREATE TABLE NAMEMONTH(name VARCHAR(30) REFERENCES NAMEPRICE, month VARCHAR(3) REFERENCES MONTHDISCOUNT);

---- INSERT DATA INTO NEW TABLES ----

INSERT INTO NAMEPRICE(name, price)
SELECT DISTINCT name, price
FROM SALES;

SELECT COUNT(*) FROM NAMEPRICE; -- cardinality = 36 *** subtracted column title row 

INSERT INTO MONTHDISCOUNT(month, discount)
SELECT DISTINCT month, discount
FROM SALES;

SELECT COUNT(*) FROM MONTHDISCOUNT; -- cardinality = 12 ***

INSERT INTO NAMEMONTH(name, month)
SELECT DISTINCT name, month
FROM SALES;

SELECT COUNT(*) FROM NAMEMONTH; -- cardinality = 426 ***










----- --------------so this is wrong ? (see below)
/*
SELECT * 
FROM SALES AS S1, SALES AS S2
WHERE S1.name = S2.name
AND S1.discount != S2.discount
AND S1.month != S2.month
AND S1.price != S2.price;
-- name -> disc, month, price

SELECT * 
FROM SALES AS S1, SALES AS S2
WHERE S1.month = S2.month
AND S1.discount != S2.discount
AND S1.price != S2.price
AND S1.name != S2.name;
-- month -> name, disc, price


SELECT * 
FROM SALES AS S1, SALES AS S2
WHERE S1.month = S2.month
AND S1.discount != S2.discount
AND S1.price = S2.price
AND S1.name != S2.name;
-- month, price -> name, discount ----------------------- not fd?

SELECT * 
FROM SALES AS S1, SALES AS S2
WHERE S1.month != S2.month
AND S1.discount = S2.discount
AND S1.price != S2.price
AND S1.name = S2.name;
-- name discount -> month price --------------------- wrong / not fd?

SELECT COUNT(*) 
FROM SALES AS S1, SALES AS S2
WHERE S1.discount != S2.discount
AND S1.price = S2.price;
-- discount -> price --- not fd

SELECT COUNT(*) 
FROM SALES AS S1, SALES AS S2
WHERE S1.month != S2.month
AND S1.discount = S2.discount
AND S1.price = S2.price
AND S1.name != S2.name; 
--- disc, price -> month name, not fd
*/