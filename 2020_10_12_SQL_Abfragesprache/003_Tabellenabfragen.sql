-- Tabellenabfragen
-- Select auf Tabellen
-- immer �berpr�fen, welche Datenbank verwendet wird!


USE Northwind


-- * steht f�r alle Spalten
-- * nur f�r �bungen, nicht in der Realit�t verwenden!
-- DB kann sich ver�ndern; Spalten k�nnen hinzukommen
SELECT *
FROM Customers

SELECT CompanyName
FROM Customers

SELECT	  CustomerID
		, CompanyName
--		, ...
FROM Customers


SELECT    CustomerID
		, CompanyName
		, ContactName
		, Phone
FROM Customers

-- mit neuen Spalten�berschriften:

SELECT    CustomerID AS Kundennummer
		, CompanyName AS Firmenname
		, ContactName AS Kontaktperson
		, Phone AS Telefon
FROM Customers





SELECT    CustomerID
		, CompanyName
		, ContactName
		, Phone
		, 100
		, 'Testtext'
FROM Customers



SELECT Freight * 100 AS [hundertfache Frachtkosten]
FROM Orders


SELECT	  ProductID AS ProduktID
		, ProductName AS Produktname
		, UnitPrice AS St�ckpreis
FROM Products


-- theoretisch d�rfen wir das AS weglassen
-- nicht empfohlen!
SELECT	  ProductID ProduktID
		, ProductName Produktname
		, UnitPrice St�ckpreis
FROM Products



SELECT Freight AS [Frachtkosten netto]
		, Freight*0.19 AS MwSt
		, Freight*1.19 AS Bruttofrachtkosten
FROM Orders




