/*

Tu nie:
DB erstellen  mit einfachen create database
			oder per SSMS einfacher Klick

			Tabellen erstellen und dort  ID gedankenlos mit PK setzen

			Datentypen m?ssen gut ?berlegt


	 PK  ---> Beziehung FK

	 Aufgabe des PK... Beziehung
	 Muss aber eindeutig sein  1:N


	 Beziehung
	 Aufgabe PK FK zu KOntrollieren 1:N
	 Ersatzalternativ: Trigger 	 schlechteste Idee


	 Normalisierung  Normalform	  Gegenteil von Redundanz


	 1NF: atomar pro Zelle ein Wert  (datum eigtl nicht atomar)


	 like '%siemens.de'	 Pr?fixEmail  Emaildom



	 2NF: PK (eine Spalte oder auch mehr Spalten)

	 3 NF: beidseitig korrelierende Spalten w?re verboten
	 --braucht mehr joins

	 Redundanz ist schnell


	 Datentypen:

	 Vorname: 'otto'

	 varchar(50)   ... Otto		4 
	 char(50)  ...'Otto    '    50
	 nchar(50)	'Otto  '		50 * 100
	 nvarchar(50) 'otto'		4 *2
	 text()						depricated seit 2005 (image)


	 immer Unicode obwohl unn?tig

	 Datetime aber date h?tte gereicht


Wieviele Bestelllungen gibts aus dem Jahr 1997 Orderdate?
 */
select * from orders where orderdate like '%1997%'	  --408	  langsam
select * from orders where year(orderdate) = 1997	  --408	  langsam
select * from orders where orderdate 
		between '1.1.1997' and '31.12.1997 23:59:59.999'	--411??
		--falsch aber schnell
select * from orders where 

datetime (ms) ist aber nur auf 2 bis 3 ms genau
datetime2 ns

durch logisches Design k?nnen physikalisch Fehler entstehen


create table t11 (id int identity, spx char(4100), spy char(4100))
-_Error wg8060














logisches Design vs physikalisches Design


Stichw?rter

Primary Key    Foreign key

Normalformen 1.2.3..4.5    vs     Redundanz

1. jede Zelle ein Wert
2. PK
3.   [PK]   Vorn Nachn  PLZ ORT keine Wechselbeziehungen zw den Spalten ausserhalb des PK


Normalisierung ist langsam

Redundanz ist schnell... muss gepflegt werden: 
Trigger  ..sind nicht das schnellste
BI Logik: Prozedur regelt update ins del auf Order details , rechnet aber auch die RngSUmme in Orders aus
				der Zugriff auf Order details wird verweigert, dennoch klappts ?ber zB Sicht der Proz

F()  ..fRngSumme als Spalte in Orders   persistente F() --m > indizierbar--> Wert ist real errechnet in der Tabelle zu finden
----kein L?sung 


Generalisierung
-best Spaltenkombis kommen in einigen Tabellen h?ufiger vor, daher auslagern in eig Tabelle
--Validieren



Datentypen
wie sollte man auf Datentyen trotzdem achten, wenn HDDs durchaus zig TB haben k?nnen.... 

'otto'
nvarchar(50) --UNICODE   var l?nge * 2
char(50) ----   fix 50
nchar(50)  --UNICODE 100fix
varchar(50) --bis zu 50 





pyhsikalisches Design
DS kommen in Seiten .. und 8 Seiten am St?ck nennt sich Block
PAGE   EXTENT

1 Seiten hat einen Gr??e von (immer) 8192 bytes
1 Seiten kann nur 8072 bytes Nutzast besitzen
1 DS mit fixne L?ngen kann nur max 8060 bytes haben

*/

create table t1 (id int identity , spx char(4100), sp2 char(4100))
--Fehler beim Erstellen oder ?ndern der t1-Tabelle, weil die Mindestzeilengr??e 8211 betragen w?rde, einschlie?lich 7 Bytes an internen Verwaltungsbytes. Dies ?berschreitet die maximal zul?ssige Gr??e f?r Tabellenzeilen von 8060 Bytes.

--varchar(max)-->  2 GB


/*


1 DS mit fixen L?ngen muss in Seite passen 

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




