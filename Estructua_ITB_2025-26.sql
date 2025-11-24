-- Crear base de datos
CREATE DATABASE dawe1;

-- Crear usuario
CREATE USER dawe1 WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'dawe1';

-- Asignar propietario
ALTER DATABASE dawe1 OWNER TO dawe1;

-- Permisos
GRANT ALL PRIVILEGES ON dawe1 itb TO dawe1;

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
    Experiencia NUMERIC(2) NOT NULL DEFAULT 2,
    CONSTRAINT pk_docent PRIMARY KEY (Codi),
    CONSTRAINT ck_experiencia CHECK (Experiencia >= 0),
    CONSTRAINT uq_docent_email UNIQUE (Email_itb),
    CONSTRAINT chk_nom CHECK (Nom = UPPER(Nom)),
    CONSTRAINT chk_Cognom1 CHECK (Cognom1 = UPPER(Cognom1))
);

CREATE TABLE Alumne (
    Codi NUMERIC(2) NOT NULL,
    Nom VARCHAR(10) NOT NULL,
    Cognom1 VARCHAR(10) NOT NULL,
    Email_itb VARCHAR(40) NOT NULL,
    Email_per VARCHAR(40),
    Telefon NUMERIC(10),
    Codi_postal NUMERIC(6) NOT NULL,
    Grup VARCHAR(5) NOT NULL,
    CONSTRAINT pk_alumne PRIMARY KEY (Codi),
    CONSTRAINT uq_alumne_email UNIQUE (Email_itb),
    CONSTRAINT fk_alumne_grup FOREIGN KEY (Grup) REFERENCES Grup(Nom),
    CONSTRAINT chk_nom CHECK (Nom = UPPER(Nom)),
    CONSTRAINT chk_Cognom1 CHECK (Cognom1 = UPPER(Cognom1))
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

-- Afegir un nou camp anomenat «HoresSet» a la taula «Ensenya», ha de ser un número enter
-- positiu més gran de zero i només pot d’acceptar els valors 1,2,3,4, 5, 6, 7 i 8.
ALTER TABLE Ensenya ADD COLUMN HoresSet NUMERIC(1);
ALTER TABLE Ensenya ADD CONSTRAINT ck_hores_set CHECK (HoresSet > 0 AND HoresSet IN (1,2,3,4,5,6,7,8));

-- Afegir un nou camp anomenat «Descripcio» a la taula MODUL. Ha de ser de tipus VARCHAR(50).
ALTER TABLE Modul ADD COLUMN Descripcio VARCHAR(50);

-- Canviar el nom del camp «HoresSet». S’ha de dir «HoresSetmana».
ALTER TABLE Ensenya RENAME COLUMN HoresSet TO HoresSetmana;

-- Canviar el nom de la restricció de la clau forana «Grup» de la taula ALUMNE. La restricció
-- s’ha de dir FK_Grup_To_Grup.
ALTER TABLE Alumne RENAME CONSTRAINT fk_alumne_grup TO FK_Grup_To_Grup;

-- Modificar la longitud del tipus de dada del camp «Descripcio» a la taula MODUL. La nova
-- longitud és VARCHAR(80).
ALTER TABLE Modul ALTER COLUMN Descripcio TYPE VARCHAR(80);

-- Afegeix una restricció amb el nom CK_lower_desc a la taula MODUL per verificar que els
-- valors de camp «Descripcio» estiguin en minúscules.
ALTER TABLE Modul ADD CONSTRAINT CK_lower_desc CHECK (Descripcio = LOWER(Descripcio));

-- Elimina el camp «Descripcio» a la taula MODUL.
ALTER TABLE Modul DROP COLUMN Descripcio;

-- Modifica el tipus de dades del camp «HoresSetmana» de la taula «Ensenya», El tipus de da-
-- des d’aquest camp ha de ser NUMERIC(5).
ALTER TABLE Ensenya ALTER COLUMN HoresSetmana TYPE NUMERIC(5);

-- Modifica la restricció que limita els valors del camp «HoresSetmana» de la taula «Ensenya»,
-- Ara els valors que només accepta són els valors 1,2,3,4, i 5,
ALTER TABLE Ensenya DROP CONSTRAINT ck_hores_set;

-- Afegim la nova restricció amb els nous valors permesos
ALTER TABLE Ensenya ADD CONSTRAINT ck_hores_set CHECK (HoresSet IN (1,2,3,4,5));
