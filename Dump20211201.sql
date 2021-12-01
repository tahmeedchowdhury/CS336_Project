CREATE DATABASE  IF NOT EXISTS `css336project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `css336project`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: css336project
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft` (
  `aircraft_id` int NOT NULL,
  `operating_days` varchar(50) DEFAULT NULL,
  `airline_id` varchar(2) DEFAULT NULL,
  `numseats_first` int DEFAULT NULL,
  `numseats_business` int DEFAULT NULL,
  `numseats_economy` int DEFAULT NULL,
  PRIMARY KEY (`aircraft_id`),
  KEY `airline_id` (`airline_id`),
  CONSTRAINT `aircraft_ibfk_1` FOREIGN KEY (`airline_id`) REFERENCES `airline_company` (`airline_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft`
--

LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
INSERT INTO `aircraft` VALUES (1,'mon,tue,wed','UA',1,1,2),(2,'mon,tue,wed,thu,fri,sat,sun','AA',1,1,0),(3,'mon,tue','FA',1,1,0),(4,'mon,tue,wed','FA',1,1,2),(5,'mon,tue,wed,thu,fri','UA',20,20,100),(6,'mon,tue,wed,thu,fri,sat,sun','WE',1,1,1),(7,'mon,tue,wed,thu,fri','JB',1,1,2),(8,'mon,tue,wed,thu,fri','WE',1,1,1),(9,'mon,tue,wed,thu,fri','WE',1,1,11);
/*!40000 ALTER TABLE `aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airline_company`
--

DROP TABLE IF EXISTS `airline_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airline_company` (
  `airline_id` varchar(2) NOT NULL,
  PRIMARY KEY (`airline_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airline_company`
--

LOCK TABLES `airline_company` WRITE;
/*!40000 ALTER TABLE `airline_company` DISABLE KEYS */;
INSERT INTO `airline_company` VALUES ('AA'),('FA'),('JB'),('UA'),('WE');
/*!40000 ALTER TABLE `airline_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport` (
  `airport_id` varchar(3) NOT NULL,
  PRIMARY KEY (`airport_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
INSERT INTO `airport` VALUES ('ABC'),('ASL'),('IJK'),('KID'),('LAW'),('QWE'),('RAG');
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `flight_number` int NOT NULL,
  `departure_time` datetime DEFAULT NULL,
  `arrival_time` datetime DEFAULT NULL,
  `departure_airport` varchar(50) DEFAULT NULL,
  `destination_airport` varchar(50) DEFAULT NULL,
  `isDomestic` tinyint(1) DEFAULT NULL,
  `isInternational` tinyint(1) DEFAULT NULL,
  `airport_id` varchar(3) DEFAULT NULL,
  `aircraft_id` int DEFAULT NULL,
  `airline_id` varchar(2) NOT NULL,
  `price` float DEFAULT NULL,
  PRIMARY KEY (`airline_id`,`flight_number`),
  KEY `airport_id` (`airport_id`),
  KEY `aircraft_id` (`aircraft_id`),
  CONSTRAINT `flight_ibfk_4` FOREIGN KEY (`airport_id`) REFERENCES `airport` (`airport_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `flight_ibfk_5` FOREIGN KEY (`aircraft_id`) REFERENCES `aircraft` (`aircraft_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `flight_ibfk_6` FOREIGN KEY (`airline_id`) REFERENCES `airline_company` (`airline_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES (1,'2021-12-31 20:00:00','2022-01-04 01:00:00','KID','IJK',1,0,'KID',2,'AA',300),(1,'2021-11-30 21:00:00','2021-12-02 12:00:00','ABC','RAG',0,1,'ABC',4,'FA',400),(3,'2021-01-12 14:50:00','2021-01-13 01:45:00','ASL','KID',0,1,'ASL',4,'FA',350),(2,'2022-02-12 08:00:00','2022-03-14 10:19:00','LAW','ASL',0,1,'LAW',6,'UA',450),(12,'2020-04-20 12:00:00','2020-04-21 13:00:00','KID','LAW',0,1,'KID',5,'UA',200),(4,'2022-03-13 03:00:00','2022-03-14 04:00:00','LAW','KID',0,1,'LAW',8,'WE',200),(5,'2021-12-12 12:00:00','2021-12-14 09:30:00','ASL','LAW',1,0,'ASL',6,'WE',200);
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `qid` int NOT NULL,
  `question` varchar(1000) DEFAULT NULL,
  `id` int DEFAULT NULL,
  `answer` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`qid`),
  KEY `id` (`id`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'How to Book Flight',3,'Book a Flight'),(2,'How to ask questions?',4,'Write question on text bar and hit ask'),(3,'How do I reserve a flight?',2,'Click the Reserve Button after logging in'),(4,'Why does it take so long to get food at the airport?',3,'To be answered');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `number` int NOT NULL,
  `booking_fee` float DEFAULT NULL,
  `purchase_time` datetime DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `total_fare` float DEFAULT NULL,
  `isOne_way` tinyint(1) DEFAULT NULL,
  `isRound_trip` tinyint(1) DEFAULT NULL,
  `id` int DEFAULT NULL,
  PRIMARY KEY (`number`),
  KEY `id` (`id`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1,30,'2021-11-21 09:00:00','Nikhil','Damle',500,1,0,11),(2,30,'2021-11-22 12:00:00','Albert','Einstein',350,1,0,3),(3,33,'2021-12-22 12:00:00','Royce','Rolls',400,1,0,2),(4,30,'2021-11-22 09:30:00','Nikhil','Damle',400,1,0,11);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_for`
--

DROP TABLE IF EXISTS `ticket_for`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_for` (
  `number` int NOT NULL,
  `flight_number` int NOT NULL,
  `airline_id` varchar(2) NOT NULL,
  `class` varchar(10) DEFAULT NULL,
  `destination_airport` varchar(50) DEFAULT NULL,
  `departure_airport` varchar(50) DEFAULT NULL,
  `seat_number` int DEFAULT NULL,
  `airline` varchar(50) DEFAULT NULL,
  `departure_time` datetime DEFAULT NULL,
  PRIMARY KEY (`airline_id`,`flight_number`,`number`),
  KEY `number` (`number`),
  CONSTRAINT `ticket_for_ibfk_3` FOREIGN KEY (`number`) REFERENCES `ticket` (`number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ticket_for_ibfk_4` FOREIGN KEY (`airline_id`, `flight_number`) REFERENCES `flight` (`airline_id`, `flight_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_for`
--

LOCK TABLES `ticket_for` WRITE;
/*!40000 ALTER TABLE `ticket_for` DISABLE KEYS */;
INSERT INTO `ticket_for` VALUES (1,1,'AA','first','IJK','QWE',22,'American Airlines','2021-12-31 20:00:00'),(3,1,'FA','business','RAG','ABC',12,'FA','2021-11-30 21:00:00'),(4,1,'FA','business','RAG','ABC',21,'FA','2021-11-30 21:00:00'),(2,3,'FA','business','KID','ASL',33,'FA','2021-01-12 14:50:00');
/*!40000 ALTER TABLE `ticket_for` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (0,'admin','admin123','A','Horatio','Hubert'),(1,'customer_rep','customer_rep123','R','Customer','Rep'),(2,'test','customer','C','Royce','Rolls'),(3,'ilike','flights','C','Albert','Einstein'),(4,'tahmeed','nikhil','C','Tommy','Dimes'),(6,'new_customer','newpass','C','Cus','Tomer'),(7,'customer_test','passforcustomer','C','Mustard','Ketchup'),(8,'newcustomer','newcustomerpass','C','Bon','Jovi'),(9,'a','a','C','Air','Plane'),(10,'blacker','whiter','C','Ronald','McDonald'),(11,'Nikhil','Damle','C','Nikhil','Damle'),(12,'r','r','R','The','Rep'),(13,'Tony','Stark','C','Tony','Stark');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waiting_list`
--

DROP TABLE IF EXISTS `waiting_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `waiting_list` (
  `id` int NOT NULL,
  `airline_id` varchar(2) NOT NULL,
  `flight_number` int NOT NULL,
  PRIMARY KEY (`flight_number`,`airline_id`,`id`),
  KEY `airline_id` (`airline_id`,`flight_number`),
  KEY `id` (`id`),
  CONSTRAINT `waiting_list_ibfk_1` FOREIGN KEY (`airline_id`, `flight_number`) REFERENCES `flight` (`airline_id`, `flight_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `waiting_list_ibfk_2` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waiting_list`
--

LOCK TABLES `waiting_list` WRITE;
/*!40000 ALTER TABLE `waiting_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `waiting_list` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-01 15:22:44
