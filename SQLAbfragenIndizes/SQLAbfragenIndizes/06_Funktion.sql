/*

speicherbar wie Prozeduren
Parametrisierbar
Skalawertfunktion, Tabellenwertfunktionen

!! F() sind immer schlecht, bis das Gegenteil bewiesen ist
F() werden  i.d.r nicht parl

Was geht nicht: #tab Begin try MADOPX > 1


*/

use Northwind

select * from customers  where customerid like 'A%' --SEEK

select * from customers  where left(customerid,1) = 'A' --SCAN   

--seit SQL 2019 könnne einfache Skalarwertf() optmiert werden
---allerdings: einfache!!!!
--SQL macht eigtl Unterabfragen daraus



--F() sind ultrapraktisch


select f(spalte) , f(wert) from f(Wert) wher f(Spalte) > f(wert)



select * from  [Order Details]


select dbo.fRngSumme(orderid)  --  10248--> 440


create function fdemo(@par1 int, @par2 int) resturns int
as
BEGIN
			return (select .).
END


create function fRngSumme(@bestid int)  returns money
as
BEGIN
		--Testszenario : select dbo.frngsumme(10248) --> 440
		return(select sum(unitprice*quantity) from [Order Details] where orderid = @bestid)
END

select dbo.frngSumme(10248)

alter table orders add RngSumme as dbo.fRngSumme(orderid)

select rngsumme, Orderid, orderdate from orders where rngsumme < 1000

--Messungen: 
--Pläne  
--set statistics

set statistics io, time on


select rngsumme, Orderid, orderdate from orders where rngsumme < 1000

select * from [Order Details]
select * from orders

select orderid, sum(unitprice*quantity) from [Order Details] group by orderid








