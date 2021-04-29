-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-04-2021 a las 09:20:23
-- Versión del servidor: 10.4.17-MariaDB
-- Versión de PHP: 7.4.15

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `hotel_dwh`
--
CREATE DATABASE IF NOT EXISTS `hotel_dwh` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hotel_dwh`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dim_espacio_hospedaje`
--

DROP TABLE IF EXISTS `dim_espacio_hospedaje`;
CREATE TABLE IF NOT EXISTS `dim_espacio_hospedaje` (
  `espacio_hospedaje_key` int(8) NOT NULL AUTO_INCREMENT,
  `id_espacio` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `num_banhos` decimal(1,0) NOT NULL,
  `num_camas` decimal(1,0) NOT NULL,
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
  `ultima_actualizacion_hospedaje` datetime NOT NULL,
  PRIMARY KEY (`espacio_hospedaje_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dim_fecha`
--

DROP TABLE IF EXISTS `dim_fecha`;
CREATE TABLE IF NOT EXISTS `dim_fecha` (
  `date_key` int(8) NOT NULL,
  `date_value` date NOT NULL,
  `day_in_month` tinyint(3) NOT NULL,
  `day_name` char(12) COLLATE utf8_spanish_ci NOT NULL,
  `is_first_day_in_month` char(10) COLLATE utf8_spanish_ci NOT NULL,
  `is_last_day_in_month` char(10) COLLATE utf8_spanish_ci NOT NULL,
  `month_number` tinyint(3) NOT NULL,
  `week_in_year` tinyint(3) NOT NULL,
  `quarter_number` tinyint(3) NOT NULL,
  `year4` smallint(5) NOT NULL,
  PRIMARY KEY (`date_key`),
  UNIQUE KEY `date` (`date_value`) USING BTREE,
  UNIQUE KEY `date_value` (`date_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dim_hotel`
--

DROP TABLE IF EXISTS `dim_hotel`;
CREATE TABLE IF NOT EXISTS `dim_hotel` (
  `hotel_key` int(8) NOT NULL AUTO_INCREMENT,
  `id_hotel` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `distancia_playa` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
  `distancia_centro` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
  `temperatura` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `poblacion` int(10) NOT NULL,
  `servicio_habitaciones` varchar(3) COLLATE utf8_spanish_ci NOT NULL,
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
  `activo` char(3) COLLATE utf8_spanish_ci NOT NULL,
  `ultima_actualizacion_hotel` datetime NOT NULL,
  PRIMARY KEY (`hotel_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dim_huesped`
--

DROP TABLE IF EXISTS `dim_huesped`;
CREATE TABLE IF NOT EXISTS `dim_huesped` (
  `huesped_key` int(10) NOT NULL AUTO_INCREMENT,
  `id_cliente` varchar(9) COLLATE utf8_spanish_ci DEFAULT NULL,
  `descubrimiento` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `tiene_familia_numerosa` varchar(3) COLLATE utf8_spanish_ci DEFAULT NULL,
  `edad` varchar(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  `genero` varchar(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nacionalidad` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `es_cliente_vip` varchar(3) COLLATE utf8_spanish_ci DEFAULT NULL,
  `situacion_civil` decimal(1,0) DEFAULT NULL,
  `medio_transporte` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `ingresos_medios` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `pais_residencia` varchar(40) COLLATE utf8_spanish_ci DEFAULT NULL,
  `huesped_num_version` smallint(5) DEFAULT NULL,
  `huesped_valido_desde` date DEFAULT NULL,
  `huesped_valido_hasta` date DEFAULT NULL,
  `ultima_actualizacion_huesped` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`huesped_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fact_reserva`
--

DROP TABLE IF EXISTS `fact_reserva`;
CREATE TABLE IF NOT EXISTS `fact_reserva` (
  `reserva_key` int(8) NOT NULL AUTO_INCREMENT,
  `id_reserva` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `espacio_hospedaje_key` int(8) NOT NULL,
  `fecha_entrada_key` int(8) NOT NULL,
  `fecha_salida_key` int(8) NOT NULL,
  `huesped_key` int(8) NOT NULL,
  `hotel_key` int(8) NOT NULL,
  `numero_reservas` int(11) NOT NULL,
  `descuento_aplicado` float(10,2) NOT NULL,
  `importe_medio` float(10,2) NOT NULL,
  `importe_bruto` float(10,2) NOT NULL,
  `importe_final` float(10,2) NOT NULL,
  `duracion` int(8) NOT NULL,
  `ultima_actualizacion_reserva` datetime NOT NULL,
  PRIMARY KEY (`reserva_key`),
  KEY `espacio_hospedaje_key` (`espacio_hospedaje_key`),
  KEY `fecha_entrada_key` (`fecha_entrada_key`),
  KEY `fecha_salida_key` (`fecha_salida_key`),
  KEY `huesped_key` (`huesped_key`),
  KEY `hotel_key` (`hotel_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `fact_reserva`
--
ALTER TABLE `fact_reserva`
  ADD CONSTRAINT `fact_reserva_ibfk_1` FOREIGN KEY (`espacio_hospedaje_key`) REFERENCES `dim_espacio_hospedaje` (`espacio_hospedaje_key`),
  ADD CONSTRAINT `fact_reserva_ibfk_2` FOREIGN KEY (`fecha_entrada_key`) REFERENCES `dim_fecha` (`date_key`),
  ADD CONSTRAINT `fact_reserva_ibfk_3` FOREIGN KEY (`fecha_salida_key`) REFERENCES `dim_fecha` (`date_key`),
  ADD CONSTRAINT `fact_reserva_ibfk_4` FOREIGN KEY (`huesped_key`) REFERENCES `dim_huesped` (`huesped_key`),
  ADD CONSTRAINT `fact_reserva_ibfk_5` FOREIGN KEY (`hotel_key`) REFERENCES `dim_hotel` (`hotel_key`);
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
