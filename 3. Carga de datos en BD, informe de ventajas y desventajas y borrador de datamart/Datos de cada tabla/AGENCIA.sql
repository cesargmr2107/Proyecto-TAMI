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
-- Table structure for table `agencia`
--

DROP TABLE IF EXISTS `agencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agencia` (
  `COD_AGENCIA` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `ID_CLIENTE` varchar(9) COLLATE utf8_spanish_ci DEFAULT NULL,
  `NOMBRE` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `FECHA_INICIO_RELACIONES` date NOT NULL,
  `PAIS_ORIGEN` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `ES_VIRTUAL` enum('Sí','No') COLLATE utf8_spanish_ci NOT NULL,
  `VALORACION` decimal(2,0) NOT NULL,
  `ULTIMA_ACTUALIZACION` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`COD_AGENCIA`),
  UNIQUE KEY `ID_CLIENTE` (`ID_CLIENTE`),
  CONSTRAINT `agencia_ibfk_1` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agencia`
--

LOCK TABLES `agencia` WRITE;
/*!40000 ALTER TABLE `agencia` DISABLE KEYS */;
INSERT INTO `agencia` VALUES ('024657456','825139168','Rodriguez, Gleason and Conroy','2019-09-21','Vietnam','Sí',7,'1977-07-20 02:01:35'),('030462740','149955849','Towne, Kub and Thompson','2019-11-14','Papua New Guinea','Sí',4,'1982-10-28 11:23:51'),('131222278','821472405','Mills, Kovacek and Conn','2012-09-02','Togo','Sí',8,'2016-07-21 00:34:31'),('173720155','799968909','Gislason PLC','2014-10-11','Comoros','Sí',1,'2017-03-24 21:33:14'),('194287141','820823905','Adams Inc','2012-01-12','Paraguay','Sí',8,'2019-12-30 23:17:36'),('207519251','373712738','Adams, Waters and Powlowski','2016-06-14','Timor-Leste','No',3,'2020-06-21 19:41:08'),('227401376','087404612','Oberbrunner-Maggio','2016-01-14','Vietnam','Sí',8,'1979-04-02 09:43:10'),('230378428','579399762','Conn-Bergstrom','2017-01-31','Bangladesh','Sí',7,'2018-01-02 00:45:10'),('244058984','721849885','Medhurst, Lebsack and Torp','2017-01-08','Australia','No',3,'1991-08-01 09:20:17'),('244719744','062579368','Gutkowski, Padberg and Graham','2012-02-15','Czech Republic','Sí',1,'1997-01-21 08:35:24'),('244939484','705916417','Hammes-Wehner','2013-05-25','Korea','Sí',7,'1979-11-23 16:46:20'),('293309788','552361948','Emard Inc','2016-04-03','Honduras','No',9,'1996-09-20 21:54:10'),('307577179','682258747','Schulist, Buckridge and Jacobs','2018-06-28','Cuba','No',7,'1987-12-15 23:11:15'),('314681567','174181118','Koelpin, Hammes and Kohler','2020-08-12','Netherlands Antilles','No',3,'2000-09-02 13:14:56'),('321216039','677646264','Herzog-Thiel','2017-09-04','Togo','Sí',6,'1983-02-03 06:54:27'),('329651085','356362456','Pagac-Gerhold','2012-08-08','Saint Lucia','No',7,'2006-11-03 05:12:36'),('343277836','583515659','Gusikowski LLC','2013-08-24','Brunei Darussalam','No',10,'2019-07-15 02:16:49'),('360930547','697715355','Jacobi LLC','2014-05-22','French Polynesia','No',6,'1980-08-12 20:18:39'),('434411167','409911481','Yost Inc','2021-02-19','Uzbekistan','Sí',3,'2004-09-13 04:06:17'),('460787113','424334837','Von, Herman and Toy','2011-08-20','Liberia','No',2,'2020-02-24 02:33:49'),('472105572','837980657','Block-Jaskolski','2017-09-19','Guinea-Bissau','No',3,'1994-07-20 10:00:18'),('501921633','084364806','Kovacek PLC','2020-07-02','Tokelau','No',6,'1971-08-09 17:46:06'),('517642314','182330951','Howell-Jacobi','2018-04-14','Tajikistan','Sí',5,'1989-01-26 06:01:16'),('529997978','000304774','Gislason-Mohr','2014-04-02','Nigeria','No',7,'1971-03-06 16:22:15'),('541693254','236719989','Haley and Sons','2018-11-11','Tunisia','No',8,'2018-10-29 11:10:53'),('558490641','711879587','Gutkowski, Cruickshank and Corwin','2015-11-14','Belgium','No',2,'2002-04-13 00:32:52'),('585757923','468788790','Reichert-Corwin','2013-08-25','Bulgaria','No',1,'1990-11-06 20:51:50'),('585840766','951315873','Gaylord, O\'Reilly and Aufderhar','2017-06-22','Palestinian Territory','Sí',7,'2005-01-31 12:01:29'),('629252090','029574483','Gislason, Conn and Lemke','2014-10-21','Yemen','No',9,'2012-03-02 21:32:30'),('649104544','087384638','Reichert-Botsford','2011-03-14','Uganda','No',1,'2015-10-30 02:30:28'),('655348841','005856234','Klein, Buckridge and Corkery','2016-04-28','Japan','No',6,'1970-10-03 18:50:23'),('680152862','988051214','Nikolaus-Kulas','2016-10-01','Netherlands','Sí',2,'1980-05-13 03:43:07'),('692820406','529364369','O\'Kon LLC','2011-03-26','United States Minor Outlying Islands','No',9,'2008-09-05 20:17:51'),('693722400','392277893','Hartmann-Jerde','2018-10-05','Cocos (Keeling) Islands','Sí',3,'1992-11-02 05:33:04'),('695726922','410197019','Wintheiser Inc','2014-07-24','Botswana','No',1,'2007-07-20 19:41:04'),('702555129','111500268','White-Corkery','2015-08-29','Singapore','No',7,'1995-09-25 11:57:23'),('711002467','861662333','Reinger-Stiedemann','2013-05-09','Papua New Guinea','Sí',8,'1985-06-06 05:14:30'),('719877667','063735437','Morar, Gusikowski and Luettgen','2019-09-01','Tuvalu','No',5,'1984-06-28 01:21:19'),('726237634','918934310','Johns and Sons','2019-04-19','Kiribati','No',6,'2009-03-29 18:15:48'),('727517819','388236355','Kutch LLC','2019-06-13','Singapore','No',6,'2020-07-20 06:40:06'),('730855118','640641130','Runolfsson, Schmitt and Nienow','2020-09-11','Cuba','Sí',1,'2000-02-12 05:17:50'),('737435805','250332654','Runolfsson, Kassulke and Price','2012-09-21','Jordan','No',9,'2013-11-06 17:29:22'),('766550270','107147839','O\'Connell, Rosenbaum and Buckridge','2019-07-24','Montenegro','Sí',10,'1979-11-01 14:53:14'),('781285050','262566141','Donnelly-Leffler','2015-12-02','Belarus','Sí',6,'1972-12-02 22:17:49'),('815577514','180130133','Gaylord, Prohaska and Moore','2016-08-13','Czech Republic','Sí',6,'2019-08-19 01:28:06'),('842140366','228166234','Kovacek Ltd','2018-01-14','Monaco','No',4,'1991-05-21 22:32:47'),('845946693','645279720','Kozey-Torp','2020-06-09','Montenegro','No',5,'1988-12-10 17:05:38'),('890343974','712697150','Watsica, Koss and Simonis','2019-07-13','Belgium','No',9,'1982-06-10 17:45:47'),('975793745','476506633','Thiel, Hegmann and Kerluke','2015-12-18','Italy','No',6,'2005-12-13 18:00:55'),('988817236','100855193','Nolan Ltd','2020-03-19','Trinidad and Tobago','Sí',10,'2016-11-13 23:12:52');
/*!40000 ALTER TABLE `agencia` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-04  1:32:49
