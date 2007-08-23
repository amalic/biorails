-- MySQL dump 10.11
--
-- Host: localhost    Database: biorails2_development
-- ------------------------------------------------------
-- Server version	5.0.38-Ubuntu_0ubuntu1-log

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
-- Table structure for table `analysis_methods`
--

DROP TABLE IF EXISTS `analysis_methods`;
CREATE TABLE `analysis_methods` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `class_name` varchar(255) NOT NULL,
  `protocol_version_id` int(11) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `analysis_methods`
--

LOCK TABLES `analysis_methods` WRITE;
/*!40000 ALTER TABLE `analysis_methods` DISABLE KEYS */;
/*!40000 ALTER TABLE `analysis_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analysis_settings`
--

DROP TABLE IF EXISTS `analysis_settings`;
CREATE TABLE `analysis_settings` (
  `id` int(11) NOT NULL auto_increment,
  `analysis_method_id` int(11) default NULL,
  `name` varchar(62) default NULL,
  `script_body` text,
  `options` text,
  `parameter_id` int(11) default NULL,
  `data_type_id` int(11) default NULL,
  `level_no` int(11) default NULL,
  `column_no` int(11) default NULL,
  `mode` int(11) default NULL,
  `mandatory` varchar(255) default 'N',
  `default_value` varchar(255) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `analysis_settings`
--

LOCK TABLES `analysis_settings` WRITE;
/*!40000 ALTER TABLE `analysis_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `analysis_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audits`
--

DROP TABLE IF EXISTS `audits`;
CREATE TABLE `audits` (
  `id` int(11) NOT NULL auto_increment,
  `auditable_id` int(11) default NULL,
  `auditable_type` varchar(255) default NULL,
  `user_id` int(11) default NULL,
  `user_type` varchar(255) default NULL,
  `session` varchar(255) default NULL,
  `action` varchar(255) default NULL,
  `changes` text,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `auditable_index` (`auditable_id`,`auditable_type`),
  KEY `user_index` (`user_id`,`user_type`),
  KEY `audits_created_at_index` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `audits`
--

LOCK TABLES `audits` WRITE;
/*!40000 ALTER TABLE `audits` DISABLE KEYS */;
INSERT INTO `audits` VALUES (1,1,'ProjectElement',3,NULL,NULL,'create','--- \nname: \n- \"\"\n- Demo\nproject_id: \n- \n- 13\nupdated_at: \n- \n- &id001 2007-07-02 14:48:29.709854 Z\ntype: \n- ProjectElement\n- ProjectFolder\nupdated_by_user_id: \n- 1\n- 3\nid: \n- \n- 1\ncreated_by_user_id: \n- 1\n- 3\ncreated_at: \n- \n- *id001\n','2007-07-02 14:48:29');
/*!40000 ALTER TABLE `audits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authentication_systems`
--

DROP TABLE IF EXISTS `authentication_systems`;
CREATE TABLE `authentication_systems` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL default '',
  `description` text,
  `type` varchar(255) NOT NULL default 'DataConcept',
  `host` varchar(60) default NULL,
  `port` int(11) default NULL,
  `account` varchar(60) default NULL,
  `account_password` varchar(60) default NULL,
  `base_dn` varchar(255) default NULL,
  `attr_login` varchar(30) default NULL,
  `attr_firstname` varchar(30) default NULL,
  `attr_lastname` varchar(30) default NULL,
  `attr_mail` varchar(30) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `authentication_systems`
--

LOCK TABLES `authentication_systems` WRITE;
/*!40000 ALTER TABLE `authentication_systems` DISABLE KEYS */;
/*!40000 ALTER TABLE `authentication_systems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batches`
--

DROP TABLE IF EXISTS `batches`;
CREATE TABLE `batches` (
  `id` int(11) NOT NULL auto_increment,
  `compound_id` int(11) NOT NULL default '0',
  `name` varchar(255) default NULL,
  `description` text,
  `external_ref` varchar(255) default NULL,
  `quantity_unit` varchar(255) default NULL,
  `quantity_value` float default NULL,
  `url` varchar(255) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `batches_compound_fk` (`compound_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `batches`
--

LOCK TABLES `batches` WRITE;
/*!40000 ALTER TABLE `batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_logs`
--

DROP TABLE IF EXISTS `catalog_logs`;
CREATE TABLE `catalog_logs` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `auditable_id` int(11) default NULL,
  `auditable_type` varchar(255) default NULL,
  `action` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `comment` varchar(255) default NULL,
  `created_by` varchar(255) default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `catalog_logs_user_id_index` (`user_id`),
  KEY `catalog_logs_auditable_type_index` (`auditable_type`,`auditable_id`),
  KEY `catalog_logs_created_at_index` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `catalog_logs`
--

LOCK TABLES `catalog_logs` WRITE;
/*!40000 ALTER TABLE `catalog_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `compound_results`
--

DROP TABLE IF EXISTS `compound_results`;
/*!50001 DROP VIEW IF EXISTS `compound_results`*/;
/*!50001 CREATE TABLE `compound_results` (
  `id` int(11),
  `row_no` int(11),
  `column_no` int(11),
  `task_id` int(11),
  `parameter_context_id` int(11),
  `task_context_id` int(11),
  `data_element_id` int(11),
  `compound_parameter_id` int(11),
  `compound_id` int(11),
  `compound_name` varchar(255),
  `protocol_version_id` int(11),
  `label` varchar(255),
  `row_label` varchar(255),
  `parameter_id` int(11),
  `parameter_name` varchar(62),
  `data_value` double,
  `created_by_user_id` int(11),
  `created_at` datetime,
  `updated_by_user_id` int(11),
  `updated_at` datetime
) */;

--
-- Table structure for table `compounds`
--

DROP TABLE IF EXISTS `compounds`;
CREATE TABLE `compounds` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL default '',
  `description` text,
  `formula` varchar(50) default NULL,
  `mass` float default NULL,
  `smiles` varchar(255) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `registration_date` datetime default NULL,
  `iupacname` varchar(255) default '',
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `compounds`
--

