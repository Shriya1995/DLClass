show tables;

# 1.	Write a query to display emp_name, state, age of an employee whose dept_id = 1

select emp_name, state from hired natural join department where dep_id in (select
dep_id from department where dep_id=1);

select * from customer;
select * from department;
select * from hired;


# 2. Write a query to display the dept_id, maximum salary, provided show the 
# departments whose maximum salary is less than the average salary.

select dep_id, max(salary) from salary group by dep_id having max(salary) < all (select avg(salary) from salary);


# 3. Write a query to display emp_id,dept_id of the employees whose salary is higher than emp_id = 02.

select emp_id,dep_id from salary where salary > all  (select salary from salary where emp_id = 2);


# 4.	Write a query to display emp_id,salary of the employees whose salary ranges from minimum salary to 35000.

select emp_id, salary from salary where salary = any (select salary from salary group by emp_id having salary between min(salary) and 35000);


use day3_inclass;
show tables;

# 5.	Write a query to display the cust_id,first_name,
# last_name,sales_id who have not purchased any product or made any sales.

select * from customer where cust_id not in (select cust_id from orders natural join customer);


# 6.	Write a query to display cust_id,first_name,last_name
# Of the customers whose second letter start with ‘a’


select cust_id, first_name, last_name from customer where last_name in (select last_name from customer where last_name like '_a%');


# 7.	Write a query to display the product_name,product_id,
# Price, provided show the second highest priced product.

select product_id, product_name, price, rank() over (order by price DESC) ranking from product;

# 8.	Write a Query to display the product_id,product_name and list 
# which of the other products were  bought apart from ‘P01’

select product_id, product_name from product where PRODUCT_ID not in (select PRODUCT_ID from product where product_id = 'P01');

# 9.	Write a query to display the product_id,product_name,
# order_quantity and list which of the other products were  bought apart from ‘P01’ provided 
# their total order_quantity bought is greater than 75.

select product_id, product_name, order_quantity from orders natural join product
where PRODUCT_ID not in (select PRODUCT_ID from product natural join orders where product_id = 'P01') and order_quantity>75;

# 10.	Write a query to display product_id,product_name,
 # total_quantity(sum(order_quantity) , Provided find the      
 # most and least sold products (quantity-wise).

select p.product_id, product_name, order_quantity from product p natural join orders o where order_quantity = (select max(order_quantity) from orders
where p.product_id = o.product_id)
union all
select p.product_id, product_name, order_quantity from product p natural join orders o where order_quantity = (select min(order_quantity) from orders
where p.product_id = o.product_id);