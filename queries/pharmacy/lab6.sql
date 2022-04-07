USE lw6;

-- 1) add need keys
alter table `order`
    add foreign key (id_production) references production (id_production) on DELETE cascade;
alter table `order`
    add foreign key (id_dealer) references dealer (id_dealer) on DELETE cascade;
alter table `order`
    add foreign key (id_pharmacy) references pharmacy (id_pharmacy) on DELETE cascade;

alter table `production`
    add foreign key (id_company) references company (id_company) on DELETE cascade;
alter table `production`
    add foreign key (id_medicine) references medicine (id_medicine) on DELETE cascade;

alter table `dealer`
    add foreign key (id_company) references company (id_company) on DELETE cascade;

-- 2) Выдать информацию по всем заказам лекарства “Кордеон” компании “Аргус” указанием названий аптек, дат, объема заказов.
select `pharmacy`.name, `medicine`.name, `company`.name, `order`.date, `order`.quantity
from `order`
         join `pharmacy` on `pharmacy`.id_pharmacy = `order`.id_pharmacy
         join `production` on `production`.id_production = `order`.id_production
         join `medicine` on `medicine`.id_medicine = `production`.id_medicine
         join `company` on `company`.id_company = `production`.id_company
where `medicine`.name = 'Кордеон'
  AND `company`.name = 'Аргус';

-- 3) Дать список лекарств компании “Фарма”, на которые не были сделаны заказы до 25 января
select `medicine`.name, `company`.name
from `order`
         join `production` on `production`.id_production = `order`.id_production
         join `medicine` on `medicine`.id_medicine = `production`.id_medicine
         join `company` on `company`.id_company = `production`.id_company
where `order`.id_production IN (
    select `order`.id_production
    from `order`
    where `order`.date < DATE('2019-01-25')
)
  AND `company`.name = 'Фарма'
group by medicine.name;

-- 4) Дать минимальный и максимальный баллы лекарств каждой фирмы, которая оформила не менее 120 заказов
SELECT `company`.name, MIN(rating), MAX(rating)
FROM `production`
         JOIN `company` ON `production`.id_company = `company`.id_company
         JOIN `order` ON `production`.id_production = `order`.id_production
GROUP BY `company`.name
HAVING COUNT(`order`.id_order) >= 120;

-- 5) Дать списки сделавших заказы аптек по всем дилерам компании “AstraZeneca”. Если у дилера нет заказов, в названии аптеки проставить NULL
SELECT `pharmacy`.name, `dealer`.name, `order`.quantity
FROM `dealer`
         LEFT JOIN `company` ON `dealer`.id_company = `company`.id_company
         LEFT JOIN `order` ON dealer.id_dealer = `order`.id_dealer
         LEFT JOIN `pharmacy` ON `order`.id_pharmacy = `pharmacy`.id_pharmacy
WHERE `company`.name = 'AstraZeneca';

-- 6) Уменьшить на 20% стоимость всех лекарств, если она превышает 3000, а длительность лечения не более 7 дней
UPDATE `production`
    LEFT JOIN `medicine` ON `production`.id_medicine = `medicine`.id_medicine
SET `production`.price = `production`.price * 0.8
WHERE `production`.price > 3000
  AND `medicine`.cure_duration <= 7;

-- 7) Добавить необходимые индексы
CREATE INDEX company_name_idx
    ON `company`(name ASC);

CREATE INDEX `medicine_name_idx`
    ON `medicine`(name ASC);

CREATE INDEX `medicine_cure_duration_idx`
    ON `medicine`(cure_duration ASC);

CREATE INDEX `order_id_order_idx`
    ON `order`(date ASC);

CREATE INDEX `production_id_production_idx`
    ON `production`(id_production ASC);

CREATE INDEX `production_price_idx`
    ON `production`(price ASC);