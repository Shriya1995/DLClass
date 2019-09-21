create database sk;
use sk;
create table supplier(SNO CHAR(3),SNAME VARCHAR(20),SUP_Status INTEGER(2),CITY VARCHAR(15),WEIGHT INTEGER(3),CONSTRAINT PK_SUPPLIER PRIMARY KEY(SNO));
show tables;

create table parts(PNO CHAR(2),PNAME VARCHAR(20),COLOR INTEGER(3),CITY VARCHAR(15),CONSTRAINT PK_PARTS PRIMARY KEY(PNO));
show tables;

create table sub_parts(SNO CHAR(4),PNO CHAR(4),Quantity INTEGER(3),WEIGHT INTEGER(3),constraint PK_SUB_PARTS primary key(SNO,PNO),
constraint FK_SUPPLY foreign key(SNO) REFERENCES SUPPLIER(SNO),
CONSTRAINT FK_PARTS FOREIGN KEY(PNO) references PARTS(PNO));
describe supplier;
describe parts;
describe sub_parts;
ALTER TABLE supplier ADD (phone integer(10),DOB DATE);
describe supplier;
ALTER TABLE supplier DROP WEIGHT
drop table supplier;
show tables;

