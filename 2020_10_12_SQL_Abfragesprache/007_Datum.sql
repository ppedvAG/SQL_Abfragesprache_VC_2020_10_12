-- Datumsfunktionen

-- g�ngige Datentypen
-- datetime (auf mehrere Millisekunden genau)
-- datetime2 (auf ~ 100 Nanosekunden genau)
-- date
-- time


/*
	-- Datumsintervalle:

		year, yyyy, yy ...................... Jahr
		quarter, qq, q ...................... Quartal
		month, MM, M ........................ Monat
		week, ww, wk ........................ Woche
		day, dd, d .......................... Tag
		hour, hh ............................ Stunde
		minute, mi, n ....................... Minute
		second, ss, s........................ Sekunde
		millisecond, ms ..................... Millisekunde
		nanosecond, ns ...................... Nanosekunde

		weekday, dw, w ...................... Wochentag (dw = day of the week)
		dayofyear, dy, y .................... Tag des Jahres

*/




SELECT BirthDate
FROM Employees

-- **************************** Datum abfragen *************************************
-- datetime (ms)
SELECT GETDATE()

-- datetime2
SELECT SYSDATETIME()


-- ********************************* DATEADD ******************************************
-- Datumsberechnungen: etwas zum Datum hinzu- oder wegz�hlen

-- Format: Schreibweise systemabh�ngig!

SELECT DATEADD(hh, 10, '2020-10-13') -- 2020-10-13 10:00:00.000

SELECT DATEADD(hh, 10, '2020-10-13 11:28') -- 2020-10-13 21:28:00.000


SELECT DATEADD(hh, 10, GETDATE())

-- wir d�rfen mit negativem Vorzeichen arbeiten, wenn wir etwas abziehen wollen:
SELECT DATEADD(hh, -10, GETDATE())



-- ***************************** DATEDIFF *******************************************
-- Differenz zwischen zwei Daten bilden

-- wie viele Tage bis zum n�chsten Feiertag?
SELECT DATEDIFF(dd, '2020-10-13', '2020-10-31') -- 18


SELECT DATEDIFF(dd, '2020-10-31', '2020-10-13') -- -18 (mit negativem Vorzeichen)


-- mit aktuellem Datum:
SELECT DATEDIFF(dd, GETDATE(), '2020-10-31') -- 18


-- *************************** DATEPART *******************************************
-- R�ckgabedatentyp: int

SELECT DATEPART(dd, '2020-10-13')
SELECT DATEPART(dd, GETDATE())
SELECT DATEPART(MM, GETDATE())
SELECT DATEPART(yyyy, GETDATE())


-- ************************ DATENAME ************************************************
-- Datename macht eigentlich nur f�r die Datumsteile Sinn, die wir als Text ausschreiben k�nnen:
-- dw (Wochentag)
-- month

-- bringt nix:
SELECT DATENAME(dd, '2020-10-13') -- 13 -- dieses Intervall macht nicht viel Sinn


SELECT DATENAME(dw, GETDATE()) -- Tuesday
SELECT DATENAME(month, GETDATE()) -- October


-- �bungen:


-- Welches Datum haben wir in 38 Tagen?
SELECT DATEADD(dd, 38, GETDATE()) -- 2020-11-20 11:57:20.540
SELECT DATEADD(dd, 38, '2020-10-13') -- 2020-11-20 00:00:00.000


-- Welcher Wochentag war Dein Geburtstag?
SELECT DATENAME(dw, '1981-04-22') -- Wednesday



-- Vor wie vielen Jahren kam der erste Star Wars Film in die Kinos? (25. Mai 1977 )

SELECT DATEDIFF(yyyy, '1977-05-25', '2020-10-13') -- 43

SELECT DATEDIFF(yyyy, '1977-05-25', GETDATE())

-- wir brauchen eigentlich nur das Jahr:

SELECT DATEDIFF(yyyy, '1977', GETDATE()) -- 43



-- In welchem Quartal liegt der �sterreichische Nationalfeiertag (26.10.)?
SELECT DATEPART(qq, '2020-10-26') -- 4



--Gib Tag, Monat und Jahr Deines Geburtstages in einer eigenen Spalte mit der jeweils entsprechenden �berschrift an
-- Tag	 Monat	 Jahr
--  22	  04	 1981


SELECT    DATEPART(yyyy, '1981-04-22') AS Jahr
		, DATEPART(MM, '1981-04-22') AS Monat
		, DATEPART(dd, '1981-04-22') AS Tag

-- mit DB:
SELECT	  BirthDate
		, DATEPART(yyyy, BirthDate) AS Jahr
		, DATEPART(MM, BirthDate) AS Monat
		, DATEPART(dd, BirthDate) AS Tag
FROM Employees



-- Gib die Datumsdifferenz zwischen Lieferdatum und Wunschtermin der Bestellungen aus.

-- was ist die Lieferverz�gerung:
SELECT    ShippedDate
		, RequiredDate
		, DATEDIFF(dd, RequiredDate, ShippedDate)
FROM Orders


-- wie viele Tage habe ich noch Zeit, um zu liefern:
SELECT    ShippedDate
		, RequiredDate
		, DATEDIFF(dd, ShippedDate, RequiredDate)
FROM Orders


-- Pause:
SELECT DATEADD(mi, 60, GETDATE()) -- 2020-10-13 13:32:34.383


-- Gib die Bestellnummer,
--     den Wunschtermin,
--      das Lieferdatum und
--     die Lieferverz�gerung aus.
--Ergebnisse von Bestellungen, die noch nicht geliefert wurden, sollen nicht ausgegeben werden.

SELECT	  OrderID
		, RequiredDate
		, ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverz�gerung
FROM Orders
WHERE ShippedDate IS NOT NULL


-- ************************* ORDER BY ***************************************************
-- Ordne das Ergebnis absteigend von der gr��ten zur kleinsten Lieferverz�gerung:


SELECT	  OrderID
		, RequiredDate
		, ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverz�gerung
FROM Orders
WHERE ShippedDate IS NOT NULL
ORDER BY Lieferverz�gerung

-- wenn nichts weiter angegeben wird, ordnet ORDER BY aufsteigend (vom kleinsten zum gr��ten Wert)

SELECT	  OrderID
		, RequiredDate
		, ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverz�gerung
FROM Orders
WHERE ShippedDate IS NOT NULL
ORDER BY Lieferverz�gerung ASC -- ASC = ascending (aufsteigend) = Default


SELECT	  OrderID
		, RequiredDate
		, ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverz�gerung
FROM Orders
WHERE ShippedDate IS NOT NULL
ORDER BY Lieferverz�gerung DESC -- DESC = descending (absteigend; vom gr��ten zum kleinsten Wert)




