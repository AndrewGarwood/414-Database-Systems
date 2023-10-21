-- This sql file will be used to create the tables from the specified schemas

-- Enable Foregin Keys. i.e. REFERENCES
PRAGMA foreign_keys=ON; 

-- 1 ---- Create FLIGHTS Table
CREATE TABLE FLIGHTS (fid INT PRIMARY KEY,
					  month_id INT REFERENCES MONTHS,
					  day_of_month INT,
					  day_of_week INT REFERENCES WEEKDAYS,
					  carrier_id VARCHAR(7) REFERENCES CARRIERS,
					  flight_num INT,
					  origin_city VARCHAR(34),
					  origin_state VARCHAR(47),
					  dest_city VARCHAR(34),
					  dest_state VARCHAR(46),
					  departure_delay INT,
					  taxi_out INT, 
					  arrival_delay INT,
					  canceled INT,
					  actual_time INT,
					  distance INT,
					  capacity INT,
					  price INT);

-- 2 ---- Create CARRIERS Table
CREATE TABLE CARRIERS (cid VARCHAR(7) PRIMARY KEY, name VARCHAR(83));

-- 3 ---- Create MONTHS Table
CREATE TABLE MONTHS (mid INT PRIMARY KEY, month VARCHAR(9));

-- 4 ---- Create WEEKDAYS Table
CREATE TABLE WEEKDAYS (did INT PRIMARY KEY, day_of_week VARCHAR(9));