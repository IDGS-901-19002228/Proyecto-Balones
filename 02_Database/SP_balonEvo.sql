
GO
USE balonEvo;



-- DROP PROCEDURE RegistrarUsuarioConRol;
-- Sp insertar usuarios administrativos
--DROP PROCEDURE RegistrarUsuarioConRol;
GO
CREATE PROCEDURE RegistrarUsuarioConRol
    @p_Nombre NVARCHAR(255),
    @p_ApellidoPaterno NVARCHAR(255),
    @p_ApellidoMaterno NVARCHAR(255),
    @p_Edad INT,
    @p_Sexo NVARCHAR(10),
    @p_Telefono NVARCHAR(20),
    @p_Direccion NVARCHAR(255),
    @p_Correo NVARCHAR(50),
    @p_Contrasenia NVARCHAR(100),
    @p_Estatus NVARCHAR(20),
    @p_RoleName NVARCHAR(50)
AS
BEGIN
    DECLARE @v_UserId INT;
    DECLARE @v_RoleId INT;
    
    -- Obtener el ID del rol
    SELECT @v_RoleId = id FROM Role WHERE name = @p_RoleName;
    
    -- Insertar en la tabla Usuarios con estatus por defecto
    INSERT INTO Usuarios (
        Nombre, ApellidoPaterno, ApellidoMaterno, Edad, Sexo,
        Telefono, Direccion, Correo, Contrasenia, fechaRegistro, Estatus, role_id
    )
    VALUES (
        @p_Nombre, @p_ApellidoPaterno, @p_ApellidoMaterno, @p_Edad, @p_Sexo,
        @p_Telefono, @p_Direccion, @p_Correo, @p_Contrasenia, GETDATE(), 'Activo', @v_RoleId
    );
    
    -- Obtener el ID del usuario recién registrado
    SET @v_UserId = SCOPE_IDENTITY();
    
    -- Insertar en la tabla user_roles para asignar el rol al usuario
    INSERT INTO user_roles (userId, roleId)
    VALUES (@v_UserId, @v_RoleId);
    
    -- No es necesario COMMIT, SQL Server maneja transacciones automáticamente
    
    SELECT 'Usuario registrado exitosamente.' AS Resultado;
END;


-- DROP PROCEDURE GetAllUsuarios;
-- Sp mostrar usuarios administrativos
GO
CREATE PROCEDURE GetAllUsuarios
AS
BEGIN
    SELECT
        u.Id,
        u.Nombre,
        u.ApellidoPaterno,
        u.ApellidoMaterno,
        u.Edad,
        u.Sexo,
        u.Telefono,
        u.Direccion,
        u.Correo,
		u.fechaRegistro,
        u.Contrasenia,
        u.Estatus,
        r.name AS Rol
    FROM Usuarios u
    JOIN user_roles ur ON u.Id = ur.userId
    JOIN Role r ON ur.roleId = r.id;
END;


-- DROP PROCEDURE IF EXISTS ActualizarUsuario;
-- Sp actualizar usuarios administrativos
GO
CREATE PROCEDURE ActualizarUsuario
    @p_Id INT,
    @p_Nombre NVARCHAR(255),
    @p_ApellidoPaterno NVARCHAR(255),
    @p_ApellidoMaterno NVARCHAR(255),
    @p_Edad INT,
    @p_Sexo NVARCHAR(10),
    @p_Telefono NVARCHAR(20),
    @p_Direccion NVARCHAR(255),
    @p_Correo NVARCHAR(50),
    @p_Contrasenia NVARCHAR(100)
AS
BEGIN
    UPDATE Usuarios
    SET 
        Telefono = @p_Telefono,
        Direccion = @p_Direccion,
        Contrasenia = @p_Contrasenia
    WHERE Id = @p_Id;

    SELECT 'Datos de usuario actualizados exitosamente.' AS Resultado;
END;


-- DROP PROCEDURE IF EXISTS DesactivarUsuario;
-- Sp Eliminar usuarios administrativos 'Inactivo'
GO
CREATE PROCEDURE DesactivarUsuario
    @p_Id INT
AS
BEGIN
    UPDATE Usuarios
    SET Estatus = 'Inactivo'
    WHERE Id = @p_Id;

    SELECT 'Usuario desactivado exitosamente.' AS Resultado;
