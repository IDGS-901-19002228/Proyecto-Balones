
GO
USE balonEvo;


INSERT INTO Role (id, name, description)
VALUES
    (1, 'Administrador', 'Rol con acceso completo'),
    (2, 'Empleado', 'Rol estándar de usuario'),
	(3, 'Cliente', 'Rol estandar compras')

SELECT * FROM Role;
SELECT * FROM Usuarios;

-- Insertar un nuevo usuario con su rol
DECLARE
	@p_Nombre NVARCHAR(255),
    @p_ApellidoPaterno NVARCHAR(255),
    @p_ApellidoMaterno NVARCHAR(255),
    @p_Edad INT,
    @p_Sexo NVARCHAR(10),
    @p_Telefono NVARCHAR(20),
    @p_Direccion NVARCHAR(255),
    @p_Correo NVARCHAR(50),
    @p_Contrasenia NVARCHAR(100),
    @p_FechaRegistro DATETIME,
	@p_Estatus NVARCHAR(20),
    @p_RoleId INT;

-- Asigna valores a los parámetros
SET @p_Nombre = 'Juan';
SET @p_ApellidoPaterno = 'Pérez';
SET @p_ApellidoMaterno = 'Gómez';
SET @p_Edad = 30;
SET @p_Sexo = 'Masculino';
SET @p_Telefono = '1234567890';
SET @p_Direccion = 'Calle 123, Villas san juan';
SET @p_Correo = 'juanPerez@example.com';
SET @p_Contrasenia = 'juanito_123';
SET @p_FechaRegistro = '2023-05-05 08:30:00';
SET @p_RoleId = 1;

EXEC RegistrarUsuarioConRol
    @p_Nombre = @p_Nombre,
    @p_ApellidoPaterno = @p_ApellidoPaterno,
    @p_ApellidoMaterno = @p_ApellidoMaterno,
    @p_Edad = @p_Edad,
    @p_Sexo = @p_Sexo,
    @p_Telefono = @p_Telefono,
    @p_Direccion = @p_Direccion,
    @p_Correo = @p_Correo,
    @p_Contrasenia = @p_Contrasenia,
    @p_FechaRegistro = @p_FechaRegistro,
	@p_Estatus = @p_Estatus,
    @p_RoleId = @p_RoleId;


-- Insertar otro usuario con un rol diferente
EXEC RegistrarUsuarioConRol
    @p_Nombre = 'María',
    @p_ApellidoPaterno = 'López',
    @p_ApellidoMaterno = 'García',
    @p_Edad = 28,
    @p_Sexo = 'Femenino',
    @p_Telefono = '9876543210',
    @p_Direccion = 'Avenida 456, Otra Ciudad',
    @p_Usuario = 'maria456',
    @p_Contrasenia = 'clave456',
    @p_RoleId = 2;


EXEC GetAllUsuarios;

-- Insertar un proveedor con información
EXEC sp_InsertarProveedor
    @nombre = 'Jorge Ramírez',
    @empresa = 'SportExtreme',
    @rfc = 'SXT124567',
    @telefono = '5557890123',
    @correo = 'jorge@sportextreme.com';


select * from Receta;
EXEC GetAllUsuarios;
EXEC sp_GetAllProveedores;
EXEC sp_GetAllClientes;
EXEC sp_GetAllProductos;
EXEC sp_MostrarMateriasPrimasActivas;
EXEC sp_verCompras;
EXEC sp_verCompras2;
EXEC sp_MostrarRecetas;
EXEC sp_VerVentasPorMes;
EXEC sp_ClientesQueMasCompraron;
EXEC sp_MostrarVentas;
EXEC sp_MostrarVentasConDetalles;
-- ##################################################################
DECLARE @clienteId INT;
SET @clienteId = 4; -- Cambia esto al ID del cliente deseado

EXEC sp_MostrarProductosEnCarrito
    @idCliente = @clienteId;

-- ##################################################################
EXEC sp_ActualizarProducto
    @id = 6,
    @nombre = 'Balon Wilson',
    @imagen = 'https',
    @descripcion = 'Balon talla 20',
    @precio = 200,
    @stock = 20;



EXEC sp_InsertarCliente
    @nombre = 'Fernando Puga',
    @usuario = 'Fpuga_20',
    @correo = 'carlospuga39@gmail.com',
    @contrasenia = 'yerik';



DECLARE @vIduser INT = 3;
DECLARE @vIdProveedor INT = 4;
DECLARE @vFolio VARCHAR(40) ='2wsde2q';
DECLARE @vidProducto INT = 8;
DECLARE @vcantidad INT = 100;
DECLARE @vprecio FLOAT = 1200;

EXEC sp_InsertarCompra @vIduser, @vIdProveedor, @vFolio, @vidProducto, @vcantidad, @vprecio;





--SELECT CURRENT_USER;

--SELECT name
--FROM sys.server_principals
--WHERE type_desc = 'SQL_LOGIN';

--CREATE LOGIN Fernando WITH PASSWORD = 'yerik2012';

--GRANT SELECT, INSERT, UPDATE, DELETE ON NombreDeTabla TO NuevoUsuario;

--USE balonEvo;
--ALTER ROLE db_datareader ADD MEMBER Fernando;
--ALTER ROLE db_datawriter ADD MEMBER Fernando;

--SELECT name
--FROM sys.database_principals
--WHERE type = 'S' AND name = 'Fernando';

--CREATE USER Fernando FOR LOGIN Fernando;

