create table zepto(
sku_id serial primary key,
category varchar(50),
name varchar(50),
mrp numeric(8,2),
discountpercent numeric(5,2),
availablequantity int,
discountedsellingprice numeric(8,2),
weightingms int,
outofstock boolean,
quantity int
)

--data exploration.

--count rows.
select count(*)from zepto

--sample data.

select* from zepto
limit 10

--null values.

select* from zepto
where name is null
or
mrp is null
or
discountpercent is null
or 
availablequantity is null
or
discountedsellingprice is null
or
weightingms is null
or
outofstock is null
or
quantity is null

--different product catogories.
select distinct category
from zepto

--products in stock and out of stock.
select outofstock,count(sku_id)
from zepto
group by 1

--product names present multiple times.
select name,count(sku_id)appearences
from zepto
group by 1
order by count(sku_id) desc

--data cleaning.

--products with price=0.
select* from zepto
where mrp=0 or discountedsellingprice=0

delete from zepto
where mrp=0

--converting paise into rupees.
update zepto
set mrp=mrp/100.0,
discountedsellingprice=discountedsellingprice/100.0

select mrp,discountedsellingprice
from zepto

--Q1 find the top 10 best products based on discount percentage.
select distinct name,mrp,discountpercent
from zepto
order by discountpercent desc
limit 10

--Q2 what are the products wth high mrp but out of stock.
select mrp, distinct name
from zepto
where outofstock='true'and mrp>300
order by mrp desc

--Q3 calculate estimated revenue for each category.
select category,sum(discountedsellingprice*availablequantity)total_revenue
from zepto
group by category
order by total_revenue

--Q4 find all products where mrp is greater than 500 and discount is less then 10%.
select distinct name,mrp,discountpercent
from zepto
where mrp>500 and discountpercent<100
order by mrp desc,discountpercent desc

--Q5 identify the top 5 categories offering the highest average discount percentage.
select category,round(avg(discountpercent),2)
from zepto
group by category
order by avg(discountpercent) desc
limit 5

--Q6 find the price per gram for products above 100 gm and sort by best value.
select distinct name,weightingms,discountedsellingprice,
round(discountedsellingprice/weightingms,2)price_per_gram
from zepto
where weightingms>=100
order by price_per_gram

--Q7 group the products into categories like low,medium,bulk.
select distinct name,weightingms,
case when weightingms<1000 then 'low'
when weightingms<5000 then 'medium'
else 'bulk'
end as weight_category
from zepto

--Q8 what is the total inventory weight per category.
select category,sum(weightingms*availablequantity)total_weight
from zepto
group by category
order by total_weight
select* from zepto

