SELECT      Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.EmployeeID, Orders.OrderDate, Orders.Freight, Orders.ShipCity, Orders.ShipCountry, Orders.ShipName, [Order Details].ProductID, [Order Details].UnitPrice, 
                   [Order Details].Quantity, [Order Details].OrderID, Products.ProductName, Products.UnitsInStock, Employees.LastName, Employees.FirstName, Employees.BirthDate
INTO KU
FROM         Customers INNER JOIN
                   Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                   [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                   Products ON [Order Details].ProductID = Products.ProductID INNER JOIN
                   Employees ON Orders.EmployeeID = Employees.EmployeeID


insert into ku
select * from ku

--551000 dazu -- 1,1 Mio Ds 


alter table ku add id int identity


--Messungen   Stats
set statistics io, time on
select country, sum(unitprice*quantity) from ku
group by country
--60318
--CPU-Zeit = 281 ms, verstrichene Zeit = 148 ms.

---Idee  mehr CPUS erledigen Aufgaben schneller
--im Plan (kleinen Doppelpfeile ) = mehr CPUs

--wieviel Prozessoren verwendet eine Abfrage
--Regel: 
--wird der Kostenwert x überschritten , dann wird parallelisiert
-- default bei 5

--wieviele Prozessoren: 1 oder alle

--ist es gut, wenn er mehr verwendet

select country, sum(unitprice*quantity) from ku
group by country
option (maxdop 1)
--250ms Dauer und CPU


select country, sum(unitprice*quantity) from ku
group by country
option (maxdop 2)
--250ms Dauer und CPU



select country, sum(unitprice*quantity) from ku
group by country
option (maxdop 4)
--390ms Dauer 100ms


select country, sum(unitprice*quantity) from ku
group by country
option (maxdop 8) --kein Effekt ausser mehr CPU


where ...... > Wert1    50000 Seiten    31
where --    > wert2     5000 Seiten      4,9

--2 CPUs 250ms 130ms


--zuerst auf dem Server Grundeinstellung (Setup)


--Im Plan:. repartion Stream und Gather Stream INdiz für zuviele CPUs
--anzahl der Kerne: max 8 
--kostenschwellwert 5  auf 25  bei OLAP (Datawarehouse) und auf 50 bei OLTP (Shop)


--Seit SQL 2016 SCOPED DATABASE
--todo: Kostenschwert 25