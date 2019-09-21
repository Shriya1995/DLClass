# SUB QUERY:
# when to use: when the value with which we want to compare is not known.

#2 types of sub query: a. sub query that returns that return 1 row as result is called as single row sub query.
# here we use  =,<>,< ,>,<=,>=

# b. sub query that returns more than 1 row as result is called as multi row sub query.
# we use IN,ANY,ALL
# how to know??? when comparing attribute is apart then primary key attribute.since primary key always reflects unique value.
# inner most query is executed first
# specific operator are exists and non exists: we call them boolean operator which gives 0 and 1 or true and false as result.
# co related sub query: 


use hr;
#LIST EMPLOYEES who gets salary same as steven:
select salary from employees where first_name="Steven"; # we get 2 values so use second sub query which uses in,all,any
select *  from employees where salary in (select salary from employees where first_name="Steven");
select * from employees where salary in (select salary from employees where employee_id=100);

#salary of employees who draws higher salary than abel:


select *  from employees where salary > Any (select salary from employees where last_name="Abel");

#find name , job and salary of all emp who gets min salary

select *  from employees where salary = (select min(salary)from employees);
select min(salary) from employees;
select *  from employees where salary = min_salary;



                                       



#LIST EMPLOYEES who gets salary of 14000:
select * from employees where salary=14000;

# list emp who have same job as last name  nayer:
select * from employees where job_id= ANY (select job_id from employees where last_name="Nayer");

#list emp who have same job as last name  nayer but getting salary more than what nayer gets;
select * from employees where job_id = ANY (select job_id from employees where last_name="Nayer")
and salary>(select salary from employees where last_name="Nayer");

#list details of departments managed by den:
select * from departments where manager_id in (select employee_id from employees where first_name="Den");
 
