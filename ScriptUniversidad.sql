CREATE DATABASE FragmentacionBD;
GO

USE FragmentacionBD;
GO
CREATE SCHEMA HUACHI;
GO
CREATE SCHEMA INGAHURCO;
GO  
CREATE SCHEMA QUEROCHACA;
GO
-- HUACHI
CREATE TABLE dbo.HUACHI_Alumnos_V1 (
    AlumnoID INT PRIMARY KEY,
    Cedula VARCHAR(10),
    Nombres VARCHAR(50),
    Apellidos VARCHAR(50),
    Email VARCHAR(100),
    Telefono VARCHAR(15),
    Sede VARCHAR(20)
);

CREATE TABLE dbo.HUACHI_Alumnos_V2 (
    AlumnoID INT PRIMARY KEY,
    Carrera VARCHAR(50),
    Ciudad VARCHAR(50),
    FechaIngreso DATE
);

-- INGAHURCO
CREATE TABLE dbo.INGAHURCO_Alumnos_V1 (
    AlumnoID INT PRIMARY KEY,
    Cedula VARCHAR(10),
    Nombres VARCHAR(50),
    Apellidos VARCHAR(50),
    Email VARCHAR(100),
    Telefono VARCHAR(15),
    Sede VARCHAR(20)
);

CREATE TABLE dbo.INGAHURCO_Alumnos_V2 (
    AlumnoID INT PRIMARY KEY,
    Carrera VARCHAR(50),
    Ciudad VARCHAR(50),
    FechaIngreso DATE
);

-- QUEROCHACA
CREATE TABLE dbo.QUEROCHACA_Alumnos_V1 (
    AlumnoID INT PRIMARY KEY,
    Cedula VARCHAR(10),
    Nombres VARCHAR(50),
    Apellidos VARCHAR(50),
    Email VARCHAR(100),
    Telefono VARCHAR(15),
    Sede VARCHAR(20)
);

CREATE TABLE dbo.QUEROCHACA_Alumnos_V2 (
    AlumnoID INT PRIMARY KEY,
    Carrera VARCHAR(50),
    Ciudad VARCHAR(50),
    FechaIngreso DATE
);

INGRESO DE DATOS

-- HUACHI
INSERT INTO dbo.HUACHI_Alumnos_V1 VALUES (4, '1102030405', 'María', 'Salazar', 'maria@huachi.edu.ec', '0998887766', 'HUACHI');
INSERT INTO dbo.HUACHI_Alumnos_V2 VALUES (4, 'Administración', 'Ambato', '2023-01-15');

INSERT INTO dbo.HUACHI_Alumnos_V1 VALUES (5, '1103040506', 'David', 'Vega', 'david@huachi.edu.ec', '0997776655', 'HUACHI');
INSERT INTO dbo.HUACHI_Alumnos_V2 VALUES (5, 'Turismo', 'Ambato', '2022-05-10');

-- INGAHURCO
INSERT INTO dbo.INGAHURCO_Alumnos_V1 VALUES (6, '1202030405', 'Sofía', 'Paredes', 'sofia@ingahurco.edu.ec', '0988887766', 'INGAHURCO');
INSERT INTO dbo.INGAHURCO_Alumnos_V2 VALUES (6, 'Sistemas', 'Ambato', '2021-11-20');

INSERT INTO dbo.INGAHURCO_Alumnos_V1 VALUES (7, '1203040506', 'Jorge', 'Cabrera', 'jorge@ingahurco.edu.ec', '0987776655', 'INGAHURCO');
INSERT INTO dbo.INGAHURCO_Alumnos_V2 VALUES (7, 'Educación', 'Ambato', '2020-03-05');

-- QUEROCHACA
INSERT INTO dbo.QUEROCHACA_Alumnos_V1 VALUES (8, '1302030405', 'Valeria', 'Mendoza', 'valeria@querochaca.edu.ec', '0978887766', 'QUEROCHACA');
INSERT INTO dbo.QUEROCHACA_Alumnos_V2 VALUES (8, 'Veterinaria', 'Quero', '2022-08-12');

