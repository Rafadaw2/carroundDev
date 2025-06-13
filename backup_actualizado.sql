-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: localhost    Database: corroundDB
-- ------------------------------------------------------
-- Server version	8.0.40

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
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2675036BDE734E51` (`cliente_id`),
  CONSTRAINT `FK_2675036BDE734E51` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centro`
--

LOCK TABLES `centro` WRITE;
/*!40000 ALTER TABLE `centro` DISABLE KEYS */;
INSERT INTO `centro` VALUES (2,6,'Mercedes Centro','Calle Edgar Neville,2',916136523),(3,5,'BMW Madrid Centro','Calle Toledo 25',919874563),(4,7,'Centro Logístico Fuenlabrada','Calle Manuel Cobo Calleja, 14, Fuenlabrada',916421122),(5,8,'Almacén Frigorífico Pinto','Calle de la Plata, 2, Pinto',916913344),(6,9,'Hub Farma Alcobendas','Avenida de la Industria, 55, Alcobendas',916615566),(7,10,'Almacén Getafe','Calle del Fundidor, 8, Getafe',916827788),(8,11,'Oficina Central Textil','Calle de la Abada, 10, Madrid',915219900),(9,12,'Centro de Distribución Gourmet','Nave 5, Plataforma de Frescos, Mercamadrid',917865432),(10,13,'Almacén Central Electrónica','Calle del Silicio, 5, Villaverde, Madrid',913456789),(11,14,'Plataforma Textil Fuenlabrada','Calle de la aguja, 33, Fuenlabrada',916012345),(12,15,'Sede Central Librerías','Calle del Pergamino, 7, Getafe',916812345),(13,16,'Hub Logístico Juguetes','Avenida del Juego, 25, Alcobendas',916509876);
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
  `nif` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `razon_social` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (5,'B87652403','BMW MADRID','Calle Alcalá, 254'),(6,'B87654250','Mercedes Madrid','Calle San sebastian, 10'),(7,'B88123456','Logística Avanzada SL','Polígono Industrial Cobo Calleja, Fuenlabrada'),(8,'A28987654','Transportes Frigoríficos Velox SA','Calle de la Plata, 2, Pinto'),(9,'B89555111','Distribuciones Farmacéuticas Centro','Avenida de la Industria, 55, Alcobendas'),(10,'A45123789','Aceros y Materiales de Construcción Sur','Polígono Industrial Los Olivos, Getafe'),(11,'B87776655','Textiles Internacionales Madrid','Calle de la Abada, 10, Madrid'),(12,'A mad12345','Gourmet Foods Distribution S.A.','Calle del Sabor, 12, Mercamadrid, Madrid'),(13,'B mad67890','Equipos Electrónicos Avanzados S.L.','Polígono Industrial Marconi, Calle del Silicio, 5, Madrid'),(14,'A mad11223','Moda y Confección Peninsular','Calle de la aguja, 33, Polígono Cobo Calleja, Fuenlabrada'),(15,'B mad44556','Librerías y Papelerías Reunidas S.L.U.','Calle del Pergamino, 7, Getafe'),(16,'A mad77889','Juguetes Educativos Infantiles S.A.','Avenida del Juego, 25, Alcobendas');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
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
  `body` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nif` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `direccion_recogida` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion_entrega` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora_entrega_prevista` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hora_entrega_real` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hora_recogida_prevista` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hora_recogida_real` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `franja_disponibilidad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicio`
--

