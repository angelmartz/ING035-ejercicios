
SELECT "Creando base de datos...";

-- Creación de la tabla `Clientes`
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Email VARCHAR(100),
    Telefono VARCHAR(20)
);

-- Creación de la tabla `Categorias`
CREATE TABLE Categorias (
    CategoriaID INT PRIMARY KEY,
    Nombre VARCHAR(50)
);

-- Creación de la tabla `Productos`
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Precio DECIMAL(10, 2),
    CategoriaID INT,
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);

-- Creación de la tabla `Pedidos`
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY,
    ClienteID INT,
    Fecha DATE,
    Total DECIMAL(10, 2),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Creación de la tabla `DetallesPedido`
CREATE TABLE DetallesPedido (
    DetalleID INT PRIMARY KEY,
    PedidoID INT,
    ProductoID INT,
    Cantidad INT,
    PrecioUnitario DECIMAL(10, 2),
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);


SELECT "Insertando Datos de Ejemplo...";

-- Insertando datos en la tabla `Clientes`
INSERT INTO Clientes (ClienteID, Nombre, Email, Telefono) VALUES
(1, 'Juan Pérez', 'juan@example.com', '555-1234'),
(2, 'Ana García', 'ana@example.com', '555-5678');

-- Insertando datos en la tabla `Categorias`
INSERT INTO Categorias (CategoriaID, Nombre) VALUES
(1, 'Electrónica'),
(2, 'Libros');

-- Insertando datos en la tabla `Productos`
INSERT INTO Productos (ProductoID, Nombre, Precio, CategoriaID) VALUES
(1, 'Laptop', 800.00, 1),
(2, 'Smartphone', 600.00, 1),
(3, 'Libro de SQL', 30.00, 2),
(4, 'Libro de Python', 45.00, 2);

-- Insertando datos en la tabla `Pedidos`
INSERT INTO Pedidos (PedidoID, ClienteID, Fecha, Total) VALUES
(1001, 1, '2023-10-01', 850.00),
(1002, 2, '2023-10-05', 30.00);

-- Insertando datos en la tabla `DetallesPedido`
INSERT INTO DetallesPedido (DetalleID, PedidoID, ProductoID, Cantidad, PrecioUnitario) VALUES
(1, 1001, 1, 1, 800.00),
(2, 1001, 3, 1, 30.00),
(3, 1002, 3, 1, 30.00);

SELECT "Uso de Operadores Lógicos AND, OR, y NOT";

-- Seleccionar productos de la categoría "Electrónica" cuyo precio sea mayor a 500
SELECT * FROM Productos
WHERE CategoriaID = 1 AND Precio > 500;

-- Seleccionar clientes cuyo nombre sea 'Juan Pérez' o cuyo email termine en 'example.com'
SELECT * FROM Clientes
WHERE Nombre = 'Juan Pérez' OR Email LIKE '%@example.com';

-- Seleccionar productos que no pertenezcan a la categoría "Libros"
SELECT * FROM Productos
WHERE NOT CategoriaID = 2;

SELECT "Uso de GROUP BY";

-- Obtener el total de ventas por categoría
SELECT c.Nombre AS Categoria, SUM(d.PrecioUnitario * d.Cantidad) AS TotalVentas
FROM Productos p
JOIN DetallesPedido d ON p.ProductoID = d.ProductoID
JOIN Categorias c ON p.CategoriaID = c.CategoriaID
GROUP BY c.Nombre;

SELECT "Uso de HAVING para Filtrar Resultados Agregados";

-- Mostrar categorías con ventas totales mayores a 100
SELECT c.Nombre AS Categoria, SUM(d.PrecioUnitario * d.Cantidad) AS TotalVentas
FROM Productos p
JOIN DetallesPedido d ON p.ProductoID = d.ProductoID
JOIN Categorias c ON p.CategoriaID = c.CategoriaID
GROUP BY c.Nombre
HAVING SUM(d.PrecioUnitario * d.Cantidad) > 100;


