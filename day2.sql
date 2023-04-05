select * from EMPLOYEES;

-- Questinon 1
-- Write a SQL query to remove the details of an employee whose first name ends in ‘even’
delete from EMPLOYEES where FIRST_NAME like '%even';

-- Questinon 2
-- Write a query in SQL to show the three minimum values of the salary from the table.

select * from EMPLOYEE 
order by SALARY desc
limit 3;

select * from EMPLOYEE 
order by SALARY desc
fetch 1  row 2 

select round(avg(salary) , 0) as average  from EMPLOYEE

select count(EMPLOYEE_ID),salary from EMPLOYEE
group by salary
order by salary desc


-- Questinon 3
-- Write a SQL query to copy the details of this table into a new table with table name as Employee table and to delete the records in employees table
create table Employee as (select * from EMPLOYEES)
truncate table EMPLOYEES;
select * from EMPLOYEE

-- Questinon 4
-- Write a SQL query to remove the column Age from the table
alter table EMPLOYEE
drop column age;

-- Questinon 5
-- Obtain the list of employees (their full name, email, hire_year) where they have joined the firm before 2000

select concat(FIRST_NAME,' ',LAST_NAME) as NAME,EMAIL, hire_date from EMPLOYEE
where year(HIRE_DATE)<2000;

-- Questinon 6
-- Fetch the employee_id and job_id of those employees whose start year lies in the range of 1990 and 1999
select EMPLOYEE_ID, JOB_ID,year(HIRE_DATE) as YEAR from EMPLOYEE
where year(HIRE_DATE) between 1990 AND 1999
order by year(HIRE_DATE) ;



-- Questinon 7
-- Find the first occurrence of the letter 'A' in each employees Email ID
-- Return the employee_id, email id and the letter position

select EMPLOYEE_ID,EMAIL,POSITION('A' IN EMAIL) AS MatchPosition from EMPLOYEE;

-- Questinon 8
-- Fetch the list of employees(Employee_id, full name, email) whose full name holds characters less than 12

select EMPLOYEE_ID,concat(FIRST_NAME,' ',LAST_NAME) as NAME,EMAIL from EMPLOYEE
where length(concat(FIRST_NAME,LAST_NAME))<12;

-- Questinon 9
-- Create a unique string by hyphenating the first name, last name , and email of the employees to obtain a new field named UNQ_ID
-- Return the employee_id, and their corresponding UNQ_ID;


select EMPLOYEE_ID,concat_ws('-',FIRST_NAME,LAST_NAME,EMAIL) as UNQ_ID from EMPLOYEE;



-- Questinon 10
-- Write a SQL query to update the size of email column to 30
alter table EMPLOYEE
modify EMAIL
varchar(30);


-- Questinon 11
-- Write a SQL query to change the location of Diana to London
select *,('London') as Location from EMPLOYEE
where FIRST_NAME = 'Diana';



select * from EMPLOYEE
where FIRST_NAME = 'Diana'

select * from LOCATIONS
update LOCATIONS
set LOCATION_ID = "London"
where LOCATION_ID 

-- Questinon 12
-- Fetch all employees with their first name , email , phone (without extension part) and extension (just the extension)
-- Info : this mean you need to separate phone into 2 parts
-- eg: 123.123.1234.12345 => 123.123.1234 and 12345 . first half in phone column and second half in extension column


select concat(FIRST_NAME,' ',LAST_NAME), EMAIL, iff(array_size(split(phone_number,'.'))>3,
array_to_string(array_slice(split(phone_number,'.'),0,3),'.'),
array_to_string(array_slice(split(phone_number,'.'),0,2),'.')) as phonecolumn,
split_part(PHONE_NUMBER,'.',-1) as extension from EMPLOYEE;



-- Questinon 13
-- Write a SQL query to find the employee with second and third maximum salary with and without using top/limit keyword

select distinct EMPLOYEE_ID, SALARY from EMPLOYEE
order by SALARY desc 
OFFSET 2 ROWS FETCH NEXT 2 ROWS ONLY;


--  Questinon 14
-- Fetch all details of top 3 highly paid employees who are in department Shipping and IT



select * from EMPLOYEE 
Where DEPARTMENT_ID in (select DEPARTMENT_ID from DEPARTMENTS where DEPARTMENT_NAME in('IT','Shipping'))
order by SALARY desc
limit 3;


--  Questinon 15
-- Display employee id and the positions(jobs) held by that employee
select * from JOB_HISTORY;

select e.EMPLOYEE_ID, e.JOB_ID, j.JOB_ID from EMPLOYEE as e ,JOB_HISTORY as j
where e.EMPLOYEE_ID = j.EMPLOYEE_ID;

select EMPLOYEE_ID, JOB_ID from EMPLOYEE
union
select EMPLOYEE_ID, JOB_ID from JOB_HISTORY
order by EMPLOYEE_ID;


-- Questinon 16
-- . Display Employee first name and date joined as WeekDay, Month Day, Year

-- Emp ID Date Joined

-- 1 Monday, June 21st, 1999

select EMPLOYEE_ID ,concat(dayname(HIRE_DATE),',  ',monthname(HIRE_DATE),' ',day(HIRE_DATE),',  ',year(HIRE_DATE)) as date from EMPLOYEE;


-- Questinon 17
-- The company holds a new job opening for Data Engineer (DT_ENGG) with a minimum salary of 12,000 and maximum salary of 30,000 . The job position might be removed based on market trends (so, save the changes) . - Later, update the maximum salary to 40,000 . - Save the entries as well.

-- Now, revert back the changes to the initial state, where the salary was 30,000


ALTER SESSION SET AUTOCOMMIT = false;
begin transaction
INSERT INTO jobs
VALUES (
	'DT_ENGG',
	'Data Engineer',
	12000,
	30000
	)
 select * from JOBS 
 commit
 update JOBS
 set MAX_SALARY = 40000
 where JOB_TITLE = 'Data Engineer'

 rollback;



 -- Questinon 18
-- Find the average salary of all the employees who got hired after 8th January 1996 but before 1st January 2000 and round the result to 3 decimals

select round(avg(SALARY),3) from EMPLOYEE where HIRE_DATE between '08/01/1996' and '01/01/2000';


-- Questinon 19
-- Display Australia, Asia, Antarctica, Europe along with the regions in the region table (Note: Do not insert data into the table)

-- A. Display all the regions

-- B. Display all the unique regions

select REGION_NAME from REGIONS
union select 'Australia' as REGION_NAME
union select 'Asia' as REGION_NAME
union select 'Antarctica' as REGION_NAME
union select 'Europe' as REGION_NAME

;


select REGION_NAME from REGIONS
union all select 'Australia' as REGION_NAME
union all select 'Asia' as REGION_NAME
union all select 'Antarctica' as REGION_NAME
union all select 'Europe' as REGION_NAME
;

select REGION_NAME from REGIONS


-- Questinon 20

drop table employee



