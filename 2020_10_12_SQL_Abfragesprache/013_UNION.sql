-- UNION


SELECT 'Testtext1'
UNION
SELECT 'Testtext2'


-- Liste von allen Kontaktpersonen?

-- Idee:
SELECT	  c.ContactName
		, c.Phone
		, s.ContactName
		, s.Phone
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
				 INNER JOIN Products p ON od.ProductID = p.ProductID
				 INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
-- keine gute Idee!!
-- hier stehen nur die Kunden, die schon etwas bestellt haben
-- und nur die Supplier, die schon etwas geliefert haben!!
-- ... und wir bekommen damit auch keine Liste, sondern entsprechend mehr Spalten



-- Liste von Kontaktpersonen:
-- mit UNION
SELECT	  ContactName
		, Phone
FROM Customers
UNION
SELECT	  ContactName
		, Phone
FROM Suppliers




-- funktioniert nicht:
-- in einer Spalte müssen die gleichen Datentypen drinstehen
SELECT	'Testtext', 123
UNION
SELECT 'Test', 'Hallo'
-- Conversion failed when converting the varchar value 'Hallo' to data type int.


-- funktioniert nicht:
-- wir müssen bei beiden die gleiche Spaltenanzahl verwenden
SELECT 'Testtext', 123
UNION
SELECT 'Test'


-- wir dürften die Spalte mit NULL auffüllen
-- SINN? Von Fall zu Fall entscheiden, ob das Sinn macht
SELECT 'Testtext', 123
UNION
SELECT 'Test', NULL


-- wir können Daten in andere (kompatible) Datentypen umwandeln
-- SINN?? Von Fall zu Fall entscheiden, ob das Sinn macht!
SELECT	'Testtext', 'Hallo'
UNION
SELECT 'Test', CAST(123 AS varchar)


-- funktioniert NICHT:
-- CustomerID = Text (ALFKI), EmployeeID = Zahl (1-9)
SELECT CustomerID, ContactName
FROM Customers
UNION
SELECT EmployeeID, LastName
FROM Employees

-- funktioniert nicht:
-- braucht gleiche Anzahl an Spalten
SELECT CompanyName, ContactName, Phone
FROM Customers
UNION
SELECT ContactName, Phone
FROM Suppliers


-- theoretisch dürfen wir die "fehlende" Spalte auch selbst befüllen:
-- SINN?? Von Fall zu Fall entscheiden, ob das Sinn macht!
SELECT CompanyName, ContactName, Phone
FROM Customers
UNION
SELECT 'XXX', ContactName, Phone
FROM Suppliers



-- theoretisch dürfen statt der fehlenden Spalte auch NULL einsetzen:
-- SINN?? Von Fall zu Fall entscheiden, ob das Sinn macht!
SELECT CompanyName, ContactName, Phone
FROM Customers
UNION
SELECT NULL, ContactName, Phone
FROM Suppliers



-- die Spalten müssen nicht gleich heißen, damit UNION funktioniert
-- es müssen nur gleich viele Spalten sein und kompatible Datentypen
SELECT Country, Phone -- AS Tel
FROM Customers
UNION
SELECT Country, HomePhone
FROM Employees




-- "ABC"-Analyse


SELECT	  ContactName
		, Phone
		, 'C' AS Category
FROM Customers
UNION
SELECT	  ContactName
		, Phone
		, 'S' -- AS Category
FROM Suppliers
ORDER BY Category --, ContactName -- sinnvoll! 
-- ORDER BY nach dem, wonach ich es geordnet haben möchte, nicht abhängig vom Index, den die DB grade verwendet
-- ORDER BY gilt für die gesamte Abfrage! (nicht nur für den unteren oder oberen Teil)




-- Gib alle Regionen der Kunden und der Angestellten aus.
-- Füge eine Kategorie „C“ für Customer und „E“ für Employee hinzu.
SELECT    Region
		, 'E' AS Category
FROM Employees
UNION
SELECT    Region
		, 'C' -- AS Category
FROM Customers
-- ORDER BY Category

-- ohne die, wo "nix" drinsteht
SELECT    Region
		, 'E' AS Category
FROM Employees
WHERE Region IS NOT NULL
UNION
SELECT    Region
		, 'C' -- AS Category
FROM Customers
WHERE Region IS NOT NULL
-- ORDER BY Category



-- ACHTUNG: UNION macht ein DISTINCT!!
SELECT 'Testtext'
UNION
SELECT 'Testtext'



-- wenn ich Mehrfacheinträge haben möchte:
SELECT 'Testtext'
UNION ALL
SELECT 'Testtext'

-- wenn ich alle haben möchte:
-- UNION ALL
SELECT    Region
		, 'E' AS Category
FROM Employees
UNION ALL 
SELECT    Region
		, 'C' -- AS Category
FROM Customers
ORDER BY Category



-- wenn ich MIT SICHERHEIT weiß, dass es keine Mehrfacheinträge gibt,
-- können wir auch mit UNION ALL arbeiten
-- wenn kein DISTINCT gemacht wird, weil es keine Mehrfacheinträge gibt,
-- ist UNION ALL schneller (weil nicht überprüft werden muss, ob es Mehrfacheinträge gibt)
SELECT	  ContactName
		, Phone
FROM Customers
UNION
SELECT	  ContactName
		, Phone
FROM Suppliers



SELECT	  ContactName
		, Phone
FROM Customers
UNION ALL
SELECT	  ContactName
		, Phone
FROM Suppliers

-- Pause:
SELECT DATEADD(mi, 15, GETDATE()) -- 2020-10-14 15:55:52.600



-- niedrigster und höchster Frachtkostenwert in einer Liste:
-- OrderID, Freight, 'niedrigster Frachtkostenwert'
-- OrderID, Freight, 'höchster Frachtkostenwert'


-- Idee:
SELECT TOP 1 OrderID, Freight, 'niedriegster Wert' AS Wert
FROM Orders
ORDER BY Freight
UNION -- UNION funktioniert hier NICHT, weil ORDER BY für gesamte Abfrage gilt
SELECT TOP 1 OrderID, Freight, 'höchster Wert' AS Wert
FROM Orders
ORDER BY Freight DESC



-- mit temporärer Tabelle gehts!
SELECT TOP 1 OrderID, Freight, 'niedriegster Wert' AS Wert
INTO #n -- Name egal; # für lokale temporäre Tabelle
FROM Orders
ORDER BY Freight


SELECT TOP 1 OrderID, Freight, 'höchster Wert' AS Wert
INTO #h
FROM Orders
ORDER BY Freight DESC

SELECT *
FROM #n
UNION
SELECT *
FROM #h
-- ORDER BY Freight


