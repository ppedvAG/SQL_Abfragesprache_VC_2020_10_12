-- tempor�re Tabellen
-- temporary tables


/*
	-- lokale tempor�re Tabellen
	-- existiert nur in der aktuellen Session
	-- #Tabellenname



	-- globale tempor�re Tabellen
	-- Zugriff auch aus anderen Sessions
	-- ##Tabellenname


	-- h�lt nur so lange, wie Verbindung (bzw. Session) besteht


	-- theoretisch d�rfen wir tempor�re Tabellen auch l�schen
	

*/


SELECT CustomerID, Freight
INTO #t1
FROM Orders
WHERE ShipCountry = 'Germany'


SELECT *
FROM #t1


SELECT OrderID, OrderDate
INTO ##t2
FROM Orders
WHERE ShipCountry = 'Germany'


SELECT *
FROM ##t2


