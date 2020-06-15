-- задание № 1

insert into orders values 
('1','1','2020-06-14 23:30:08','2020-06-14 23:30:08'),
('3','3','2020-06-14 23:30:08','2020-06-14 23:30:08'),
('5','5','2020-06-14 23:30:08','2020-06-14 23:30:08'),
('7','7','2020-06-14 23:30:08','2020-06-14 23:30:08'),
('9','9','2020-06-14 23:30:08','2020-06-14 23:30:08');

select 
	id, name 
from 
	users 
where 
	id = any (select id from orders);
    
-- задание №2

select 
	products.catalog_id, products.name, products.description, catalogs.id, catalogs.name
from
	products 
join 
	catalogs
on 
	catalogs.id = products.catalog_id;
