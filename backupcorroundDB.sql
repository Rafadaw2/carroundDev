-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: localhost    Database: corroundDB
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `centro`
--

DROP TABLE IF EXISTS `centro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `centro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int DEFAULT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2675036BDE734E51` (`cliente_id`),
  CONSTRAINT `FK_2675036BDE734E51` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centro`
--

LOCK TABLES `centro` WRITE;
/*!40000 ALTER TABLE `centro` DISABLE KEYS */;
INSERT INTO `centro` VALUES (2,6,'Mercedes Centro','Calle Edgar Neville,2',916136523),(3,5,'BMW Madrid Centro','Calle Toledo 25',919874563);
/*!40000 ALTER TABLE `centro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nif` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `razon_social` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (5,'B87652403','BMW MADRID','Calle Alcalá, 254'),(6,'B87654250','Mercedes Madrid','Calle San sebastian, 10');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctrine_migration_versions`
--

LOCK TABLES `doctrine_migration_versions` WRITE;
/*!40000 ALTER TABLE `doctrine_migration_versions` DISABLE KEYS */;
INSERT INTO `doctrine_migration_versions` VALUES ('DoctrineMigrations\\Version20250511155739','2025-05-18 15:02:47',331),('DoctrineMigrations\\Version20250518103907','2025-05-18 15:02:48',73),('DoctrineMigrations\\Version20250601101730','2025-06-01 10:17:42',14),('DoctrineMigrations\\Version20250601113515','2025-06-01 11:35:24',19),('DoctrineMigrations\\Version20250601152334','2025-06-01 15:23:40',55),('DoctrineMigrations\\Version20250601164731','2025-06-01 16:47:40',20),('DoctrineMigrations\\Version20250601180801','2025-06-01 18:08:07',21),('DoctrineMigrations\\Version20250612153502','2025-06-12 15:35:12',23),('DoctrineMigrations\\Version20250613105155','2025-06-13 10:51:57',50);
/*!40000 ALTER TABLE `doctrine_migration_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messenger_messages`
--

LOCK TABLES `messenger_messages` WRITE;
/*!40000 ALTER TABLE `messenger_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messenger_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receptor`
--

DROP TABLE IF EXISTS `receptor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receptor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido1` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nif` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receptor`
--

LOCK TABLES `receptor` WRITE;
/*!40000 ALTER TABLE `receptor` DISABLE KEYS */;
INSERT INTO `receptor` VALUES (1,'rafa@gmail.com','Rafael','Soria','Fernández','4856935J',91563248);
/*!40000 ALTER TABLE `receptor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicio`
--

DROP TABLE IF EXISTS `servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vehiculo_id` int DEFAULT NULL,
  `creador_id` int NOT NULL,
  `conductor_id` int DEFAULT NULL,
  `direccion_recogida` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion_entrega` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora_entrega_prevista` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hora_entrega_real` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hora_recogida_prevista` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hora_recogida_real` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `franja_disponibilidad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `km_inicial` int DEFAULT NULL,
  `km_final` int DEFAULT NULL,
  `receptor_id` int DEFAULT NULL,
  `latitud_recogida` double DEFAULT NULL,
  `longitud_recogida` double DEFAULT NULL,
  `latitud_entrega` double DEFAULT NULL,
  `longitud_entrega` double DEFAULT NULL,
  `anulado` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CB86F22A25F7D575` (`vehiculo_id`),
  KEY `IDX_CB86F22A62F40C3D` (`creador_id`),
  KEY `IDX_CB86F22AA49DECF0` (`conductor_id`),
  KEY `IDX_CB86F22A386D8D01` (`receptor_id`),
  CONSTRAINT `FK_CB86F22A25F7D575` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculo` (`id`),
  CONSTRAINT `FK_CB86F22A386D8D01` FOREIGN KEY (`receptor_id`) REFERENCES `receptor` (`id`),
  CONSTRAINT `FK_CB86F22A62F40C3D` FOREIGN KEY (`creador_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `FK_CB86F22AA49DECF0` FOREIGN KEY (`conductor_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicio`
--

LOCK TABLES `servicio` WRITE;
/*!40000 ALTER TABLE `servicio` DISABLE KEYS */;
INSERT INTO `servicio` VALUES (1,1,6,1,'Calle Jaén, 10, Móstoles, España','Calle de Albania, 31, Arroyomolinos, España','2025-06-11',NULL,NULL,'10:00',NULL,'mañana',NULL,NULL,1,40.3270867,-3.8745717,40.2770303,-3.9261603,NULL),(2,1,6,8,'Calle Pinos Alta, 10, Madrid, España','Calle General Oraá, 20, Madrid, España','2025-06-13','09:02:13','08:33:59','08:44:59','08:33:45','tarde',15000,25000,1,40.4654335,-3.6955497,40.4361018,-3.684705,NULL),(3,1,6,1,'Calle de la Princesa, 10, Madrid, España','Calle de Albania, 31, Arroyomolinos, España','2025-06-11',NULL,NULL,NULL,NULL,'mañana',NULL,NULL,1,40.4256035,-3.7123951,40.2770303,-3.9261603,NULL),(4,1,6,1,'Travesía Pinos Alta, 12, Madrid, España','Calle Asturias, 47, Pinto, Madrid, España','2025-06-11',NULL,NULL,NULL,NULL,'mañana',NULL,NULL,1,40.4691194,-3.6993414,40.2508983,-3.6937806,NULL),(5,1,6,1,'Calle Granada, 10, Móstoles, España','Calle de García de Paredes, 20, Madrid, España','2025-06-11',NULL,NULL,NULL,NULL,'mañana',NULL,NULL,1,40.3262075,-3.8758724,40.4367822,-3.7012251,NULL),(6,1,6,1,'Calle del Marqués de Mondéjar, 20, Madrid, España','Calle de la Princesa, 5, Madrid, España','2025-06-11',NULL,NULL,NULL,NULL,'mañana',NULL,NULL,1,40.4275968,-3.6652753,40.4250671,-3.7132631,NULL),(7,1,6,1,'Calle Ponzano, 10, Madrid, España','Calle Alcalá, 250, Madrid, España','2025-06-11',NULL,NULL,NULL,NULL,'mañana',NULL,NULL,1,40.4374139,-3.6991529,40.4319871,-3.655346,NULL),(8,1,6,3,'Calle de la Ilustración, 10, Madrid, España','Calle Gran Vía, 22, Madrid, España','2025-06-13','08:50:43',NULL,'08:32:14',NULL,'mañana',NULL,NULL,1,40.4214473,-3.7171412,40.4201682,-3.7002443,NULL),(9,1,6,9,'Calle Claudio Coello, 20, Madrid, España','Avenida de Concha Espina, 35, Madrid, España','2025-06-13','08:38:05',NULL,'08:23:05',NULL,'mañana',NULL,NULL,1,40.4228912,-3.6866554,40.4527239,-3.6842687,NULL),(10,1,6,8,'Calle de Serrano, 101, Madrid, España','Calle de Luis I, 64, Madrid, España','2025-06-13','09:32:06',NULL,'09:11:53',NULL,'mañana',NULL,NULL,1,40.438668,-3.6866301,40.3749683,-3.648071,NULL),(11,1,6,3,'Calle del Doctor Fleming, 23, Madrid, España','Calle Tulipán, 43, Móstoles, España','2025-06-13','09:43:49',NULL,'09:13:18',NULL,'mañana',NULL,NULL,1,40.4599056,-3.6881472,40.3389618,-3.8684052,NULL),(12,1,6,2,'Calle del Pintor Sorolla, 12, Móstoles, España','Avenida de la Aviación, 120, Madrid, España','2025-06-13','08:34:02',NULL,'08:20:06',NULL,'mañana',NULL,NULL,1,40.3365703,-3.8666875,40.3749989,-3.7755332,NULL),(13,1,6,8,'Calle de Alejandro Dumas, 45, Madrid, España','Calle de Molina, 5, Madrid, España','2025-06-13','08:37:49',NULL,'08:20:11',NULL,'mañana',NULL,NULL,1,40.4038335,-3.7190157,40.4691339,-3.6982025,NULL),(14,1,6,9,'Avenida de las Fuerzas Armadas, 400, Madrid, España','Calle de la Veredilla, 5, Alcobendas, España','2025-06-13','09:14:07',NULL,'08:58:12',NULL,'mañana',NULL,NULL,1,40.4818087,-3.6135978,40.51585,-3.63244,NULL),(15,1,6,2,'Calle de Atocha, 120, Madrid, España','Calle Casas de Miravete, 5, Madrid, España','2025-06-13','09:21:01',NULL,'09:07:34',NULL,'mañana',NULL,NULL,1,40.4091371,-3.692722,40.3750677,-3.6423308,NULL),(16,1,6,2,'Avenida de Monforte de Lemos, 193, Madrid, España','Calle Amanecer, 10, Pozuelo de Alarcón, España','2025-06-12','09:15:25',NULL,'09:00:08',NULL,'mañana',NULL,NULL,1,40.4758131,-3.7197322,40.4420518,-3.8105409,NULL),(17,1,6,2,'Avenida de los Ángeles, 10, Pozuelo de Alarcón, España','Calle de Covadonga, 37, Leganés, España','2025-06-12','09:50:14',NULL,'09:29:08',NULL,'mañana',NULL,NULL,1,40.4087527,-3.7829195,40.325182,-3.7706807,NULL),(18,1,6,8,'Calle Tarragona, 49, Getafe, España','Calle Reyes Magos, 11, Madrid, España','2025-06-12','09:31:00',NULL,'09:05:10',NULL,'mañana',NULL,NULL,1,40.3102856,-3.7201377,40.4100285,-3.6756668,NULL),(19,1,6,8,'Calle de Pío Felipe, 55, Madrid, España','Avenida del dos de Mayo, 26, Móstoles, España','2025-06-12','08:35:38',NULL,'08:06:46',NULL,'mañana',NULL,NULL,1,40.3952966,-3.6517066,40.320841,-3.8672252,NULL),(20,1,6,NULL,'Calle del Pez, 22, Madrid, España','Calle de Marcelo Usera, 34, Madrid, España','2025-06-13',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,40.423923,-3.7056717,40.3866393,-3.7019135,0);
/*!40000 ALTER TABLE `servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `centro_id` int DEFAULT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido1` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `domicilio` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitud_domicilio` double DEFAULT NULL,
  `longitud_domicilio` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`),
  KEY `IDX_2265B05D298137A7` (`centro_id`),
  CONSTRAINT `FK_2265B05D298137A7` FOREIGN KEY (`centro_id`) REFERENCES `centro` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,NULL,'rafa@gmail.com','[]','$2y$13$Jbb.jtHFLWTpWb5JI.YHxeSd5wQxo1DH9.x6/8AzRNMy8e6EFM0iK','Rafael','Soria','Fernández','Calle Fabricas, 22',40.340795523538,-3.807267356822),(2,NULL,'paco@gmail.com','[\"ROLE_CONDUCTOR\"]','$2y$13$FbiHGLxgm2.HHP9bnpvUHOTsIiDmnp4Ufc/XidBD8z30Wato1rVYu','Francisco','Lopez',NULL,'Calle Moraleja, 10',40.269315678372,-3.9198899041285),(3,NULL,'david@gmail.com','[\"ROLE_CONDUCTOR\"]','$2y$13$lQGjlGX5Up6X/u9kXCsvgORGQ23giaY7LEwUNSU8gc7.dS/x.ukuC','David','Sanchez',NULL,'Calle Granada, 20, Móstoles, España',40.3262223,-3.8757321),(4,NULL,'admin2@gmail.com','[\"ROLE_ADMIN\"]','$2y$13$sqEunREJPEYKnGsEc1bBZemVaZYZcZT2zVbS6JQM7GxhfilWv9B.e','Admin','Administrador2',NULL,'Calle Larios, Málaga, España',36.7194687,-4.421575),(5,NULL,'planficador@gmail.com','[\"ROLE_PLANIFICADOR\"]','$2y$13$mejspCJ1clR6cM2n1t4w1ujn1JdFSQucLuIdV1k7pQGHKP0nMaKDW','Planficador','Planifica',NULL,'Calle del Laurel, Logroño, España',42.4655595,-2.4483527),(6,2,'cliente@gmail.com','[\"ROLE_CLIENTE\"]','$2y$13$Zb4bZm0JiWJM1TRR22y9MOJCAGbXNDIy.KUVVbDWwP1aSii8os1p2','Cliente','Primero',NULL,'Calle de Ponzano, Madrid, España',40.4418079,-3.6990562),(7,NULL,'manager@gmail.com','[\"ROLE_MANAGER\"]','$2y$13$iRYOfhUMyDLJJFDpT6ARj.dXYPpmPqThmUm81iyqRty6UXilQfw2O','Manager','Estadisticas',NULL,'Calle de Serrano, Madrid, España',40.4232728,-3.6882407),(8,NULL,'joseConductor@gmail.com','[\"ROLE_CONDUCTOR\"]','$2y$13$FgnJJsPniD9fM.7HZoT/fuhuDfgkqLmEKMmgMqLNOvCqdirtFBpoi','Jose Luis','Garcia','Pérez','Avenida de la Albufera, 200, Madrid, España',40.3912888,-3.6509936),(9,NULL,'pacoConductor@gmail.com','[\"ROLE_CONDUCTOR\"]','$2y$13$Yp/WsX0Zvf.P3vyquvrumOmeX0dE5Thd9jBwgFsz7z7UkowBPV6c2','Francisco','Rubalcaba','Cabarubal','Avenida de la Moncloa, 10, Madrid, España',40.4466796,-3.7167772);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehiculo`
--

DROP TABLE IF EXISTS `vehiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehiculo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marca` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modelo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `matricula` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehiculo`
--

LOCK TABLES `vehiculo` WRITE;
/*!40000 ALTER TABLE `vehiculo` DISABLE KEYS */;
INSERT INTO `vehiculo` VALUES (1,'Audi','a4','2563KLY');
/*!40000 ALTER TABLE `vehiculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehiculo_receptor`
--

DROP TABLE IF EXISTS `vehiculo_receptor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehiculo_receptor` (
  `vehiculo_id` int NOT NULL,
  `receptor_id` int NOT NULL,
  PRIMARY KEY (`vehiculo_id`,`receptor_id`),
  KEY `IDX_B2B2C38525F7D575` (`vehiculo_id`),
  KEY `IDX_B2B2C385386D8D01` (`receptor_id`),
  CONSTRAINT `FK_B2B2C38525F7D575` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculo` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_B2B2C385386D8D01` FOREIGN KEY (`receptor_id`) REFERENCES `receptor` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehiculo_receptor`
--

LOCK TABLES `vehiculo_receptor` WRITE;
/*!40000 ALTER TABLE `vehiculo_receptor` DISABLE KEYS */;
INSERT INTO `vehiculo_receptor` VALUES (1,1);
/*!40000 ALTER TABLE `vehiculo_receptor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-13 13:32:36
