use hr;
show tables;
select * from employees;
# List all IT related departments where there are no managers .(
#1
select * from departments where manager_id is not NULL;
#2
select concat("This is to certify that ",first_name," ",last_name," ","with employee id  ",employee_id," is working as ",job_id," in dept ",department_id)
from employees where employee_id=123 ;

#3
select employee_id,salary,
case when salary<5000 then 'Tier1' 
	 when salary>5000 and salary <10000 then 'Tier2'
	 else 'Tier3'
end  as salrange
from employees
order by salrange asc;

# 4 

select * from employees;
select department_id,job_id,sum(salary) as total_salary from employees group by department_id,job_id having total_salary>25000;

#5
select * from employees
where first_name  RLIKE '^.*[aeiouAEIOU]$' and last_name RLIKE '^.*[aeiouAEIOU]$';

#6
select * from jobs;
select *,max_salary-min_salary as diff from jobs where job_title like '%manager%' or job_title like '%clerk%';
select *,max_salary-min_salary as diff from jobs where job_title like '%manager%' or job_title like '%clerk%' group by job_title like '%manager%';



#7

select * from locations;
select location_id,city from locations
where country_id in ("US","UK")
and city like ("S%") AND city not like ("South%");

#8
use orders;
show tables;
select * from ONLINE_CUSTOMER;
select * from ONLINE_CUSTOMER where customer_creation_date<date("2006-01-12") and
(customer_email like ("%gmail%") or customer_email like ("%yahoo%")) and
customer_username like ("dave%");

#9
select * from product;
select product_id,product_desc,(product_price*product_quantity_avail) as worth from PRODUCT;

#10
select * from online_customer;
select concat(CUSTOMER_FNAME,CUSTOMER_LNAME,"(",CUSTOMER_USERNAME,") created on",CUSTOMER_CREATION_DATE,".Contact Phone:",CUSTOMER_PHONE," E-mail: ",CUSTOMER_EMAIL) as custDetails from ONLINE_CUSTOMER
where CUSTOMER_PHONE like '%77%' and customer_email like '%gmail%';

#11
use hr;
show tables;
select * from locations;
select count(city) as cnt,country_id from locations
where country_id not in ("US","UK")
group by country_id having cnt>1 
order by country_id desc;










