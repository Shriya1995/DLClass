use hr;
show tables;
select * from locations;
select location_id,city from locations where state_province is null;
select * from jobs;
select * from jobs where max_salary >10000;
select * from departments;
select department_id,department_name,manager_id from departments where manager_id>200 and location_id=2400;
select * from jobs;
select job_title from jobs where min_salary>8000 and max_salary<20000;
select * from departments where location_id=1700 and manager_id is not null;



use orders;

show tables;

select * from product;

select PRODUCT_ID, PRODUCT_DESC, PRODUCT_CLASS_CODE, PRODUCT_PRICE from product
where PRODUCT_CLASS_CODE = 2050 or PRODUCT_CLASS_CODE = 2053 or PRODUCT_CLASS_CODE = 2055; 

select * from order_header;

select CUSTOMER_ID, ORDER_ID, ORDER_DATE, ORDER_SHIPMENT_DATE from order_header
where ORDER_SHIPMENT_DATE is not null order by CUSTOMER_ID, ORDER_DATE desc;

select * from product;

select * from product
where PRODUCT_CLASS_CODE = 2050 and PRODUCT_PRICE>10000 and PRODUCT_PRICE<30000 and PRODUCT_QUANTITY_AVAIL>15;

select * from order_header;

select * from order_header where ORDER_STATUS != 'Shipped';

select * from order_header;

select * from order_header where ORDER_STATUS = 'Shipped' and PAYMENT_MODE = 'Credit Card' or PAYMENT_MODE = 'Net Banking'
and PAYMENT_DATE > '2013-01-01';





