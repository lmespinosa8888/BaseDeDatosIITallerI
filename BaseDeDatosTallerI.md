# Consultas SQL - Biblioteca

## SUBCONSULTAS

* Obtener los nombres y apellidos de los usuarios que han reservado un libro de la categoría **"Fiction"**.
* Mostrar el título y autor de los libros que están prestados.

## OPERADORES DE CONJUNTO

* Encontrar los títulos de los libros que han sido reservados, pero no prestados.
* Encontrar los títulos de los libros que han sido prestados, pero no reservados.

## EXPRESIONES CONDICIONALES

* Mostrar un listado de todos los libros con un estado:

  * **"Disponible"** si `AvailableCopies > 0`.
  * **"Agotado"** si no hay copias disponibles.
* Mostrar los usuarios y clasificarlos como:

  * **"Activo"** si tienen libros prestados.
  * **"Sin actividad"** si no tienen libros prestados.

## ANÁLISIS AGREGADO CON GROUP BY Y HAVING

* Encontrar las categorías con más de **3 libros**.
* Mostrar los usuarios que tienen más de **2 libros reservados**.

## INNER JOIN

* Mostrar un listado de los nombres de usuarios y los títulos de los libros que han sido prestados.
* Mostrar los nombres de usuarios y los títulos de los libros que han reservado.

## LEFT JOIN

* Listar todos los libros junto con el nombre del usuario que los reservó, si es que existe una reserva.
* Listar todos los usuarios junto con el título del libro prestado, si existe un préstamo.

## RIGHT JOIN

* Listar todos los libros junto con los nombres de los usuarios que los han reservado, incluyendo los libros que no tienen reservas.
* Listar todos los usuarios junto con los títulos de los libros prestados, incluyendo los usuarios que no han realizado préstamos.

## FUNCIONES ESPECIALIZADAS

* Mostrar un listado de los títulos de los libros en mayúsculas.
* Mostrar los nombres de los usuarios concatenados en un solo campo (**Nombre Completo**).

## FUNCIONES DE FECHA

* Calcular el número de días que han pasado desde que se reservó cada libro.
* Mostrar los préstamos que están pendientes de devolución (`ReturnDate IS NULL`).

## FUNCIONES DE AGREGACIÓN

* Calcular el total de copias disponibles para cada categoría.
* Encontrar el número total de libros prestados por cada usuario.