END;

-- ###################################################################################################################################################################

-- SP DE PRODUCTOS

-- SP DE INSERTAR PRODUCTOS
GO
CREATE PROCEDURE sp_InsertarProducto (
    @nombre VARCHAR(200),
    @imagen VARCHAR(255),
    @descripcion VARCHAR(200),
    @precio INT,
    @stock INT
) AS
BEGIN
    INSERT INTO Productos (nombre, imagen, descripcion, precio, stock, estatus)
    VALUES (@nombre, @imagen, @descripcion, @precio, @stock, 'Activo');
END;

-- SP ACTUALIZAR PRODUCTOS
GO
CREATE PROCEDURE sp_ActualizarProducto (
    @id INT,
    @nombre VARCHAR(200),
    @imagen VARCHAR(255),
    @descripcion VARCHAR(200),
    @precio INT,
    @stock INT
) AS
BEGIN
    UPDATE Productos
    SET nombre = @nombre,
        imagen = @imagen,
        descripcion = @descripcion,
        precio = @precio,
        stock = @stock
    WHERE id = @id;
END;


-- SP DE ELIMINAR (CAMBIO DE ESTATUS)
GO
CREATE PROCEDURE sp_EliminarProducto (
    @id INT
) AS
BEGIN
    UPDATE Productos
    SET estatus = 'Inactivo'
    WHERE id = @id;
END;

-- SP ELIMINACION DE PRODUCTOS POR ID FISICAMENTE
CREATE PROCEDURE sp_EliminarProductoFisico (
    @id INT
) AS
BEGIN
    DELETE FROM Productos
    WHERE id = @id;
END;


-- SP MOSTRAR PRODUCTOS
GO
CREATE PROCEDURE sp_GetAllProductos AS
BEGIN
    SELECT id, nombre, imagen, descripcion, precio, stock, estatus
    FROM Productos;
END;

-- ###################################################################################################################################################################

-- SP DE PROVEEDORES
-- DROP PROCEDURE sp_InsertarProveedor;
-- SP INSERTAR PROVEEDORES
GO
CREATE PROCEDURE sp_InsertarProveedor (
    @nombre VARCHAR(200),
    @empresa VARCHAR(120),
    @rfc VARCHAR(13),
    @telefono VARCHAR(10),
    @correo VARCHAR(120)
) AS
BEGIN
    INSERT INTO Proveedor (nombre, empresa, rfc, telefono, correo, estatus)
    VALUES (@nombre, @empresa, @rfc, @telefono, @correo, 'Activo');
END;



-- SP ACTUALIZAR PROVEEDORES
GO
CREATE PROCEDURE sp_ActualizarProveedor (
    @id INT,
    @nombre VARCHAR(200),
    @empresa VARCHAR(120),
    @rfc VARCHAR(13),
    @telefono VARCHAR(10),
    @correo VARCHAR(120)
) AS
BEGIN
    UPDATE Proveedor
    SET nombre = @nombre,
        empresa = @empresa,
        rfc = @rfc,
        telefono = @telefono,
        correo = @correo
    WHERE id = @id;
END;


-- SP DE ELIMINAR (CAMBIO DE ESTATUS)
GO
CREATE PROCEDURE sp_EliminarProveedor (
    @id INT
) AS
BEGIN
    UPDATE Proveedor
    SET estatus = 'Inactivo'
    WHERE id = @id;
END;


-- SP ELIMINACION DE PROVEEDOR POR ID FISICAMENTE
GO
CREATE PROCEDURE sp_EliminarProveedorFisico (
    @id INT
) AS
BEGIN
    DELETE FROM Proveedor
    WHERE id = @id;
END;

-- DROP PROCEDURE sp_GetAllProveedores;
-- SP MOSTRAR PROVEEDORES
GO
CREATE PROCEDURE sp_GetAllProveedores AS
BEGIN
    SELECT * FROM Proveedor;
END;

-- ###################################################################################################################################################################

-- SP CLIENTES

