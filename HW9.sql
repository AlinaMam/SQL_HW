-- Транзакции, переменные, представления
-- Задание № 1

create database sample;
use sample;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Жасмин', '1991-10-04'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

start transaction;
select * from shop.users where id = 1;
update shop.users set id = id - 1 where id = 1;
update sample.users set id = id + 6 where id = 1;
select * from sample.users;
commit;
select * from sample.users;

-- Задание № 2

create view namesofproducts
	as select c.name, p.desription
		from products p, catalogs c
        where p.id = c.id;
        
select c.name, p.desription from products p, catalogs c;

-- Хранимые процедуры и функции, триггеры
-- Задание №1

delimiter //
create function hello ()
returns tinytext
begin
	declare hour int;
    set hour = hour(now());
    case
		when hour between 6:00 and 12:00 then 
        return 'Доброе утро';
        when hour between 12:00 and 18:00 then
        return 'Добрый день';
        when hour between 18:00 and 00:00 then
        return 'Добрый вечер';
        when hour between 00:00 and 6:00 then
        return 'Доброй ночи';
	end case;
    end
    delimiter //
    
    select hello ();
    
    -- Задание №2
    
    use shop;
    
    delimiter //
    create trigger filling_fields before insert on products
    for each row 
    begin
		declare name, desription tinytext
		if products.name or products.desription is null then 
        signal sqlstate '45000' set message_text = 'field must be filled in'
        end if;
	end
    delimiter //
		

