-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-05-2021 a las 20:38:05
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
-- Base de datos: `hotel`
--
CREATE DATABASE IF NOT EXISTS `hotel` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE `hotel`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agencia`
--

DROP TABLE IF EXISTS `agencia`;
CREATE TABLE IF NOT EXISTS `agencia` (
  `COD_AGENCIA` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `ID_CLIENTE` varchar(9) COLLATE utf8_spanish_ci DEFAULT NULL,
  `NOMBRE` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `FECHA_INICIO_RELACIONES` date NOT NULL,
  `PAIS_ORIGEN` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `ES_VIRTUAL` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `VALORACION` decimal(2,0) NOT NULL,
  `ULTIMA_ACTUALIZACION` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`COD_AGENCIA`),
  UNIQUE KEY `ID_CLIENTE` (`ID_CLIENTE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `apartamento`
--

DROP TABLE IF EXISTS `apartamento`;
CREATE TABLE IF NOT EXISTS `apartamento` (
  `ID_ESPACIO` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `TIENE_SALON` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `COCINA_ELECTRICA` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `NUM_PLANTAS` decimal(2,0) NOT NULL,
  `TIENE_ASCENSOR` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `NUM_HABITACIONES` int(1) NOT NULL,
  `ULTIMA_ACTUALIZACION` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID_ESPACIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aprendiz`
--

DROP TABLE IF EXISTS `aprendiz`;
CREATE TABLE IF NOT EXISTS `aprendiz` (
  `NUM_ID` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `FECHA_INGRESO` date DEFAULT NULL,
  PRIMARY KEY (`NUM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aprendiz_realiza_practica`
--

DROP TABLE IF EXISTS `aprendiz_realiza_practica`;
CREATE TABLE IF NOT EXISTS `aprendiz_realiza_practica` (
  `ID_APRENDIZ_PRACTICA` varchar(12) COLLATE utf8_spanish_ci NOT NULL,
  `NUM_ID_APRENDIZ` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `ID_PRACTICA` varchar(3) COLLATE utf8_spanish_ci NOT NULL,
  `HORAS_REALIZADAS` float(7,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_APRENDIZ_PRACTICA`),
  UNIQUE KEY `NUM_ID_APRENDIZ` (`NUM_ID_APRENDIZ`),
  UNIQUE KEY `ID_PRACTICA` (`ID_PRACTICA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `ID_CLIENTE` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `FECHA_PRIMER_CONTRATO` date NOT NULL,
  `TIPO_CLIENTE` enum('AGENCIA','EMPRESA','HUESPED') COLLATE utf8_spanish_ci NOT NULL DEFAULT 'HUESPED',
  `ULTIMA_ACTUALIZACION` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID_CLIENTE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_prioritario`
--

DROP TABLE IF EXISTS `cliente_prioritario`;
CREATE TABLE IF NOT EXISTS `cliente_prioritario` (
  `NUM_ID` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `ID_CLIENTE` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `RANGO_PRIORIDAD` int(1) UNSIGNED NOT NULL,
  PRIMARY KEY (`NUM_ID`,`ID_CLIENTE`),
  KEY `ID_CLIENTE` (`ID_CLIENTE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_reserva_esp_hospedaje`
--

DROP TABLE IF EXISTS `cliente_reserva_esp_hospedaje`;
CREATE TABLE IF NOT EXISTS `cliente_reserva_esp_hospedaje` (
  `ID_RESERVA` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `ID_CLIENTE` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `ID_ESPACIO` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `FECHA_RESERVA` date NOT NULL,
  `FECHA_ENTRADA` date NOT NULL,
  `FECHA_SALIDA` date NOT NULL,
  `PRECIO` decimal(7,2) UNSIGNED DEFAULT NULL,
  `PORC_DESCUENTO` decimal(2,0) DEFAULT NULL,
  `ULTIMA_ACTUALIZACION` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID_RESERVA`),
  KEY `ID_CLIENTE` (`ID_CLIENTE`),
  KEY `ID_ESPACIO` (`ID_ESPACIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contrato`
--

DROP TABLE IF EXISTS `contrato`;
CREATE TABLE IF NOT EXISTS `contrato` (
  `COD_CONTRATO` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
  `NOMBRE` varchar(40) COLLATE utf8_spanish_ci DEFAULT NULL,
  `SALARIO` float(7,2) NOT NULL,
  `DESCRIPCION` varchar(300) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`COD_CONTRATO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contrato_asignado_a_empleado`
--

DROP TABLE IF EXISTS `contrato_asignado_a_empleado`;
CREATE TABLE IF NOT EXISTS `contrato_asignado_a_empleado` (
  `ID_CONTRATO_EMPLEADO` varchar(12) COLLATE utf8_spanish_ci NOT NULL,
  `COD_CONTRATO` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
  `NUM_ID_EMPLEADO` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `FECHA_INICIO` date NOT NULL,
  `FECHA_FIN` date DEFAULT NULL,
  PRIMARY KEY (`ID_CONTRATO_EMPLEADO`),
  UNIQUE KEY `COD_CONTRATO` (`COD_CONTRATO`),
  UNIQUE KEY `NUM_ID_EMPLEADO` (`NUM_ID_EMPLEADO`),
  UNIQUE KEY `FECHA_INICIO` (`FECHA_INICIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `edificio`
--

DROP TABLE IF EXISTS `edificio`;
CREATE TABLE IF NOT EXISTS `edificio` (
  `ID_EDIFICIO` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
  `DIRECCION` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `NUM_PLANTAS` int(2) UNSIGNED NOT NULL,
  `ANHO_CONSTRUCCION` int(4) DEFAULT NULL,
  `ID_HOTEL` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`ID_EDIFICIO`),
  UNIQUE KEY `DIRECCION` (`DIRECCION`),
  KEY `ID_HOTEL` (`ID_HOTEL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

DROP TABLE IF EXISTS `empleado`;
CREATE TABLE IF NOT EXISTS `empleado` (
  `NUM_ID` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `ESPECIALIDAD` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `CUENTA_BANCO` varchar(24) COLLATE utf8_spanish_ci NOT NULL,
  `ANHOS_EXPERIENCIA` int(2) UNSIGNED DEFAULT NULL,
  `ID_HOTEL` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
  `ID_PRACTICA_SUPERVISADA` varchar(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`NUM_ID`),
  KEY `ID_HOTEL` (`ID_HOTEL`),
  KEY `ID_PRACTICA_SUPERVISADA` (`ID_PRACTICA_SUPERVISADA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

DROP TABLE IF EXISTS `empresa`;
CREATE TABLE IF NOT EXISTS `empresa` (
  `CIF` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `ID_CLIENTE` varchar(9) COLLATE utf8_spanish_ci DEFAULT NULL,
  `NOMBRE` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `NUM_EMPLEADOS` decimal(4,0) UNSIGNED DEFAULT NULL,
  `ALCANCE` enum('Local','Regional','Nacional','Comunitaria','Multinacional') COLLATE utf8_spanish_ci NOT NULL,
  `TIPO_EMPRESA` enum('Limitada','Anónima','Cooperativa') COLLATE utf8_spanish_ci NOT NULL DEFAULT 'Limitada',
  `ULTIMA_ACTUALIZACION` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`CIF`),
  UNIQUE KEY `ID_CLIENTE` (`ID_CLIENTE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `espacio`
--

DROP TABLE IF EXISTS `espacio`;
CREATE TABLE IF NOT EXISTS `espacio` (
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `espacio_en_planta`
--

DROP TABLE IF EXISTS `espacio_en_planta`;
CREATE TABLE IF NOT EXISTS `espacio_en_planta` (
  `ID_ESPACIO_EN_PLANTA` varchar(7) COLLATE utf8_spanish_ci NOT NULL,
  `ID_EDIFICIO` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
  `NUM_PLANTA` int(3) NOT NULL,
  `ID_ESPACIO` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`ID_ESPACIO_EN_PLANTA`),
  UNIQUE KEY `ID_EDIFICIO` (`ID_EDIFICIO`),
  UNIQUE KEY `NUM_PLANTA` (`NUM_PLANTA`),
  UNIQUE KEY `ID_ESPACIO` (`ID_ESPACIO`),
  KEY `ID_EDIFICIO_2` (`ID_EDIFICIO`,`NUM_PLANTA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `espacio_hospedaje`
--

DROP TABLE IF EXISTS `espacio_hospedaje`;
CREATE TABLE IF NOT EXISTS `espacio_hospedaje` (
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
  `ULTIMA_ACTUALIZACION` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID_ESPACIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `espacio_instalacion`
--

DROP TABLE IF EXISTS `espacio_instalacion`;
CREATE TABLE IF NOT EXISTS `espacio_instalacion` (
  `ID_ESPACIO` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `AFORO` decimal(3,0) UNSIGNED DEFAULT NULL,
  `HORARIO_ACCESIBLE` varchar(40) COLLATE utf8_spanish_ci DEFAULT NULL,
  `ES_EXTERIOR` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `USO_INFANTIL` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `TIPO` enum('Gimnasio','Restaurante','Piscina','Pista de tenis','Pista de pádel','Campo de Golf','Spa') COLLATE utf8_spanish_ci DEFAULT NULL,
  `ESTA_INCLUIDO` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `NECESITA_RESERVA` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `ULTIMA_ACTUALIZACION` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID_ESPACIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `espacio_trabajo`
--

DROP TABLE IF EXISTS `espacio_trabajo`;
CREATE TABLE IF NOT EXISTS `espacio_trabajo` (
  `ID_ESPACIO` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `TIPO` enum('ADMINISTRATIVO','SERVICIOS','DIRECCION') COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`ID_ESPACIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habitacion`
--

DROP TABLE IF EXISTS `habitacion`;
CREATE TABLE IF NOT EXISTS `habitacion` (
  `ID_ESPACIO` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `TIPO` enum('INDIVIDUAL','DOBLE','TRIPLE','CUADRUPLE') COLLATE utf8_spanish_ci NOT NULL,
  `ES_SUITE` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `ES_COMPARTIDO` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `BANHO_COMPARTIDO` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `TIENE_COCINA` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `ULTIMA_ACTUALIZACION` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID_ESPACIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hotel`
--

DROP TABLE IF EXISTS `hotel`;
CREATE TABLE IF NOT EXISTS `hotel` (
  `ID_HOTEL` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
  `DIRECCION` varchar(32) COLLATE utf8_spanish_ci NOT NULL,
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
  `ACTIVO` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL DEFAULT 'Sí',
  `ULTIMA_ACTUALIZACION` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID_HOTEL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `huesped`
--

DROP TABLE IF EXISTS `huesped`;
CREATE TABLE IF NOT EXISTS `huesped` (
  `NUM_ID` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `ID_CLIENTE` varchar(9) COLLATE utf8_spanish_ci DEFAULT NULL,
  `NACIONALIDAD` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `NUM_TARJETA` varchar(19) COLLATE utf8_spanish_ci DEFAULT NULL,
  `FAMILIA_NUMEROSA` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `ESTADO_CIVIL` enum('Soltero','Casado','Viudo','Divorciado') COLLATE utf8_spanish_ci DEFAULT NULL,
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

DROP TABLE IF EXISTS `persona`;
CREATE TABLE IF NOT EXISTS `persona` (
  `NUM_ID` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `NOMBRE` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `TELEFONO` varchar(31) COLLATE utf8_spanish_ci NOT NULL,
  `FECHA_NACIMIENTO` date DEFAULT NULL,
  `GENERO` enum('Masculino','Femenino','Otro') COLLATE utf8_spanish_ci DEFAULT NULL,
  `ULTIMA_ACTUALIZACION` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`NUM_ID`),
  UNIQUE KEY `TELEFONO` (`TELEFONO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planta`
--

DROP TABLE IF EXISTS `planta`;
CREATE TABLE IF NOT EXISTS `planta` (
  `ID_EDIFICIO` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
  `NUM_PLANTA` int(2) NOT NULL,
  `ACCESIBILIDAD` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`ID_EDIFICIO`,`NUM_PLANTA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `practica`
--

DROP TABLE IF EXISTS `practica`;
CREATE TABLE IF NOT EXISTS `practica` (
  `ID_PRACTICA` varchar(3) COLLATE utf8_spanish_ci NOT NULL,
  `NOMBRE` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `HORAS_TOTALES` float(4,1) UNSIGNED NOT NULL,
  `DESCRIPCION` varchar(300) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`ID_PRACTICA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `agencia`
--
ALTER TABLE `agencia`
  ADD CONSTRAINT `agencia_ibfk_1` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`) ON DELETE SET NULL;

--
-- Filtros para la tabla `aprendiz`
--
ALTER TABLE `aprendiz`
  ADD CONSTRAINT `aprendiz_ibfk_1` FOREIGN KEY (`NUM_ID`) REFERENCES `persona` (`NUM_ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `aprendiz_realiza_practica`
--
ALTER TABLE `aprendiz_realiza_practica`
  ADD CONSTRAINT `aprendiz_realiza_practica_ibfk_1` FOREIGN KEY (`NUM_ID_APRENDIZ`) REFERENCES `aprendiz` (`NUM_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `aprendiz_realiza_practica_ibfk_2` FOREIGN KEY (`ID_PRACTICA`) REFERENCES `practica` (`ID_PRACTICA`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cliente_prioritario`
--
ALTER TABLE `cliente_prioritario`
  ADD CONSTRAINT `cliente_prioritario_ibfk_1` FOREIGN KEY (`NUM_ID`) REFERENCES `empleado` (`NUM_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `cliente_prioritario_ibfk_2` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cliente_reserva_esp_hospedaje`
--
ALTER TABLE `cliente_reserva_esp_hospedaje`
  ADD CONSTRAINT `cliente_reserva_esp_hospedaje_ibfk_1` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`) ON DELETE CASCADE,
  ADD CONSTRAINT `cliente_reserva_esp_hospedaje_ibfk_2` FOREIGN KEY (`ID_ESPACIO`) REFERENCES `espacio_hospedaje` (`ID_ESPACIO`) ON DELETE CASCADE;

--
-- Filtros para la tabla `contrato_asignado_a_empleado`
--
ALTER TABLE `contrato_asignado_a_empleado`
  ADD CONSTRAINT `contrato_asignado_a_empleado_ibfk_1` FOREIGN KEY (`COD_CONTRATO`) REFERENCES `contrato` (`COD_CONTRATO`) ON DELETE CASCADE,
  ADD CONSTRAINT `contrato_asignado_a_empleado_ibfk_2` FOREIGN KEY (`NUM_ID_EMPLEADO`) REFERENCES `empleado` (`NUM_ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `edificio`
--
ALTER TABLE `edificio`
  ADD CONSTRAINT `edificio_ibfk_1` FOREIGN KEY (`ID_HOTEL`) REFERENCES `hotel` (`ID_HOTEL`) ON DELETE CASCADE;

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`NUM_ID`) REFERENCES `persona` (`NUM_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `empleado_ibfk_2` FOREIGN KEY (`ID_HOTEL`) REFERENCES `hotel` (`ID_HOTEL`) ON DELETE CASCADE,
  ADD CONSTRAINT `empleado_ibfk_3` FOREIGN KEY (`ID_PRACTICA_SUPERVISADA`) REFERENCES `aprendiz_realiza_practica` (`ID_APRENDIZ_PRACTICA`) ON DELETE SET NULL;

--
-- Filtros para la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD CONSTRAINT `empresa_ibfk_1` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`) ON DELETE SET NULL;

--
-- Filtros para la tabla `espacio`
--
ALTER TABLE `espacio`
  ADD CONSTRAINT `espacio_ibfk_1` FOREIGN KEY (`ID_HOTEL`) REFERENCES `hotel` (`ID_HOTEL`) ON DELETE CASCADE,
  ADD CONSTRAINT `espacio_ibfk_2` FOREIGN KEY (`ID_ESPACIO_CONT`) REFERENCES `espacio` (`ID_ESPACIO`) ON DELETE SET NULL;

--
-- Filtros para la tabla `espacio_en_planta`
--
ALTER TABLE `espacio_en_planta`
  ADD CONSTRAINT `espacio_en_planta_ibfk_1` FOREIGN KEY (`ID_EDIFICIO`,`NUM_PLANTA`) REFERENCES `planta` (`ID_EDIFICIO`, `NUM_PLANTA`) ON DELETE CASCADE,
  ADD CONSTRAINT `espacio_en_planta_ibfk_2` FOREIGN KEY (`ID_ESPACIO`) REFERENCES `espacio` (`ID_ESPACIO`) ON DELETE CASCADE;

--
-- Filtros para la tabla `espacio_hospedaje`
--
ALTER TABLE `espacio_hospedaje`
  ADD CONSTRAINT `espacio_hospedaje_ibfk_1` FOREIGN KEY (`ID_ESPACIO`) REFERENCES `espacio` (`ID_ESPACIO`) ON DELETE CASCADE;

--
-- Filtros para la tabla `espacio_instalacion`
--
ALTER TABLE `espacio_instalacion`
  ADD CONSTRAINT `espacio_instalacion_ibfk_1` FOREIGN KEY (`ID_ESPACIO`) REFERENCES `espacio` (`ID_ESPACIO`) ON DELETE CASCADE;

--
-- Filtros para la tabla `espacio_trabajo`
--
ALTER TABLE `espacio_trabajo`
  ADD CONSTRAINT `espacio_trabajo_ibfk_1` FOREIGN KEY (`ID_ESPACIO`) REFERENCES `espacio` (`ID_ESPACIO`) ON DELETE CASCADE;

--
-- Filtros para la tabla `habitacion`
--
ALTER TABLE `habitacion`
  ADD CONSTRAINT `habitacion_ibfk_1` FOREIGN KEY (`ID_ESPACIO`) REFERENCES `espacio_hospedaje` (`ID_ESPACIO`) ON DELETE CASCADE;

--
-- Filtros para la tabla `huesped`
--
ALTER TABLE `huesped`
  ADD CONSTRAINT `huesped_ibfk_1` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`) ON DELETE SET NULL,
  ADD CONSTRAINT `huesped_ibfk_2` FOREIGN KEY (`NUM_ID`) REFERENCES `persona` (`NUM_ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `planta`
--
ALTER TABLE `planta`
  ADD CONSTRAINT `planta_ibfk_1` FOREIGN KEY (`ID_EDIFICIO`) REFERENCES `edificio` (`ID_EDIFICIO`) ON DELETE CASCADE;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
