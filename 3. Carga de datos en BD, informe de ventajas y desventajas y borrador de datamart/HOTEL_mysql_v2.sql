/***********************************************************************/
/* 1.- Configuración inicial de la BD                                  */
/***********************************************************************/

DROP DATABASE IF EXISTS `HOTEL_DB`;

CREATE DATABASE IF NOT EXISTS `HOTEL_DB` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE `HOTEL_DB`;

CREATE USER IF NOT EXISTS dbadmin@'%' IDENTIFIED BY 'dbadmin';
GRANT ALL PRIVILEGES ON `HOTEL_DB`.* TO dbadmin@'%';

/**************************************************/
/* 2.- Creamos las tablas de nuestro Diagrama EER */
/**************************************************/

CREATE TABLE HOTEL
(
    ID_HOTEL   	    VARCHAR(6) NOT NULL,
    CALLE       	VARCHAR(32) NOT NULL,
    LOCALIDAD       VARCHAR(32) NOT NULL,
    PROVINCIA       VARCHAR(32) NOT NULL,
    ESTRELLAS		DECIMAL(1) UNSIGNED NOT NULL,
    NOMBRE   		VARCHAR(40) NOT NULL,
    DISTANCIA_PLAYA DECIMAL(6,1),
    DISTANCIA_CENTRO    DECIMAL(6,1),
    PARKING         ENUM('ABIERTO', 'CERRADO'), #NULL significa que no tiene parking
    TRANSLADO_AEROPUERTO ENUM('Sí', 'No') NOT NULL,
    VALORACION      DECIMAL(2,1) NOT NULL,
    TIPO            ENUM('HISTORICO', 'CONCEPTUAL', 'MODERNO', 'TRADICIONAL') NOT NULL,
    TIENE_ASCENSOR  ENUM('Sí', 'No') NOT NULL,
    PRESUPUESTO     DECIMAL(11,2) NOT NULL,
    INGRESOS        DECIMAL(11,2) NOT NULL,
    PRES_MARKETING  DECIMAL(11,2) NOT NULL,
    TIENE_SH        ENUM('Sí', 'No') NOT NULL, #Tiene Servicio de Habitaciones
    
    ULTIMA_ACTUALIZACION timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

        PRIMARY KEY (ID_HOTEL)
);

CREATE TABLE ESPACIO
(
    ID_ESPACIO   	    VARCHAR(9) NOT NULL,
    NOMBRE   		    VARCHAR(40),
    SUPERFICIE		    FLOAT(6,3) UNSIGNED NOT NULL,
    ID_HOTEL            VARCHAR(6) NOT NULL,
    ID_ESPACIO_CONT	    VARCHAR(9), # ID del espacio contenedor, si existe.
    TIENE_INTERNET      ENUM('Sí', 'No') NOT NULL,
    TIENE_VISTAS        ENUM('Sí', 'No') NOT NULL DEFAULT 'No',
    ESTA_CLIMATIZADO    ENUM('Sí', 'No') NOT NULL,

    ULTIMA_ACTUALIZACION timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

        PRIMARY KEY (ID_ESPACIO),
        FOREIGN KEY (ID_HOTEL) REFERENCES HOTEL(ID_HOTEL) ON DELETE CASCADE
        # Si se borra un hotel, se borran sus espacios.
);

ALTER TABLE ESPACIO ADD FOREIGN KEY(ID_ESPACIO_CONT) REFERENCES ESPACIO(ID_ESPACIO) ON DELETE SET NULL;
# Por defecto, si borramos un espacio, sus subespacios
# se mantienen como "huérfanos".

CREATE TABLE ESPACIO_INSTALACION
(
    ID_ESPACIO   		VARCHAR(9) NOT NULL,
    AFORO			    DECIMAL(5) UNSIGNED,
    HORARIO_ACCESIBLE	VARCHAR(40),
    ES_EXTERIOR		    ENUM('Sí', 'No') NOT NULL,
    USO_INFANTIL		ENUM('Sí', 'No') NOT NULL,
    TIPO                ENUM('Gimnasio', 'Restaurante', 'Piscina', 'Pista de tenis', 'Pista de pádel', 'Campo de Golf', 'Spa'),
    ESTA_INCLUIDO       ENUM('Sí', 'No') NOT NULL,
    NECESITA_RESERVA    ENUM('Sí', 'No') NOT NULL,

    ULTIMA_ACTUALIZACION timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

        PRIMARY KEY (ID_ESPACIO),
        FOREIGN KEY (ID_ESPACIO) REFERENCES ESPACIO(ID_ESPACIO) ON DELETE CASCADE
        # Borrado en cascada: Si borramos los datos generales de espacio de un
        # espacio de instalación borramos también sus datos concretos.
);

