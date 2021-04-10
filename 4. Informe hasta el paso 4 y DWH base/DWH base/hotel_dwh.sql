DROP DATABASE `hotel_dwh`;

CREATE DATABASE `hotel_dwh`;

USE `hotel_dwh`;


DROP TABLE IF EXISTS `fact_reserva`;

CREATE TABLE `fact_reserva` (

  # IDS
  `reserva_key` int(8) NOT NULL AUTO_INCREMENT,
  `id_reserva` VARCHAR(9) NOT NULL, 
  
  # FOREIGN KEYS
  `espacio_hospedaje_key` INT(8) NOT NULL,
  `fecha_entrada` INT(8) NOT NULL,
  `fecha_salida` INT(8) NOT NULL,
  `huesped_key` INT(8) NOT NULL,
  `hotel_key` INT(8) NOT NULL,
  
  # METRICS
  `numero_reservas` INTEGER NOT NULL,
  `descuento_aplicado` FLOAT(10,2) NOT NULL,
  `importe_medio` FLOAT(10,2) NOT NULL,
  `importe_bruto` FLOAT(10,2) NOT NULL,
  `importe_final` FLOAT(10,2) NOT NULL,
  `duracion` INT(8) NOT NULL,

  # TIMESTAMP
  `ultima_actualizacion_reserva` datetime NOT NULL,

  # KEY CONSTRAINTS
  PRIMARY KEY (`reserva_key`),
  FOREIGN KEY (`espacio_hospedaje_key`) REFERENCES `dim_espacio_hospedaje`(`espacio_hospedaje_key`),
  FOREIGN KEY (`fecha_entrada`) REFERENCES `dim_fecha`(`date_key`),
  FOREIGN KEY (`fecha_salida`) REFERENCES `dim_fecha`(`date_key`),
  FOREIGN KEY (`huesped_key`) REFERENCES `dim_huesped`(`huesped_key`),
  FOREIGN KEY (`hotel_key`) REFERENCES `dim_hotel` (`hotel_key`)
  
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;



DROP TABLE IF EXISTS `dim_hotel`;

CREATE TABLE `dim_hotel` (
    
    # DIMENSION KEY
    `hotel_key` int(8) NOT NULL AUTO_INCREMENT,

    # DIMENSION ATRIBUTES
    `id_hotel` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
    `distancia_playa` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
    `distancia_centro` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
    `temperatura` varchar(15)  COLLATE utf8_spanish_ci NOT NULL,
    `poblacion` INT(10) NOT NULL,
    `servicio_habitaciones` varchar(3)  COLLATE utf8_spanish_ci NOT NULL,
    `ingresos` decimal(11,2) NOT NULL,
    `valoracion` decimal(2,1) NOT NULL,
    `tiene_ascensor` varchar(3) COLLATE utf8_spanish_ci NOT NULL,
    `traslado_aeropuerto` varchar(3) COLLATE utf8_spanish_ci NOT NULL,
    `parking` varchar(8) COLLATE utf8_spanish_ci NOT NULL,
    `presupuesto` decimal(11,2) NOT NULL,
    `pres_marketing` decimal(11,2) NOT NULL,
    `pais` varchar(32) COLLATE utf8_spanish_ci NOT NULL,
    `estrellas` decimal(1,0) UNSIGNED NOT NULL,
    `tipo_hotel` decimal(1,0) UNSIGNED NOT NULL,
    `ciudad` varchar(58) COLLATE utf8_spanish_ci NOT NULL,

    # TIMESTAMP
    `ultima_actualizacion_hotel` datetime NOT NULL,    
    
    PRIMARY KEY (`hotel_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


DROP TABLE IF EXISTS `dim_espacio_hospedaje`;
CREATE TABLE `dim_espacio_hospedaje` (

    # DIMENSION KEY
    `espacio_hospedaje_key` int(8) NOT NULL AUTO_INCREMENT,

    # DIMENSION ATRIBUTES
    `id_espacio` varchar(9) NOT NULL,
    `num_banhos` decimal(1,0) NOT NULL,
    `num_camas` decimal(1,0) COLLATE utf8_spanish_ci NOT NULL,
    `tiene_terraza` varchar(3) COLLATE utf8_spanish_ci NOT NULL,
    `admite_fumadores` varchar(3) COLLATE utf8_spanish_ci NOT NULL,
    `admite_mascotas` varchar(3) COLLATE utf8_spanish_ci NOT NULL,
    `tiene_cancelacion_gratis` varchar(3) COLLATE utf8_spanish_ci NOT NULL,
    `tiene_movilidad_adaptada` varchar(3) COLLATE utf8_spanish_ci NOT NULL,
    `precio_noche` varchar(13) COLLATE utf8_spanish_ci NOT NULL,
    `luminosidad` varchar(5) COLLATE utf8_spanish_ci NOT NULL,
    `tipo_alojamiento` varchar(12) COLLATE utf8_spanish_ci NOT NULL,
    `superficie` varchar(8) COLLATE utf8_spanish_ci NOT NULL, 
    `tiene_internet` varchar(3) COLLATE utf8_spanish_ci NOT NULL,
    `tiene_vistas` varchar(3) COLLATE utf8_spanish_ci NOT NULL,
    `tiene_climatizacion` varchar(3) COLLATE utf8_spanish_ci NOT NULL,

    # TIMESTAMP
    `ultima_actualizacion_hospedaje` datetime NOT NULL,    
    
    PRIMARY KEY (`espacio_hospedaje_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


DROP TABLE IF EXISTS `dim_huesped`;
CREATE TABLE `dim_huesped` (

  # DIMENSION KEY
  `huesped_key` int(10) NOT NULL AUTO_INCREMENT,

  # DIMENSION ATRIBUTES
  `id_cliente` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `descubrimiento` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `tiene_familia_numerosa` varchar(3) COLLATE utf8_spanish_ci NOT NULL,
  `edad` varchar(12) COLLATE utf8_spanish_ci NOT NULL,
  `genero` varchar(12) COLLATE utf8_spanish_ci NOT NULL,
  `nacionalidad` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `es_cliente_vip` varchar(3) COLLATE utf8_spanish_ci NOT NULL,
  `situacion_civil` decimal(1,0) COLLATE utf8_spanish_ci NOT NULL,
  `medio_transporte` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `ingresos_medios` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `pais_residencia` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  
  # TIMESTAMP
  `ultima_actualizacion_huesped` datetime NOT NULL,    
    
  PRIMARY KEY (`huesped_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

DROP TABLE IF EXISTS `dim_fecha`;

CREATE TABLE `dim_fecha` (
  `date_key` int(8) NOT NULL,
  `date_value` date NOT NULL,

  `day_in_month` tinyint(3) NOT NULL,
  `day_name` char(12) NOT NULL,
  `is_first_day_in_month` char(10) NOT NULL,
  `is_last_day_in_month` char(10) NOT NULL,
  `month_number` tinyint(3) NOT NULL,
  `week_in_year` tinyint(3) NOT NULL,
  `quarter_number` tinyint(3) NOT NULL,
  `year4` smallint(5) NOT NULL,
    
  PRIMARY KEY (`date_key`),
  UNIQUE KEY `date` (`date_value`) USING BTREE,
  UNIQUE KEY `date_value` (`date_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
