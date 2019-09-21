use orders;
show tables;
select * from product;
#1 1.	Write a query to Display the product details (product_class_code, product_id, product_desc, product_price,) as per the following criteria and sort them in descending order of category:
#a.	If the category is 2050, increase the price by 2000
#b.	If the category is 2051, increase the price by 500
#c.	If the category is 2052, increase the price by 600.

select product_class_code,product_id,product_desc,product_price,
case when product_class_code=2050 then product_price+2000
	when product_class_code=2051 then product_price+500
    when product_class_code=2052 then product_price+600
end 
from product order by product_class_code desc;

# 2.	Write a Query to display the  the product description, product class description and product price of all products
# which are shipped.(168 rows)
#[NOTE : TABLE TO BE USED:PRODUCT_CLASS,PRODUCT, ORDER_ITEMS,ORDER_HEADER]

select * from order_header;
select product_desc,product_class_desc,product_price from ORDER_HEADER OH
join order_items OI on OI.order_id = OH.order_id
join product P on P.product_id = OI.product_id
join PRODUCT_CLASS on PRODUCT_CLASS.product_class_code = P.product_class_code
where order_status = 'Shipped';

#3.Write a query to display the  customer_id,customer name, email and order details
# (order id, product desc,product  qty, subtotal(product_quantity * product_price))
# for all customers even if they have not ordered any item.(225 ROWS) 
#[NOTE : TABLE TO BE USED - online_customer, order_header, order_items, product].

show tables;
select OC.customer_id,concat(customer_fname,customer_lname) as customername ,customer_email,OH.order_id,
product_desc,product_class_code,(product_quantity * product_price) as sub_total 
from online_customer OC
left join order_header OH on OC.customer_id=OH.customer_id
left join order_items OI on OI.order_id=OH.order_id
left join product P on P.product_id=OI.product_id;

#4. 1.	Write a query to display the customer_id,customer full name ,city,pincode,and order details
#(order id,order date, product class desc, product desc, subtotal(product_quantity * product_price))
#for orders shipped to cities whose pin codes do not have any 0s in them.
#Sort the output on customer name, order date and subtotal.(52 ROWS)
#[NOTE : TABLE TO BE USED - online_customer, address, order_header, order_items, product, product_class].


select OC.customer_id,concat(customer_fname,customer_lname) as customername,city,pincode,customer_email,OH.order_id,
product_desc,P.product_class_code,(product_quantity * product_price) as sub_total
from online_customer OC
join order_header OH on OC.customer_id=OH.customer_id
join order_items OI on OI.order_id=OH.order_id
join product P on P.product_id=OI.product_id
join product_class PC ON PC.product_class_code=P.product_class_code
join address AD on AD.address_id=OC.address_id
where order_status="shipped" and pincode not like ("%0%")
order by customername,order_date,sub_total;

#5.	Write a query to display (customer id,customer fullname,city)
#of customers  from outside ‘Karnataka’ who haven’t bought any toys or books.(19 ROWS)
#[NOTE : TABLES TO BE USED – online_customer, address,       
#order_header, order_items, product, product_class].

select OC.customer_id,concat(customer_fname,customer_lname) as customername,city
from online_customer OC
join order_header OH on OC.customer_id=OH.customer_id
join order_items OI on OI.order_id=OH.order_id
join product P on P.product_id=OI.product_id
join product_class PC ON PC.product_class_code=P.product_class_code
join address AD on AD.address_id=OC.address_id
where state!="Karnataka" and order_status="shipped" and PC.product_class_code not in (2051,2054)
group by (customer_id);

 select * from product_class;

#6.Write a query to display  details (customer id,customer fullname,order id,product quantity)
#of customers who bought more than ten (i.e. total order qty) products per order.(11 ROWS)
#[NOTE : TABLES TO BE USED - online_customer, order_header, order_items].

select OC.customer_id,concat(customer_fname,customer_lname) as customername,OH.order_id,sum(product_quantity) as total_quantity
from online_customer OC
join order_header OH on OC.customer_id=OH.customer_id
join order_items OI on OI.order_id=OH.order_id
where order_status="shipped"
group by OC.customer_id,OH.order_id
having total_quantity>10;

#7. 1.	Write a query to display the customer full name and total order value
#(product_quantity*product_price) of premium customers
#(i.e. the customers who bought items total worth > Rs. 1 lakh.)(2 ROWS)
#[ NOTE : TABLES TO BE USED – ONLINE_CUSTOMER,ORDER_HEADER,
#ORDER_ITEMS,PRODUCT]

select OC.customer_id,concat(customer_fname,customer_lname) as customername, sum(product_quantity*product_price) as total_order_value
from online_customer OC
join order_header OH on OC.customer_id=OH.customer_id
join order_items OI on OI.order_id=OH.order_id
join product P on P.product_id=OI.product_id
where order_status="shipped"
group by customer_id
having total_order_value>100000;

#8.Write a query to display the customer id and customer full name of customers
#along with (product_quantity) as total quantity of products ordered for order ids > 10060.(6 ROWS)
#[NOTE : TABLES TO BE USED - online_customer, order_header, order_items].

select OC.customer_id,concat(customer_fname,customer_lname) as customername,sum(product_quantity) as total_quantity
from online_customer OC
join order_header OH on OC.customer_id=OH.customer_id
join order_items OI on OI.order_id=OH.order_id
where order_status="shipped"
group by OH.order_id
having order_id>10060;

#9.Write a query to display (product_class_desc, product_id, product_desc, product_quantity_avail )
#and Show inventory status of products as below as per their available quantity:
#a.	For Electronics and Computer categories,
   #if available quantity is < 10, show 'Low stock',
   # 11 < qty < 30, show 'In stock',
   # > 31, show 'Enough stock'
#b.	For Stationery and Clothes categories,
#if qty < 20, show 'Low stock',
# 21 < qty < 80, show 'In stock',
# > 81, show 'Enough stock'
#c.	Rest of the categories, if qty < 15 – 'Low Stock',
#  16 < qty < 50 – 'In Stock',
#  > 51 – 'Enough stock'
#For all categories, if available quantity is 0, show 'Out of    stock'.	
#(60  ROWS)[NOTE : TABLES TO BE USED – product, product_class].

select product_desc,product_class_desc,product_id,product_quantity_avail,product_class.product_class_code,
case 
	 when product_quantity_avail = 0 then 'Out of stock'
	 when product_class.product_class_code in (2050,2053) then 
		  case when product_quantity_avail < 10 then 'Low Stock' 
		  	   when product_quantity_avail <30 and product_quantity_avail >11 then 'In Stock' 
		       else 'Enough Stock' end
     when product_class.product_class_code in (2056,2052) then 
		  case when product_quantity_avail < 20 then 'Low Stock' 
		  	   when product_quantity_avail <80 and product_quantity_avail >21 then 'In Stock' 
		       else 'Enough Stock' end
     else  
		  case when product_quantity_avail < 15 then 'Low Stock' 
		  	   when product_quantity_avail <50 and product_quantity_avail >16 then 'In Stock' 
		       else 'Enough Stock' end
end as someOthers
from product join PRODUCT_CLASS on product_class.product_class_code = product.product_class_code;











