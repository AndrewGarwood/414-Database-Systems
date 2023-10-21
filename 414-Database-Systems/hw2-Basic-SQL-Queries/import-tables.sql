-- This sql file will be used to import data to the tables created in create-tables.sql

.mode csv

.import C:/Users/drewg/Desktop/flight-dataset/flights-small.csv FLIGHTS

.import C:/Users/drewg/Desktop/flight-dataset/carriers.csv CARRIERS

.import C:/Users/drewg/Desktop/flight-dataset/months.csv MONTHS

.import C:/Users/drewg/Desktop/flight-dataset/weekdays.csv WEEKDAYS