CREATE DATABASE booking;
USE booking;

-- Создание таблицы "отели":
CREATE TABLE hotels (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    hotel_type_id INT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    stars INT UNSIGNED,
    description TEXT NOT NULL
);

-- Создание таблицы "тип отеля" и заполнение значениями:
CREATE TABLE hotel_types (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO hotel_types
  (id, name)
VALUES
  (1, 'hotel'),
  (2, 'motel'),
  (3, 'hostel'),
  (4, 'appartment'),
  (5, 'villa');
  
  -- Создание таблицы "типы характеристик отеля" и заполнение данными:
  CREATE TABLE hotel_detail_types (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO hotel_detail_types
  (id, name)
VALUES
  (1, 'taxi'),
  (2, 'restaurant'),
  (3, 'bar'),
  (4, 'park'),
  (5, 'swimming pool'),
  (6, 'gym'),
  (7, 'cleaning'),
  (8, 'massage'),
  (9, 'exchange'),
  (10, 'smoking_area');
  
  -- Создание таблицы "характеристики отеля":
  CREATE TABLE hotel_details (
	hotel_id INT UNSIGNED NOT NULL,
	hotel_detail_type_id INT UNSIGNED NOT NULL
);
  
  -- Создание таблицы "страны":
  CREATE TABLE countries (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL UNIQUE
);

-- Создание таблицы "города":
CREATE TABLE cities (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	country_id INT UNSIGNED NOT NULL,
	name VARCHAR(255) NOT NULL
);

-- Создание таблицы "адреса отелей":
CREATE TABLE address (
    hotel_id INT UNSIGNED NOT NULL PRIMARY KEY,
    country_id INT UNSIGNED NOT NULL,
    city_id INT UNSIGNED NOT NULL,
    street VARCHAR(255),
    building INT UNSIGNED NOT NULL
);

-- Создание таблицы "номера":
CREATE TABLE rooms (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
	hotel_id INT UNSIGNED NOT NULL,
	room_type_id INT UNSIGNED NOT NULL,
    price_per_day INT UNSIGNED NOT NULL,
	single_beds_qty INT UNSIGNED NOT NULL,
	double_beds_qty INT UNSIGNED NOT NULL,
	max_persons_qty INT UNSIGNED NOT NULL
);

-- Создание таблицы "тип номера" и заполнение значениями:
CREATE TABLE room_types (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(255) NOT NULL UNIQUE
);

INSERT INTO room_types
  (id, name)
VALUES
  (1, 'single'),
  (2, 'double'),
  (3, 'tripple');
  
  -- Создание таблицы "характеристики номера" и заполнение значениями:
  CREATE TABLE room_details_types (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(255) NOT NULL UNIQUE
);

INSERT INTO room_details_types
  (id, name)
VALUES
  (1, 'conditioner'),
  (2, 'wifi'),
  (3, 'safe'),
  (4, 'shower'),
  (5, 'tv'),
  (6, 'minibar'),
  (7, 'balcony'),
  (8, 'satellite channels'),
  (9, 'parking'),
  (10, 'iron'),
  (11, 'hair_dryer'),
  (12, 'kettle');
  
-- Создание таблицы "характеристика каждого номера":
CREATE TABLE room_details (
	room_id INT UNSIGNED NOT NULL,
	room_details_type_id INT UNSIGNED NOT NULL
);

-- Создание таблицы "контакты":
CREATE TABLE contacts (
	hotel_id INT UNSIGNED NOT NULL,
	contact_type_id INT UNSIGNED NOT NULL,
	contact VARCHAR(255) NOT NULL
);

-- Создание таблицы "тип контакта" и заполнение значениями:
CREATE TABLE contact_types (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(255) NOT NULL UNIQUE);
    
INSERT INTO contact_types
  (id, name)
VALUES
  (1, 'phone'),
  (2, 'email'),
  (3, 'whatsapp'),
  (4, 'skype');
  
-- Создание таблицы "фотографии":
CREATE TABLE photos (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
	hotel_id INT UNSIGNED NOT NULL,
	filename VARCHAR(255) NOT NULL UNIQUE 
);

-- Создание таблицы "пользователи"(адрес):
CREATE TABLE users (
    id INT UNSIGNED NOT NULL PRIMARY KEY,
    country_id INT UNSIGNED NOT NULL,
    city_id INT UNSIGNED NOT NULL,
	street VARCHAR(255),
    building INT UNSIGNED NOT NULL,
    appartm INT UNSIGNED
);

-- Создание таблицы "профиль пользователя"(данные):
CREATE TABLE profiles (
	user_id INT UNSIGNED NOT NULL PRIMARY KEY,
	firstname VARCHAR(100) NOT NULL,
	lastname VARCHAR(100) NOT NULL,
	sex CHAR(1),
	email VARCHAR(100) NOT NULL UNIQUE,
	phone VARCHAR(100) NOT NULL UNIQUE,
    birthday_at DATE,
    created_at DATETIME DEFAULT NOW()
);

-- Создание таблицы "бронирования":
CREATE TABLE bookings (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
	user_id INT UNSIGNED NOT NULL,
	room_id INT UNSIGNED NOT NULL,
	people_qty INT UNSIGNED NOT NULL,
	check_in_at DATETIME NOT NULL,
	check_out_at DATETIME NOT NULL
);

-- Создание таблицы "оценка":
CREATE TABLE marks (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	hotel_id INT UNSIGNED NOT NULL,
	user_id INT UNSIGNED NOT NULL,
    staff INT UNSIGNED NOT NULL,
	place INT UNSIGNED NOT NULL,
	price_to_quality INT UNSIGNED NOT NULL,
	clearness INT UNSIGNED NOT NULL,
	comfort INT UNSIGNED NOT NULL);
    
-- Создание таблицы "отзывы":
CREATE TABLE reports (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
	user_id INT UNSIGNED NOT NULL,
	hotel_id INT UNSIGNED NOT NULL,
	report TEXT NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

show tables;
Select * from users limit 10; -- все верно
select * from profiles limit 10; -- здесь не заполнился пол
create temporary table sex (sex Char(1)); -- создал временную таблицу заполнения пола
insert into sex values ("m"), ("w");
update profiles set sex = (select sex from sex order by rand() limit 1); -- но таблица не отработала, выкидывала ошибку в workbench, просит where
drop table if exists sex; -- удалил таблицу
alter table profiles drop column sex; -- а затем и столбец с полом, он роли не играет
alter table profiles add column sex CHAR(1); -- потом понял, что в Workbench в настройках надо было 2 галочки убрать, чтобы ошибку 1175 отработать, и добавил колонку, заполнив ее значениями
Select * from countries limit 10; -- все верно
Select * from cities; -- в колонке country_id порядок, делаем его рандомным
UPDATE booking.cities SET country_id = FLOOR(1 + (RAND() * 30)); -- рандомим страны для городов
Select * from address limit 10;
UPDATE booking.address SET country_id = FLOOR(1 + (RAND() * 30)), city_id = FLOOR(1 + (RAND() * 150)); -- рандомим
UPDATE booking.address SET building = FLOOR(1 + (RAND() * 300)); -- делаем нормальные номера домов
Select * from marks limit 10;
UPDATE booking.marks SET hotel_id = FLOOR(1 + (RAND() * 500)), user_id = FLOOR(1 + (RAND() * 200)); -- рандомим
Select * from reports limit 10;
UPDATE booking.reports SET hotel_id = FLOOR(1 + (RAND() * 500)), user_id = FLOOR(1 + (RAND() * 200)); -- рандомим
Select * from photos limit 10;
UPDATE booking.photos SET hotel_id = FLOOR(1 + (RAND() * 500));
Select * from hotels limit 10; -- все верно
Select * from hotel_details limit 10; -- все верно
Select * from rooms limit 10; -- все верно
Select * from room_details limit 10; -- все верно
Select * from bookings limit 10;
UPDATE booking.bookings SET user_id = FLOOR(1 + (RAND() * 200)), user_id = FLOOR(1 + (RAND() * 2000));
select * from contact_types;

-- Создаём индексы наиболее частых запросов:
create index room_id_idx on rooms(id);
create index hotel_id_idx on hotels(id);
create index user_id_idx on users(id);
create index city_id_idx on cities(id);
create index country_id_idx on countries(id);

-- Здесь мы посчитали, сколько городов в каждой стране:
SELECT countries.name, COUNT(cities.id) as cities_qty
	FROM
		countries
	JOIN
		cities
	ON cities.country_id = countries.id
GROUP by countries.name;

select * from cities;

SELECT 	rooms.id,
		hotels.name,
		address.country_id,
		cities.name
	FROM rooms
		JOIN hotels
			ON rooms.hotel_id = hotels.id
		JOIN address
			ON hotels.id = address.hotel_id
		JOIN cities
			ON cities.id = address.city_id
		WHERE cities.name = 'Port Jon';
        
-- Посмотрели фото и комнаты одного из отелей (задумался о том, чтобы более логично привязать ценники по типу отеля и самому номеру..):
SELECT * FROM photos WHERE hotel_id = 55;
SELECT * FROM rooms WHERE hotel_id = 55;

-- Попытка найти номер в Бахрейне с бассейном на определённые даты:
SELECT * FROM
	(SELECT
		r.id as room,
		h.id as hotel_id,
		h.name as hotel_name,
		c.name as country_name
	FROM rooms as r
		JOIN hotels as h
			ON r.hotel_id = h.id
		JOIN address as a
			ON h.id = a.hotel_id
		JOIN countries as c
			ON c.id = a.country_id
		JOIN room_details as rd
			ON rd.room_id = r.id
		JOIN room_details_types as rdt
			ON rdt.id = rd.room_details_type_id
		JOIN hotel_details as hd
			ON hd.hotel_id = h.id
		JOIN hotel_detail_types as hdt
			ON hd.hotel_detail_type_id = hdt.id
		WHERE r.max_persons_qty>=1
			AND c.name = "Bahrain"
			AND rdt.name = 'swimming pool'
			AND r.id NOT IN
		(SELECT room_id FROM bookings
			WHERE DATE(check_in_at) BETWEEN
		'2020-04-12 10:00:00' AND '2020-04-20 21:00:00'
			OR DATE(check_out_at) BETWEEN
		'2020-04-12 10:00:00' AND '2020-04-20 21:00:00')) as variants;
        

-- Найдём отели в Греции на определённые даты для двоих:
SELECT * FROM
	(SELECT DISTINCT
		h.name as hotel_name,
        c.name as country_name
	FROM rooms as r
		JOIN hotels as h
			ON r.hotel_id = h.id
		JOIN address as a
			ON h.id = a.hotel_id
		JOIN countries as c
			ON c.id = a.city_id
		WHERE r.max_persons_qty>=2
		AND c.name = 'Greece'
		AND r.id NOT IN
		(SELECT room_id FROM bookings
			WHERE DATE(check_in_at) BETWEEN
		'2020-02-05 10:00:00' AND '2020-02-25 21:00:00'
			OR DATE(check_out_at) BETWEEN
		'2020-02-25 10:00:00' AND '2020-02-25 121:00:00')) as variants;

-- Посмотрим все номера города Edfort:        
SELECT 	r.id as room,
		h.name as hotel_name,
		c.name as city_name
	FROM rooms as r
		JOIN hotels as h
			ON r.hotel_id = h.id
		JOIN address as a
			ON h.id = a.hotel_id
		JOIN cities as c
			ON c.id = a.city_id
		WHERE c.name = "Edfort";
        

-- Создадим триггер, который запрещает добавлять в БД номер, в котором нет кроватей, затем проверим как отработало: 
DELIMITER //
DROP TRIGGER IF EXISTS beds//
CREATE TRIGGER beds BEFORE INSERT ON rooms
FOR EACH ROW	
BEGIN
	IF NEW.single_beds_qty = 0 AND
		NEW.double_beds_qty = 0
			THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Minimum one bed in the room!';
	END IF;
END//
DELIMITER ;

INSERT INTO `rooms` 
(`id`, `hotel_id`, `room_type_id`, `single_beds_qty`, `double_beds_qty`, `max_persons_qty`, `price_per_day`) 
VALUES (1, 1, 3, 0, 0, 2, 285);

-- Создаём представление для удобства получения информации по отелю (названия вместо индексов) и сразу проверяем:
CREATE VIEW hotels_cities_countries AS
SELECT 
	h.name as hotel_name, ci.name as city, co.name as country
	FROM
		hotels as h
	JOIN
		address as a
			ON h.id = a.hotel_id
	JOIN
		cities as ci
			ON ci.id = a.city_id
	JOIN
		countries as co
			ON co.id = a.country_id;
            
SELECT * FROM hotels_cities_countries;

-- Представление в формате "Город-отель-комната":
SELECT * FROM
	(SELECT
		r.id as room,
		h.id as hotel_id,
		h.name as hotel_name,
		c.name as city_name
	FROM rooms as r
		JOIN hotels as h
			ON r.hotel_id = h.id
		JOIN address as a
			ON h.id = a.hotel_id
		JOIN cities as c
			ON c.id = a.city_id
		JOIN room_details as rd
			ON rd.room_id = r.id
		JOIN room_details_types as rdt
			ON rdt.id = rd.room_details_type_id
		JOIN hotel_details as hd
			ON hd.hotel_id = h.id
		JOIN hotel_detail_types as hdt
			ON hd.hotel_detail_type_id = hdt.id) AS filter;