-- SP REGISTRO CLIENTES
--DROP PROCEDURE sp_InsertarCliente;
GO
CREATE PROCEDURE sp_InsertarCliente (
    @nombre VARCHAR(100),
    @usuario VARCHAR(100),
    @correo VARCHAR(100),
    @contrasenia VARCHAR(100)
) AS
BEGIN
    DECLARE @role_id INT;
    SET @role_id = (SELECT id FROM Role WHERE name = 'Cliente');

    INSERT INTO Clientes (nombre, usuario, correo, contrasenia, estatus, role_id)
    VALUES (@nombre, @usuario, @correo, @contrasenia, 'Activo', @role_id);
END;



-- SP ACTUALIZAR CLIENTES
GO
CREATE PROCEDURE sp_ActualizarCliente (
    @id INT,
    @nombre VARCHAR(100),
	@usuario VARCHAR(100),
    @correo VARCHAR(100),
    @contrasenia VARCHAR(100)
) AS
BEGIN
    UPDATE Clientes
    SET 
		usuario = @usuario,
        contrasenia = @contrasenia
    WHERE id = @id;
END;


-- SP DE ELIMINAR CLIENTES (CAMBIO DE ESTATUS)
GO
CREATE PROCEDURE sp_EliminarCliente (
    @id INT
) AS
BEGIN
    UPDATE Clientes
    SET estatus = 'Inactivo'
    WHERE id = @id;
END;


-- SP ELIMINACION DE CLIENTES POR ID FISICAMENTE
GO
CREATE PROCEDURE sp_EliminarClienteFisico (
    @id INT
) AS
BEGIN
    DELETE FROM Clientes
    WHERE id = @id;
END;


-- SP MOSTRAR CLIENTES
GO
CREATE PROCEDURE sp_GetAllClientes AS
BEGIN
    SELECT c.id, c.nombre, c.usuario, c.correo, c.contrasenia, c.estatus, r.name AS rol
    FROM Clientes c
    INNER JOIN Role r ON c.role_id = r.id;
END;

-- ###################################################################################################################################################################

-- SP MOSTRAR Direcciones
GO
CREATE PROCEDURE sp_MostrarDirecciones AS
BEGIN
    SELECT * FROM Direccion;
END;

-- SP INSERTAR Direcciones
GO
CREATE PROCEDURE sp_InsertarDireccion2 (
    @nombreCompleto VARCHAR(40),
    @calleNumero VARCHAR(50),
    @codigoPostal VARCHAR(5),
    @telefono VARCHAR(10),
    @idcliente INT
) AS
BEGIN
    INSERT INTO Direccion2 (nombreCompleto, calleNumero, codigoPostal, telefono, idcliente)
    VALUES (@nombreCompleto, @calleNumero, @codigoPostal, @telefono, @idcliente);
END;


-- SP ACTUALIZAR Direcciones
GO
CREATE PROCEDURE sp_ActualizarDireccion (
    @id INT,
    @nombreCompleto VARCHAR(40),
    @calleNumero VARCHAR(50),
    @codigoPostal VARCHAR(5),
    @telefono VARCHAR(10),
    @idcliente INT
) AS
BEGIN
    UPDATE Direccion
    SET nombreCompleto = @nombreCompleto,
        calleNumero = @calleNumero,
        codigoPostal = @codigoPostal,
        telefono = @telefono,
        idcliente = @idcliente
    WHERE id = @id;
END;


-- SP ELIMINAR Direcciones
GO
CREATE PROCEDURE sp_EliminarDireccionFisico (
    @id INT
) AS
BEGIN
    DELETE FROM Direccion
    WHERE id = @id;
END;

-- ###################################################################################################################################################################

-- SP INSERTAR MateriaPrima
GO
CREATE PROCEDURE sp_InsertarMateriaPrima (
    @nombre VARCHAR(80),
	@descripcion VARCHAR(200),
    @cantidad INT,
    @unidad_medida VARCHAR(10),
	@stock INT
) AS
BEGIN
    DECLARE @estatus NVARCHAR(20);
    SET @estatus = 'activo';

    INSERT INTO MateriaPrima (nombre, descripcion, cantidad, unidad_medida, stock, estatus)
    VALUES (@nombre, @descripcion, @cantidad, @unidad_medida, @stock, @estatus);
END;

