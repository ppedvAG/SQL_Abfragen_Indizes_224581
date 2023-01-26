--A) Proz  B)  Sichten  C) Funktionen  D) adhoc Abfragen 

--normalerweise--
--langsam  ---- >schnell

--  adhoc   F()      Proz     Sicht
--  F()      adhoc -- View--      Proz




--Proz                                             F()   





--SICHT


use demodb

create table slf (id int identity, stadt int, land int)

insert into slf (stadt, land) values (10, 100)

insert into slf (stadt, land) values (20, 200)

insert into slf (stadt, land) values (30, 300)

select * from slf

--Cool ..ne Sicht..
--Securitygründe, oder komplexes zu vereinfachen

create view vslf
as
select * from slf

select * from vslf
--sicht und adhoc sind gleich schnell

--neue Spalte Fluss mit 1000er Werte
alter table slf add fluss int
update slf set fluss = id* 1000

select * from vslf --der * kommt nicht an..  evtl merkt er sich select id, stadt , land
select * from slf

alter table slf drop column Land
select * from vslf --jetzt bekommen wir falsche Werte, weil Land nicht existiert, aber angezeigt wird mit Werten aus Fluss!!!

--wie kann man das verhindern??

--und nochmal
drop table slf
drop view vslf

create table slf (id int identity, stadt int, land int)

insert into slf (stadt, land) values (10, 100)
insert into slf (stadt, land) values (20, 200)
insert into slf (stadt, land) values (30, 300)

select * from slf

--Cool ..ne Sicht..
--Securitygründe, oder komplexes zu vereinfachen

create view dbo.vslf WITH SCHEMABINDING --_!!
as
select id, stadt, land from dbo.slf --korrekte Schema angeben    Schema = Ordner

select * from vslf
--sicht und adhoc sind gleich schnell

--neue Spalte Fluss mit 1000er Werte
alter table slf add fluss int
update slf set fluss = id* 1000

select * from vslf --der * kommt nicht an..  evtl merkt er sich select id, stadt , land
select * from slf

alter table slf drop column Land --geht nicht.. ohne vorher die Sicht anzupassen..
select * from vslf 




--Was soll man mit Sichten nicht machen

create view vKU
as
SELECT      Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.EmployeeID, Orders.OrderDate, Orders.ShipVia, Orders.Freight, Orders.ShipName, Orders.ShipCity, Orders.ShipCountry, Employees.LastName, 
                   Employees.FirstName, [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName, Products.UnitsInStock

FROM         Customers INNER JOIN
                   Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                   Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                   [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                   Products ON [Order Details].ProductID = Products.ProductID

select * from vku



--Wieviele Kunden gibts es in Germany (customerid, Country)

--328

select country, count(*)  from vku 
where country = 'Germany'
group by country


select country, count(*)  from customers 
where country = 'Germany'
group by country

--Sicht nie zweckentfremden, sondern nur dann anwenden, wenn wirklich alle Tabellen gbraucht werden , die in der Sicht genannt werden
--Die Sicht macht immer das , was drin steht.. ..zb join über 14 Tabellen




