LOCK TABLES `compounds` WRITE;
/*!40000 ALTER TABLE `compounds` DISABLE KEYS */;
/*!40000 ALTER TABLE `compounds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `container_items`
--

DROP TABLE IF EXISTS `container_items`;
CREATE TABLE `container_items` (
  `id` int(11) NOT NULL auto_increment,
  `container_group_id` int(11) NOT NULL,
  `subject_type` varchar(255) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `slot_no` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `container_items`
--

LOCK TABLES `container_items` WRITE;
/*!40000 ALTER TABLE `container_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `container_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `containers`
--

DROP TABLE IF EXISTS `containers`;
CREATE TABLE `containers` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `plate_format_id` int(11) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `containers`
--

LOCK TABLES `containers` WRITE;
/*!40000 ALTER TABLE `containers` DISABLE KEYS */;
/*!40000 ALTER TABLE `containers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_concepts`
--

DROP TABLE IF EXISTS `data_concepts`;
CREATE TABLE `data_concepts` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) default NULL,
  `name` varchar(50) NOT NULL default '',
  `data_context_id` int(11) NOT NULL default '0',
  `description` text,
  `access_control_id` int(11) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL default '0000-00-00 00:00:00',
  `type` varchar(255) NOT NULL default 'DataConcept',
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `data_concepts_idx2` (`updated_at`),
  KEY `data_concepts_idx4` (`created_at`),
  KEY `data_concepts_name_idx` (`name`),
  KEY `data_concepts_acl_idx` (`access_control_id`),
  KEY `data_concepts_fk1` (`data_context_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_concepts`
--

LOCK TABLES `data_concepts` WRITE;
/*!40000 ALTER TABLE `data_concepts` DISABLE KEYS */;
INSERT INTO `data_concepts` VALUES (1,NULL,'BioRails',1,'This is the main <strong>context </strong>or<strong> conceptual name space </strong>for all key <strong>concepts </strong>in the core BioRails application. The context is divided into a logical tree of concepts.&nbsp; These concepts can be extended with child concepts providing&nbsp; the possibility of <strong>value lookup lists</strong> defined against each concept. In-use concepts<strong> </strong>are linked to <strong>parameter types </strong>at the global catalogue level. Parameter types are then implemented as <strong>study parameters</strong> and a linked lookup <strong>element </strong>may be used.<br />\r\n<br />\r\nThis structure provides a solid division of control between global warehousing need and local terminology, put more simply, the scientists can maintain their own (often unique) terminologies which can be mapped into the corporate dictionaries.',NULL,3,'2007-01-22 15:23:29','2007-01-23 20:54:17','DataContext',1,1),(2,1,'Subject',1,'Subject',NULL,1,'2006-09-06 19:33:33','2006-09-06 19:33:33','DataConcept',1,1),(3,1,'Catalogue',1,'Short lookup dictionaries and other internal used combo in study,protocol, and experiment forms.',NULL,2,'2006-09-06 19:35:22','2007-06-07 09:46:08','DataConcept',3,1),(4,1,'Organization',1,'Oganizational Structure (Projects, studies etc)',NULL,5,'2006-09-06 19:35:33','2006-10-09 16:01:50','DataConcept',1,1),(6,2,'Compounds',1,'Compounds',NULL,1,'2006-09-06 19:35:50','2006-09-06 19:35:51','DataConcept',1,1),(7,2,'Batches',1,'Batch',NULL,2,'2006-09-06 19:36:00','2007-01-19 15:37:11','DataConcept',1,1),(8,2,'Plate',1,'Plate',NULL,1,'2006-09-06 19:36:07','2006-09-06 19:36:07','DataConcept',1,1),(9,2,'Treatment',1,'Treatment Groups',NULL,1,'2006-09-06 19:36:13','2006-09-06 19:36:13','DataConcept',1,1),(10,2,'Specimens',1,'Specimens',NULL,1,'2006-09-06 19:36:24','2006-09-06 19:36:24','DataConcept',1,1),(11,2,'Lists',1,'List, Libraries',NULL,2,'2006-09-06 19:36:32','2006-09-06 19:39:47','DataConcept',1,1),(24,4,'Experiment',1,'Experiment main element in the execution of a workflow',NULL,1,'2006-11-22 12:49:19','2006-12-05 18:15:43','DataConcept',1,1),(25,4,'Protocol',1,'Protocol',NULL,0,'2006-11-22 12:52:00','2006-11-22 12:52:00','DataConcept',1,1),(26,3,'Unit',1,'Unit',NULL,0,'2006-11-22 12:52:30','2006-11-22 12:52:30','DataConcept',1,1),(27,4,'Task',1,'Task',NULL,0,'2006-11-22 12:53:17','2006-11-22 12:53:17','DataConcept',1,1),(28,3,'DataType',1,'Various type of data the system is expected to handle like numeric ,text',NULL,3,'2006-11-22 12:53:47','2007-01-22 23:32:32','DataConcept',1,1),(29,3,'DataFormat',1,'Data Formats are skill',NULL,1,'2006-11-22 12:56:05','2007-01-12 13:58:05','DataConcept',1,1),(30,3,'ParameterType',1,'ParameterType',NULL,0,'2006-11-22 12:56:57','2006-11-22 12:56:57','DataConcept',1,1),(31,3,'ParameterRole',1,'Parameter Role',NULL,0,'2006-11-22 12:57:18','2006-11-22 12:57:18','DataConcept',1,1),(33,3,'Groups',1,'Groups',NULL,0,'2006-12-12 13:53:02','2006-12-12 13:53:02','DataConcept',1,1),(39,3,'Roles',1,'Lookup',NULL,0,'2007-01-19 16:04:03','2007-01-19 16:04:03','DataConcept',1,1),(47,2,'Species',1,'Mammals licensed by company for pre-clinical safety studies',NULL,3,'2007-01-31 13:51:33','2007-03-20 15:57:04','DataConcept',1,1),(48,3,'Users',1,'Allowed Username for people in the system',NULL,1,'2007-02-28 17:55:48','2007-02-28 17:55:48','DataConcept',1,1),(49,4,'Project',1,'Projects',NULL,1,'2007-03-20 15:53:10','2007-03-20 15:53:10','DataConcept',1,1),(50,2,'Target',1,'A biological target are the subject of drug discovery campaigns and typically include newly discovered proteins.',NULL,1,'2007-04-03 16:44:25','2007-04-03 16:44:25','DataConcept',1,1),(51,4,'Folder',0,'Folders',NULL,1,'2007-04-30 15:12:38','2007-04-30 15:12:38','DataConcept',2,2),(52,3,'ProtocolCatagory',0,'Protocol Catagory. This is a internal lookup used on the protocol definition forms',NULL,2,'2007-06-06 20:36:51','2007-06-06 22:00:05','DataConcept',3,3),(53,3,'ProtocolStatus',0,'Protocol Status: Internal lookup for the status of a protocol. ',NULL,2,'2007-06-06 20:37:19','2007-06-06 22:00:47','DataConcept',3,3),(54,3,'ResearchArea',0,'Research Area: This is a internal lookup for study form to a list of reasearch area used in the organization',NULL,2,'2007-06-06 20:37:46','2007-06-06 22:01:45','DataConcept',3,3),(55,4,'PickLists',0,'Short picklists',NULL,1,'2007-06-13 11:57:22','2007-06-13 11:57:22','DataConcept',4,4),(56,3,'Route',0,'Route',NULL,1,'2007-06-13 12:30:12','2007-06-13 12:30:12','DataConcept',3,3),(57,1,'xxx',0,'xxx',NULL,1,'2007-06-13 14:47:53','2007-06-13 14:47:53','DataConcept',3,3),(58,3,'Scores',0,'Scoring',NULL,1,'2007-06-13 14:47:56','2007-06-13 14:47:56','DataConcept',4,4);
/*!40000 ALTER TABLE `data_concepts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_contexts`
--

DROP TABLE IF EXISTS `data_contexts`;
CREATE TABLE `data_contexts` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL default '',
  `description` text,
  `access_control_id` int(11) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `data_contexts_idx2` (`updated_at`),
  KEY `data_contexts_idx4` (`created_at`),
  KEY `data_contexts_name_idx` (`name`),
  KEY `data_contexts_acl_idx` (`access_control_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_contexts`
--

LOCK TABLES `data_contexts` WRITE;
/*!40000 ALTER TABLE `data_contexts` DISABLE KEYS */;
INSERT INTO `data_contexts` VALUES (1,'BioRails','Main BIo Rails Context for application development namespace. This includes all the standard models and relationships in the default application setup',NULL,1,'2006-09-06 19:28:02','2006-12-05 18:10:03',1,1),(2,'LegacyHTS','This is a example <em>namespace</em> for a custom integration of BioRails into a legacy inventory system.',NULL,2,'2006-12-05 18:13:35','2007-01-03 19:55:49',1,1);
/*!40000 ALTER TABLE `data_contexts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_elements`
--

DROP TABLE IF EXISTS `data_elements`;
CREATE TABLE `data_elements` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL default '',
  `description` text,
  `data_system_id` int(11) NOT NULL,
  `data_concept_id` int(11) NOT NULL,
  `access_control_id` int(11) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `parent_id` int(10) unsigned default NULL,
  `style` varchar(10) NOT NULL,
  `content` text NOT NULL,
  `estimated_count` int(11) default NULL,
  `type` varchar(255) default NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `data_elements_idx2` (`updated_at`),
  KEY `data_elements_idx4` (`created_at`),
  KEY `data_elements_name_idx` (`name`),
  KEY `data_elements_acl_idx` (`access_control_id`),
  KEY `data_element_fk2` (`data_concept_id`),
  KEY `data_element_fk1` (`data_system_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_elements`
--

LOCK TABLES `data_elements` WRITE;
/*!40000 ALTER TABLE `data_elements` DISABLE KEYS */;
INSERT INTO `data_elements` VALUES (1,'DataFormat','Data Format List for the system',1,29,NULL,1,'2007-06-06 14:31:27','2007-06-06 14:31:27',NULL,'model','DataFormat',NULL,'ModelElement',3,3),(2,'DataType','Data Type implemented in the biorails site',1,28,NULL,1,'2007-06-06 14:37:38','2007-06-06 14:37:38',NULL,'model','DataType',NULL,'ModelElement',3,3),(3,'Groups','User Groups registered on the current system',1,33,NULL,1,'2007-06-06 14:38:15','2007-06-06 14:38:15',NULL,'model','Group',NULL,'ModelElement',3,3),(4,'ParameterRole','Parameter Roles lookup to allow separation of data into a number of bin for fruther use.',1,31,NULL,1,'2007-06-06 14:41:08','2007-06-06 14:41:09',NULL,'model','ParameterRole',NULL,'ModelElement',3,3),(5,'ParameterType','Parameter Types , A little recursive as parameter types are defined with data elements',1,30,NULL,1,'2007-06-06 14:42:41','2007-06-06 14:42:41',NULL,'model','ParameterType',NULL,'ModelElement',3,3),(6,'Roles','Roles a user can take in the system',1,39,NULL,1,'2007-06-06 14:43:10','2007-06-06 14:43:10',NULL,'model','Role',NULL,'ModelElement',3,3),(7,'Molar','Molar Units',1,26,NULL,1,'2007-06-06 14:45:45','2007-06-06 14:45:45',NULL,'list','M,mM,uM,pM,nM',5,'ListElement',3,3),(8,'M','M',1,26,NULL,1,'2007-06-06 14:45:45','2007-06-06 14:45:45',7,'child','',NULL,NULL,3,3),(9,'mM','mM',1,26,NULL,1,'2007-06-06 14:45:45','2007-06-06 14:45:45',7,'child','',NULL,NULL,3,3),(10,'uM','uM',1,26,NULL,1,'2007-06-06 14:45:45','2007-06-06 14:45:45',7,'child','',NULL,NULL,3,3),(11,'pM','pM',1,26,NULL,1,'2007-06-06 14:45:45','2007-06-06 14:45:45',7,'child','',NULL,NULL,3,3),(12,'nM','nM',1,26,NULL,1,'2007-06-06 14:45:45','2007-06-06 14:45:45',7,'child','',NULL,NULL,3,3),(13,'Length','Length Units',1,26,NULL,1,'2007-06-06 14:46:42','2007-06-06 14:46:42',NULL,'list','m,km,cm,mm,um,nm,pm',7,'ListElement',3,3),(14,'m','m',1,26,NULL,1,'2007-06-06 14:46:42','2007-06-06 14:46:42',13,'child','',NULL,NULL,3,3),(15,'km','km',1,26,NULL,1,'2007-06-06 14:46:42','2007-06-06 14:46:42',13,'child','',NULL,NULL,3,3),(16,'cm','cm',1,26,NULL,1,'2007-06-06 14:46:42','2007-06-06 14:46:42',13,'child','',NULL,NULL,3,3),(17,'mm','mm',1,26,NULL,1,'2007-06-06 14:46:42','2007-06-06 14:46:42',13,'child','',NULL,NULL,3,3),(18,'um','um',1,26,NULL,1,'2007-06-06 14:46:42','2007-06-06 14:46:42',13,'child','',NULL,NULL,3,3),(19,'nm','nm',1,26,NULL,1,'2007-06-06 14:46:42','2007-06-06 14:46:42',13,'child','',NULL,NULL,3,3),(20,'pm','pm',1,26,NULL,1,'2007-06-06 14:46:42','2007-06-06 14:46:42',13,'child','',NULL,NULL,3,3),(21,'weight','Weight',1,26,NULL,1,'2007-06-06 14:47:17','2007-06-06 14:47:18',NULL,'list','g,kg,mg,ug,ng,pg',6,'ListElement',3,3),(22,'g','g',1,26,NULL,1,'2007-06-06 14:47:17','2007-06-06 14:47:17',21,'child','',NULL,NULL,3,3),(23,'kg','kg',1,26,NULL,1,'2007-06-06 14:47:17','2007-06-06 14:47:17',21,'child','',NULL,NULL,3,3),(24,'mg','mg',1,26,NULL,1,'2007-06-06 14:47:18','2007-06-06 14:47:18',21,'child','',NULL,NULL,3,3),(25,'ug','ug',1,26,NULL,1,'2007-06-06 14:47:18','2007-06-06 14:47:18',21,'child','',NULL,NULL,3,3),(26,'ng','ng',1,26,NULL,1,'2007-06-06 14:47:18','2007-06-06 14:47:18',21,'child','',NULL,NULL,3,3),(27,'pg','pg',1,26,NULL,1,'2007-06-06 14:47:18','2007-06-06 14:47:18',21,'child','',NULL,NULL,3,3),(28,'Users','User',1,48,NULL,1,'2007-06-06 14:49:09','2007-06-06 14:49:09',NULL,'model','User',NULL,'ModelElement',3,3),(29,'Administrators','Users with full Administration role',1,48,NULL,1,'2007-06-06 14:51:30','2007-06-06 14:51:30',NULL,'sql','select * from users where role_id=3',NULL,'SqlElement',3,3),(30,'Experiment','Experiments',1,24,NULL,1,'2007-06-06 14:52:43','2007-06-06 14:52:44',NULL,'model','Experiment',NULL,'ModelElement',3,3),(31,'Folder','Project Folder',1,51,NULL,1,'2007-06-06 14:53:42','2007-06-06 14:53:42',NULL,'model','ProjectFolder',NULL,'ModelElement',3,3),(32,'Project','List of all projects on the systems ',1,49,NULL,1,'2007-06-06 14:55:25','2007-06-06 14:55:25',NULL,'model','Project',NULL,'ModelElement',3,3),(33,'Task','Task in the system',1,27,NULL,1,'2007-06-06 14:55:53','2007-06-06 14:55:53',NULL,'model','Task',NULL,'ModelElement',3,3),(34,'Batches','Batches of a compound ',1,7,NULL,1,'2007-06-06 14:56:31','2007-06-06 14:56:31',NULL,'model','Batch',NULL,'ModelElement',3,3),(35,'Compounds','Compounds',1,6,NULL,1,'2007-06-06 14:56:50','2007-06-06 14:56:50',NULL,'model','Compound',NULL,'ModelElement',3,3),(36,'Request','List of subjects associated with a request',1,11,NULL,1,'2007-06-06 14:58:11','2007-06-06 14:58:11',NULL,'model','RequestList',NULL,'ModelElement',3,3),(37,'Plate','Plate containers',1,8,NULL,1,'2007-06-06 14:59:01','2007-06-06 14:59:01',NULL,'model','Container',NULL,'ModelElement',3,3),(38,'Area','Research Areas',1,54,NULL,1,'2007-06-06 20:42:42','2007-06-06 20:42:43',NULL,'list','A,B,C,D',4,'ListElement',3,3),(39,'A','A',1,54,NULL,1,'2007-06-06 20:42:42','2007-06-06 20:42:42',38,'child','',NULL,NULL,3,3),(40,'B','B',1,54,NULL,1,'2007-06-06 20:42:42','2007-06-06 20:42:42',38,'child','',NULL,NULL,3,3),(41,'C','C',1,54,NULL,1,'2007-06-06 20:42:42','2007-06-06 20:42:42',38,'child','',NULL,NULL,3,3),(42,'D','D',1,54,NULL,1,'2007-06-06 20:42:42','2007-06-06 20:42:42',38,'child','',NULL,NULL,3,3),(43,'Status','Protocol Status',1,53,NULL,1,'2007-06-06 21:15:55','2007-06-06 21:15:56',NULL,'list','New,Active,Finished',3,'ListElement',3,3),(44,'New','New',1,53,NULL,1,'2007-06-06 21:15:55','2007-06-06 21:15:55',43,'child','',NULL,NULL,3,3),(45,'Active','Active',1,53,NULL,1,'2007-06-06 21:15:55','2007-06-06 21:15:55',43,'child','',NULL,NULL,3,3),(46,'Finished','Finished',1,53,NULL,1,'2007-06-06 21:15:56','2007-06-06 21:15:56',43,'child','',NULL,NULL,3,3),(47,'Catagory','Protocol Catagory',1,52,NULL,1,'2007-06-06 21:17:22','2007-06-06 21:17:22',NULL,'list','Screen,Dose,Profile,Tox',4,'ListElement',3,3),(48,'Screen','Screen',1,52,NULL,1,'2007-06-06 21:17:22','2007-06-06 21:17:22',47,'child','',NULL,NULL,3,3),(49,'Dose','Dose',1,52,NULL,1,'2007-06-06 21:17:22','2007-06-06 21:17:22',47,'child','',NULL,NULL,3,3),(50,'Profile','Profile',1,52,NULL,1,'2007-06-06 21:17:22','2007-06-06 21:17:22',47,'child','',NULL,NULL,3,3),(51,'Tox','Tox',1,52,NULL,1,'2007-06-06 21:17:22','2007-06-06 21:17:22',47,'child','',NULL,NULL,3,3),(75,'PickLists','test',1,55,NULL,1,'2007-06-13 12:13:52','2007-06-13 12:13:52',NULL,'','A,B,C,D',8,NULL,3,3),(76,'FolderTest','folders',1,51,NULL,1,'2007-06-13 12:28:31','2007-06-13 12:28:31',NULL,'list','1,2,3,4',4,'ListElement',3,3),(77,'1','1',1,51,NULL,1,'2007-06-13 12:28:31','2007-06-13 12:28:31',76,'child','',NULL,NULL,3,3),(78,'2','2',1,51,NULL,1,'2007-06-13 12:28:31','2007-06-13 12:28:31',76,'child','',NULL,NULL,3,3),(79,'3','3',1,51,NULL,1,'2007-06-13 12:28:31','2007-06-13 12:28:31',76,'child','',NULL,NULL,3,3),(80,'4','4',1,51,NULL,1,'2007-06-13 12:28:31','2007-06-13 12:28:31',76,'child','',NULL,NULL,3,3),(81,'5','5',1,51,NULL,2,'2007-06-13 12:29:03','2007-06-13 12:29:03',76,'child','',NULL,NULL,3,3),(82,'6moose','6',1,51,NULL,3,'2007-06-13 12:29:06','2007-06-13 12:29:10',76,'child','',NULL,NULL,3,3),(83,'Route','Adding routes of admin',1,56,NULL,1,'2007-06-13 12:30:28','2007-06-13 12:30:28',NULL,'list','iv,im,o',3,'ListElement',3,3),(84,'iv','iv',1,56,NULL,1,'2007-06-13 12:30:28','2007-06-13 12:30:28',83,'child','',NULL,NULL,3,3),(85,'im','im',1,56,NULL,1,'2007-06-13 12:30:28','2007-06-13 12:30:28',83,'child','',NULL,NULL,3,3),(86,'o','o',1,56,NULL,1,'2007-06-13 12:30:28','2007-06-13 12:30:28',83,'child','',NULL,NULL,3,3),(87,'RouteD','test',1,56,NULL,1,'2007-06-13 14:45:05','2007-06-13 14:45:05',NULL,'list','A,B,C,D',4,'ListElement',3,3),(88,'A','A',1,56,NULL,1,'2007-06-13 14:45:05','2007-06-13 14:45:05',87,'child','',NULL,NULL,3,3),(89,'B','B',1,56,NULL,1,'2007-06-13 14:45:05','2007-06-13 14:45:05',87,'child','',NULL,NULL,3,3),(90,'C','C',1,56,NULL,1,'2007-06-13 14:45:05','2007-06-13 14:45:05',87,'child','',NULL,NULL,3,3),(91,'D','D',1,56,NULL,1,'2007-06-13 14:45:05','2007-06-13 14:45:05',87,'child','',NULL,NULL,3,3),(105,'ScoresX','test',1,58,NULL,1,'2007-06-13 14:50:18','2007-06-13 14:50:18',NULL,'','zero,quarter,half,one,two,three,four',7,NULL,3,3),(106,'ClinicalScores','Clinical scores <5',1,58,NULL,1,'2007-06-13 14:50:23','2007-06-13 14:50:23',NULL,'','zero,quarter,half,one,two,three,four',7,NULL,4,4),(107,'Compounds2','comd',1,6,NULL,1,'2007-06-20 16:30:46','2007-06-20 16:30:47',NULL,'list','a,b,c',3,'ListElement',1,1),(108,'a','a',1,6,NULL,1,'2007-06-20 16:30:46','2007-06-20 16:30:46',107,'child','',NULL,NULL,1,1),(109,'b','b',1,6,NULL,1,'2007-06-20 16:30:46','2007-06-20 16:30:47',107,'child','',NULL,NULL,1,1),(110,'c','c',1,6,NULL,1,'2007-06-20 16:30:47','2007-06-20 16:30:47',107,'child','',NULL,NULL,1,1),(111,'xxx','test',1,57,NULL,1,'2007-06-27 15:04:38','2007-06-27 15:04:39',NULL,'list','a,b,c',3,'ListElement',1,1),(112,'a','a',1,57,NULL,1,'2007-06-27 15:04:38','2007-06-27 15:04:38',111,'child','',NULL,NULL,1,1),(113,'b','b',1,57,NULL,1,'2007-06-27 15:04:38','2007-06-27 15:04:38',111,'child','',NULL,NULL,1,1),(114,'c','c',1,57,NULL,1,'2007-06-27 15:04:38','2007-06-27 15:04:38',111,'child','',NULL,NULL,1,1),(115,'d','d',1,57,NULL,2,'2007-06-27 15:04:52','2007-06-27 15:04:53',111,'child','',NULL,NULL,1,1);
/*!40000 ALTER TABLE `data_elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_formats`
--

DROP TABLE IF EXISTS `data_formats`;
CREATE TABLE `data_formats` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `default_value` varchar(255) default NULL,
  `format_regex` varchar(255) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `data_type_id` int(11) default NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  `format_sprintf` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_formats`
--

LOCK TABLES `data_formats` WRITE;
/*!40000 ALTER TABLE `data_formats` DISABLE KEYS */;
INSERT INTO `data_formats` VALUES (1,'Text','Free Format Text','','.',1,'0000-00-00 00:00:00','2007-02-07 14:10:25',1,1,1,NULL),(2,'Alpha','A-Z',NULL,NULL,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',1,1,1,NULL),(3,'Line','Single Line of Text',NULL,'[^\"\\r\\n]*',0,'0000-00-00 00:00:00','0000-00-00 00:00:00',1,1,1,NULL),(4,'Double','Standard Number format +/-nnn.nnnnn with units','0.0','^[-+]?[0-9]*\\.?[0-9]+[ ,A-z,/,%]*$',8,'2006-11-27 11:59:22','2007-06-26 11:38:38',2,1,1,'%g %s'),(7,'Scientific Notation','Scientific Notation',NULL,'[-+]?[0-9]*\\.?[0-9]+([eE][-+]?[0-9]+)?',0,'0000-00-00 00:00:00','0000-00-00 00:00:00',2,1,1,NULL),(8,'Integer','Integer Value','','^[-+]?[0-9]*$',4,'0000-00-00 00:00:00','2007-06-12 16:33:51',2,3,1,'%d'),(11,'Positive','Description:  	Positive integer value.\r\nMatches: 	123|||10|||54\r\nNon-Matches: 	-54|||54.234|||abc','','^[0-9,.]*$',1,'0000-00-00 00:00:00','2007-05-31 14:18:52',2,3,1,''),(12,'Decimal5.2','Description:  	validates to 5 digits and 2 decimal places but not allowing zero','','(?!^0*$)(?!^0*\\.0*$)^\\d{1,5}(\\.\\d{1,2})?$',2,'0000-00-00 00:00:00','2007-06-06 20:13:07',2,3,1,'%5.2d'),(13,'Percentage','Description:  	Percentage (From 0 to 100)\r\n','','[-+]?[0-9]*\\.?[0-9]',1,'0000-00-00 00:00:00','2007-06-06 20:26:16',2,3,1,'%d'),(24,'URL','Description:  	I wrote this after I couldn\'t find an expression that would search for valid URLs, whether they had HTTP in front or not. This will find those that don\'t have hyphens anywhere in them (except for after the domain).\r\nMatches: 	http://www.google.com|||www.123google.com|||www.google.com/help/me\r\nNon-Matches: 	-123google.com|||http://-123.123google.com\r\n ','','(http://)[a..Z]*',1,'0000-00-00 00:00:00','2007-05-25 19:08:50',6,3,1,NULL),(25,'Name','Name without spaces','','^[A-Z,a-z,0-9]*$',1,'2007-05-25 21:07:28','2007-05-28 15:02:59',3,3,3,''),(26,'Quantiy','Basic numeric value followed by a unit','','^[-+]?[0-9]*\\.?[0-9]+[ ,A-z,/,%]*$',0,'2007-06-06 20:15:15','2007-06-06 20:15:15',2,3,3,'%d %s'),(27,'Concentration','Concentration in molar units','','^[-+]?[0-9]*\\.?[0-9]* ?[m,u,u,p]?M?$',1,'2007-06-06 20:20:26','2007-06-08 11:24:56',2,3,3,'%d %s'),(28,'Amount','Mols of stuff ','','^[-+]?[0-9]*\\.?[0-9] ?[(m,u,n,p)]mol$',0,'2007-06-06 20:22:12','2007-06-06 20:22:12',2,3,3,'%d %s');
/*!40000 ALTER TABLE `data_formats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_relations`
--

DROP TABLE IF EXISTS `data_relations`;
CREATE TABLE `data_relations` (
  `id` int(11) NOT NULL auto_increment,
  `from_concept_id` int(32) NOT NULL,
  `to_concept_id` int(32) NOT NULL,
  `role_concept_id` int(32) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `data_relations_from_idx` (`from_concept_id`),
  KEY `data_relations_to_idx` (`to_concept_id`),
  KEY `data_relations_role_idx` (`role_concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_relations`
--

LOCK TABLES `data_relations` WRITE;
/*!40000 ALTER TABLE `data_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_systems`
--

DROP TABLE IF EXISTS `data_systems`;
CREATE TABLE `data_systems` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL default '',
  `description` text,
  `data_context_id` int(11) NOT NULL default '1',
  `access_control_id` int(11) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `adapter` varchar(50) NOT NULL default 'mysql',
  `host` varchar(50) default 'localhost',
  `username` varchar(50) default 'root',
  `password` varchar(50) default '',
  `database` varchar(50) default '',
  `test_object` varchar(45) NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `data_environments_idx2` (`updated_at`),
  KEY `data_environments_idx4` (`created_at`),
  KEY `data_environments_name_idx` (`name`),
  KEY `data_environments_acl_idx` (`access_control_id`),
  KEY `data_environments_fk1` (`data_context_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_systems`
--

LOCK TABLES `data_systems` WRITE;
/*!40000 ALTER TABLE `data_systems` DISABLE KEYS */;
INSERT INTO `data_systems` VALUES (1,'Internal','Internal link to reference data element from with this BioRails schema',1,NULL,5,'2006-10-09 12:11:25','2007-01-13 21:46:14','mysql','localhost','biorails','moose','beagle_development','tmp_data',1,1);
/*!40000 ALTER TABLE `data_systems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_types`
--

DROP TABLE IF EXISTS `data_types`;
CREATE TABLE `data_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `value_class` varchar(255) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_types`
--

LOCK TABLES `data_types` WRITE;
/*!40000 ALTER TABLE `data_types` DISABLE KEYS */;
INSERT INTO `data_types` VALUES (1,'text','Text','String',1,'0000-00-00 00:00:00','2006-12-13 16:44:12',1,1),(2,'numeric','Numeric','Numeric',1,'0000-00-00 00:00:00','2006-12-13 16:44:21',1,1),(3,'date','Date','Date',1,'0000-00-00 00:00:00','2006-12-13 16:44:28',1,1),(4,'time','Time','DateTime',1,'0000-00-00 00:00:00','2006-12-13 16:44:35',1,1),(5,'dictionary','Look up on catalogue','DataConcept',1,'0000-00-00 00:00:00','2006-12-13 16:44:41',1,1),(6,'url','Reference','String',1,'0000-00-00 00:00:00','2006-12-13 16:44:50',1,1),(7,'file','File','File',1,'0000-00-00 00:00:00','2006-12-13 16:45:26',1,1);
/*!40000 ALTER TABLE `data_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `db_files`
--

DROP TABLE IF EXISTS `db_files`;
CREATE TABLE `db_files` (
  `id` int(11) NOT NULL auto_increment,
  `data` longblob,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `db_files`
--

LOCK TABLES `db_files` WRITE;
/*!40000 ALTER TABLE `db_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `db_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experiment_logs`
--

DROP TABLE IF EXISTS `experiment_logs`;
CREATE TABLE `experiment_logs` (
  `id` int(11) NOT NULL auto_increment,
  `experiment_id` int(11) default NULL,
  `task_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `auditable_id` int(11) default NULL,
  `auditable_type` varchar(255) default NULL,
  `action` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `comment` varchar(255) default NULL,
  `created_by` varchar(255) default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `experiment_logs_experiment_id_index` (`experiment_id`),
  KEY `experiment_logs_user_id_index` (`user_id`),
  KEY `experiment_logs_auditable_type_index` (`auditable_type`,`auditable_id`),
  KEY `experiment_logs_created_at_index` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `experiment_logs`
--

LOCK TABLES `experiment_logs` WRITE;
/*!40000 ALTER TABLE `experiment_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `experiment_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `experiment_statistics`
--

DROP TABLE IF EXISTS `experiment_statistics`;
/*!50001 DROP VIEW IF EXISTS `experiment_statistics`*/;
/*!50001 CREATE TABLE `experiment_statistics` (
  `id` bigint(20),
  `experiment_id` int(11),
  `study_parameter_id` int(11),
  `parameter_role_id` int(11),
  `parameter_type_id` int(11),
  `data_type_id` int(11),
  `avg_values` double,
  `stddev_values` double,
  `num_values` bigint(20),
  `num_unique` bigint(20),
  `max_values` double,
  `min_values` double
) */;

--
-- Table structure for table `experiments`
--

DROP TABLE IF EXISTS `experiments`;
CREATE TABLE `experiments` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `category_id` int(11) default NULL,
  `status_id` int(11) NOT NULL default '0',
  `study_id` int(11) NOT NULL,
  `protocol_version_id` int(11) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `study_protocol_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  `started_at` datetime default NULL,
  `ended_at` datetime default NULL,
  `expected_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `experiments`
--

LOCK TABLES `experiments` WRITE;
/*!40000 ALTER TABLE `experiments` DISABLE KEYS */;
/*!40000 ALTER TABLE `experiments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `identifiers`
--

DROP TABLE IF EXISTS `identifiers`;
CREATE TABLE `identifiers` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `prefix` varchar(255) default NULL,
  `postfix` varchar(255) default NULL,
  `mask` varchar(255) default NULL,
  `current_counter` int(11) default '0',
  `current_step` int(11) default '1',
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `identifiers`
--

LOCK TABLES `identifiers` WRITE;
/*!40000 ALTER TABLE `identifiers` DISABLE KEYS */;
INSERT INTO `identifiers` VALUES (1,'ProjectFolder','Fold-','',NULL,9,1,9,'2007-04-18 13:30:15','2007-04-30 17:57:03',1,1),(2,'Experiment','Expt-','',NULL,6,1,6,'2007-04-18 13:58:39','2007-04-30 21:12:55',1,1),(3,'Task','Task-','',NULL,35,1,35,'2007-04-18 14:08:30','2007-06-28 22:18:56',1,1),(4,'ProjectContent','Note-','',NULL,65,1,65,'2007-04-18 14:31:57','2007-04-30 20:39:13',1,1),(5,'Study','S-','',NULL,47,1,47,'2007-04-18 19:04:32','2007-06-19 09:08:56',1,1),(6,'Report','R-','',NULL,45,1,45,'2007-04-19 11:18:58','2007-06-29 15:07:12',1,1),(7,'','-','',NULL,3,1,3,'2007-04-19 16:31:46','2007-04-19 16:32:39',1,1),(8,'rshell','rjs-','',NULL,352,1,352,'2007-04-19 16:33:09','2007-07-02 14:31:31',1,1),(9,'Request','Req-','',NULL,25,1,25,'2007-04-19 20:51:01','2007-06-27 14:55:30',1,1),(10,'ProjectAsset','File-','',NULL,31,1,31,'2007-04-25 09:46:42','2007-05-01 06:01:34',1,1),(11,'StudyProtocol','Prot-','',NULL,27,1,27,'2007-04-30 16:55:39','2007-06-21 12:50:56',1,1),(12,'Content','Art-','',NULL,48,1,48,'2007-05-25 16:34:09','2007-07-02 14:31:37',1,1),(13,'member','m-','',NULL,3,1,3,'2007-05-30 15:42:54','2007-05-30 15:43:45',1,1),(14,'Role','Role-','',NULL,9,1,9,'2007-06-11 11:28:46','2007-06-11 12:47:48',1,1),(15,'admin','admin-','',NULL,1,1,1,'2007-06-12 12:31:26','2007-06-12 12:31:26',1,1),(16,'thawkins','thawkins-','',NULL,4,1,4,'2007-06-13 01:09:17','2007-06-27 15:11:49',1,1),(17,'guest','guest-','',NULL,19,1,19,'2007-06-21 12:53:28','2007-06-29 11:37:45',1,1);
/*!40000 ALTER TABLE `identifiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `list_items`
--

DROP TABLE IF EXISTS `list_items`;
CREATE TABLE `list_items` (
  `id` int(11) NOT NULL auto_increment,
  `list_id` int(11) default NULL,
  `data_type` varchar(255) default NULL,
  `data_id` int(11) default NULL,
  `data_name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `list_items`
--

LOCK TABLES `list_items` WRITE;
/*!40000 ALTER TABLE `list_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `list_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lists`
--

DROP TABLE IF EXISTS `lists`;
CREATE TABLE `lists` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `type` varchar(255) default NULL,
  `expires_at` datetime default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `data_element_id` int(11) default NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lists`
--

LOCK TABLES `lists` WRITE;
/*!40000 ALTER TABLE `lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logging_events`
--

DROP TABLE IF EXISTS `logging_events`;
CREATE TABLE `logging_events` (
  `id` int(11) NOT NULL auto_increment,
  `level` varchar(255) default NULL,
  `source` varchar(255) default NULL,
  `class_ref` varchar(255) default NULL,
  `id_ref` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `comments` varchar(255) default NULL,
  `data` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logging_events`
--

LOCK TABLES `logging_events` WRITE;
/*!40000 ALTER TABLE `logging_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `logging_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `memberships`
--

DROP TABLE IF EXISTS `memberships`;
CREATE TABLE `memberships` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `project_id` int(11) NOT NULL default '0',
  `role_id` int(11) NOT NULL default '0',
  `owner` tinyint(1) default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `memberships`
--

LOCK TABLES `memberships` WRITE;
/*!40000 ALTER TABLE `memberships` DISABLE KEYS */;
INSERT INTO `memberships` VALUES (1,1,1,1,0,'0000-00-00 00:00:00','0000-00-00 00:00:00',1,1),(2,2,1,3,1,'0000-00-00 00:00:00','0000-00-00 00:00:00',1,1),(3,3,1,3,1,'0000-00-00 00:00:00','0000-00-00 00:00:00',1,1),(4,4,1,3,1,'0000-00-00 00:00:00','0000-00-00 00:00:00',1,1),(5,6,1,3,1,'0000-00-00 00:00:00','0000-00-00 00:00:00',1,1),(7,7,1,2,0,'2007-04-18 15:30:13','2007-04-19 20:50:06',1,1),(28,8,1,2,0,'2007-05-30 14:17:29','2007-05-30 14:17:29',3,3),(31,9,1,2,0,'2007-06-06 18:16:18','2007-06-06 18:16:18',3,3),(32,3,13,5,1,'2007-06-06 22:06:30','2007-06-11 13:33:07',3,3),(33,4,13,5,0,'2007-06-07 22:50:01','2007-06-11 13:32:52',3,3),(34,6,13,2,0,'2007-06-07 22:50:13','2007-06-11 13:32:36',3,3),(35,7,13,5,0,'2007-06-07 22:50:30','2007-06-11 13:32:15',3,3),(36,9,13,2,0,'2007-06-11 13:31:57','2007-06-11 13:31:57',3,3),(39,6,14,1,1,'2007-06-19 09:06:34','2007-06-19 09:06:34',6,6),(44,4,16,1,1,'2007-06-27 15:08:50','2007-06-27 15:08:50',1,1);
/*!40000 ALTER TABLE `memberships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parameter_contexts`
--

DROP TABLE IF EXISTS `parameter_contexts`;
CREATE TABLE `parameter_contexts` (
  `id` int(11) NOT NULL auto_increment,
  `protocol_version_id` int(11) default NULL,
  `parent_id` int(11) default NULL,
  `level_no` int(11) default '0',
  `label` varchar(255) default NULL,
  `default_count` int(11) default '1',
  PRIMARY KEY  (`id`),
  KEY `parameter_contexts_process_instance_id_index` (`protocol_version_id`),
  KEY `parameter_contexts_parent_id_index` (`parent_id`),
  KEY `parameter_contexts_label_index` (`label`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `parameter_contexts`
--

LOCK TABLES `parameter_contexts` WRITE;
/*!40000 ALTER TABLE `parameter_contexts` DISABLE KEYS */;
/*!40000 ALTER TABLE `parameter_contexts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parameter_roles`
--

DROP TABLE IF EXISTS `parameter_roles`;
CREATE TABLE `parameter_roles` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `weighing` int(11) NOT NULL default '0',
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `parameter_roles`
--

LOCK TABLES `parameter_roles` WRITE;
/*!40000 ALTER TABLE `parameter_roles` DISABLE KEYS */;
INSERT INTO `parameter_roles` VALUES (1,'observation','Measurement of the system under investigation',1,3,'2006-10-26 15:34:14','2006-12-13 16:43:21',1,1),(2,'result','Summary data generated from the observations and other inputs',2,4,'2006-10-26 15:34:25','2006-12-13 16:43:32',1,1),(3,'setting','Prefixed Setting',1,4,'2006-10-26 15:34:38','2006-12-13 16:43:39',1,1),(4,'subject','Subject of Experiment',0,3,'2006-10-26 15:35:05','2006-12-13 16:43:47',1,1),(6,'condition','Conditions under which the data is collected',1,3,'2006-12-13 09:53:50','2006-12-13 19:38:06',1,1);
/*!40000 ALTER TABLE `parameter_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parameter_types`
--

DROP TABLE IF EXISTS `parameter_types`;
CREATE TABLE `parameter_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `weighing` int(11) NOT NULL default '0',
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `data_concept_id` int(11) default NULL,
  `data_type_id` int(11) default NULL,
  `storage_unit` varchar(255) default NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `parameter_types`
--

LOCK TABLES `parameter_types` WRITE;
/*!40000 ALTER TABLE `parameter_types` DISABLE KEYS */;
INSERT INTO `parameter_types` VALUES (1,'Dose','Dosage ',0,0,'2007-06-06 16:56:20','2007-06-06 16:56:20',NULL,2,'',3,3),(2,'Count','This is generic parameter type for animal counts and other such totals',0,1,'2007-06-06 16:59:17','2007-06-06 17:02:49',NULL,2,'counting',3,3),(3,'Inhibition','A good example of usage would be the competitive inhibition, the inhibitor binds to the same active site as the normal enzyme substrate, without undergoing a reaction. The substrate molecule cannot enter the active site while the inhibitor is there, and t',0,1,'2007-06-06 17:01:06','2007-06-08 10:45:01',NULL,2,'',3,3),(4,'Identifier','In the case of non managed inventories this provide a reference text or barcode used for identification',0,0,'2007-06-06 17:04:24','2007-06-06 17:04:24',NULL,1,'',3,3),(5,'Compound','Lookup of a compound reference, dictionary driven',0,0,'2007-06-06 17:05:07','2007-06-06 17:05:07',NULL,5,'',3,3),(6,'Plate','Plate reference, lookup based Plate Id ',0,0,'2007-06-06 17:05:46','2007-06-06 17:05:46',NULL,5,'',3,3),(7,'Subject','Generic lookup for the subject of a experiment may be a compound, tissue , treadment group in use depending on the study.',0,0,'2007-06-06 17:07:05','2007-06-06 17:07:05',NULL,5,'',3,3),(8,'Rate','Rate for radisotope used and other places with are managing counts per min etc.',0,0,'2007-06-06 17:08:52','2007-06-06 17:08:52',NULL,2,'rate',3,3),(9,'Duration','Duration for managemenrt of delta times and other time points as numeric values.',0,0,'2007-06-06 17:09:57','2007-06-06 17:09:57',NULL,2,'time',3,3),(10,'Length','Length ',0,0,'2007-06-06 17:12:28','2007-06-06 17:12:28',NULL,2,'length',3,3),(11,'URL','Reference url for futher information in external context',0,1,'2007-06-06 17:13:05','2007-06-06 17:13:42',NULL,6,'',3,3),(12,'IC50','IC50 is a measure of concentration used in pharmacological research. IC50, or the half maximal inhibitory concentration, represents the concentration of an inhibitor that is required for 50% inhibition of its target (i.e. an enzyme, cell, cell receptor or',0,0,'2007-06-06 22:22:07','2007-06-06 22:22:07',NULL,2,'concentration',3,3),(13,'Enzyme','Enzymes are proteins that catalyze (i.e. accelerate) chemical reactions.[1] In enzymatic reactions, the molecules at the beginning of the process are called substrates, and the enzyme converts them into different molecules, the products. Almost all proces',0,0,'2007-06-06 22:27:29','2007-06-06 22:27:29',NULL,1,'',3,3),(14,'organism','n biology and ecology, an organism (in Greek organon = instrument) is a living complex adaptive system of organs that influence each other in such a way that they function in some way as a stable whole.\r\n\r\nThe origin of life on Earth and the relationships',0,0,'2007-06-06 22:29:09','2007-06-06 22:29:09',NULL,1,'',3,3),(15,'Location','Location of a object',0,0,'2007-06-06 22:29:40','2007-06-06 22:29:40',NULL,1,'',3,3),(16,'Date','Date',0,0,'2007-06-08 10:49:26','2007-06-08 10:49:26',NULL,3,'',3,3),(17,'Time','Time',0,0,'2007-06-08 10:49:50','2007-06-08 10:49:50',NULL,2,'time',3,3),(18,'Temperature','Temperature',0,0,'2007-06-08 10:51:11','2007-06-08 10:51:11',NULL,2,'temperature',3,3),(19,'ClinScore','Clinical Score',0,0,'2007-06-13 11:59:30','2007-06-13 11:59:30',55,5,NULL,4,4),(20,'cmd2','cmpd',0,0,'2007-06-20 16:33:34','2007-06-20 16:33:34',6,5,NULL,1,1),(21,'Mass','Mass',0,0,'2007-06-21 12:31:55','2007-06-21 12:31:55',NULL,2,'mass',1,1),(22,'TreatmentGroup','Treatment Group',0,0,'2007-06-21 12:44:11','2007-06-21 12:44:11',9,5,NULL,1,1);
/*!40000 ALTER TABLE `parameter_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parameters`
--

DROP TABLE IF EXISTS `parameters`;
CREATE TABLE `parameters` (
  `id` int(11) NOT NULL auto_increment,
  `protocol_version_id` int(11) default NULL,
  `parameter_type_id` int(11) default NULL,
  `parameter_role_id` int(11) default NULL,
  `parameter_context_id` int(11) default NULL,
  `column_no` int(11) default NULL,
  `sequence_num` int(11) default NULL,
  `name` varchar(62) default NULL,
  `description` varchar(62) default NULL,
  `display_unit` varchar(20) default NULL,
  `data_element_id` int(11) default NULL,
  `qualifier_style` varchar(1) default NULL,
  `access_control_id` int(11) NOT NULL default '0',
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `mandatory` varchar(255) default 'N',
  `default_value` varchar(255) default NULL,
  `data_type_id` int(11) default NULL,
  `data_format_id` int(11) default NULL,
  `study_parameter_id` int(11) default NULL,
  `study_queue_id` int(11) default NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `parameters_name_index` (`name`),
  KEY `parameters_process_instance_id_index` (`protocol_version_id`),
  KEY `parameters_parameter_context_id_index` (`parameter_context_id`),
  KEY `parameters_parameter_type_id_index` (`parameter_type_id`),
  KEY `parameters_parameter_role_id_index` (`parameter_role_id`),
  KEY `parameters_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `parameters`
--

LOCK TABLES `parameters` WRITE;
/*!40000 ALTER TABLE `parameters` DISABLE KEYS */;
/*!40000 ALTER TABLE `parameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` int(11) NOT NULL auto_increment,
  `checked` tinyint(1) NOT NULL default '0',
  `subject` varchar(255) NOT NULL default '',
  `action` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=475 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,1,'user','*'),(2,1,'user','--- :list\n'),(3,1,'user','--- :show\n'),(4,1,'user','--- :new\n'),(5,1,'user','--- :create\n'),(6,1,'user','--- :edit\n'),(7,1,'user','--- :update\n'),(8,1,'user','--- :desrroy\n'),(9,1,'auth','*'),(10,1,'protocol','*'),(11,1,'protocol','--- :list\n'),(12,1,'protocol','--- :show\n'),(13,1,'protocol','--- :new\n'),(14,1,'protocol','--- :create\n'),(15,1,'protocol','--- :edit\n'),(16,1,'protocol','--- :update\n'),(17,1,'protocol','--- :desrroy\n'),(18,1,'study','*'),(19,1,'study','--- :list\n'),(20,1,'study','--- :show\n'),(21,1,'study','--- :new\n'),(22,1,'study','--- :create\n'),(23,1,'study','--- :edit\n'),(24,1,'study','--- :update\n'),(25,1,'study','--- :desrroy\n'),(26,1,'catalogue','*'),(27,1,'catalogue','--- :list\n'),(28,1,'catalogue','--- :show\n'),(29,1,'catalogue','--- :new\n'),(30,1,'catalogue','--- :create\n'),(31,1,'catalogue','--- :edit\n'),(32,1,'catalogue','--- :update\n'),(33,1,'catalogue','--- :desrroy\n'),(34,1,'project','*'),(35,1,'project','--- :list\n'),(36,1,'project','--- :show\n'),(37,1,'project','--- :new\n'),(38,1,'project','--- :create\n'),(39,1,'project','--- :edit\n'),(40,1,'project','--- :update\n'),(41,1,'project','--- :desrroy\n'),(42,1,'system','*'),(43,1,'system','--- :list\n'),(44,1,'system','--- :show\n'),(45,1,'system','--- :new\n'),(46,1,'system','--- :create\n'),(47,1,'system','--- :edit\n'),(48,1,'system','--- :update\n'),(49,1,'system','--- :desrroy\n'),(50,1,'cataloge','*'),(51,1,'cataloge','--- :list\n'),(52,1,'cataloge','--- :show\n'),(53,1,'cataloge','--- :new\n'),(54,1,'cataloge','--- :create\n'),(55,1,'cataloge','--- :edit\n'),(56,1,'cataloge','--- :update\n'),(57,1,'cataloge','--- :desrroy\n'),(58,1,'data_capture','*'),(59,1,'articles','*'),(60,1,'experiment','*'),(61,1,'experiment','--- :list\n'),(62,1,'experiment','--- :show\n'),(63,1,'experiment','--- :new\n'),(64,1,'experiment','--- :create\n'),(65,1,'experiment','--- :edit\n'),(66,1,'experiment','--- :update\n'),(67,1,'experiment','--- :desrroy\n'),(68,1,'page','*'),(69,1,'request','*'),(70,1,'request','--- :list\n'),(71,1,'request','--- :show\n'),(72,1,'request','--- :new\n'),(73,1,'request','--- :create\n'),(74,1,'request','--- :edit\n'),(75,1,'request','--- :update\n'),(76,1,'request','--- :desrroy\n'),(77,1,'users','*'),(78,1,'users','--- :list\n'),(79,1,'users','--- :show\n'),(80,1,'users','--- :new\n'),(81,1,'users','--- :create\n'),(82,1,'users','--- :edit\n'),(83,1,'users','--- :update\n'),(84,1,'users','--- :desrroy\n'),(85,1,'report','*'),(86,1,'report','--- :list\n'),(87,1,'report','--- :show\n'),(88,1,'report','--- :new\n'),(89,1,'report','--- :create\n'),(90,1,'report','--- :edit\n'),(91,1,'report','--- :update\n'),(92,1,'report','--- :desrroy\n'),(93,1,'home','*'),(94,1,'home','--- :index\n'),(95,1,'home','--- :show\n'),(96,1,'home','--- :projects\n'),(97,1,'home','--- :calendar\n'),(98,1,'home','--- :timeline\n'),(99,1,'home','--- :blog\n'),(100,1,'home','--- :destroy\n'),(101,1,'finder','*'),(102,1,'charts','*'),(103,1,'inventory','*'),(104,1,'inventory','--- :list\n'),(105,1,'inventory','--- :show\n'),(106,1,'inventory','--- :new\n'),(107,1,'inventory','--- :create\n'),(108,1,'inventory','--- :edit\n'),(109,1,'inventory','--- :update\n'),(110,1,'inventory','--- :desrroy\n'),(111,1,'user','--- :list\n'),(112,1,'user','--- :show\n'),(113,1,'user','--- :new\n'),(114,1,'user','--- :create\n'),(115,1,'user','--- :edit\n'),(116,1,'user','--- :update\n'),(117,1,'user','--- :desrroy\n'),(118,1,'protocol','--- :list\n'),(119,1,'protocol','--- :show\n'),(120,1,'protocol','--- :new\n'),(121,1,'protocol','--- :create\n'),(122,1,'protocol','--- :edit\n'),(123,1,'protocol','--- :update\n'),(124,1,'protocol','--- :desrroy\n'),(125,1,'study','--- :list\n'),(126,1,'study','--- :show\n'),(127,1,'study','--- :new\n'),(128,1,'study','--- :create\n'),(129,1,'study','--- :edit\n'),(130,1,'study','--- :update\n'),(131,1,'study','--- :desrroy\n'),(132,1,'catalogue','--- :list\n'),(133,1,'catalogue','--- :show\n'),(134,1,'catalogue','--- :new\n'),(135,1,'catalogue','--- :create\n'),(136,1,'catalogue','--- :edit\n'),(137,1,'catalogue','--- :update\n'),(138,1,'catalogue','--- :desrroy\n'),(139,1,'project','--- :list\n'),(140,1,'project','--- :show\n'),(141,1,'project','--- :new\n'),(142,1,'project','--- :create\n'),(143,1,'project','--- :edit\n'),(144,1,'project','--- :update\n'),(145,1,'project','--- :desrroy\n'),(146,1,'system','--- :list\n'),(147,1,'system','--- :show\n'),(148,1,'system','--- :new\n'),(149,1,'system','--- :create\n'),(150,1,'system','--- :edit\n'),(151,1,'system','--- :update\n'),(152,1,'system','--- :desrroy\n'),(153,1,'cataloge','--- :list\n'),(154,1,'cataloge','--- :show\n'),(155,1,'cataloge','--- :new\n'),(156,1,'cataloge','--- :create\n'),(157,1,'cataloge','--- :edit\n'),(158,1,'cataloge','--- :update\n'),(159,1,'cataloge','--- :desrroy\n'),(160,1,'experiment','--- :list\n'),(161,1,'experiment','--- :show\n'),(162,1,'experiment','--- :new\n'),(163,1,'experiment','--- :create\n'),(164,1,'experiment','--- :edit\n'),(165,1,'experiment','--- :update\n'),(166,1,'experiment','--- :desrroy\n'),(167,1,'request','--- :list\n'),(168,1,'request','--- :show\n'),(169,1,'request','--- :new\n'),(170,1,'request','--- :create\n'),(171,1,'request','--- :edit\n'),(172,1,'request','--- :update\n'),(173,1,'request','--- :desrroy\n'),(174,1,'users','--- :list\n'),(175,1,'users','--- :show\n'),(176,1,'users','--- :new\n'),(177,1,'users','--- :create\n'),(178,1,'users','--- :edit\n'),(179,1,'users','--- :update\n'),(180,1,'users','--- :desrroy\n'),(181,1,'report','--- :list\n'),(182,1,'report','--- :show\n'),(183,1,'report','--- :new\n'),(184,1,'report','--- :create\n'),(185,1,'report','--- :edit\n'),(186,1,'report','--- :update\n'),(187,1,'report','--- :desrroy\n'),(188,1,'home','--- :index\n'),(189,1,'home','--- :show\n'),(190,1,'home','--- :projects\n'),(191,1,'home','--- :calendar\n'),(192,1,'home','--- :timeline\n'),(193,1,'home','--- :blog\n'),(194,1,'home','--- :destroy\n'),(195,1,'inventory','--- :list\n'),(196,1,'inventory','--- :show\n'),(197,1,'inventory','--- :new\n'),(198,1,'inventory','--- :create\n'),(199,1,'inventory','--- :edit\n'),(200,1,'inventory','--- :update\n'),(201,1,'inventory','--- :desrroy\n'),(202,1,'user','--- :list\n'),(203,1,'user','--- :show\n'),(204,1,'user','--- :new\n'),(205,1,'user','--- :create\n'),(206,1,'user','--- :edit\n'),(207,1,'user','--- :update\n'),(208,1,'user','--- :desrroy\n'),(209,1,'protocol','--- :list\n'),(210,1,'protocol','--- :show\n'),(211,1,'protocol','--- :new\n'),(212,1,'protocol','--- :create\n'),(213,1,'protocol','--- :edit\n'),(214,1,'protocol','--- :update\n'),(215,1,'protocol','--- :desrroy\n'),(216,1,'study','--- :list\n'),(217,1,'study','--- :show\n'),(218,1,'study','--- :new\n'),(219,1,'study','--- :create\n'),(220,1,'study','--- :edit\n'),(221,1,'study','--- :update\n'),(222,1,'study','--- :desrroy\n'),(223,1,'catalogue','--- :list\n'),(224,1,'catalogue','--- :show\n'),(225,1,'catalogue','--- :new\n'),(226,1,'catalogue','--- :create\n'),(227,1,'catalogue','--- :edit\n'),(228,1,'catalogue','--- :update\n'),(229,1,'catalogue','--- :desrroy\n'),(230,1,'project','--- :list\n'),(231,1,'project','--- :show\n'),(232,1,'project','--- :new\n'),(233,1,'project','--- :create\n'),(234,1,'project','--- :edit\n'),(235,1,'project','--- :update\n'),(236,1,'project','--- :desrroy\n'),(237,1,'system','--- :list\n'),(238,1,'system','--- :show\n'),(239,1,'system','--- :new\n'),(240,1,'system','--- :create\n'),(241,1,'system','--- :edit\n'),(242,1,'system','--- :update\n'),(243,1,'system','--- :desrroy\n'),(244,1,'cataloge','--- :list\n'),(245,1,'cataloge','--- :show\n'),(246,1,'cataloge','--- :new\n'),(247,1,'cataloge','--- :create\n'),(248,1,'cataloge','--- :edit\n'),(249,1,'cataloge','--- :update\n'),(250,1,'cataloge','--- :desrroy\n'),(251,1,'experiment','--- :list\n'),(252,1,'experiment','--- :show\n'),(253,1,'experiment','--- :new\n'),(254,1,'experiment','--- :create\n'),(255,1,'experiment','--- :edit\n'),(256,1,'experiment','--- :update\n'),(257,1,'experiment','--- :desrroy\n'),(258,1,'request','--- :list\n'),(259,1,'request','--- :show\n'),(260,1,'request','--- :new\n'),(261,1,'request','--- :create\n'),(262,1,'request','--- :edit\n'),(263,1,'request','--- :update\n'),(264,1,'request','--- :desrroy\n'),(265,1,'users','--- :list\n'),(266,1,'users','--- :show\n'),(267,1,'users','--- :new\n'),(268,1,'users','--- :create\n'),(269,1,'users','--- :edit\n'),(270,1,'users','--- :update\n'),(271,1,'users','--- :desrroy\n'),(272,1,'report','--- :list\n'),(273,1,'report','--- :show\n'),(274,1,'report','--- :new\n'),(275,1,'report','--- :create\n'),(276,1,'report','--- :edit\n'),(277,1,'report','--- :update\n'),(278,1,'report','--- :desrroy\n'),(279,1,'home','--- :index\n'),(280,1,'home','--- :show\n'),(281,1,'home','--- :projects\n'),(282,1,'home','--- :calendar\n'),(283,1,'home','--- :timeline\n'),(284,1,'home','--- :blog\n'),(285,1,'home','--- :destroy\n'),(286,1,'inventory','--- :list\n'),(287,1,'inventory','--- :show\n'),(288,1,'inventory','--- :new\n'),(289,1,'inventory','--- :create\n'),(290,1,'inventory','--- :edit\n'),(291,1,'inventory','--- :update\n'),(292,1,'inventory','--- :desrroy\n'),(293,1,'user','--- :list\n'),(294,1,'user','--- :show\n'),(295,1,'user','--- :new\n'),(296,1,'user','--- :create\n'),(297,1,'user','--- :edit\n'),(298,1,'user','--- :update\n'),(299,1,'user','--- :desrroy\n'),(300,1,'protocol','--- :list\n'),(301,1,'protocol','--- :show\n'),(302,1,'protocol','--- :new\n'),(303,1,'protocol','--- :create\n'),(304,1,'protocol','--- :edit\n'),(305,1,'protocol','--- :update\n'),(306,1,'protocol','--- :desrroy\n'),(307,1,'study','--- :list\n'),(308,1,'study','--- :show\n'),(309,1,'study','--- :new\n'),(310,1,'study','--- :create\n'),(311,1,'study','--- :edit\n'),(312,1,'study','--- :update\n'),(313,1,'study','--- :desrroy\n'),(314,1,'catalogue','--- :list\n'),(315,1,'catalogue','--- :show\n'),(316,1,'catalogue','--- :new\n'),(317,1,'catalogue','--- :create\n'),(318,1,'catalogue','--- :edit\n'),(319,1,'catalogue','--- :update\n'),(320,1,'catalogue','--- :desrroy\n'),(321,1,'project','--- :list\n'),(322,1,'project','--- :show\n'),(323,1,'project','--- :new\n'),(324,1,'project','--- :create\n'),(325,1,'project','--- :edit\n'),(326,1,'project','--- :update\n'),(327,1,'project','--- :desrroy\n'),(328,1,'system','--- :list\n'),(329,1,'system','--- :show\n'),(330,1,'system','--- :new\n'),(331,1,'system','--- :create\n'),(332,1,'system','--- :edit\n'),(333,1,'system','--- :update\n'),(334,1,'system','--- :desrroy\n'),(335,1,'cataloge','--- :list\n'),(336,1,'cataloge','--- :show\n'),(337,1,'cataloge','--- :new\n'),(338,1,'cataloge','--- :create\n'),(339,1,'cataloge','--- :edit\n'),(340,1,'cataloge','--- :update\n'),(341,1,'cataloge','--- :desrroy\n'),(342,1,'experiment','--- :list\n'),(343,1,'experiment','--- :show\n'),(344,1,'experiment','--- :new\n'),(345,1,'experiment','--- :create\n'),(346,1,'experiment','--- :edit\n'),(347,1,'experiment','--- :update\n'),(348,1,'experiment','--- :desrroy\n'),(349,1,'request','--- :list\n'),(350,1,'request','--- :show\n'),(351,1,'request','--- :new\n'),(352,1,'request','--- :create\n'),(353,1,'request','--- :edit\n'),(354,1,'request','--- :update\n'),(355,1,'request','--- :desrroy\n'),(356,1,'users','--- :list\n'),(357,1,'users','--- :show\n'),(358,1,'users','--- :new\n'),(359,1,'users','--- :create\n'),(360,1,'users','--- :edit\n'),(361,1,'users','--- :update\n'),(362,1,'users','--- :desrroy\n'),(363,1,'report','--- :list\n'),(364,1,'report','--- :show\n'),(365,1,'report','--- :new\n'),(366,1,'report','--- :create\n'),(367,1,'report','--- :edit\n'),(368,1,'report','--- :update\n'),(369,1,'report','--- :desrroy\n'),(370,1,'home','--- :index\n'),(371,1,'home','--- :show\n'),(372,1,'home','--- :projects\n'),(373,1,'home','--- :calendar\n'),(374,1,'home','--- :timeline\n'),(375,1,'home','--- :blog\n'),(376,1,'home','--- :destroy\n'),(377,1,'inventory','--- :list\n'),(378,1,'inventory','--- :show\n'),(379,1,'inventory','--- :new\n'),(380,1,'inventory','--- :create\n'),(381,1,'inventory','--- :edit\n'),(382,1,'inventory','--- :update\n'),(383,1,'inventory','--- :desrroy\n'),(384,1,'user','--- :list\n'),(385,1,'user','--- :show\n'),(386,1,'user','--- :new\n'),(387,1,'user','--- :create\n'),(388,1,'user','--- :edit\n'),(389,1,'user','--- :update\n'),(390,1,'user','--- :desrroy\n'),(391,1,'protocol','--- :list\n'),(392,1,'protocol','--- :show\n'),(393,1,'protocol','--- :new\n'),(394,1,'protocol','--- :create\n'),(395,1,'protocol','--- :edit\n'),(396,1,'protocol','--- :update\n'),(397,1,'protocol','--- :desrroy\n'),(398,1,'study','--- :list\n'),(399,1,'study','--- :show\n'),(400,1,'study','--- :new\n'),(401,1,'study','--- :create\n'),(402,1,'study','--- :edit\n'),(403,1,'study','--- :update\n'),(404,1,'study','--- :desrroy\n'),(405,1,'catalogue','--- :list\n'),(406,1,'catalogue','--- :show\n'),(407,1,'catalogue','--- :new\n'),(408,1,'catalogue','--- :create\n'),(409,1,'catalogue','--- :edit\n'),(410,1,'catalogue','--- :update\n'),(411,1,'catalogue','--- :desrroy\n'),(412,1,'project','--- :list\n'),(413,1,'project','--- :show\n'),(414,1,'project','--- :new\n'),(415,1,'project','--- :create\n'),(416,1,'project','--- :edit\n'),(417,1,'project','--- :update\n'),(418,1,'project','--- :desrroy\n'),(419,1,'system','--- :list\n'),(420,1,'system','--- :show\n'),(421,1,'system','--- :new\n'),(422,1,'system','--- :create\n'),(423,1,'system','--- :edit\n'),(424,1,'system','--- :update\n'),(425,1,'system','--- :desrroy\n'),(426,1,'cataloge','--- :list\n'),(427,1,'cataloge','--- :show\n'),(428,1,'cataloge','--- :new\n'),(429,1,'cataloge','--- :create\n'),(430,1,'cataloge','--- :edit\n'),(431,1,'cataloge','--- :update\n'),(432,1,'cataloge','--- :desrroy\n'),(433,1,'experiment','--- :list\n'),(434,1,'experiment','--- :show\n'),(435,1,'experiment','--- :new\n'),(436,1,'experiment','--- :create\n'),(437,1,'experiment','--- :edit\n'),(438,1,'experiment','--- :update\n'),(439,1,'experiment','--- :desrroy\n'),(440,1,'request','--- :list\n'),(441,1,'request','--- :show\n'),(442,1,'request','--- :new\n'),(443,1,'request','--- :create\n'),(444,1,'request','--- :edit\n'),(445,1,'request','--- :update\n'),(446,1,'request','--- :desrroy\n'),(447,1,'users','--- :list\n'),(448,1,'users','--- :show\n'),(449,1,'users','--- :new\n'),(450,1,'users','--- :create\n'),(451,1,'users','--- :edit\n'),(452,1,'users','--- :update\n'),(453,1,'users','--- :desrroy\n'),(454,1,'report','--- :list\n'),(455,1,'report','--- :show\n'),(456,1,'report','--- :new\n'),(457,1,'report','--- :create\n'),(458,1,'report','--- :edit\n'),(459,1,'report','--- :update\n'),(460,1,'report','--- :desrroy\n'),(461,1,'home','--- :index\n'),(462,1,'home','--- :show\n'),(463,1,'home','--- :projects\n'),(464,1,'home','--- :calendar\n'),(465,1,'home','--- :timeline\n'),(466,1,'home','--- :blog\n'),(467,1,'home','--- :destroy\n'),(468,1,'inventory','--- :list\n'),(469,1,'inventory','--- :show\n'),(470,1,'inventory','--- :new\n'),(471,1,'inventory','--- :create\n'),(472,1,'inventory','--- :edit\n'),(473,1,'inventory','--- :update\n'),(474,1,'inventory','--- :desrroy\n');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plate_formats`
--

DROP TABLE IF EXISTS `plate_formats`;
CREATE TABLE `plate_formats` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `rows` int(11) default NULL,
  `columns` int(11) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `plate_formats`
--

LOCK TABLES `plate_formats` WRITE;
/*!40000 ALTER TABLE `plate_formats` DISABLE KEYS */;
INSERT INTO `plate_formats` VALUES (1,'12 Vial Rack','A rack to hold 12 test tubes',1,12,0,'2007-01-10 10:37:19','2007-01-10 10:37:19',1,1);
/*!40000 ALTER TABLE `plate_formats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plate_wells`
--

DROP TABLE IF EXISTS `plate_wells`;
CREATE TABLE `plate_wells` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `label` varchar(255) default NULL,
  `row_no` int(11) NOT NULL default '0',
  `column_no` int(11) NOT NULL default '0',
  `slot_no` int(11) NOT NULL default '0',
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `plate_wells`
--

LOCK TABLES `plate_wells` WRITE;
/*!40000 ALTER TABLE `plate_wells` DISABLE KEYS */;
/*!40000 ALTER TABLE `plate_wells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plates`
--

DROP TABLE IF EXISTS `plates`;
CREATE TABLE `plates` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `external_ref` varchar(255) default NULL,
  `quantity_unit` varchar(255) default NULL,
  `quantity_value` float default NULL,
  `url` varchar(255) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `plates`
--

LOCK TABLES `plates` WRITE;
/*!40000 ALTER TABLE `plates` DISABLE KEYS */;
/*!40000 ALTER TABLE `plates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin_schema_info`
--

DROP TABLE IF EXISTS `plugin_schema_info`;
CREATE TABLE `plugin_schema_info` (
  `plugin_name` varchar(255) default NULL,
  `version` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `plugin_schema_info`
--

LOCK TABLES `plugin_schema_info` WRITE;
/*!40000 ALTER TABLE `plugin_schema_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugin_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `process_definitions`
--

DROP TABLE IF EXISTS `process_definitions`;
CREATE TABLE `process_definitions` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `release` varchar(5) NOT NULL,
  `description` text,
  `protocol_catagory` varchar(20) default NULL,
  `protocol_status` varchar(20) default NULL,
  `literature_ref` varchar(255) default NULL,
  `access_control_id` int(11) NOT NULL default '0',
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `process_definitions_name_index` (`name`),
  KEY `process_definitions_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `process_definitions`
--

LOCK TABLES `process_definitions` WRITE;
/*!40000 ALTER TABLE `process_definitions` DISABLE KEYS */;
/*!40000 ALTER TABLE `process_definitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `process_instances`
--

DROP TABLE IF EXISTS `process_instances`;
CREATE TABLE `process_instances` (
  `id` int(11) NOT NULL auto_increment,
  `process_definition_id` int(11) NOT NULL,
  `name` varchar(77) default NULL,
  `version` int(6) NOT NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` time default NULL,
  `updated_at` time default NULL,
  `how_to` text,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `process_instances_name_index` (`name`),
  KEY `process_instances_process_definition_id_index` (`process_definition_id`),
  KEY `process_instances_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `process_instances`
--

LOCK TABLES `process_instances` WRITE;
/*!40000 ALTER TABLE `process_instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `process_instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `process_statistics`
--

DROP TABLE IF EXISTS `process_statistics`;
/*!50001 DROP VIEW IF EXISTS `process_statistics`*/;
/*!50001 CREATE TABLE `process_statistics` (
  `id` int(11),
  `study_parameter_id` int(11),
  `protocol_version_id` int(11),
  `parameter_id` int(11),
  `parameter_role_id` int(11),
  `parameter_type_id` int(11),
  `avg_values` double,
  `stddev_values` double,
  `num_values` bigint(20),
  `num_unique` bigint(20),
  `max_values` double,
  `min_values` double
) */;

--
-- Table structure for table `project_assets`
--

DROP TABLE IF EXISTS `project_assets`;
CREATE TABLE `project_assets` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `title` varchar(255) default NULL,
  `parent_id` int(11) default NULL,
  `content_type` varchar(255) default NULL,
  `filename` varchar(255) default NULL,
  `thumbnail` varchar(255) default NULL,
  `size` int(11) default NULL,
  `width` int(11) default NULL,
  `height` int(11) default NULL,
  `thumbnails_count` int(11) default '0',
  `published` tinyint(1) default '0',
  `content_hash` varchar(255) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  `caption` mediumtext,
  `db_file_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_assets`
--

LOCK TABLES `project_assets` WRITE;
/*!40000 ALTER TABLE `project_assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_contents`
--

DROP TABLE IF EXISTS `project_contents`;
CREATE TABLE `project_contents` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) NOT NULL,
  `type` varchar(20) default NULL,
  `name` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  `body` longtext,
  `body_html` longtext,
  `author_ip` varchar(100) default NULL,
  `comments_count` int(11) default '0',
  `comment_age` int(11) default '0',
  `published` tinyint(1) default '0',
  `content_hash` varchar(255) default NULL,
  `lock_timeout` datetime default NULL,
  `lock_user_id` int(11) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  `left_limit` int(11) default NULL,
  `right_limit` int(11) default NULL,
  `parent_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_contents`
--

LOCK TABLES `project_contents` WRITE;
/*!40000 ALTER TABLE `project_contents` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_elements`
--

DROP TABLE IF EXISTS `project_elements`;
CREATE TABLE `project_elements` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) default NULL,
  `project_id` int(11) NOT NULL,
  `type` varchar(32) default 'ProjectElement',
  `position` int(11) default '1',
  `name` varchar(64) NOT NULL,
  `reference_id` int(11) default NULL,
  `reference_type` varchar(20) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  `asset_id` int(11) default NULL,
  `content_id` int(11) default NULL,
  `published_hash` varchar(255) default NULL,
  `project_elements_count` int(11) NOT NULL default '0',
  `left_limit` int(11) NOT NULL default '0',
  `right_limit` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `parent_id` (`name`,`parent_id`),
  KEY `project_id` (`project_id`),
  KEY `left_limit` (`left_limit`,`project_id`),
  KEY `right_limit` (`right_limit`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_elements`
--

LOCK TABLES `project_elements` WRITE;
/*!40000 ALTER TABLE `project_elements` DISABLE KEYS */;
INSERT INTO `project_elements` VALUES (1,NULL,13,'ProjectFolder',1,'Demo',NULL,NULL,0,'2007-07-02 14:48:29','2007-07-02 14:48:29',3,3,NULL,NULL,NULL,0,0,0);
/*!40000 ALTER TABLE `project_elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(30) NOT NULL default '',
  `summary` text NOT NULL,
  `status_id` int(11) NOT NULL default '0',
  `title` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `host` varchar(255) default NULL,
  `comment_age` int(11) default NULL,
  `timezone` varchar(255) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `started_at` datetime default NULL,
  `ended_at` datetime default NULL,
  `expected_at` datetime default NULL,
  `done_hours` float default NULL,
  `expected_hours` float default NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'global','Public Area for open work everyone allowed to see!',0,'Global',NULL,NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00',NULL,NULL,NULL,NULL,NULL,1,1),(13,'Demo','This is a demo production for training and playing',0,NULL,NULL,NULL,NULL,NULL,'2007-06-06 22:06:30','2007-06-06 22:06:30',NULL,NULL,NULL,NULL,NULL,3,3);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `protocol_versions`
--

DROP TABLE IF EXISTS `protocol_versions`;
CREATE TABLE `protocol_versions` (
  `id` int(11) NOT NULL auto_increment,
  `study_protocol_id` int(11) default NULL,
  `name` varchar(77) default NULL,
  `version` int(6) NOT NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` time default NULL,
  `updated_at` time default NULL,
  `how_to` text,
  `report_id` int(11) default NULL,
  `analysis_id` int(11) default NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `process_instances_name_index` (`name`),
  KEY `process_instances_process_definition_id_index` (`study_protocol_id`),
  KEY `process_instances_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `protocol_versions`
--

LOCK TABLES `protocol_versions` WRITE;
/*!40000 ALTER TABLE `protocol_versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `protocol_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue_items`
--

DROP TABLE IF EXISTS `queue_items`;
CREATE TABLE `queue_items` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `comments` text,
  `study_queue_id` int(11) default NULL,
  `experiment_id` int(11) default NULL,
  `task_id` int(11) default NULL,
  `study_parameter_id` int(11) default NULL,
  `data_type` varchar(255) default NULL,
  `data_id` int(11) default NULL,
  `data_name` varchar(255) default NULL,
  `expected_at` datetime default NULL,
  `started_at` datetime default NULL,
  `ended_at` datetime default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `request_service_id` int(11) default NULL,
  `status_id` int(11) NOT NULL default '0',
  `priority_id` int(11) default NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  `requested_by_user_id` int(11) default '1',
  `assigned_to_user_id` int(11) default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `queue_items`
--

LOCK TABLES `queue_items` WRITE;
/*!40000 ALTER TABLE `queue_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `queue_results`
--

DROP TABLE IF EXISTS `queue_results`;
/*!50001 DROP VIEW IF EXISTS `queue_results`*/;
/*!50001 CREATE TABLE `queue_results` (
  `id` int(11),
  `row_no` int(11),
  `column_no` int(11),
  `task_id` int(11),
  `queue_item_id` int(11),
  `request_service_id` int(11),
  `study_queue_id` int(11),
  `requested_by_user_id` int(11),
  `assigned_to_user_id` int(11),
  `parameter_context_id` int(11),
  `task_context_id` int(11),
  `reference_parameter_id` int(11),
  `data_element_id` int(11),
  `data_type` varchar(255),
  `data_id` int(11),
  `subject` varchar(255),
  `parameter_id` int(11),
  `protocol_version_id` int(11),
  `label` varchar(255),
  `row_label` varchar(255),
  `parameter_name` varchar(62),
  `data_value` blob,
  `created_by_user_id` int(11),
  `created_at` datetime,
  `updated_by_user_id` int(11),
  `updated_at` datetime
) */;

--
-- Table structure for table `report_columns`
--

DROP TABLE IF EXISTS `report_columns`;
CREATE TABLE `report_columns` (
  `id` int(11) NOT NULL auto_increment,
  `report_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `join_model` varchar(255) default NULL,
  `label` varchar(255) default NULL,
  `action` varchar(255) default NULL,
  `filter_operation` varchar(255) default NULL,
  `filter_text` varchar(255) default NULL,
  `subject_type` varchar(255) default NULL,
  `subject_id` int(11) default NULL,
  `data_element` int(11) default NULL,
  `is_visible` tinyint(1) default '1',
  `is_filterible` tinyint(1) default '1',
  `is_sortable` tinyint(1) default '1',
  `order_num` int(11) default NULL,
  `sort_num` int(11) default NULL,
  `sort_direction` varchar(11) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `join_name` varchar(255) default NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `report_columns`
--

LOCK TABLES `report_columns` WRITE;
/*!40000 ALTER TABLE `report_columns` DISABLE KEYS */;
INSERT INTO `report_columns` VALUES (3,3,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,1,0,NULL,'',2,'2007-04-24 14:52:53','2007-04-24 14:58:56',NULL,3,3),(7,3,'description',NULL,NULL,'Description',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,1,1,NULL,'',2,'2007-04-24 14:58:32','2007-04-24 14:58:56',NULL,3,3),(8,3,'base_model',NULL,NULL,'Base_model',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,1,2,NULL,'',2,'2007-04-24 14:58:36','2007-04-24 14:58:56',NULL,3,3),(9,3,'created_by_user.name',NULL,'created_by_user','Created_by',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,1,3,NULL,'',2,'2007-04-24 14:58:48','2007-04-24 14:58:56','belongs_to',3,3),(10,2,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,1,'2007-04-24 17:27:51','2007-04-24 17:27:51',NULL,3,3),(11,2,'description',NULL,NULL,'Description',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,1,'2007-04-24 17:27:53','2007-04-24 17:27:53',NULL,3,3),(12,2,'base_model',NULL,NULL,'Base_model',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,4,NULL,NULL,1,'2007-04-24 17:27:56','2007-04-24 17:27:56',NULL,3,3),(15,5,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,0,'2007-04-24 20:45:49','2007-04-24 20:45:49',NULL,3,3),(16,5,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,0,'2007-04-24 21:27:06','2007-04-24 21:27:06',NULL,1,1),(17,5,'description',NULL,NULL,'Description',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,0,'2007-04-24 21:27:06','2007-04-24 21:27:06',NULL,1,1),(18,5,'research_area',NULL,NULL,'Research_area',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,0,'2007-04-24 21:27:06','2007-04-24 21:27:06',NULL,1,1),(19,5,'purpose',NULL,NULL,'Purpose',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,4,NULL,NULL,0,'2007-04-24 21:27:06','2007-04-24 21:27:06',NULL,1,1),(20,5,'lock_version',NULL,NULL,'Lock_version',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,5,NULL,NULL,0,'2007-04-24 21:27:06','2007-04-24 21:27:06',NULL,1,1),(21,5,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,6,NULL,NULL,0,'2007-04-24 21:27:06','2007-04-24 21:27:06',NULL,1,1),(22,5,'updated_at',NULL,NULL,'Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,7,NULL,NULL,0,'2007-04-24 21:27:06','2007-04-24 21:27:06',NULL,1,1),(99,15,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,0,'2007-04-26 21:03:12','2007-04-26 21:03:12',NULL,3,3),(100,15,'description',NULL,NULL,'Description',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,0,'2007-04-26 21:03:12','2007-04-26 21:03:12',NULL,3,3),(101,15,'research_area',NULL,NULL,'Research_area',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,0,'2007-04-26 21:03:12','2007-04-26 21:03:12',NULL,3,3),(102,15,'purpose',NULL,NULL,'Purpose',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,0,'2007-04-26 21:03:12','2007-04-26 21:03:12',NULL,3,3),(103,15,'lock_version',NULL,NULL,'Lock_version',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,4,NULL,NULL,0,'2007-04-26 21:03:12','2007-04-26 21:03:12',NULL,3,3),(104,15,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,5,NULL,NULL,0,'2007-04-26 21:03:13','2007-04-26 21:03:13',NULL,3,3),(105,15,'updated_at',NULL,NULL,'Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,6,NULL,NULL,0,'2007-04-26 21:03:13','2007-04-26 21:03:13',NULL,3,3),(106,15,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,7,NULL,NULL,0,'2007-04-26 21:03:13','2007-04-26 21:03:13',NULL,3,3),(107,15,'project_id',NULL,NULL,'Project_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,8,NULL,NULL,0,'2007-04-26 21:03:13','2007-04-26 21:03:13',NULL,3,3),(108,16,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,0,'2007-04-26 21:03:52','2007-04-26 21:03:52',NULL,3,3),(109,16,'description',NULL,NULL,'Description',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,0,'2007-04-26 21:03:52','2007-04-26 21:03:52',NULL,3,3),(110,16,'research_area',NULL,NULL,'Research_area',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,0,'2007-04-26 21:03:52','2007-04-26 21:03:52',NULL,3,3),(111,16,'purpose',NULL,NULL,'Purpose',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,0,'2007-04-26 21:03:52','2007-04-26 21:03:52',NULL,3,3),(112,16,'lock_version',NULL,NULL,'Lock_version',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,4,NULL,NULL,0,'2007-04-26 21:03:52','2007-04-26 21:03:52',NULL,3,3),(113,16,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,5,NULL,NULL,0,'2007-04-26 21:03:52','2007-04-26 21:03:52',NULL,3,3),(114,16,'updated_at',NULL,NULL,'Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,6,NULL,NULL,0,'2007-04-26 21:03:52','2007-04-26 21:03:52',NULL,3,3),(115,16,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,7,NULL,NULL,0,'2007-04-26 21:03:52','2007-04-26 21:03:52',NULL,3,3),(116,16,'project_id',NULL,NULL,'Project_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,8,NULL,NULL,0,'2007-04-26 21:03:52','2007-04-26 21:03:52',NULL,3,3),(117,17,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,0,NULL,'',2,'2007-04-26 21:05:42','2007-04-26 21:08:09',NULL,3,3),(118,17,'description',NULL,NULL,'Description',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,1,1,NULL,'',2,'2007-04-26 21:05:42','2007-04-26 21:08:10',NULL,3,3),(119,17,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,2,NULL,'',2,'2007-04-26 21:05:42','2007-04-26 21:08:09',NULL,3,3),(120,17,'project_id',NULL,NULL,'Project_id',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,3,NULL,'',2,'2007-04-26 21:05:42','2007-04-26 21:08:09',NULL,3,3),(121,17,'created_by_user.name',NULL,'created_by_user','Created_by',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,5,NULL,'',3,'2007-04-26 21:06:30','2007-04-26 21:08:10','belongs_to',3,3),(122,17,'study.name',NULL,'study','Study',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,4,NULL,'',3,'2007-04-26 21:06:51','2007-04-26 21:08:10','belongs_to',3,3),(123,18,'column_no',NULL,NULL,'Column_no',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,0,'2007-04-30 15:09:18','2007-04-30 15:09:18',NULL,3,3),(124,18,'sequence_num',NULL,NULL,'Sequence_num',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,0,'2007-04-30 15:09:18','2007-04-30 15:09:18',NULL,3,3),(125,18,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,3,'2007-04-30 15:09:18','2007-05-01 11:52:20',NULL,3,3),(126,18,'description',NULL,NULL,'Description',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,0,'2007-04-30 15:09:18','2007-04-30 15:09:18',NULL,3,3),(127,18,'display_unit',NULL,NULL,'Display_unit',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,4,NULL,NULL,0,'2007-04-30 15:09:18','2007-04-30 15:09:18',NULL,3,3),(128,18,'qualifier_style',NULL,NULL,'Qualifier_style',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,5,NULL,NULL,0,'2007-04-30 15:09:18','2007-04-30 15:09:18',NULL,3,3),(129,18,'lock_version',NULL,NULL,'Lock_version',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,6,NULL,NULL,0,'2007-04-30 15:09:18','2007-04-30 15:09:18',NULL,3,3),(130,18,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,7,NULL,NULL,0,'2007-04-30 15:09:18','2007-04-30 15:09:18',NULL,3,3),(131,18,'updated_at',NULL,NULL,'Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,8,NULL,NULL,0,'2007-04-30 15:09:18','2007-04-30 15:09:18',NULL,3,3),(132,18,'mandatory',NULL,NULL,'Mandatory',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,9,NULL,NULL,0,'2007-04-30 15:09:18','2007-04-30 15:09:18',NULL,3,3),(133,18,'default_value',NULL,NULL,'Default_value',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,10,NULL,NULL,0,'2007-04-30 15:09:18','2007-04-30 15:09:18',NULL,3,3),(134,18,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,11,NULL,NULL,0,'2007-04-30 15:09:18','2007-04-30 15:09:18',NULL,3,3),(135,18,'study_parameter_id',NULL,NULL,'Study_parameter_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,12,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(136,18,'process.name',NULL,'process','Process Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,13,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19','belongs_to',3,3),(137,19,'avg_values',NULL,NULL,'Avg_values',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(138,19,'stddev_values',NULL,NULL,'Stddev_values',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(139,19,'num_values',NULL,NULL,'Num_values',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(140,19,'num_unique',NULL,NULL,'Num_unique',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(141,19,'max_values',NULL,NULL,'Max_values',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,4,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(142,19,'min_values',NULL,NULL,'Min_values',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,5,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(143,19,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,6,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(144,19,'study_parameter_id',NULL,NULL,'Study_parameter_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,7,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(145,20,'avg_values',NULL,NULL,'Avg_values',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(146,20,'stddev_values',NULL,NULL,'Stddev_values',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(147,20,'num_values',NULL,NULL,'Num_values',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(148,20,'num_unique',NULL,NULL,'Num_unique',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(149,20,'max_values',NULL,NULL,'Max_values',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,4,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(150,20,'min_values',NULL,NULL,'Min_values',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,5,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(151,20,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,6,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(152,20,'study_parameter_id',NULL,NULL,'Study_parameter_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,7,NULL,NULL,0,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3),(153,21,'compound_name',NULL,NULL,'Compound_name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,1,'2007-05-01 00:00:42','2007-05-01 00:00:42',NULL,3,3),(154,22,'data_value',NULL,NULL,'Data_value',NULL,'=','Activity',NULL,NULL,NULL,1,1,1,0,NULL,'',3,'2007-05-01 00:02:35','2007-05-01 09:06:07',NULL,3,3),(156,24,'row_no',NULL,NULL,'Row_no',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,0,NULL,'',4,'2007-05-01 07:11:56','2007-05-01 09:11:26',NULL,3,3),(158,22,'context.label',NULL,'context','Context Label',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,1,NULL,'',4,'2007-05-01 09:05:04','2007-05-01 09:06:07','belongs_to',3,3),(159,24,'column_no',NULL,NULL,'Column_no',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,1,NULL,'',5,'2007-05-01 09:09:16','2007-05-01 09:11:26',NULL,3,3),(160,2,'project_id',NULL,NULL,'Project_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,3,NULL,NULL,0,'2007-05-18 19:59:53','2007-05-18 19:59:53',NULL,3,3),(161,2,'style',NULL,NULL,'Style',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,4,NULL,NULL,0,'2007-05-18 19:59:53','2007-05-18 19:59:53',NULL,3,3),(162,2,'custom_sql',NULL,NULL,'Custom_sql',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,5,NULL,NULL,0,'2007-05-18 19:59:53','2007-05-18 19:59:53',NULL,3,3),(168,26,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,0,1,'desc',22,'2007-05-23 06:31:50','2007-05-30 15:45:05',NULL,8,3),(169,26,'description',NULL,NULL,'Description',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,1,NULL,NULL,22,'2007-05-23 06:32:01','2007-05-30 15:45:05',NULL,8,3),(170,27,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,1,'2007-05-25 18:07:53','2007-05-25 18:07:53',NULL,3,3),(171,27,'description',NULL,NULL,'Description',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,1,'2007-05-25 18:07:55','2007-05-25 18:07:55',NULL,3,3),(172,27,'class_name',NULL,NULL,'Class_name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,1,'2007-05-25 18:07:58','2007-05-25 18:07:58',NULL,3,3),(173,27,'lock_version',NULL,NULL,'Lock_version',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,3,NULL,NULL,1,'2007-05-25 18:08:00','2007-05-25 18:08:00',NULL,3,3),(174,27,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,4,NULL,NULL,1,'2007-05-25 18:08:02','2007-05-25 18:08:02',NULL,3,3),(175,27,'updated_at',NULL,NULL,'Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,5,NULL,NULL,1,'2007-05-25 18:08:03','2007-05-25 18:08:03',NULL,3,3),(176,27,'settings.name',NULL,'settings','Settings Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,6,NULL,NULL,1,'2007-05-25 18:08:08','2007-05-25 18:08:08','has_many',3,3),(177,27,'settings.script_body',NULL,'settings','Settings Script_body',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,7,NULL,NULL,1,'2007-05-25 18:08:10','2007-05-25 18:08:10','has_many',3,3),(178,27,'settings.options',NULL,'settings','Settings Options',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,8,NULL,NULL,1,'2007-05-25 18:08:11','2007-05-25 18:08:11','has_many',3,3),(179,27,'settings.level_no',NULL,'settings','Settings Level_no',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,9,NULL,NULL,1,'2007-05-25 18:08:12','2007-05-25 18:08:12','has_many',3,3),(180,27,'settings.mode',NULL,'settings','Settings Mode',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,10,NULL,NULL,1,'2007-05-25 18:08:14','2007-05-25 18:08:14','has_many',3,3),(181,27,'settings.column_no',NULL,'settings','Settings Column_no',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,11,NULL,NULL,1,'2007-05-25 18:08:15','2007-05-25 18:08:15','has_many',3,3),(182,27,'settings.mandatory',NULL,'settings','Settings Mandatory',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,12,NULL,NULL,1,'2007-05-25 18:08:17','2007-05-25 18:08:17','has_many',3,3),(183,27,'settings.default_value',NULL,'settings','Settings Default_value',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,13,NULL,NULL,1,'2007-05-25 18:08:18','2007-05-25 18:08:18','has_many',3,3),(184,27,'settings.created_at',NULL,'settings','Settings Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,14,NULL,NULL,1,'2007-05-25 18:08:20','2007-05-25 18:08:20','has_many',3,3),(185,27,'settings.updated_at',NULL,'settings','Settings Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,15,NULL,NULL,1,'2007-05-25 18:08:22','2007-05-25 18:08:22','has_many',3,3),(186,27,'settings.type.name',NULL,'settings','Settings Type Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,16,NULL,NULL,1,'2007-05-25 18:08:30','2007-05-25 18:08:30','has_many',3,3),(187,27,'settings.type.description',NULL,'settings','Settings Type Description',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,17,NULL,NULL,1,'2007-05-25 18:08:31','2007-05-25 18:08:31','has_many',3,3),(188,27,'settings.type.value_class',NULL,'settings','Settings Type Value_class',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,18,NULL,NULL,1,'2007-05-25 18:08:33','2007-05-25 18:08:33','has_many',3,3),(189,27,'settings.type.lock_version',NULL,'settings','Settings Type Lock_version',NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,19,NULL,NULL,1,'2007-05-25 18:08:34','2007-05-25 18:08:34','has_many',3,3),(190,27,'settings.type.created_at',NULL,'settings','Settings Type Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,20,NULL,NULL,1,'2007-05-25 18:08:36','2007-05-25 18:08:36','has_many',3,3),(191,27,'settings.type.updated_at',NULL,'settings','Settings Type Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,21,NULL,NULL,1,'2007-05-25 18:08:37','2007-05-25 18:08:37','has_many',3,3),(192,27,'settings.parameter.sequence_num',NULL,'settings','Settings Parameter Sequence_num',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,22,NULL,NULL,1,'2007-05-25 18:08:39','2007-05-25 18:08:39','has_many',3,3),(193,27,'settings.parameter.column_no',NULL,'settings','Settings Parameter Column_no',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,23,NULL,NULL,1,'2007-05-25 18:08:40','2007-05-25 18:08:41','has_many',3,3),(194,27,'settings.parameter.name',NULL,'settings','Settings Parameter Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,24,NULL,NULL,1,'2007-05-25 18:08:42','2007-05-25 18:08:42','has_many',3,3),(195,27,'settings.parameter.description',NULL,'settings','Settings Parameter Description',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,25,NULL,NULL,1,'2007-05-25 18:08:44','2007-05-25 18:08:44','has_many',3,3),(196,27,'settings.parameter.display_unit',NULL,'settings','Settings Parameter Display_unit',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,26,NULL,NULL,1,'2007-05-25 18:08:45','2007-05-25 18:08:45','has_many',3,3),(197,27,'settings.parameter.qualifier_style',NULL,'settings','Settings Parameter Qualifier_style',NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,27,NULL,NULL,1,'2007-05-25 18:08:47','2007-05-25 18:08:47','has_many',3,3),(202,29,'owner',NULL,NULL,'Owner',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,0,'2007-05-28 17:38:47','2007-05-28 17:38:47',NULL,3,3),(203,29,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,1,NULL,NULL,0,'2007-05-28 17:38:48','2007-05-28 17:38:48',NULL,3,3),(204,29,'updated_at',NULL,NULL,'Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,2,NULL,NULL,0,'2007-05-28 17:38:48','2007-05-28 17:38:48',NULL,3,3),(205,29,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,0,'2007-05-28 17:38:48','2007-05-28 17:38:48',NULL,3,3),(206,29,'user_id',NULL,NULL,'User_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,4,NULL,NULL,0,'2007-05-28 17:38:48','2007-05-28 17:38:48',NULL,3,3),(207,29,'project.project_id',NULL,'project','Project Project_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,5,NULL,NULL,0,'2007-05-28 17:38:48','2007-05-28 17:38:48','belongs_to',3,3),(208,29,'project.name',NULL,'project','Project Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,6,NULL,NULL,0,'2007-05-28 17:38:48','2007-05-28 17:38:48','belongs_to',3,3),(209,29,'project.summary',NULL,'project','Project Summary',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,7,NULL,NULL,0,'2007-05-28 17:38:48','2007-05-28 17:38:48','belongs_to',3,3),(210,29,'role.name',NULL,'role','Role Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,8,NULL,NULL,0,'2007-05-28 17:38:48','2007-05-28 17:38:48','belongs_to',3,3),(226,31,'position',NULL,NULL,'Position',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,0,'2007-05-28 17:49:04','2007-05-28 17:49:04',NULL,3,3),(227,31,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,0,'2007-05-28 17:49:04','2007-05-28 17:49:04',NULL,3,3),(228,31,'path',NULL,NULL,'Path',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,0,'2007-05-28 17:49:04','2007-05-28 17:49:04',NULL,3,3),(229,31,'reference_type',NULL,NULL,'Reference_type',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,0,'2007-05-28 17:49:04','2007-05-28 17:49:04',NULL,3,3),(230,31,'lock_version',NULL,NULL,'Lock_version',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,4,NULL,NULL,0,'2007-05-28 17:49:04','2007-05-28 17:49:04',NULL,3,3),(231,31,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,5,NULL,NULL,0,'2007-05-28 17:49:04','2007-05-28 17:49:04',NULL,3,3),(232,31,'updated_at',NULL,NULL,'Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,6,NULL,NULL,0,'2007-05-28 17:49:04','2007-05-28 17:49:04',NULL,3,3),(233,31,'published_hash',NULL,NULL,'Published_hash',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,7,NULL,NULL,0,'2007-05-28 17:49:04','2007-05-28 17:49:04',NULL,3,3),(234,31,'left_limit',NULL,NULL,'Left_limit',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,8,NULL,NULL,0,'2007-05-28 17:49:04','2007-05-28 17:49:04',NULL,3,3),(235,31,'right_limit',NULL,NULL,'Right_limit',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,9,NULL,NULL,0,'2007-05-28 17:49:05','2007-05-28 17:49:05',NULL,3,3),(236,31,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,10,NULL,NULL,0,'2007-05-28 17:49:05','2007-05-28 17:49:05',NULL,3,3),(237,31,'updated_by_user_id',NULL,NULL,'Updated_by_user_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,11,NULL,NULL,0,'2007-05-28 17:49:05','2007-05-28 17:49:05',NULL,3,3),(238,31,'project_id',NULL,NULL,'Project_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,12,NULL,NULL,0,'2007-05-28 17:49:05','2007-05-28 17:49:05',NULL,3,3),(239,31,'project.name',NULL,'project','Project Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,13,NULL,NULL,0,'2007-05-28 17:49:05','2007-05-28 17:49:05','belongs_to',3,3),(240,31,'icon',NULL,NULL,'Icon',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,14,NULL,NULL,0,'2007-05-28 17:49:05','2007-05-28 17:49:05',NULL,3,3),(241,32,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,0,'2007-05-28 18:00:29','2007-05-28 18:00:29',NULL,3,3),(242,32,'comments',NULL,NULL,'Comments',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,0,'2007-05-28 18:00:29','2007-05-28 18:00:29',NULL,3,3),(243,32,'data_type',NULL,NULL,'Data_type',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,0,'2007-05-28 18:00:30','2007-05-28 18:00:30',NULL,3,3),(244,32,'data_name',NULL,NULL,'Data_name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,0,'2007-05-28 18:00:30','2007-05-28 18:00:30',NULL,3,3),(245,32,'expected_at',NULL,NULL,'Expected_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,4,NULL,NULL,0,'2007-05-28 18:00:30','2007-05-28 18:00:30',NULL,3,3),(246,32,'started_at',NULL,NULL,'Started_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,5,NULL,NULL,0,'2007-05-28 18:00:30','2007-05-28 18:00:30',NULL,3,3),(247,32,'ended_at',NULL,NULL,'Ended_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,6,NULL,NULL,0,'2007-05-28 18:00:30','2007-05-28 18:00:30',NULL,3,3),(248,32,'lock_version',NULL,NULL,'Lock_version',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,7,NULL,NULL,0,'2007-05-28 18:00:30','2007-05-28 18:00:30',NULL,3,3),(249,32,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,8,NULL,NULL,0,'2007-05-28 18:00:30','2007-05-28 18:00:30',NULL,3,3),(250,32,'updated_at',NULL,NULL,'Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,9,NULL,NULL,0,'2007-05-28 18:00:30','2007-05-28 18:00:30',NULL,3,3),(251,32,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,10,NULL,NULL,0,'2007-05-28 18:00:30','2007-05-28 18:00:30',NULL,3,3),(252,32,'assigned_to_user_id',NULL,NULL,'Assigned_to_user_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,11,NULL,NULL,0,'2007-05-28 18:00:30','2007-05-28 18:00:30',NULL,3,3),(253,33,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,0,'2007-05-28 18:00:47','2007-05-28 18:00:47',NULL,3,3),(254,33,'comments',NULL,NULL,'Comments',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,0,'2007-05-28 18:00:47','2007-05-28 18:00:47',NULL,3,3),(255,33,'data_type',NULL,NULL,'Data_type',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,0,'2007-05-28 18:00:47','2007-05-28 18:00:47',NULL,3,3),(256,33,'data_name',NULL,NULL,'Data_name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,0,'2007-05-28 18:00:47','2007-05-28 18:00:47',NULL,3,3),(257,33,'expected_at',NULL,NULL,'Expected_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,4,NULL,NULL,0,'2007-05-28 18:00:47','2007-05-28 18:00:47',NULL,3,3),(258,33,'started_at',NULL,NULL,'Started_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,5,NULL,NULL,0,'2007-05-28 18:00:47','2007-05-28 18:00:47',NULL,3,3),(259,33,'ended_at',NULL,NULL,'Ended_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,6,NULL,NULL,0,'2007-05-28 18:00:47','2007-05-28 18:00:47',NULL,3,3),(260,33,'lock_version',NULL,NULL,'Lock_version',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,7,NULL,NULL,0,'2007-05-28 18:00:47','2007-05-28 18:00:47',NULL,3,3),(261,33,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,8,NULL,NULL,0,'2007-05-28 18:00:47','2007-05-28 18:00:47',NULL,3,3),(262,33,'updated_at',NULL,NULL,'Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,9,NULL,NULL,0,'2007-05-28 18:00:47','2007-05-28 18:00:47',NULL,3,3),(263,33,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,10,NULL,NULL,0,'2007-05-28 18:00:47','2007-05-28 18:00:47',NULL,3,3),(264,33,'requested_by_user_id',NULL,NULL,'Requested_by_user_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,11,NULL,NULL,0,'2007-05-28 18:00:47','2007-05-28 18:00:47',NULL,3,3),(265,34,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,0,'2007-05-28 18:11:30','2007-05-28 18:11:30',NULL,3,3),(266,34,'comments',NULL,NULL,'Comments',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,0,'2007-05-28 18:11:30','2007-05-28 18:11:30',NULL,3,3),(267,34,'data_type',NULL,NULL,'Data_type',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,0,'2007-05-28 18:11:30','2007-05-28 18:11:30',NULL,3,3),(268,34,'data_name',NULL,NULL,'Data_name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,0,'2007-05-28 18:11:30','2007-05-28 18:11:30',NULL,3,3),(269,34,'expected_at',NULL,NULL,'Expected_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,4,NULL,NULL,0,'2007-05-28 18:11:31','2007-05-28 18:11:31',NULL,3,3),(270,34,'started_at',NULL,NULL,'Started_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,5,NULL,NULL,0,'2007-05-28 18:11:31','2007-05-28 18:11:31',NULL,3,3),(271,34,'ended_at',NULL,NULL,'Ended_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,6,NULL,NULL,0,'2007-05-28 18:11:31','2007-05-28 18:11:31',NULL,3,3),(272,34,'lock_version',NULL,NULL,'Lock_version',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,7,NULL,NULL,0,'2007-05-28 18:11:31','2007-05-28 18:11:31',NULL,3,3),(273,34,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,8,NULL,NULL,0,'2007-05-28 18:11:31','2007-05-28 18:11:31',NULL,3,3),(274,34,'updated_at',NULL,NULL,'Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,9,NULL,NULL,0,'2007-05-28 18:11:31','2007-05-28 18:11:31',NULL,3,3),(275,34,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,10,NULL,NULL,0,'2007-05-28 18:11:31','2007-05-28 18:11:31',NULL,3,3),(276,34,'assigned_to_user_id',NULL,NULL,'Assigned_to_user_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,11,NULL,NULL,0,'2007-05-28 18:11:31','2007-05-28 18:11:31',NULL,3,3),(277,35,'position',NULL,NULL,'Position',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,0,'2007-05-28 18:11:58','2007-05-28 18:11:58',NULL,3,3),(278,35,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,0,'2007-05-28 18:11:58','2007-05-28 18:11:58',NULL,3,3),(279,35,'path',NULL,NULL,'Path',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,0,'2007-05-28 18:11:58','2007-05-28 18:11:58',NULL,3,3),(280,35,'reference_type',NULL,NULL,'Reference_type',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,0,'2007-05-28 18:11:58','2007-05-28 18:11:58',NULL,3,3),(281,35,'lock_version',NULL,NULL,'Lock_version',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,4,NULL,NULL,0,'2007-05-28 18:11:58','2007-05-28 18:11:58',NULL,3,3),(282,35,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,5,NULL,NULL,0,'2007-05-28 18:11:58','2007-05-28 18:11:58',NULL,3,3),(283,35,'updated_at',NULL,NULL,'Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,6,NULL,NULL,0,'2007-05-28 18:11:58','2007-05-28 18:11:58',NULL,3,3),(284,35,'published_hash',NULL,NULL,'Published_hash',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,7,NULL,NULL,0,'2007-05-28 18:11:58','2007-05-28 18:11:58',NULL,3,3),(285,35,'left_limit',NULL,NULL,'Left_limit',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,8,NULL,NULL,0,'2007-05-28 18:11:58','2007-05-28 18:11:58',NULL,3,3),(286,35,'right_limit',NULL,NULL,'Right_limit',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,9,NULL,NULL,0,'2007-05-28 18:11:58','2007-05-28 18:11:58',NULL,3,3),(287,35,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,10,NULL,NULL,0,'2007-05-28 18:11:58','2007-05-28 18:11:58',NULL,3,3),(288,35,'updated_by_user_id',NULL,NULL,'Updated_by_user_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,11,NULL,NULL,0,'2007-05-28 18:11:58','2007-05-28 18:11:58',NULL,3,3),(289,35,'project_id',NULL,NULL,'Project_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,12,NULL,NULL,0,'2007-05-28 18:11:58','2007-05-28 18:11:58',NULL,3,3),(290,35,'project.name',NULL,'project','Project Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,13,NULL,NULL,0,'2007-05-28 18:11:58','2007-05-28 18:11:58','belongs_to',3,3),(291,35,'summary',NULL,NULL,'Summary',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,14,NULL,NULL,0,'2007-05-28 18:11:58','2007-05-28 18:11:58',NULL,3,3),(292,36,'position',NULL,NULL,'Position',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,0,'2007-05-28 18:15:06','2007-05-28 18:15:06',NULL,3,3),(293,36,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,0,'2007-05-28 18:15:06','2007-05-28 18:15:06',NULL,3,3),(294,36,'path',NULL,NULL,'Path',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,0,'2007-05-28 18:15:06','2007-05-28 18:15:06',NULL,3,3),(295,36,'reference_type',NULL,NULL,'Reference_type',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,0,'2007-05-28 18:15:06','2007-05-28 18:15:06',NULL,3,3),(296,36,'lock_version',NULL,NULL,'Lock_version',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,4,NULL,NULL,0,'2007-05-28 18:15:06','2007-05-28 18:15:06',NULL,3,3),(297,36,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,5,NULL,NULL,0,'2007-05-28 18:15:06','2007-05-28 18:15:06',NULL,3,3),(298,36,'updated_at',NULL,NULL,'Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,6,NULL,NULL,0,'2007-05-28 18:15:06','2007-05-28 18:15:06',NULL,3,3),(299,36,'published_hash',NULL,NULL,'Published_hash',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,7,NULL,NULL,0,'2007-05-28 18:15:06','2007-05-28 18:15:06',NULL,3,3),(300,36,'left_limit',NULL,NULL,'Left_limit',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,8,NULL,NULL,0,'2007-05-28 18:15:06','2007-05-28 18:15:06',NULL,3,3),(301,36,'right_limit',NULL,NULL,'Right_limit',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,9,NULL,NULL,0,'2007-05-28 18:15:06','2007-05-28 18:15:06',NULL,3,3),(302,36,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,10,NULL,NULL,0,'2007-05-28 18:15:06','2007-05-28 18:15:06',NULL,3,3),(303,36,'updated_by_user_id',NULL,NULL,'Updated_by_user_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,11,NULL,NULL,0,'2007-05-28 18:15:06','2007-05-28 18:15:06',NULL,3,3),(304,36,'project_id',NULL,NULL,'Project_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,12,NULL,NULL,0,'2007-05-28 18:15:06','2007-05-28 18:15:06',NULL,3,3),(305,36,'project.name',NULL,'project','Project Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,13,NULL,NULL,0,'2007-05-28 18:15:07','2007-05-28 18:15:07','belongs_to',3,3),(306,36,'summary',NULL,NULL,'Summary',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,14,NULL,NULL,0,'2007-05-28 18:15:07','2007-05-28 18:15:07',NULL,3,3),(307,37,'owner',NULL,NULL,'Owner',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,0,'2007-05-28 18:18:21','2007-05-28 18:18:21',NULL,3,3),(308,37,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,1,NULL,NULL,0,'2007-05-28 18:18:21','2007-05-28 18:18:21',NULL,3,3),(309,37,'updated_at',NULL,NULL,'Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,2,NULL,NULL,0,'2007-05-28 18:18:21','2007-05-28 18:18:21',NULL,3,3),(310,37,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,0,'2007-05-28 18:18:21','2007-05-28 18:18:21',NULL,3,3),(311,37,'user_id',NULL,NULL,'User_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,4,NULL,NULL,0,'2007-05-28 18:18:21','2007-05-28 18:18:21',NULL,3,3),(312,37,'project.project_id',NULL,'project','Project Project_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,5,NULL,NULL,0,'2007-05-28 18:18:21','2007-05-28 18:18:21','belongs_to',3,3),(313,37,'project.name',NULL,'project','Project Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,6,NULL,NULL,0,'2007-05-28 18:18:21','2007-05-28 18:18:21','belongs_to',3,3),(314,37,'project.summary',NULL,'project','Project Summary',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,7,NULL,NULL,0,'2007-05-28 18:18:21','2007-05-28 18:18:21','belongs_to',3,3),(315,37,'role.name',NULL,'role','Role Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,8,NULL,NULL,0,'2007-05-28 18:18:21','2007-05-28 18:18:21','belongs_to',3,3),(316,38,'row_no',NULL,NULL,'Row_no',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,0,'2007-05-29 11:34:17','2007-05-29 11:34:17',NULL,3,3),(317,38,'column_no',NULL,NULL,'Column_no',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,0,'2007-05-29 11:34:17','2007-05-29 11:34:17',NULL,3,3),(318,38,'data_type',NULL,NULL,'Data_type',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,0,'2007-05-29 11:34:17','2007-05-29 11:34:17',NULL,3,3),(319,38,'subject',NULL,NULL,'Subject',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,0,'2007-05-29 11:34:17','2007-05-29 11:34:17',NULL,3,3),(320,38,'label',NULL,NULL,'Label',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,4,NULL,NULL,0,'2007-05-29 11:34:17','2007-05-29 11:34:17',NULL,3,3),(321,38,'row_label',NULL,NULL,'Row_label',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,5,NULL,NULL,0,'2007-05-29 11:34:17','2007-05-29 11:34:17',NULL,3,3),(322,38,'parameter_name',NULL,NULL,'Parameter_name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,6,NULL,NULL,0,'2007-05-29 11:34:17','2007-05-29 11:34:17',NULL,3,3),(323,38,'data_value',NULL,NULL,'Data_value',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,7,NULL,NULL,0,'2007-05-29 11:34:18','2007-05-29 11:34:18',NULL,3,3),(324,38,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,8,NULL,NULL,0,'2007-05-29 11:34:18','2007-05-29 11:34:18',NULL,3,3),(325,38,'updated_at',NULL,NULL,'Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,9,NULL,NULL,0,'2007-05-29 11:34:18','2007-05-29 11:34:18',NULL,3,3),(326,38,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,10,NULL,NULL,0,'2007-05-29 11:34:18','2007-05-29 11:34:18',NULL,3,3),(327,38,'request_service_id',NULL,NULL,'Request_service_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,11,NULL,NULL,0,'2007-05-29 11:34:18','2007-05-29 11:34:18',NULL,3,3),(328,39,'row_no',NULL,NULL,'Row_no',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,1,'2007-05-29 11:43:43','2007-06-29 12:01:37',NULL,1,3),(329,39,'column_no',NULL,NULL,'Column_no',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,1,'2007-05-29 11:43:43','2007-06-29 12:01:37',NULL,1,3),(330,39,'data_type',NULL,NULL,'Data_type',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,1,'2007-05-29 11:43:43','2007-06-29 12:01:37',NULL,1,3),(331,39,'subject',NULL,NULL,'Subject',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,3,NULL,NULL,1,'2007-05-29 11:43:43','2007-06-29 12:01:37',NULL,1,3),(332,39,'label',NULL,NULL,'Label',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,4,NULL,NULL,1,'2007-05-29 11:43:43','2007-06-29 12:01:37',NULL,1,3),(333,39,'row_label',NULL,NULL,'Row_label',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,5,NULL,NULL,1,'2007-05-29 11:43:43','2007-06-29 12:01:37',NULL,1,3),(334,39,'parameter_name',NULL,NULL,'Parameter_name',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,6,NULL,NULL,1,'2007-05-29 11:43:43','2007-06-29 12:01:37',NULL,1,3),(335,39,'data_value',NULL,NULL,'Data_value',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,7,NULL,NULL,1,'2007-05-29 11:43:43','2007-06-29 12:01:38',NULL,1,3),(336,39,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,8,NULL,NULL,1,'2007-05-29 11:43:44','2007-06-29 12:01:38',NULL,1,3),(337,39,'updated_at',NULL,NULL,'Updated_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,9,NULL,NULL,1,'2007-05-29 11:43:44','2007-06-29 12:01:37',NULL,1,3),(338,39,'id',NULL,NULL,'Id',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,10,NULL,NULL,1,'2007-05-29 11:43:44','2007-06-29 12:01:37',NULL,1,3),(339,39,'study_queue_id',NULL,NULL,'Study_queue_id',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,11,NULL,NULL,1,'2007-05-29 11:43:44','2007-06-29 12:01:37',NULL,1,3),(340,40,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,0,2,'asc',3,'2007-06-12 10:36:52','2007-06-12 10:37:42',NULL,3,3),(341,40,'description',NULL,NULL,'Description',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,3,'2007-06-12 10:36:53','2007-06-12 10:37:42',NULL,3,3),(342,40,'external_ref',NULL,NULL,'Ref',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,3,'2007-06-12 10:36:54','2007-06-12 10:37:42',NULL,3,3),(343,40,'quantity_unit',NULL,NULL,'unit',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,3,'2007-06-12 10:36:55','2007-06-12 10:37:42',NULL,3,3),(344,40,'quantity_value',NULL,NULL,'Quantity',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,4,NULL,NULL,3,'2007-06-12 10:36:55','2007-06-12 10:37:42',NULL,3,3),(345,40,'compound.name',NULL,'compound','Compound',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,5,1,'asc',3,'2007-06-12 10:36:59','2007-06-12 10:37:42','belongs_to',3,3),(346,42,'row_no',NULL,NULL,'Row_no',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,2,'2007-06-20 08:16:38','2007-06-20 08:17:52',NULL,3,3),(347,42,'column_no',NULL,NULL,'Column_no',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,2,'2007-06-20 08:16:40','2007-06-20 08:17:52',NULL,3,3),(348,42,'subject',NULL,NULL,'Subject',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,2,NULL,NULL,2,'2007-06-20 08:16:43','2007-06-20 08:17:52',NULL,3,3),(349,42,'label',NULL,NULL,'Label',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,2,'2007-06-20 08:16:46','2007-06-20 08:17:52',NULL,3,3),(350,42,'parameter_name',NULL,NULL,'Parameter_name',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,4,NULL,NULL,2,'2007-06-20 08:16:48','2007-06-20 08:17:52',NULL,3,3),(351,42,'data_value',NULL,NULL,'Data_value',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,5,NULL,NULL,2,'2007-06-20 08:16:50','2007-06-20 08:17:52',NULL,3,3),(352,42,'task.name',NULL,'task','Task Name',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,6,NULL,NULL,2,'2007-06-20 08:17:00','2007-06-20 08:17:52','belongs_to',3,3),(354,42,'process.name',NULL,'process','Process Name',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,7,NULL,NULL,2,'2007-06-20 08:17:26','2007-06-20 08:17:52','belongs_to',3,3),(355,43,'label',NULL,NULL,'Label',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,2,'2007-06-20 17:34:59','2007-06-20 17:35:24',NULL,1,1),(356,43,'row_label',NULL,NULL,'Row_label',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,2,'2007-06-20 17:35:01','2007-06-20 17:35:24',NULL,1,1),(357,43,'parameter_name',NULL,NULL,'Parameter_name',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,2,NULL,NULL,2,'2007-06-20 17:35:02','2007-06-20 17:35:24',NULL,1,1),(358,43,'data_value',NULL,NULL,'Data_value',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,3,NULL,NULL,2,'2007-06-20 17:35:04','2007-06-20 17:35:24',NULL,1,1),(359,43,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,4,NULL,NULL,2,'2007-06-20 17:35:05','2007-06-20 17:35:25',NULL,1,1),(360,43,'process.name',NULL,'process','Process Name',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,5,NULL,NULL,2,'2007-06-20 17:35:12','2007-06-20 17:35:24','belongs_to',1,1),(361,44,'name',NULL,NULL,'Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,0,NULL,NULL,2,'2007-06-27 15:10:42','2007-06-27 15:10:46',NULL,1,1),(362,44,'description',NULL,NULL,'Description',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,NULL,NULL,2,'2007-06-27 15:10:44','2007-06-27 15:10:46',NULL,1,1),(363,2,'internal',NULL,NULL,'Internal',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,6,NULL,NULL,0,'2007-06-29 11:59:13','2007-06-29 11:59:13',NULL,1,1),(364,39,'queue.name',NULL,'queue','Queue Name',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,12,NULL,NULL,2,'2007-06-29 12:01:02','2007-06-29 12:01:37','belongs_to',1,1),(365,45,'auditable_type',NULL,NULL,'Auditable_type',NULL,'like','Task%',NULL,NULL,NULL,1,1,1,0,2,'asc',6,'2007-06-29 15:07:51','2007-06-29 15:12:21',NULL,3,3),(366,45,'action',NULL,NULL,'Action',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,1,1,'asc',6,'2007-06-29 15:09:20','2007-06-29 15:12:21',NULL,3,3),(367,45,'created_at',NULL,NULL,'Created_at',NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,2,NULL,NULL,6,'2007-06-29 15:09:24','2007-06-29 15:12:21',NULL,3,3),(370,45,'user.name',NULL,'user','User Name',NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,5,NULL,NULL,6,'2007-06-29 15:10:24','2007-06-29 15:12:21','belongs_to',3,3);
/*!40000 ALTER TABLE `report_columns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
CREATE TABLE `reports` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `base_model` varchar(255) default NULL,
  `custom_sql` varchar(255) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `style` varchar(255) default NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  `internal` tinyint(1) default NULL,
  `project_id` int(11) default NULL,
  `action` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (2,'ReportList','Default reports for display as /Report/list','Report',NULL,0,'2007-04-24 14:44:52','2007-04-24 14:44:52','Report',3,3,NULL,NULL,NULL),(3,'All-Reports','List of all reports on the system','Report',NULL,1,'2007-04-24 14:52:18','2007-04-24 14:58:56','Report',3,3,NULL,NULL,NULL),(5,'List_of_Study','Default reports for display as /Study/list','Study',NULL,2,'2007-04-24 20:45:49','2007-04-24 21:27:22',NULL,1,3,NULL,NULL,NULL),(15,'StudyList','Default reports for display as /Study/list','Study',NULL,1,'2007-04-26 21:03:12','2007-04-26 21:03:13',NULL,3,3,1,NULL,NULL),(16,'StudyList','Default reports for display as /Study/list','Study',NULL,1,'2007-04-26 21:03:52','2007-04-26 21:03:52',NULL,3,3,1,NULL,NULL),(17,'ExperimentList','Default reports for display as /Experiment/list','Experiment',NULL,3,'2007-04-26 21:05:42','2007-04-26 21:08:09',NULL,3,3,1,NULL,NULL),(18,'ParameterProtocols','Default reports for display as /Parameter/list','Parameter',NULL,1,'2007-04-30 15:09:18','2007-04-30 15:09:18',NULL,3,3,1,NULL,NULL),(19,'ParameterStatistics','Default reports for display as /ProcessStatistics/list','ProcessStatistics',NULL,1,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3,1,NULL,NULL),(20,'ExperimentStatistics','Default reports for display as /ExperimentStatistics/list','ExperimentStatistics',NULL,1,'2007-04-30 15:09:19','2007-04-30 15:09:19',NULL,3,3,1,NULL,NULL),(22,'Screening Results','Screening results','TaskValue',NULL,2,'2007-05-01 09:04:48','2007-05-01 09:06:07',NULL,3,3,NULL,NULL,NULL),(23,'Screening Results','Screening results','TaskValue',NULL,0,'2007-05-01 09:07:12','2007-05-01 09:07:12',NULL,3,3,NULL,NULL,NULL),(24,'Results','Screening results','TaskResultValue',NULL,3,'2007-05-01 09:09:07','2007-05-01 09:11:26',NULL,3,3,NULL,NULL,NULL),(26,'Report-26','llll','DataElement',NULL,22,'2007-05-23 06:29:12','2007-05-30 15:45:04','Report',8,3,NULL,4,''),(27,'Report-27','task report','AnalysisMethod',NULL,0,'2007-05-25 18:07:46','2007-05-25 18:07:46','Report',3,3,NULL,4,NULL),(29,'UserProjects','Default reports for display as /Membership/list','Membership',NULL,1,'2007-05-28 17:38:47','2007-05-28 17:38:48','System',3,3,1,NULL,NULL),(31,'UserArticles','Default reports for display as /ProjectContent/list','ProjectContent',NULL,1,'2007-05-28 17:49:04','2007-05-28 17:49:05','System',3,3,1,NULL,NULL),(32,'Stuff Todo ','Default reports for display as /QueueItem/list','QueueItem',NULL,1,'2007-05-28 18:00:29','2007-05-28 18:00:30','System',3,3,1,NULL,NULL),(33,'Stuff Wanted','Default reports for display as /QueueItem/list','QueueItem',NULL,1,'2007-05-28 18:00:47','2007-05-28 18:00:47','System',3,3,1,NULL,NULL),(34,'My Todo List ','Default reports for display as /QueueItem/list','QueueItem',NULL,1,'2007-05-28 18:11:30','2007-05-28 18:11:31','System',3,3,1,NULL,NULL),(35,'My Articles','Default reports for display as /ProjectContent/list','ProjectContent',NULL,1,'2007-05-28 18:11:57','2007-05-28 18:11:58','System',3,3,1,NULL,NULL),(36,'My News','Default reports for display as /ProjectElement/list','ProjectElement',NULL,1,'2007-05-28 18:15:06','2007-05-28 18:15:06','System',3,3,1,NULL,NULL),(37,'My Projects','Default reports for display as /Membership/list','Membership',NULL,1,'2007-05-28 18:18:21','2007-05-28 18:18:21','System',3,3,1,NULL,NULL),(38,'Service Request Results','Default reports for display as /QueueResult/list','QueueResult',NULL,1,'2007-05-29 11:34:17','2007-05-29 11:34:18','System',3,3,1,NULL,NULL),(39,'Service Queue Results','Default reports for display as /QueueResult/list','QueueResult',NULL,2,'2007-05-29 11:43:43','2007-06-29 12:01:37','System',1,3,1,NULL,''),(40,'Batches','Batches','Batch',NULL,2,'2007-06-12 10:36:45','2007-06-12 10:37:41','Report',3,3,NULL,13,''),(42,'R-41','results','TaskResultValue',NULL,1,'2007-06-20 08:16:26','2007-06-20 08:17:52','Report',3,3,NULL,13,''),(43,'R-42','bvfgfggf','TaskResult',NULL,1,'2007-06-20 17:34:49','2007-06-20 17:35:24','Report',1,1,NULL,13,''),(44,'R-43','test','AnalysisMethod',NULL,1,'2007-06-27 15:10:37','2007-06-27 15:10:46','Report',1,1,NULL,16,''),(45,'Audit Changes','Changes to Tasks','Audit',NULL,5,'2007-06-29 15:07:41','2007-06-29 15:12:21','Report',3,3,NULL,13,'');
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request_lists`
--

DROP TABLE IF EXISTS `request_lists`;
CREATE TABLE `request_lists` (
  `id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `request_lists`
--

LOCK TABLES `request_lists` WRITE;
/*!40000 ALTER TABLE `request_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `request_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request_services`
--

DROP TABLE IF EXISTS `request_services`;
CREATE TABLE `request_services` (
  `id` int(11) NOT NULL auto_increment,
  `request_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `expected_at` datetime default NULL,
  `started_at` datetime default NULL,
  `ended_at` datetime default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `status_id` int(11) NOT NULL default '0',
  `priority_id` int(11) default NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  `requested_by_user_id` int(11) default '1',
  `assigned_to_user_id` int(11) default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `request_services`
--

LOCK TABLES `request_services` WRITE;
/*!40000 ALTER TABLE `request_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `request_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requests`
--

DROP TABLE IF EXISTS `requests`;
CREATE TABLE `requests` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `expected_at` varchar(255) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `list_id` int(11) default NULL,
  `data_element_id` int(11) default NULL,
  `status_id` int(11) NOT NULL default '0',
  `priority_id` int(11) default NULL,
  `project_id` int(11) default NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  `requested_by_user_id` int(11) default '1',
  `started_at` datetime default NULL,
  `ended_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `requests`
--

LOCK TABLES `requests` WRITE;
/*!40000 ALTER TABLE `requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
CREATE TABLE `role_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) default NULL,
  `subject` varchar(40) default NULL,
  `action` varchar(40) default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_roles_permission_role_id` (`role_id`),
  KEY `fk_roles_permission_permission_id` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (4,3,1,NULL,NULL),(6,1,3,NULL,NULL),(7,3,2,NULL,NULL),(9,1,4,NULL,NULL),(10,2,5,NULL,NULL),(11,3,NULL,'user','list'),(12,3,NULL,'user','show'),(13,3,NULL,'user','new'),(14,3,NULL,'user','create'),(15,3,NULL,'user','edit'),(16,3,NULL,'user','update'),(17,3,NULL,'protocol','list'),(18,3,NULL,'protocol','show'),(19,3,NULL,'protocol','new'),(20,3,NULL,'protocol','create'),(21,3,NULL,'protocol','edit'),(22,3,NULL,'protocol','update'),(23,3,NULL,'catalogue','list'),(24,3,NULL,'catalogue','show'),(25,3,NULL,'catalogue','new'),(26,3,NULL,'catalogue','create'),(27,3,NULL,'catalogue','edit'),(28,3,NULL,'catalogue','update'),(29,3,NULL,'study','list'),(30,3,NULL,'study','show'),(31,3,NULL,'study','new'),(32,3,NULL,'study','create'),(33,3,NULL,'study','edit'),(34,3,NULL,'study','update'),(41,3,NULL,'system','list'),(42,3,NULL,'system','show'),(43,3,NULL,'system','new'),(44,3,NULL,'system','create'),(45,3,NULL,'system','edit'),(46,3,NULL,'system','update'),(47,3,NULL,'cataloge','list'),(48,3,NULL,'cataloge','show'),(49,3,NULL,'cataloge','new'),(50,3,NULL,'cataloge','create'),(51,3,NULL,'cataloge','edit'),(52,3,NULL,'cataloge','update'),(53,3,NULL,'experiment','list'),(54,3,NULL,'experiment','show'),(55,3,NULL,'experiment','new'),(56,3,NULL,'experiment','create'),(57,3,NULL,'experiment','edit'),(58,3,NULL,'experiment','update'),(59,3,NULL,'request','list'),(60,3,NULL,'request','show'),(61,3,NULL,'request','new'),(62,3,NULL,'request','create'),(63,3,NULL,'request','edit'),(64,3,NULL,'request','update'),(65,3,NULL,'users','list'),(66,3,NULL,'users','show'),(67,3,NULL,'users','new'),(68,3,NULL,'users','create'),(69,3,NULL,'users','edit'),(70,3,NULL,'users','update'),(71,3,NULL,'home','index'),(72,3,NULL,'home','show'),(73,3,NULL,'home','projects'),(74,3,NULL,'home','calendar'),(75,3,NULL,'home','timeline'),(76,3,NULL,'home','blog'),(77,3,NULL,'report','list'),(78,3,NULL,'report','show'),(79,3,NULL,'report','new'),(80,3,NULL,'report','create'),(81,3,NULL,'report','edit'),(82,3,NULL,'report','update'),(83,3,NULL,'inventory','list'),(84,3,NULL,'inventory','show'),(85,3,NULL,'inventory','new'),(86,3,NULL,'inventory','create'),(87,3,NULL,'inventory','edit'),(88,3,NULL,'inventory','update'),(89,2,NULL,'user','list'),(90,2,NULL,'user','show'),(91,2,NULL,'protocol','list'),(92,2,NULL,'protocol','show'),(93,2,NULL,'study','list'),(94,2,NULL,'study','show'),(97,2,NULL,'project','list'),(98,2,NULL,'project','show'),(99,2,NULL,'system','list'),(100,2,NULL,'system','show'),(101,2,NULL,'cataloge','list'),(102,2,NULL,'cataloge','show'),(103,2,NULL,'experiment','list'),(104,2,NULL,'experiment','show'),(105,2,NULL,'experiment','new'),(106,2,NULL,'experiment','create'),(107,2,NULL,'experiment','update'),(108,2,NULL,'request','list'),(109,2,NULL,'request','show'),(110,2,NULL,'request','new'),(111,2,NULL,'request','create'),(112,2,NULL,'request','edit'),(113,2,NULL,'request','update'),(116,2,NULL,'report','list'),(117,2,NULL,'report','show'),(118,2,NULL,'report','new'),(119,2,NULL,'report','create'),(120,2,NULL,'report','edit'),(121,2,NULL,'report','update'),(130,5,NULL,'project_queues','list'),(131,5,NULL,'project_queues','show'),(132,5,NULL,'project_studies','list'),(133,5,NULL,'project_studies','show'),(134,5,NULL,'project','list'),(135,5,NULL,'project','show'),(136,5,NULL,'project_experiments','list'),(137,5,NULL,'project_experiments','show'),(138,5,NULL,'project_requests','list'),(139,5,NULL,'project_requests','show'),(140,5,NULL,'project_studies','*'),(141,5,NULL,'project_queues','*'),(142,5,NULL,'project','*'),(143,5,NULL,'project_experiments','*'),(144,5,NULL,'project_requests','*'),(145,6,NULL,'user','*'),(148,6,NULL,'home','*'),(149,6,NULL,'report','*'),(150,6,NULL,'inventory','*'),(151,6,NULL,'catalogue','list'),(152,6,NULL,'catalogue','show'),(153,6,NULL,'users','list'),(154,6,NULL,'users','show'),(155,3,NULL,'catalogue','*'),(156,3,NULL,'users','*'),(157,3,NULL,'report','*'),(158,3,NULL,'home','*'),(159,3,NULL,'inventory','*'),(160,5,NULL,'studies','*'),(161,5,NULL,'experiments','*'),(162,5,NULL,'study_parameters','*'),(163,5,NULL,'study_queues','*'),(164,5,NULL,'queue_items','*'),(165,5,NULL,'tasks','*'),(166,5,NULL,'requests','*'),(167,5,NULL,'study_protocols','*'),(168,2,NULL,'experiments','*'),(169,2,NULL,'studies','list'),(170,2,NULL,'project','*'),(171,2,NULL,'study_parameters','list'),(172,2,NULL,'study_queues','list'),(173,2,NULL,'tasks','*'),(174,2,NULL,'queue_items','list'),(175,2,NULL,'requests','list'),(176,2,NULL,'study_protocols','list'),(177,2,NULL,'project_requests','list'),(178,2,NULL,'queue_items','*'),(179,2,NULL,'requests','*'),(180,2,NULL,'project_requests','*'),(181,2,NULL,'studies','show'),(182,2,NULL,'study_parameters','show'),(183,2,NULL,'study_queues','show'),(184,2,NULL,'study_protocols','show'),(185,1,NULL,'experiments','list'),(186,1,NULL,'experiments','show'),(187,1,NULL,'studies','list'),(188,1,NULL,'studies','show'),(189,1,NULL,'project','list'),(190,1,NULL,'project','show'),(191,1,NULL,'study_parameters','list'),(192,1,NULL,'study_parameters','show'),(193,1,NULL,'study_queues','list'),(194,1,NULL,'study_queues','show'),(195,1,NULL,'tasks','list'),(196,1,NULL,'tasks','show'),(197,1,NULL,'queue_items','list'),(198,1,NULL,'queue_items','show'),(199,1,NULL,'requests','list'),(200,1,NULL,'requests','show'),(201,1,NULL,'study_protocols','list'),(202,1,NULL,'study_protocols','show'),(203,1,NULL,'project_requests','list'),(204,1,NULL,'project_requests','show'),(205,3,NULL,'dba','*'),(206,3,NULL,'reports','*'),(207,7,NULL,'catalogue','list'),(208,7,NULL,'catalogue','show'),(209,7,NULL,'users','list'),(210,7,NULL,'users','show'),(211,7,NULL,'home','*'),(212,7,NULL,'reports','list'),(213,7,NULL,'reports','show'),(214,7,NULL,'reports','new'),(215,7,NULL,'reports','create'),(216,7,NULL,'reports','edit'),(217,7,NULL,'reports','update'),(218,7,NULL,'inventory','*');
/*!40000 ALTER TABLE `role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `parent_id` int(11) default NULL,
  `description` varchar(1024) NOT NULL,
  `default_page_id` int(11) default NULL,
  `cache` longtext,
  `created_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL default '0000-00-00 00:00:00',
  `created_by_user_id` int(11) NOT NULL default '1',
  `updated_by_user_id` int(11) NOT NULL default '1',
  `type` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_role_parent_id` (`parent_id`),
  KEY `fk_role_default_page_id` (`default_page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Public',NULL,'Members of the public who are not logged in.',NULL,'--- \nstudies: \n  list: true\n  show: true\nexperiments: \n  list: true\n  show: true\nmemberships: {}\n\nauth: {}\n\nhelp: {}\n\ncatalogue: {}\n\ndba: {}\n\nproject: \n  list: true\n  show: true\nstudy_parameters: \n  list: true\n  show: true\n~: \n  ~: true\naudit: {}\n\nstudy_queues: \n  list: true\n  show: true\nqueue_items: \n  list: true\n  show: true\ntasks: \n  list: true\n  show: true\nbiorails: {}\n\npage: {}\n\nrequests: \n  list: true\n  show: true\nusers: {}\n\nreports: {}\n\nstudy_protocols: \n  list: true\n  show: true\nhome: {}\n\ncharts: {}\n\nfinder: {}\n\nproject_requests: \n  list: true\n  show: true\ninventory: {}\n\n','2006-06-23 11:03:49','2007-06-11 11:46:18',1,3,'ProjectRole'),(2,'Member',1,'Project Member',NULL,'--- \nstudies: \n  list: true\n  show: true\nmemberships: {}\n\nexperiments: \n  \"*\": true\nuser: \n  list: true\n  show: true\nauth: {}\n\nhelp: {}\n\ncatalogue: {}\n\nprotocol: \n  list: true\n  show: true\nstudy: \n  list: true\n  show: true\ndba: {}\n\nproject: \n  list: true\n  show: true\n  \"*\": true\nstudy_parameters: \n  list: true\n  show: true\n~: \n  ~: true\nsystem: \n  list: true\n  show: true\naudit: {}\n\ncataloge: \n  list: true\n  show: true\nstudy_queues: \n  list: true\n  show: true\nbiorails: {}\n\ntasks: \n  \"*\": true\nqueue_items: \n  list: true\n  \"*\": true\nexperiment: \n  new: true\n  list: true\n  create: true\n  show: true\n  update: true\npage: {}\n\nrequests: \n  list: true\n  \"*\": true\nusers: {}\n\nrequest: \n  new: true\n  list: true\n  edit: true\n  create: true\n  show: true\n  update: true\nstudy_protocols: \n  list: true\n  show: true\nhome: {}\n\nreports: {}\n\nreport: \n  new: true\n  list: true\n  edit: true\n  create: true\n  show: true\n  update: true\ncharts: {}\n\nfinder: {}\n\nproject_requests: \n  list: true\n  \"*\": true\ninventory: {}\n\n','2006-06-23 11:03:50','2007-06-11 11:44:25',1,3,'ProjectRole'),(3,'Administrator',2,'Systems Catalogue Administrator',NULL,'--- \nstudies: {}\n\nexperiments: {}\n\nmemberships: {}\n\nuser: \n  new: true\n  list: true\n  edit: true\n  create: true\n  show: true\n  update: true\nauth: {}\n\nhelp: {}\n\ncatalogue: \n  new: true\n  list: true\n  edit: true\n  create: true\n  show: true\n  update: true\n  \"*\": true\nprotocol: \n  new: true\n  list: true\n  edit: true\n  create: true\n  show: true\n  update: true\nstudy: \n  new: true\n  list: true\n  edit: true\n  create: true\n  show: true\n  update: true\ndba: \n  \"*\": true\nproject: {}\n\nstudy_parameters: {}\n\n~: \n  ~: true\nsystem: \n  new: true\n  list: true\n  edit: true\n  create: true\n  show: true\n  update: true\naudit: {}\n\ncataloge: \n  new: true\n  list: true\n  edit: true\n  create: true\n  show: true\n  update: true\nstudy_queues: {}\n\nqueue_items: {}\n\ntasks: {}\n\nbiorails: {}\n\nexperiment: \n  new: true\n  list: true\n  edit: true\n  create: true\n  show: true\n  update: true\npage: {}\n\nrequests: {}\n\nusers: \n  new: true\n  list: true\n  edit: true\n  create: true\n  show: true\n  update: true\n  \"*\": true\nrequest: \n  new: true\n  list: true\n  edit: true\n  create: true\n  show: true\n  update: true\nreports: \n  \"*\": true\nstudy_protocols: {}\n\nhome: \n  calendar: true\n  blog: true\n  projects: true\n  timeline: true\n  show: true\n  index: true\n  \"*\": true\nreport: \n  new: true\n  list: true\n  edit: true\n  create: true\n  show: true\n  update: true\n  \"*\": true\nfinder: {}\n\ncharts: {}\n\nproject_requests: {}\n\ninventory: \n  new: true\n  list: true\n  edit: true\n  create: true\n  show: true\n  update: true\n  \"*\": true\n','2006-06-23 11:03:48','2007-06-11 11:47:32',1,3,'UserRole'),(5,'Owner',NULL,'Project owner with full rights',NULL,'--- \nmemberships: {}\n\nstudies: \n  \"*\": true\nexperiments: \n  \"*\": true\nauth: {}\n\nhelp: {}\n\nproject_queues: \n  list: true\n  show: true\n  \"*\": true\nproject_studies: \n  list: true\n  show: true\n  \"*\": true\ncatalogue: {}\n\ndba: {}\n\nproject: \n  list: true\n  show: true\n  \"*\": true\nstudy_parameters: \n  \"*\": true\naudit: {}\n\nproject_experiments: \n  list: true\n  show: true\n  \"*\": true\nstudy_queues: \n  \"*\": true\nqueue_items: \n  \"*\": true\ntasks: \n  \"*\": true\nbiorails: {}\n\npage: {}\n\nrequests: \n  \"*\": true\nusers: {}\n\nreports: {}\n\nstudy_protocols: \n  \"*\": true\nhome: {}\n\ncharts: {}\n\nfinder: {}\n\nproject_requests: \n  list: true\n  show: true\n  \"*\": true\ninventory: {}\n\n','2007-06-11 11:05:52','2007-06-11 11:41:08',3,3,'ProjectRole'),(6,'manager',NULL,'General Power user role with delete rights',NULL,'--- \nmemberships: {}\n\nuser: \n  \"*\": true\nproject_queues: {}\n\nauth: {}\n\nhelp: {}\n\nproject_studies: {}\n\ncatalogue: \n  list: true\n  show: true\ndba: {}\n\nproject: {}\n\naudit: {}\n\nproject_experiments: {}\n\nbiorails: {}\n\npage: {}\n\nusers: \n  list: true\n  show: true\nreport: \n  \"*\": true\nhome: \n  \"*\": true\nfinder: {}\n\ncharts: {}\n\nproject_requests: {}\n\ninventory: \n  \"*\": true\n','2007-06-11 11:06:50','2007-06-11 11:27:59',3,3,'UserRole'),(7,'User',NULL,'Standard User ',NULL,'--- \nstudies: {}\n\nmemberships: {}\n\nexperiments: {}\n\nauth: {}\n\nhelp: {}\n\ncatalogue: \n  list: true\n  show: true\ndba: {}\n\nproject: {}\n\nstudy_parameters: {}\n\naudit: {}\n\nstudy_queues: {}\n\nbiorails: {}\n\ntasks: {}\n\nqueue_items: {}\n\npage: {}\n\nrequests: {}\n\nusers: \n  list: true\n  show: true\nstudy_protocols: {}\n\nreports: \n  new: true\n  list: true\n  edit: true\n  create: true\n  show: true\n  update: true\nhome: \n  \"*\": true\nfinder: {}\n\ncharts: {}\n\nproject_requests: {}\n\ninventory: \n  \"*\": true\n','2007-06-11 11:48:05','2007-06-11 11:48:39',3,3,'UserRole');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `samples`
--

DROP TABLE IF EXISTS `samples`;
CREATE TABLE `samples` (
  `id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `samples`
--

LOCK TABLES `samples` WRITE;
/*!40000 ALTER TABLE `samples` DISABLE KEYS */;
/*!40000 ALTER TABLE `samples` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_info`
--

DROP TABLE IF EXISTS `schema_info`;
CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schema_info`
--

LOCK TABLES `schema_info` WRITE;
/*!40000 ALTER TABLE `schema_info` DISABLE KEYS */;
INSERT INTO `schema_info` VALUES (277);
/*!40000 ALTER TABLE `schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL auto_increment,
  `session_id` varchar(255) NOT NULL,
  `data` longtext,
  `created_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,'c439522a09379c9651f5ccf0b992332a','BAh7CjoVY3VycmVudF91c2VybmFtZSILcnNoZWxsOhdjdXJyZW50X3Byb2pl\nY3RfaWRpEjoUY3VycmVudF91c2VyX2lkaQg6E2N1cnJlbnRfcGFyYW1zQzoe\nSGFzaFdpdGhJbmRpZmZlcmVudEFjY2Vzc3sHIgthY3Rpb24iCWxpc3QiD2Nv\nbnRyb2xsZXIiFmludmVudG9yeS9iYXRjaGVzIgpmbGFzaElDOidBY3Rpb25D\nb250cm9sbGVyOjpGbGFzaDo6Rmxhc2hIYXNoewAGOgpAdXNlZHsA\n','2007-07-02 13:48:12','2007-07-02 13:48:29'),(2,'d7fb98e9c113f6bf86080d96d1038894','BAh7CjoVY3VycmVudF91c2VybmFtZSIJbm9uZToXY3VycmVudF9wcm9qZWN0\nX2lkMDoUY3VycmVudF91c2VyX2lkMDoTY3VycmVudF9wYXJhbXMwIgpmbGFz\naElDOidBY3Rpb25Db250cm9sbGVyOjpGbGFzaDo6Rmxhc2hIYXNoewAGOgpA\ndXNlZHsA\n','2007-07-02 19:36:57','2007-07-02 19:36:57'),(3,'081a1bd472f115f5ca9d7f62b73fb5a5','BAh7CjoVY3VycmVudF91c2VybmFtZSILcnNoZWxsOhdjdXJyZW50X3Byb2pl\nY3RfaWRpEjoUY3VycmVudF91c2VyX2lkaQg6E2N1cnJlbnRfcGFyYW1zQzoe\nSGFzaFdpdGhJbmRpZmZlcmVudEFjY2Vzc3sIIgthY3Rpb24iCXNob3ciB2lk\nIgcxMyIPY29udHJvbGxlciIVcHJvamVjdC9wcm9qZWN0cyIKZmxhc2hJQzon\nQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNoSGFzaHsABjoKQHVzZWR7\nAA==\n','2007-07-03 18:42:08','2007-07-03 18:43:33');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specimens`
--

DROP TABLE IF EXISTS `specimens`;
CREATE TABLE `specimens` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `weight` float default NULL,
  `sex` varchar(255) default NULL,
  `birth` datetime default NULL,
  `age` datetime default NULL,
  `taxon_domain` varchar(255) default NULL,
  `taxon_kingdom` varchar(255) default NULL,
  `taxon_phylum` varchar(255) default NULL,
  `taxon_class` varchar(255) default NULL,
  `taxon_family` varchar(255) default NULL,
  `taxon_order` varchar(255) default NULL,
  `taxon_genus` varchar(255) default NULL,
  `taxon_species` varchar(255) default NULL,
  `taxon_subspecies` varchar(255) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `specimens`
--

LOCK TABLES `specimens` WRITE;
/*!40000 ALTER TABLE `specimens` DISABLE KEYS */;
INSERT INTO `specimens` VALUES (1,'Mooose','Large mammal',NULL,'','2006-12-18 22:44:52','2006-12-18 22:44:52','','','','','','','','','',0,'2006-12-18 22:46:00','2006-12-18 22:46:00',1,1);
/*!40000 ALTER TABLE `specimens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studies`
--

DROP TABLE IF EXISTS `studies`;
CREATE TABLE `studies` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `category_id` int(11) default NULL,
  `research_area` varchar(255) default NULL,
  `purpose` varchar(255) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `project_id` int(11) NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  `started_at` datetime default NULL,
  `ended_at` datetime default NULL,
  `expected_at` datetime default NULL,
  `status_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `studies_name_index` (`name`),
  KEY `studies_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `studies`
--

LOCK TABLES `studies` WRITE;
/*!40000 ALTER TABLE `studies` DISABLE KEYS */;
/*!40000 ALTER TABLE `studies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `study_logs`
--

DROP TABLE IF EXISTS `study_logs`;
CREATE TABLE `study_logs` (
  `id` int(11) NOT NULL auto_increment,
  `study_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `auditable_id` int(11) default NULL,
  `auditable_type` varchar(255) default NULL,
  `action` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `comment` varchar(255) default NULL,
  `changes` text,
  `created_by` varchar(255) default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `study_logs_study_id_index` (`study_id`),
  KEY `study_logs_user_id_index` (`user_id`),
  KEY `study_logs_auditable_type_index` (`auditable_type`,`auditable_id`),
  KEY `study_logs_created_at_index` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `study_logs`
--

LOCK TABLES `study_logs` WRITE;
/*!40000 ALTER TABLE `study_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `study_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `study_parameters`
--

DROP TABLE IF EXISTS `study_parameters`;
CREATE TABLE `study_parameters` (
  `id` int(11) NOT NULL auto_increment,
  `parameter_type_id` int(11) default NULL,
  `parameter_role_id` int(11) default NULL,
  `study_id` int(11) default '1',
  `name` varchar(255) default NULL,
  `default_value` varchar(255) default NULL,
  `data_element_id` int(11) default NULL,
  `data_type_id` int(11) default NULL,
  `data_format_id` int(11) default NULL,
  `description` varchar(1024) NOT NULL default '',
  `display_unit` varchar(255) default NULL,
  `created_by_user_id` int(11) NOT NULL default '1',
  `updated_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `study_parameters_study_id_index` (`study_id`),
  KEY `study_parameters_default_name_index` (`name`),
  KEY `study_parameters_parameter_type_id_index` (`parameter_type_id`),
  KEY `study_parameters_parameter_role_id_index` (`parameter_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `study_parameters`
--

LOCK TABLES `study_parameters` WRITE;
/*!40000 ALTER TABLE `study_parameters` DISABLE KEYS */;
/*!40000 ALTER TABLE `study_parameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `study_protocols`
--

DROP TABLE IF EXISTS `study_protocols`;
CREATE TABLE `study_protocols` (
  `id` int(11) NOT NULL auto_increment,
  `study_id` int(11) NOT NULL,
  `study_stage_id` int(11) NOT NULL default '1',
  `current_process_id` int(11) default NULL,
  `process_definition_id` int(11) default NULL,
  `process_style` varchar(128) NOT NULL default 'Entry',
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `literature_ref` text,
  `protocol_catagory` varchar(20) default NULL,
  `protocol_status` varchar(20) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `study_protocols_study_id_index` (`study_id`),
  KEY `study_protocols_process_instance_id_index` (`current_process_id`),
  KEY `study_protocols_process_definition_id_index` (`process_definition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `study_protocols`
--

LOCK TABLES `study_protocols` WRITE;
/*!40000 ALTER TABLE `study_protocols` DISABLE KEYS */;
/*!40000 ALTER TABLE `study_protocols` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `study_queues`
--

DROP TABLE IF EXISTS `study_queues`;
CREATE TABLE `study_queues` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `study_id` int(11) default NULL,
  `study_stage_id` int(11) default NULL,
  `study_parameter_id` int(11) default NULL,
  `study_protocol_id` int(11) default NULL,
  `status` varchar(255) NOT NULL default 'new',
  `priority` varchar(255) NOT NULL default 'normal',
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  `assigned_to_user_id` int(11) default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `study_queues`
--

LOCK TABLES `study_queues` WRITE;
/*!40000 ALTER TABLE `study_queues` DISABLE KEYS */;
/*!40000 ALTER TABLE `study_queues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `study_stages`
--

DROP TABLE IF EXISTS `study_stages`;
CREATE TABLE `study_stages` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `study_stages`
--

LOCK TABLES `study_stages` WRITE;
/*!40000 ALTER TABLE `study_stages` DISABLE KEYS */;
INSERT INTO `study_stages` VALUES (5,'Preparation','Preparation steps',0,'2006-12-11 18:32:33','2006-12-11 18:32:33',1,1),(6,'Data Capture','Capturing raw data',0,'2006-12-11 18:32:56','2006-12-11 18:32:56',1,1),(8,'Analysis','Data analysis',0,'2006-12-11 18:33:23','2006-12-11 18:33:23',1,1);
/*!40000 ALTER TABLE `study_stages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `study_statistics`
--

DROP TABLE IF EXISTS `study_statistics`;
/*!50001 DROP VIEW IF EXISTS `study_statistics`*/;
/*!50001 CREATE TABLE `study_statistics` (
  `id` int(11),
  `study_id` int(11),
  `parameter_role_id` int(11),
  `parameter_type_id` int(11),
  `data_type_id` int(11),
  `avg_values` double,
  `stddev_values` double,
  `num_values` bigint(20),
  `num_unique` bigint(20),
  `max_values` double,
  `min_values` double
) */;

--
-- Table structure for table `subscribers`
--

DROP TABLE IF EXISTS `subscribers`;
CREATE TABLE `subscribers` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `project_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subscribers`
--

LOCK TABLES `subscribers` WRITE;
/*!40000 ALTER TABLE `subscribers` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscribers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_settings`
--

DROP TABLE IF EXISTS `system_settings`;
CREATE TABLE `system_settings` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(30) NOT NULL default '',
  `description` varchar(255) NOT NULL default '',
  `text` varchar(255) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `system_settings`
--

LOCK TABLES `system_settings` WRITE;
/*!40000 ALTER TABLE `system_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggings`
--

DROP TABLE IF EXISTS `taggings`;
CREATE TABLE `taggings` (
  `id` int(11) NOT NULL auto_increment,
  `tag_id` int(11) default NULL,
  `taggable_id` int(11) default NULL,
  `taggable_type` varchar(255) default NULL,
  `created_at` timestamp NULL default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `taggings`
--

LOCK TABLES `taggings` WRITE;
/*!40000 ALTER TABLE `taggings` DISABLE KEYS */;
/*!40000 ALTER TABLE `taggings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_contexts`
--

DROP TABLE IF EXISTS `task_contexts`;
CREATE TABLE `task_contexts` (
  `id` int(11) NOT NULL auto_increment,
  `task_id` int(11) default NULL,
  `parameter_context_id` int(11) default NULL,
  `label` varchar(255) default NULL,
  `is_valid` tinyint(1) default NULL,
  `row_no` int(11) NOT NULL,
  `parent_id` int(11) default NULL,
  `sequence_no` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `task_contexts_task_id_index` (`task_id`),
  KEY `task_contexts_parameter_context_id_index` (`parameter_context_id`),
  KEY `task_contexts_row_no_index` (`row_no`),
  KEY `task_contexts_label_index` (`label`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task_contexts`
--

LOCK TABLES `task_contexts` WRITE;
/*!40000 ALTER TABLE `task_contexts` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_contexts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_files`
--

DROP TABLE IF EXISTS `task_files`;
CREATE TABLE `task_files` (
  `id` int(11) NOT NULL auto_increment,
  `task_context_id` int(11) default NULL,
  `parameter_id` int(11) default NULL,
  `data_uri` varchar(255) default NULL,
  `is_external` tinyint(1) default NULL,
  `mime_type` varchar(250) default NULL,
  `data_binary` text,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `task_id` int(11) default NULL,
  `content_type` varchar(255) default NULL,
  `parent_id` int(11) default NULL,
  `filename` varchar(255) default NULL,
  `thumbnail` varchar(255) default NULL,
  `size` int(11) default NULL,
  `width` int(11) default NULL,
  `height` int(11) default NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task_files`
--

LOCK TABLES `task_files` WRITE;
/*!40000 ALTER TABLE `task_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_references`
--

DROP TABLE IF EXISTS `task_references`;
CREATE TABLE `task_references` (
  `id` int(11) NOT NULL auto_increment,
  `task_context_id` int(11) default NULL,
  `parameter_id` int(11) default NULL,
  `data_element_id` int(11) default NULL,
  `data_type` varchar(255) default NULL,
  `data_id` int(11) default NULL,
  `data_name` varchar(255) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `task_id` int(11) default NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `task_references_task_id_index` (`task_id`),
  KEY `task_references_task_context_id_index` (`task_context_id`),
  KEY `task_references_parameter_id_index` (`parameter_id`),
  KEY `task_references_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task_references`
--

LOCK TABLES `task_references` WRITE;
/*!40000 ALTER TABLE `task_references` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_references` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_relations`
--

DROP TABLE IF EXISTS `task_relations`;
CREATE TABLE `task_relations` (
  `id` int(11) NOT NULL auto_increment,
  `to_task_id` int(11) default NULL,
  `from_task_id` int(11) default NULL,
  `relation_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task_relations`
--

LOCK TABLES `task_relations` WRITE;
/*!40000 ALTER TABLE `task_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `task_result_texts`
--

DROP TABLE IF EXISTS `task_result_texts`;
/*!50001 DROP VIEW IF EXISTS `task_result_texts`*/;
/*!50001 CREATE TABLE `task_result_texts` (
  `id` int(11),
  `row_no` int(11),
  `column_no` int(11),
  `task_id` int(11),
  `parameter_context_id` int(11),
  `task_context_id` int(11),
  `reference_parameter_id` int(11),
  `data_element_id` int(11),
  `data_type` varchar(255),
  `data_id` int(11),
  `subject` varchar(255),
  `parameter_id` int(11),
  `protocol_version_id` int(11),
  `label` varchar(255),
  `row_label` varchar(255),
  `parameter_name` varchar(62),
  `data_value` text,
  `created_by_user_id` int(11),
  `created_at` datetime,
  `updated_by_user_id` int(11),
  `updated_at` datetime
) */;

--
-- Temporary table structure for view `task_result_values`
--

DROP TABLE IF EXISTS `task_result_values`;
/*!50001 DROP VIEW IF EXISTS `task_result_values`*/;
/*!50001 CREATE TABLE `task_result_values` (
  `id` int(11),
  `row_no` int(11),
  `column_no` int(11),
  `task_id` int(11),
  `parameter_context_id` int(11),
  `task_context_id` int(11),
  `reference_parameter_id` int(11),
  `data_element_id` int(11),
  `data_type` varchar(255),
  `data_id` int(11),
  `subject` varchar(255),
  `parameter_id` int(11),
  `protocol_version_id` int(11),
  `label` varchar(255),
  `row_label` varchar(255),
  `parameter_name` varchar(62),
  `data_value` double,
  `created_by_user_id` int(11),
  `created_at` datetime,
  `updated_by_user_id` int(11),
  `updated_at` datetime
) */;

--
-- Temporary table structure for view `task_results`
--

DROP TABLE IF EXISTS `task_results`;
/*!50001 DROP VIEW IF EXISTS `task_results`*/;
/*!50001 CREATE TABLE `task_results` (
  `id` int(11),
  `protocol_version_id` int(11),
  `parameter_context_id` int(11),
  `label` varchar(255),
  `row_label` varchar(255),
  `row_no` int(11),
  `column_no` int(11),
  `task_id` int(11),
  `parameter_id` int(11),
  `parameter_name` varchar(62),
  `data_value` blob,
  `created_by_user_id` int(11),
  `created_at` datetime,
  `updated_by_user_id` int(11),
  `updated_at` datetime
) */;

--
-- Temporary table structure for view `task_statistics`
--

DROP TABLE IF EXISTS `task_statistics`;
/*!50001 DROP VIEW IF EXISTS `task_statistics`*/;
/*!50001 CREATE TABLE `task_statistics` (
  `id` bigint(20),
  `task_id` int(11),
  `parameter_id` int(11),
  `parameter_role_id` int(11),
  `parameter_type_id` int(11),
  `data_type_id` int(11),
  `avg_values` double,
  `stddev_values` double,
  `num_values` bigint(20),
  `num_unique` bigint(20),
  `max_values` blob,
  `min_values` blob
) */;

--
-- Temporary table structure for view `task_stats1`
--

DROP TABLE IF EXISTS `task_stats1`;
/*!50001 DROP VIEW IF EXISTS `task_stats1`*/;
/*!50001 CREATE TABLE `task_stats1` (
  `task_id` int(11),
  `parameter_role_id` int(11),
  `parameter_type_id` int(11),
  `data_type_id` int(11),
  `avg_values` double,
  `stddev_values` double,
  `num_values` bigint(20),
  `num_unique` bigint(20),
  `max_values` double,
  `min_values` double
) */;

--
-- Temporary table structure for view `task_stats2`
--

DROP TABLE IF EXISTS `task_stats2`;
/*!50001 DROP VIEW IF EXISTS `task_stats2`*/;
/*!50001 CREATE TABLE `task_stats2` (
  `task_id` int(11),
  `parameter_id` int(11),
  `avg_values` double,
  `stddev_values` double,
  `num_values` bigint(20),
  `num_unique` bigint(20),
  `max_values` double,
  `min_values` double
) */;

--
-- Table structure for table `task_texts`
--

DROP TABLE IF EXISTS `task_texts`;
CREATE TABLE `task_texts` (
  `id` int(11) NOT NULL auto_increment,
  `task_context_id` int(11) default NULL,
  `parameter_id` int(11) default NULL,
  `markup_style_id` int(11) default NULL,
  `data_content` text,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `task_id` int(11) default NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `task_texts_task_id_index` (`task_id`),
  KEY `task_texts_task_context_id_index` (`task_context_id`),
  KEY `task_texts_parameter_id_index` (`parameter_id`),
  KEY `task_texts_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task_texts`
--

LOCK TABLES `task_texts` WRITE;
/*!40000 ALTER TABLE `task_texts` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_texts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_values`
--

DROP TABLE IF EXISTS `task_values`;
CREATE TABLE `task_values` (
  `id` int(11) NOT NULL auto_increment,
  `task_context_id` int(11) default NULL,
  `parameter_id` int(11) default NULL,
  `data_value` double default NULL,
  `display_unit` varchar(255) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `task_id` int(11) default NULL,
  `storage_unit` varchar(255) default NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `task_values_task_id_index` (`task_id`),
  KEY `task_values_task_context_id_index` (`task_context_id`),
  KEY `task_values_parameter_id_index` (`parameter_id`),
  KEY `task_values_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task_values`
--

LOCK TABLES `task_values` WRITE;
/*!40000 ALTER TABLE `task_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `experiment_id` int(11) NOT NULL,
  `protocol_version_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL default '0',
  `is_milestone` tinyint(1) default NULL,
  `priority_id` int(11) default NULL,
  `started_at` datetime default NULL,
  `ended_at` datetime default NULL,
  `expected_hours` float default NULL,
  `done_hours` float default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `study_protocol_id` int(11) default NULL,
  `project_id` int(11) NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  `assigned_to_user_id` int(11) default '1',
  `expected_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `tasks_name_index` (`name`),
  KEY `tasks_experiment_id_index` (`experiment_id`),
  KEY `tasks_process_instance_id_index` (`protocol_version_id`),
  KEY `tasks_study_protocol_id_index` (`study_protocol_id`),
  KEY `tasks_start_date_index` (`started_at`),
  KEY `tasks_end_date_index` (`ended_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tmp_data`
--

DROP TABLE IF EXISTS `tmp_data`;
CREATE TABLE `tmp_data` (
  `id` int(10) unsigned NOT NULL auto_increment,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tmp_data`
--

LOCK TABLES `tmp_data` WRITE;
/*!40000 ALTER TABLE `tmp_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treatment_groups`
--

DROP TABLE IF EXISTS `treatment_groups`;
CREATE TABLE `treatment_groups` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `study_id` int(11) default NULL,
  `experiment_id` int(11) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `treatment_groups`
--

LOCK TABLES `treatment_groups` WRITE;
/*!40000 ALTER TABLE `treatment_groups` DISABLE KEYS */;
INSERT INTO `treatment_groups` VALUES (1,'A','Group A',NULL,NULL,1,'2006-12-18 22:44:04','2007-06-21 12:43:23',1,1),(2,'B','B',NULL,NULL,1,'2006-12-18 22:44:22','2007-06-21 12:42:50',1,1),(3,'C','Treatment group C',NULL,NULL,0,'2007-06-21 12:42:41','2007-06-21 12:42:41',1,1);
/*!40000 ALTER TABLE `treatment_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treatment_items`
--

DROP TABLE IF EXISTS `treatment_items`;
CREATE TABLE `treatment_items` (
  `id` int(11) NOT NULL auto_increment,
  `treatment_group_id` int(11) NOT NULL,
  `subject_type` varchar(255) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `sequence_order` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `treatment_items`
--

LOCK TABLES `treatment_items` WRITE;
/*!40000 ALTER TABLE `treatment_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `treatment_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_settings`
--

DROP TABLE IF EXISTS `user_settings`;
CREATE TABLE `user_settings` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(30) NOT NULL default '',
  `description` varchar(255) NOT NULL default '',
  `value` varchar(255) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_settings`
--

LOCK TABLES `user_settings` WRITE;
/*!40000 ALTER TABLE `user_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `password_hash` varchar(40) default NULL,
  `role_id` int(11) NOT NULL,
  `password_salt` varchar(255) default NULL,
  `fullname` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `login` varchar(40) default NULL,
  `activation_code` varchar(40) default NULL,
  `state_id` int(11) default NULL,
  `activated_at` datetime default NULL,
  `token` varchar(255) default NULL,
  `token_expires_at` datetime default NULL,
  `filter` varchar(255) default NULL,
  `admin` tinyint(1) default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `deleted_at` datetime default NULL,
  `created_by_user_id` int(11) NOT NULL default '1',
  `updated_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `fk_user_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'guest','cebc21d4c7bcef9624474cda20ebb609e4c2779f',7,NULL,NULL,NULL,'guest',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,1,1),(2,'admin','38591e7d32f1a68f4b6977d7026a2031f4d7d6ec',3,'314033922d5fd52b653ee385d9682e9b2bfbff0b',NULL,NULL,'admin',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2007-04-18 12:54:44',NULL,1,1),(3,'rshell','e7c2941bbbbec9c14c774e0522d0e18b754f4b69',3,'4f977405c4c4ca36165fd6bb5f99bc26b9fbaa09','','','rshell',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2007-05-26 10:13:38',NULL,1,3),(4,'thawkins','af4c83e204c25f752e8132f3a0939b2553282450',3,'1b3835585efd38ba368553cc451459b194b0520f','baldy','ted@edgesoftwareconsultancy.com','thawkins',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2007-06-12 10:45:18',NULL,1,2),(6,'alemon','6a07417e6ce8ffffd9d6a2d4894b929bc5592091',3,'e5d83eeadb7eeb4cff02d9694ebe692eeea04e41','Andrew Lemon','andrew@edgesoftwareconsultancy.com','alemon',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2007-06-19 09:08:38',NULL,1,6),(8,'amember','e71497f06f6dba6a3f50932146732c510fab17ed',7,'9c432e83097c4c00014fa3b1e31026cd6040132b','A.Member','dddd','member',NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-05-30 14:17:29','2007-05-30 14:17:29',NULL,3,3),(9,'demo1','4b2e6eed98f2af38184a5986144c39650abe907a',7,'fd5fc858572324f3aef01fb01492f113dec1707f','Demo1 user a simple member','demo1@localhost','demo1',NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-06-06 18:16:18','2007-06-06 18:16:18',NULL,3,3);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_status`
--

DROP TABLE IF EXISTS `work_status`;
CREATE TABLE `work_status` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `work_status`
--

LOCK TABLES `work_status` WRITE;
/*!40000 ALTER TABLE `work_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `work_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `compound_results`
--

/*!50001 DROP TABLE IF EXISTS `compound_results`*/;
/*!50001 DROP VIEW IF EXISTS `compound_results`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`biorails`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `compound_results` AS select `ti`.`id` AS `id`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`p`.`parameter_context_id` AS `parameter_context_id`,`tr`.`task_context_id` AS `task_context_id`,`tr`.`data_element_id` AS `data_element_id`,`tr`.`parameter_id` AS `compound_parameter_id`,`tr`.`data_id` AS `compound_id`,`tr`.`data_name` AS `compound_name`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`ti`.`parameter_id` AS `parameter_id`,`p`.`name` AS `parameter_name`,`ti`.`data_value` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from ((((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_references` `tr`) join `task_values` `ti`) where ((`tc`.`id` = `tr`.`task_context_id`) and (`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`) and (`tr`.`data_type` = _latin1'Compound')) */;

--
-- Final view structure for view `experiment_statistics`
--

/*!50001 DROP TABLE IF EXISTS `experiment_statistics`*/;
/*!50001 DROP VIEW IF EXISTS `experiment_statistics`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`biorails`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `experiment_statistics` AS select ((`t`.`experiment_id` * 1000000) + `p`.`study_parameter_id`) AS `id`,`t`.`experiment_id` AS `experiment_id`,`p`.`study_parameter_id` AS `study_parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,avg(`r`.`data_value`) AS `avg_values`,std(`r`.`data_value`) AS `stddev_values`,count(`r`.`data_value`) AS `num_values`,count(distinct `r`.`data_value`) AS `num_unique`,max(`r`.`data_value`) AS `max_values`,min(`r`.`data_value`) AS `min_values` from ((`task_values` `r` join `parameters` `p`) join `tasks` `t`) where ((`p`.`id` = `r`.`parameter_id`) and (`t`.`id` = `r`.`task_id`) and (`p`.`study_parameter_id` is not null)) group by `t`.`experiment_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id`,`p`.`study_parameter_id` union select ((`t`.`experiment_id` * 1000000) + `p`.`study_parameter_id`) AS `id`,`t`.`experiment_id` AS `experiment_id`,`p`.`study_parameter_id` AS `study_parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_content`) AS `num_unique`,sum(NULL) AS `max_values`,sum(NULL) AS `min_values` from ((`task_texts` `r` join `parameters` `p`) join `tasks` `t`) where ((`p`.`id` = `r`.`parameter_id`) and (`p`.`study_parameter_id` is not null) and (`t`.`id` = `r`.`task_id`)) group by `t`.`experiment_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id`,`p`.`study_parameter_id` union select ((`t`.`experiment_id` * 1000000) + `p`.`study_parameter_id`) AS `id`,`t`.`experiment_id` AS `experiment_id`,`p`.`study_parameter_id` AS `study_parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_name`) AS `num_unique`,max(`r`.`data_id`) AS `max_values`,min(`r`.`data_id`) AS `min_values` from ((`task_references` `r` join `parameters` `p`) join `tasks` `t`) where ((`p`.`id` = `r`.`parameter_id`) and (`p`.`study_parameter_id` is not null) and (`t`.`id` = `r`.`task_id`)) group by `t`.`experiment_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id`,`p`.`study_parameter_id` */;

--
-- Final view structure for view `process_statistics`
--

/*!50001 DROP TABLE IF EXISTS `process_statistics`*/;
/*!50001 DROP VIEW IF EXISTS `process_statistics`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`biorails`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `process_statistics` AS select `p`.`id` AS `id`,`p`.`study_parameter_id` AS `study_parameter_id`,`p`.`protocol_version_id` AS `protocol_version_id`,`r`.`parameter_id` AS `parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,avg(`r`.`data_value`) AS `avg_values`,std(`r`.`data_value`) AS `stddev_values`,count(`r`.`data_value`) AS `num_values`,count(distinct `r`.`data_value`) AS `num_unique`,max(`r`.`data_value`) AS `max_values`,min(`r`.`data_value`) AS `min_values` from (`task_values` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `p`.`study_parameter_id`,`p`.`protocol_version_id`,`r`.`parameter_id`,`p`.`id` union select `p`.`id` AS `id`,`p`.`study_parameter_id` AS `study_parameter_id`,`p`.`protocol_version_id` AS `protocol_version_id`,`r`.`parameter_id` AS `parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_content`) AS `num_unique`,sum(NULL) AS `max_values`,sum(NULL) AS `min_values` from (`task_texts` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `p`.`study_parameter_id`,`p`.`protocol_version_id`,`r`.`parameter_id`,`p`.`id` union select `p`.`id` AS `id`,`p`.`study_parameter_id` AS `study_parameter_id`,`p`.`protocol_version_id` AS `protocol_version_id`,`r`.`parameter_id` AS `parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_name`) AS `num_unique`,max(`r`.`data_id`) AS `max_values`,min(`r`.`data_id`) AS `min_values` from (`task_references` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `p`.`study_parameter_id`,`p`.`protocol_version_id`,`r`.`parameter_id`,`p`.`id` */;

--
-- Final view structure for view `queue_results`
--

/*!50001 DROP TABLE IF EXISTS `queue_results`*/;
/*!50001 DROP VIEW IF EXISTS `queue_results`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`biorails`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `queue_results` AS select `ti`.`id` AS `id`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`qi`.`id` AS `queue_item_id`,`qi`.`request_service_id` AS `request_service_id`,`qi`.`study_queue_id` AS `study_queue_id`,`qi`.`requested_by_user_id` AS `requested_by_user_id`,`qi`.`assigned_to_user_id` AS `assigned_to_user_id`,`p`.`parameter_context_id` AS `parameter_context_id`,`tr`.`task_context_id` AS `task_context_id`,`tr`.`parameter_id` AS `reference_parameter_id`,`tr`.`data_element_id` AS `data_element_id`,`tr`.`data_type` AS `data_type`,`tr`.`data_id` AS `data_id`,`tr`.`data_name` AS `subject`,`ti`.`parameter_id` AS `parameter_id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`p`.`name` AS `parameter_name`,`ti`.`data_content` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from (((((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_references` `tr`) join `task_texts` `ti`) join `queue_items` `qi`) where ((`tc`.`id` = `tr`.`task_context_id`) and (`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`) and (`qi`.`task_id` = `tr`.`task_id`) and (`qi`.`data_id` = `tr`.`data_id`) and (`qi`.`data_type` = `tr`.`data_type`) and (`qi`.`data_name` = `tr`.`data_name`)) union select `ti`.`id` AS `id`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`qi`.`id` AS `queue_item_id`,`qi`.`request_service_id` AS `request_service_id`,`qi`.`study_queue_id` AS `study_queue_id`,`qi`.`requested_by_user_id` AS `requested_by_user_id`,`qi`.`assigned_to_user_id` AS `assigned_to_user_id`,`p`.`parameter_context_id` AS `parameter_context_id`,`tr`.`task_context_id` AS `task_context_id`,`tr`.`parameter_id` AS `reference_parameter_id`,`tr`.`data_element_id` AS `data_element_id`,`tr`.`data_type` AS `data_type`,`tr`.`data_id` AS `data_id`,`tr`.`data_name` AS `subject`,`ti`.`parameter_id` AS `parameter_id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`p`.`name` AS `parameter_name`,`ti`.`data_value` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from (((((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_references` `tr`) join `task_values` `ti`) join `queue_items` `qi`) where ((`tc`.`id` = `tr`.`task_context_id`) and (`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`) and (`qi`.`task_id` = `tr`.`task_id`) and (`qi`.`data_id` = `tr`.`data_id`) and (`qi`.`data_type` = `tr`.`data_type`) and (`qi`.`data_name` = `tr`.`data_name`)) */;

--
-- Final view structure for view `study_statistics`
--

/*!50001 DROP TABLE IF EXISTS `study_statistics`*/;
/*!50001 DROP VIEW IF EXISTS `study_statistics`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`biorails`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `study_statistics` AS select `p`.`study_parameter_id` AS `id`,`e`.`study_id` AS `study_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,avg(`r`.`data_value`) AS `avg_values`,std(`r`.`data_value`) AS `stddev_values`,count(`r`.`data_value`) AS `num_values`,count(distinct `r`.`data_value`) AS `num_unique`,max(`r`.`data_value`) AS `max_values`,min(`r`.`data_value`) AS `min_values` from (((`task_values` `r` join `parameters` `p`) join `tasks` `t`) join `experiments` `e`) where ((`p`.`id` = `r`.`parameter_id`) and (`t`.`id` = `r`.`task_id`) and (`e`.`id` = `t`.`experiment_id`) and (`p`.`study_parameter_id` is not null)) group by `e`.`study_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`study_parameter_id` union select `p`.`study_parameter_id` AS `id`,`e`.`study_id` AS `study_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_content`) AS `num_unique`,sum(NULL) AS `max_values`,sum(NULL) AS `min_values` from (((`task_texts` `r` join `parameters` `p`) join `tasks` `t`) join `experiments` `e`) where ((`p`.`id` = `r`.`parameter_id`) and (`t`.`id` = `r`.`task_id`) and (`e`.`id` = `t`.`experiment_id`) and (`p`.`study_parameter_id` is not null)) group by `e`.`study_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`study_parameter_id` union select `p`.`study_parameter_id` AS `id`,`e`.`study_id` AS `study_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_name`) AS `num_unique`,max(`r`.`data_id`) AS `max_values`,min(`r`.`data_id`) AS `min_values` from (((`task_references` `r` join `parameters` `p`) join `tasks` `t`) join `experiments` `e`) where ((`p`.`id` = `r`.`parameter_id`) and (`t`.`id` = `r`.`task_id`) and (`e`.`id` = `t`.`experiment_id`) and (`p`.`study_parameter_id` is not null)) group by `e`.`study_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`study_parameter_id` */;

--
-- Final view structure for view `task_result_texts`
--

/*!50001 DROP TABLE IF EXISTS `task_result_texts`*/;
/*!50001 DROP VIEW IF EXISTS `task_result_texts`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`biorails`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `task_result_texts` AS select `ti`.`id` AS `id`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`p`.`parameter_context_id` AS `parameter_context_id`,`tr`.`task_context_id` AS `task_context_id`,`tr`.`parameter_id` AS `reference_parameter_id`,`tr`.`data_element_id` AS `data_element_id`,`tr`.`data_type` AS `data_type`,`tr`.`data_id` AS `data_id`,`tr`.`data_name` AS `subject`,`ti`.`parameter_id` AS `parameter_id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`p`.`name` AS `parameter_name`,`ti`.`data_content` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from ((((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_references` `tr`) join `task_texts` `ti`) where ((`tc`.`id` = `tr`.`task_context_id`) and (`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`)) */;

--
-- Final view structure for view `task_result_values`
--

/*!50001 DROP TABLE IF EXISTS `task_result_values`*/;
/*!50001 DROP VIEW IF EXISTS `task_result_values`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `task_result_values` AS select `ti`.`id` AS `id`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`p`.`parameter_context_id` AS `parameter_context_id`,`tr`.`task_context_id` AS `task_context_id`,`tr`.`parameter_id` AS `reference_parameter_id`,`tr`.`data_element_id` AS `data_element_id`,`tr`.`data_type` AS `data_type`,`tr`.`data_id` AS `data_id`,`tr`.`data_name` AS `subject`,`ti`.`parameter_id` AS `parameter_id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`p`.`name` AS `parameter_name`,`ti`.`data_value` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from ((((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_references` `tr`) join `task_values` `ti`) where ((`tc`.`id` = `tr`.`task_context_id`) and (`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`)) */;

--
-- Final view structure for view `task_results`
--

/*!50001 DROP TABLE IF EXISTS `task_results`*/;
/*!50001 DROP VIEW IF EXISTS `task_results`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`biorails`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `task_results` AS select `ti`.`id` AS `id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`id` AS `parameter_context_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`ti`.`parameter_id` AS `parameter_id`,`p`.`name` AS `parameter_name`,`ti`.`data_value` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from (((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_values` `ti`) where ((`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`)) union select `ti`.`id` AS `id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`id` AS `parameter_context_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`ti`.`parameter_id` AS `parameter_id`,`p`.`name` AS `parameter_name`,`ti`.`data_content` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by`,`ti`.`updated_at` AS `updated_at` from (((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_texts` `ti`) where ((`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`)) union select `ti`.`id` AS `id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`id` AS `parameter_context_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`ti`.`parameter_id` AS `parameter_id`,`p`.`name` AS `parameter_name`,`ti`.`data_content` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from (((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_texts` `ti`) where ((`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`)) union select `ti`.`id` AS `id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`id` AS `parameter_context_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`ti`.`parameter_id` AS `parameter_id`,`p`.`name` AS `parameter_name`,`ti`.`data_name` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from (((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_references` `ti`) where ((`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`)) */;

--
-- Final view structure for view `task_statistics`
--

/*!50001 DROP TABLE IF EXISTS `task_statistics`*/;
/*!50001 DROP VIEW IF EXISTS `task_statistics`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`biorails`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `task_statistics` AS select ((`r`.`task_id` * 100000) + `r`.`parameter_id`) AS `id`,`r`.`task_id` AS `task_id`,`r`.`parameter_id` AS `parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,avg(`r`.`data_value`) AS `avg_values`,std(`r`.`data_value`) AS `stddev_values`,count(`r`.`data_value`) AS `num_values`,count(distinct `r`.`data_value`) AS `num_unique`,max(`r`.`data_value`) AS `max_values`,min(`r`.`data_value`) AS `min_values` from (`task_values` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `r`.`task_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id` union select ((`r`.`task_id` * 100000) + `r`.`parameter_id`) AS `id`,`r`.`task_id` AS `task_id`,`r`.`parameter_id` AS `parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_content`) AS `num_unique`,min(`r`.`data_content`) AS `max_values`,max(`r`.`data_content`) AS `min_values` from (`task_texts` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `r`.`task_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id` union select ((`r`.`task_id` * 100000) + `r`.`parameter_id`) AS `id`,`r`.`task_id` AS `task_id`,`r`.`parameter_id` AS `parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_name`) AS `num_unique`,max(`r`.`data_name`) AS `max_values`,min(`r`.`data_name`) AS `min_values` from (`task_references` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `r`.`task_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id` */;

--
-- Final view structure for view `task_stats1`
--

/*!50001 DROP TABLE IF EXISTS `task_stats1`*/;
/*!50001 DROP VIEW IF EXISTS `task_stats1`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `task_stats1` AS select `r`.`task_id` AS `task_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,avg(`r`.`data_value`) AS `avg_values`,std(`r`.`data_value`) AS `stddev_values`,count(`r`.`data_value`) AS `num_values`,count(distinct `r`.`data_value`) AS `num_unique`,max(`r`.`data_value`) AS `max_values`,min(`r`.`data_value`) AS `min_values` from (`task_values` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `r`.`task_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id` union select `r`.`task_id` AS `task_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_content`) AS `num_unique`,sum(NULL) AS `max_values`,sum(NULL) AS `min_values` from (`task_texts` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `r`.`task_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id` union select `r`.`task_id` AS `task_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_name`) AS `num_unique`,max(`r`.`data_id`) AS `max_values`,min(`r`.`data_id`) AS `min_values` from (`task_references` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `r`.`task_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id` */;

--
-- Final view structure for view `task_stats2`
--

/*!50001 DROP TABLE IF EXISTS `task_stats2`*/;
/*!50001 DROP VIEW IF EXISTS `task_stats2`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `task_stats2` AS select `r`.`task_id` AS `task_id`,`r`.`parameter_id` AS `parameter_id`,avg(`r`.`data_value`) AS `avg_values`,std(`r`.`data_value`) AS `stddev_values`,count(`r`.`data_value`) AS `num_values`,count(distinct `r`.`data_value`) AS `num_unique`,max(`r`.`data_value`) AS `max_values`,min(`r`.`data_value`) AS `min_values` from `task_values` `r` group by `r`.`task_id`,`r`.`parameter_id` union select `r`.`task_id` AS `task_id`,`r`.`parameter_id` AS `parameter_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_content`) AS `num_unique`,sum(NULL) AS `max_values`,sum(NULL) AS `min_values` from `task_texts` `r` group by `r`.`task_id`,`r`.`parameter_id` union select `r`.`task_id` AS `task_id`,`r`.`parameter_id` AS `parameter_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_name`) AS `num_unique`,max(`r`.`data_id`) AS `max_values`,min(`r`.`data_id`) AS `min_values` from `task_references` `r` group by `r`.`task_id`,`r`.`parameter_id` */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2007-07-10 22:09:00
