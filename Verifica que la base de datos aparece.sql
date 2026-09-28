-- Verifica que la base de datos aparece en la lista
SHOW DATABASES;

-- Selecciona la base de datos y muestra las tablas creadas
USE db_library;
SHOW TABLES;

-- Confirma que los datos de prueba se insertaron correctamente (deberías ver 10 libros)
SELECT * FROM Books;