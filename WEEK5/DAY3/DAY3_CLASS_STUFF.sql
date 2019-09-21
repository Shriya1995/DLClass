use hr;
show tables;
select * from employees;
select * from countries;
select avg(salary) from employees;
select avg(salary),max(salary),min(Salary),count(salary),sum(salary) from employees;
select avg(first_name) from employees; #this wont work
select max(first_name) from employees;
select min(first_name) from employees;
select count(first_name) from employees;
select sum(first_name) from employees; #this wont work 
select avg(hire_date),max(hire_date),min(hire_date),count(hire_date),sum(hire_date) from employees;# sum and avg doesnt make sense in dates.
select avg(commission_pct),max(commission_pct),min(commission_pct),count(commission_pct),sum(commission_pct) from employees; #because of null valued
# columns, there is problem in aggregate operations so avoid null valued columns.
# we can avoid this by if null operator.It takes 2 para. ifnull(attribute,substituted value by which you want to replace null values)
#ifnull(commission_pct,0) --> basically replacing null value with 0.

select avg(ifnull(commission_pct,0)) from employees;
select avg(ifnull(commission_pct,1)) from employees; #we can replace with value
select count(department_id) from employees; 
select count(ifnull(department_id,1)) from employees; 
select count(department_id) from departments; #there are 27 depts.
select count(manager_id) from departments; # 11 manager managing 27 dept.
select count(ifnull(manager_id,1)) from departments;
select job_id,avg(salary) as average_salary_of_job_holders from employees group by(job_id); 
# group by is used when we want to combine a non agg column with a agg column.
select department_id,job_id,sum(salary) from employees group by department_id,job_id; 
 #if we are choosing group by, make sure those attributes ae there in select clause.
select manager_id,count(employee_id) from employees group by manager_id;
select manager_id,count(*) from employees group by manager_id; # * also denotes same thing
select year(hire_date),month(hire_date),count(employee_id) from employees group by year(hire_date),month(hire_date);
# Joins: if we want to fetch 1 attr from 1 table and another from another table.
select country_id,count(*) from countries group by country_id;
select department_id,avg(salary) from employees where commission_pct is not null group by department_id;
select * from jobs;
select job_id,count(*),sum(salary),max(salary)-min(salary) from employees group by job_id;
select * from job_history;
select employee_id,max(end_date) from job_history group by employee_id;
select manager_id,count(employee_id) from employees group by manager_id having count(employee_id)>5;
#where was only for display purpose, so not valid here. Use "having" here.A condition used to filter aggregate rows.It is used only with group by.
select department_id,max(salary) from employees group by department_id having max(salary)>1000;
select job_id,count(*) from employees group by job_id having count(*)>10;
select job_id,avg(salary) from employees group by job_id having avg(salary)>10000;
select year(hire_date),count(employee_id) from employees group by year(hire_date) having count(*)>10;
select job_id,count(*) from job_history where datediff(end_date,start_date)>100 group by job_id having count(*)>3;
select department_id,year(hire_date),count(*) from employees group by department_id,year(hire_date);
select employee_id,count(*) from job_history group by employee_id having count(*)>1;

# JOINS : to fetch data from multiple tables:

select * from regions;
select * from countries;
select Region_name,country_name from regions,countries order by region_name;
select * from regions,countries;
select Region_name,country_name from regions R,countries C order by R.region_name=C.region_id;
select * from regions natural join countries;
select * from countries natural join locations;
select * from countries c inner join locations l where c.country_id=l.country_id;  #inner join, it needs a condition
select Region_name,country_name,city from regions natural join countries natural join locations; #3tables
select * from regions natural join countries natural join locations;
select * from regions r natural join countries c natural join locations l where r.region_id=c.region_id and l.country_id=c.country_id; #inner join

select first_name,last_name,department_name from employees natural join departments;
select * from employees natural join departments;

select * from employees E where E.salary>(select min_salary from jobs where job_id="AC_MGR"); #DOUBT

select job_title,avg(salary) from employees natural join jobs group by job_title;
select * from employees;
select job_title,first_name ,max_salary-salary FROM employees natural join jobs;

select job_title,last_name from employees natural join jobs where department_id=30 and commission_pct is not null;


select region_name,department_name from Regions natural join Countries natural join locations natural join Departments; #multiple natural joins

select R.region_name,D.department_name from regions R,countries C,locations L,departments D
where R.Region_ID = C.Region_ID
and C.country_ID=L.country_ID
and L.location_ID=D.location_ID;

select department_name,first_name from departments D join employees E on (D.Manager_ID=E.Employee_ID);
select * from employees;
select first_name from employees e join departments d where d.manager_ID<>E.employee_ID;

select country_name,city,department_name from countries join locations
using(country_ID) JOIN departments
using(location_ID);
select * from EMPLOYEES e WHERE e.employee_ID not in (select d.manager_ID from departments d);
select * from employees;

select A.first_name ,A.last_name 
from employees A,employees B
where A.manager_ID=B.employee_ID;

#list employees whose firstname is same as last name of some employee---> done through self join

select A.first_name ,B.last_name 
from employees A,employees B
where A.first_name=B.last_name;
select * from jobs;

#list details of jobs where max salary = min salary
select A.max_salary ,B.min_salary
from jobs A,jobs B
where A.max_salary=B.min_salary;

# display employee name if the employee joined before his manager:

select A.first_name
from employees A join employees B
on (A.manager_ID=B.employee_ID)
where A.hire_date<B.hire_date;

# list all details of employees who are managers of some departments:

select * from employees E,departments D
where E.employee_ID=D.manager_ID;

#	list details of all employees and details of all departments who are managing or not managing departments:

select * from employees;

select * from employees e left join departments d on d.manager_id =e.department_id;

# list all departments those with and without employees,

select * from  departments d left join employees e on d.department_id=e.department_id;

#job history or not

select * from employees e left join job_history j on e.employee_id=j.employee_id;

# SET OPERATIONS:

select * from employees union select * from departments;
select * from departments;
select * from jobs;
select * from jobs union select * from departments;

# query to get a union of employees managing departments or employees managing other employees:
select manager_id from departments where manager_id is not null union 
select manager_id from employees where manager_id is not null;
#union removes duplicates

select manager_id from departments where manager_id is not null union all
select manager_id from employees where manager_id is not null;

select distinct(manager_id) from departments where manager_id is not null union 
select distinct(manager_id) from employees where manager_id is not null;

#employees who are managers and not managing any employee:

select distinct(manager_id) from departments where manager_id


#list employees whose hiredate or end date is the same:
select * from jobs;
select * from job_history;
select * from employees e,job_history j where e.hire_date=j.end_date;


#list employees whose salary and min salary is same:
select * from employees;

select * from employees where year(hire_date)<"1990";

select last_name,to_char(hire_date,"month","year") as Hire_Date from employees;


select min(last_name),max(last_name) from employees;
select count(*) from employees where department_id=80 and commission_pct is not null;

select department_id,avg(salary) from employees group by department_id order by avg(salary);

select any_value(job_id),sum(salary) from employees where department_id>40 group by department_id order by department_id;
select job_id,sum(salary) as SALARY1 from employees where job_id!="SA_REP" group by job_id  having SALARY1>13000 order by sum(salary);

select department_id,avg(salary) from employees group by department_id order by avg(salary) desc limit 2;

select department_id from departments d natural join locations l where
d.location_id=l.location_id;

select last_name,job_id from employees where job_id  = (select job_id from employees where employee_id=141);













