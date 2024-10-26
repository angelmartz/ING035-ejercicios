-- Crear la tabla `Personas`
CREATE TABLE Personas (
    PersonaID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Edad INT,
    Ciudad VARCHAR(50)
);

-- Crear la tabla `Productos`
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Precio DECIMAL(10, 2),
    Categoria VARCHAR(50)
);

-- Crear la tabla `Ventas`
CREATE TABLE Ventas (
    VentaID INT PRIMARY KEY,
    ProductoID INT,
    Cantidad INT,
    Total DECIMAL(10, 2)
);


-- Insertar datos en la tabla `Personas`
INSERT INTO Personas (PersonaID, Nombre, Edad, Ciudad) VALUES
(1, 'Juan', 28, 'Ciudad A'),
(2, 'Ana', 34, 'Ciudad B'),
(3, 'Luis', 45, 'Ciudad A'),
(4, 'Sofía', 19, 'Ciudad C'),
(5, 'Natalia', 19, 'Ciudad B'),
(6, 'Jessica', 29, 'Ciudad C');

-- Insertar datos en la tabla `Productos`
INSERT INTO Productos (ProductoID, Nombre, Precio, Categoria) VALUES
(1, 'Laptop', 1200.00, 'Electrónica'),
(2, 'Smartphone', 600.00, 'Electrónica'),
(3, 'Libro A', 30.00, 'Libros'),
(4, 'Cámara', 300.00, 'Electrónica'),
(5, 'Libro B', 60.00, 'Libros');

-- Insertar datos en la tabla `Ventas`
INSERT INTO Ventas (VentaID, ProductoID, Cantidad, Total) VALUES
(1, 1, 1, 1200.00),
(2, 2, 2, 1200.00),
(3, 3, 5, 150.00),
(4, 4, 1, 300.00);

-- Esto solo sirve para el INPUT de OneCompiler
SELECT "Mostramos todos los datos de la tabla Personas";
-- Mostrar todos los datos de la tabla `Personas`
SELECT * FROM Personas;

-- Esto solo sirve para el INPUT de OneCompiler
SELECT "Mostramos todos los datos de la tabla Productos";
-- Mostrar todos los datos de la tabla `Productos`
SELECT * FROM Productos;

-- Esto solo sirve para el INPUT de OneCompiler
SELECT "Operador Logico AND: Seleccionar personas que viven en Ciudad A y tienen más de 25 años";

-- Seleccionar personas que viven en "Ciudad A" y tienen más de 25 años
SELECT * FROM Personas
WHERE Ciudad = 'Ciudad A'  -- Filtra solo las personas que viven en "Ciudad A"
AND Edad > 25;             -- Además, solo selecciona las personas con edad mayor a 25

-- Esto solo sirve para el INPUT de OneCompiler
SELECT "Operador Logico OR: Seleccionar productos que cuestan menos de 100 o que pertenecen a la categoría Libros";
-- Seleccionar productos que cuestan menos de 100 o que pertenecen a la categoría "Libros"
SELECT * FROM Productos
WHERE Precio < 100         -- Selecciona productos con precio menor a 100
OR Categoria = 'Libros';   -- O productos que pertenezcan a la categoría "Libros"

-- Esto solo sirve para el INPUT de OneCompiler
SELECT "Operador Logico NOT: Seleccionar productos que no pertenecen a la categoría Electrónica";
-- Seleccionar productos que no pertenecen a la categoría "Electrónica"
SELECT * FROM Productos
WHERE NOT Categoria = 'Electrónica';  -- Excluye productos de la categoría "Electrónica"

-- Esto solo sirve para el INPUT de OneCompiler
SELECT "Uso de GROUP BY: Calcular la cantidad total de productos vendidos por cada producto";

-- Calcular la cantidad total de productos vendidos por cada producto
SELECT ProductoID,                 -- Selecciona el identificador del producto
       SUM(Cantidad) AS TotalVendidos  -- Calcula la suma total de la cantidad vendida para cada producto
FROM Ventas
GROUP BY ProductoID;               -- Agrupa los resultados por cada producto, de modo que el total se calcule para cada grupo

-- Esto solo sirve para el INPUT de OneCompiler
SELECT "Uso de GROUP BY: Obtener el número de personas en cada ciudad";
-- Obtener el número de personas en cada ciudad
SELECT Ciudad,                     -- Selecciona la ciudad de cada persona
       COUNT(PersonaID) AS NumeroPersonas  -- Cuenta cuántas personas hay en cada ciudad
FROM Personas
GROUP BY Ciudad;                   -- Agrupa los resultados por ciudad para calcular el conteo en cada una

-- Esto solo sirve para el INPUT de OneCompiler
SELECT "Uso de HAVING: Mostrar solo los productos que han generado ventas totales mayores a 500";

-- Mostrar solo los productos que han generado ventas totales mayores a 500
SELECT ProductoID,                 -- Selecciona el identificador de cada producto
       SUM(Total) AS TotalVentas   -- Calcula el total de ventas por producto
FROM Ventas
GROUP BY ProductoID                -- Agrupa por cada producto para obtener su total de ventas
HAVING SUM(Total) > 500;           -- Muestra solo los productos cuyo total de ventas es mayor a 500

