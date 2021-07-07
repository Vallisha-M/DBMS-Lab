create database moviesdb;
use moviesdb;

create table actor (
	id int primary key, 
	name varchar(10), 
	gender varchar(1)
);
desc actor;
create table director (
	id int primary key, 
	name varchar(10), 
	phone varchar(10)
);
desc director;
create table movie (
	id int primary key, 
	title varchar(20), 
	year int, 
	lang varchar(10), 
	dir_id int, 
	foreign key(dir_id) references director(id)
);
desc movie;
create table cast (
	act_id int, 
	mov_id int, 
	role varchar(20), 
	primary key(act_id, mov_id), 
	foreign key(act_id) references actor(id), 
	foreign key(mov_id) references movie(id)
);
desc cast;
create table rating(
	mov_id int, 
	stars int, 
	foreign key(mov_id) references movie(id),
	check (stars > 0 and stars <= 5)
);
desc rating;
insert into actor values (301,'anushka','f'),
(302,'prabhas','m'),
(303,'punith','m'),
(304,'jermy','m');
select * from actor;
insert into director values (60,'rajamouli',8751611001),
(61,'hitchcock',7766138911),
(62,'faran',9986776531),
(63,'spielberg',8989776530);
select * from director;
insert into movie values (1001,'bahubali-2',2017,'telugu',60),
(1002,'bahubali-1',2015,'telugu',60),
(1003,'akash',2008,'kannada',61),
(1004,'war horse',2011,'english',63);
select * from movie;
insert into cast values (301,1002, 'heroine'),
(301,1001,'heroine'),(303,1003,'hero'),(303,1002,'guest'),(304, 1004,'hero');
select * from cast;
insert into rating values
(1001,4),
(1002,2),
(1003,5),
(1004,4);
select * from rating;

-- Query 1

select title from movie m, director d where d.name='hitchcock' and d.id=m.dir_id;

-- Query 2

select distinct title from movie m, cast c where m.id=c.mov_id and c.act_id in (select act_id from cast group by act_id having count(mov_id) > 1);

-- Query 3

select distinct name from actor a, cast c where c.act_id=a.id and c.mov_id in (select id from movie m where year not between 2000 and 2015);
/*or*/
select distinct name from actor a inner join cast c on a.id=c.act_id and c.mov_id in (select id from movie m where year not between 2000 and 2015);

-- Query 4

select title, stars from movie m inner join (select mov_id, max(stars) as stars from rating group by mov_id) r on m.id=r.mov_id order by title;


-- Query 5
update rating set stars=5 where mov_id in (select m.id from movie m, director d where m.dir_id = d.id and d.name='spielberg');
select * from rating;