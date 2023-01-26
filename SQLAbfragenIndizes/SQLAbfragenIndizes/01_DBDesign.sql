/*

logisches Design vs physikalisches Design


Stichwörter

Primary Key    Foreign key

Normalformen 1.2.3..4.5    vs     Redundanz

1. jede Zelle ein Wert
2. PK
3.   [PK]   Vorn Nachn  PLZ ORT keine Wechselbeziehungen zw den Spalten ausserhalb des PK


Normalisierung ist langsam

Redundanz ist schnell... muss gepflegt werden: 
Trigger  ..sind nicht das schnellste
BI Logik: Prozedur regelt update ins del auf Order details , rechnet aber auch die RngSUmme in Orders aus
				der Zugriff auf Order details wird verweigert, dennoch klappts über zB Sicht der Proz

F()  ..fRngSumme als Spalte in Orders   persistente F() --m > indizierbar--> Wert ist real errechnet in der Tabelle zu finden
----kein Lösung 


Generalisierung
-best Spaltenkombis kommen in einigen Tabellen häufiger vor, daher auslagern in eig Tabelle
--Validieren



Datentypen
wie sollte man auf Datentyen trotzdem achten, wenn HDDs durchaus zig TB haben können.... 

'otto'
nvarchar(50) --UNICODE   var länge * 2
char(50) ----   fix 50
nchar(50)  --UNICODE 100fix
varchar(50) --bis zu 50 





pyhsikalisches Design
DS kommen in Seiten .. und 8 Seiten am Stück nennt sich Block
PAGE   EXTENT

1 Seiten hat einen Größe von (immer) 8192 bytes
1 Seiten kann nur 8072 bytes Nutzast besitzen
1 DS mit fixne Längen kann nur max 8060 bytes haben

*/

create table t1 (id int identity , spx char(4100), sp2 char(4100))
--Fehler beim Erstellen oder Ändern der t1-Tabelle, weil die Mindestzeilengröße 8211 betragen würde, einschließlich 7 Bytes an internen Verwaltungsbytes. Dies überschreitet die maximal zulässige Größe für Tabellenzeilen von 8060 Bytes.

--varchar(max)-->  2 GB


/*


1 DS mit fixen Längen muss in Seite passen 

1 DS hat 4100 bytes     
1MIO DS
---> Seiten 1 MIO DS --> 8 GB    --> 1 MIO * 8 kb

---Seiten kommen 1:1 in RAM

*/
create database demoDB;
GO

use demodb;
GO

create table t1 (id int identity, spx char(4100));
GO

insert into t1
select 'XY'
GO 20000 --Sekunden 12

--20000 DS a 4100 --> 80MB

dbcc showcontig ('t1')
--- Gescannte Seiten.............................: 20000
--- Blockscanfragmentierung...................: 0.20%
- Bytes frei pro Seite (Durchschnitt).....................: 3983.0
-- Mittlere Seitendichte (voll).....................: 50.79%


select 400000*8  /5

--auch ein NULL Wert kostet Platz

set statistics io, time on  -- 
--IO Anzahl der Seiten (Anzahl der Seiten + 8 muss von HDD in RAM gelsen werden)
--time  CPU Dauer in ms   Dauer in ms   gesamte Dauer

--Statistik Messung + Plan  nie in Schleifen !!

select * from t1




