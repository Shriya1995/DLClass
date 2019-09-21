create database day3_inclass;
use day3_inclass;

create table hired(emp_id int(2), emp_name varchar(15), state char(2));
create table department(dep_id int(2), emp_id int(2));
create table salary(emp_id int(2), dep_id int(2), salary int(8));

ALTER TABLE hired ADD CONSTRAINT PK_hired PRIMARY KEY (emp_id);
ALTER TABLE department ADD CONSTRAINT pk_dep PRIMARY KEY (emp_id);
ALTER TABLE department ADD FOREIGN KEY (emp_id) REFERENCES hired(emp_id);
ALTER TABLE salary ADD CONSTRAINT PK_sal PRIMARY KEY (emp_id);
ALTER TABLE salary ADD FOREIGN KEY (emp_id) REFERENCES hired(emp_id);

insert into hired values (01,'Edwin','TN');
insert into hired values (02,'Perk','OR');
insert into hired values (03,'Abhi','AP');
insert into hired values (04,'Arshad','KA');

drop table hired;
drop table department;
drop table salary;

insert into department values (02,02);
insert into department values (01,01);
insert into department values (01,03);

insert into salary values (01,01,25000);
insert into salary values (02,02,30000);
insert into salary values (03,01,50000);
insert into salary values (04,null,null);

#1 Write a query to display the dept_id, emp_name, state and salary of only those employees who  have  been assigned a department.

select dep_id, emp_name, state, salary from hired h natural join department d natural join salary s where h.emp_id = d.emp_id and d.emp_id = s.emp_id;

#2. Write a query to display all the employee names and their salary,dept_id 
#(irrespective of their assignment to a particular department).
# Note : [emp_name,salary,dept_id]

select emp_name, salary, dep_id from hired h left join department d natural join salary s on h.emp_id = d.emp_id and d.emp_id = s.emp_id;

#3. Write a query to display all the records of the department table and the respective employee names assigned to them .
#Note : [dept_id,emp_name,salary].

select dep_id, emp_id, emp_name from hired h natural join department d;

