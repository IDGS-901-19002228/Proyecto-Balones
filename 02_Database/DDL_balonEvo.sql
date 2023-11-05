/**************************************************
 * BASE DE DATOS balonEvo            *
 *                                   *
 * Archivo de BASE DE DATOS (DDL).   *
 **************************************************/
 
 /*
	Versión:                         3.0
    Fecha:                           13/08/23 23:23:00
    Autor:                           Carlos Fernando Ledezma Puga
    Email:                           19002228@alumnos.utleon.edu.mx
    Comentarios:                     Esta es la tercera version de la base datos, 
									 así como crecion del archivo DDL de BalonEvo.
*/

GO
DROP DATABASE IF EXISTS balonEvo;
GO
CREATE DATABASE balonEvo;
GO
USE balonEvo;


GO
CREATE TABLE Role (
    id INT PRIMARY KEY,
    name VARCHAR(80) NOT NULL,
    description VARCHAR(255)
);

--DROP TABLE Usuarios2;
GO
CREATE TABLE Usuarios2 (
    Id INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(255),
    ApellidoPaterno NVARCHAR(255),
    ApellidoMaterno NVARCHAR(255),
    Edad INT,
    Sexo NVARCHAR(10),
    Telefono NVARCHAR(20),
    Direccion NVARCHAR(255),
    Usuario NVARCHAR(50),
    Contrasenia NVARCHAR(100),
	--fechaRegistro DATETIME,
	rol NVARCHAR(40),
    Estatus NVARCHAR(20),
    --role_id INT,
    --FOREIGN KEY (role_id) REFERENCES Role(id)
);
--CREATE TABLE Usuarios (
--    Id INT PRIMARY KEY IDENTITY,
--    Nombre NVARCHAR(255),
--    ApellidoPaterno NVARCHAR(255),
--    ApellidoMaterno NVARCHAR(255),
--    Edad INT,
--    Sexo NVARCHAR(10),
--    Telefono NVARCHAR(20),
--    Direccion NVARCHAR(255),
--    Correo NVARCHAR(50),
--    Contrasenia NVARCHAR(100),
--	fechaRegistro DATETIME,
--    Estatus NVARCHAR(20),
--    role_id INT,
--    FOREIGN KEY (role_id) REFERENCES Role(id)
--);

GO
CREATE TABLE user_roles (
    userId INT,
    roleId INT,
    FOREIGN KEY (userId) REFERENCES Usuarios(Id),
    FOREIGN KEY (roleId) REFERENCES Role(id),
    PRIMARY KEY (userId, roleId)
);

GO
CREATE TABLE Productos (
    id INT PRIMARY KEY IDENTITY,
    nombre VARCHAR(200) NOT NULL,
    imagen VARCHAR(255) NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    precio INT NOT NULL,
    stock INT NOT NULL,
    estatus NVARCHAR(20) NOT NULL
);

GO
CREATE TABLE Proveedor (
    id INTEGER PRIMARY KEY IDENTITY,
    nombre VARCHAR(200) NOT NULL,
    empresa VARCHAR(120) NOT NULL,
    rfc VARCHAR(13) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    correo VARCHAR(120) NOT NULL,
    estatus NVARCHAR(20) NOT NULL
);

--DROP TABLE Clientes2;
GO
CREATE TABLE Clientes2 ( 
    id INTEGER PRIMARY KEY IDENTITY,
    nombre VARCHAR(100) NOT NULL,
	usuario VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    contrasenia VARCHAR(100) NOT NULL,
	rol NVARCHAR(40) NOT NULL,
    estatus NVARCHAR(20) NOT NULL,
	--role_id INT,
 --   FOREIGN KEY (role_id) REFERENCES Role(id)
);
--CREATE TABLE Clientes ( 
--    id INTEGER PRIMARY KEY IDENTITY,
--    nombre VARCHAR(100) NOT NULL,
--	usuario VARCHAR(100) NOT NULL,
--    correo VARCHAR(100) NOT NULL,
--    contrasenia VARCHAR(100) NOT NULL,
--    estatus NVARCHAR(20) NOT NULL,
--	role_id INT,
--    FOREIGN KEY (role_id) REFERENCES Role(id)
--);


GO
CREATE TABLE Direccion2 (
    id INTEGER PRIMARY KEY IDENTITY,
    nombreCompleto VARCHAR(40),
    calleNumero VARCHAR(50),
    codigoPostal VARCHAR(5),
    telefono VARCHAR(10),
	idcliente INT,
	FOREIGN KEY (idcliente) REFERENCES Clientes2(id),
);