-- Esto solo sirve para el INPUT de OneCompiler
SELECT "Uso de HAVING: Mostrar ciudades con más de una persona registrada";
-- Mostrar ciudades con más de una persona registrada
SELECT Ciudad,                     -- Selecciona la ciudad de cada persona
       COUNT(PersonaID) AS NumeroPersonas  -- Cuenta cuántas personas hay en cada ciudad
FROM Personas
GROUP BY Ciudad                    -- Agrupa los resultados por ciudad
HAVING COUNT(PersonaID) > 1;       -- Muestra solo las ciudades con más de una persona registrada

-- Esto solo sirve para el INPUT de OneCompiler
SELECT "Subconsulta NO Correlacionada en WHERE: Seleccionar productos cuyo precio es mayor al precio promedio de todos los productos";
-- Seleccionar productos cuyo precio es mayor que el precio promedio de todos los productos
SELECT Nombre, Precio                -- Selecciona el nombre y precio de los productos
FROM Productos
WHERE Precio > (                     -- Solo selecciona los productos cuyo precio es mayor que:
    SELECT AVG(Precio) FROM Productos -- El precio promedio calculado para todos los productos en la tabla
);                                    -- La subconsulta se ejecuta una vez y devuelve el precio promedio total

SELECT "Podemos verificar solo la subconsulta para ver el precio promedio de todos los productos";

SELECT AVG(Precio) FROM Productos; -- El precio promedio calculado para todos los productos en la tabla


-- Esto solo sirve para el INPUT de OneCompiler
SELECT "Subconsulta NO Correlacionada en WHERE: Seleccionar personas cuya edad es mayor que la edad promedio";
-- Seleccionar personas cuya edad es mayor que la edad promedio
SELECT Nombre, Edad                  -- Selecciona el nombre y edad de las personas
FROM Personas
WHERE Edad > (                       -- Solo selecciona las personas cuya edad es mayor que:
    SELECT AVG(Edad) FROM Personas   -- La edad promedio calculada para todas las personas en la tabla
);                                   -- La subconsulta devuelve un único valor, que es la edad promedio

SELECT "Podemos verificar solo la subconsulta para ver la edad promedio de todas las personas";

SELECT AVG(Edad) FROM Personas;       -- La edad promedio calculada para todas las personas en la tabla
-- Esto solo sirve para el INPUT de OneCompiler
SELECT "Subconsulta Correlacionada en WHERE: Seleccionar personas que tienen una edad mayor que el promedio de edad de las personas en su misma ciudad";
-- Seleccionar personas que tienen una edad mayor que el promedio de edad de las personas en su misma ciudad
SELECT Nombre, Edad, Ciudad               -- Selecciona el nombre, edad y ciudad de cada persona
FROM Personas p1                          -- La tabla `Personas` se usa con alias `p1` para representar cada persona en la consulta principal
WHERE Edad > (                            -- Solo selecciona las personas cuya edad es mayor que:
    SELECT AVG(Edad)                      -- El promedio de edad calculado en la subconsulta
    FROM Personas p2                      -- La misma tabla `Personas`, pero ahora con alias `p2`
    WHERE p2.Ciudad = p1.Ciudad           -- La subconsulta solo considera personas en la misma ciudad
);                                        -- Esta subconsulta se ejecuta para cada fila en la consulta principal, calculando un promedio específico por ciudad

SELECT "Podemos verificar sacando la edad promedio por ciudad";
-- Obtener la edad promedio por cada ciudad
SELECT Ciudad,                        -- Selecciona la ciudad
       AVG(Edad) AS EdadPromedio      -- Calcula el promedio de edad para cada ciudad
FROM Personas                          -- Tabla Personas
GROUP BY Ciudad;                      -- Agrupa los resultados por ciudad

-- Esto solo sirve para el INPUT de OneCompiler
SELECT "Subconsulta Correlacionada en WHERE: Seleccionar productos cuyo precio es mayor que el precio promedio de los productos de su misma categoría";
-- Seleccionar productos cuyo precio es mayor que el precio promedio de los productos de su misma categoría
SELECT Nombre, Precio, Categoria          -- Selecciona el nombre, precio y categoría de cada producto
FROM Productos p1                         -- La tabla `Productos` se usa con alias `p1` para representar cada producto en la consulta principal
WHERE Precio > (                          -- Solo selecciona productos cuyo precio es mayor que:
    SELECT AVG(Precio)                    -- El precio promedio calculado en la subconsulta
    FROM Productos p2                     -- La misma tabla `Productos`, ahora con alias `p2`
    WHERE p2.Categoria = p1.Categoria     -- La subconsulta solo considera productos de la misma categoría
);                                        -- Esta subconsulta se ejecuta para cada fila, calculando el precio promedio específico por categoría

SELECT "Podemos verificar sacando el precio promedio por categoria";
-- Obtener el precio promedio por cada categoría de productos
SELECT Categoria,                        -- Selecciona la categoría de cada producto
       AVG(Precio) AS PrecioPromedio     -- Calcula el precio promedio de los productos en cada categoría
FROM Productos                           -- Tabla Productos
GROUP BY Categoria;                      -- Agrupa los resultados por categoría
