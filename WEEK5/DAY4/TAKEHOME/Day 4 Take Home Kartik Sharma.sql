use orders;
show tables;

# 1.	Write a Query to display the  product id, product description and product  price of products  
# whose product id  less than 1000 and that have the same price more than once.

select product_id, product_desc, product_price from product a
where PRODUCT_ID < 1000 and PRODUCT_PRICE in (select PRODUCT_PRICE from product b group by PRODUCT_PRICE having count(PRODUCT_PRICE)>1);


# 2.	Write a query to display product class description ,total quantity(sum(product_quantity),
# Total value (product_quantity * product price) and show which class of products have been shipped 
# highest to countries outside India other than USA? Also show the total value of those items.

select * from (select product_class_desc, country, sum(product_quantity) as total_quan, sum(product_quantity*product_price) as Total_Value
from address join online_customer on address.address_id = online_customer.address_id
join order_header on online_customer.customer_id = order_header.customer_id
join order_items on order_header.order_id = order_items.order_id
join product on order_items.product_id = product.product_id
join product_class on product.product_class_code = product_class.product_class_code
where address.COUNTRY not in ('USA','India')
group by country) as sub limit 1,1;

# In the above query limit 1,1 is used to get the 2nd element from the result. I suggest u remove the limit 1,1 from the query and run. You
# will see that the highest sales are at second position. If you simply write limit 1, it will give u the 1st element from the result.


# 3.	Write a query to display the customer id, customer first name, address line 2,city  total sales(sum(product quantity * product price 
# (0 if they haven't purchased any item)) made by customers who stay in the same locality (i.e. same address_line2 & city).

select online_customer.CUSTOMER_ID, customer_fname, address_line2, city, coalesce(sum(product_quantity*product_price),0) as Total_Sales
from address left join online_customer on address.ADDRESS_ID = online_customer.ADDRESS_ID
left join order_header on online_customer.CUSTOMER_ID = order_header.CUSTOMER_ID
left join order_items on order_header.ORDER_ID = order_items.ORDER_ID
left join product on order_items.PRODUCT_ID = product.PRODUCT_ID
where ADDRESS_LINE2 in (select ADDRESS_LINE2 from address group by ADDRESS_LINE2 having count(ADDRESS_LINE2)>1)
group by CUSTOMER_ID;


## In the above query coalesce is used to get 0 instead of null in the output if a particular customer has not purchased anything ... 


# 4.	Write a Query to display product id,product description,totalquantity(sum(product quantity) For a given item whose 
# product id is 201 and which item has been bought along with it  maximum no. of times.

select * from product;
select product_id,product_desc from products, sum(product_quantity) as total_quan from order_items where order_id in
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

select product_class.product_class_code, product_class_desc, product_id, product_desc, product_price from product_class
join product on product_class.PRODUCT_CLASS_CODE = product.PRODUCT_CLASS_CODE
group by PRODUCT_CLASS_CODE order by PRODUCT_PRICE DESC;


## To be frank the above query was the easiest one


# 8.	Write a query to display shipper id,shipper name , (len*width*height*product_quantity) as total volume 
# shipped and show Which shipper has shipped highest volume of items.

select shipper.shipper_id, shipper_name, (len*width*height*product_quantity) as Total_Volume from shipper
join order_header on shipper.SHIPPER_ID = order_header.SHIPPER_ID
join order_items on order_header.ORDER_ID = order_items.ORDER_ID
join product on order_items.PRODUCT_ID = product.PRODUCT_ID
group by shipper_id order by Total_Volume DESC limit 1;


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










