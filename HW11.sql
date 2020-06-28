use shop;

-- Оптимизация запросов
-- Задание №1

-- Первичный ключ не указала, поскольку Archive индексы не поддерживает
drop table if exists logs;
create table logs (
	created_at timestamp not null, -- время и дата создания записи
	table_name varchar (50) not null, -- название таблицы
	name varchar (50)
) engine = ARCHIVE;

-- trigger_users
drop trigger if exists trigger_users;
delimiter //
create trigger trigger_users after insert on users 
for each row 
begin
	insert into logs (created_at, table_name, name)
    values (now(), 'users', 'new.name');
end
delimiter //

-- trigger_catalogs
drop trigger if exists trigger_catalogs;
delimiter //
create trigger trigger_catalogs after insert on catalogs 
for each row 
begin
	insert into logs (created_at, table_name, name)
    values (now(), 'catalogs', 'new.name');
end
delimiter //

-- trigger_products
drop trigger if exists trigger_products;
delimiter //
create trigger trigger_products after insert on products
for each row 
begin
	insert into logs (created_at, table_name, name)
    values (now(), 'products', 'new.name');
end
delimiter //


-- NoSQL
-- Задание № 1
-- В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.

--  вставляем ip адреса
SADD ip '256.0.0.1' '256.0.0.2' '256.0.0.3'

-- проверяем, чтобы были только уникальные значения
SMEMBERS ip

-- проверяем кол-во адресов в коллекции
SCARD ip

-- Задание №2
-- поиск имени пользователя по эл.адресу
set alinaamamontova@gmail.com alina
get alinaamamontova@gmail.com

-- поиск эл.адреса по имени пользователя
set alina alinaamamontova@gmail.com
get alina

-- Задание №3
-- Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

use shop
db.shop.insert({"name": "Бохан К. А. Курс математического анализа", "description": "Книги по высшей математике", "catalog_id": "1", "price": "1200 руб.", "created_at": date (), "updated_at": date ()})

