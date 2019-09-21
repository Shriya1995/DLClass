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

drop table hired;
drop table department;
drop table salary;

insert into hired values (01,'Edwin','TN');
insert into hired values (02,'Perk','OR');
insert into hired values (03,'Abhi','AP');
insert into hired values (04,'Arshad','KA');

insert into department values (02,02);
insert into department values (01,01);
insert into department values (01,03);

insert into salary values (01,01,25000);
insert into salary values (02,02,30000);
insert into salary values (03,01,50000);
insert into salary values (04,null,null);


# 1.Write a query to display the dept_id, emp_name, state and salary of only those employees who  have  been assigned a department.

select dep_id, emp_name, state, salary from hired h natural join department d natural join salary s where h.emp_id = d.emp_id and d.emp_id = s.emp_id;

# 2. Write a query to display all the employee names and their salary,dept_id (irrespective of their assignment to a particular department)

select emp_name, salary, dep_id from hired h left join department d natural join salary s on h.emp_id = d.emp_id and d.emp_id = s.emp_id;

# 3. Write a query to display all the records of the department table and the respective employee names assigned to them .

select dep_id, emp_id, emp_name from hired h natural join department d;

# 4. write a query to fetch all the distinct records of emp_id from hired & department table together.

select distinct d.emp_id as Dep, h.emp_id as Hir from hired h left join department d on h.emp_id = d.emp_id; 

# 5. write a query to fetch all the records of emp_id from hired & department table. together.

select * from hired h LEFT join department d on h.emp_id = d.emp_id;

# 6.write a query to display the emp_id,emp_name,salary ,state and whose salary greater than 20000 and belong’s  to the  state  ‘AP’

select distinct h.emp_id, emp_name, salary, state from hired h, salary s where salary>20000 and state = 'AP' and h.emp_id = s.emp_id;

# 7.write a query to display the emp_id, emp_name , salary, state and whose salary greater than 10000 and  less than
# 30000  and belongs to the state  ‘TN’,’OR’.

select distinct h.emp_id, emp_name, salary, state from hired h, salary s where salary>30000 and state in ('AP','OR') and h.emp_id = s.emp_id;



create table product(product_id varchar(3), product_name varchar(15), price int(5));
create table sales(sales_id int(3), product_id varchar(15));
create table orders(sales_id int(3), cust_id int(3), product_id varchar(3), order_quantity int(3), order_status varchar(15));
create table customer(cust_id int(3), first_name varchar(15), last_name varchar(15), sales_id int(3));



ALTER TABLE product ADD CONSTRAINT PK_prod PRIMARY KEY (product_id);
ALTER TABLE sales ADD CONSTRAINT pk_sales PRIMARY KEY (product_id);
ALTER TABLE sales ADD FOREIGN KEY (product_id) REFERENCES product(product_id);
ALTER TABLE customer ADD CONSTRAINT PK_cust PRIMARY KEY (cust_id);
ALTER TABLE orders ADD CONSTRAINT PK_orders PRIMARY KEY (cust_id, product_id);
ALTER TABLE orders ADD FOREIGN KEY (cust_id) REFERENCES customer(cust_id);
ALTER TABLE orders ADD FOREIGN KEY (product_id) REFERENCES product(product_id);


insert into product values ('P01','BISCUITS',10);
insert into product values ('P02','CHOCOLATES',20);
insert into product values ('P03','BREAD',15);
insert into product values ('P04','BUTTER',30);

insert into sales values (02,'P02');
insert into sales values (01,'P01');
insert into sales values (01,'P03');

insert into customer values (101,'Harry','Dany',02);
insert into customer values (102,'Tom','Adein',01);
insert into customer values (103,'Marina','paul',01);
insert into customer values (104,'peter','kevin',02);
insert into customer values (105,'David','warner',null);

insert into orders values (02,101,'P02',100,'Shipped');
insert into orders values (01,102,'P01',130,'Shipped');
insert into orders values (01,103,'P03',25,'Cancelled');
insert into orders values (02,104,'P01',50,'Cancelled');


# 8.write a query to display cust_id,full name along with total quantity of products ordered 
# for sales ids  greater than 1 and order_status is cancelled.

select c.cust_id, concat(first_name,' ',last_name) as Name, sum(order_quantity) as Total_Quan
from customer c natural join orders o where sales_id>1 and order_status = 'Cancelled';


# 9. Write a query to Show distinct records of customer_id, full name and total order value of 
# premium customers (i.e. the customers who bought items total worth greater than RS.1000 )

select c.cust_id, concat(first_name,' ',last_name) as Name, sum(order_quantity*price) as Order_Value
from customer c natural join orders o natural join product group by c.cust_id having Order_Value>1000;


# 10. write a query to display the List out customers who haven’t bought any ‘bread’ or ‘butter’.

select cust_id from orders natural join product where product_name not in ('bread','butter');




