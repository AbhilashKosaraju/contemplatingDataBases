-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.6.37-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `annualsalary`
--

DROP TABLE IF EXISTS `annualsalary`;
/*!50001 DROP VIEW IF EXISTS `annualsalary`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `annualsalary` AS SELECT 
 1 AS `TimeSheetOwner`,
 1 AS `Rating`,
 1 AS `ClientName`,
 1 AS `Organization`,
 1 AS `BaseSalaryInDollars`,
 1 AS `AnnualSalary`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `AssetID` int(11) NOT NULL,
  `BelongsTo` int(11) DEFAULT NULL,
  `AssetType` enum('VEHICLE','LAPTOP','MOBILE','VPN') DEFAULT NULL,
  `Criticality` enum('HIGH','LOW','MEDIUM') DEFAULT NULL,
  PRIMARY KEY (`AssetID`),
  KEY `fk_Assets_Employee1_idx` (`BelongsTo`),
  CONSTRAINT `fk_Assets_Employee1` FOREIGN KEY (`BelongsTo`) REFERENCES `employee` (`EmployeeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
INSERT INTO `assets` VALUES (1,1401,'VEHICLE','HIGH'),(2,1401,'LAPTOP','LOW'),(3,1402,'LAPTOP','HIGH'),(4,1402,'VEHICLE','LOW'),(5,1405,'VEHICLE','HIGH'),(6,1403,'VEHICLE','LOW'),(7,1401,'VPN','HIGH'),(8,1404,'LAPTOP','MEDIUM'),(9,1404,'VEHICLE','HIGH'),(10,1405,'LAPTOP','MEDIUM'),(11,1407,'VEHICLE','MEDIUM'),(12,1408,'VEHICLE','HIGH'),(13,1409,'VEHICLE','MEDIUM'),(14,1410,'VEHICLE','HIGH');
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `bankaccount`
--

DROP TABLE IF EXISTS `bankaccount`;
/*!50001 DROP VIEW IF EXISTS `bankaccount`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `bankaccount` AS SELECT 
 1 AS `employeeId`,
 1 AS `Firstname`,
 1 AS `lastname`,
 1 AS `BankName`,
 1 AS `BankAccountNumber`,
 1 AS `RoutingNumber`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branch` (
  `BranchName` varchar(25) NOT NULL,
  `ParentOrganization` varchar(25) NOT NULL,
  `Area` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`BranchName`,`ParentOrganization`),
  KEY `fk_Branch_Organization_idx` (`ParentOrganization`),
  CONSTRAINT `fk_Branch_Organization` FOREIGN KEY (`ParentOrganization`) REFERENCES `organization` (`OrganizationName`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES ('Albertville','Gabtype','Thompson'),('Albertville','Quire','Thompson'),('Florencia','Feednation','Ramsey'),('Florencia','Yambee','Ramsey'),('Haoxinying','Browsecat','Birchwood'),('Haoxinying','Edgewire','Birchwood'),('Hoani','Demimbu','Packers'),('Hoani','Edgewire','Packers'),('Igreja','Edgewire','Crest Line'),('Igreja','Twitterlist','Crest Line'),('Lakeland','Feednation','Bowman'),('Lakeland','Yambee','Bowman'),('Mawu','Feednation','Pierstorff'),('Mawu','Yambee','Pierstorff'),('Phichit','Feednation','Vahlen'),('Phichit','Yambee','Vahlen'),('Sever do Vouga','Realcube','Kipling'),('Stockholm','Demimbu','Hermina');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `clientinvestments`
--

DROP TABLE IF EXISTS `clientinvestments`;
/*!50001 DROP VIEW IF EXISTS `clientinvestments`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `clientinvestments` AS SELECT 
 1 AS `Organization`,
 1 AS `Clientname`,
 1 AS `ProjectId`,
 1 AS `Project`,
 1 AS `Industry`,
 1 AS `Investment`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `ClientName` varchar(25) NOT NULL,
  `ClientIndustry` varchar(45) DEFAULT NULL,
  `ClientsOrganization` varchar(25) DEFAULT NULL,
  `ClientLocation` varchar(25) NOT NULL,
  `BaseSalaryInDollars` int(11) NOT NULL,
  PRIMARY KEY (`ClientName`,`ClientLocation`),
  KEY `fk_Clients_Organization1_idx` (`ClientsOrganization`),
  CONSTRAINT `fk_Clients_Organization1` FOREIGN KEY (`ClientsOrganization`) REFERENCES `organization` (`OrganizationName`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES ('Beatty Group','Computer Software: Prepackaged Software','Yambee','Bahía Honda',1200),('Beier-Johns','Semiconductors','Yambee','Tikhoretsk',1800),('Bernier and Sons','Real Estate Investment Trusts','Feednation','Ulricehamn',1550),('Brekke Inc','Metal Fabrications','Browsecat','Is',1200),('Lemke and Monahan','Metal Fabrications','Feednation','Fuxing',1400),('Lemke, Sauer and Wunsch','Real Estate Investment Trusts','Browsecat','San Julian',1250),('Lubowitz-O\'Reilly','Biological Products ','Yambee','Concepcion',1200),('Monahan-Glover','Computer Software: Prepackaged Software','Feednation','Polzela',1700),('Olson-Nienow','EDP Services','Browsecat','Hengelo',1500),('Schowalter and Mitchell','Package Goods/Cosmetics','Demimbu','Rantaupanjangkiri',1700);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `EmployeeId` int(11) NOT NULL AUTO_INCREMENT,
  `EmpWorksAt` varchar(25) NOT NULL,
  `EmpWorksIn` varchar(25) NOT NULL,
  `EmployeeDesignation` varchar(30) DEFAULT NULL,
  `SalaryBankAccount_Number` int(11) DEFAULT NULL,
  `ManagerId` int(11) DEFAULT NULL,
  `Client` varchar(25) NOT NULL,
  PRIMARY KEY (`EmployeeId`),
  KEY `fk_Employee_Branch1_idx` (`EmpWorksAt`),
  KEY `fk_Employee_Profile1_idx` (`EmpWorksIn`),
  KEY `fk_Employee_BankSalaryAccount1_idx` (`SalaryBankAccount_Number`),
  KEY `fk_Employee_employee_idx` (`ManagerId`),
  KEY `fk_employee_client_idx` (`Client`),
  KEY `fk_employee_c_idx` (`Client`),
  CONSTRAINT `fk_Employee_BankSalaryAccount1` FOREIGN KEY (`SalaryBankAccount_Number`) REFERENCES `salaryaccountbank` (`BankAccountNumber`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_Branch1` FOREIGN KEY (`EmpWorksAt`) REFERENCES `branch` (`BranchName`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_Profile1` FOREIGN KEY (`EmpWorksIn`) REFERENCES `organization` (`OrganizationName`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_employee` FOREIGN KEY (`ManagerId`) REFERENCES `employee` (`EmployeeId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_c` FOREIGN KEY (`Client`) REFERENCES `clients` (`ClientName`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1411 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1401,'Stockholm','Demimbu','Data Coordiator',37428803,NULL,'Beatty Group'),(1402,'Albertville','Gabtype','Programmer Analyst III',32905019,1401,'Beier-Johns'),(1403,'Sever do Vouga','Realcube','Food Chemist',44966336,1401,'Bernier and Sons'),(1404,'Lakeland','Quire','Geologist I',59676200,1406,'Brekke Inc'),(1405,'Phichit','Yambee','Senior Sales Associate',17292972,1401,'Lemke and Monahan'),(1406,'Florencia','Fatz','Human Resources Manager',54799550,NULL,'Lemke, Sauer and Wunsch'),(1407,'Igreja','Twitterlist','Social Worker',29108639,1406,'Lubowitz-O\'Reilly'),(1408,'Hoani','Edgewire','Programmer Analyst II',10042700,1406,'Monahan-Glover'),(1409,'Mawu','Feednation','Senior Quality Engineer',32662526,1406,'Olson-Nienow'),(1410,'Haoxinying','Browsecat','Chemical Engineer',90857640,1401,'Schowalter and Mitchell');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_has_tasks`
--

DROP TABLE IF EXISTS `employee_has_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_has_tasks` (
  `Employee_EmployeeId` int(11) NOT NULL,
  `Tasks_TaskId` int(11) NOT NULL,
  PRIMARY KEY (`Employee_EmployeeId`,`Tasks_TaskId`),
  KEY `fk_Employee_has_Tasks_Tasks1_idx` (`Tasks_TaskId`),
  KEY `fk_Employee_has_Tasks_Employee1_idx` (`Employee_EmployeeId`),
  CONSTRAINT `fk_Employee_has_Tasks_Employee1` FOREIGN KEY (`Employee_EmployeeId`) REFERENCES `employee` (`EmployeeId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_has_Tasks_Tasks1` FOREIGN KEY (`Tasks_TaskId`) REFERENCES `tasks` (`TaskId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_has_tasks`
--

LOCK TABLES `employee_has_tasks` WRITE;
/*!40000 ALTER TABLE `employee_has_tasks` DISABLE KEYS */;
INSERT INTO `employee_has_tasks` VALUES (1401,11),(1403,11),(1401,12),(1402,12),(1403,12),(1401,13),(1403,13),(1401,14),(1403,14),(1404,14),(1401,15),(1402,15),(1405,15),(1401,16),(1402,16),(1406,16),(1402,17),(1407,17),(1402,18),(1403,18),(1408,18),(1403,19),(1409,19),(1403,20),(1410,20);
/*!40000 ALTER TABLE `employee_has_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `employeeassets`
--

DROP TABLE IF EXISTS `employeeassets`;
/*!50001 DROP VIEW IF EXISTS `employeeassets`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `employeeassets` AS SELECT 
 1 AS `employeeId`,
 1 AS `Firstname`,
 1 AS `lastname`,
 1 AS `AssetId`,
 1 AS `AssetType`,
 1 AS `Criticality`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `employeemedicalrecords`
--

DROP TABLE IF EXISTS `employeemedicalrecords`;
/*!50001 DROP VIEW IF EXISTS `employeemedicalrecords`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `employeemedicalrecords` AS SELECT 
 1 AS `employeeId`,
 1 AS `FirstName`,
 1 AS `Lastname`,
 1 AS `BloodGroup`,
 1 AS `NatureOfIllness`,
 1 AS `SickLeavesTaken`,
 1 AS `Hospitalized`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `employeemeetings`
--

DROP TABLE IF EXISTS `employeemeetings`;
/*!50001 DROP VIEW IF EXISTS `employeemeetings`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `employeemeetings` AS SELECT 
 1 AS `employeeId`,
 1 AS `FirstName`,
 1 AS `LastName`,
 1 AS `DeadLine`,
 1 AS `TaskDescription`,
 1 AS `Priority`,
 1 AS `MeetingId`,
 1 AS `MeetingType`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `employeeprojects`
--

DROP TABLE IF EXISTS `employeeprojects`;
/*!50001 DROP VIEW IF EXISTS `employeeprojects`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `employeeprojects` AS SELECT 
 1 AS `EmployeeId`,
 1 AS `Client`,
 1 AS `ProjectName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `employeeresources`
--

DROP TABLE IF EXISTS `employeeresources`;
/*!50001 DROP VIEW IF EXISTS `employeeresources`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `employeeresources` AS SELECT 
 1 AS `employeeId`,
 1 AS `Firstname`,
 1 AS `lastname`,
 1 AS `ResourceName`,
 1 AS `ResourceType`,
 1 AS `Owner`,
 1 AS `ReturnDate`,
 1 AS `ReturnStatus`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `employeeskills`
--

DROP TABLE IF EXISTS `employeeskills`;
/*!50001 DROP VIEW IF EXISTS `employeeskills`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `employeeskills` AS SELECT 
 1 AS `employeeId`,
 1 AS `Firstname`,
 1 AS `lastname`,
 1 AS `skill`,
 1 AS `SkillDescription`,
 1 AS `Experience`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `employeetasks`
--

DROP TABLE IF EXISTS `employeetasks`;
/*!50001 DROP VIEW IF EXISTS `employeetasks`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `employeetasks` AS SELECT 
 1 AS `EmployeeId`,
 1 AS `EmpWorksAt`,
 1 AS `EmployeeDesignation`,
 1 AS `ParentOrganization`,
 1 AS `TaskDescription`,
 1 AS `Priority`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `employeevehicles`
--

DROP TABLE IF EXISTS `employeevehicles`;
/*!50001 DROP VIEW IF EXISTS `employeevehicles`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `employeevehicles` AS SELECT 
 1 AS `employeeId`,
 1 AS `Firstname`,
 1 AS `lastname`,
 1 AS `VehicleType`,
 1 AS `VehicleNumber`,
 1 AS `VehicleMake`,
 1 AS `VehicleModel`,
 1 AS `VechileColor`,
 1 AS `CompanyAsset`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `irc`
--

DROP TABLE IF EXISTS `irc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `irc` (
  `IRCName` varchar(35) NOT NULL,
  `AssociatedOrganization` varchar(45) NOT NULL,
  `Location` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`IRCName`),
  KEY `fk_IRC_Organization1_idx` (`AssociatedOrganization`),
  CONSTRAINT `fk_IRC_Organization1` FOREIGN KEY (`AssociatedOrganization`) REFERENCES `organization` (`OrganizationName`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `irc`
--

LOCK TABLES `irc` WRITE;
/*!40000 ALTER TABLE `irc` DISABLE KEYS */;
INSERT INTO `irc` VALUES ('Cronin-Yost','Browsecat','Burrows'),('Littel, Little and Stamm','Realcube','Towne'),('Marks, Connelly and Bergnaum','Gabtype','Twin Pines'),('Mayert, Prohaska and Hamill','Feednation','Sheridan'),('Mitchell-Beer','Yambee','Marquette'),('Moen LLC','Browsecat','Mosinee'),('O\'Kon-Brakus','Feednation','Scofield'),('Quigley Group','Feednation','Cardinal'),('Reinger and Sons','Yambee','Montana'),('Swift, Schowalter and Mills','Fatz','Butterfield');
/*!40000 ALTER TABLE `irc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicalrecord`
--

DROP TABLE IF EXISTS `medicalrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicalrecord` (
  `MedicalRecordId` int(10) NOT NULL,
  `PatientId` int(11) NOT NULL,
  `BloodGroup` enum('A+','B+','AB+','O+','A-','B-','AB-') DEFAULT NULL,
  `NatureOfIllness` varchar(50) DEFAULT NULL,
  `SickLeavesTaken` int(11) DEFAULT NULL,
  `Hospitalized` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`MedicalRecordId`,`PatientId`),
  KEY `fk_MedicalRecord_Profile1_idx` (`PatientId`),
  CONSTRAINT `fk_MedicalRecord_Profkey` FOREIGN KEY (`PatientId`) REFERENCES `profile` (`ProfileId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicalrecord`
--

LOCK TABLES `medicalrecord` WRITE;
/*!40000 ALTER TABLE `medicalrecord` DISABLE KEYS */;
INSERT INTO `medicalrecord` VALUES (1,1401,'A+','Flu Relief Therapy Day Time',1,1),(2,1402,'B+','Fluconazole',2,0),(3,1403,'AB+','FENTANYL TRANSDERMAL SYSTEM',3,0),(4,1404,'O+','Ximino',4,1),(5,1405,'A-','Ver',5,0),(6,1406,'B-','Alcohol Prep',6,0),(7,1407,'AB-','Clean and Clear Essentials Deep Cleaning',7,1),(8,1408,'AB+','LBEL COULEUR LUXE AMPLIFIER XP',8,1),(9,1409,'O+','rifampin',9,0),(10,1410,'A-','Buxom Show Some Skin Weightless ',10,0),(11,1401,'A+','Fluconazole',2,0),(12,1401,'A+','rifampin',10,1),(13,1402,'B+','Alcohol Prep',6,0),(14,1402,'B+','Alcohol Prep',7,1),(15,1403,'AB+','Ximino',3,1),(16,1404,'O+','Buxom Show Some Skin Weightless ',4,1);
/*!40000 ALTER TABLE `medicalrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meetings`
--

DROP TABLE IF EXISTS `meetings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meetings` (
  `MeetingId` int(11) NOT NULL,
  `TaskIds` int(11) NOT NULL,
  `MeetingType` enum('STATUS','UNPLANNED','EMERGENCY') DEFAULT NULL,
  PRIMARY KEY (`MeetingId`,`TaskIds`),
  KEY `fk_Meetings_Tasks1_idx` (`TaskIds`),
  CONSTRAINT `fk_Meetings_Task` FOREIGN KEY (`TaskIds`) REFERENCES `tasks` (`TaskId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meetings`
--

LOCK TABLES `meetings` WRITE;
/*!40000 ALTER TABLE `meetings` DISABLE KEYS */;
INSERT INTO `meetings` VALUES (31,11,'UNPLANNED'),(32,12,'STATUS'),(33,13,'UNPLANNED'),(34,14,'EMERGENCY'),(35,15,'UNPLANNED'),(36,16,'STATUS'),(37,17,'EMERGENCY'),(38,18,'UNPLANNED'),(39,19,'STATUS'),(40,20,'EMERGENCY');
/*!40000 ALTER TABLE `meetings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `numberoftasks`
--

DROP TABLE IF EXISTS `numberoftasks`;
/*!50001 DROP VIEW IF EXISTS `numberoftasks`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `numberoftasks` AS SELECT 
 1 AS `EmployeeId`,
 1 AS `NumberofTasks`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization` (
  `OrganizationName` varchar(35) NOT NULL,
  `MainBranch` varchar(35) DEFAULT NULL,
  `WebsiteLink` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`OrganizationName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES ('Browsecat','Leeds','https://com.com/tortor/risus/dapibus/augue/vel/accumsan.json'),('Demimbu','Sindangrasa','https://fastcompany.com/eget.json'),('Edgewire','Eauripik','http://1688.com/nisl.json'),('Fatz','Villa Santa Rita','http://foxnews.com/consequat/nulla/nisl/nunc/nisl.js'),('Feednation','Sindang','https://patch.com/malesuada/in/imperdiet/et/commodo/vulputate.xml'),('Gabtype','Ekazhevo','http://cam.ac.uk/blandit/nam.json'),('Quire','Tujing','http://clickbank.net/donec/dapibus/duis/at/velit/eu.jpg'),('Realcube','Songgui','https://desdev.cn/placerat.js'),('Twitterlist','Uttaradit','http://arstechnica.com/interdum/in/ante/vestibulum.json'),('Yambee','Ciparay','https://uol.com.br/hac.jsp');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `organizationsirc`
--

DROP TABLE IF EXISTS `organizationsirc`;
/*!50001 DROP VIEW IF EXISTS `organizationsirc`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `organizationsirc` AS SELECT 
 1 AS `organizationName`,
 1 AS `IRCName`,
 1 AS `Location`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile` (
  `ProfileId` int(11) NOT NULL,
  `LastName` varchar(15) DEFAULT NULL,
  `FirstName` varchar(15) DEFAULT NULL,
  `EmailId` varchar(25) DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `Gender` enum('MALE','FEMALE') DEFAULT NULL,
  `SSN` varchar(20) DEFAULT NULL,
  `WorkExperience` int(11) DEFAULT NULL,
  `UserName` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`ProfileId`),
  CONSTRAINT `fk_EmployeeProfile` FOREIGN KEY (`ProfileId`) REFERENCES `employee` (`EmployeeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` VALUES (1401,'Almak','Gawen','galmak0@tamu.edu',24,'MALE','675-44-2731',1,'galmak0'),(1402,'Radband','Cynde','cradband1@arizona.edu',25,'FEMALE','497-64-6171',2,'cradband1'),(1403,'Deneve','Courtnay','cdeneve2@1und1.de',26,'MALE','845-27-3481',3,'cdeneve2'),(1404,'Amberger','Virgie','vamberger3@admin.ch',28,'FEMALE','352-79-9298',4,'vamberger3'),(1405,'Becraft','Michaella','mbecraft4@about.com',24,'FEMALE','618-60-5000',5,'mbecraft4'),(1406,'Stillmann','Kellyann','kstillmann5@boston.com',32,'FEMALE','881-07-3319',6,'kstillmann5'),(1407,'Ruppert','Vittorio','vruppert6@naver.com',33,'MALE','689-30-6788',7,'vruppert6'),(1408,'Rummins','Carmine','crummins7@instagram.com',35,'FEMALE','178-44-3102',8,'crummins7'),(1409,'Carberry','Cy','ccarberry8@i2i.jp',45,'MALE','294-66-0568',9,'ccarberry8'),(1410,'Burnham','Edee','eburnham9@goo.ne.jp',31,'FEMALE','202-78-9452',10,'eburnham9');
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `ProjectId` int(11) NOT NULL,
  `ProjectName` varchar(45) DEFAULT NULL,
  `Investment` int(11) DEFAULT NULL,
  `ProjectOwner` varchar(25) NOT NULL,
  PRIMARY KEY (`ProjectId`),
  KEY `fk_Project_Client_idx` (`ProjectOwner`),
  CONSTRAINT `fk_Project_Client` FOREIGN KEY (`ProjectOwner`) REFERENCES `clients` (`ClientName`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'Alpha',50000,'Beatty Group'),(2,'Beta',40000,'Beatty Group'),(3,'Gamma',70000,'Beatty Group'),(4,'Charlie',10000,'Beier-Johns'),(5,'Whisky',65000,'Beier-Johns'),(6,'Foxtrot',20000,'Lubowitz-O\'Reilly'),(7,'Echo',30000,'Bernier and Sons'),(8,'Delta',40000,'Brekke Inc'),(9,'Hotel',15000,'Lemke and Monahan'),(10,'Juliett',12000,'Lemke, Sauer and Wunsch'),(11,'Kilo',10000,'Olson-Nienow'),(12,'Lima',17000,'Monahan-Glover');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources`
--

DROP TABLE IF EXISTS `resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources` (
  `ResourceId` int(11) NOT NULL,
  `BelongsTo` varchar(45) NOT NULL,
  `ResourceType` enum('BOOK','RESEARCH MATERIAL','JOURNAL','EMATERIAL') DEFAULT NULL,
  `ResourceName` varchar(45) DEFAULT NULL,
  `IssueDate` date DEFAULT NULL,
  `ReturnDate` date DEFAULT NULL,
  `RecipientId` int(11) NOT NULL,
  `ReturnStatus` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ResourceId`,`BelongsTo`),
  KEY `fk_Resources_IRC1_idx` (`BelongsTo`),
  KEY `fk_resources_e_idx` (`RecipientId`),
  CONSTRAINT `fk_Resources_IRCKey` FOREIGN KEY (`BelongsTo`) REFERENCES `irc` (`IRCName`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_resources_employes` FOREIGN KEY (`RecipientId`) REFERENCES `employee` (`EmployeeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources`
--

LOCK TABLES `resources` WRITE;
/*!40000 ALTER TABLE `resources` DISABLE KEYS */;
INSERT INTO `resources` VALUES (1,'Swift, Schowalter and Mills','RESEARCH MATERIAL','National Research Corporation','2017-10-15','2016-01-01',1401,1),(2,'Marks, Connelly and Bergnaum','JOURNAL','BlackRock Income Trust Inc. (The)','2017-04-19','2017-06-28',1401,0),(3,'Mitchell-Beer','BOOK','VSE Corporation','2016-10-10','2017-01-01',1403,0),(4,'Littel, Little and Stamm','EMATERIAL','Kingstone Companies, Inc','2017-06-26','2017-12-21',1404,1),(5,'Moen LLC','EMATERIAL','Medley LLC','2016-11-11','2017-12-12',1401,0),(6,'Reinger and Sons','BOOK','Camping World Holdings, Inc.','2017-03-13','2017-12-21',1406,0),(7,'Quigley Group','RESEARCH MATERIAL','PFSweb, Inc.','2017-06-09','2017-11-02',1407,1),(8,'O\'Kon-Brakus','BOOK','Escalade, Incorporated','2017-03-28','2017-08-19',1408,1),(9,'Mayert, Prohaska and Hamill','EMATERIAL','TCG BDC, Inc.','2017-04-18','2017-05-22',1409,1),(10,'Cronin-Yost','JOURNAL','First Trust Dorsey Wright Focus 5 ETF','2017-10-18','2018-02-02',1410,0);
/*!40000 ALTER TABLE `resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salaryaccountbank`
--

DROP TABLE IF EXISTS `salaryaccountbank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salaryaccountbank` (
  `BankAccountNumber` int(11) NOT NULL,
  `Bank` varchar(15) NOT NULL,
  `RoutingNumber` int(11) DEFAULT NULL,
  `BankBalanceInMillions$` int(11) DEFAULT NULL,
  PRIMARY KEY (`BankAccountNumber`,`Bank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salaryaccountbank`
--

LOCK TABLES `salaryaccountbank` WRITE;
/*!40000 ALTER TABLE `salaryaccountbank` DISABLE KEYS */;
INSERT INTO `salaryaccountbank` VALUES (10042700,'ICICI',4558630,643),(17292972,'SBI',5767200,16940),(29108639,'Bank Of America',2353080,2),(32662526,'AXIS',3467950,1),(32905019,'Bank Of America',8173490,36333),(37428803,'Santander',8675929,20054),(44966336,'ICICI',8701310,8),(54799550,'Santander',3466700,135),(59676200,'AXIS',8236210,11720),(90857640,'SBI',2946824,20402);
/*!40000 ALTER TABLE `salaryaccountbank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills`
--

DROP TABLE IF EXISTS `skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skills` (
  `CandidateId` int(11) NOT NULL,
  `Skill` varchar(30) NOT NULL,
  `SkillDescription` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CandidateId`,`Skill`),
  KEY `fk_Skills_Profile1_idx` (`CandidateId`),
  CONSTRAINT `fk_Skills_Prof` FOREIGN KEY (`CandidateId`) REFERENCES `profile` (`ProfileId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills`
--

LOCK TABLES `skills` WRITE;
/*!40000 ALTER TABLE `skills` DISABLE KEYS */;
INSERT INTO `skills` VALUES (1401,'CSRs','MDSD'),(1401,'Cycle Counting','High Sense Of Urgency'),(1401,'EBP','WebLogic'),(1401,'Health Insurance','Grievances'),(1402,'EBP','WebLogic'),(1403,'Immunology','Usability Engineering'),(1404,'NHS Commissioning','PeopleSoft'),(1405,'CSRs','MDSD'),(1406,'Cycle Counting','High Sense Of Urgency'),(1407,'Duty Drawback','Real Estate License'),(1408,'LTSP','MCEV'),(1409,'Award Ceremonies','Biblical Studies'),(1410,'E-commerce','Air Force');
/*!40000 ALTER TABLE `skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks` (
  `TaskId` int(11) NOT NULL,
  `Priority` varchar(45) DEFAULT NULL,
  `DeadLine` date DEFAULT NULL,
  `TaskDescription` varchar(100) DEFAULT NULL,
  `Status` enum('COMPLETED','PENDING','ABORTED','ONGOING') DEFAULT NULL,
  PRIMARY KEY (`TaskId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (11,'HIGH','2017-05-19','Opiate antagonists causing adverse effects in therapeutic use','ABORTED'),(12,'LOW','2017-09-20','Unspecified agent primarily affecting skin.','COMPLETED'),(13,'MEDIUM','2017-10-20','Benign neoplasm of tonsil','COMPLETED'),(14,'HIGH','2017-11-20','Illegally induced abortion, complicated by embolism, complete','ONGOING'),(15,'LOW','2017-12-20','\"Light-for-dates\" with signs of fetal malnutrition, 1,000-1,249 grams','PENDING'),(16,'LOW','2018-01-23','Macrodactylia of toes','COMPLETED'),(17,'MEDIUM','2018-02-21','Vaginal hematoma','PENDING'),(18,'LOW','2018-03-24','Puerperal septic thrombophlebitis, unspecified as to episode of care or not applicable','ABORTED'),(19,'MEDIUM','2018-04-15','Stage I necrotizing enterocolitis in newborn','ONGOING'),(20,'HIGH','2018-05-28','Special screening for traumatic brain injury','ONGOING');
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timesheet`
--

DROP TABLE IF EXISTS `timesheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timesheet` (
  `TimeSheetOwner` int(11) NOT NULL,
  `Month` enum('JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC') NOT NULL,
  `WorkingDays` int(11) DEFAULT NULL,
  `LeavesTaken` int(11) DEFAULT NULL,
  `WorkingHoursPerDay` int(11) DEFAULT NULL,
  `Rating` int(11) DEFAULT NULL,
  PRIMARY KEY (`Month`,`TimeSheetOwner`),
  KEY `fk_TimeSheet_Employee1_idx` (`TimeSheetOwner`),
  CONSTRAINT `fk_TimeSheet_E` FOREIGN KEY (`TimeSheetOwner`) REFERENCES `employee` (`EmployeeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timesheet`
--

LOCK TABLES `timesheet` WRITE;
/*!40000 ALTER TABLE `timesheet` DISABLE KEYS */;
INSERT INTO `timesheet` VALUES (1401,'JAN',22,0,8,5),(1402,'JAN',22,1,8,4),(1401,'FEB',22,1,8,4),(1402,'FEB',22,2,8,4),(1401,'MAR',22,4,8,4),(1402,'MAR',22,3,8,4),(1403,'MAR',22,1,8,4),(1401,'APR',22,3,8,4),(1402,'APR',22,4,8,4),(1404,'APR',22,4,8,3),(1401,'MAY',22,4,8,4),(1402,'MAY',22,4,8,4),(1405,'MAY',22,4,8,4),(1401,'JUN',22,4,8,4),(1402,'JUN',22,4,8,4),(1406,'JUN',22,4,8,4),(1401,'JUL',22,4,8,4),(1402,'JUL',22,6,8,4),(1407,'JUL',22,7,8,4),(1401,'AUG',22,3,8,4),(1402,'AUG',22,3,8,4),(1408,'AUG',22,0,8,5),(1401,'SEP',22,1,8,4),(1402,'SEP',22,4,8,4),(1409,'SEP',22,5,8,4),(1401,'OCT',22,1,8,4),(1402,'OCT',22,1,8,4),(1410,'OCT',22,1,8,4),(1401,'NOV',22,0,8,5),(1402,'NOV',22,1,8,4),(1401,'DEC',22,5,8,4),(1402,'DEC',22,6,8,4);
/*!40000 ALTER TABLE `timesheet` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mydb`.`timesheet_BEFORE_INSERT` BEFORE INSERT ON `timesheet` FOR EACH ROW
BEGIN
if((new.WorkingHoursPerDay - new.LeavesTaken)*(new.workingdays) = 176) then
 set new.Rating = 5;
 
 elseif(160< (new.WorkingHoursPerDay- new.LeavesTaken)*(new.workingdays) < 176) then
 set new.Rating =4;
 
 elseif( 144 <(new.WorkingHoursPerDay- new.LeavesTaken)*(new.workingdays) < 160) then
 set new.Rating=3; 
 
 elseif( 128 <(new.WorkingHoursPerDay- new.LeavesTaken)*(new.workingdays) < 144) then
 set new.Rating=2; 
 else
 set new.Rating=1;

   end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mydb`.`timesheet_BEFORE_UPDATE` BEFORE UPDATE ON `timesheet` FOR EACH ROW
BEGIN
 if((new.WorkingHoursPerDay - new.LeavesTaken)*(new.workingdays) = 176) then
 set new.Rating = 5;
 
 elseif(160< (new.WorkingHoursPerDay- new.LeavesTaken)*(new.workingdays) < 176) then
 set new.Rating =4;
 
 elseif( 144 <(new.WorkingHoursPerDay- new.LeavesTaken)*(new.workingdays) < 160) then
 set new.Rating=3; 
 
 elseif( 128 <(new.WorkingHoursPerDay- new.LeavesTaken)*(new.workingdays) < 144) then
 set new.Rating=2; 
 else
 set new.Rating=1;

   end if;
   
   
   
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mydb`.`timesheet_AFTER_UPDATE` AFTER UPDATE ON `timesheet` FOR EACH ROW
BEGIN
  call viewRating();
  -- insert INTO EMPLOYEE(ANNUALSALARY) VALUES(RATING.ANNUALSALARY);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle` (
  `VehicleID` int(11) NOT NULL,
  `VechileOwner` int(11) NOT NULL,
  `VehicleNumber` varchar(15) DEFAULT NULL,
  `VehicleType` enum('CAR','BIKE') DEFAULT NULL,
  `VehicleMake` varchar(10) DEFAULT NULL,
  `VehicleModel` varchar(15) DEFAULT NULL,
  `VechileColor` varchar(10) DEFAULT NULL,
  `Asset` tinyint(4) NOT NULL,
  PRIMARY KEY (`VehicleID`),
  KEY `fk_Vehicle_Employee1_idx` (`VechileOwner`),
  CONSTRAINT `fk_Vehicle_Emp2` FOREIGN KEY (`VechileOwner`) REFERENCES `employee` (`EmployeeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES (1,1401,'10-857-8826','CAR','Ford','Grand Caravan','Green',1),(2,1402,'19-974-2600','BIKE','Cadillac','Ram 1500','Orange',0),(3,1403,'34-256-3982','BIKE','Mazda','E350','Green',0),(4,1404,'99-052-4524','CAR','Bentley','R8','Pink',1),(5,1405,'05-656-8046','BIKE','Toyota','SVX','Puce',1),(6,1406,'72-238-4202','CAR','Acura','Jetta','Aquamarine',0),(7,1407,'28-849-4567','CAR','Infiniti','Prizm','Red',1),(8,1408,'79-240-3290','BIKE','Chrysler','Reatta','Teal',1),(9,1409,'55-286-9252','CAR','BMW','R-Class','Red',1),(10,1410,'80-560-5026','BIKE','Buick','Panamera','Pink',0);
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'mydb'
--

--
-- Dumping routines for database 'mydb'
--
/*!50003 DROP FUNCTION IF EXISTS `SalaryDeposit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `SalaryDeposit`(id int) RETURNS int(11)
BEGIN
DECLARE deposit int;

case 
when (select numberoftasks from numberoftasks where employeeId=id ) =10
then set deposit  = ((select annualsalary.AnnualSalary  from annualsalary where annualsalary.TimeSheetOwner=id)*5); 

when (select numberoftasks.numberoftasks from numberoftasks where employeeId=id ) >=5 AND (select  numberoftasks.numberoftasks.numberoftasks from numberoftasks where employeeId=id) <10
then set deposit  =((select annualsalary.AnnualSalary  from annualsalary where annualsalary.TimeSheetOwner=id)*4); 

else set deposit  =((select annualsalary.AnnualSalary  from annualsalary where annualsalary.TimeSheetOwner=id)*3);  

end case;


  return deposit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BankSalaryDeposit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `BankSalaryDeposit`(IN id int)
BEGIN
update salaryaccountbank set BankBalanceInMillions$ = BankBalanceInMillions$ + SalaryDeposit (id ) where 
  BankAccountNumber=(select SalaryBankAccount_Number from employee where EmployeeId =id);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ClientInvestments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ClientInvestments`()
BEGIN

select IFNULL(Organization, 'Org') AS Organization,
IFNULL(Clientname, 'Total') As Client, sum(investment) As TotalInvestment
from clientinvestments
Group by  ClientName with rollup;

   END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EmployeeAssets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EmployeeAssets`(IN id int)
BEGIN
select  employeeId,Firstname,lastname,AssetId,AssetType,Criticality
from employee 
inner join profile
on employee.EmployeeId = profile.ProfileId
inner join assets
on employee.employeeId = assets.BelongsTo
where BelongsTo = id
order by EmployeeId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EmployeeManager` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EmployeeManager`(IN id int)
BEGIN
select * from employee 
inner join 
profile
on employee.EmployeeId = ProfileId
where EmployeeId in (SELECT ManagerId 
FROM employee 
where EmployeeId= id);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `employeeMyBankBalance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `employeeMyBankBalance`(IN id int)
BEGIN
select employeeId,FirstName,lastname,b.BankAccountNumber as AccountNumber,Bank,BankBalanceInMillions$ as mybalance
from bankaccount b
inner join
salaryaccountbank
on b.BankAccountNumber = salaryaccountbank.BankAccountNumber
where employeeId =id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EmployeeparticipatingProjects` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EmployeeparticipatingProjects`(IN id int)
BEGIN
select * from EmployeeProjects
where employeeId =1401;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `employeeResources` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `employeeResources`(IN id int)
BEGIN
select  employeeId,Firstname,lastname,ResourceName,ResourceType,BelongsTo As Owner,ReturnDate,ReturnStatus
from employee 
inner join profile
on employee.EmployeeId = profile.ProfileId
inner join resources
on employee.employeeId = resources.recipientId
where RecipientId = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `employeeSkill` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `employeeSkill`(IN id int)
BEGIN
select  *
from employeeskills
where 
employeeId=id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EmployeesUnderManager` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EmployeesUnderManager`(IN id int)
BEGIN
SELECT * 
FROM employee inner join 
profile 
on employee.EmployeeId = profile.ProfileId
where ManagerId = 1401;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EmployeeVehicles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EmployeeVehicles`(IN id int)
BEGIN
select   employeeId,Firstname,lastname,VehicleType,VehicleNumber,VehicleMake,VehicleModel,VechileColor, Asset as CompanyAsset
from employee 
inner join profile
on employee.EmployeeId = profile.ProfileId
inner join vehicle
on employee.employeeId = vehicle.VechileOwner
where VechileOwner = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Grading` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Grading`(IN id int, OUT Rating varchar(5))
BEGIN
case 
when (select numberoftasks.numberofTasks from numberoftasks where employeeId=id ) =10
then set rating ='A';
when (select numberoftasks.numberofTasks from numberoftasks where employeeId=id ) >=5 AND (select numberoftasks.numberofTasks from numberoftasks where employeeId=id) <10
then set rating ='B';
else set rating ='C';
end case;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `HospitalizedEmployeeMedicalRecords` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `HospitalizedEmployeeMedicalRecords`(IN id int)
BEGIN
select *
from EmployeeMedicalRecords
where Hospitalized = 1
AND employeeId=id
order by EmployeeId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `IndustryAssets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `IndustryAssets`()
BEGIN

select IFNULL(Organization, 'Org') AS Organization,
IFNULL(Industry,'Total') As ClientIndustry,
sum(investment) As TotalInvestment
from clientinvestments
Group by  Industry,Organization with rollup;

   END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Managers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Managers`()
BEGIN
SELECT * 
FROM employee inner join 
profile 
on employee.EmployeeId = profile.ProfileId
where ManagerId IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MeetingParticipants` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MeetingParticipants`(IN id int)
BEGIN
select employeeId,FirstName,Lastname,Priority as TaskPriority,MeetingType,DeadLine as TaskDeadline
from employeemeetings
where meetingId =id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MyIncrement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MyIncrement`(IN id int, OUT SalaryWithIncrement int)
BEGIN
case 
when (select numberoftasks from numberoftasks where employeeId=id ) =10
then set SalaryWithIncrement = ((select annualsalary.AnnualSalary  from annualsalary where annualsalary.TimeSheetOwner=id)*5);                   

when (select numberoftasks.numberoftasks from numberoftasks where employeeId=id ) >=5 AND (select  numberoftasks.numberoftasks.numberoftasks from numberoftasks where employeeId=id) <10
then set SalaryWithIncrement =((select annualsalary.AnnualSalary  from annualsalary where annualsalary.TimeSheetOwner=id)*4); 

else set SalaryWithIncrement =((select annualsalary.AnnualSalary  from annualsalary where annualsalary.TimeSheetOwner=id)*3);  

end case;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Mytasks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Mytasks`(IN id int)
BEGIN
select * from employeeTasks
where 
employeeid =id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `OnlyEmployees` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OnlyEmployees`()
BEGIN
SELECT * 
FROM employee inner join 
profile 
on employee.EmployeeId = profile.ProfileId
where ManagerId IS NOT NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `viewRating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `viewRating`()
BEGIN
   SELECT TimesheetOwner as EmployeeId,rating,clientname,Organization FROM annualsalary
   group by organization,clientname
   order by rating desc;
   
   END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `annualsalary`
--

/*!50001 DROP VIEW IF EXISTS `annualsalary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `annualsalary` AS select `timesheet`.`TimeSheetOwner` AS `TimeSheetOwner`,avg(`timesheet`.`Rating`) AS `Rating`,`clients`.`ClientName` AS `ClientName`,`clients`.`ClientsOrganization` AS `Organization`,`clients`.`BaseSalaryInDollars` AS `BaseSalaryInDollars`,(avg(`timesheet`.`Rating`) * `clients`.`BaseSalaryInDollars`) AS `AnnualSalary` from ((`timesheet` join `employee` on((`timesheet`.`TimeSheetOwner` = `employee`.`EmployeeId`))) join `clients` on((`clients`.`ClientName` = `employee`.`Client`))) group by `timesheet`.`TimeSheetOwner` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `bankaccount`
--

/*!50001 DROP VIEW IF EXISTS `bankaccount`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `bankaccount` AS select `employee`.`EmployeeId` AS `employeeId`,`profile`.`FirstName` AS `Firstname`,`profile`.`LastName` AS `lastname`,`salaryaccountbank`.`Bank` AS `BankName`,`salaryaccountbank`.`BankAccountNumber` AS `BankAccountNumber`,`salaryaccountbank`.`RoutingNumber` AS `RoutingNumber` from ((`employee` join `profile` on((`employee`.`EmployeeId` = `profile`.`ProfileId`))) join `salaryaccountbank` on((`employee`.`SalaryBankAccount_Number` = `salaryaccountbank`.`BankAccountNumber`))) order by `employee`.`EmployeeId` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `clientinvestments`
--

/*!50001 DROP VIEW IF EXISTS `clientinvestments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `clientinvestments` AS select `organization`.`OrganizationName` AS `Organization`,`projects`.`ProjectOwner` AS `Clientname`,`projects`.`ProjectId` AS `ProjectId`,`projects`.`ProjectName` AS `Project`,`clients`.`ClientIndustry` AS `Industry`,`projects`.`Investment` AS `Investment` from ((`clients` join `projects` on((`projects`.`ProjectOwner` = `clients`.`ClientName`))) join `organization` on((`clients`.`ClientsOrganization` = `organization`.`OrganizationName`))) order by `organization`.`OrganizationName` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `employeeassets`
--

/*!50001 DROP VIEW IF EXISTS `employeeassets`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `employeeassets` AS select `employee`.`EmployeeId` AS `employeeId`,`profile`.`FirstName` AS `Firstname`,`profile`.`LastName` AS `lastname`,`assets`.`AssetID` AS `AssetId`,`assets`.`AssetType` AS `AssetType`,`assets`.`Criticality` AS `Criticality` from ((`employee` join `profile` on((`employee`.`EmployeeId` = `profile`.`ProfileId`))) join `assets` on((`employee`.`EmployeeId` = `assets`.`BelongsTo`))) order by `employee`.`EmployeeId` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `employeemedicalrecords`
--

/*!50001 DROP VIEW IF EXISTS `employeemedicalrecords`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `employeemedicalrecords` AS select `employee`.`EmployeeId` AS `employeeId`,`profile`.`FirstName` AS `FirstName`,`profile`.`LastName` AS `Lastname`,`medicalrecord`.`BloodGroup` AS `BloodGroup`,`medicalrecord`.`NatureOfIllness` AS `NatureOfIllness`,`medicalrecord`.`SickLeavesTaken` AS `SickLeavesTaken`,`medicalrecord`.`Hospitalized` AS `Hospitalized` from ((`employee` join `profile` on((`employee`.`EmployeeId` = `profile`.`ProfileId`))) join `medicalrecord` on((`employee`.`EmployeeId` = `medicalrecord`.`PatientId`))) order by `employee`.`EmployeeId` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `employeemeetings`
--

/*!50001 DROP VIEW IF EXISTS `employeemeetings`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `employeemeetings` AS select `employee`.`EmployeeId` AS `employeeId`,`profile`.`FirstName` AS `FirstName`,`profile`.`LastName` AS `LastName`,`tasks`.`DeadLine` AS `DeadLine`,`tasks`.`TaskDescription` AS `TaskDescription`,`tasks`.`Priority` AS `Priority`,`meetings`.`MeetingId` AS `MeetingId`,`meetings`.`MeetingType` AS `MeetingType` from ((((`profile` join `employee` on((`profile`.`ProfileId` = `employee`.`EmployeeId`))) join `employee_has_tasks` on((`employee`.`EmployeeId` = `employee_has_tasks`.`Employee_EmployeeId`))) join `tasks` on((`employee_has_tasks`.`Tasks_TaskId` = `tasks`.`TaskId`))) join `meetings` on((`tasks`.`TaskId` = `meetings`.`TaskIds`))) order by `employee`.`EmployeeId` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `employeeprojects`
--

/*!50001 DROP VIEW IF EXISTS `employeeprojects`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `employeeprojects` AS select `employee`.`EmployeeId` AS `EmployeeId`,`employee`.`Client` AS `Client`,`projects`.`ProjectName` AS `ProjectName` from ((`employee` join `clients` on((`employee`.`Client` = `clients`.`ClientName`))) join `projects` on((`clients`.`ClientName` = `projects`.`ProjectOwner`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `employeeresources`
--

/*!50001 DROP VIEW IF EXISTS `employeeresources`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `employeeresources` AS select `employee`.`EmployeeId` AS `employeeId`,`profile`.`FirstName` AS `Firstname`,`profile`.`LastName` AS `lastname`,`resources`.`ResourceName` AS `ResourceName`,`resources`.`ResourceType` AS `ResourceType`,`resources`.`BelongsTo` AS `Owner`,`resources`.`ReturnDate` AS `ReturnDate`,`resources`.`ReturnStatus` AS `ReturnStatus` from ((`employee` join `profile` on((`employee`.`EmployeeId` = `profile`.`ProfileId`))) join `resources` on((`employee`.`EmployeeId` = `resources`.`RecipientId`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `employeeskills`
--

/*!50001 DROP VIEW IF EXISTS `employeeskills`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `employeeskills` AS select `employee`.`EmployeeId` AS `employeeId`,`profile`.`FirstName` AS `Firstname`,`profile`.`LastName` AS `lastname`,`skills`.`Skill` AS `skill`,`skills`.`SkillDescription` AS `SkillDescription`,`profile`.`WorkExperience` AS `Experience` from ((`employee` join `profile` on((`employee`.`EmployeeId` = `profile`.`ProfileId`))) join `skills` on((`employee`.`EmployeeId` = `skills`.`CandidateId`))) order by `employee`.`EmployeeId` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `employeetasks`
--

/*!50001 DROP VIEW IF EXISTS `employeetasks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `employeetasks` AS select `employee`.`EmployeeId` AS `EmployeeId`,`employee`.`EmpWorksAt` AS `EmpWorksAt`,`employee`.`EmployeeDesignation` AS `EmployeeDesignation`,`branch`.`ParentOrganization` AS `ParentOrganization`,`tasks`.`TaskDescription` AS `TaskDescription`,`tasks`.`Priority` AS `Priority` from ((((`employee` join `branch` on((`employee`.`EmpWorksAt` = `branch`.`BranchName`))) join `organization` `o` on((`branch`.`ParentOrganization` = `o`.`OrganizationName`))) join `employee_has_tasks` on((`employee`.`EmployeeId` = `employee_has_tasks`.`Employee_EmployeeId`))) join `tasks` on((`employee_has_tasks`.`Tasks_TaskId` = `tasks`.`TaskId`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `employeevehicles`
--

/*!50001 DROP VIEW IF EXISTS `employeevehicles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `employeevehicles` AS select `employee`.`EmployeeId` AS `employeeId`,`profile`.`FirstName` AS `Firstname`,`profile`.`LastName` AS `lastname`,`vehicle`.`VehicleType` AS `VehicleType`,`vehicle`.`VehicleNumber` AS `VehicleNumber`,`vehicle`.`VehicleMake` AS `VehicleMake`,`vehicle`.`VehicleModel` AS `VehicleModel`,`vehicle`.`VechileColor` AS `VechileColor`,`vehicle`.`Asset` AS `CompanyAsset` from ((`employee` join `profile` on((`employee`.`EmployeeId` = `profile`.`ProfileId`))) join `vehicle` on((`employee`.`EmployeeId` = `vehicle`.`VechileOwner`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `numberoftasks`
--

/*!50001 DROP VIEW IF EXISTS `numberoftasks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `numberoftasks` AS select `employeetasks`.`EmployeeId` AS `EmployeeId`,count(0) AS `NumberofTasks` from `employeetasks` group by `employeetasks`.`EmployeeId` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `organizationsirc`
--

/*!50001 DROP VIEW IF EXISTS `organizationsirc`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `organizationsirc` AS select `organization`.`OrganizationName` AS `organizationName`,`irc`.`IRCName` AS `IRCName`,`irc`.`Location` AS `Location` from (`organization` join `irc` on((`organization`.`OrganizationName` = `irc`.`AssociatedOrganization`))) order by `organization`.`OrganizationName` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-14  6:59:45
