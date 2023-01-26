select country, sum(freight) as Fracht
from kundeumsatz k
where freight < 1
group by country
order by country

select country as Land, sum(freight) as Fracht
from kundeumsatz k
where freight < 1
group by Land
order by country


select country as Land, sum(freight) as Fracht, k.
from kundeumsatz k
where freight < 1 --and Land = 'UK' and k.
group by country-- having Fracht < 1000
order by 2,1


----> FROM  --> JOINS (der  Reihe nach + ALIAS) --> WHERE --> GROUP BY --> HAVING --> SELECT (Berrch/Alias)--> ORDER BY
--->TOP DISTINCT --> AUSGABE





--keine gute Idee
select country as Land, sum(freight) as Fracht
from kundeumsatz k
---where freight < 1 --and Land = 'UK' and k.
group by country having freight < 1
order by Land, Fracht

--tu nie etwas in havng filtern, was ein where kann
--im having sllte immer eine AGG-Filter  sein






