USE
    `logistic`;

INSERT INTO company
VALUES (DEFAULT,
        'Рога и копыта',
        'ул. Пушкина д.Колотушкина',
        '88005553535',
        'www.kopyta.net');

INSERT INTO company (title)
    VALUE ('LTN');

INSERT INTO company (title)
    VALUE ('Factorio'), ('Shrek'), ('Polikek');

INSERT INTO client (id_company, first_name, last_name)
VALUES ((SELECT id_company FROM company WHERE title = 'LTN'),
        'Кирилл',
        'Вересников');

INSERT INTO client (id_company, first_name, last_name)
VALUES ((SELECT id_company FROM company WHERE title = 'LTN'),
        'НеКирилл',
        'Вересников'),
       ((SELECT id_company FROM company WHERE title = 'LTN'),
        'ТочноНеКирилл',
        'Вересников');

INSERT INTO cargo (id_owner, title, description, count)
VALUES ((SELECT id_client FROM client WHERE first_name = 'Кирилл'),
        'Поезд',
        'Может перевозить грузы по жд',
        '10'),
       ((SELECT id_client FROM client WHERE first_name = 'Кирилл'),
        'Самолет',
        'Может перевозить грузы в небе',
        '100'),
       ((SELECT id_client FROM client WHERE first_name = 'НеКирилл'),
        'Важный груз',
        'супер пупер важный',
        '2'),
       ((SELECT id_client FROM client WHERE first_name = 'ТочноНеКирилл'),
        'Не важный груз',
        NULL,
        '4');

INSERT INTO cargo (id_owner, title, description, count)
VALUES ((SELECT id_client FROM client WHERE first_name = 'Кирилл'),
        'Дрон строительный',
        'Строит по шаблону',
        '10'),
       ((SELECT id_client FROM client WHERE first_name = 'Кирилл'),
        'Турель пулементная',
        'Стреляет по жукам',
        '100'),
       ((SELECT id_client FROM client WHERE first_name = 'Кирилл'),
        'Урановая руда',
        'Перерабатывается в уран 238',
        '2'),
       ((SELECT id_client FROM client WHERE first_name = 'Кирилл'),
        'Дерево',
        NULL,
        '1000');

DELETE
FROM client;

DELETE
FROM client
WHERE id_client = UUID_TO_BIN('');

INSERT INTO waybill (id_company, `from`, `to`, status)
VALUES ((SELECT id_company FROM company WHERE title = 'LTN'),
        (SELECT id_client FROM client WHERE first_name = 'Кирилл'),
        (SELECT id_client FROM client WHERE first_name = 'ТочноНеКирилл'),
        0),
       ((SELECT id_company FROM company WHERE title = 'LTN'),
        (SELECT id_client FROM client WHERE first_name = 'НеКирилл'),
        (SELECT id_client FROM client WHERE first_name = 'Кирилл'),
        0),
       ((SELECT id_company FROM company WHERE title = 'LTN'),
        (SELECT id_client FROM client WHERE first_name = 'Кирилл'),
        (SELECT id_client FROM client WHERE first_name = 'НеКирилл'),
        0);

INSERT INTO cargo_list (id_waybill, id_cargo, count)
VALUES ((SELECT id_waybill
         FROM waybill
         WHERE `from` = (SELECT id_client FROM client WHERE first_name = 'Кирилл')
           AND `to` = (SELECT id_client FROM client WHERE first_name = 'ТочноНеКирилл')),
        (SELECT id_cargo FROM cargo WHERE title = 'Поезд'),
        (SELECT count FROM cargo WHERE title = 'Поезд')),
       ((SELECT id_waybill
         FROM waybill
         WHERE `from` = (SELECT id_client FROM client WHERE first_name = 'НеКирилл')
           AND `to` = (SELECT id_client FROM client WHERE first_name = 'Кирилл')),
        (SELECT id_cargo FROM cargo WHERE title = 'Важный груз'),
        (SELECT count FROM cargo WHERE title = 'Важный груз')),
       ((SELECT id_waybill
         FROM waybill
         WHERE `from` = (SELECT id_client FROM client WHERE first_name = 'Кирилл')
           AND `to` = (SELECT id_client FROM client WHERE first_name = 'НеКирилл')),
        (SELECT id_cargo FROM cargo WHERE title = 'Самолет'),
        (SELECT count FROM cargo WHERE title = 'Самолет'));

