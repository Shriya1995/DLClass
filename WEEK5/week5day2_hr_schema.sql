use hr;
show TABLES;
desc regions;
desc countries;
desc jobs;
desc job_history;
SELECT * FROM regions;
SELECT * FROM countries;
SELECT * FROM locations;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM jobs;
SELECT * FROM job_history;
SELECT employee_id,first_name,salary FROM employees WHERE salary>20000;
SELECT last_name,salary,salary+300 FROM employees;
SELECT first_name,salary,salary*12 FROM employees;
SELECT first_name,salary,salary*12+500 FROM employees;
SELECT first_name,last_name,(salary+100)*12 FROM employees;
SELECT first_name,last_name,(salary+100)*12 as Annual_Salary FROM employees;
SELECT first_name,last_name,(salary+100)*12 Annual_Salary FROM employees;
SELECT first_name,last_name,(salary+100)*12 "Annual_Salary" FROM employees;
SELECT first_name,last_name,(salary+100)*12 "ANNUAL_SALARY" FROM employees;
SELECT CONCAT(first_name," ",last_name) AS Full_Name FROM employees;
SELECT CONCAT(first_name," works as ",job_id," IN DEPT ",department_id) FROM employees;
SELECT CONCAT(first_name," works as ",job_id," IN DEPT ",department_id) AS employee_desc FROM employees;
SELECT distinct job_id FROM employees;
SELECT distinct department_id,job_id FROM employees;
# Today's Date and time
SELECT NOW();
SELECT SYSDATE();
SELECT CURDATE();
SELECT CURTIME();
SELECT CURRENT_DATE();
SELECT 3000*35000;

SELECT * FROM employees;
SELECT last_name,salary*12 as Annual_Salary FROM employees WHERE hire_date="1987-01-01";
SELECT last_name,salary*12 as Annual_Salary FROM employees WHERE last_name="livingston";
SELECT * FROM employees where salary*12 >10000;
SELECT first_name,last_name,salary*12 "Annual_salary" from employees where Annual_Salary>12000;
SELECT first_name,last_name,salary*12 "Annual_salary" from employees where (Salary*12)>12000;
SELECT last_name,salary from employees where salary>10000 and department_id=90;
SELECT last_name,salary from employees where salary>10000;
SELECT last_name,salary from employees where salary>10000 or department_id=90;
SELECT last_name,salary from employees where department_id=60;
SELECT * from employees where salary>10000 and (department_id=80 or department_id=90);
SELECT * from employees where salary>10000 and department_id=80;
SELECT * from employees where employee_id in (150,160);
SELECT * from employees where hire_date>"2008-01-01";
SELECT hire_date from employees;
SELECT * FROM jobs where min_salary>10000;
SELECT last_name,salary from employees where salary between 10000 AND 25000;
SELECT job_title,max_salary-min_salary from jobs where max_salary between 10000 and 20000;
SELECT * from employees where commission_pct is null and salary between 5000 and 10000 and department_id=30;
# LIKE OPERATOR : PATTERN MATCHER
SELECT * from employees where first_name like "S%";   #LIKE TO KNOW FIRST NAME STARTS WITH S.
SELECT * from employees where first_name like "%S"; #LAST
SELECT * from employees where first_name like "%S%"; #BETWEEN
SELECT * from employees where first_name like "_S%"; #SECOND CHAR IS S
SELECT * from employees where first_name like "S%" or last_name like "S%";
SELECT * from employees where manager_id is null;
SELECT * from employees where commission_pct is null;
SELECT * from countries;
SELECT * from countries order by region_id;
SELECT * from countries order by region_id desc;
SELECT last_name,job_id,department_id from employees order by first_name;
select employee_id,last_name,salary*12 annsal from employees order by annsal;
SELECT * from employees order by 4; #order by 4th column
SELECT * from employees order by 4,1;
SELECT * from employees order by 3; 
select last_name,job_id,department_id,hire_date from employees order by 3;  #here 3 is choosen from select list
select * from employees order by department_id,salary;
select * from jobs order by job_title desc;
select * from employees order by salary  limit 10;  #only required will be fetched,limit is used. it takes 2 parameters 1. offset 2. no of rows
select * from employees order by salary desc limit 1,10;
select * from employees order by salary limit 49,1;
select * from employees order by salary limit 1,1;
select * from employees order by salary;
select  distinct salary from employees order by salary desc;
select  distinct salary from employees order by salary desc limit 49,1;
select first_name,last_name,job_id,salary from employees where job_id like "%clerk" order by salary desc limit 10;
select round(45.923,-1);
select round(45.923,2);
select truncate(45.999,2);
select truncate(45.923,0);
select truncate(45.923,-1);
select ceil(45.923);
select first_name,salary,round(commission_pct,1) from employees;
select first_name,salary,round(salary,-3) from employees;
select * from employees where first_name="STEVEN";
select upper(first_name) from employees where first_name="steven";
select SUBSTR("HELLOWORLD",1,5);
select LENGTH("HELLOWORLD");
select SUBSTR("HELLOWORLD",7,5);
select SUBSTR("HELLOWORLD",7,-5);
select INSTR("HELLOWORLD","L"); #ALWAYS GIVES FIRST OCCURENCE OF THAT PARTICULAR CHARACTER
select LPAD(salary,10,"*") from employees;
select trim("d" from "helloworld"); #works on extremes , not anything in between
select * from jobs;
select * from employees;
select employee_id, concat(first_name," ",last_name),job_id,length(last_name),INSTR(last_name,"a")
 from employees where job_id like"___REP%" and last_name like"%a%";
select replace(lower(first_name),substr(first_name,2,1),upper(substr(first_name,2,1))) from employees;

select substring_index(job_title," ",1) from jobs;
select length(first_name) from employees where position("b" in last_name)>3;
select ucase(first_name),lcase(email) from employees where substring_index(email,"@",1)=substring(first_name,1,length(first_name));

# date functions
select last_day("2019-08-13");
select period_diff("201810","201801");
select * from employees;
select * from employees where month(hire_date) = 5;
select * from employees where date_format(hire_date,"%b")="MAY";
select first_name,adddate(last_day(hire_date),1) as first_salary_date from employees;
select * from employees where year(hire_date)=year(now());
select subdate(sysdate()-"2011-01-01") from employees;
select last_name,job_id,salary, case job_id when "IT_PROG" THEN 1.10*salary
											when "ST_CLERK" THEN 1.15*salary
                                            when "SA_REP" THEN 1.20*salary
								else salary END AS revised_salary
                                from employees;
select first_name,round(datediff(now(),hire_date)/365) as exp_in_years from employees;
select first_name from employees where year(hire_date)="2001";
select count(*) as no_of_employees from employees where day(hire_date)>15;

