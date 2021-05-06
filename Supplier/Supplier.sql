create database supplierdb;
use supplierdb;

create table catalog(
	sid int,
    pid int,
    cost int
);

create table supplier(
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





