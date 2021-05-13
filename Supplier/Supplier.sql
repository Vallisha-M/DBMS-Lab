create database supplierdb;
use supplierdb;

create table suppliers(
	sid int,
    sname varchar(20),
	city varchar(15),
    primary key (sid)
);

create table parts (
	pid int,
    pname varchar(15),
    color varchar(10),
    primary key (pid)
);

create table catalog(
	sid int,
	pid int,
    cost int,
    primary key(pid, sid),
    foreign key (pid) references parts(pid),
    foreign key (sid) references suppliers(sid)
);

insert into suppliers values (10001, 'Acme Widget', 'Bangalore');
insert into suppliers values (10002, 'Johns', 'Kolkata');
insert into suppliers values (10003, 'Vimal', 'Mumbai');
insert into suppliers values (10004, 'Reliance', 'Delhi');

insert into parts value(20001, 'Book', 'Red');
insert into parts value(20002, 'Pen', 'Red');
insert into parts value(20003, 'Pencil', 'Green');
insert into parts value(20004, 'Mobile', 'Green');
insert into parts value(20005, 'Charger', 'Black');

insert into catalog values(10001,20001,10);
insert into catalog values(10001,20002,10);
insert into catalog values(10001,20003,30);
insert into catalog values(10001,20004,10);
insert into catalog values(10001,20005,10);

insert into catalog values(10002,20001,10);
insert into catalog values(10002,20002,20);
insert into catalog values(10003,20003,30);
insert into catalog values(10004,20003,40);
commit;


select * from parts;
select * from suppliers;
select * from catalog;

#Query 1#
select distinct p.pname from parts p, catalog c where p.pid = c.pid;

#Query 2#

select distinct sname from suppliers where 
sid = 
(select sid from catalog group by sid having 
count(pid) = (select count(distinct pid) from parts));

-- Query 3

select distinct s.sname from suppliers s, parts p, catalog c where s.sid = c.sid and p.pid = c.pid and 
exists ((select sid from catalog group by sid having 
p.pid = c.pid and p.color='Red'));

-- Query 4

 select P.pname from parts P, catalog C, suppliers S 
 where P.pid = C.pid and C.sid = S.sid and S.sname = 'Acme Widget'
 and not exists (select * from catalog C1, suppliers S1
 where P.pid = C1.pid and C1.sid = S1.sid and S1.sname <> 'Acme Widget');

-- Query 5
select distinct C.sid from catalog C
where C.cost > ( select avg (C1.cost)
from catalog C1
where C1.pid = C.pid );


-- Query 6
select P.pid, S.sname
from parts P, suppliers S, catalog C
where C.pid = P.pid
and C.sid = S.sid
and C.cost = (select max(C1.cost)
from catalog C1
where C1.pid = P.pid);