CREATE TABLE ESPACIO_HOSPEDAJE
(
    ID_ESPACIO          VARCHAR(9) NOT NULL,
    NUM_BANHOS          DECIMAL(2),
    NUM_CAMAS           DECIMAL(2) NOT NULL,
    TIENE_TERRAZA       ENUM('Sí', 'No') NOT NULL,
    ADMITE_FUMADORES    ENUM('Sí', 'No') NOT NULL,
    ADMITE_MASCOTAS     ENUM('Sí', 'No') NOT NULL,
    CANCELACION_GRATIS  ENUM('Sí', 'No') NOT NULL,
    MOVILIDAD_ADAPTADA  ENUM('Sí', 'No') NOT NULL,
    PRECIO_NOCHE        DECIMAL(6,1) NOT NULL,
    LUMINOSIDAD         ENUM('BAJA', 'MEDIA', 'ALTA') NOT NULL,

    ULTIMA_ACTUALIZACION timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

        PRIMARY KEY (ID_ESPACIO),
        FOREIGN KEY (ID_ESPACIO) REFERENCES ESPACIO(ID_ESPACIO) ON DELETE CASCADE
        # Borrado en cascada: Si borramos los datos generales de espacio de un
        # espacio de hospedaje borramos también sus datos concretos.
);

CREATE TABLE HABITACION
(
    ID_ESPACIO      VARCHAR(9) NOT NULL,
    TIPO            ENUM('INDIVIDUAL', 'DOBLE', 'TRIPLE', 'CUADRUPLE') NOT NULL,
    ES_SUITE        ENUM('Sí', 'No') NOT NULL,
    ES_COMPARTIDO   ENUM('Sí', 'No') NOT NULL,
    BANHO_COMPARTIDO    ENUM('Sí', 'No') NOT NULL,
    TIENE_COCINA    ENUM('Sí', 'No') NOT NULL,

    ULTIMA_ACTUALIZACION timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

        PRIMARY KEY (ID_ESPACIO),
        FOREIGN KEY (ID_ESPACIO) REFERENCES ESPACIO_HOSPEDAJE(ID_ESPACIO) ON DELETE CASCADE
        # Borrado en cascada: Si borramos los datos generales de espacio de hospedaje
        # de una habitación borramos también sus datos concretos.
);

CREATE TABLE APARTAMENTO
(
    ID_ESPACIO          VARCHAR(9) NOT NULL,
    TIENE_SALON         ENUM('Sí', 'No') NOT NULL,
    COCINA_ELECTRICA    ENUM('Sí', 'No') NOT NULL,
    NUM_PLANTAS         DECIMAL(2) NOT NULL,
    TIENE_ASCENSOR      ENUM('Sí','No') NOT NULL,
    NUM_HABITACIONES    INT(1) NOT NULL,
   
    ULTIMA_ACTUALIZACION timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

        PRIMARY KEY (ID_ESPACIO),
        FOREIGN KEY (ID_ESPACIO) REFERENCES ESPACIO_HOSPEDAJE(ID_ESPACIO) ON DELETE CASCADE
        # Borrado en cascada: Si borramos los datos generales de espacio de hospedaje
        # de un apartamento borramos también sus datos concretos.
);

CREATE TABLE PERSONA
(
    NUM_ID              VARCHAR (9) NOT NULL,
    NOMBRE              VARCHAR (40) NOT NULL,
    TELEFONO            VARCHAR(31) NOT NULL UNIQUE, #  Incluye Prefijo(hasta 5 dígitos), número (hasta 15) y sufijo(hasta 11).
    FECHA_NACIMIENTO    DATE,
    GENERO              ENUM ('Masculino','Femenino','Otro'),

    ULTIMA_ACTUALIZACION timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

        PRIMARY KEY (NUM_ID)
);

CREATE TABLE CLIENTE
(
    ID_CLIENTE              VARCHAR (9) NOT NULL, #clave subrogada
    FECHA_PRIMER_CONTRATO   DATE NOT NULL,
    ES_CLIENTE_VIP          ENUM('Sí','No'),

    ULTIMA_ACTUALIZACION timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

        PRIMARY KEY (ID_CLIENTE)
);