UPDATE waybill
SET status = 1;

UPDATE waybill
SET status = 0;

UPDATE waybill
SET status = 2
WHERE id_company = UUID_TO_BIN('');

UPDATE waybill
SET received_date = CURRENT_TIMESTAMP
WHERE status = 2;

UPDATE company
SET address = 'болото',
    website = 'ogrytop.rrr'
WHERE title = 'Shrek';

SELECT `title`, `website`
FROM company;

SELECT *
FROM company;

SELECT *
FROM company
WHERE title = 'Shrek';

SELECT *
FROM client;

SELECT *
FROM cargo;

SELECT *
FROM cargo
ORDER BY count ASC
LIMIT 3;

SELECT *
FROM cargo
ORDER BY count DESC;

SELECT count, title
FROM cargo
ORDER BY 1;

INSERT INTO client (id_company, first_name, last_name)
VALUES ((SELECT id_company FROM company WHERE title = 'Рога и копыта'),
        'Старый',
        'Клиент1'),
       ((SELECT id_company FROM company WHERE title = 'Рога и копыта'),
        'Старый',
        'Клиент2');

INSERT INTO waybill (`id_company`, `from`, `to`, `status`, `sent_date`, `received_date`)
VALUES ((SELECT id_company FROM company WHERE title = 'Рога и копыта'),
        (SELECT id_client FROM client WHERE last_name = 'Клиент1'),
        (SELECT id_client FROM client WHERE last_name = 'Клиент2'),
        4,
        DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 YEAR),
        DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 YEAR)),
       ((SELECT id_company FROM company WHERE title = 'Рога и копыта'),
        (SELECT id_client FROM client WHERE last_name = 'Клиент2'),
        (SELECT id_client FROM client WHERE last_name = 'Клиент1'),
        4,
        DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 YEAR),
        DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 YEAR));

SELECT *
FROM waybill
WHERE sent_date BETWEEN '2017-01-01' AND '2021-01-01';

SELECT count(*)
FROM client;

SELECT count(DISTINCT id_owner)
FROM cargo;

SELECT DISTINCT id_owner
FROM cargo;

SELECT MAX(count)
FROM cargo;

SELECT MIN(count)
FROM cargo;

SELECT id_owner, count(*)
FROM cargo
GROUP BY id_owner;

SELECT *
FROM client
         LEFT JOIN cargo c on client.id_client = c.id_owner
WHERE last_name = 'Клиент1';

SELECT *
FROM client
         LEFT JOIN cargo c on client.id_client = c.id_owner
WHERE last_name = 'Вересников';

SELECT *
FROM cargo
         RIGHT JOIN client c on c.id_client = cargo.id_owner
WHERE last_name = 'Вересников';

SELECT *
FROM cargo
         RIGHT JOIN client c on c.id_client = cargo.id_owner
WHERE last_name = 'Клиент1';

SELECT *
FROM waybill
         LEFT JOIN client on waybill.`from` = client.id_client
         LEFT JOIN company on client.id_company = company.id_company
         LEFT JOIN cargo_list on waybill.id_waybill = cargo_list.id_waybill
         LEFT JOIN cargo on cargo_list.id_cargo = cargo.id_cargo
WHERE waybill.status = 0
  AND company.title = 'LTN'
  AND cargo.title = 'Поезд';

SELECT *
FROM client
         INNER JOIN company c on client.id_company = c.id_company