INSERT INTO dbo.QUEROCHACA_Alumnos_V1 VALUES (9, '1303040506', 'Esteban', 'Luna', 'esteban@querochaca.edu.ec', '0977776655', 'QUEROCHACA');
INSERT INTO dbo.QUEROCHACA_Alumnos_V2 VALUES (9, 'Mecánica', 'Quero', '2023-02-28');

CREACION DE LA VISTA GLOBAL CREADA

CREATE VIEW dbo.Alumnos AS
SELECT 
    V1.AlumnoID,
    V1.Nombres,
    V1.Apellidos,
    V1.Email,
    V1.Telefono,
    V1.Sede,
    V2.Carrera,
    V2.Ciudad,
    V2.FechaIngreso
FROM dbo.HUACHI_Alumnos_V1 V1
JOIN dbo.HUACHI_Alumnos_V2 V2 ON V1.AlumnoID = V2.AlumnoID

UNION ALL

SELECT 
    V1.AlumnoID,
    V1.Nombres,
    V1.Apellidos,
    V1.Email,
    V1.Telefono,
    V1.Sede,
    V2.Carrera,
    V2.Ciudad,
    V2.FechaIngreso
FROM dbo.INGAHURCO_Alumnos_V1 V1
JOIN dbo.INGAHURCO_Alumnos_V2 V2 ON V1.AlumnoID = V2.AlumnoID

UNION ALL

SELECT 
    V1.AlumnoID,
    V1.Nombres,
    V1.Apellidos,
    V1.Email,
    V1.Telefono,
    V1.Sede,
    V2.Carrera,
    V2.Ciudad,
    V2.FechaIngreso
FROM dbo.QUEROCHACA_Alumnos_V1 V1
JOIN dbo.QUEROCHACA_Alumnos_V2 V2 ON V1.AlumnoID = V2.AlumnoID;

PRUEBA DE LA VISTA GLOBAL CREADA
USE FragmentacionBD;
GO

SELECT * FROM dbo.Alumnos;

CONTEO POR SEDE
SELECT Sede, COUNT(*) AS TotalPorSede
FROM dbo.Alumnos
GROUP BY Sede;

CONTEO POR CARRERA
SELECT Carrera, COUNT(*) AS TotalPorCarrera
FROM dbo.Alumnos
GROUP BY Carrera;

Fragmentación horizontal por Sede → cada sede almacena solo sus alumnos.
-- HUACHI
SELECT * FROM dbo.HUACHI_Alumnos_V1;

-- INGAHURCO
SELECT * FROM dbo.INGAHURCO_Alumnos_V1;

-- QUEROCHACA
SELECT * FROM dbo.QUEROCHACA_Alumnos_V1;

Fragmentación vertical dentro de cada sede:
Fragmento V1 (identificación/contacto): AlumnoID, Cedula, Nombres, 
Apellidos, Email, Telefono, Sede
-- HUACHI
SELECT AlumnoID, Cedula, Nombres, Apellidos, Email, Telefono, Sede
FROM dbo.HUACHI_Alumnos_V1;

-- INGAHURCO
SELECT AlumnoID, Cedula, Nombres, Apellidos, Email, Telefono, Sede
FROM dbo.INGAHURCO_Alumnos_V1;

-- QUEROCHACA
SELECT AlumnoID, Cedula, Nombres, Apellidos, Email, Telefono, Sede
FROM dbo.QUEROCHACA_Alumnos_V1;

Fragmentación vertical dentro de cada sede:
Fragmento V2 (académico): AlumnoID, Carrera, Ciudad, FechaIngreso
(Ambos fragmentos incluyen AlumnoID para permitir JOIN)
-- HUACHI
SELECT AlumnoID, Carrera, Ciudad, FechaIngreso
FROM dbo.HUACHI_Alumnos_V2;

-- INGAHURCO
SELECT AlumnoID, Carrera, Ciudad, FechaIngreso
FROM dbo.INGAHURCO_Alumnos_V2;

-- QUEROCHACA
SELECT AlumnoID, Carrera, Ciudad, FechaIngreso
FROM dbo.QUEROCHACA_Alumnos_V2;

demostración de transparencia: una consulta global que no “sepa” de los fragmentos y devuelva datos unificado
SELECT * FROM dbo.Alumnos;
