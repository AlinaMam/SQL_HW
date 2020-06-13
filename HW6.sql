use vk;

select * from users where id = 5;

select * from friend_requests where status = 'approved';

select * from messages where to_user_id = 5 order by from_user_id desc;

-- задание №1
-- сосредоточилась на заданиях 2-5, было очень сложно, потратила много времени поэтому задание 1 не выполнено

-- задание № 2
select * from messages where to_user_id = (select id from users where id = 5)
and from_user_id in (select initiator_user_id from friend_requests where status = 'approved') and from_user_id != 5;


select 
	user_id,
	floor((to_days(now()) - to_days(birthday)) / 365.25) as age 
from profiles
order by age
limit 10;

select count(id) from likes;


-- задание №3
-- посчитала возраст, но потом решила это не использовать в запросе, а пойти другим путем
select * from likes where user_id in (select 
	user_id,
	floor((to_days(now()) - to_days(birthday)) / 365.25) as age 
from profiles
order by age);

-- решение
select sum(media_id) as sum_likes from likes
where user_id in (select user_id  from profiles order by birthday desc);


-- задание №4
select user_id, gender from profiles;

select sum(media_id) as sum_likes from likes 
where user_id in (select user_id from profiles where gender = 'f');


select sum(media_id) from likes;

-- решение
select 
       (select sum(media_id) as sum_likes from likes 
		where user_id in (select user_id from profiles where gender = 'f')) as Female,
		(select sum(media_id) as sum_likes from likes 
		where user_id in (select user_id from profiles where gender = 'm')) as Male
from profiles
limit 1;

-- задание №5
-- анализ был проведен на основании отправленных сообщений
select from_user_id, count(id) from messages group by from_user_id order by count(id) desc limit 10;