GO
CREATE TABLE Pedido2 (
    id INTEGER PRIMARY KEY IDENTITY,
    fecha DATETIME,
    folio VARCHAR(50),
    estatus NVARCHAR(20) NOT NULL,
	idcliente INT,
	FOREIGN KEY (idcliente) REFERENCES Clientes2(id),
    direccion INT,
	FOREIGN KEY (direccion) REFERENCES Direccion(id),
);

GO
CREATE TABLE detallePedido2 (
    id INT PRIMARY KEY IDENTITY,
	idPedido INT,
	FOREIGN KEY (idPedido) REFERENCES Pedido2(id),
	idProducto INT,
	FOREIGN KEY (idProducto) REFERENCES Productos(id),
    cantidad INT
);


GO
CREATE TABLE Compra (
    id_compra_materia INT PRIMARY KEY IDENTITY,
    fecha DATE,
	cantidad INT,
    costo_compra INT,
	estatus NVARCHAR(20),
	idProveedor INT,
	FOREIGN KEY (idProveedor) REFERENCES Proveedor(id),
	id_materia_prima INT,
	FOREIGN KEY (id_materia_prima) REFERENCES MateriaPrima(id),
);

--CREATE TABLE compra_materia (
--    id_compra_materia INT PRIMARY KEY IDENTITY,
--	idProveedor INT,
--	FOREIGN KEY (idProveedor) REFERENCES Proveedor(id),
--    fecha DATE,
--	estatus NVARCHAR(20)
--);

--GO
--CREATE TABLE detalle_compra_materia_prima (
--    id_detalle_compra_ INT PRIMARY KEY IDENTITY,
--    id_compra_materia INT,
--	FOREIGN KEY (id_compra_materia) REFERENCES compra_materia(id_compra_materia),
--    id_materia_prima INT,
--	FOREIGN KEY (id_materia_prima) REFERENCES MateriaPrima(id),
--    cantidad INT,
--    costo_compra INT
--);


GO
CREATE TABLE MateriaPrima (
    id INT PRIMARY KEY IDENTITY,
    nombre VARCHAR(80),
	descripcion VARCHAR(200),
    cantidad INT,
    unidad_medida VARCHAR(10),
	stock INT NOT NULL,
    estatus NVARCHAR(20) NOT NULL
);


 --DROP TABLE Receta;
GO
CREATE TABLE Receta (
    id INT PRIMARY KEY IDENTITY,
    nombre VARCHAR(200) NOT NULL,
	ingredientesMateriaP NVARCHAR(MAX) NOT NULL,
    cantidad INT,
    cantidad_producto INT,
	estatus NVARCHAR(20),
	idProducto INT,
	FOREIGN KEY (idProducto) REFERENCES Productos(id),
	idMateriaP INT,
	FOREIGN KEY (idMateriaP) REFERENCES MateriaPrima(id),
);


GO
CREATE TABLE Carrito2 (
    id INTEGER PRIMARY KEY IDENTITY,
    idcliente INT,
	FOREIGN KEY (idcliente) REFERENCES Clientes2(id),
    idProducto INT,
	FOREIGN KEY (idProducto) REFERENCES Productos(id),
    cantidad INT
);

GO
CREATE TABLE Tarjeta2 (
    id INT PRIMARY KEY IDENTITY,
	nombreTarjeta VARCHAR(50),
    numTarjeta VARCHAR(16),
	fechaVencimiento VARCHAR(14),
    ccv VARCHAR(3),
	idcliente INT,
	FOREIGN KEY (idcliente) REFERENCES Clientes2(id),
);

GO
CREATE TABLE Inversion (
    id INT PRIMARY KEY IDENTITY,
    monto FLOAT NOT NULL,
    fecha DATETIME NOT NULL
);


GO
CREATE TABLE Venta2 (
	id INT PRIMARY KEY IDENTITY,
	idcliente INT,
	FOREIGN KEY (idcliente) REFERENCES Clientes2(id),
	fecha DATE,
	estatus NVARCHAR(20)
);

GO
CREATE TABLE detalleVenta2 (
	id INT PRIMARY KEY IDENTITY,
	idVenta INT,
	FOREIGN KEY (idVenta) REFERENCES Venta2(id),
	idProducto INT,
	FOREIGN KEY (idProducto) REFERENCES Productos(id),
	cantidad INT,
    precioUnitario INT,
);
