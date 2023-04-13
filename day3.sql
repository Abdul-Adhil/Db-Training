select * from EMPLOYEE;
where not first_name = 'Nancy' and ( ) ;

select * from departments;

select * from locations;
select * from departments;

-- Questinon 1
-- Write a SQL query to find the total salary of employees who is in Tokyo excluding whose first name is Nancy
select * from departments
where location_id = 2400;

select sum(salary) from EMPLOYEE
inner join DEPARTMENTS
inner join LOCATIONS
on (EMPLOYEE.DEPARTMENT_ID= DEPARTMENTS.DEPARTMENT_ID ) and (DEPARTMENTS.LOCATION_ID=LOCATIONS.LOCATION_ID)
where LOCATIONS.CITY = 'Seattle' and FIRST_NAME not like 'Nancy';


-- Questinon 2
-- Fetch all details of employees who has salary more than the avg salary by each department.


select * from EMPLOYEE,(select DEPARTMENT_ID, avg(SALARY) as Average  from EMPLOYEE group by department_id) as AVGSAL
where EMPLOYEE.DEPARTMENT_ID =AVGSAL.DEPARTMENT_ID and EMPLOYEE.SALARY > AVGSAL.Average;


select department_id, avg(SALARY) as Average  from EMPLOYEE group by department_id;


--  Questinon 3
-- Write a SQL query to find the number of employees and its location whose salary is greater than or equal to 7000 and less than 10000


select count (EMPLOYEE_ID), LOCATIONS.CITY from EMPLOYEE
inner join DEPARTMENTS
on EMPLOYEE.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
inner join LOCATIONS
on DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID 
where EMPLOYEE.SALARY between 7000 and 9999
group by LOCATIONS.CITY;


-- Questinon 4
-- Fetch max salary, min salary and avg salary by job and department.

-- Info: grouped by department id and job id ordered by department id and max salary




select JOB_ID,DEPARTMENT_ID,max(SALARY) as  max_salary,min(SALARY) as  min_salary,avg(SALARY) as  avg_salary from EMPLOYEE
group by  EMPLOYEE.JOB_ID,EMPLOYEE.DEPARTMENT_ID
order by EMPLOYEE.DEPARTMENT_ID, max_salary desc


-- Questinon 5
-- Write a SQL query to find the total salary of employees whose country_id is ‘US’ excluding whose first name is Nancy


select sum(salary) from EMPLOYEE
inner join DEPARTMENTS
on EMPLOYEE.DEPARTMENT_ID= DEPARTMENTS.DEPARTMENT_ID
inner join LOCATIONS
on DEPARTMENTS.LOCATION_ID=LOCATIONS.LOCATION_ID
where LOCATIONS.COUNTRY_ID = 'US' and FIRST_NAME not like 'Nancy';


select sum(salary) from EMPLOYEE
where EMPLOYEE.DEPARTMENT_ID in
(select DEPARTMENT_ID from departments
where location_id in(
select LOCATION_ID from LOCATIONS
where COUNTRY_ID = 'US'))and FIRST_NAME not like 'Nancy';