-- SP MOSTRAR MateriaPrima
GO
CREATE PROCEDURE sp_MostrarMateriasPrimasActivas AS
BEGIN
    SELECT *
    FROM MateriaPrima
    WHERE estatus = 'activo';
END;

-- SP ELIMINAR Materia Prima(Cambio de estatus)
GO
CREATE PROCEDURE sp_EliminarMateriaPrima (
    @id INT
) AS
BEGIN
    UPDATE MateriaPrima
    SET estatus = 'inactivo'
    WHERE id = @id;
END;

-- ###################################################################################################################################################################

--GO
--CREATE PROCEDURE sp_InsertarCompra (
--    @vIdProveedor INT,
--    @vIdMateriaPrima INT,
--    @vCantidad INT,
--    @vCostoCompra INT
--)
--AS
--BEGIN
--    DECLARE @vFecha DATETIME;
--    DECLARE @vIdCompra INT;
--    SET @vFecha = GETDATE();

--    -- Insertar en la tabla compra_materia
--    INSERT INTO compra_materia (fecha, idProveedor, estatus)
--    VALUES (@vFecha, @vIdProveedor, N'activo');

--    -- Obtener el ID de la última compra insertada
--    SET @vIdCompra = SCOPE_IDENTITY();

--    -- Insertar en la tabla detalle_compra_materia_prima
--    INSERT INTO detalle_compra_materia_prima (id_compra_materia, id_materia_prima, cantidad, costo_compra)
--    VALUES (@vIdCompra, @vIdMateriaPrima, @vCantidad, @vCostoCompra);
--END;


--GO
--CREATE PROCEDURE sp_VerCompras
--AS
--BEGIN
--    SELECT
--        CM.id_compra_materia AS CompraId,
--        CM.fecha AS Fecha,
--        CM.idProveedor AS IdProveedor,
--        CM.estatus AS Estatus,
--        DCM.id_materia_prima AS IdMateriaPrima,
--        DCM.cantidad AS Cantidad,
--        DCM.costo_compra AS CostoCompra
--    FROM
--        compra_materia AS CM
--    INNER JOIN
--        detalle_compra_materia_prima AS DCM ON CM.id_compra_materia = DCM.id_compra_materia;
--END;



-- ###################################################################################################################################################################

GO
CREATE PROCEDURE sp_insertarCompra
    @IdProveedor INT,
    @Fecha DATE,
    @id_materia_prima INT,
    @cantidad INT,
    @costo_compra INT
AS
BEGIN
    DECLARE @id_compra_materia INT;
    
    INSERT INTO compra_materia (idProveedor, fecha, estatus)
    VALUES (@IdProveedor, @Fecha, 'Activo');
    
    SET @id_compra_materia = SCOPE_IDENTITY();
    
    INSERT INTO detalle_compra_materia_prima (id_compra_materia, id_materia_prima, cantidad, costo_compra)
    VALUES (@id_compra_materia, @id_materia_prima, @cantidad, @costo_compra);
    
    -- Actualizar cantidad en MateriaPrima
    UPDATE MateriaPrima
    SET cantidad = cantidad + @cantidad,
        stock = stock + @cantidad
    WHERE id = @id_materia_prima;
END;

-- DROP PROCEDURE sp_verCompras;
GO
CREATE PROCEDURE sp_verCompras
AS
BEGIN
    SELECT
        cm.id_compra_materia,
        prov.nombre AS nombreProveedor,
        mp.nombre AS nombreMateriaPrima,
        cm.idProveedor,
        dcmp.id_materia_prima,
        cm.fecha,
        dcmp.cantidad,
        dcmp.costo_compra
    FROM
        compra_materia cm
    INNER JOIN
        detalle_compra_materia_prima dcmp ON cm.id_compra_materia = dcmp.id_compra_materia
    INNER JOIN
        Proveedor prov ON cm.idProveedor = prov.id
    INNER JOIN
        MateriaPrima mp ON dcmp.id_materia_prima = mp.id
    WHERE
        cm.estatus = 'Activo';
END;




-- ###################################################################################################################################################################
--drop procedure sp_MostrarRecetas;
GO
CREATE PROCEDURE sp_MostrarRecetas
AS
BEGIN
    SELECT
        r.id,
        r.nombre,
        r.ingredientesMateriaP,
        --r.cantidad,
        r.cantidad_producto,
        r.estatus,
        r.idProducto,
        p.nombre AS nombreProducto
    FROM
        Receta r
    INNER JOIN
        Productos p ON r.idProducto = p.id
    WHERE
        r.estatus = 'Activa';
