use hr;
show tables;
select * from employees;
select * from departments where manager_id=NULL;
select concat("This is to certify that ",first_name," ",last_name," ","with employee id  ",employee_id," is working as ",job_id," in dept ",department_id)
from employees where employee_id=123 ;