LOCK TABLES `servicio` WRITE;
/*!40000 ALTER TABLE `servicio` DISABLE KEYS */;
INSERT INTO `servicio` VALUES (1,1,6,1,'Calle Jaén, 10, Móstoles, España','Calle de Albania, 31, Arroyomolinos, España','2025-06-11',NULL,NULL,'10:00',NULL,'mañana',NULL,NULL,1,40.3270867,-3.8745717,40.2770303,-3.9261603,NULL),(2,1,6,8,'Calle Pinos Alta, 10, Madrid, España','Calle General Oraá, 20, Madrid, España','2025-06-13','09:02:13','08:33:59','08:44:59','08:33:45','tarde',15000,25000,1,40.4654335,-3.6955497,40.4361018,-3.684705,NULL),(3,1,6,1,'Calle de la Princesa, 10, Madrid, España','Calle de Albania, 31, Arroyomolinos, España','2025-06-11',NULL,NULL,NULL,NULL,'mañana',NULL,NULL,1,40.4256035,-3.7123951,40.2770303,-3.9261603,NULL),(4,1,6,1,'Travesía Pinos Alta, 12, Madrid, España','Calle Asturias, 47, Pinto, Madrid, España','2025-06-11',NULL,NULL,NULL,NULL,'mañana',NULL,NULL,1,40.4691194,-3.6993414,40.2508983,-3.6937806,NULL),(5,1,6,1,'Calle Granada, 10, Móstoles, España','Calle de García de Paredes, 20, Madrid, España','2025-06-11',NULL,NULL,NULL,NULL,'mañana',NULL,NULL,1,40.3262075,-3.8758724,40.4367822,-3.7012251,NULL),(6,1,6,1,'Calle del Marqués de Mondéjar, 20, Madrid, España','Calle de la Princesa, 5, Madrid, España','2025-06-11',NULL,NULL,NULL,NULL,'mañana',NULL,NULL,1,40.4275968,-3.6652753,40.4250671,-3.7132631,NULL),(7,1,6,1,'Calle Ponzano, 10, Madrid, España','Calle Alcalá, 250, Madrid, España','2025-06-11',NULL,NULL,NULL,NULL,'mañana',NULL,NULL,1,40.4374139,-3.6991529,40.4319871,-3.655346,NULL),(8,1,6,3,'Calle de la Ilustración, 10, Madrid, España','Calle Gran Vía, 22, Madrid, España','2025-06-13','08:50:43',NULL,'08:32:14',NULL,'mañana',NULL,NULL,1,40.4214473,-3.7171412,40.4201682,-3.7002443,NULL),(9,1,6,9,'Calle Claudio Coello, 20, Madrid, España','Avenida de Concha Espina, 35, Madrid, España','2025-06-13','08:38:05',NULL,'08:23:05',NULL,'mañana',NULL,NULL,1,40.4228912,-3.6866554,40.4527239,-3.6842687,NULL),(10,1,6,8,'Calle de Serrano, 101, Madrid, España','Calle de Luis I, 64, Madrid, España','2025-06-13','09:32:06',NULL,'09:11:53',NULL,'mañana',NULL,NULL,1,40.438668,-3.6866301,40.3749683,-3.648071,NULL),(11,1,6,3,'Calle del Doctor Fleming, 23, Madrid, España','Calle Tulipán, 43, Móstoles, España','2025-06-13','09:43:49',NULL,'09:13:18',NULL,'mañana',NULL,NULL,1,40.4599056,-3.6881472,40.3389618,-3.8684052,NULL),(12,1,6,2,'Calle del Pintor Sorolla, 12, Móstoles, España','Avenida de la Aviación, 120, Madrid, España','2025-06-13','08:34:02',NULL,'08:20:06',NULL,'mañana',NULL,NULL,1,40.3365703,-3.8666875,40.3749989,-3.7755332,NULL),(13,1,6,8,'Calle de Alejandro Dumas, 45, Madrid, España','Calle de Molina, 5, Madrid, España','2025-06-13','08:37:49',NULL,'08:20:11',NULL,'mañana',NULL,NULL,1,40.4038335,-3.7190157,40.4691339,-3.6982025,NULL),(14,1,6,9,'Avenida de las Fuerzas Armadas, 400, Madrid, España','Calle de la Veredilla, 5, Alcobendas, España','2025-06-13','09:14:07',NULL,'08:58:12',NULL,'mañana',NULL,NULL,1,40.4818087,-3.6135978,40.51585,-3.63244,NULL),(15,1,6,2,'Calle de Atocha, 120, Madrid, España','Calle Casas de Miravete, 5, Madrid, España','2025-06-13','09:21:01',NULL,'09:07:34',NULL,'mañana',NULL,NULL,1,40.4091371,-3.692722,40.3750677,-3.6423308,NULL),(16,1,6,2,'Avenida de Monforte de Lemos, 193, Madrid, España','Calle Amanecer, 10, Pozuelo de Alarcón, España','2025-06-12','09:15:25',NULL,'09:00:08',NULL,'mañana',NULL,NULL,1,40.4758131,-3.7197322,40.4420518,-3.8105409,NULL),(17,1,6,2,'Avenida de los Ángeles, 10, Pozuelo de Alarcón, España','Calle de Covadonga, 37, Leganés, España','2025-06-12','09:50:14',NULL,'09:29:08',NULL,'mañana',NULL,NULL,1,40.4087527,-3.7829195,40.325182,-3.7706807,NULL),(18,1,6,8,'Calle Tarragona, 49, Getafe, España','Calle Reyes Magos, 11, Madrid, España','2025-06-12','09:31:00',NULL,'09:05:10',NULL,'mañana',NULL,NULL,1,40.3102856,-3.7201377,40.4100285,-3.6756668,NULL),(19,1,6,8,'Calle de Pío Felipe, 55, Madrid, España','Avenida del dos de Mayo, 26, Móstoles, España','2025-06-12','08:35:38',NULL,'08:06:46',NULL,'mañana',NULL,NULL,1,40.3952966,-3.6517066,40.320841,-3.8672252,NULL),(20,1,6,NULL,'Calle del Pez, 22, Madrid, España','Calle de Marcelo Usera, 34, Madrid, España','2025-06-13',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,40.423923,-3.7056717,40.3866393,-3.7019135,0),(21,2,5,10,'Calle Manuel Cobo Calleja, 14, Fuenlabrada','Calle de Serrano, 80, Madrid','2024-04-05','11:00:00','10:55:12','09:30:00','09:28:45','mañana',50100,50125,1,40.278,-3.799,40.428,-3.685,0),(22,3,5,11,'Avenida de la Industria, 55, Alcobendas','Plaza de Callao, 2, Madrid','2024-04-08','10:30:00','10:40:21','09:00:00','09:05:10','mañana',22050,22070,1,40.545,-3.633,40.42,-3.705,0),(23,4,5,12,'Calle del Fundidor, 8, Getafe','Paseo de la Castellana, 150, Madrid','2024-04-10','12:00:00',NULL,'10:30:00','10:31:00','mañana',89000,NULL,1,40.315,-3.716,40.447,-3.691,0),(24,5,5,13,'Calle de la Abada, 10, Madrid','Aeropuerto Adolfo Suárez, T4, Madrid','2024-04-12','16:00:00','15:58:00','15:00:00','14:59:12','tarde',123400,123425,1,40.421,-3.704,40.493,-3.566,0),(25,6,5,14,'Calle de la Plata, 2, Pinto','Estación de Atocha, Madrid','2024-04-15','09:45:00','09:42:15','08:45:00','08:44:50','mañana',76500,76522,1,40.245,-3.7,40.407,-3.692,0),(26,7,5,15,'Calle del Pozo, 5, Móstoles','Calle de Alcalá, 400, Madrid','2024-04-16','11:30','11:25','10:00','10:02','mañana',45000,45025,1,40.322,-3.864,40.429,-3.646,0),(27,8,5,16,'Avenida de Europa, 20, Pozuelo de Alarcón','Calle Gran Vía, 50, Madrid','2024-04-17','10:00','09:58','09:00','08:59','mañana',91000,91015,1,40.435,-3.805,40.421,-3.708,0),(28,9,5,17,'Paseo de la Chopera, 15, Alcobendas','Calle de Velázquez, 90, Madrid','2024-04-18','14:00','14:10','13:00','13:05','tarde',32500,32518,1,40.533,-3.633,40.432,-3.683,0),(29,10,5,18,'Calle de la Luna, 8, Rivas-Vaciamadrid','Calle de Goya, 77, Madrid','2024-04-19','17:00','16:55','16:00','16:03','tarde',12800,12822,1,40.345,-3.523,40.425,-3.678,0),(30,11,22,19,'Calle Mayor, 1, Alcorcón','Avenida de América, 10, Madrid','2024-04-22','12:00','11:59','11:00','10:58','mañana',67300,67320,1,40.349,-3.828,40.437,-3.674,0),(31,12,22,10,'Centro Comercial Xanadú, Arroyomolinos','Calle de la Princesa, 30, Madrid','2024-04-23','18:00',NULL,'16:30','16:35','tarde',112000,NULL,1,40.297,-3.924,40.427,-3.715,0),(32,13,22,11,'Calle Real, 30, San Sebastián de los Reyes','Paseo del Prado, 20, Madrid','2024-04-24','10:45','10:50','09:45','09:46','mañana',14500,14520,1,40.547,-3.626,40.414,-3.693,0),(33,14,22,12,'Polígono Industrial Las Nieves, Móstoles','Plaza de España, Madrid','2024-04-25','13:00','13:15','12:00','12:02','mañana',88900,88925,1,40.339,-3.856,40.424,-3.712,0),(34,15,22,13,'Calle de la Fragua, 1, Leganés','Calle de José Ortega y Gasset, 40, Madrid','2024-04-26','11:00','10:55','10:00','10:01','mañana',54300,54315,1,40.32,-3.77,40.428,-3.682,0),(35,16,22,14,'Avenida de la Técnica, 5, Rivas-Vaciamadrid','Calle de Juan Bravo, 25, Madrid','2024-04-29','16:30',NULL,'15:30',NULL,'tarde',78100,NULL,1,40.355,-3.528,40.431,-3.684,1),(36,17,22,15,'Calle de la Magnesita, 10, Valdemoro','Avenida de Felipe II, Madrid','2024-04-30','10:00','09:50','09:00','09:05','mañana',43210,43240,1,40.181,-3.67,40.424,-3.668,0),(37,18,22,16,'Avenida de la Vía Láctea, 4, Parla','Calle de Bravo Murillo, 100, Madrid','2024-04-01','12:30','12:28','11:30','11:32','mañana',99800,99825,1,40.246,-3.778,40.449,-3.702,0),(38,19,22,17,'Calle del Río, 20, Getafe','Plaza de Castilla, Madrid','2024-04-02','15:00','15:10','14:00','14:03','tarde',15400,15428,1,40.306,-3.733,40.466,-3.689,0),(39,20,22,18,'Calle de la Noria, 3, Pinto','Calle del Príncipe de Vergara, 200, Madrid','2024-04-03','11:00',NULL,'10:00',NULL,'mañana',21500,NULL,1,40.24,-3.696,40.444,-3.673,0),(40,21,22,19,'Avenida de los Rosales, 40, Villaverde, Madrid','Calle de Orense, 50, Madrid','2024-04-04','10:00','09:59','09:00','09:01','mañana',77600,77615,1,40.344,-3.692,40.453,-3.697,0),(41,22,22,10,'Calle Manuel Cobo Calleja, 14, Fuenlabrada','Calle de Serrano, 80, Madrid','2024-05-06','11:00:00','10:58:15','09:30:00','09:31:02','mañana',50500,50525,1,40.278,-3.799,40.428,-3.685,0),(42,23,22,11,'Avenida de la Industria, 55, Alcobendas','Plaza de Callao, 2, Madrid','2024-05-07','10:30:00','10:35:00','09:00:00','09:02:11','mañana',22500,22520,1,40.545,-3.633,40.42,-3.705,0),(43,24,22,12,'Calle del Fundidor, 8, Getafe','Paseo de la Castellana, 150, Madrid','2024-05-08','12:00:00','12:10:30','10:30:00','10:33:00','mañana',89500,89528,1,40.315,-3.716,40.447,-3.691,0),(44,25,22,13,'Calle de la Abada, 10, Madrid','Aeropuerto Adolfo Suárez, T4, Madrid','2024-05-09','16:00:00',NULL,'15:00:00','15:01:00','tarde',124000,NULL,1,40.421,-3.704,40.493,-3.566,0),(45,26,22,14,'Calle de la Plata, 2, Pinto','Estación de Atocha, Madrid','2024-05-13','09:45:00','09:40:55','08:45:00','08:46:00','mañana',77000,77022,1,40.245,-3.7,40.407,-3.692,0),(46,27,22,15,'Calle del Pozo, 5, Móstoles','Calle de Alcalá, 400, Madrid','2024-05-14','11:30','11:28','10:00','10:05','mañana',45300,45325,1,40.322,-3.864,40.429,-3.646,0),(47,28,22,16,'Avenida de Europa, 20, Pozuelo de Alarcón','Calle Gran Vía, 50, Madrid','2024-05-15','10:00',NULL,'09:00',NULL,'mañana',91500,NULL,1,40.435,-3.805,40.421,-3.708,0),(48,29,22,17,'Paseo de la Chopera, 15, Alcobendas','Calle de Velázquez, 90, Madrid','2024-05-16','14:00','14:05','13:00','13:01','tarde',33000,33018,1,40.533,-3.633,40.432,-3.683,0),(49,30,22,18,'Calle de la Luna, 8, Rivas-Vaciamadrid','Calle de Goya, 77, Madrid','2024-05-17','17:00','16:58','16:00','16:00','tarde',13200,13222,1,40.345,-3.523,40.425,-3.678,0),(50,31,20,19,'Calle Mayor, 1, Alcorcón','Avenida de América, 10, Madrid','2024-05-20','12:00','12:05','11:00','11:03','mañana',67800,67820,1,40.349,-3.828,40.437,-3.674,0),(51,2,20,10,'Centro Comercial Xanadú, Arroyomolinos','Calle de la Princesa, 30, Madrid','2024-05-21','18:00','18:10','16:30','16:33','tarde',112500,112535,1,40.297,-3.924,40.427,-3.715,0),(52,3,20,11,'Calle Real, 30, San Sebastián de los Reyes','Paseo del Prado, 20, Madrid','2024-05-22','10:45',NULL,'09:45',NULL,'mañana',15000,NULL,1,40.547,-3.626,40.414,-3.693,0),(53,4,20,12,'Polígono Industrial Las Nieves, Móstoles','Plaza de España, Madrid','2024-05-23','13:00','13:05','12:00','11:58','mañana',89200,89225,1,40.339,-3.856,40.424,-3.712,0),(54,5,20,13,'Calle de la Fragua, 1, Leganés','Calle de José Ortega y Gasset, 40, Madrid','2024-05-24','11:00','11:02','10:00','10:03','mañana',54800,54815,1,40.32,-3.77,40.428,-3.682,0),(55,6,20,14,'Avenida de la Técnica, 5, Rivas-Vaciamadrid','Calle de Juan Bravo, 25, Madrid','2024-05-27','16:30','16:35','15:30','15:31','tarde',78600,78625,1,40.355,-3.528,40.431,-3.684,0),(56,7,20,15,'Calle de la Magnesita, 10, Valdemoro','Avenida de Felipe II, Madrid','2024-05-28','10:00','09:55','09:00','08:59','mañana',43800,43830,1,40.181,-3.67,40.424,-3.668,0),(57,8,20,16,'Avenida de la Vía Láctea, 4, Parla','Calle de Bravo Murillo, 100, Madrid','2024-05-29','12:30',NULL,'11:30','11:35','mañana',100500,NULL,1,40.246,-3.778,40.449,-3.702,0),(58,9,20,17,'Calle del Río, 20, Getafe','Plaza de Castilla, Madrid','2024-05-30','15:00','15:00','14:00','14:01','tarde',16000,16028,1,40.306,-3.733,40.466,-3.689,0),(59,10,20,18,'Calle de la Noria, 3, Pinto','Calle del Príncipe de Vergara, 200, Madrid','2024-05-31','11:00','10:59','10:00','10:02','mañana',22000,22025,1,40.24,-3.696,40.444,-3.673,0),(60,11,20,19,'Avenida de los Rosales, 40, Villaverde, Madrid','Calle de Orense, 50, Madrid','2024-05-02','10:00','10:05','09:00','09:03','mañana',78000,78015,1,40.344,-3.692,40.453,-3.697,0),(61,12,20,10,'Calle Manuel Cobo Calleja, 14, Fuenlabrada','Calle de Serrano, 80, Madrid','2024-06-03','11:00:00',NULL,'09:30:00','09:32:00','mañana',51000,NULL,1,40.278,-3.799,40.428,-3.685,0),(62,13,20,11,'Avenida de la Industria, 55, Alcobendas','Plaza de Callao, 2, Madrid','2024-06-04','10:30:00',NULL,'09:00:00',NULL,'mañana',23000,NULL,1,40.545,-3.633,40.42,-3.705,0),(63,14,20,12,'Calle del Fundidor, 8, Getafe','Paseo de la Castellana, 150, Madrid','2024-06-05','12:00:00','12:05:00','10:30:00','10:29:00','mañana',90000,90028,1,40.315,-3.716,40.447,-3.691,0),(64,15,20,13,'Calle de la Abada, 10, Madrid','Aeropuerto Adolfo Suárez, T4, Madrid','2024-06-06','16:00:00',NULL,'15:00:00',NULL,'tarde',125000,NULL,1,40.421,-3.704,40.493,-3.566,0),(65,16,20,14,'Calle de la Plata, 2, Pinto','Estación de Atocha, Madrid','2024-06-10','09:45:00','09:41:00','08:45:00','08:45:00','mañana',77500,77522,1,40.245,-3.7,40.407,-3.692,0),(66,17,20,15,'Calle del Pozo, 5, Móstoles','Calle de Alcalá, 400, Madrid','2024-06-11','11:30',NULL,'10:00',NULL,'mañana',46000,NULL,1,40.322,-3.864,40.429,-3.646,0),(67,18,20,16,'Avenida de Europa, 20, Pozuelo de Alarcón','Calle Gran Vía, 50, Madrid','2024-06-12','10:00','10:02','09:00','09:01','mañana',92000,92015,1,40.435,-3.805,40.421,-3.708,0),(68,19,20,17,'Paseo de la Chopera, 15, Alcobendas','Calle de Velázquez, 90, Madrid','2024-06-13','14:00',NULL,'13:00',NULL,'tarde',33500,NULL,1,40.533,-3.633,40.432,-3.683,0),(69,20,20,18,'Calle de la Luna, 8, Rivas-Vaciamadrid','Calle de Goya, 77, Madrid','2024-06-14','17:00',NULL,'16:00',NULL,'tarde',13800,NULL,1,40.345,-3.523,40.425,-3.678,0),(70,21,20,19,'Calle Mayor, 1, Alcorcón','Avenida de América, 10, Madrid','2024-06-17','12:00',NULL,'11:00',NULL,'mañana',68200,NULL,1,40.349,-3.828,40.437,-3.674,1),(71,22,20,10,'Centro Comercial Xanadú, Arroyomolinos','Calle de la Princesa, 30, Madrid','2024-06-18','18:00',NULL,'16:30',NULL,'tarde',113000,NULL,1,40.297,-3.924,40.427,-3.715,0),(72,23,20,11,'Calle Real, 30, San Sebastián de los Reyes','Paseo del Prado, 20, Madrid','2024-06-19','10:45','10:55','09:45','09:48','mañana',15500,15520,1,40.547,-3.626,40.414,-3.693,0),(73,24,20,12,'Polígono Industrial Las Nieves, Móstoles','Plaza de España, Madrid','2024-06-20','13:00',NULL,'12:00',NULL,'mañana',89800,NULL,1,40.339,-3.856,40.424,-3.712,0),(74,25,20,13,'Calle de la Fragua, 1, Leganés','Calle de José Ortega y Gasset, 40, Madrid','2024-06-21','11:00',NULL,'10:00',NULL,'mañana',55200,NULL,1,40.32,-3.77,40.428,-3.682,0),(75,26,20,14,'Avenida de la Técnica, 5, Rivas-Vaciamadrid','Calle de Juan Bravo, 25, Madrid','2024-06-24','16:30','16:40','15:30','15:32','tarde',79000,79025,1,40.355,-3.528,40.431,-3.684,0),(76,27,20,15,'Calle de la Magnesita, 10, Valdemoro','Avenida de Felipe II, Madrid','2024-06-25','10:00',NULL,'09:00',NULL,'mañana',44200,NULL,1,40.181,-3.67,40.424,-3.668,0),(77,28,20,16,'Avenida de la Vía Láctea, 4, Parla','Calle de Bravo Murillo, 100, Madrid','2024-06-26','12:30','12:35','11:30','11:31','mañana',101000,101025,1,40.246,-3.778,40.449,-3.702,0),(78,29,20,17,'Calle del Río, 20, Getafe','Plaza de Castilla, Madrid','2024-06-27','15:00',NULL,'14:00',NULL,'tarde',16500,NULL,1,40.306,-3.733,40.466,-3.689,0),(79,30,20,18,'Calle de la Noria, 3, Pinto','Calle del Príncipe de Vergara, 200, Madrid','2024-06-28','11:00',NULL,'10:00',NULL,'mañana',22500,NULL,1,40.24,-3.696,40.444,-3.673,0),(80,31,20,19,'Avenida de los Rosales, 40, Villaverde, Madrid','Calle de Orense, 50, Madrid','2024-06-01','10:00','10:10','09:00','09:05','mañana',78500,78515,1,40.344,-3.692,40.453,-3.697,0),(81,15,20,8,'Mercamadrid, Plataforma Baja, 28053 Madrid','Hospital La Paz, Paseo de la Castellana, 261, Madrid','2024-07-01','10:00:00','09:55:10','08:30:00','08:29:45','mañana',85000,85025,1,40.364,-3.662,40.474,-3.692,0),(82,22,21,4,'Centro de Carga Aérea, Aeropuerto de Barajas, Madrid','Calle de Goya, 88, Madrid','2024-07-01','12:30:00','12:25:30','11:00:00','11:05:12','mañana',45000,45018,1,40.481,-3.585,40.425,-3.678,0),(83,7,21,18,'Polígono Industrial de Villaverde, Calle San Eustaquio, 12, Madrid','Torre Picasso, Plaza de Pablo Ruiz Picasso, 1, Madrid','2024-07-02','11:00:00','11:10:00','09:45:00','09:44:50','mañana',110500,110515,1,40.347,-3.708,40.45,-3.693,0),(84,11,21,9,'Calle de Alcalá, 500, Madrid','Centro Comercial La Gavia, Calle Adolfo Bioy Casares, 2, Madrid','2024-07-02','17:00:00',NULL,'16:00:00','16:02:00','tarde',33200,NULL,1,40.435,-3.633,40.377,-3.606,0),(85,30,21,1,'Polígono Industrial La Carpetania, Getafe','IFEMA, Avenida del Partenón, 5, Madrid','2024-07-03','10:30:00',NULL,'09:00:00',NULL,'mañana',78000,NULL,1,40.318,-3.746,40.467,-3.615,0),(86,2,21,12,'Calle Fuerte de Navidad, 4, Coslada','Boadilla del Monte, Avenida Siglo XXI, 10','2024-07-03','14:00:00','13:55:00','12:45:00','12:48:00','tarde',95000,95035,1,40.428,-3.551,40.407,-3.857,0),(87,19,21,15,'Avenida de la Democracia, 7, Vicálvaro, Madrid','Calle de Ferraz, 70, Madrid','2024-07-04','11:45:00',NULL,'10:30:00',NULL,'mañana',140000,NULL,1,40.395,-3.612,40.427,-3.718,1),(88,5,21,6,'Polígono Európolis, Calle Zurich, 10, Las Rozas','Estación de Chamartín, Madrid','2024-07-04','13:00:00',NULL,'12:00:00','12:05:00','mañana',62000,NULL,1,40.509,-3.856,40.472,-3.682,0),(89,25,21,11,'Calle de la Sierra de Atapuerca, 1, Las Tablas, Madrid','Calle de Antonio López, 110, Madrid','2024-07-05','10:00:00',NULL,'09:00:00',NULL,'mañana',55500,NULL,1,40.502,-3.676,40.388,-3.706,0),(90,14,21,19,'Polígono Industrial de Fuencarral, Calle de Nuestra Señora de Valverde, 200, Madrid','Plaza de Cibeles, Madrid','2024-07-05','12:00:00','11:58:00','11:00:00','11:01:00','mañana',88800,88815,1,40.499,-3.698,40.419,-3.693,0),(91,3,21,2,'Avenida de los Artesanos, 6, Tres Cantos','Parque Warner, San Martín de la Vega','2024-07-08','11:30:00',NULL,'10:00:00',NULL,'mañana',123000,NULL,1,40.607,-3.707,40.231,-3.596,0),(92,28,21,13,'Calle de la Laguna, 10, Pinto','Puerta del Sol, Madrid','2024-07-08','16:00:00','15:50:00','15:00:00','15:05:00','tarde',41000,41022,1,40.246,-3.693,40.417,-3.703,0),(93,17,21,16,'Polígono Industrial El Lomo, Calle del Lomo, 1, Fuenlabrada','Cuatro Torres Business Area, Madrid','2024-07-09','10:00:00',NULL,'08:45:00','08:50:00','mañana',72000,NULL,1,40.298,-3.834,40.476,-3.688,0),(94,9,21,5,'Calle de la Electricidad, 30, Leganés','Wanda Metropolitano, Avenida de Luis Aragonés, 4, Madrid','2024-07-09','18:00:00',NULL,'17:00:00',NULL,'tarde',66000,NULL,1,40.334,-3.755,40.436,-3.599,0),(95,21,21,10,'Avenida de la Recomba, 10, Arganda del Rey','Zielo Shopping, Pozuelo de Alarcón','2024-07-10','11:00:00',NULL,'09:45:00',NULL,'mañana',180000,NULL,1,40.301,-3.493,40.433,-3.811,0),(96,4,21,14,'Polígono Industrial Las Monjas, Torrejón de Ardoz','Matadero Madrid, Plaza de Legazpi, 8, Madrid','2024-07-10','13:00:00','13:10:00','12:00:00','12:01:00','mañana',99000,99020,1,40.457,-3.456,40.392,-3.695,0),(97,26,21,17,'Calle del Corindón, 2, Valdemoro','Palacio Real de Madrid, Calle de Bailén, Madrid','2024-07-11','10:30:00',NULL,'09:15:00','09:20:00','mañana',37000,NULL,1,40.198,-3.666,40.418,-3.714,0),(98,13,21,3,'Polígono Industrial La Estación, Griñón','Museo del Prado, Calle de Ruiz de Alarcón, 23, Madrid','2024-07-11','12:30:00',NULL,'11:15:00',NULL,'mañana',155000,NULL,1,40.222,-3.844,40.414,-3.692,0),(99,29,21,7,'Calle del Trigo, 15, Polígono Polvoranca, Leganés','Calle de Fuencarral, 120, Madrid','2024-07-12','11:00:00',NULL,'10:00:00',NULL,'mañana',23000,NULL,1,40.34,-3.791,40.429,-3.702,0),(100,8,21,18,'Avenida de la Técnica, 20, Rivas-Vaciamadrid','Plaza de Colón, Madrid','2024-07-12','17:30:00','17:25:00','16:30:00','16:33:00','tarde',74000,74025,1,40.355,-3.528,40.424,-3.688,0),(101,20,21,9,'Calle Platino, 40, Villaverde, Madrid','Las Rozas Village, Calle Juan Ramón Jiménez, 3, Las Rozas','2024-07-15','11:00:00',NULL,'09:45:00',NULL,'mañana',200500,NULL,1,40.34,-3.711,40.507,-3.882,0),(102,6,21,1,'Centro Transportes de Coslada (CTC)','Calle de Preciados, 10, Madrid','2024-07-16','10:00:00',NULL,'08:45:00',NULL,'mañana',63000,NULL,1,40.435,-3.557,40.419,-3.705,1),(103,16,21,11,'Polígono Industrial Urtinsa, Alcorcón','Calle del General Ricardos, 150, Madrid','2024-07-17','12:00:00',NULL,'11:00:00',NULL,'mañana',73000,NULL,1,40.342,-3.812,40.395,-3.722,0),(104,23,23,13,'Avenida de los Pirineos, 7, San Sebastián de los Reyes','Calle de la Oca, 20, Carabanchel, Madrid','2024-07-18','11:30:00','11:40:00','10:15:00','10:20:00','mañana',46000,46028,1,40.556,-3.626,40.395,-3.733,0),(105,1,22,15,'Calle de la Yesera, 1, Ciempozuelos','Calle de Alberto Aguilera, 30, Madrid','2024-07-19','10:45:00',NULL,'09:30:00',NULL,'mañana',11000,NULL,1,40.169,-3.619,40.431,-3.71,0),(106,27,23,4,'Polígono Industrial Fin de Semana, Madrid','Barrio de las Letras, Plaza de Santa Ana, Madrid','2024-07-22','11:00:00',NULL,'10:00:00',NULL,'mañana',38000,NULL,1,40.443,-3.585,40.415,-3.701,0),(107,10,23,8,'Calle del Estaño, 10, Pinto','Barrio de Salamanca, Calle de Claudio Coello, 50, Madrid','2024-07-23','12:00:00','11:55:00','11:00:00','11:02:00','mañana',34000,34023,1,40.252,-3.695,40.426,-3.685,0),(108,12,23,19,'Avenida de la Industria, 30, Tres Cantos','Barrio de Chamberí, Calle de Ponzano, 40, Madrid','2024-07-24','10:30:00',NULL,'09:30:00',NULL,'mañana',130000,NULL,1,40.596,-3.704,40.438,-3.699,0),(109,31,23,17,'Calle del Hierro, 5, Arganda del Rey','Barrio de Malasaña, Calle del Pez, 20, Madrid','2024-07-25','11:45:00',NULL,'10:45:00',NULL,'mañana',51000,NULL,1,40.306,-3.486,40.424,-3.705,0),(110,18,23,6,'Polígono Industrial Los Frailes, Daganzo de Arriba','Barrio de Lavapiés, Calle de Argumosa, 15, Madrid','2024-07-26','12:30:00',NULL,'11:15:00',NULL,'mañana',145000,NULL,1,40.536,-3.456,40.407,-3.7,0),(111,24,23,2,'Avenida de Madrid, 50, Alcalá de Henares','Barrio de Chueca, Plaza de Chueca, Madrid','2024-07-29','11:00:00','11:15:00','10:00:00','10:05:00','mañana',47000,47035,1,40.482,-3.375,40.422,-3.698,0),(112,5,23,10,'Calle de la Formación, 2, Getafe','Barrio del Pilar, Avenida de Monforte de Lemos, 100, Madrid','2024-07-30','10:00:00',NULL,'09:00:00','09:02:00','mañana',63000,NULL,1,40.325,-3.754,40.475,-3.712,0),(113,15,23,14,'Polígono Industrial Los Ángeles, Getafe','Parque de El Retiro (Entrada Puerta de Alcalá), Madrid','2024-07-31','12:00:00',NULL,'11:00:00',NULL,'mañana',86000,NULL,1,40.334,-3.691,40.419,-3.688,0),(114,22,23,12,'Calle del Desarrollo, 1, Rivas-Vaciamadrid','La Moraleja, Paseo de la Marquesa Viuda de Aldama, Alcobendas','2024-07-15','13:00',NULL,'11:45',NULL,'mañana',45500,NULL,1,40.349,-3.535,40.513,-3.648,0),(115,7,23,3,'Calle de la Sagra, 5, Fuenlabrada','Soto de la Moraleja, Calle de la Begonia, 275, Alcobendas','2024-07-17','10:00',NULL,'09:00',NULL,'mañana',111000,NULL,1,40.292,-3.801,40.517,-3.633,0),(116,11,23,5,'Polígono Industrial San José de Valderas, Leganés','Ciudad Universitaria, Avenida Complutense, Madrid','2024-07-19','11:30','11:28','10:30','10:31','mañana',33700,33718,1,40.364,-3.791,40.443,-3.727,0),(117,30,23,7,'Calle del Monte de Piedad, 10, Madrid','El Pardo, Madrid','2024-07-22','12:00',NULL,'11:00',NULL,'mañana',78500,NULL,1,40.418,-3.707,40.518,-3.774,1),(118,2,23,16,'Calle de la Madera, 3, Seseña','Calle de Arturo Soria, 300, Madrid','2024-07-24','10:00',NULL,'09:00',NULL,'mañana',96000,NULL,1,40.103,-3.702,40.457,-3.642,0),(119,19,23,1,'Polígono Industrial de Paracuellos de Jarama','Aravaca, Avenida de la Osa Mayor, 50, Madrid','2024-07-26','11:00',NULL,'10:00',NULL,'mañana',141000,NULL,1,40.501,-3.535,40.461,-3.784,0),(120,5,23,13,'Calle del Acero, 1, Humanes de Madrid','Las Tablas, Avenida del Camino de Santiago, 40, Madrid','2024-07-30','12:30',NULL,'11:15',NULL,'mañana',62500,NULL,1,40.257,-3.829,40.505,-3.67,0),(121,25,23,11,'Mercamadrid, Plataforma Alta, 28053 Madrid','Hospital Gregorio Marañón, Calle del Dr. Esquerdo, 46, Madrid','2024-08-01','10:00:00',NULL,'08:30:00',NULL,'mañana',56000,NULL,1,40.364,-3.662,40.41,-3.67,0),(122,14,23,19,'Centro de Carga Aérea, Aeropuerto de Barajas, Madrid','Calle de Velázquez, 100, Madrid','2024-08-01','12:30:00',NULL,'11:00:00',NULL,'mañana',89000,NULL,1,40.481,-3.585,40.432,-3.682,0),(123,3,23,2,'Polígono Industrial de Villaverde, Calle San Norberto, 8, Madrid','Torre de Cristal, Paseo de la Castellana, 259, Madrid','2024-08-02','11:00:00',NULL,'09:45:00',NULL,'mañana',124000,NULL,1,40.347,-3.708,40.478,-3.687,0),(124,28,23,13,'Calle de Alcalá, 520, Madrid','Centro Comercial Islazul, Calle de la Calderilla, 1, Madrid','2024-08-02','17:00:00',NULL,'16:00:00',NULL,'tarde',42000,NULL,1,40.435,-3.633,40.375,-3.746,0),(125,17,23,16,'Polígono Industrial La Carpetania, Getafe','IFEMA, Avenida del Partenón, 5, Madrid','2024-08-05','10:30:00',NULL,'09:00:00',NULL,'mañana',73000,NULL,1,40.318,-3.746,40.467,-3.615,0),(126,9,23,5,'Calle del Puerto de Navacerrada, 5, Móstoles','Majadahonda, Gran Vía, 20','2024-08-05','14:00:00',NULL,'12:45:00',NULL,'tarde',67000,NULL,1,40.331,-3.868,40.474,-3.874,0),(127,21,23,10,'Avenida de la Industria, 40, Coslada','Calle de Argensola, 2, Madrid','2024-08-06','11:45:00',NULL,'10:30:00',NULL,'mañana',181000,NULL,1,40.421,-3.56,40.425,-3.691,0),(128,4,23,14,'Polígono Európolis, Calle Cabo Rufino Lázaro, 8, Las Rozas','Estación de Atocha, Madrid','2024-08-06','13:00:00',NULL,'12:00:00',NULL,'mañana',100000,NULL,1,40.509,-3.856,40.407,-3.692,0),(129,26,23,17,'Calle de la Haya, 4, Las Tablas, Madrid','Calle de Embajadores, 50, Madrid','2024-08-07','10:00:00',NULL,'09:00:00',NULL,'mañana',38000,NULL,1,40.507,-3.668,40.406,-3.698,0),(130,13,23,3,'Polígono Industrial de Fuencarral, Calle de la Isla de Java, 33, Madrid','Puerta de Toledo, Madrid','2024-08-07','12:00:00',NULL,'11:00:00',NULL,'mañana',156000,NULL,1,40.499,-3.698,40.408,-3.711,0),(131,29,23,7,'Avenida de la Vía Láctea, 40, Parla','Teatros del Canal, Calle de Cea Bermúdez, 1, Madrid','2024-08-08','11:30:00',NULL,'10:00:00',NULL,'mañana',24000,NULL,1,40.246,-3.778,40.439,-3.707,0),(132,8,23,18,'Calle del Plomo, 8, Rivas-Vaciamadrid','Plaza de Manuel Becerra, Madrid','2024-08-08','16:00:00',NULL,'15:00:00',NULL,'tarde',75000,NULL,1,40.352,-3.531,40.426,-3.665,0),(133,20,23,9,'Polígono Industrial El Palomo, Fuenlabrada','Conde de Casal, Madrid','2024-08-09','10:00:00',NULL,'08:45:00',NULL,'mañana',201000,NULL,1,40.288,-3.829,40.406,-3.669,0),(134,6,23,1,'Calle del Río Tormes, 1, Getafe','Nuevos Ministerios, Madrid','2024-08-09','18:00:00',NULL,'17:00:00',NULL,'tarde',64000,NULL,1,40.313,-3.737,40.444,-3.694,0),(135,16,23,11,'Polígono Industrial Urtinsa 2, Alcorcón','Avenida de la Albufera, 100, Madrid','2024-08-12','11:00:00',NULL,'09:45:00',NULL,'mañana',74000,NULL,1,40.339,-3.805,40.399,-3.66,0),(136,23,5,13,'Avenida de los Pirineos, 25, San Sebastián de los Reyes','Calle de López de Hoyos, 200, Madrid','2024-08-13','12:00:00',NULL,'11:00:00',NULL,'mañana',47000,NULL,1,40.556,-3.626,40.449,-3.665,0),(137,1,20,15,'Calle de la Cerámica, 5, Ciempozuelos','Calle de Raimundo Fernández Villaverde, 50, Madrid','2024-08-14','13:00:00',NULL,'11:45:00',NULL,'mañana',12000,NULL,1,40.165,-3.615,40.446,-3.699,0),(138,27,20,4,'Polígono Industrial Fin de Semana, Madrid','Calle de Santa Engracia, 80, Madrid','2024-08-16','11:30:00',NULL,'10:30:00',NULL,'mañana',39000,NULL,1,40.443,-3.585,40.437,-3.696,0),(139,10,20,8,'Calle del Cobalto, 3, Pinto','Calle del General Yagüe, 20, Madrid','2024-08-19','10:45:00',NULL,'09:45:00',NULL,'mañana',35000,NULL,1,40.252,-3.695,40.456,-3.699,0),(140,12,20,19,'Avenida de la Industria, 4, Tres Cantos','Calle de Ríos Rosas, 30, Madrid','2024-08-20','12:30:00',NULL,'11:30:00',NULL,'mañana',131000,NULL,1,40.596,-3.704,40.441,-3.698,0),(141,31,20,17,'Calle del Cobre, 10, Arganda del Rey','Calle de Ibiza, 40, Madrid','2024-08-21','11:00:00',NULL,'10:00:00',NULL,'mañana',52000,NULL,1,40.306,-3.486,40.415,-3.668,0),(142,18,20,6,'Polígono Industrial Los Frailes, Daganzo de Arriba','Calle de Diego de León, 50, Madrid','2024-08-22','12:00:00',NULL,'10:45:00',NULL,'mañana',146000,NULL,1,40.536,-3.456,40.434,-3.676,0),(143,24,20,2,'Avenida de Madrid, 80, Alcalá de Henares','Calle de Ayala, 60, Madrid','2024-08-23','10:30:00',NULL,'09:30:00',NULL,'mañana',48000,NULL,1,40.482,-3.375,40.427,-3.679,0),(144,5,20,10,'Calle de la Electricidad, 1, Getafe','Calle del Doctor Fleming, 50, Madrid','2024-08-26','11:00:00',NULL,'10:00:00',NULL,'mañana',64000,NULL,1,40.325,-3.754,40.461,-3.688,1),(145,15,20,14,'Polígono Industrial Los Olivos, Getafe','Paseo de la Habana, 30, Madrid','2024-08-27','12:30:00',NULL,'11:30:00',NULL,'mañana',87000,NULL,1,40.324,-3.715,40.451,-3.684,0),(146,22,20,12,'Calle del Progreso, 10, Rivas-Vaciamadrid','Avenida de Pío XII, 100, Madrid','2024-08-28','10:00:00',NULL,'09:00:00',NULL,'mañana',46000,NULL,1,40.349,-3.535,40.467,-3.664,0),(147,7,20,3,'Calle de la Sierra de Gredos, 8, Fuenlabrada','Avenida de los Madroños, 27, Madrid','2024-08-29','11:45:00',NULL,'10:45:00',NULL,'mañana',112000,NULL,1,40.292,-3.801,40.454,-3.626,0),(148,11,20,5,'Polígono Industrial San José de Valderas, Leganés','Calle de Alfonso XIII, 120, Madrid','2024-08-30','12:00:00',NULL,'11:00:00',NULL,'mañana',34500,NULL,1,40.364,-3.791,40.449,-3.67,0),(149,30,3,7,'Calle de la Solidaridad, 20, Fuenlabrada','Calle de la Costa Brava, 10, Mirasierra, Madrid','2024-08-12','10:00:00',NULL,'09:00:00',NULL,'mañana',79000,NULL,1,40.28,-3.807,40.49,-3.722,0),(150,2,5,16,'Calle Plomo, 10, Seseña','Calle del Padre Damián, 40, Madrid','2024-08-14','11:30:00',NULL,'10:30:00',NULL,'mañana',97000,NULL,1,40.103,-3.702,40.457,-3.691,0),(151,19,2,1,'Polígono Industrial de Paracuellos de Jarama','Calle de Concha Espina, 1, Madrid','2024-08-16','12:30:00',NULL,'11:30:00',NULL,'mañana',142000,NULL,1,40.501,-3.535,40.453,-3.688,0),(152,5,20,13,'Calle del Hierro, 20, Humanes de Madrid','Calle de la Infanta Mercedes, 90, Madrid','2024-08-19','10:00:00',NULL,'08:45:00',NULL,'mañana',63000,NULL,1,40.257,-3.829,40.457,-3.702,0),(153,25,20,11,'Mercamadrid, Plataforma Baja, 28053 Madrid','Hospital 12 de Octubre, Avenida de Córdoba, Madrid','2024-08-20','11:00:00',NULL,'10:00:00',NULL,'mañana',57000,NULL,1,40.364,-3.662,40.379,-3.694,0),(154,14,20,19,'Centro de Carga Aérea, Aeropuerto de Barajas, Madrid','Calle de Juan Hurtado de Mendoza, 4, Madrid','2024-08-21','12:00:00',NULL,'11:00:00',NULL,'mañana',90000,NULL,1,40.481,-3.585,40.459,-3.684,0),(155,3,5,2,'Polígono Industrial de Villaverde, Calle San Dalmacio, 5, Madrid','Hospital Ramón y Cajal, Carretera de Colmenar Viejo, km. 9,100, Madrid','2024-08-22','10:30:00',NULL,'09:15:00',NULL,'mañana',125000,NULL,1,40.347,-3.708,40.491,-3.694,0),(156,28,5,13,'Calle de Alcalá, 540, Madrid','Centro Comercial Plenilunio, Calle de Aracne, Madrid','2024-08-23','16:00:00',NULL,'15:00:00',NULL,'tarde',43000,NULL,1,40.435,-3.633,40.458,-3.593,0),(157,17,6,16,'Polígono Industrial La Carpetania, Getafe','Calle de Sinesio Delgado, 50, Madrid','2024-08-26','11:00:00',NULL,'10:00:00',NULL,'mañana',74000,NULL,1,40.318,-3.746,40.473,-3.704,0),(158,9,6,5,'Calle del Puerto de Cotos, 10, Móstoles','Calle de la Ribera del Loira, 46, Madrid','2024-08-27','12:30:00',NULL,'11:15:00',NULL,'mañana',68000,NULL,1,40.331,-3.868,40.463,-3.619,0),(159,21,6,10,'Avenida de la Democracia, 1, Vicálvaro, Madrid','Calle del Marqués de la Valdavia, 80, Alcobendas','2024-08-28','10:45:00',NULL,'09:45:00',NULL,'mañana',182000,NULL,1,40.395,-3.612,40.536,-3.642,0),(160,4,6,14,'Polígono Európolis, Calle Mónaco, 20, Las Rozas','Estación de Príncipe Pío, Madrid','2024-08-29','13:00:00',NULL,'12:00:00',NULL,'mañana',101000,NULL,1,40.509,-3.856,40.421,-3.723,0);
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
  `email` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `domicilio` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitud_domicilio` double DEFAULT NULL,
  `longitud_domicilio` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`),
  KEY `IDX_2265B05D298137A7` (`centro_id`),
  CONSTRAINT `FK_2265B05D298137A7` FOREIGN KEY (`centro_id`) REFERENCES `centro` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,NULL,'rafa@gmail.com','[]','$2y$13$Jbb.jtHFLWTpWb5JI.YHxeSd5wQxo1DH9.x6/8AzRNMy8e6EFM0iK','Rafael','Soria','Fernández','Calle Fabricas, 22',40.340795523538,-3.807267356822),(2,NULL,'paco@gmail.com','[\"ROLE_CONDUCTOR\"]','$2y$13$FbiHGLxgm2.HHP9bnpvUHOTsIiDmnp4Ufc/XidBD8z30Wato1rVYu','Francisco','Lopez',NULL,'Calle Moraleja, 10',40.269315678372,-3.9198899041285),(3,NULL,'david@gmail.com','[\"ROLE_CONDUCTOR\"]','$2y$13$lQGjlGX5Up6X/u9kXCsvgORGQ23giaY7LEwUNSU8gc7.dS/x.ukuC','David','Sanchez',NULL,'Calle Granada, 20, Móstoles, España',40.3262223,-3.8757321),(4,NULL,'admin2@gmail.com','[\"ROLE_ADMIN\"]','$2y$13$sqEunREJPEYKnGsEc1bBZemVaZYZcZT2zVbS6JQM7GxhfilWv9B.e','Admin','Administrador2',NULL,'Calle Larios, Málaga, España',36.7194687,-4.421575),(5,NULL,'planficador@gmail.com','[\"ROLE_PLANIFICADOR\"]','$2y$13$mejspCJ1clR6cM2n1t4w1ujn1JdFSQucLuIdV1k7pQGHKP0nMaKDW','Planficador','Planifica',NULL,'Calle del Laurel, Logroño, España',42.4655595,-2.4483527),(6,2,'cliente@gmail.com','[\"ROLE_CLIENTE\"]','$2y$13$Zb4bZm0JiWJM1TRR22y9MOJCAGbXNDIy.KUVVbDWwP1aSii8os1p2','Cliente','Primero',NULL,'Calle de Ponzano, Madrid, España',40.4418079,-3.6990562),(7,NULL,'manager@gmail.com','[\"ROLE_MANAGER\"]','$2y$13$iRYOfhUMyDLJJFDpT6ARj.dXYPpmPqThmUm81iyqRty6UXilQfw2O','Manager','Estadisticas',NULL,'Calle de Serrano, Madrid, España',40.4232728,-3.6882407),(8,NULL,'joseConductor@gmail.com','[\"ROLE_CONDUCTOR\"]','$2y$13$FgnJJsPniD9fM.7HZoT/fuhuDfgkqLmEKMmgMqLNOvCqdirtFBpoi','Jose Luis','Garcia','Pérez','Avenida de la Albufera, 200, Madrid, España',40.3912888,-3.6509936),(9,NULL,'pacoConductor@gmail.com','[\"ROLE_CONDUCTOR\"]','$2y$13$Yp/WsX0Zvf.P3vyquvrumOmeX0dE5Thd9jBwgFsz7z7UkowBPV6c2','Francisco','Rubalcaba','Cabarubal','Avenida de la Moncloa, 10, Madrid, España',40.4466796,-3.7167772),(10,NULL,'carlos.gomez@example.com','[\"ROLE_CONDUCTOR\"]','$2y$13$Jbb.jtHFLWTpWb5JI.YHxeSd5wQxo1DH9.x6/8AzRNMy8e6EFM0iK','Carlos','Gómez','Sánchez','Calle de los Pinos, 3, Alcorcón',40.3475,-3.8242),(11,NULL,'lucia.martin@example.com','[\"ROLE_CONDUCTOR\"]','$2y$13$Jbb.jtHFLWTpWb5JI.YHxeSd5wQxo1DH9.x6/8AzRNMy8e6EFM0iK','Lucía','Martín','Jiménez','Avenida de la Constitución, 102, Fuenlabrada',40.2847,-3.7946),(12,NULL,'javier.ruiz@example.com','[\"ROLE_CONDUCTOR\"]','$2y$13$Jbb.jtHFLWTpWb5JI.YHxeSd5wQxo1DH9.x6/8AzRNMy8e6EFM0iK','Javier','Ruiz','García','Plaza Mayor, 5, Leganés',40.3283,-3.7644),(13,NULL,'sara.diaz@example.com','[\"ROLE_CONDUCTOR\"]','$2y$13$Jbb.jtHFLWTpWb5JI.YHxeSd5wQxo1DH9.x6/8AzRNMy8e6EFM0iK','Sara','Díaz','Moreno','Calle de la Libertad, 22, Parla',40.2367,-3.7725),(14,NULL,'mario.perez@example.com','[\"ROLE_CONDUCTOR\"]','$2y$13$Jbb.jtHFLWTpWb5JI.YHxeSd5wQxo1DH9.x6/8AzRNMy8e6EFM0iK','Mario','Pérez','Alonso','Calle de la Estación, 1, Valdemoro',40.1889,-3.6792),(15,NULL,'elena.romero@example.com','[\"ROLE_CONDUCTOR\"]','$2y$13$Jbb.jtHFLWTpWb5JI.YHxeSd5wQxo1DH9.x6/8AzRNMy8e6EFM0iK','Elena','Romero','Navarro','Paseo de las Delicias, 88, Aranjuez',40.0336,-3.6042),(16,NULL,'adrian.iglesias@example.com','[\"ROLE_CONDUCTOR\"]','$2y$13$Jbb.jtHFLWTpWb5JI.YHxeSd5wQxo1DH9.x6/8AzRNMy8e6EFM0iK','Adrián','Iglesias','Soto','Calle Real, 45, Collado Villalba',40.6322,-4.0108),(17,NULL,'paula.vazquez@example.com','[\"ROLE_CONDUCTOR\"]','$2y$13$Jbb.jtHFLWTpWb5JI.YHxeSd5wQxo1DH9.x6/8AzRNMy8e6EFM0iK','Paula','Vázquez','Blanco','Avenida de España, 70, Majadahonda',40.4727,-3.8722),(18,NULL,'diego.castro@example.com','[\"ROLE_CONDUCTOR\"]','$2y$13$Jbb.jtHFLWTpWb5JI.YHxeSd5wQxo1DH9.x6/8AzRNMy8e6EFM0iK','Diego','Castro','Rey','Calle Camilo José Cela, 12, Las Rozas de Madrid',40.4925,-3.8741),(19,NULL,'andrea.nuñez@example.com','[\"ROLE_CONDUCTOR\"]','$2y$13$Jbb.jtHFLWTpWb5JI.YHxeSd5wQxo1DH9.x6/8AzRNMy8e6EFM0iK','Andrea','Nuñez','Ramos','Plaza de la Villa, 1, Pozuelo de Alarcón',40.435,-3.811),(20,9,'laura.sanz@gourmetfoods.com','[\"ROLE_CLIENTE\"]','$2y$13$KGUd1.o/n8x28i2JjFwG/u8w2Z/0d.Gk/L7b1zX1Q9E1Y.jW8rX.q','Laura','Sanz','García',NULL,NULL,NULL),(21,10,'marcos.vidal@electronicaavanzada.es','[\"ROLE_CLIENTE\"]','$2y$13$KGUd1.o/n8x28i2JjFwG/u8w2Z/0d.Gk/L7b1zX1Q9E1Y.jW8rX.q','Marcos','Vidal','Costa',NULL,NULL,NULL),(22,11,'isabel.jimenez@modapeninsular.com','[\"ROLE_CLIENTE\"]','$2y$13$KGUd1.o/n8x28i2JjFwG/u8w2Z/0d.Gk/L7b1zX1Q9E1Y.jW8rX.q','Isabel','Jiménez','Pérez',NULL,NULL,NULL),(23,12,'roberto.nunez@libreriasreunidas.net','[\"ROLE_CLIENTE\"]','$2y$13$KGUd1.o/n8x28i2JjFwG/u8w2Z/0d.Gk/L7b1zX1Q9E1Y.jW8rX.q','Roberto','Nuñez','Martín',NULL,NULL,NULL),(24,13,'ana.beltran@jugueteseducativos.es','[\"ROLE_CLIENTE\"]','$2y$13$KGUd1.o/n8x28i2JjFwG/u8w2Z/0d.Gk/L7b1zX1Q9E1Y.jW8rX.q','Ana','Beltrán','Soler',NULL,NULL,NULL);
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
  `marca` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `modelo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `matricula` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehiculo`