END;


--drop procedure InsertarReceta;
GO
CREATE PROCEDURE InsertarReceta
(
    @nombre VARCHAR(200),
    @ingredientesMateriaP NVARCHAR(MAX),
    @cantidad INT,
    @cantidad_producto INT,
    @idProducto INT
)
AS
BEGIN
    -- Insertar la receta con estatus "Activa"
    INSERT INTO Receta (nombre, ingredientesMateriaP, cantidad, cantidad_producto, estatus, idProducto)
    VALUES (@nombre, @ingredientesMateriaP, @cantidad, @cantidad_producto, 'Activa', @idProducto);
    
    -- Mensaje de éxito
    PRINT 'Receta insertada exitosamente con estatus Activa.';
END;







GO
CREATE PROCEDURE sp_ActualizarReceta
    @id INT,
    @nombre VARCHAR(200),
    @idProducto INT,
    @idMateriaP INT,
    @cantidad INT,
    @cantidad_producto INT
AS
BEGIN
    UPDATE Receta
    SET nombre = @nombre, idProducto = @idProducto, idMateriaP = @idMateriaP,
        cantidad = @cantidad, cantidad_producto = @cantidad_producto
    WHERE id = @id;
END;

GO
CREATE PROCEDURE sp_EliminarReceta
    @id INT
AS
BEGIN
    DELETE FROM Receta WHERE id = @id;
END;


-- ###################################################################################################################################################################

-- Procedimiento para Mostrar Productos
--GO
--CREATE PROCEDURE MostrarProductos
--AS
--BEGIN
--    SELECT * FROM Productos;
--END;

-- Procedimiento para Insertar Producto (con estatus "Activo")
--GO
--CREATE PROCEDURE InsertarProducto
--    @nombre VARCHAR(200),
--    @imagen VARCHAR(255),
--    @descripcion VARCHAR(200),
--    @precio INT,
--    @stock INT
--AS
--BEGIN
--    INSERT INTO Productos (nombre, imagen, descripcion, precio, stock, estatus)
--    VALUES (@nombre, @imagen, @descripcion, @precio, @stock, 'Activo');
--END;

-- Procedimiento para Actualizar Producto
--GO
--CREATE PROCEDURE ActualizarProducto
--    @id INT,
--    @nombre VARCHAR(200),
--    @imagen VARCHAR(255),
--    @descripcion VARCHAR(200),
--    @precio INT,
--    @stock INT
--AS
--BEGIN
--    UPDATE Productos
--    SET nombre = @nombre, imagen = @imagen, descripcion = @descripcion,
--        precio = @precio, stock = @stock
--    WHERE id = @id;
--END;

-- Procedimiento para Eliminar Producto (cambiando el estatus a "Inactivo")
--GO
--CREATE PROCEDURE EliminarProducto
--    @id INT
--AS
--BEGIN
--    UPDATE Productos
--    SET estatus = 'Inactivo'
--    WHERE id = @id;
--END;

-- ###################################################################################################################################################################

GO
CREATE PROCEDURE sp_VerVentasPorMes
AS
BEGIN
    SELECT
        DATEPART(YEAR, Venta.fecha) AS Anio,
        DATEPART(MONTH, Venta.fecha) AS Mes,
        SUM(detalleVenta.cantidad * detalleVenta.precioUnitario) AS TotalVentas
    FROM
        Venta
    INNER JOIN
        detalleVenta ON Venta.id = detalleVenta.idVenta
    GROUP BY
        DATEPART(YEAR, Venta.fecha),
        DATEPART(MONTH, Venta.fecha)
    ORDER BY
        Anio, Mes;
END;


GO
CREATE PROCEDURE sp_ClientesQueMasCompraron
AS
BEGIN
    SELECT TOP 10
        c.id,
        c.nombre AS NombreCliente,
        SUM(dv.cantidad * dv.precioUnitario) AS TotalCompras
    FROM
        Carrito AS ca
    INNER JOIN
        Venta AS v ON ca.idcliente = v.idcliente
    INNER JOIN
        detalleVenta AS dv ON v.id = dv.idVenta
    INNER JOIN
        Clientes AS c ON ca.idcliente = c.id
    GROUP BY
        c.id, c.nombre
    ORDER BY
        TotalCompras DESC;
