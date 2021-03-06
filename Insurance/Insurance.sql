create database insurance;
use insurance;

create table person( 
	driver_id varchar(10),
    name varchar(20),
	address varchar(30),
	primary key(driver_id)
);

desc person;

create table car(
	reg_num varchar(10),
	model varchar(10),
	year int,
	primary key(reg_num)
);

desc car;

create table accident(
	report_num int,
	accident_date date,
	location varchar(20),
	primary key(report_num)
);
desc accident;
create table owns(
	driver_id varchar(10),
	reg_num varchar(10),
	primary key(driver_id,reg_num),
	foreign key(driver_id) references person(driver_id),
	foreign key(reg_num) references car(reg_num)
);

desc owns;

create table participated(
	driver_id varchar(10),
	reg_num varchar(10),
	report_num int,
	damage_amount int,
	primary key(driver_id,reg_num,report_num),
	foreign key(driver_id) references person(driver_id),
	foreign key(reg_num) references car(reg_num),
	foreign key(report_num) references accident(report_num)
);

desc participated;

insert into person values('A01','Raghu','Electronic City');
insert into person values('A02','Rishab','Orange County');
insert into person values('A03','Rufus','NR Colony');
insert into person values('A04','Jamal','Lawrence Park');
insert into person values('A05','Kevin','Rosedale');

commit;

select * from person;

insert into car values('KA031111','Accord',2005);
insert into car values('KA041122','MX-5',2019);
insert into car values('KA051133','Indica',2010);
insert into car values('KA061144','Prius',2015);
insert into car values('KA071155','Camry',2020);
insert into car values('KA01010', 'Accord', 2002);
commit;

select * from car;

insert into accident values(111,'2020-01-01','NR Road');
insert into accident values(122,'2020-02-02','Dalhousie Road');
insert into accident values(133,'2020-03-03','Henry Road');
insert into accident values(144,'2020-04-04','Beehive Road');
insert into accident values(155,'2020-05-05','Orange Street');
insert into accident values(200, '2008-12-01', 'Pinto Road');
commit;

select * from accident;

insert into owns values ('A01','KA031111');
insert into owns values ('A02','KA041122');
insert into owns values ('A03','KA051133');
insert into owns values ('A04','KA061144');
insert into owns values ('A05','KA071155');
insert into owns values('A02', 'KA01010');

commit;

select * from owns;

insert into participated values ('A01','KA031111',111, 10000);
insert into participated values ('A02','KA041122',122, 20000);
insert into participated values ('A03','KA051133',133, 30000);
insert into participated values ('A04','KA061144',144, 40000);
insert into participated values ('A05','KA071155',155, 50000);

insert into participated values('A02', 'KA01010', 200, 500);
commit;

select * from participated;

-- Query 3a
update participated 
set damage_amount = 18500
where reg_num='KA031111' and report_num=20;

select * from participated;
-- Query 3b
insert into accident values(101,'2020-12-01','Xavier Road');
insert into participated values('A01','KA031111',101, 1001);
commit;
select * from accident;
select * from participated order by damage_amount desc;
delete from participated where damage_amount < (select avg(damage_amount) from participated);
-- Query 4
select count(*) from accident where year(accident_date)=2008;
-- Query 5
select count(*) from participated where reg_num in ( select reg_num from car where model="Accord");


set @average = (select avg(damage_amount) from participated);
select  @average;
delete from participated where damage_amount<@average;
select * from participated;
select name from person where driver_id in( select driver_id from participated where damage_amount > @average);
select damage_amount from participated;
select max(damage_amount) from participated;


SELECT name , damage_amount
FROM person p
JOIN participated pt
	ON p.driver_id = pt.driver_id
WHERE  pt.damage_amount > (
SELECT AVG(damage_amount) FROM participated
);

SELECT name , damage_amount
FROM person p
JOIN participated pt
	ON p.driver_id = pt.driver_id
WHERE  pt.damage_amount > (
SELECT AVG(damage_amount) FROM participated
);