CREATE TABLE HUESPED
(
    NUM_ID          VARCHAR(9) NOT NULL,
    ID_CLIENTE      VARCHAR(9) UNIQUE,
    NACIONALIDAD    VARCHAR(20) NOT NULL,
    NUM_TARJETA     VARCHAR(19) UNIQUE,
    FAMILIA_NUMEROSA ENUM('Sí', 'No') NOT NULL,
    ESTADO_CIVIL    ENUM('Soltero', 'Casado', 'Viúdo', 'Divorciado'),
    SITUACION_LABORAL ENUM('Empresario', 'Autónomo', 'Asalariado', 'Cooperativista', 'En paro', 'Jubilado'),
    MEDIO_TRANSPORTE ENUM('Coche', 'Avión', 'Tren', 'Moto', 'Bus', 'Camión'),
    COMO_CONOCISTE  ENUM('Internet', 'Publicidad', 'Conocidos', 'Otros'),
    TRAE_MASCOTA    ENUM('Sí','No'),
    PAIS_RESIDENCIA VARCHAR(40) NOT NULL,

    ULTIMA_ACTUALIZACION timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

        PRIMARY KEY (NUM_ID),
        FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE) ON DELETE SET NULL,
        # Un huésped puede no ser un cliente, por lo que si borramos sus datos
        # de cliente, mantendremos los de huésped.
        FOREIGN KEY (NUM_ID) REFERENCES PERSONA(NUM_ID) ON DELETE CASCADE
        # Si borramos los datos de persona, borramos también los de huésped.
);

CREATE TABLE EMPRESA
(
    CIF             VARCHAR(9) NOT NULL,
    ID_CLIENTE      VARCHAR(9) UNIQUE,
    NOMBRE          VARCHAR(40) NOT NULL,
    NUM_EMPLEADOS   DECIMAL(4) UNSIGNED,
    ALCANCE         ENUM('Local', 'Regional', 'Nacional', 'Comunitaria', 'Multinacional') NOT NULL,
    TIPO_EMPRESA    ENUM('Limitada', 'Anónima', 'Cooperativa', 'Autónomo') NOT NULL,

    ULTIMA_ACTUALIZACION timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

        PRIMARY KEY (CIF),
        FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE) ON DELETE SET NULL
        # Una empresa puede no ser un cliente, por lo que si borramos sus datos
        # de cliente, mantendremos los de empresa.
);

CREATE TABLE AGENCIA
(
    COD_AGENCIA                 VARCHAR(9) NOT NULL,
    ID_CLIENTE                  VARCHAR(9) UNIQUE,
    NOMBRE                      VARCHAR(40) NOT NULL,
    FECHA_INICIO_RELACIONES     DATE NOT NULL,
    PAIS_ORIGEN                 VARCHAR(40) NOT NULL,
    ES_VIRTUAL                  ENUM('Sí', 'No') NOT NULL,
    VALORACION                  DECIMAL(2) NOT NULL,

    ULTIMA_ACTUALIZACION timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

        PRIMARY KEY (COD_AGENCIA),
        FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID_CLIENTE) ON DELETE SET NULL
        # Una agencia puede no ser un cliente, por lo que si borramos sus datos
        # de cliente, mantendremos los de agencia.
);

CREATE TABLE CLIENTE_RESERVA_ESP_HOSPEDAJE
(
    ID_RESERVA      VARCHAR(20) NOT NULL,
    ID_CLIENTE      VARCHAR(9) NOT NULL UNIQUE,
    ID_ESPACIO      VARCHAR(9) NOT NULL UNIQUE,
    FECHA_RESERVA   DATE NOT NULL,
    FECHA_ENTRADA   DATE NOT NULL UNIQUE,
    FECHA_SALIDA    DATE NOT NULL,
    PRECIO          DECIMAL(8,2) UNSIGNED,
    #NOCHES          DATE(3) AS (FECHA_SALIDA-FECHA_ENTRADA) NOT NULL,
    PORC_DESCUENTO  DECIMAL(2),

        PRIMARY KEY (ID_RESERVA),
        FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID_CLIENTE) ON DELETE CASCADE,
        FOREIGN KEY (ID_ESPACIO) REFERENCES ESPACIO_HOSPEDAJE(ID_ESPACIO) ON DELETE CASCADE
        # Si se borran el espacio reservado o el cliente que reserva, se borra la reserva en cascada.
);