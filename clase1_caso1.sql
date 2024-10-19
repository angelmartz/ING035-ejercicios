-- Creamos la tabla "Libros" con los campos ID, Titulo, Autor, Genero y Cantidad_Stock
-- ID es la llave primaria de la tabla la defininimos con PRIMARY KEY
-- PRIMARY KEY nos indica que el campo ID es único y no puede repetirse
-- Titulo, Autor, Genero y Cantidad_Stock son campos de la tabla
-- NOT NULL nos indica que el campo no puede ser nulo
-- varchar(100) nos indica que el campo es de tipo texto y puede tener hasta 100 caracteres
-- int unsigned nos indica que el campo es de tipo entero y solo puede tener valores positivos
-- Este SQL puede variar dependiendo del motor de base de datos que estemos utilizando
-- En este caso estamos utilizando MySQL
-- Para otros motores de base de datos como PostgreSQL, SQL Server, Oracle, etc
-- La sintaxis puede variar
CREATE TABLE Libros (
  ID INTEGER PRIMARY KEY,
  Titulo varchar(100) NOT NULL,
  Autor varchar(100) NOT NULL,
  Genero varchar(100),
  Cantidad_Stock int unsigned
);

-- Insertamos algunos datos de ejemplo
-- INSERT INTO es la acción de SQL, "Libros" nos indica de que tabla
-- (ID, Titulo, Autor, Genero, Cantidad_Stock) nos indica los campos que vamos a insertar
-- VALUES nos indica los valores que vamos a insertar
-- (1, "Cien años de Soledad", "Gabriel Garcia Marquez", "Ficción", 12) es el primer registro
-- (2, "La sombra del viento", "Carlos Ruiz", "Misterio", 8) es el segundo registro
-- (3, "Don Quijote de la Mancha", "Miguel de Cervantes", "Clasicos", 6) es el tercer registro
INSERT INTO Libros (ID, Titulo, Autor, Genero, Cantidad_Stock) VALUES 
(1, "Cien años de Soledad", "Gabriel Garcia Marquez", "Ficción", 12),
(2, "La sombra del viento", "Carlos Ruiz", "Misterio", 8),
(3, "Don Quijote de la Mancha", "Miguel de Cervantes", "Clasicos", 6);

-- Hacemos un select para ver todos los datos
-- El * indica que nos muestre todos los campos de la tabla
SELECT * FROM Libros;



-- Actualizamos la cantidad de stock del libro "La sombra del viento" a 0
-- UPDATE es la acción de SQL, "Libros" nos indica de que tabla
-- SET definimos que campo queremos actualizar y su nuevo valor
-- Cantidad_Stock = 0 es el nuevo valor que le asignamos
-- WHERE es el condicional.
-- En este caso actualizara cantidad de stock a 0
-- De todos los registros que coincidan con el Titulo = "La sombra del viento"
UPDATE Libros
SET Cantidad_Stock = 0
WHERE Titulo = "La sombra del viento";

-- Hacemos un nuevo select para ver todos los datos datos actualizados
SELECT * FROM Libros;

-- Hacemos un SELECT para mostrar los libros que tienen más o igual a 5 unidades en stock
-- SELECT ID, Titulo, Cantidad_Stock nos indica que campos especificos queremos mostrar.
-- FROM Libros nos indica de que tabla queremos obtener los datos
-- WHERE Cantidad_Stock >= 6 es el condicional que nos indica que solo queremos los registros que tengan 6 o más unidades en stock
SELECT ID, Titulo, Cantidad_Stock 
FROM Libros 
WHERE Cantidad_Stock >= 6;


-- Caso: Nos pidieron agregar un nuevo campo a la tabla Libros, para la Editorial
-- ALTER TABLE es la acción de SQL, "Libros" nos indica de que tabla
-- ADD COLUMN Editorial varchar(50) es la acción que agrega un nuevo campo a la tabla
-- varchar(50) nos indica que el campo es de tipo texto y puede tener hasta 50 caracteres
-- AFTER Autor nos indica que el campo Editorial se agregara después del campo Autor
ALTER TABLE Libros
ADD COLUMN Editorial varchar(50) AFTER Autor;

-- Hacemos un nuevo select para ver que se agrego el campo Editorial
-- Ya que no insertamos datos en el campo Editorial, este aparecerá como NULL
SELECT * FROM Libros;

-- Actualizamos todos los registros de la tabla Libros
-- SET Editorial = "Sin Editorial" es el nuevo valor que le asignamos al campo Editorial
-- No utilizamos WHERE por lo que se actualizara todos los registros de la tabla
-- SIEMPRE tener cuidado con el UPDATE ya que no se puede deshacer
-- Siempre es recomendable hacer un SELECT antes de hacer un UPDATE
-- Para asegurarnos que estamos actualizando los registros correctos
-- SIEMPRE utilizar WHERE con el condicional correcto
-- Si no se utiliza WHERE se actualizara todos los registros de la tabla
UPDATE Libros SET Editorial = "Sin Editorial";

-- Hacemos un nuevo select para ver que se actualizaron todos los registros
SELECT * FROM Libros;

-- Actualizamos el libro con ID = 1
-- SET Editorial = "Planeta" es el nuevo valor que le asignamos al campo Editorial
-- WHERE ID = 1 es el condicional que nos indica que solo queremos actualizar el registro con ID = 1
-- En este caso actualizara el registro con ID = 1
UPDATE Libros 
SET Editorial = "Planeta" 
WHERE ID = 1;

-- Hacemos un nuevo select para ver que se actualizo el registro con ID = 1
SELECT * FROM Libros
WHERE ID = 1;


-- Queremos Eliminar el libro con ID = 2
-- Hacemos un SELECT para ver que datos nos regresa
SELECT * FROM Libros
WHERE ID = 2;

-- Eliminamos el libro con ID = 2
-- DELETE es la acción de SQL, "Libros" nos indica de que tabla
-- WHERE es el condicional.
-- En este caso eliminara el registro con ID = 2
-- SIEMPRE tener cuidado con el DELETE ya que no se puede deshacer
-- Siempre es recomendable hacer un SELECT antes de hacer un DELETE
-- Para asegurarnos que estamos eliminando el registro correcto
-- SIEMPRE utilizar WHERE con el condicional correcto
-- Si no se utiliza WHERE se eliminaran todos los registros de la tabla
DELETE FROM Libros WHERE ID = 2;

-- Hacemos un nuevo select para verificar que el libro con ID = 2 fue eliminado
SELECT * FROM Libros
WHERE ID = 2;

-- Hacemos un nuevo select para ver todos los datos y vemos que el ID = 2 fue eliminado

SELECT * FROM Libros;

-- Haremos un DELETE sin condicional
DELETE FROM Libros;

-- En el nuevo select vemos que no hay registros en la tabla
-- No hay forma de recuperar los registros eliminados
-- SIEMPRE tener cuidado con el DELETE
-- Solo podemos recuperar los registros eliminados si tenemos un respaldo de la base de datos
SELECT * FROM Libros;