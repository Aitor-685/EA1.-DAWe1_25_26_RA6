-- Crear base de datos
CREATE DATABASE DAWe1;

-- Crear usuario
CREATE USER usuarioitb WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'usuarioitb';

-- Asignar propietario
ALTER DATABASE itb OWNER TO usuarioitb;

-- Permisos
GRANT ALL PRIVILEGES ON DATABASE itb TO usuarioitb;

CREATE TABLE Grup (
    Nom VARCHAR(5) NOT NULL,
    Aula NUMERIC(3) NOT NULL,
    CONSTRAINT pk_grup PRIMARY KEY (Nom),
    CONSTRAINT ck_aula CHECK (Aula > 0)
);

CREATE TABLE Modul (
    Codi VARCHAR(10) NOT NULL,
    Nom VARCHAR(60) NOT NULL,
    CONSTRAINT pk_modul PRIMARY KEY (Codi)
);

CREATE TABLE Docent (
    Codi NUMERIC(3) NOT NULL,
    Nom VARCHAR(10) NOT NULL,
    Cognom1 VARCHAR(10) NOT NULL,
    Email_itb VARCHAR(40) NOT NULL,
    Experiencia NUMERIC(2) NOT NULL,
    CONSTRAINT pk_docent PRIMARY KEY (Codi),
    CONSTRAINT ck_experiencia CHECK (Experiencia >= 0),
    CONSTRAINT uq_docent_email UNIQUE (Email_itb)
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
    CONSTRAINT pk_alumne PRIMARY KEY (Codi),
    CONSTRAINT uq_alumne_email UNIQUE (Email_itb),
    CONSTRAINT fk_alumne_grup FOREIGN KEY (Grup) REFERENCES Grup(Nom)
);

CREATE TABLE Ensenya (
    Codi_docent NUMERIC(3) NOT NULL,
    Codi_modul VARCHAR(10) NOT NULL,
    Grup VARCHAR(5) NOT NULL,
    CONSTRAINT pk_ensenya PRIMARY KEY (Codi_docent, Codi_modul, Grup),
    CONSTRAINT fk_ensenya_docent FOREIGN KEY (Codi_docent) REFERENCES Docent(Codi),
    CONSTRAINT fk_ensenya_modul FOREIGN KEY (Codi_modul) REFERENCES Modul(Codi),
    CONSTRAINT fk_ensenya_grup FOREIGN KEY (Grup) REFERENCES Grup(Nom)
);

CREATE TABLE Activitat (
    Codi VARCHAR(5) NOT NULL,
    Nom VARCHAR(20) NOT NULL,
    Descripcio VARCHAR(20),
    CONSTRAINT pk_activitat PRIMARY KEY (Codi)
);

CREATE TABLE Preferencia (
    Codi VARCHAR(5) NOT NULL,
    Nom VARCHAR(20) NOT NULL,
    Descripcio VARCHAR(20),
    CONSTRAINT pk_preferencia PRIMARY KEY (Codi)
);

CREATE TABLE Realitza (
    Codi_Al NUMERIC(2) NOT NULL,
    Codi_Act VARCHAR(5) NOT NULL,
    Hores NUMERIC(3) NOT NULL,
    CONSTRAINT pk_realitza PRIMARY KEY (Codi_Al, Codi_Act),
    CONSTRAINT fk_realitza_alumne FOREIGN KEY (Codi_Al) REFERENCES Alumne(Codi),
    CONSTRAINT fk_realitza_activitat FOREIGN KEY (Codi_Act) REFERENCES Activitat(Codi),
    CONSTRAINT ck_realitza_hores CHECK (Hores >= 0)
);

CREATE TABLE Agrada (
    Codi_Al NUMERIC(2) NOT NULL,
    Codi_Pref VARCHAR(5) NOT NULL,
    CONSTRAINT pk_agrada PRIMARY KEY (Codi_Al, Codi_Pref),
    CONSTRAINT fk_agrada_alumne FOREIGN KEY (Codi_Al)  REFERENCES Alumne(Codi),
    CONSTRAINT fk_agrada_preferencia FOREIGN KEY (Codi_Pref) REFERENCES Preferencia(Codi)
);

