use hotels;
-- 1) сделаем нужные типы в таблицах
alter table booking
    modify booking_date DATE;
alter table booking
    AUTO_INCREMENT = 2001;
alter table booking
    add primary key (id_booking);
alter table booking
    modify id_booking int auto_increment;

alter table client
    AUTO_INCREMENT = 86;
alter table client
    add primary key (id_client);
alter table client
    modify id_client int auto_increment;

alter table hotel
    AUTO_INCREMENT = 10;
alter table hotel
    add primary key (id_hotel);
alter table hotel
    modify id_hotel int auto_increment;

alter table room
    AUTO_INCREMENT = 209;
alter table room
    add primary key (id_room);
alter table room
    modify price decimal(10, 2);
alter table room
    modify id_room int auto_increment;

alter table room_category
    AUTO_INCREMENT = 7;
alter table room_category
    add primary key (id_room_category);
alter table room_category
    modify id_room_category int auto_increment;

alter table room_in_booking
    modify checkin_date date;
alter table room_in_booking
    modify checkout_date date;
alter table room_in_booking
    AUTO_INCREMENT = 2251;
alter table room_in_booking
    add primary key (id_room_in_booking);
alter table room_in_booking
    modify id_room_in_booking int auto_increment;

-- 2) добавим внешние ключи в таблицы
alter table room
    add foreign key (id_hotel) references hotel (id_hotel) on DELETE cascade;
alter table room
    add foreign key (id_room_category) references room_category (id_room_category) on DELETE cascade;

alter table booking
    add foreign key (id_client) references client (id_client) on DELETE cascade;

alter table room_in_booking
    add foreign key (id_booking) references booking (id_booking) on DELETE cascade;
alter table room_in_booking
    add foreign key (id_room) references room (id_room) on DELETE cascade;

-- 3) Выдать информацию о клиентах гостиницы “Космос”, проживающих в номерах категории “Люкс” на 1 апреля 2019г
select client.name, client.phone
from client
         inner join booking on client.id_client = booking.id_client
         inner join room_in_booking on booking.id_booking = room_in_booking.id_booking
         inner join room on room_in_booking.id_room = room.id_room
         inner join room_category on room.id_room_category = room_category.id_room_category
         inner join hotel on room.id_hotel = hotel.id_hotel
where hotel.name = 'Космос'
  and room_category.name = 'Люкс'
  and room_in_booking.checkin_date < '2019-04-01'
  and room_in_booking.checkout_date >= '2019-04-01';

-- 4) Дать список свободных номеров всех гостиниц на 22 апреля
select hotel.name, room.number
from room
         inner join hotel on room.id_hotel = hotel.id_hotel
         inner join room_in_booking on room.id_room = room_in_booking.id_room
where room_in_booking.checkin_date < '2019-04-22'
  and room_in_booking.checkout_date < '2019-04-22'
group by room.number, hotel.name;

-- 5) Дать количество проживающих в гостинице “Космос” на 23 марта по каждой категории номеров
select count(*) as `clients`, room_category.name
from room_category
         inner join room on room_category.id_room_category = room.id_room_category
         inner join room_in_booking on room.id_room = room_in_booking.id_room
         inner join hotel on room.id_hotel = hotel.id_hotel
where hotel.name = 'Космос'
  and room_in_booking.checkin_date < '2019-03-23'
  and room_in_booking.checkout_date >= '2019-03-23'
group by room_category.name;

-- 6) Продлить на 2 дня дату проживания в гостинице “Космос” всем клиентам комнат категории “Бизнес”, которые заселились 10 мая.
update room_in_booking
    inner join room on room_in_booking.id_room = room.id_room
    inner join room_category on room.id_room_category = room_category.id_room_category
    inner join hotel on room.id_hotel = hotel.id_hotel
set checkout_date = adddate(checkout_date, 2)
where checkin_date = '2021-05-10'
  and room_category.name = 'Бизнес'
  and hotel.name = 'Космос';

select *
from room_in_booking AS left_room_in_booking
         INNER JOIN room_in_booking AS right_room_in_booking
                    ON left_room_in_booking.id_room = right_room_in_booking.id_room
WHERE left_room_in_booking.id_room_in_booking != right_room_in_booking.id_room_in_booking
  AND left_room_in_booking.checkin_date <= right_room_in_booking.checkin_date
  AND left_room_in_booking.checkout_date >= right_room_in_booking.checkout_date;

-- тот же самы запрос, но более явно видно конфликтующие даты
select left_room_in_booking.id_room_in_booking,
       left_room_in_booking.checkin_date,
       left_room_in_booking.checkout_date,
       right_room_in_booking.checkin_date,
       right_room_in_booking.checkout_date
from room_in_booking AS left_room_in_booking
         INNER JOIN room_in_booking AS right_room_in_booking
                    ON left_room_in_booking.id_room = right_room_in_booking.id_room
WHERE left_room_in_booking.id_room_in_booking != right_room_in_booking.id_room_in_booking
  AND left_room_in_booking.checkin_date <= right_room_in_booking.checkin_date
  AND left_room_in_booking.checkout_date >= right_room_in_booking.checkout_date;


-- 8) Создать бронирование в транзакции
start transaction;
    insert into booking(id_client, booking_date)
    values (15, date(now()));
    insert into room_in_booking(id_booking, id_room, checkin_date, checkout_date)
    values (last_insert_id(), 1, adddate(date(now()), 5), adddate(date(now()), 10));
commit;

-- 9) добавление индексов
create index client_name_idx on client(id_client);

create index room_category_id_idx on room_category(id_room_category);

create index hotel_id_idx on hotel(id_hotel);
create index hotel_stars_idx on hotel(stars);

create index room_id_idx on room(id_room);
create index room_number_idx on room(number);
create index room_price_idx on room(price);
create index room_hotel_idx on room(id_hotel);
create index room_category_idx on room(id_room_category);

create index booking_id_idx on booking(id_booking);
create index booking_client_idx on booking(id_client);
create index booking_date_idx on booking(booking_date);

create index room_in_booking_id_idx on room_in_booking(id_room_in_booking);
create index room_in_booking_id_booking_idx on room_in_booking(id_booking);
create index room_in_booking_id_room_idx on room_in_booking(id_room);