SELECT "Diferencia entre WHERE y HAVING";

-- Mostrar productos de la categoría "Libros" con precio mayor a 40
SELECT * FROM Productos
WHERE CategoriaID = 2 AND Precio > 40;

-- Mostrar categorías de productos cuyo precio total de venta supera los 100
SELECT c.Nombre AS Categoria, SUM(d.PrecioUnitario * d.Cantidad) AS TotalVentas
FROM Productos p
JOIN DetallesPedido d ON p.ProductoID = d.ProductoID
JOIN Categorias c ON p.CategoriaID = c.CategoriaID
GROUP BY c.Nombre
HAVING SUM(d.PrecioUnitario * d.Cantidad) > 100;

SELECT "Subconsulta en WHERE";

-- Seleccionar productos cuyo precio es mayor al precio promedio de todos los productos
SELECT Nombre, Precio
FROM Productos
WHERE Precio > (SELECT AVG(Precio) FROM Productos);

SELECT "Subconsulta Correlacionada";

-- Subconsulta correlacionada: Seleccionar clientes que hayan gastado más de 500 en un pedido
SELECT Nombre
FROM Clientes c
WHERE EXISTS (
    SELECT 1
    FROM Pedidos p
    WHERE p.ClienteID = c.ClienteID AND p.Total > 500
);

SELECT "Subconsulta No Correlacionada";

-- Subconsulta no correlacionada: Seleccionar productos con precio mayor al promedio
SELECT Nombre, Precio
FROM Productos
WHERE Precio > (SELECT AVG(Precio) FROM Productos);

SELECT "Tablas Derivadas";

-- Calcular el precio promedio solo de productos de electrónica
SELECT Categoria, AVG(Precio) AS PrecioPromedio
FROM (
    SELECT p.Nombre, p.Precio, c.Nombre AS Categoria
    FROM Productos p
    JOIN Categorias c ON p.CategoriaID = c.CategoriaID
    WHERE c.Nombre = 'Electrónica'
) AS ProductosElectronicos
GROUP BY Categoria;

SELECT "Uso de JOIN para Combinar Tablas";

-- Seleccionar nombre de cliente y nombre de producto de cada pedido
SELECT cl.Nombre AS Cliente, pr.Nombre AS Producto, dp.Cantidad
FROM Pedidos p
JOIN Clientes cl ON p.ClienteID = cl.ClienteID
JOIN DetallesPedido dp ON p.PedidoID = dp.PedidoID
JOIN Productos pr ON dp.ProductoID = pr.ProductoID;

SELECT "Uso de JOIN para Combinar Tablas (LEFT JOIN)";

-- Seleccionar nombre de cliente y nombre de producto de cada pedido
SELECT cl.Nombre AS Cliente, pr.Nombre AS Producto, dp.Cantidad
FROM Pedidos p
JOIN Clientes cl ON p.ClienteID = cl.ClienteID
LEFT JOIN DetallesPedido dp ON p.PedidoID = dp.PedidoID
LEFT JOIN Productos pr ON dp.ProductoID = pr.ProductoID;

SELECT "Uso de JOIN para Combinar Tablas (RIGHT JOIN)";

-- Seleccionar nombre de cliente y nombre de producto de cada pedido
SELECT cl.Nombre AS Cliente, pr.Nombre AS Producto, dp.Cantidad
FROM Pedidos p
RIGHT JOIN Clientes cl ON p.ClienteID = cl.ClienteID
JOIN DetallesPedido dp ON p.PedidoID = dp.PedidoID
RIGHT JOIN Productos pr ON dp.ProductoID = pr.ProductoID;

SELECT "Uso de UNION para Unir Resultados";
-- Obtener todos los nombres de clientes y productos en una lista (sin duplicados)
SELECT Nombre FROM Clientes
UNION
SELECT Nombre FROM Productos;
