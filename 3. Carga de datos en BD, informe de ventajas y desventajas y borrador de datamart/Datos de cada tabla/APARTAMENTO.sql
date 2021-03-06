-- MariaDB dump 10.17  Distrib 10.4.15-MariaDB, for Linux (x86_64)
--
-- Host: mysql.hostinger.ro    Database: u574849695_24
-- ------------------------------------------------------
-- Server version	10.4.15-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `apartamento`
--

DROP TABLE IF EXISTS `apartamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apartamento` (
  `ID_ESPACIO` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `TIENE_SALON` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `COCINA_ELECTRICA` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `NUM_PLANTAS` decimal(2,0) NOT NULL,
  `TIENE_ASCENSOR` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `NUM_HABITACIONES` int(1) NOT NULL,
  `ULTIMA_ACTUALIZACION` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID_ESPACIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apartamento`
--

LOCK TABLES `apartamento` WRITE;
/*!40000 ALTER TABLE `apartamento` DISABLE KEYS */;
INSERT INTO `apartamento` VALUES ('722347687','Sí','No',1,'No',2,'1983-09-12 06:05:17'),('729519881','Sí','No',1,'Sí',3,'2010-10-20 15:40:38'),('738750803','No','Sí',4,'No',9,'1995-12-21 10:36:21'),('754842465','Sí','No',2,'No',3,'1998-02-26 12:56:39'),('764378255','No','Sí',4,'Sí',6,'1993-06-10 09:31:59'),('774622100','No','Sí',5,'No',3,'2012-06-10 17:11:48'),('786505741','No','Sí',4,'Sí',8,'2013-09-26 19:20:11'),('787074940','Sí','Sí',2,'No',6,'1974-06-22 19:54:16'),('791169840','No','No',4,'No',2,'2007-02-03 11:54:23'),('795590758','No','No',5,'No',8,'1990-06-08 13:26:10'),('803805649','No','Sí',3,'Sí',5,'1971-04-24 12:26:19'),('807362227','Sí','Sí',5,'No',2,'2014-08-08 11:05:57'),('809328115','Sí','Sí',4,'Sí',8,'2019-10-25 12:13:27'),('809489198','No','Sí',4,'No',8,'2013-11-20 17:36:20'),('809545814','No','No',2,'No',6,'2017-11-23 13:27:08'),('813326738','Sí','Sí',1,'Sí',0,'1971-12-23 05:29:02'),('815285853','No','No',5,'No',8,'1987-03-13 13:59:04'),('815902749','No','Sí',1,'No',4,'2007-06-15 07:25:47'),('817663881','No','No',1,'No',0,'2010-04-29 14:25:16'),('821702064','No','Sí',2,'Sí',4,'1972-10-02 13:11:46'),('822794929','Sí','Sí',1,'No',2,'2001-05-20 07:20:19'),('828935407','Sí','Sí',3,'No',1,'2010-08-25 00:43:40'),('829326610','No','No',3,'No',5,'2018-02-10 00:40:29'),('842221757','Sí','No',2,'Sí',2,'1980-08-14 23:16:22'),('846135370','Sí','Sí',3,'No',9,'1970-07-30 08:28:46'),('848318690','No','No',3,'No',5,'1971-02-15 06:13:42'),('854717185','Sí','No',5,'No',8,'2018-01-30 12:32:34'),('860005070','Sí','Sí',5,'No',1,'1982-04-20 11:21:49'),('860338284','Sí','Sí',2,'Sí',2,'1972-07-22 11:18:29'),('863246729','No','Sí',4,'Sí',7,'1989-09-04 03:54:50'),('866627877','No','Sí',2,'Sí',9,'1972-05-11 23:12:38'),('876834803','No','Sí',1,'Sí',7,'1997-04-08 07:18:07'),('881164449','Sí','Sí',1,'Sí',6,'1983-02-12 16:38:36'),('885837281','Sí','Sí',2,'Sí',9,'2005-12-02 01:30:42'),('910617325','No','No',4,'No',6,'1974-05-23 03:26:10'),('910737692','No','Sí',1,'No',1,'1999-10-30 01:53:26'),('920864754','No','Sí',1,'Sí',9,'1999-01-05 10:46:46'),('924370606','No','Sí',4,'Sí',2,'1976-09-28 10:34:22'),('927509350','No','Sí',5,'Sí',9,'1984-09-28 07:49:43'),('933760377','No','No',1,'No',3,'1970-10-02 04:05:44'),('935853427','No','Sí',1,'Sí',6,'1972-06-23 04:15:16'),('946316467','Sí','Sí',2,'No',7,'1972-08-10 15:59:41'),('955205550','Sí','Sí',3,'Sí',1,'2001-10-03 03:56:48'),('960925565','Sí','Sí',4,'No',6,'2000-12-13 16:30:12'),('966477448','Sí','Sí',3,'No',9,'1990-11-12 17:21:25'),('975154047','No','No',4,'No',3,'1998-05-16 08:21:02'),('976943165','No','No',2,'No',1,'1978-09-03 04:41:58'),('976972301','No','Sí',4,'Sí',2,'1998-07-24 10:21:31'),('979377000','No','No',3,'No',1,'1976-01-23 16:56:06'),('985228451','Sí','Sí',2,'No',1,'1998-12-28 02:53:55');
/*!40000 ALTER TABLE `apartamento` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-04  1:12:28
