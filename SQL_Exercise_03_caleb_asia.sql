create database global_diversity ;
use global_diversity;

-- department is the parent element --
CREATE TABLE departments (
    Department_ID INT NOT NULL AUTO_INCREMENT,
    Department_Name VARCHAR(45) NOT NULL,
    Location VARCHAR(45) NOT NULL,

    PRIMARY KEY (Department_ID)
);

CREATE TABLE employees (
    Employee_ID INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(45) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Department_ID INT NOT NULL,

    PRIMARY KEY (Employee_ID),

    FOREIGN KEY (Department_ID)
    REFERENCES departments(Department_ID)
);

CREATE TABLE department_heads (
    Head_ID INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(45) NOT NULL,
    Department_ID INT NOT NULL,

    PRIMARY KEY (Head_ID),

    FOREIGN KEY (Department_ID)
    REFERENCES departments(Department_ID)
);
-- tables employees and department_head both referenced the primary key in departments making it a foreign key --

-- inserting the data given into our tables i have created --
INSERT INTO departments 
VALUES 
(201 ,' Human Resources' ,' Johannesburg') ,
(202 , 'IT '  ,'Cape Town') ,
(203 , 'Marketing '  , ' Durban' ),
(204 ,'Finance ' ,'Pretoria' ) ;

select * from departments;

INSERT INTO employees 
VALUES 
(1 ,'Thandiwe Mkhize' , 'thandiwe@mzansi.com ' ,'0834567890' , 201),
(2 ,' Sipho Dlamini' ,'sipho@mzansi.com ' ,'0732345678' ,202),
(3 ,'Nosipho Ngcobo' ,'nosipho@mzansi.com', '0613456789' ,203),
(4 ,'Johan van der Merwe', 'johan@mzansi.com' ,'0824567890' ,201),
(5 ,'Zanele Molefe' ,'zanele@mzansi.com' ,'0711234567' , 204);

select * from  employees ;

INSERT INTO department_heads
VALUES
(1 ,' Lerato Khumalo' ,201),
(2 ,'Themba Ndlovu', 202 ),
(3 ,'Fatima Patel' ,203),
(4 ,'Peter Mabena' ,204);

select * from department_heads ;

-- referenced at https://www.w3schools.com/sql/sql_join_full.asp --
-- selected the two columns from employees to showcase the name and email of the person that has the same department_id of the IT department--
-- the two tables were joined so that they could see which of the values matched the condition inputed since the employee table didnt have the department name --
SELECT employees.Name , employees.Email
FROM employees
JOIN departments 
ON employees.Department_ID = departments.Department_ID
WHERE departments.Department_ID = 202;

-- referenced at https://www.w3schools.com/sql/sql_count.asp --
SELECT departments.Department_Name,
COUNT(employees.Employee_ID) AS Total_Employees -- this counts the amount an employee id shows up and saves that amount as total employees --
FROM departments
JOIN employees -- this joins the tables together so data from both tables can be referenced --
ON departments.Department_ID = employees.Department_ID -- this is like a condition that checks if the id of both tables match --
GROUP BY departments.Department_Name ; 

-- edits an already existing value in a table --
UPDATE employees 
SET Phone = '0845678901'
WHERE Employee_ID = 4 ;

-- deletes a row from the table where all data in the same row as the condition matches --
DELETE FROM employees 
WHERE Employee_ID = 5 ;

SELECT * FROM employees;

-- created the user with their password --
CREATE USER 'mzansi_user'@'localhost'
IDENTIFIED BY 'securePass456' ;

-- gives them access to see and input more data in the mzansi_company database --
GRANT SELECT,INSERT 
ON mzansi_company.*
TO 'mzansi_user'@'localhost' ;

-- revokes the access that was given previously --
REVOKE SELECT,INSERT 
ON mzansi_company.*
FROM 'mzansi_user'@'localhost' ;

-- creates a table based on the department table data --
CREATE TABLE locations (
	Location_ID INT NOT NULL AUTO_INCREMENT, 
    Location_Name VARCHAR(100) NOT NULL ,
    Department_ID INT NOT NULL ,
    
    PRIMARY KEY (Location_ID),
    
     FOREIGN KEY (Department_ID)
     REFERENCES departments(Department_ID)
     );
     
     INSERT INTO locations
     VALUES 
     (101, 'Johannesburg' , 201),
     (102, 'Cape Town', 202),
     (103, 'Durban', 203),
     (104, 'Pretoria', 204);
     
     select * from locations ;
     -- deletes the column location and all of its data --
     ALTER TABLE departments
     DROP column Location ;
     
     select * from departments ;
     
     -- counted the department ids in employees and saved it as members --
     -- which ever department shows up at the condition amout will be displayed along with the amount they appear -- 
     select Department_ID , count(*) AS members
     from employees
     group by Department_ID
     having count(*) > 1 ;
     
     
     
     



