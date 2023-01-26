/*

Datens‰tze werden in    Seiten gespeichert

1 Seite:
max 700 Slots
8192 bytes Volumens
8072 bytes Nutzlast
 1DS mit fixen Datentypen kann nicht mehr als 8060 bytes haben
 8 Seiten am St¸ck nennt sich Block
  Seiten werden 1 :1 in RAM geschoben

  Tab  1 DS ca 4100 bytes
  1 MIO DS
  ---> 1DS/Seite  --> 1 MIO Seiten * 8 = 8 GB   auf HDD   und    RAM


  Idee
  1 MIO  a 4000      +  1MIO  a100
  500.000           + 12500      ---> 4,1 GB     HDD      RAM
  





*/

create table t1 (id int identity, spx char(4100), spy char(4100))


use Northwind


create table txy (id int identity, spx char(4100))

-- 1DS = 1Seite

insert into txy
select 'XY'
GO 20000


--Messen der Seiteninhalte
dbcc showcontig('txy')

--- Gescannte Seiten.............................: 20000
--- Gescannte Blˆcke..............................: 2501
--- Mittlere Seitendichte (voll).....................: 50.96%

set statistics io, time on

select * from txy where id = 10 --20000 Seiten gelesen

--Wieviele Seiten hat Tabelle KU?
dbcc showcontig ('ku')
-- Gescannte Seiten.............................: 52790

alter table ku add id int identity
--Abfrage auf ID = 10 in KU
select * from ku where id = 10  --Seiten: 64923

--EIn Admin sollt eimmer Bescheid bekommen, wenn Tabellen ge‰ndert werden!!


--besser
select * from sys.dm_db_index_physical_stats(db_id(),object_id('ku'),NULL, NULL, 'detailed')
--forward record counts : 12133  zus. Seiten wg Alter Tabel add id Spalte
--IndexID 0 = HEAP
USE [Northwind]

GO


CREATE CLUSTERED INDEX [ClusteredIndex-20220722-101430] ON [dbo].[ku]
(	[City] ASC  )

select * from ku where id = 10
--nach CL ix anlegene und danach sogar wiede rlˆschen... 53600 Seiten-- 
---11000 Seiten gespart  auf HDD , in RAM und weniger CPU

---Brent Ozar sp_Blitzindex 



--Auch ne Idee--- Kompression
-- Zeilen ~   
--Datentypen komprimiert char in varchar)
--die kleineren DS in Seiten zusammengezogen--> weniger Seiten

--Seiten ~
--zuerst Zeilenkomression
--Kompressionsalgorithmus


--zu erwarten: bei viel Text besser komprimierbar, bei Zahlen weniger gut
--Kompressionsrate: 40 bis 60%



set statistics io, time on

-- SQL Neustart --> Arbeotsspeicher:  286
select * from northwind..txy
--RAM: ++160MB
--Seiten: 20000
--CPU: 250
--Dauer: 1935


--NACH KOMPRESSION ..f¸r die Anwendung transarent.. die weiss nix
--Seitenkompression:  ca 160MB -->  0,5 MB
set statistics io, time on

-- SQL Neustart --> Arbeitsspeicher:  286 -- gleich
select * from northwind..txy
--RAM: --> mehr  oder weniger-- nur die Anzahl der Seiten 30 mehr im RAM -- 500kb
--Seiten: weniger    30 Seiten
--CPU:   weniger, aber in Realit‰t eher mehr
--Dauer:   k¸rzer - -gleich

--Kompresssion  ich bezahle RAM mit CPU Leistung
-- bei CPU Mangel keine Kompression
--keine KOpresssion wenn 100 --> 80%

--Ideal: Archivdaten
--cool... Partition und Archiv l‰ﬂt sich kombinieren