--

LOCK TABLES `vehiculo` WRITE;
/*!40000 ALTER TABLE `vehiculo` DISABLE KEYS */;
INSERT INTO `vehiculo` VALUES (1,'Audi','a4','2563KLY'),(2,'Mercedes-Benz','Sprinter','1122LMN'),(3,'Ford','Transit','3344PQR'),(4,'Iveco','Daily','5566STV'),(5,'Renault','Master','7788WXY'),(6,'Volkswagen','Crafter','9900BCC'),(7,'MAN','TGE','1234DFG'),(8,'Citroën','Jumper','5678HJK'),(9,'Peugeot','Boxer','9012LMN'),(10,'Fiat','Ducato','3456PQR'),(11,'Opel','Movano','7890STV'),(12,'Iveco','Eurocargo','1111BCD'),(13,'Volvo','FL','2222FGH'),(14,'Mercedes-Benz','Atego','3333JKL'),(15,'DAF','LF','4444MNP'),(16,'Renault','Midlum','5555QRS'),(17,'MAN','TGL','6666TVW'),(18,'Scania','P-Series','7777XYZ'),(19,'Iveco','Stralis','8888ABC'),(20,'Volvo','FH','9999DEF'),(21,'Mercedes-Benz','Actros','1010GHI'),(22,'DAF','XF','2020JKL'),(23,'Renault','T','3030MNO'),(24,'MAN','TGX','4040PQR'),(25,'Scania','R-Series','5050STU'),(26,'Ford','F-MAX','6060VWX'),(27,'Mercedes-Benz','eSprinter','7070YZA'),(28,'Renault','Kangoo E-Tech','8080BCD'),(29,'Peugeot','e-Partner','9090FGH'),(30,'Citroën','ë-Jumpy','1212JKL'),(31,'Nissan','Townstar EV','3434MNO');
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

-- Dump completed on 2025-06-13 15:28:03
