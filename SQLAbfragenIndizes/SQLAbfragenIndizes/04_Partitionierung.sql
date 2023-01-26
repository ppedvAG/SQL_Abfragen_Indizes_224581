/*

Abfrage .. Ergebnis 10 Zeilen



TABA  10000


TABB 100000



UMSATZTABELLE

--> U2021 U2020 U2019 U2018
select * from umsatz... !


*/



create table u2021(id int, jahr int, spx int)
create table u2020(id int, jahr int, spx int)
create table u2019(id int, jahr int, spx int)
create table u2018(id int, jahr int, spx int)


create view Umsatz
as
select * from u2021
UNION ALL --keine Suche nach doppelten Werten
select * from u2020
UNION ALL
select * from u2019
UNION ALL
select * from u2018


select * from umsatz where jahr = 2020 --bisher null vorteil!!

ALTER TABLE dbo.u2019 ADD CONSTRAINT
	CK_u2019 CHECK (jahr=2019)

--Jeder Hinweis für den SQL, welche Werte wo sein oder nicht sein dürfen
--zB NULL oder NOT NULL

--Nachteil: kein identity!! wenn du INS UP DEL machen willst in die Sicht
---         PK muss eindeutig auf Sicht: PK auf ID und Jahr


--sequenz

select next value for seqID



--          doof für Wartung

---Part Sicht!!




--Dateigruppe ?

--Part Funktion
--Part Schema



create table test2 (id int) --auf Primary

create table test3 (id int) on HOT

create table test4 ( id int) on  DG1, DG2 , DG3



--PARTITIONIERUNG

--4 Dateigruppen: bis100 bis200 bis5000 rest

create table t1(id int) ON ARCHIV

--F()   schema Dgruppe

----------M--------1.1.1999---------------------
--  1               2                            3

create table tab (id int) ON SCHEMA(Spalte5)

create partition scheme schname
as
partition fzahl()  to (Dg1, DG2, DG3)
---                               1      2      3




--PART FUNKTION


---------------100---------------200--------------------- int

--       1                2                   3

--max 15000 Bereiche 

create partition function fZahl(int)
as
RANGE LEFT FOR  VALUES (100,200)
--Grenzen sind inkl

select $partition.fzahl(117) ---2

--geht auch datetime..ja
---geht auch varchar(50).. ja
--geht auch .. nein !!  XML ja .. nein!


--Part Schema

create partition scheme schZahl
as
PARTITION fzahl to (bis100,bis200, rest)
--                     1.    2.    3.

drop table ptab

create table ptab
	(id int identity,
	 nummer int, 
	 spx char(4100)) ON schzahl(nummer)



set statistics io, time off --soll es schnell sein? Dann schalte auch noch den tats Plan aus 

declare @i as int = 1

begin tran
	while @i<=20000
	begin 
		insert into ptab select @i, 'XY'
		set @i+=1 
	end
commit


set statistics io, time on
select * from ptab where nummer = 1170 --100 Seiten


select * from ptab where id = 117


select * from ptab where nummer = 1117 --19800


--Neue Grenze im Bereich 5000

--------------100-------200-----------------------5000-------------------

--PTAB  F() SCHEMA DGR
--nie TABELLE


--DGruppe mit dazunehmen: bis5000

alter partition scheme schZahl next used bis5000


select $partition.fzahl(nummer), min(nummer), max(nummer), count(*)
from ptab
group by $partition.fzahl(nummer)
--es werden nur 3 gebaucht, obwohl das Schema 4 verwenden könnte

alter partition function fzahl() split range (5000)


select * from ptab where nummer = 1117


--Idee Grenze muss weg
--100

--PTAB, F() SCHEMA DGR
--nie PTAB, F()!, SCHEMA..nö, DGR...nö


---100! -----200----5000---------
--    1            2       3


alter partition function fzahl() merge range (100)

--Welche nehmen wir gerade her Dateigruppe f()







CREATE PARTITION SCHEME [schZahl] AS PARTITION
[fZahl] TO ([bis200], [bis5000], [rest])
GO
CREATE PARTITION FUNCTION [fZahl](int) AS 
RANGE LEFT FOR VALUES (200, 5000)
GO

--Daten werden immer verschoben in die DGruppe, die verantworlich ist

--jede Abfrage, die nicht auf die nummer führt zu eine
--komplette SCAN


--Archivieren
--Frage: wie heisst der SQL Befehl zum Verschieben von Datensätzen


--es gibt keinen... ausser bei der Partionierung


create table archiv(id int not null --kein identity
					, nummer int
					, spx char(4100)) on bis200


alter table ptab switch partition 1 to archiv --das war alles

select * from archiv

select * from ptab where id = 10



--100MB/Sek verschieben
--Part 1000 MB --> Archiv? -----10 Sek hihihi
---0,  sek


CREATE PARTITION SCHEME [schZahl] AS PARTITION
[fZahl] ALL TO ([bis200], [bis5000], [rest])
GO
CREATE PARTITION FUNCTION [fZahl](int) AS 
RANGE LEFT FOR VALUES (200, 5000)
GO









