-- 1BM19CS177, Vallisha M
create database cie2;
use cie2;

create table student(
     regno varchar(15),
     name varchar(20),
     major varchar(20),
     bdate date,
     primary key (regno) 
     );
desc student;
create table course(
     courseno int,
     cname varchar(20),
     dept varchar(20),
     primary key (courseno) 
     );
desc course;     
create table enroll(
     regno varchar(15),
     courseno int,
     sem int(3),
     marks int(4),
     primary key (regno,courseno),
     foreign key (regno) references student (regno),
     foreign key (courseno) references course (courseno) 
     );
desc enroll;
create table text(
     book_isbn int(5),
     book_title varchar(20),
     publisher varchar(20),
     author varchar(20),
     primary key (book_isbn) 
     );
desc text;

create table book_adoption(
     courseno int,
     sem int(3),
     book_isbn int(5),
     primary key (courseno,book_isbn),
     foreign key (courseno) references course (courseno),
     foreign key (book_isbn) references text(book_isbn) 
     );
desc book_adoption;
insert into student (regno,name,major,bdate) values
     ('1pe11cs002','b','sr','19930924'),
     ('1pe11cs003','c','sr','19931127'),
     ('1pe11cs004','d','sr','19930413'),
     ('1pe11cs005','e','jr','19940824'),
	('1pe11cs006','f','jr','19940824');
select * from student;

insert into course values (111,'os','cse'),
     (112,'ec','cse'),
     (113,'ss','ise'),
     (114,'dbms','cse'),
     (115,'signals','ece');
select * from course;
insert into text (book_isbn,book_title,publisher,author) values
     (10,'database systems','pearson','schield'),
     (900,'operating sys','pearson','leland'),
     (901,'circuits','hall india','bob'),
     (902,'system software','peterson','jacob'),
     (903,'scheduling','pearson','patil'),
     (904,'database systems','pearson','jacob'),
     (905,'database manager','pearson','bob'),
     (906,'signals','hall india','sumit'),
	(100, 'computer systems', 'new india', 'sumit');
     
select * from text;

insert into enroll (regno,courseno,sem,marks) values
     ('1pe11cs002',114,5,100),
     ('1pe11cs003',113,5,100),
     ('1pe11cs004',111,5,100),
     ('1pe11cs005',112,3,100),('1pe11cs005',115,3,100)
,('1pe11cs005',111,3,100);
select * from enroll;

insert into book_adoption (courseno,sem,book_isbn) values
(111,5,900),
(111,5,903),
(111,5,904),
(112,3,901),
(113,3,10),
(114,5,905),
(113,5,902),
(115,3,906),
(115,3,100);
select * from book_adoption;

-- Query 1

select courseno, cname from course where courseno in (select courseno from enroll group by courseno having count(courseno)<25) or courseno not in(select courseno from enroll);

-- Query 2
select c.courseno, c.cname, count(e.courseno) from course c, enroll e where e.courseno=c.courseno group by(e.courseno);

-- Query 3
select cname, courseno from course where courseno in 
(select courseno from book_adoption where book_isbn in 
(select t.book_isbn from text t where 
(select locate('computer', t.book_title)>0)
));

-- Query 4
select * from student where regno in (select regno from enroll group by (regno) having count(regno)>=2);

-- Query 5
select name from student where regno not in (select regno from enroll);