END;

GO
CREATE PROCEDURE sp_MostrarVentas
AS
BEGIN
    SELECT v.id AS VentaID, v.fecha AS FechaVenta, c.nombre AS NombreCliente, d.idProducto AS ProductoID,
           p.nombre AS NombreProducto, d.cantidad AS Cantidad, d.precioUnitario AS PrecioUnitario
    FROM Venta v
    INNER JOIN Clientes c ON v.idcliente = c.id
    INNER JOIN detalleVenta d ON v.id = d.idVenta
    INNER JOIN Productos p ON d.idProducto = p.id;
END;


GO
CREATE PROCEDURE sp_CargarCarritoAVentas
    @idCliente INT
AS
BEGIN
    -- Crear una nueva venta
    DECLARE @idVenta INT;
    INSERT INTO Venta (idcliente, fecha, estatus)
    VALUES (@idCliente, GETDATE(), 'En Proceso');

    -- Obtener el id de la venta recién creada
    SET @idVenta = SCOPE_IDENTITY();

    -- Transferir productos del carrito a la tabla detalleVenta
    INSERT INTO detalleVenta (idVenta, idProducto, cantidad, precioUnitario)
    SELECT @idVenta, c.idProducto, c.cantidad, p.precio
    FROM Carrito c
    INNER JOIN Productos p ON c.idProducto = p.id
    WHERE c.idcliente = @idCliente;

    -- Actualizar el stock de productos
    UPDATE p
    SET stock = p.stock - c.cantidad
    FROM Productos p
    INNER JOIN Carrito c ON p.id = c.idProducto
    WHERE c.idcliente = @idCliente;

    -- Limpiar el carrito
    DELETE FROM Carrito WHERE idcliente = @idCliente;
END;

GO
CREATE PROCEDURE sp_MostrarVentasConDetalles
AS
BEGIN
    SELECT v.id AS VentaID, v.fecha AS FechaVenta, c.nombre AS NombreCliente,
           d.idProducto AS ProductoID, p.nombre AS NombreProducto,
           d.cantidad AS Cantidad, d.precioUnitario AS PrecioUnitario
    FROM Venta v
    INNER JOIN Clientes c ON v.idcliente = c.id
    INNER JOIN detalleVenta d ON v.id = d.idVenta
    INNER JOIN Productos p ON d.idProducto = p.id;
END;



-- ###################################################################################################################################################################

GO
CREATE PROCEDURE sp_MostrarProductosEnCarrito
    @idCliente INT
AS
BEGIN
    SELECT c.id AS idCarrito, p.id, p.nombre, p.imagen, p.descripcion, p.precio, p.estatus, c.cantidad, c.idcliente AS userId
    FROM Carrito AS c
    INNER JOIN Productos AS p ON c.idProducto = p.id
    WHERE c.idcliente = @idCliente AND p.estatus = 'Activo';
END;

-- Procedimiento para Insertar Producto en el Carrito
GO
CREATE PROCEDURE sp_InsertarProductoEnCarrito
    @idCliente INT,
    @idProducto INT,
    @cantidad INT
AS
BEGIN
    INSERT INTO Carrito (idcliente, idProducto, cantidad)
    VALUES (@idCliente, @idProducto, @cantidad);
END;

-- Procedimiento para Eliminar Todos los Productos del Carrito para un Cliente
GO
CREATE PROCEDURE sp_EliminarTodosLosProductosDelCarrito
    @idCliente INT
AS
BEGIN
    DELETE FROM Carrito WHERE idcliente = @idCliente;
END;

-- Procedimiento para Eliminar un Producto Individual del Carrito
GO
CREATE PROCEDURE sp_EliminarProductoIndividualDelCarrito
    @idCarrito INT
AS
BEGIN
    DELETE FROM Carrito WHERE id = @idCarrito;
END;


-- ###################################################################################################################################################################


