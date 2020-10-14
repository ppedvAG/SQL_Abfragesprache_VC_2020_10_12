-- DISTINCT

-- in welchen L�ndern haben wir Kunden?

-- erste Idee:
SELECT Country
FROM Customers
-- Ergebnis: L�nder von allen Kunden (1 pro Kunde); also auch Mehrfacheintr�ge, wenn wir mehrere Kunden in einem Land haben

-- L�sung:
SELECT DISTINCT Country
FROM Customers
-- damit bekommen wir eine Liste von allen L�ndern (21, statt 91)


-- wenn ich die Ausgabereihenfolge bestimmen will:
SELECT DISTINCT Country
FROM Customers
ORDER BY Country


-- mehrere Spalten m�glich?
-- ja
-- machen die Sinn?
-- von Fall zu Fall entscheiden
SELECT DISTINCT Country, CustomerID
FROM Customers
-- in diesem Fall bringt es nichts!
-- wieder so viele Ergebnisse, wie Kunden!!


SELECT DISTINCT Country, City
FROM Customers
-- damit bekommen wir so viele Ergebnisse, wie es St�dte gibt
-- manche L�nder stehen wieder mehrfach da, n�mlich dann, wenn es in einem Land mehr als 1 Stadt gibt, in der wir Kunden haben


SELECT DISTINCT Country, Region
FROM Customers


-- Liste von allen St�dten, in denen wir Kunden haben?
SELECT DISTINCT City
FROM Customers


-- Liste von allen L�ndern, in denen Angestellte wohnen?
SELECT DISTINCT Country
FROM Employees
-- UK, USA

-- kann das stimmen?
SELECT Country
FROM Employees
ORDER BY Country
-- stimmt!