-- Questinon 6
-- Fetch max salary, min salary and avg salary by job id and department id but only for folks who worked in more than one role(job) in a department
where (JOB_ID,DEPARTMENT_ID) in (
select JOB_ID,DEPARTMENT_ID from EMPLOYEE
EMPLOYEE.JOB_ID,


select  JOB_ID,DEPARTMENT_ID,max(SALARY) as  max_salary,min(SALARY) as  min_salary,avg(SALARY) as  avg_salary from EMPLOYEE
group by DEPARTMENT_ID, JOB_ID 
having count(*)>1
order by  DEPARTMENT_ID;

-- checking
select JOB_ID,DEPARTMENT_ID from EMPLOYEE
group by EMPLOYEE.DEPARTMENT_ID,JOB_ID
having count(distinct DEPARTMENT_ID)>1

-- checking
select first_name,last_name, count(first_name),count(last_name),EMPLOYEE.DEPARTMENT_ID  from EMPLOYEE
group by EMPLOYEE.DEPARTMENT_ID,first_name,last_name;


-- Questinon 7

-- Display the employee count in each department and also in the same result.

-- Info: * the total employee count categorized as "Total"

-- · the null department count categorized as "-" 

(select  IFNULL(cast(EMPLOYEE.DEPARTMENT_ID as varchar), '-') as departments,count(EMPLOYEE.EMPLOYEE_ID)as Total from EMPLOYEE
group by EMPLOYEE.DEPARTMENT_ID
order by EMPLOYEE.DEPARTMENT_ID)
union
(select 'total',count(*)from EMPLOYEE)


-- Questinon 8
-- Display the jobs held and the employee count.

select EMPLOYEE.JOB_ID as "Jobs Held", count(EMPLOYEE.EMPLOYEE_ID) as EmpCount  from EMPLOYEE
group by JOB_HISTORY.JOB_ID



    select jobs_held, count(JP.EMPLOYEE_ID) 
    from 
    (select EMPLOYEE.EMPLOYEE_ID, count(EMPLOYEE.EMPLOYEE_ID) as jobs_held
    from EMPLOYEE
    left join JOB_HISTORY
    on EMPLOYEE.EMPLOYEE_ID = JOB_HISTORY.EMPLOYEE_ID
    group by EMPLOYEE.EMPLOYEE_ID) as JP
    group by JP.jobs_held;





-- Questinon 9
-- Display average salary by department and country.

select DEPARTMENTS.DEPARTMENT_ID,COUNTRIES.COUNTRY_NAME,avg(SALARY) from EMPLOYEE
inner join DEPARTMENTS
on DEPARTMENTS.DEPARTMENT_ID = EMPLOYEE.DEPARTMENT_ID
inner join LOCATIONS
on DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
inner join COUNTRIES
on LOCATIONS.COUNTRY_ID =COUNTRIES.COUNTRY_ID
group by DEPARTMENTS.DEPARTMENT_ID, COUNTRIES.COUNTRY_NAME
order by DEPARTMENTS.DEPARTMENT_ID;

-- Questinon 10
-- Display manager names and the number of employees reporting to them by countries (each employee works for only one department, and each department belongs to a country)

select EMPLOYEE.FIRST_NAME as manager_name, EMPLOYEE.EMPLOYEE_ID as man_id,country_name, emp_count   from EMPLOYEE
inner join 
(select EMPLOYEE.MANAGER_ID as mngid,COUNTRIES.COUNTRY_NAME as country_name, count(EMPLOYEE.EMPLOYEE_ID) as emp_count from EMPLOYEE
inner join DEPARTMENTS
on DEPARTMENTS.DEPARTMENT_ID = EMPLOYEE.DEPARTMENT_ID
inner join LOCATIONS
on DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
inner join COUNTRIES
on COUNTRIES.COUNTRY_ID = LOCATIONS.COUNTRY_ID
group by EMPLOYEE.MANAGER_ID,COUNTRIES.COUNTRY_NAME
order by EMPLOYEE.MANAGER_ID
) as manager_table
on manager_table.mngid = EMPLOYEE.MANAGER_ID
;

select EMPLOYEE.MANAGER_ID as mngid,LOCATIONS.COUNTRY_ID, count(EMPLOYEE.EMPLOYEE_ID) from EMPLOYEE
inner join DEPARTMENTS
on DEPARTMENTS.DEPARTMENT_ID = EMPLOYEE.DEPARTMENT_ID
inner join LOCATIONS
on DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
inner join COUNTRIES
on COUNTRIES.COUNTRY_ID = LOCATIONS.COUNTRY_ID
group by EMPLOYEE.MANAGER_ID,LOCATIONS.COUNTRY_ID
order by EMPLOYEE.MANAGER_ID;



select * from EMPLOYEE;


select EMPLOYEE.FIRST_NAME as manager, EMPLOYEE.EMPLOYEE_ID,EMPLOYEE.MANAGER_ID from EMPLOYEE
inner join DEPARTMENTS
on DEPARTMENTS.DEPARTMENT_ID = EMPLOYEE.DEPARTMENT_ID
inner join LOCATIONS
on DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
group by EMPLOYEE.MANAGER_ID,

-- Questinon 11
-- Group salaries of employees in 4 buckets eg: 0-10000, 10000-20000,.. (Like the previous question) but now group by department and categorize it like below.


select DEPARTMENT_ID, 
count(case when SALARY>=0 and SALARY<10000 then 1 end) as "0-10000",
count(case when SALARY>=10000 and SALARY<20000 then 1 end) as "10000-20000", 
count(case when SALARY>=20000 and SALARY<30000 then 1 end) as "20000-30000"
from EMPLOYEE
group by DEPARTMENT_ID
order by DEPARTMENT_ID;


-- Questinon 12

-- Display employee count by country and the avg salary

select count(EMPLOYEE_ID) as employeCount,avg(SALARY) as average,COUNTRIES.COUNTRY_NAME from EMPLOYEE
inner join DEPARTMENTS
on DEPARTMENTS.DEPARTMENT_ID = EMPLOYEE.DEPARTMENT_ID
inner join LOCATIONS
on DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
inner join COUNTRIES
on LOCATIONS.COUNTRY_ID= COUNTRIES.COUNTRY_ID
group by COUNTRIES.COUNTRY_NAME;




-- Questinon 13
-- Display region and the number off employees by department


select DEPARTMENTS.DEPARTMENT_ID,COALESCE(REGIONS.REGION_NAME, '-') AS region,COUNT(*) AS num_employees from EMPLOYEE
inner join DEPARTMENTS
on DEPARTMENTS.DEPARTMENT_ID = EMPLOYEE.DEPARTMENT_ID
inner join LOCATIONS
on DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
inner join COUNTRIES
on LOCATIONS.COUNTRY_ID= COUNTRIES.COUNTRY_ID
inner join REGIONS
on COUNTRIES.REGION_ID = REGIONS.REGION_ID
group by DEPARTMENTS.DEPARTMENT_ID,REGIONS.REGION_NAME
order by DEPARTMENTS.DEPARTMENT_ID


select DEPARTMENTS.DEPARTMENT_ID,
coalesce(cast (sum(case when REGIONS.REGION_NAME = 'United States' then 1 else 0 end) as varchar ), '-') as "United States",
coalesce(cast (sum(case when REGIONS.REGION_NAME = 'Europe' then 1 else 0 end)as varchar ), '-') as Europe,
coalesce(cast (sum(case when REGIONS.REGION_NAME = 'Asia' then 1 else 0 end)as varchar ), '-') as Asia
from EMPLOYEE
inner join DEPARTMENTS
on DEPARTMENTS.DEPARTMENT_ID = EMPLOYEE.DEPARTMENT_ID
inner join LOCATIONS
on DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
inner join COUNTRIES
on LOCATIONS.COUNTRY_ID= COUNTRIES.COUNTRY_ID
inner join REGIONS
on COUNTRIES.REGION_ID = REGIONS.REGION_ID
group by DEPARTMENTS.DEPARTMENT_ID






-- Questinon 14
-- Select the list of all employees who work either for one or more departments or have not yet joined / allocated to any department

select EMPLOYEE.FIRST_NAME,EMPLOYEE.LAST_NAME,coalesce(cast(EMPLOYEE.DEPARTMENT_ID as varchar),'Not yet joined' ) from EMPLOYEE
group by EMPLOYEE.EMPLOYEE_ID,EMPLOYEE.DEPARTMENT_ID,EMPLOYEE.FIRST_NAME,EMPLOYEE.LAST_NAME
order by EMPLOYEE.EMPLOYEE_ID;



-- Questinon 15
-- write a SQL query to find the employees and their respective managers. Return the first name, last name of the employees and their managers



select concat (EMPLOYEE.FIRST_NAME,' ',EMPLOYEE.LAST_NAME) as EmployeeName,EMPLOYEE.MANAGER_ID as mngid ,manager_name from EMPLOYEE
inner join
(select EMPLOYEE.FIRST_NAME as manager_name, EMPLOYEE.EMPLOYEE_ID as man_id   from EMPLOYEE)
on mngid = man_id
order by EmployeeName;


select EMPLOYEE.MANAGER_ID as mngid,COUNTRIES.COUNTRY_NAME as country_name, count(EMPLOYEE.EMPLOYEE_ID) as emp_count from EMPLOYEE
inner join DEPARTMENTS
on DEPARTMENTS.DEPARTMENT_ID = EMPLOYEE.DEPARTMENT_ID
inner join LOCATIONS
on DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
inner join COUNTRIES
on COUNTRIES.COUNTRY_ID = LOCATIONS.COUNTRY_ID
group by EMPLOYEE.MANAGER_ID,COUNTRIES.COUNTRY_NAME
order by EMPLOYEE.MANAGER_ID



-- Questinon 16
-- write a SQL query to display the department name, city, and state province for each department.


select DEPARTMENTS.DEPARTMENT_NAME,LOCATIONS.CITY,LOCATIONS.STATE_PROVINCE from EMPLOYEE
inner join DEPARTMENTS
on DEPARTMENTS.DEPARTMENT_ID = EMPLOYEE.DEPARTMENT_ID
inner join LOCATIONS
on DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID


-- Questinon 17
-- . write a SQL query to list the employees (first_name , last_name, department_name) who belong to a department or don't
-- 
select EMPLOYEE.FIRST_NAME,EMPLOYEE.LAST_NAME,DEPARTMENTS.DEPARTMENT_NAME, iff(EMPLOYEE.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID,'Belong to','Not belong to') from EMPLOYEE
inner join DEPARTMENTS
on EMPLOYEE.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID


select EMPLOYEE.FIRST_NAME,EMPLOYEE.LAST_NAME,DEPARTMENTS.DEPARTMENT_NAME, iff(EMPLOYEE.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID,'Belong to','Not belong to') from EMPLOYEE
inner join DEPARTMENTS



select EMPLOYEE.FIRST_NAME,EMPLOYEE.LAST_NAME,D.DEPARTMENT_NAME from EMPLOYEE
left outer join DEPARTMENTS D 
on EMPLOYEE.DEPARTMENT_ID = D.DEPARTMENT_ID

-- Questinon 18
-- The HR decides to make an analysis of the employees working in every department. Help him to determine the salary given in average per department and the total number of employees working in a department. List the above along with the department id, department name


select DEPARTMENTS.DEPARTMENT_ID,DEPARTMENTS.DEPARTMENT_NAME,count(EMPLOYEE.EMPLOYEE_ID),avg(EMPLOYEE.SALARY) from EMPLOYEE
inner join DEPARTMENTS
on DEPARTMENTS.DEPARTMENT_ID = EMPLOYEE.DEPARTMENT_ID
group by DEPARTMENTS.DEPARTMENT_ID,DEPARTMENTS.DEPARTMENT_NAME
order by DEPARTMENTS.DEPARTMENT_ID

select * from EMPLOYEE;
select * from DEPARTMENTS;
select * from LOCATIONS;
select * from COUNTRIES;
select * from REGIONS;
select * from JOBS;
select * from JOB_HISTORY;


-- Questinon 19
-- Write a SQL query to combine each row of the employees with each row of the jobs to obtain a consolidated results.

select * from EMPLOYEE
cross join JOBS;




-- Questinon 20
-- Write a query to display first_name, last_name, and email of employees who are from Europe and Asia
select EMPLOYEE.FIRST_NAME,EMPLOYEE.PHONE_NUMBER,EMPLOYEE.EMAIL,REGIONS.REGION_NAME
from EMPLOYEE
inner join DEPARTMENTS
on DEPARTMENTS.DEPARTMENT_ID = EMPLOYEE.DEPARTMENT_ID
inner join LOCATIONS
on DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
inner join COUNTRIES
on LOCATIONS.COUNTRY_ID= COUNTRIES.COUNTRY_ID
inner join REGIONS
on COUNTRIES.REGION_ID = REGIONS.REGION_ID
where REGIONS.REGION_NAME in ('Asia','Europe')


-- Questinon 21
-- Write a query to display full name with alias as FULL_NAME (Eg: first_name = 'John' and last_name='Henry' - full_name = "John Henry") who are from oxford city and their second last character of their last name is 'e' and are not from finance and shipping department.

 
select concat(EMPLOYEE.FIRST_NAME,' ',EMPLOYEE.LAST_NAME) as FULL_NAME from EMPLOYEE
inner join DEPARTMENTS
on DEPARTMENTS.DEPARTMENT_ID = EMPLOYEE.DEPARTMENT_ID
inner join LOCATIONS
on DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
where LOCATIONS.CITY='Oxford' and 
FULL_NAME like '%e_'and 
not DEPARTMENTS.DEPARTMENT_NAME in('Finance','Shipping')




-- Questinon 22
-- Display the first name and phone number of employees who have less than 50 months of experience

select EMPLOYEE.FIRST_NAME, EMPLOYEE.PHONE_NUMBER from EMPLOYEE
inner join JOB_HISTORY
on EMPLOYEE.EMPLOYEE_ID = JOB_HISTORY.EMPLOYEE_ID
where months_between(JOB_HISTORY.START_DATE,JOB_HISTORY.END_DATE)<50



-- Questinon 23
-- Display Employee id, first_name, last name, hire_date and salary for employees who has the highest salary for each hiring year. (For eg: John and Deepika joined on year 2023, and john has a salary of 5000, and Deepika has a salary of 6500. Output should show Deepika’s details only).

select FIRST_NAME,LAST_NAME,HIRE_DATE,SALARY 
from EMPLOYEE e1 
where SALARY =(SELECT max(salary) FROM EMPLOYEE e2
WHERE EXTRACT(YEAR FROM e1.HIRE_DATE) = EXTRACT(YEAR FROM e2.HIRE_DATE))
order by e1.HIRE_DATE





