/**************************************************
 * BASE DE DATOS balonevo           			   *
 *                                   			   *
 * Archivo de BASE DE DATOS (Views).  			   *
 * Vistas - Views                                  *
 **************************************************/
 
  /*
	Versión:                         1.0
    Fecha:                           02/08/23 20:30:00
    Autor:                           Alan Herrera Martínez
    Email:                           20001575@alumnos.utleon.edu.mx
    Comentarios:                     Esta es la primera version de las
									 vistas de la base de datos balonevo.
*/


USE balonevo;

--  Vista que consulta todos los datos de un Empleado
DROP VIEW IF EXISTS v_empleados;
CREATE VIEW v_empleados AS
    SELECT  P.*,
            E.idEmpleado,
            E.puesto,
            E.estatus,
            U.*
    FROM    persona P
            INNER JOIN empleado E ON E.idPersona = P.idPersona
            INNER JOIN usuario U ON U.idUsuario = E.idUsuario;
            
--  Vista que consulta todos los datos de un Cliente
DROP VIEW IF EXISTS v_clientes;
CREATE VIEW v_clientes AS
    SELECT  P.*,
            C.idCliente,
            C.rol,
            C.estatus
    FROM    persona P
            INNER JOIN cliente C ON C.idPersona = P.idPersona;
            
--  Vista que consulta todos los datos de un Departamento actualizada
DROP VIEW IF EXISTS v_departamentos;
CREATE VIEW v_departamentos AS
    SELECT  P.*,
			C.idCliente,
            D.idDepartamento,
            D.nombreDepartamento,
            D.ubicacion,
            D.jefe,
            D.estatus
    FROM    persona P
            INNER JOIN cliente C ON C.idPersona = P.idPersona
            INNER JOIN departamento D ON D.idCliente = C.idCliente;
            
--  Vista que consulta todos los datos de un Servicio
DROP VIEW IF EXISTS v_servicios;
CREATE VIEW v_servicios AS
    SELECT  P.*,
            E.idEmpleado,
            D.idDepartamento,
            D.nombreDepartamento,
            Eq.idEquipo,
            Eq.claveCams,
            S.idServicio,
            S.nombreServicio,
            S.fecha,
            S.actividad,
            S.descripcion,
            S.estatus
    FROM    persona P
            INNER JOIN empleado E ON E.idPersona = P.idPersona
            INNER JOIN servicio S ON S.idEmpleado = E.idEmpleado
            INNER JOIN departamento D ON D.idDepartamento = S.idDepartamento
            INNER JOIN equipo Eq ON Eq.idEquipo = S.idEquipo;
            
--  Vista que consulta todos los datos de una Nota
DROP VIEW IF EXISTS v_notas;
CREATE VIEW v_notas AS
    SELECT  N.idNota,
			S.idServicio,
            N.fechaNota,
            N.descripcionNota
    FROM    nota N
            INNER JOIN servicio S ON S.idServicio = N.idServicio;