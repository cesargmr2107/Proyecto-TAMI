CREATE DATABASE 'hotel_dwh';

USE `hotel_dwh`;


DROP TABLE IF EXISTS `dim_hotel`;

CREATE TABLE `dim_hotel` (
    
    # DIMENSION KEY
    `HOTEL_KEY` int(8) NOT NULL AUTO_INCREMENT,

    # DIMENSION ATRIBUTES
    `ID_HOTEL` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
    `CALLE` varchar(32) COLLATE utf8_spanish_ci NOT NULL,
    `PAIS` varchar(32) COLLATE utf8_spanish_ci NOT NULL,
    `CIUDAD` varchar(32) COLLATE utf8_spanish_ci NOT NULL,
    `ESTRELLAS` decimal(1,0) UNSIGNED NOT NULL,
    `NOMBRE` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
    `PARKING` enum('ABIERTO','CERRADO') COLLATE utf8_spanish_ci DEFAULT NULL,
    `TRASLADO_AEROPUERTO` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
    `VALORACION` decimal(2,1) NOT NULL,
    `TIPO` enum('HISTORICO','CONCEPTUAL','MODERNO','TRADICIONAL') COLLATE utf8_spanish_ci NOT NULL,
    `TIENE_ASCENSOR` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
    `PRESUPUESTO` decimal(11,2) NOT NULL,
    `INGRESOS` decimal(11,2) NOT NULL,
    `PRES_MARKETING` decimal(11,2) NOT NULL,
    `TIENE_SH` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
    `DISTANCIA_CENTRO` enum('< 500m','< 1Km','< 2Km','< 3Km','< 5Km') COLLATE utf8_spanish_ci DEFAULT NULL,
    `DISTANCIA_PLAYA` enum('< 500m','< 1Km','< 2Km','< 3Km','< 5Km') COLLATE utf8_spanish_ci DEFAULT NULL,
    `ULTIMA_ACTUALIZACION` datetime NOT NULL,
    
    PRIMARY KEY (`HOTEL_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

DROP TABLE IF EXISTS `dim_espacio`;
CREATE TABLE `dim_espacio` (

    # DIMENSION KEY
    `ID_ESPACIO` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
    
    
    `NOMBRE` varchar(40) COLLATE utf8_spanish_ci DEFAULT NULL,
    `SUPERFICIE` float(6,3) UNSIGNED NOT NULL,
    `ID_HOTEL` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
    `ID_ESPACIO_CONT` varchar(9) COLLATE utf8_spanish_ci DEFAULT NULL,
    `TIENE_INTERNET` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
    `TIENE_VISTAS` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL DEFAULT 'No',
    `ESTA_CLIMATIZADO` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
    `TIPO_ESPACIO` enum('ESPACIO_HOSPEDAJE','ESPACIO_INSTALACION','ESPACIO_TRABAJO') COLLATE utf8_spanish_ci NOT NULL DEFAULT 'ESPACIO_HOSPEDAJE',
    `ULTIMA_ACTUALIZACION` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`ID_ESPACIO`),
    KEY `ID_HOTEL` (`ID_HOTEL`),
    KEY `ID_ESPACIO_CONT` (`ID_ESPACIO_CONT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


DROP TABLE IF EXISTS `dim_espacio_hospedaje`;
CREATE TABLE `dim_espacio_hospedaje` (

    # DIMENSION KEY
    `ESPACIO_HOSPEDAJE_KEY` int(8) NOT NULL AUTO_INCREMENT,

    # DIMENSION ATRIBUTES
    `ID_ESPACIO` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
    `NUM_BANHOS` decimal(1,0) DEFAULT NULL,
    `NUM_CAMAS` decimal(1,0) NOT NULL,
    `TIENE_TERRAZA` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
    `ADMITE_FUMADORES` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
    `ADMITE_MASCOTAS` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
    `CANCELACION_GRATIS` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
    `MOVILIDAD_ADAPTADA` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
    `PRECIO_NOCHE` decimal(5,2) NOT NULL,
    `LUMINOSIDAD` enum('BAJA','MEDIA','ALTA') COLLATE utf8_spanish_ci NOT NULL,
    `TIPO_HOSPEDAJE` enum('APARTAMENTO','HABITACION') COLLATE utf8_spanish_ci NOT NULL,
    `ULTIMA_ACTUALIZACION` datetime NOT NULL,

    PRIMARY KEY (`ESPACIO_HOSPEDAJE_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


DROP TABLE IF EXISTS `dim_huesped`;
CREATE TABLE `dim_huesped` (
  `NUM_ID` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `ID_CLIENTE` varchar(9) COLLATE utf8_spanish_ci DEFAULT NULL,
  `NACIONALIDAD` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `NUM_TARJETA` varchar(19) COLLATE utf8_spanish_ci DEFAULT NULL,
  `FAMILIA_NUMEROSA` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `ESTADO_CIVIL` enum('Soltero','Casado','Viúdo','Divorciado') COLLATE utf8_spanish_ci DEFAULT NULL,
  `SITUACION_LABORAL` enum('Empresario','Autónomo','Asalariado','Cooperativista','En paro','Jubilado') COLLATE utf8_spanish_ci DEFAULT NULL,
  `MEDIO_TRANSPORTE` enum('Coche','Avión','Tren','Moto','Bus','Camión') COLLATE utf8_spanish_ci DEFAULT NULL,
  `COMO_CONOCISTE` enum('Internet','Publicidad','Conocidos','Otros') COLLATE utf8_spanish_ci DEFAULT NULL,
  `TRAE_MASCOTA` enum('Sí','No') COLLATE utf8_spanish_ci DEFAULT NULL,
  `PAIS_RESIDENCIA` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `ES_VIP` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL DEFAULT 'No',
  `ULTIMA_ACTUALIZACION` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`NUM_ID`),
  UNIQUE KEY `ID_CLIENTE` (`ID_CLIENTE`),
  UNIQUE KEY `NUM_TARJETA` (`NUM_TARJETA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


DROP TABLE IF EXISTS `dim_persona`;
CREATE TABLE `dim_persona` (
  `NUM_ID` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `NOMBRE` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `TELEFONO` varchar(31) COLLATE utf8_spanish_ci NOT NULL,
  `FECHA_NACIMIENTO` date DEFAULT NULL,
  `GENERO` enum('Masculino','Femenino','Otro') COLLATE utf8_spanish_ci DEFAULT NULL,
  `ULTIMA_ACTUALIZACION` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`NUM_ID`),
  UNIQUE KEY `TELEFONO` (`TELEFONO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;