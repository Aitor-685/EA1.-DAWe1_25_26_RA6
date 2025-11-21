-- Crear base de datos
CREATE DATABASE itb;

-- Crear usuari
CREATE USER usuarioitb WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'usuarioitb';

-- Asignar base de datos al usuari
ALTER DATABASE itb OWNER TO usuarioitb;

-- Darle todos los permisos ha ese usuario
GRANT ALL PRIVILEGES ON DATABASE itb TO usuarioitb;

-- Estructura de base de datos
CREATE TABLE Grup (
    Nom VARCHAR(5) NOT NULL,
    Aula NUMERIC(3) NOT NULL,
    CONSTRAINT PK_grup PRIMARY KEY (Nom)
);

CREATE TABLE Modul (
    Codi VARCHAR(10) NOT NULL,
    Nom VARCHAR(60) NOT NULL,
    CONSTRAINT PK_modul PRIMARY KEY (Codi)
);

CREATE TABLE Docent (
    Codi NUMERIC(3) NOT NULL,
    Nom VARCHAR(10) NOT NULL,
    Cognom1 VARCHAR(10) NOT NULL,
    Email_itb VARCHAR(40) NOT NULL,
    Experiencia NUMERIC(2) NOT NULL,
    CONSTRAINT PK_docent PRIMARY KEY (Codi)
);

CREATE TABLE Alumne (
    Codi NUMERIC(2) NOT NULL,
    Nom VARCHAR(10) NOT NULL,
    Cognom1 VARCHAR(10) NOT NULL,
    Email_itb VARCHAR(40) NOT NULL,
    Email_per VARCHAR(40),
    Telefon NUMERIC(9),
    Codi_postal NUMERIC(5) NOT NULL,
    Grup VARCHAR(5) NOT NULL,
    CONSTRAINT PK_Alumne PRIMARY KEY (Codi),
    CONSTRAINT FK_grup FOREIGN KEY (Grup) REFERENCES Grup(Nom)
);

CREATE TABLE Ensenya (
    Docent NUMERIC(3) NOT NULL,
    Modul VARCHAR(10) NOT NULL,
    Grup VARCHAR(5) NOT NULL,
    CONSTRAINT PK_Ensenya PRIMARY KEY (Docent, Modul, Grup),
    CONSTRAINT FK_docent FOREIGN KEY (Docent) REFERENCES Docent(Codi),
    CONSTRAINT FK_modul FOREIGN KEY (Grup) REFERENCES Modul(Codi),
    CONSTRAINT FK_grups FOREIGN KEY (Grup) REFERENCES Grup(Nom)
);

CREATE TABLE Activitat (
    Codi VARCHAR(5) NOT NULL,
    Nom VARCHAR(20) NOT NULL,
    Descripcio VARCHAR(20),
    CONSTRAINT PK_activitat PRIMARY KEY (Codi)
);

CREATE TABLE Preferencia (
    Codi VARCHAR(5) NOT NULL,
    Nom VARCHAR(20) NOT NULL,
    Descripcio VARCHAR(20),
    CONSTRAINT PK_preferencia PRIMARY KEY (Codi)
);

CREATE TABLE Realitza (
    Codi_Al NUMERIC(2) NOT NULL,
    Codi_Act VARCHAR(5) NOT NULL,
    Hores_Sem VARCHAR(5) NOT NULL,
    CONSTRAINT PK_realitza PRIMARY KEY (Codi_Al, Codi_Act),
    CONSTRAINT FK_alumnes1 FOREIGN KEY (Codi_Al) REFERENCES Alumne(Codi),
    CONSTRAINT FK_activitats1 FOREIGN KEY (Grup) REFERENCES Activitat(Codi)
);

CREATE TABLE Agrada (
    Codi_Al NUMERIC(2) NOT NULL,
    Codi_Pref VARCHAR(5) NOT NULL,
    CONSTRAINT PK_realitza PRIMARY KEY (Codi_Al, Codi_Pref),
    CONSTRAINT FK_alumnes2 FOREIGN KEY (Codi_Al) REFERENCES Alumne(Codi),
    CONSTRAINT FK_activitats1 FOREIGN KEY (Codi_Pref) REFERENCES Preferencia(Codi)
);

