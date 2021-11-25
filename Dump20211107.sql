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
  `number_of_seats` int DEFAULT NULL,
  `airline_id` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`aircraft_id`),
  KEY `airline_id` (`airline_id`),
  CONSTRAINT `aircraft_ibfk_1` FOREIGN KEY (`airline_id`) REFERENCES `airline_company` (`airline_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft`
--

LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
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
  PRIMARY KEY (`airline_id`,`flight_number`),
  KEY `airport_id` (`airport_id`),
  KEY `aircraft_id` (`aircraft_id`),
  CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`airport_id`) REFERENCES `airport` (`airport_id`),
  CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`aircraft_id`) REFERENCES `aircraft` (`aircraft_id`),
  CONSTRAINT `flight_ibfk_3` FOREIGN KEY (`airline_id`) REFERENCES `airline_company` (`airline_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
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
  `id_number` int DEFAULT NULL,
  `total_fare` float DEFAULT NULL,
  `isOne_way` tinyint(1) DEFAULT NULL,
  `isRound_trip` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
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
  CONSTRAINT `ticket_for_ibfk_1` FOREIGN KEY (`number`) REFERENCES `ticket` (`number`),
  CONSTRAINT `ticket_for_ibfk_2` FOREIGN KEY (`airline_id`, `flight_number`) REFERENCES `flight` (`airline_id`, `flight_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_for`
--

LOCK TABLES `ticket_for` WRITE;
/*!40000 ALTER TABLE `ticket_for` DISABLE KEYS */;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (0,'admin','admin123','A'),(1,'customer_rep','customer_rep123','R'),(2,'test','customer','C'),(3,'ilike','flights','C'),(4,'tahmeed','nikhil','C'),(5,'','','C'),(6,'new_customer','newpass','C'),(7,'customer_test','passforcustomer','C'),(8,'newcustomer','newcustomerpass','C');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-07 13:04:38

INSERT INTO `aircraft`(`aircraft_id`, `operating_days`, `number_of_seats`,`airline_id`) VALUES (665, 'SUN, MON, WED', 100, 'AA');
INSERT INTO `aircraft`(`aircraft_id`, `operating_days`, `number_of_seats`,`airline_id`) VALUES (500, 'SUN, MON, TUE, WED, THU, FRI, SAT', 300, 'EK');
INSERT INTO `aircraft`(`aircraft_id`, `operating_days`, `number_of_seats`,`airline_id`) VALUES (173, 'FRI, SAT, SUN', 70, 'DL');
INSERT INTO `aircraft`(`aircraft_id`, `operating_days`, `number_of_seats`,`airline_id`) VALUES (055, 'MON, TUE, WED, THU, FRI', 50, 'DL');
INSERT INTO `aircraft`(`aircraft_id`, `operating_days`, `number_of_seats`,`airline_id`) VALUES (236, 'MON, TUE, WED', 150, 'CO');
INSERT INTO `aircraft`(`aircraft_id`, `operating_days`, `number_of_seats`,`airline_id`) VALUES (175, 'FRI, SAT, SUN', 70, 'AA');
INSERT INTO `aircraft`(`aircraft_id`, `operating_days`, `number_of_seats`,`airline_id`) VALUES (250, 'MON, FRI, SAT', 100, 'AC');
INSERT INTO `aircraft`(`aircraft_id`, `operating_days`, `number_of_seats`,`airline_id`) VALUES (180, 'FRI, SAT, SUN', 300, 'AI');
INSERT INTO `aircraft`(`aircraft_id`, `operating_days`, `number_of_seats`,`airline_id`) VALUES (233, 'MON, TUE, SAT', 300, 'QR');
INSERT INTO `aircraft`(`aircraft_id`, `operating_days`, `number_of_seats`,`airline_id`) VALUES (186, 'FRI, SAT, SUN', 70, 'DL');
INSERT INTO `aircraft`(`aircraft_id`, `operating_days`, `number_of_seats`,`airline_id`) VALUES (007, 'SUN, MON, TUE, WED, THU, FRI, SAT', 300, 'BA');
INSERT INTO `aircraft`(`aircraft_id`, `operating_days`, `number_of_seats`,`airline_id`) VALUES (300, 'MON, TUE, WED', 20, 'FX');

INSERT INTO `airline_company`(`airline_id`) VALUES ('FX');
INSERT INTO `airline_company`(`airline_id`) VALUES ('AA');
INSERT INTO `airline_company`(`airline_id`) VALUES ('CO');
INSERT INTO `airline_company`(`airline_id`) VALUES ('EK');
INSERT INTO `airline_company`(`airline_id`) VALUES ('DL');
INSERT INTO `airline_company`(`airline_id`) VALUES ('AC');
INSERT INTO `airline_company`(`airline_id`) VALUES ('AI');
INSERT INTO `airline_company`(`airline_id`) VALUES ('QR');
INSERT INTO `airline_company`(`airline_id`) VALUES ('BA');

INSERT INTO `airport`(`airport_id`) VALUES ('EWR');
INSERT INTO `airport`(`airport_id`) VALUES ('JFK');
INSERT INTO `airport`(`airport_id`) VALUES ('YYZ');
INSERT INTO `airport`(`airport_id`) VALUES ('AUH');
INSERT INTO `airport`(`airport_id`) VALUES ('AMD');
INSERT INTO `airport`(`airport_id`) VALUES ('AAN');
INSERT INTO `airport`(`airport_id`) VALUES ('BOM');
INSERT INTO `airport`(`airport_id`) VALUES ('RSW');
INSERT INTO `airport`(`airport_id`) VALUES ('BDA');
INSERT INTO `airport`(`airport_id`) VALUES ('LDJ');
INSERT INTO `airport`(`airport_id`) VALUES ('LAX');
INSERT INTO `airport`(`airport_id`) VALUES ('SFO');
INSERT INTO `airport`(`airport_id`) VALUES ('LHR');


INSERT INTO `flight`(`flight_number`, `departure_time`, `arrival_time`, `departure_airport`, 
`destination_airport`, `isDomestic`, `isInternational`, `airport_id`, `aircraft_id`, 
`airline_id`) 
VALUES ('1', '2021-11-27 09:00:00', '2021-11-27 13:30:00', 'Newark Liberty Intl airport', 
'Toronto Pearson Intl airport', 0, 1, 'EWR', 250, 'AC');
INSERT INTO `flight`(`flight_number`, `departure_time`, `arrival_time`, `departure_airport`, 
`destination_airport`, `isDomestic`, `isInternational`, `airport_id`, `aircraft_id`, 
`airline_id`) 
VALUES ('2', '2021-12-01 13:00:00', '2021-12-02 20:30:00', 'Newark Liberty Intl airport', 
'Abu Dhabi Intl Airport', 0, 1, 'EWR', 500, 'EK');
INSERT INTO `flight`(`flight_number`, `departure_time`, `arrival_time`, `departure_airport`, 
`destination_airport`, `isDomestic`, `isInternational`, `airport_id`, `aircraft_id`, 
`airline_id`) 
VALUES ('3', '2022-01-22 14:00:00', '2022-01-22 16:30:00', 'Newark Liberty Intl airport', 
'Los Angeles Intl Airport', 1, 0, 'EWR', 665, 'AA');
INSERT INTO `flight`(`flight_number`, `departure_time`, `arrival_time`, `departure_airport`, 
`destination_airport`, `isDomestic`, `isInternational`, `airport_id`, `aircraft_id`, 
`airline_id`) 
VALUES ('4', '2022-03-15 10:00:00', '2022-03-16 13:30:00', 'John F. Kennedy Intl Airport', 
'Bombay Intl Airport', 0, 1, 'EWR', 180, 'AI');
INSERT INTO `flight`(`flight_number`, `departure_time`, `arrival_time`, `departure_airport`, 
`destination_airport`, `isDomestic`, `isInternational`, `airport_id`, `aircraft_id`, 
`airline_id`) 
VALUES ('5', '2022-01-01 10:00:00', '2022-01-01 12:30:00', 'John F. Kennedy Intl Airport', 
'Southwest Florida Intl Airport', 1, 0, 'EWR', 173, 'DL');
INSERT INTO `flight`(`flight_number`, `departure_time`, `arrival_time`, `departure_airport`, 
`destination_airport`, `isDomestic`, `isInternational`, `airport_id`, `aircraft_id`, 
`airline_id`) 
VALUES ('6', '2022-01-01 10:00:00', '2022-01-01 18:45:00', 'John F. Kennedy Intl Airport', 
'Heathrow Intl Airport', 0, 1, 'EWR', 007, 'BA');

INSERT INTO `ticket`(`number`, `booking_fee`, `purchase_time`, `first_name`, `last_name`, `id_number`, 
`total_fare`, `isOne_way`, `isRound_trip`)
VALUES(44, 45.50, '2021-11-20 11:33:33', 'John', 'Doe', 4430, 753.60, 1, 0);
INSERT INTO `ticket`(`number`, `booking_fee`, `purchase_time`, `first_name`, `last_name`, `id_number`, 
`total_fare`, `isOne_way`, `isRound_trip`)
VALUES(55, 46.50, '2021-11-21 12:33:34', 'Joe', 'Smith', 4543, 754.60, 0, 1);
INSERT INTO `ticket`(`number`, `booking_fee`, `purchase_time`, `first_name`, `last_name`, `id_number`, 
`total_fare`, `isOne_way`, `isRound_trip`)
VALUES(66, 47.50, '2021-11-22 13:33:35', 'Ashley', 'Kirk', 4222, 755.60, 0, 1);
INSERT INTO `ticket`(`number`, `booking_fee`, `purchase_time`, `first_name`, `last_name`, `id_number`, 
`total_fare`, `isOne_way`, `isRound_trip`)
VALUES(77, 48.50, '2021-11-23 13:33:36', 'Anna', 'Lian', 5686, 756.60, 1, 0);

INSERT INTO `ticket_for`(`number`, `flight_number`, `class`, `destination_airport`, `seat_number`, `airline`, 
`departure_time`)
VALUES(44, 3, 'AA', 'Business', 'Los Angeles Intl Airport', 'Newark Liberty Intl Airport', 15, 
'American Airlines', '2022-01-22 14:00:00');
INSERT INTO `ticket_for`(`number`, `flight_number`, `class`, `destination_airport`, `seat_number`, `airline`, 
`departure_time`)
VALUES(55, 1, 'AC', 'Economy', 'Toronto Pearson Intl Airport', 'Newark Liberty Intl Airport', 85, 
'Air Canada', '2021-11-27 09:00:00');
INSERT INTO `ticket_for`(`number`, `flight_number`, `class`, `destination_airport`, `seat_number`, `airline`, 
`departure_time`)
VALUES(66, 2, 'EK', 'First', 'Abu Dhabi Intl Airport', 'Newark Liberty Intl Airport', 5, 
'Emirates', '2021-12-01 13:00:00');
INSERT INTO `ticket_for`(`number`, `flight_number`, `class`, `destination_airport`, `seat_number`, `airline`, 
`departure_time`)
VALUES(77, 5, 'DL', 'Economy', 'Southwest Florida Intl Airport', 'John F. Kennedy Intl Airport', 105, 
'Delta Airlines', '2022-01-01 10:00:00');


