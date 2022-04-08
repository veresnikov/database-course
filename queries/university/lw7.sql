USE university;

-- 1) add need keys
alter table `student`
    add foreign key (id_group) references `group` (id_group) on DELETE cascade;

alter table `student`
    add foreign key (id_group) references `group` (id_group) on DELETE cascade;

alter table `lesson`
    add foreign key (id_group) references `group` (id_group) on DELETE cascade;
alter table `lesson`
    add foreign key (id_teacher) references `teacher` (id_teacher) on DELETE cascade;
alter table `lesson`
    add foreign key (id_subject) references `subject` (id_subject) on DELETE cascade;

alter table `mark`
    add foreign key (id_lesson) references `lesson` (id_lesson) on DELETE cascade;
alter table `mark`
    add foreign key (id_student) references `student` (id_student) on DELETE cascade;

-- 2) Выдать оценки студентов по информатике если они обучаются данному предмету. Оформить выдачу данных с использованием view
create or replace view `marks_for_subject` as
select `student`.name, `mark`.mark
from `mark`
         join `lesson` on `mark`.id_lesson = `lesson`.id_lesson
         join `student` on `mark`.id_student = `student`.id_student
         join `subject` on `lesson`.id_subject = `subject`.id_subject
where `subject`.name = 'Информатика';
select *
from marks_for_subject;

-- 3) Дать информацию о должниках с указанием фамилии студента и названия предмета. Должниками считаются студенты, не имеющие оценки по предмету, который ведется в группе. Оформить в виде процедуры, на входе идентификатор группы
delimiter $
drop procedure if exists debtors;
create procedure debtors(in group_id int)
begin
    select `student`.name, `subject`.name
    from `student`
             join `lesson` on `lesson`.id_group = `student`.id_group
             left join `mark` on `mark`.id_lesson = `lesson`.id_lesson AND `mark`.id_student = `student`.id_student
             left join `subject` on `student`.name = `subject`.name
    where `student`.id_group = group_id
    group by `student`.name, `subject`.name
    having COUNT(`mark`.mark) = 0;
end$
delimiter ;

call debtors(3);

-- 4) Дать среднюю оценку студентов по каждому предмету для тех предметов, по которым занимается не менее 35 студентов
select `subject`.name, AVG(`mark`.mark)
from `subject`
         join `lesson` on `subject`.id_subject = `lesson`.id_subject
         join `group` on `lesson`.id_group = `group`.id_group
         join `mark` on `lesson`.id_lesson = `mark`.id_lesson
         join `student` on `group`.id_group = `student`.id_group
group by `subject`.name
having COUNT(`student`.id_student) >= 35;

-- 5) Дать оценки студентов специальности ВМ по всем проводимым предметам с указанием группы, фамилии, предмета, даты. При отсутствии оценки заполнить значениями NULL поля оценки
select `group`.name, `student`.name, `subject`.name, `lesson`.date, `mark`.mark
from `student`
         join `group` on `student`.id_group = `group`.id_group
         join `lesson` on `group`.id_group = `lesson`.id_subject
         join `subject` on `lesson`.id_subject = `subject`.id_subject
         left join `mark` on `lesson`.id_lesson = `mark`.id_lesson
where `group`.name = 'ВМ';

-- 6) Всем студентам специальности ПС, получившим оценки меньшие 5 по предмету БД до 12.05, повысить эти оценки на 1 балл
update `mark`
    join `student` on `mark`.id_student = `student`.id_student
    join `group` on `student`.id_group = `group`.id_group
    join `lesson` on `group`.id_group = `lesson`.id_group
    join `subject` on `lesson`.id_subject = `subject`.id_subject
set `mark`.mark = `mark`.mark + 1
where `mark`.mark < 5
  and `subject`.name = 'БД'
  and `group`.name = 'ПС'
  and `lesson`.date < '2019-05-12';

-- 7) Добавить необходимые индексы
CREATE INDEX group_name_idx
    ON `group` (name ASC);
CREATE INDEX lesson_date_idx
    ON `lesson` (date ASC);
CREATE INDEX mark_mark_idx
    ON `mark` (mark ASC);
CREATE INDEX subject_name_idx
    ON `subject` (name ASC);
