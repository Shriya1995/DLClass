guse day1_inclass;
select * from country;
select Name from country where length(Name)>8;
select round(revenue ) from country;
select ucase(Name) from country;
select Country_id,Name,Region_ID,revenue from country where Name like "%d_";
select Country_id,Name,revenue from country order by revenue desc limit 2,2;
select distinct Region_ID,Name from country order by Name desc;

select * from products;
select name,price from products where name like"PENCIL%";
select name,price from products where name like"P__%";
SELECT * from products where price between 1.0 and 2.0 and quantity between 1000 and 2000;
select concat(productCode," ",name) as Product_Description,price from products;
select max(price)-min(price) from products;