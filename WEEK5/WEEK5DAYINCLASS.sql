create database day1_inclass;
use day1_inclass;
create table employee(employee_id int(3),Department_id int(2),Manager_id int(3),first_name varchar(15),last_name varchar(15),
email varchar(15),phone_number int(10),salary int(10));
insert into employee values(100,90,109,"EDWIN","DANY","a@gm",958585858,10000);
insert into employee values(101,90,109,"HARRY","POTTER","B@gm",787878787,20000);
insert into employee values(102,60,101,"EVA","MATE","C@gm",646464646,90000);

select * from employee;

select employee_id,first_name,last_name from employee;

select employee_id,first_name,last_name from employee where salary>20000;

select employee_id,first_name,last_name,email,phone_number,salary from employee where Manager_id=120 or Manager_id=103 or Manager_id=145;

select employee_id,first_name,last_name,Department_id,email,phone_number,salary from employee where Manager_id=120 or Manager_id=103 or Manager_id=145 and salary>8000;

create table products(productID int(4),productCode varchar(3),name varchar(20),quantity int(6),price varchar(6));
insert into products values(1001,"PEN","Pen Red",5000,1.23);
insert into products values(1002,"PEN","Pen Blue",8000,1.25);
insert into products values(1003,"PEN","Pen Black",2000,1.25);
insert into products values(1004,"PEC","Pencil 2B",10000,0.48);
insert into products values(1005,"PEC","Pencil 2H",8000,0.49);

select * from products;

select * from products where quantity<=1000 and quantity>=3000;

select * from products where quantity!=5000 and quantity>5000;

select * from products order by price desc;

create table country(Country_id varchar(4),Name varchar(20),Region_ID int(2),Population int(8),revenue int(15));
insert into country values("AR","Argentina",2,10000,10000000);
insert into country values("NL","Netherlands",1,15000,10000000);
insert into country values("AU","Australia",3,12000,800000);
insert into country values("BE","Belgium",1,23000,3000000);
insert into country values("BR","Brazil",2,11300,2000000);
insert into country values("CA","Canada",2,16500,4600000);
insert into country values("CH","Switzerland",1,30000,2100000);
insert into country values("CN","China",3,40000,1300000);
insert into country values("DE","Germany",1,35000,1200000);
select * from country;

select * from country where revenue<=10000000 and Region_ID=2;

select * from country where Population>10000 and revenue<1500000 order by Population;









