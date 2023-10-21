-- HW 4 PART 2

-- a. ----- Translate the diagram

CREATE TABLE INSURANCECOS(name VARCHAR(100) PRIMARY KEY, phone INT);

CREATE TABLE PERSONS(ssn VARCHAR(50) PRIMARY KEY, name VARCHAR(100));

CREATE TABLE DRIVERS(ssn VARCHAR(50) REFERENCES PERSONS, driverID VARCHAR(50));
-- I initially had ssn and driverID be represented by integers, but the possibility of  
-- one of these attribtues starting with a 0 lead me to change the type to VARCHAR.

CREATE TABLE NONPROFESSIONALDRIVERS(ssn VARCHAR(50) REFERENCES DRIVERS);

CREATE TABLE PROFESSIONALDRIVERS(ssn VARCHAR(50) REFERENCES DRIVERS, medicalHistory VARCHAR(100));

CREATE TABLE VEHICLES(licensePlate VARCHAR(20) PRIMARY KEY, 
			         insuranceCoName VARCHAR(100) REFERENCES INSURANCECOS, 
			         ssn VARCHAR(50) REFERENCES PERSONS,
			         year INT,
			         maxLiability REAL);

CREATE TABLE CARS(licensePlate VARCHAR(20) REFERENCES VEHICLES, make VARCHAR(30));

CREATE TABLE TRUCKS(licensePlate VARCHAR(20) REFERENCES VEHICLES, 
				    ssn VARCHAR(50) REFERENCES PROFESSIONALDRIVERS, 
				    capacity INT);

-- b. -----
/*	
	Which relation in your relational schema represents the relationship "insures" in the 
	E/R diagram? Why is that your representation?

	The VEHICLES table/schema has a foreign key that references the INSURANCECOS table/schema.
	This because each vehicle is insured by an insurance company, or that an insurance company 
	insures a vehicle. This is a many to one relationship because an insurance company can insure
	many vehicles. If a vehicle is not insured perhaps it would be represented by a null value and 
	maxLiability would be 0 or null. 

	By creating a VEHICLES table with a foreign key,
	we eliminate the redundancy that would be created if INSURNACECOS had to list every 
	vehicle insured by every insurance company. 
*/

-- c. -----
/*
	 Compare the representation of the relationships "drives" and "operates" in your schema, 
	 and explain why they are different.

	 Multiple Nonprofessional drivers can 'drive' a car. This analogous to someone having a class C
	 driver's license - they can drive any class C vehicle, but this does not necessarily mean that 
	 they are qualified to drive a truck - the same idea holds for this diagram.

	 A truck is operated by a designated professional driver (or a professional driver can operate
	 many trucks, hence the many to one relationship we see in the diagram). Not everyone is 
	 permitted to drive a truck, they require a special license and training.

	 This is represented in the schema in the TRUCKS table. Each truck has a reference to the ssn
	 of a professional driver, while a car does not have a foreign key to any particular 
	 person/driver type.
*/