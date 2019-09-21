use orders;
show tables;
#1.	Write a Query to display the  product id, product description
#and product  price of products  whose product id  less than 1000 and that have the same price more than once.
#(USE SUB-QUERY)(15 ROWS)[NOTE:PRODUCT TABLE].

select product.product_id, product_desc from product 
where product_price in  (select product_price from product group by product_price having count(product_price)>1 )
and product_id <1000;

#2.Write a query to display product class description ,total quantity(sum(product_quantity),
#Total value (product_quantity * product price) and
#show which class of products have been shipped highest to countries outside India other than USA? Also show the total value of those items.
#(1 ROWS)[NOTE:PRODUCT TABLE,ADDRESS TABLE,ONLINE_CUSTOMER TABLE,ORDER_HEADER TABLE,ORDER_ITEMS TABLE,PRODUCT_CLASS TABLE].

#SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
select * from order_header; 
select * from address;
select * from online_customer;
select * from order_items;


select * from (select  ANY_VALUE(product_class_desc),ANY_VALUE(country)from ORDER_HEADER
join ONLINE_CUSTOMER on ONLINE_CUSTOMER.customer_id = order_header.customer_id
join address on address.address_id = ONLINE_CUSTOMER.address_id
join order_items on order_items.order_id = ORDER_HEADER.order_id
join product on product.product_id = order_items.product_id
join PRODUCT_CLASS on PRODUCT_CLASS.product_class_code = product.product_class_code
where country not in ('INDIA','USA') group by country) as dup limit 1;


#3.Write a query to display the customer id, customer first name, address line 2,city 
#total sales(sum(product quantity * product price (0 if they haven't purchased any item))
#made by customers who stay in the same locality (i.e. same address_line2 & city). (USE SUB-QUERY)
#(4 ROWS)
#[NOTE : ADDRESS,ONLINE_CUSTOMER,ORDER_HEADER,ORDER_ITEMS,PRODUCT].

select any_value(ONLINE_CUSTOMER.customer_id),any_value(customer_fname),any_value(address_line2),any_value(city) from address 
left join ONLINE_CUSTOMER on address.address_id = ONLINE_CUSTOMER.address_id
left join order_header on ONLINE_CUSTOMER.customer_id = order_header.customer_id
left join order_items on order_items.order_id = ORDER_HEADER.order_id
left join product on product.product_id = order_items.product_id
left join PRODUCT_CLASS on PRODUCT_CLASS.product_class_code = product.product_class_code
where address.address_line2 in (select address.address_line2  from address 
group by address_line2 
having count(address.address_id) >1) group by ONLINE_CUSTOMER.customer_id;

## In the above query coalesce is used to get 0 instead of null in the output if a particular customer has not purchased anything ... 

# 4.	Write a Query to display product id,product description,totalquantity(sum(product quantity) For a given item whose 
# product id is 201 and which item has been bought along with it  maximum no. of times.

select product_id, sum(product_quantity) as total_quan from order_items where order_id in
(select order_id from order_items join product on product.PRODUCT_ID = order_items.PRODUCT_ID
where order_items.PRODUCT_ID = 201)
group by product_id order by total_quan DESC limit 1;

# 5.	Write a Query to display the month,total quantity(sum(product quantity)) 
# and show during which month of the year do foreign customers tend to buy max. no. of products.

select month(order_date), sum(product_quantity) as total_quan from address
join online_customer on address.address_id = online_customer.address_id
join order_header on online_customer.customer_id = order_header.customer_id
join order_items on order_header.ORDER_ID = order_items.ORDER_ID
where country not in (select country from address where country = 'India')
group by month(order_date) order by total_quan DESC limit 1;

# 6.	Write a Query to display customer id,customer firstname,lastname,order status,total value(sum(product quantity * product price)) 
# and show who is the most valued customer (customer who made the highest sales)

select online_customer.CUSTOMER_ID, customer_fname, customer_lname, order_status, sum(product_quantity*product_price) as Total_Value from online_customer
join order_header on online_customer.CUSTOMER_ID = order_header.CUSTOMER_ID
join order_items on order_header.ORDER_ID = order_items.ORDER_ID
join product on order_items.PRODUCT_ID = product.PRODUCT_ID
where order_header.ORDER_STATUS = 'Shipped'
group by CUSTOMER_ID order by Total_Value DESC limit 1;

# 7.	Write a query to display product class code,product class desc,
# product id product description,product price and show the most expensive products in their respective classes.

select any_value(product_class.product_class_code),any_value(product_class_desc),any_value(product_id),any_value(product_desc), 
max(product_price) from product_class
join product on product_class.PRODUCT_CLASS_CODE = product.PRODUCT_CLASS_CODE
group by product_class.PRODUCT_CLASS_CODE;

# 8.	Write a query to display shipper id,shipper name , (len*width*height*product_quantity) as total volume 
# shipped and show Which shipper has shipped highest volume of items.

select any_value(shipper.shipper_id), any_value(shipper_name), any_value((len*width*height*product_quantity)) as Total_Volume from shipper
join order_header on shipper.SHIPPER_ID = order_header.SHIPPER_ID
join order_items on order_header.ORDER_ID = order_items.ORDER_ID
join product on order_items.PRODUCT_ID = product.PRODUCT_ID
group by shipper.shipper_id order by Total_Volume DESC limit 1;

# 9.	Write a query to display  carton id ,(len*width*height) as carton_vol and identify the optimum carton 
# (carton with the least volume whose volume is greater than the total volume of all items) for a given order whose 
# order id is 10006 , Assume all items of an order are packed into one single carton (box)


select carton_id, (c.len*c.width*c.height) as carton_vol from carton c
where (c.len*c.width*c.height) >= (select sum(p.len*p.width*p.height) from order_items
join product p on p.product_id = order_items.product_id
where order_id = 10006)
order by carton_vol limit 1;

# 10.	Write a query to display product id,product description,total_quantity (sum(order_quantity) ,   
 # Provided show the most and least sold products (quantity-wise).


(select product.product_id, product_desc, sum(product_quantity) as Total_Quan from product
join order_items on product.PRODUCT_ID = order_items.PRODUCT_ID
join order_header on order_items.ORDER_ID = order_header.ORDER_ID
group by PRODUCT_ID order by Total_Quan DESC limit 1)
union all
(select product.product_id, product_desc, sum(product_quantity) as Total_Quan from product
join order_items on product.PRODUCT_ID = order_items.PRODUCT_ID
join order_header on order_items.ORDER_ID = order_header.ORDER_ID
group by PRODUCT_ID order by Total_Quan limit 1);