#list jobs into which employees joined in the current year:
select * from jobs where job_id in (select job_id from employees where year(hire_date)=select year(sysdate());

#display details of current job for employees who worked as IT programmer in the past:

select * from employees where job_id IN (select job_id from EMPLOYEES where employee_id IN
(select employee_id from job_history where job_id="IT_PROG"));


#(select employee_id from job_history where job_id="IT_PROG");

#display employees who didnt do any job in the past:
select * from job_history;
###select * from employees e join job_history jh where e.job_id!=jh.job_id;

select * from employees where employee_id NOT IN (select distinct employee_id from job_history);

#display job title and avg salary of jobs for employees who did a job in the past.
select j.job_title,avg(e.salary) from employees e natural join jobs j
where e.job_id=j.job_id
group by j.job_title;

# display depts into which no employee joined in last 20 years:
select * from departments where department_id not in ( select distinct department_id from employees
where datediff(sysdate(),

#result of query below:
select employee_id,first_name from employees where(select min(salary) from employees) group by department_id;


# list depts whose min salary is more than min salary of dept 50.
select min(salary) from employees where department_id=50;
select department_id,min(salary) from employees group by department_id
having min(salary)>(select min(salary) from employees where department_id=50);

# sub queries with sub queries:
#list emp who work other than us and uk:
select * from employees where department_id IN
(select department_id FROM departments where location_id IN
(select location_id from locations 
where country_id NOT IN ("US","UK")));

#list empid,job id, salary of employees other than IT_programmers whose salary is less than any of the IT_PROG's salary:

select employee_id,job_id,salary from employees 
where salary < any(select salary from employees where job_id="IT_PROG") AND 
job_id not in (select job_id from jobs where job_id="IT_PROG");


#LIST details of jobs in which no employee is working:
select job_id from jobs;
select distinct job_id from employees;   #
select * from jobs #
where job_id not in (select distinct job_id from employees);


# list countries that has no departments:
select distinct country_id from locations; #
select country_id from countries;#

select * from countries where country_id not in (select country_id from locations);

# list all departments where there are no employees working:

select * from departments where department_id not in (select distinct department_id from employees);

select department_id from departments;
select distinct department_id from employees;

#list employees who are not managing any departments:
select * from employees
where employee_id not in (select manager_id from departments where manager_id is not null);

#multi column sub query:
#list peers of employee id 123:

select * from employees where employee_id!=123
and (job_id,department_id) IN 
(select job_id,department_id from employees where employee_id=123);


#display first name,dept id,salary and commission pct of any employee whose salary and comm matches both the comm pctt and salary of any emplyee in dept 30.

select first_name,department_id,salary,commission_pct from employees
where (salary, IFNULL(commission_pct,0)) IN 
(select salary,IFNULL(commission_pct,0) from employees where department_id=30);


 #corelated sub query:
#list details of employees who draw more salary than avg salary of their dept and jobs ids:
select * from employees e1
where salary>(select avg(salary) from employees e2 
where e1.department_id=e2.department_id
and e1.job_id=e2.job_id);

#display details of employees drawing highest salary in the department:

select e.department_id,e.first_name,e.salary from employees e 
where e.salary = (select max(salary) from employees b where
b.department_id=e.department_id);

select * from employees  where exists
(select * from employees where 1=2);

select * from employees  where not exists
(select * from employees where 1=2);  #this condition nvr is true so output is overall rows.

#display empid,salary,lastname of employees who are managing other employees:

select employee_id,salary,last_name from employees m where exists
(select  employee_id,salary,last_name from employees e where m.employee_id=e.manager_id);


select employee_id,salary,last_name from employees m where not exists
(select  employee_id,salary,last_name from employees e where m.employee_id=e.manager_id);

# list details of depts that has managers:

#view: a virtual table whch dont have physical existence. why? for faster access. to maintain confidentiality. 
#create view empvu80 view,which contains details of employees in dept 80:
create view dept80_emp AS    #creating a view 
select * from employees where department_id=80;
DESC dept80_emp;
select * from dept80_emp;   # we can use it for operations
select max(salary) from dept80_emp;

#create empview view which contains empid,firstname,jobid,salary,dept_id:
create view empview AS
select * from employees;

desc empview;
select employee_id,first_name,last_name,job_id,salary,department_id from employees;
select max(salary) from employees where department_id=80;

#create a view with regionname,countryname,city,deptname,job_title,empid,firstname,salaryof employees:
create view hr_view AS
select r.region_name,c.country_name,l.city,d.department_name,j.job_title,e.employee_id,e.first_name,e.salary
from regions r natural join countries c
natural join locations l
natural join departments d
natural join employees e
natural join jobs j;

select * from hr_view;
insert into empview 
values (300,"Ram","KUMAR","IT_PROG",5000,10);

create view dept_emp_view1 AS    #creating a view 
select first_name,last_name from employees where department_id=80;
select * from dept_emp_view1;
insert into dept_emp_view1
values("ram","kumar");  
#it is possible to insert to a table through view as well provided none of the columns of the table which isnt in the view or having not null conditions:
 # we can remove/delete 
 
#analytical functions: various func supported by mysql are : rank/dense rank/lead/lag/first/last etc

#Dimension functions:
# roll up : cumulative sum of anything:
# it is an extension to the group by clause. 
# find sum of salary of employees:
select department_id,sum(salary) from employees group by department_id;

select department_id,sum(salary) from employees 
where department_id is not null
group by department_id with rollup;

#cumulative salary of employees dept wise and job wise:

select department_id,job_id,sum(salary) from employees 
where department_id is not null
group by department_id,job_id with rollup;

select department_id,job_id,sum(salary) from employees 
group by department_id,job_id with rollup;

#grouping function: grouping of groups
#grouping sets are a further extension of the group by clause.it takes 1 parameter

select department_id,job_id,sum(salary),
grouping(department_id),grouping(job_id)
from employees group by department_id,job_id with rollup;

#analytic func: basic aggregate func: 
# count:
select last_name,department_id,count(*) 
over (partition by department_id) dept_cnt
from employees
where department_id in (30,40);   

# rank employees based on salaries:
select employee_id,first_name,job_id,salary,
rank() over (order by salary desc) as ranking
from employees;

select employee_id,first_name,job_id,salary,
dense_rank() over (order by salary desc) as ranking
from employees;


# fetch jump in salaries of employees:
# lead and lag concept:
select employee_id,first_name,job_id,salary,lead(salary)
over (order by salary) 
from employees;

select employee_id,first_name,job_id,salary,lag(salary)
over (order by salary) 
from employees;