GO
CREATE PROCEDURE sp_insertarCompras
    @IdProveedor INT,
    @Fecha DATE,
    @id_materia_prima INT,
    @cantidad INT,
    @costo_compra INT
AS
BEGIN
    DECLARE @id_compra_materia INT;

    -- Insertar en la tabla Compra
    INSERT INTO Compra (idProveedor, fecha, cantidad, costo_compra, estatus, id_materia_prima)
    VALUES (@IdProveedor, @Fecha, @cantidad, @costo_compra, 'Completado', @id_materia_prima);

    SET @id_compra_materia = SCOPE_IDENTITY();

    -- Actualizar cantidad en MateriaPrima
    UPDATE MateriaPrima
    SET cantidad = cantidad + @cantidad,
        stock = stock + @cantidad
    WHERE id = @id_materia_prima;

    -- Devolver el ID de la compra insertada
    SELECT @id_compra_materia AS id_compra_materia;
END;


GO
CREATE PROCEDURE sp_verCompras2
AS
BEGIN
    SELECT
        c.id_compra_materia,
        prov.nombre AS nombreProveedor,
        mp.nombre AS nombreMateriaPrima,
        c.idProveedor,
        c.id_materia_prima,
        c.fecha,
        c.cantidad,
        c.costo_compra,
        c.estatus -- Agrega el campo estatus a la selección
    FROM
        Compra c
    INNER JOIN
        Proveedor prov ON c.idProveedor = prov.id
    INNER JOIN
        MateriaPrima mp ON c.id_materia_prima = mp.id
    WHERE
        c.estatus = 'Completado';
END;

--drop procedure fabricar;
GO
CREATE PROCEDURE fabricar
    @idProducto INT
AS
BEGIN
    -- Verificar la existencia de recetas para el producto
    IF NOT EXISTS (SELECT 1 FROM Receta WHERE idProducto = @idProducto)
    BEGIN
        PRINT 'No hay receta disponible para el producto. No se puede fabricar.';
        RETURN; -- Salir del procedimiento
    END

    -- Restar la cantidad de materia prima y aumentar el stock de productos
    BEGIN TRANSACTION;

    DECLARE @materiaprima_id INT, @cantidad_materiap INT, @cantidad_producto INT;

    -- Obtener la materia prima, cantidad necesaria y cantidad de productos para la receta
    SELECT @materiaprima_id = idProducto, @cantidad_materiap = cantidad, @cantidad_producto = cantidad_producto
    FROM Receta
    WHERE idProducto = @idProducto;

    -- Verificar si hay suficiente cantidad de materia prima
    DECLARE @materiaprima_cantidad INT;
    SELECT @materiaprima_cantidad = cantidad
    FROM MateriaPrima
    WHERE id = @materiaprima_id;

    IF @materiaprima_cantidad >= @cantidad_materiap
    BEGIN
        -- Actualizar cantidad de materia prima y stock de productos
        UPDATE MateriaPrima
        SET cantidad = cantidad - @cantidad_materiap
        WHERE id = @materiaprima_id;

        UPDATE Productos
        SET stock = stock + @cantidad_producto
        WHERE id = @idProducto;

        -- Actualizar el estatus de la receta (si es necesario)
        UPDATE Receta
        SET estatus = 'Fabricado'
        WHERE idProducto = @idProducto;

        COMMIT;
        PRINT 'Proceso de fabricación exitoso. Stock de productos aumentado.';
    END
    ELSE
    BEGIN
        ROLLBACK;
        PRINT 'No hay suficiente cantidad de materia prima para fabricar el producto.';
    END
END;



--USE [balonEvo]
CREATE PROCEDURE sp_GetDetailsVentas  
@id int 
AS 
BEGIN
    SELECT v.*, 
		   c.nombre,
		   p.nombre as nombreproducto,
		   dv.cantidad,
		   dv.precioUnitario
	FROM Venta2 v
	inner join Clientes2 c on v.idcliente=c.id
	inner join detalleVenta2 dv on v.id = dv.idVenta
	inner join Productos p on dv.idProducto = p.id
	where dv.id=@id;

END;

CREATE PROCEDURE sp_GetAllVentas 
AS
BEGIN
    SELECT v.*, c.nombre FROM Venta2 v inner join Clientes2 c on v.idcliente=c.id;
END;