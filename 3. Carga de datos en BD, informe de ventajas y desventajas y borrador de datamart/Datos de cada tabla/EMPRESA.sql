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
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empresa` (
  `CIF` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `ID_CLIENTE` varchar(9) COLLATE utf8_spanish_ci DEFAULT NULL,
  `NOMBRE` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `NUM_EMPLEADOS` decimal(4,0) unsigned DEFAULT NULL,
  `ALCANCE` enum('Local','Regional','Nacional','Comunitaria','Multinacional') COLLATE utf8_spanish_ci NOT NULL,
  `TIPO_EMPRESA` enum('Limitada','Anónima','Cooperativa','Autónomo') COLLATE utf8_spanish_ci NOT NULL,
  `ULTIMA_ACTUALIZACION` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`CIF`),
  UNIQUE KEY `ID_CLIENTE` (`ID_CLIENTE`),
  CONSTRAINT `empresa_ibfk_1` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` VALUES ('001624828','919076236','Roob and Sons',3080,'Multinacional','Autónomo','2010-08-06 16:31:30'),('025592621','103864093','Lakin and Sons',673,'Nacional','Autónomo','1991-11-20 06:36:00'),('049374869','111396591','Dibbert, Hartmann and Marvin',3190,'Local','Anónima','1976-01-27 03:53:35'),('051510755','922231935','Hane LLC',4901,'Local','Cooperativa','2019-03-31 11:30:01'),('097388751','905153627','Howell, Bartoletti and Runte',8950,'Multinacional','Limitada','1973-11-26 09:48:43'),('112588967','521904939','Schaden Group',7435,'Multinacional','Anónima','2002-01-07 23:04:28'),('118493717','282621134','Hane, Bogisich and Cartwright',3405,'Regional','Autónomo','1989-07-09 17:17:21'),('175279466','517684546','West-Runte',2067,'Local','Cooperativa','1993-06-05 13:00:38'),('183797029','357745419','Brakus Ltd',4567,'Nacional','Limitada','2004-12-25 17:14:27'),('188603517','610737147','Prohaska, Macejkovic and Barton',2817,'Local','Anónima','1980-09-04 10:29:06'),('189515201','567309514','Hane-Kreiger',1421,'Regional','Cooperativa','1973-04-13 23:09:48'),('201975385','600660335','Cummings, Nienow and Roob',2693,'Multinacional','Cooperativa','1998-02-03 00:23:13'),('226713233','138637098','Cruickshank Ltd',2957,'Comunitaria','Anónima','1990-12-09 23:16:59'),('251339871','152763959','Ortiz, Kessler and Rodriguez',9959,'Comunitaria','Limitada','1999-10-03 04:03:46'),('255074118','204603709','Koss-Sporer',9249,'Nacional','Cooperativa','1982-07-07 10:13:55'),('259984586','325454174','Price, Moen and Treutel',4000,'Nacional','Anónima','2019-08-30 12:16:10'),('281769402','032976109','Rau, Kreiger and Prosacco',3926,'Comunitaria','Cooperativa','2009-02-18 03:32:30'),('291167137','706910386','Von and Sons',1794,'Regional','Autónomo','2000-05-01 01:47:23'),('313347591','676841637','Koelpin, Huel and Predovic',8341,'Multinacional','Anónima','1970-09-10 04:22:06'),('324119257','356182968','Parisian and Sons',2863,'Comunitaria','Cooperativa','2013-01-07 01:49:51'),('326490880','392899308','Batz-Steuber',3428,'Nacional','Autónomo','2005-08-27 08:21:20'),('356416358','970595992','Douglas-Powlowski',795,'Nacional','Autónomo','1975-03-22 05:07:10'),('378356227','577671678','Hartmann, Runolfsson and Corwin',2110,'Multinacional','Cooperativa','1996-03-20 07:23:26'),('384761902','063907023','McDermott-Murray',910,'Regional','Cooperativa','2002-11-12 08:38:09'),('407028612','834772678','Brekke, Gibson and Nitzsche',206,'Nacional','Autónomo','1979-06-14 06:40:19'),('407923850','680757285','Maggio Ltd',9846,'Regional','Anónima','1974-12-12 15:40:27'),('447083210','480525762','Schultz, Wolf and Stiedemann',3477,'Comunitaria','Autónomo','1995-07-07 11:13:34'),('518251236','378681011','Halvorson-Gorczany',825,'Nacional','Cooperativa','1989-10-06 15:24:21'),('544718246','041647314','Schuster, McLaughlin and Farrell',5443,'Comunitaria','Autónomo','2009-01-30 01:31:31'),('578605290','657217245','Christiansen Inc',6911,'Regional','Cooperativa','1983-11-15 18:17:02'),('637023211','398059213','Runte, White and Sporer',2042,'Multinacional','Cooperativa','2018-11-09 23:39:26'),('703321922','221812661','Bergstrom, Ondricka and Schinner',7718,'Regional','Anónima','1982-10-11 05:43:27'),('774237733','618775593','Haley, Kreiger and Cartwright',8457,'Nacional','Limitada','1972-12-23 09:41:02'),('785026356','206090524','Konopelski-Fadel',7856,'Comunitaria','Cooperativa','2005-07-11 22:03:20'),('788183074','627469700','Spinka, Willms and Wolf',6467,'Nacional','Limitada','1990-07-12 09:12:36'),('825827724','196035155','Bradtke, Erdman and Jenkins',3003,'Nacional','Cooperativa','2010-03-18 08:13:43'),('839385662','544825003','Bode, Weber and Gislason',5775,'Local','Cooperativa','1974-10-19 18:19:56'),('881653830','243155853','Harvey, Koss and Hintz',9775,'Comunitaria','Cooperativa','1991-01-09 08:23:47'),('888874437','979183204','Kuphal, Hamill and DuBuque',2996,'Comunitaria','Anónima','1990-08-28 14:42:28'),('907426566','361350300','Wiegand Group',9599,'Local','Autónomo','1986-01-22 00:11:33'),('938948728','672986971','Willms Group',2939,'Comunitaria','Autónomo','2009-04-30 05:36:28'),('942089345','946668971','Bauch Inc',2739,'Nacional','Anónima','2008-03-29 10:05:30'),('943572027','304874734','Langworth, Hackett and McKenzie',986,'Regional','Limitada','1974-02-19 20:09:31'),('945327145','328698329','Zemlak, Raynor and Dach',430,'Comunitaria','Autónomo','1980-06-18 12:17:43'),('950502680','542170353','Olson-Kuhn',1232,'Multinacional','Cooperativa','2002-03-03 03:43:29'),('961580996','995884029','Balistreri, Zboncak and Hansen',6447,'Regional','Autónomo','2012-06-18 23:40:14'),('961640331','025775867','Schuppe, Ondricka and Bahringer',5138,'Regional','Limitada','2008-04-16 05:43:59'),('965504465','613113862','Haley-Breitenberg',2667,'Nacional','Autónomo','2003-04-17 13:04:52'),('972791554','854969713','Goldner Inc',8418,'Local','Autónomo','2005-11-26 22:11:23'),('998900402','275880097','Rippin Group',6272,'Local','Cooperativa','2005-07-30 23:07:07');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-04  1:36:56
