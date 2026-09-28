-- BaseDeDatosTallerI_LuisEspinosa.sql

#SUBCONSULTAS

-- Query 1: Obtener los nombres y apellidos de los usuarios que han reservado un libro de la categoría "Fiction".
SELECT FirstName, LastName
FROM users
WHERE UserID IN (
    SELECT UserID
    FROM Reservations
    WHERE BookID IN (
        SELECT BookID
        FROM Books
        WHERE CategoryID IN (
            SELECT CategoryID
            FROM BookCategories
            WHERE CategoryName = 'Fiction'
        )  
     )
);

-- Query 2: Mostrar el título y autor de los libros que están prestados.

SELECT Title, Author
FROM Books
WHERE BookID IN (
    SELECT BookID
    FROM Loans
    WHERE ReturnDate IS NULL
);

#  OPERADORES DE CONJUNTO

-- Query 3: Encontrar los títulos de los libros que han sido reservados, pero no prestados.

SELECT Title
FROM Books
WHERE BookID IN (
    SELECT BookID 
    FROM Reservations
    EXCEPT
    SELECT BookID 
    FROM Loans
);

-- Query 4: Encontrar los títulos de los libros que han sido prestados, pero no reservados.

SELECT Title
FROM Books
WHERE BookID IN (
    SELECT BookID 
    FROM Loans
    EXCEPT
    SELECT BookID 
    FROM Reservations
);

# EXPRESIONES CONDICIONALES

-- Query 5: Mostrar un listado de todos los libros con un estado: "Disponible" si AvailableCopies > 0, o "Agotado" si no hay copias disponibles.

SELECT Title, Author,
    CASE
        WHEN AvailableCopies > 0 THEN 'Disponible'
        ELSE 'Agotado'
    END AS Estado
FROM Books;

-- Query 6: Mostrar los usuarios y clasifícalos como "Activo" si tienen libros prestados y "Sin actividad" si no.

SELECT FirstName, LastName,
    CASE
        WHEN UserID IN (SELECT DISTINCT UserID FROM Loans WHERE ReturnDate IS NULL) THEN 'Activo'
        ELSE 'Sin actividad'
    END AS Clasificacion
FROM users;     

# ANÁLISIS AGREGADO CON GROUP BY Y HAVING

-- Query 7: Encontrar las categorías con más de 3 libros.

SELECT c.CategoryName, COUNT(b.BookID) AS TotalBooks
FROM BookCategories c
INNER JOIN Books b ON c.CategoryID = b.CategoryID
GROUP BY c.CategoryID, c.CategoryName
HAVING COUNT(b.BookID) > 3;

-- Query 8: Mostrar los usuarios que tienen más de 2 libros reservados.

SELECT u.FirstName, u.LastName, COUNT(r.ReservationID) AS TotalReservations
FROM Users u
INNER JOIN Reservations r ON u.UserID = r.UserID
GROUP BY u.UserID, u.FirstName, u.LastName
HAVING COUNT(r.ReservationID) > 2;  

# INNER JOIN

-- Query 9: Mostrar un listado de los nombres de usuarios y los títulos de los libros que han sido prestados.

SELECT u.FirstName, u.LastName, b.Title
FROM Users u
INNER JOIN Loans l ON u.UserID = l.UserID
INNER JOIN Books b ON l.BookID = b.BookID;

-- Query 10: Mostrar los nombres de usuarios y los títulos de los libros que han reservado.

SELECT u.FirstName, u.LastName, b.Title
FROM Users u
INNER JOIN Reservations r ON u.UserID = r.UserID
INNER JOIN Books b ON r.BookID = b.BookID;      

# LEFT JOIN

 -- Query 11: Listar todos los libros junto con el nombre del usuario que los reservó, si es que existe una reserva.

SELECT b.Title, u.FirstName, u.LastName
FROM Books b
LEFT JOIN Reservations r ON b.BookID = r.BookID
LEFT JOIN Users u ON r.UserID = u.UserID;

 -- Query 12: Listar todos los usuarios junto con el título del libro prestado, si existe un préstamo.

SELECT u.FirstName, u.LastName, b.Title
FROM Users u
LEFT JOIN Loans l ON u.UserID = l.UserID
LEFT JOIN Books b ON l.BookID = b.BookID;

# RIGHT JOIN

-- Query 13: Listar todos los libros junto con los nombres de los usuarios que los han reservado, incluyendo los libros que no tienen reservas.

SELECT b.Title, u.FirstName, u.LastName
FROM Users u
INNER JOIN Reservations r ON u.UserID = r.UserID
RIGHT JOIN Books b ON r.BookID = b.BookID;

-- Query 14: Listar todos los usuarios junto con los títulos de los libros prestados, incluyendo los usuarios que no han realizado préstamos.

SELECT u.FirstName, u.LastName, b.Title
FROM Books b
INNER JOIN Loans l ON b.BookID = l.BookID
RIGHT JOIN Users u ON l.UserID = u.UserID;

# FUNCIONES ESPECIALIZADAS

-- Query 15: Mostrar un listado de los títulos de los libros en mayúsculas.

SELECT UPPER(Title) AS TitleUpperCase
FROM Books;

-- Query 16: Mostrar los nombres de los usuarios concatenados en un solo campo (Nombre Completo).

SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Users;

# FUNCIONES DE FECHA

-- Query 17: Calcular el número de días que han pasado desde que se reservó cada libro.

SELECT r.ReservationID, b.Title, DATEDIFF(CURDATE(), r.ReservationDate) AS DaysSinceReservation
FROM Reservations r
INNER JOIN Books b ON r.BookID = b.BookID;

-- Query 18: Mostrar los préstamos que están pendientes de devolución (ReturnDate es NULL).

SELECT l.LoanID, u.FirstName, b.Title, l.LoanDate
FROM Loans l
INNER JOIN Users u ON l.UserID = u.UserID
INNER JOIN Books b ON l.BookID = b.BookID
WHERE l.ReturnDate IS NULL;

# FUNCIONES DE AGREGACIÓN

-- Query 19: Calcular el total de copias disponibles para cada categoría

SELECT c.CategoryName, SUM(b.AvailableCopies) AS TotalAvailableCopies
FROM BookCategories c
INNER JOIN Books b ON c.CategoryID = b.CategoryID
GROUP BY c.CategoryName;

-- Query 20: Encontrar el número total de libros prestados por cada usuario.

SELECT u.FirstName, u.LastName, COUNT(l.LoanID) AS TotalLoans
FROM Users u
LEFT JOIN Loans l ON u.UserID = l.UserID
GROUP BY u.UserID, u.FirstName, u.LastName;
