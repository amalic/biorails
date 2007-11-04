/*
SQLyog Enterprise - MySQL GUI v6.07
Host - 5.0.38-Ubuntu_0ubuntu1.1-log : Database - biorails2_development
*********************************************************************
Server version : 5.0.38-Ubuntu_0ubuntu1.1-log
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

create database if not exists `biorails2_development`;

USE `biorails2_development`;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

/*Table structure for table `IJC_ITEM_INFO` */

DROP TABLE IF EXISTS `IJC_ITEM_INFO`;

CREATE TABLE `IJC_ITEM_INFO` (
  `SCHEMA_ID` varchar(32) NOT NULL,
  `ITEM_ID` varchar(32) NOT NULL,
  `INFO_TYPE` varchar(32) NOT NULL,
  `EXTRA_1` varchar(100) default NULL,
  `EXTRA_2` varchar(100) default NULL,
  `EXTRA_3` varchar(100) default NULL,
  `EXTRA_4` varchar(100) default NULL,
  `INFO_VALUE` text,
  PRIMARY KEY  (`SCHEMA_ID`,`ITEM_ID`,`INFO_TYPE`),
  CONSTRAINT `FK_IJC_ITEM_INFO_SCHEMA` FOREIGN KEY (`SCHEMA_ID`, `ITEM_ID`) REFERENCES `IJC_SCHEMA` (`SCHEMA_ID`, `ITEM_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `IJC_ITEM_USER` */

DROP TABLE IF EXISTS `IJC_ITEM_USER`;

CREATE TABLE `IJC_ITEM_USER` (
  `SCHEMA_ID` varchar(32) NOT NULL,
  `ITEM_ID` varchar(32) NOT NULL,
  `USERNAME` varchar(32) NOT NULL,
  `TYPE` varchar(32) NOT NULL,
  `CREATION_TIME` datetime NOT NULL,
  `INFO` text,
  PRIMARY KEY  (`SCHEMA_ID`,`ITEM_ID`,`USERNAME`,`TYPE`),
  KEY `FK_IJC_ITEM_USER_USER` (`SCHEMA_ID`,`USERNAME`),
  CONSTRAINT `FK_IJC_ITEM_USER_ITEM` FOREIGN KEY (`SCHEMA_ID`, `ITEM_ID`) REFERENCES `IJC_SCHEMA` (`SCHEMA_ID`, `ITEM_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_IJC_ITEM_USER_USER` FOREIGN KEY (`SCHEMA_ID`, `USERNAME`) REFERENCES `IJC_USER` (`SCHEMA_ID`, `USERNAME`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `IJC_SCHEMA` */

DROP TABLE IF EXISTS `IJC_SCHEMA`;

CREATE TABLE `IJC_SCHEMA` (
  `SCHEMA_ID` varchar(32) NOT NULL,
  `ITEM_ID` varchar(32) NOT NULL,
  `ITEM_INDEX` smallint(6) NOT NULL,
  `GENERIC_TYPE` varchar(200) NOT NULL,
  `IMPL_TYPE` varchar(200) NOT NULL,
  `PARENT_ID` varchar(32) default NULL,
  `ITEM_VALUE` text,
  PRIMARY KEY  (`SCHEMA_ID`,`ITEM_ID`),
  KEY `FK_IJC_SCHEMA_SCHEMA` (`SCHEMA_ID`,`PARENT_ID`),
  CONSTRAINT `FK_IJC_SCHEMA_SCHEMA` FOREIGN KEY (`SCHEMA_ID`, `PARENT_ID`) REFERENCES `IJC_SCHEMA` (`SCHEMA_ID`, `ITEM_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `IJC_SECURITY_INFO` */

DROP TABLE IF EXISTS `IJC_SECURITY_INFO`;

CREATE TABLE `IJC_SECURITY_INFO` (
  `SCHEMA_ID` varchar(32) NOT NULL,
  `ITEM_ID` varchar(32) NOT NULL,
  `INFO_TYPE` varchar(32) NOT NULL,
  `EXTRA_1` varchar(100) default NULL,
  `EXTRA_2` varchar(100) default NULL,
  `EXTRA_3` varchar(100) default NULL,
  `EXTRA_4` varchar(100) default NULL,
  `INFO_VALUE` text,
  PRIMARY KEY  (`SCHEMA_ID`,`ITEM_ID`,`INFO_TYPE`),
  CONSTRAINT `FK_IJC_SECURITY_INFO_SCHEMA` FOREIGN KEY (`SCHEMA_ID`, `ITEM_ID`) REFERENCES `IJC_SCHEMA` (`SCHEMA_ID`, `ITEM_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `IJC_USER` */

DROP TABLE IF EXISTS `IJC_USER`;

CREATE TABLE `IJC_USER` (
  `SCHEMA_ID` varchar(32) NOT NULL,
  `USERNAME` varchar(32) NOT NULL,
  `LOGIN_TIME` datetime default NULL,
  `HEARTBEAT` datetime default NULL,
  PRIMARY KEY  (`SCHEMA_ID`,`USERNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `IJC_VIEWS` */

DROP TABLE IF EXISTS `IJC_VIEWS`;

CREATE TABLE `IJC_VIEWS` (
  `ID` int(11) NOT NULL auto_increment,
  `SCHEMA_ID` varchar(32) NOT NULL,
  `DATATREE_ID` varchar(32) NOT NULL,
  `USERNAME` varchar(32) NOT NULL,
  `VIEW_ID` varchar(32) NOT NULL,
  `VIEW_NAME` varchar(100) NOT NULL,
  `VIEW_INDEX` smallint(6) NOT NULL,
  `IMPL_TYPE` varchar(200) NOT NULL,
  `VIEW_CONFIG` mediumtext,
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `UQ_IJC_VIEWS` (`SCHEMA_ID`,`DATATREE_ID`,`USERNAME`,`VIEW_ID`),
  KEY `FK_IJC_VIEWS_USER` (`SCHEMA_ID`,`USERNAME`),
  CONSTRAINT `FK_IJC_VIEWS_SCHEMA` FOREIGN KEY (`SCHEMA_ID`, `DATATREE_ID`) REFERENCES `IJC_SCHEMA` (`SCHEMA_ID`, `ITEM_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_IJC_VIEWS_USER` FOREIGN KEY (`SCHEMA_ID`, `USERNAME`) REFERENCES `IJC_USER` (`SCHEMA_ID`, `USERNAME`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `JCHEMPROPERTIES` */

DROP TABLE IF EXISTS `JCHEMPROPERTIES`;

CREATE TABLE `JCHEMPROPERTIES` (
  `prop_name` varchar(200) NOT NULL,
  `prop_value` varchar(200) default NULL,
  `prop_value_ext` mediumblob,
  PRIMARY KEY  (`prop_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `analysis_methods` */

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

/*Table structure for table `analysis_settings` */

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
  `io_mode` int(11) default NULL,
  `mandatory` varchar(255) default 'N',
  `default_value` varchar(255) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `audit_logs` */

DROP TABLE IF EXISTS `audit_logs`;

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL auto_increment,
  `auditable_id` int(11) default NULL,
  `auditable_type` varchar(255) default NULL,
  `user_id` int(11) default NULL,
  `action` varchar(255) default NULL,
  `changes` text,
  `created_by` varchar(255) default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `audits` */

DROP TABLE IF EXISTS `audits`;

CREATE TABLE `audits` (
  `id` int(11) NOT NULL auto_increment,
  `auditable_id` int(11) default NULL,
  `auditable_type` varchar(255) default NULL,
  `user_id` int(11) default NULL,
  `user_type` varchar(255) default NULL,
  `session_id` varchar(255) default NULL,
  `action` varchar(255) default NULL,
  `changes` text,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `auditable_index` (`auditable_id`,`auditable_type`),
  KEY `user_index` (`user_id`,`user_type`),
  KEY `audits_created_at_index` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `batches` */

DROP TABLE IF EXISTS `batches`;

CREATE TABLE `batches` (
  `id` int(11) NOT NULL auto_increment,
  `registration_id` int(11) NOT NULL default '0',
  `composition_id` int(11) default NULL,
  `name` varchar(255) default NULL,
  `compound_id` int(11) NOT NULL default '0',
  `description` text,
  `external_ref` varchar(255) default NULL,
  `quantity_unit` varchar(255) default NULL,
  `quantity_value` float default NULL,
  `url` varchar(255) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `catalog_logs` */

DROP TABLE IF EXISTS `catalog_logs`;

CREATE TABLE `catalog_logs` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `auditable_id` int(11) default NULL,
  `auditable_type` varchar(255) default NULL,
  `action` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `comments` varchar(255) default NULL,
  `created_by` varchar(255) default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `catalog_logs_user_id_index` (`user_id`),
  KEY `catalog_logs_auditable_type_index` (`auditable_type`,`auditable_id`),
  KEY `catalog_logs_created_at_index` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `composition_items` */

DROP TABLE IF EXISTS `composition_items`;

CREATE TABLE `composition_items` (
  `id` int(11) NOT NULL auto_increment,
  `composition_id` int(11) default NULL,
  `compound_id` int(11) default NULL,
  `coeffient` float default NULL,
  `name` varchar(255) default NULL,
  `description` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `compositions` */

DROP TABLE IF EXISTS `compositions`;

CREATE TABLE `compositions` (
  `id` int(11) NOT NULL auto_increment,
  `type` varchar(50) NOT NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `compound_results` */

DROP TABLE IF EXISTS `compound_results`;

/*!50001 DROP VIEW IF EXISTS `compound_results` */;
/*!50001 DROP TABLE IF EXISTS `compound_results` */;

/*!50001 CREATE TABLE `compound_results` (
  `id` int(11) NOT NULL default '0',
  `row_no` int(11) NOT NULL,
  `column_no` int(11) default NULL,
  `task_id` int(11) default NULL,
  `parameter_context_id` int(11) default NULL,
  `task_context_id` int(11) default NULL,
  `data_element_id` int(11) default NULL,
  `compound_parameter_id` int(11) default NULL,
  `compound_id` int(11) default NULL,
  `compound_name` varchar(255) default NULL,
  `protocol_version_id` int(11) default NULL,
  `label` varchar(255) default NULL,
  `row_label` varchar(255) default NULL,
  `parameter_id` int(11) default NULL,
  `parameter_name` varchar(62) default NULL,
  `data_value` double default NULL,
  `created_by_user_id` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '0',
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 */;

/*Table structure for table `compounds` */

DROP TABLE IF EXISTS `compounds`;

CREATE TABLE `compounds` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL default '',
  `description` text,
  `formula` varchar(50) default NULL,
  `mass` float default NULL,
  `smiles` varchar(255) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_by_user_id` int(32) NOT NULL default '1',
  `created_at` datetime NOT NULL,
  `updated_by_user_id` int(32) NOT NULL default '1',
  `updated_at` datetime NOT NULL,
  `registration_date` datetime default NULL,
  `iupacname` varchar(255) default '',
  `molecule_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `container_items` */

DROP TABLE IF EXISTS `container_items`;

CREATE TABLE `container_items` (
  `id` int(11) NOT NULL auto_increment,
  `container_group_id` int(11) NOT NULL,
  `subject_type` varchar(255) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `slot_no` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `container_slots` */

DROP TABLE IF EXISTS `container_slots`;

CREATE TABLE `container_slots` (
  `id` int(11) NOT NULL auto_increment,
  `container_layout_id` int(11) NOT NULL default '0',
  `name` varchar(128) NOT NULL,
  `label` varchar(255) default NULL,
  `slot_no` int(11) NOT NULL default '0',
  `object_no` int(11) NOT NULL default '0',
  `dilution_factor` float NOT NULL default '1',
  `x` int(11) NOT NULL default '0',
  `y` int(11) NOT NULL default '0',
  `z` int(11) NOT NULL default '0',
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `containers` */

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

/*Table structure for table `content_pages` */

DROP TABLE IF EXISTS `content_pages`;

CREATE TABLE `content_pages` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `name` varchar(255) NOT NULL,
  `markup_style_id` int(11) default NULL,
  `content` text,
  `permission_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY `fk_content_page_permission_id` (`permission_id`),
  KEY `fk_content_page_markup_style_id` (`markup_style_id`),
  CONSTRAINT `fk_content_page_markup_style_id` FOREIGN KEY (`markup_style_id`) REFERENCES `markup_styles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_content_page_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `controller_actions` */

DROP TABLE IF EXISTS `controller_actions`;

CREATE TABLE `controller_actions` (
  `id` int(11) NOT NULL auto_increment,
  `site_controller_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `permission_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_controller_action_permission_id` (`permission_id`),
  KEY `fk_controller_action_site_controller_id` (`site_controller_id`),
  CONSTRAINT `fk_controller_action_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_controller_action_site_controller_id` FOREIGN KEY (`site_controller_id`) REFERENCES `site_controllers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `data_concepts` */

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

/*Table structure for table `data_contexts` */

DROP TABLE IF EXISTS `data_contexts`;

CREATE TABLE `data_contexts` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL default '',
  `description` text,
  `access_control_id` int(11) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_by` varchar(32) NOT NULL default 'sys',
  `created_at` datetime NOT NULL,
  `updated_by` varchar(32) NOT NULL default 'sys',
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `data_contexts_idx1` (`updated_by`),
  KEY `data_contexts_idx2` (`updated_at`),
  KEY `data_contexts_idx3` (`created_by`),
  KEY `data_contexts_idx4` (`created_at`),
  KEY `data_contexts_name_idx` (`name`),
  KEY `data_contexts_acl_idx` (`access_control_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `data_elements` */

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

/*Table structure for table `data_formats` */

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

/*Table structure for table `data_relations` */

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

/*Table structure for table `data_systems` */

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

/*Table structure for table `data_types` */

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

/*Table structure for table `db_files` */

DROP TABLE IF EXISTS `db_files`;

CREATE TABLE `db_files` (
  `id` int(11) NOT NULL auto_increment,
  `data` longblob,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `engine_schema_info` */

DROP TABLE IF EXISTS `engine_schema_info`;

CREATE TABLE `engine_schema_info` (
  `engine_name` varchar(255) default NULL,
  `version` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `experiment_logs` */

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
  `comments` varchar(255) default NULL,
  `created_by` varchar(255) default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `experiment_logs_experiment_id_index` (`experiment_id`),
  KEY `experiment_logs_user_id_index` (`user_id`),
  KEY `experiment_logs_auditable_type_index` (`auditable_type`,`auditable_id`),
  KEY `experiment_logs_created_at_index` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `experiment_statistics` */

DROP TABLE IF EXISTS `experiment_statistics`;

/*!50001 DROP VIEW IF EXISTS `experiment_statistics` */;
/*!50001 DROP TABLE IF EXISTS `experiment_statistics` */;

/*!50001 CREATE TABLE `experiment_statistics` (
  `id` bigint(20) default NULL,
  `experiment_id` int(11) NOT NULL default '0',
  `study_parameter_id` int(11) default NULL,
  `parameter_role_id` int(11) default NULL,
  `parameter_type_id` int(11) default NULL,
  `data_type_id` int(11) default NULL,
  `avg_values` double default NULL,
  `stddev_values` double default NULL,
  `num_values` bigint(20) NOT NULL default '0',
  `num_unique` bigint(20) NOT NULL default '0',
  `max_values` double default NULL,
  `min_values` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 */;

/*Table structure for table `experiments` */

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

/*Table structure for table `identifiers` */

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

/*Table structure for table `list_items` */

DROP TABLE IF EXISTS `list_items`;

CREATE TABLE `list_items` (
  `id` int(11) NOT NULL auto_increment,
  `list_id` int(11) default NULL,
  `data_type` varchar(255) default NULL,
  `data_id` int(11) default NULL,
  `data_name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `lists` */

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

/*Table structure for table `logging_events` */

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

/*Table structure for table `markup_styles` */

DROP TABLE IF EXISTS `markup_styles`;

CREATE TABLE `markup_styles` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `memberships` */

DROP TABLE IF EXISTS `memberships`;

CREATE TABLE `memberships` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `project_id` int(11) NOT NULL default '0',
  `role_id` int(11) NOT NULL default '0',
  `is_owner` tinyint(1) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `menu_items` */

DROP TABLE IF EXISTS `menu_items`;

CREATE TABLE `menu_items` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) default NULL,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `seq` int(11) default NULL,
  `controller_action_id` int(11) default NULL,
  `content_page_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_menu_item_controller_action_id` (`controller_action_id`),
  KEY `fk_menu_item_content_page_id` (`content_page_id`),
  KEY `fk_menu_item_parent_id` (`parent_id`),
  CONSTRAINT `fk_menu_item_content_page_id` FOREIGN KEY (`content_page_id`) REFERENCES `content_pages` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_menu_item_controller_action_id` FOREIGN KEY (`controller_action_id`) REFERENCES `controller_actions` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_menu_item_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `menu_items` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `mixtures` */

DROP TABLE IF EXISTS `mixtures`;

CREATE TABLE `mixtures` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `composition_id` int(11) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `molecules` */

DROP TABLE IF EXISTS `molecules`;

CREATE TABLE `molecules` (
  `id` int(11) NOT NULL auto_increment,
  `cas` varchar(50) NOT NULL,
  `name` varchar(255) default NULL,
  `formula` varchar(50) default NULL,
  `mass` float default NULL,
  `smiles` varchar(255) default NULL,
  `cd_id` int(11) NOT NULL,
  `compound_ref` varchar(50) default NULL,
  `iupac_name` varchar(255) default NULL,
  `comments` varchar(50) default NULL,
  `cd_structure` mediumblob NOT NULL,
  `cd_mol_file` text,
  `cd_smiles` text,
  `cd_formula` varchar(100) default NULL,
  `cd_molweight` double default NULL,
  `cd_hash` int(11) NOT NULL,
  `cd_flags` varchar(20) default NULL,
  `cd_timestamp` datetime NOT NULL,
  `cd_fp1` int(11) NOT NULL,
  `cd_fp2` int(11) NOT NULL,
  `cd_fp3` int(11) NOT NULL,
  `cd_fp4` int(11) NOT NULL,
  `cd_fp5` int(11) NOT NULL,
  `cd_fp6` int(11) NOT NULL,
  `cd_fp7` int(11) NOT NULL,
  `cd_fp8` int(11) NOT NULL,
  `cd_fp9` int(11) NOT NULL,
  `cd_fp10` int(11) NOT NULL,
  `cd_fp11` int(11) NOT NULL,
  `cd_fp12` int(11) NOT NULL,
  `cd_fp13` int(11) NOT NULL,
  `cd_fp14` int(11) NOT NULL,
  `cd_fp15` int(11) NOT NULL,
  `cd_fp16` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `molecules_UL` */

DROP TABLE IF EXISTS `molecules_UL`;

CREATE TABLE `molecules_UL` (
  `update_id` int(11) NOT NULL auto_increment,
  `update_info` varchar(20) NOT NULL,
  PRIMARY KEY  (`update_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Table structure for table `parameter_contexts` */

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

/*Table structure for table `parameter_roles` */

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

/*Table structure for table `parameter_types` */

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

/*Table structure for table `parameters` */

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

/*Table structure for table `permissions` */

DROP TABLE IF EXISTS `permissions`;

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL auto_increment,
  `checked` tinyint(1) NOT NULL default '0',
  `subject` varchar(255) NOT NULL default '',
  `action` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=949 DEFAULT CHARSET=latin1;

/*Table structure for table `plate_formats` */

DROP TABLE IF EXISTS `plate_formats`;

CREATE TABLE `plate_formats` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `description` text,
  `num_rows` int(11) default NULL,
  `num_columns` int(11) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `plate_wells` */

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

/*Table structure for table `plates` */

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

/*Table structure for table `plugin_schema_info` */

DROP TABLE IF EXISTS `plugin_schema_info`;

CREATE TABLE `plugin_schema_info` (
  `plugin_name` varchar(255) default NULL,
  `version` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `process_statistics` */

DROP TABLE IF EXISTS `process_statistics`;

/*!50001 DROP VIEW IF EXISTS `process_statistics` */;
/*!50001 DROP TABLE IF EXISTS `process_statistics` */;

/*!50001 CREATE TABLE `process_statistics` (
  `id` int(11) NOT NULL default '0',
  `study_parameter_id` int(11) default NULL,
  `protocol_version_id` int(11) default NULL,
  `parameter_id` int(11) default NULL,
  `parameter_role_id` int(11) default NULL,
  `parameter_type_id` int(11) default NULL,
  `avg_values` double default NULL,
  `stddev_values` double default NULL,
  `num_values` bigint(20) NOT NULL default '0',
  `num_unique` bigint(20) NOT NULL default '0',
  `max_values` double default NULL,
  `min_values` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 */;

/*Table structure for table `project_assets` */

DROP TABLE IF EXISTS `project_assets`;

CREATE TABLE `project_assets` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `title` varchar(255) default NULL,
  `parent_id` int(11) default NULL,
  `content_type` varchar(255) default NULL,
  `filename` varchar(255) default NULL,
  `thumbnail` varchar(255) default NULL,
  `size_bytes` int(11) default NULL,
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

/*Table structure for table `project_contents` */

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

/*Table structure for table `project_elements` */

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

/*Table structure for table `projects` */

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

/*Table structure for table `protocol_versions` */

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

/*Table structure for table `queue_items` */

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

/*Table structure for table `queue_result_texts` */

DROP TABLE IF EXISTS `queue_result_texts`;

/*!50001 DROP VIEW IF EXISTS `queue_result_texts` */;
/*!50001 DROP TABLE IF EXISTS `queue_result_texts` */;

/*!50001 CREATE TABLE `queue_result_texts` (
  `id` int(11) NOT NULL default '0',
  `row_no` int(11) NOT NULL,
  `column_no` int(11) default NULL,
  `task_id` int(11) default NULL,
  `queue_item_id` int(11) NOT NULL default '0',
  `request_service_id` int(11) default NULL,
  `study_queue_id` int(11) default NULL,
  `parameter_context_id` int(11) default NULL,
  `task_context_id` int(11) default NULL,
  `reference_parameter_id` int(11) default NULL,
  `data_element_id` int(11) default NULL,
  `data_type` varchar(255) default NULL,
  `data_id` int(11) default NULL,
  `subject` varchar(255) default NULL,
  `parameter_id` int(11) default NULL,
  `protocol_version_id` int(11) default NULL,
  `label` varchar(255) default NULL,
  `row_label` varchar(255) default NULL,
  `parameter_name` varchar(62) default NULL,
  `data_value` text,
  `created_by_user_id` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '0',
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 */;

/*Table structure for table `queue_result_values` */

DROP TABLE IF EXISTS `queue_result_values`;

/*!50001 DROP VIEW IF EXISTS `queue_result_values` */;
/*!50001 DROP TABLE IF EXISTS `queue_result_values` */;

/*!50001 CREATE TABLE `queue_result_values` (
  `id` int(11) NOT NULL default '0',
  `row_no` int(11) NOT NULL,
  `column_no` int(11) default NULL,
  `task_id` int(11) default NULL,
  `queue_item_id` int(11) NOT NULL default '0',
  `request_service_id` int(11) default NULL,
  `study_queue_id` int(11) default NULL,
  `parameter_context_id` int(11) default NULL,
  `task_context_id` int(11) default NULL,
  `reference_parameter_id` int(11) default NULL,
  `data_element_id` int(11) default NULL,
  `data_type` varchar(255) default NULL,
  `data_id` int(11) default NULL,
  `subject` varchar(255) default NULL,
  `parameter_id` int(11) default NULL,
  `protocol_version_id` int(11) default NULL,
  `label` varchar(255) default NULL,
  `row_label` varchar(255) default NULL,
  `parameter_name` varchar(62) default NULL,
  `data_value` double default NULL,
  `created_by_user_id` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '0',
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 */;

/*Table structure for table `queue_results` */

DROP TABLE IF EXISTS `queue_results`;

/*!50001 DROP VIEW IF EXISTS `queue_results` */;
/*!50001 DROP TABLE IF EXISTS `queue_results` */;

/*!50001 CREATE TABLE `queue_results` (
  `id` int(11) NOT NULL default '0',
  `row_no` int(11) NOT NULL default '0',
  `column_no` int(11) default NULL,
  `task_id` int(11) default NULL,
  `queue_item_id` int(11) NOT NULL default '0',
  `request_service_id` int(11) default NULL,
  `study_queue_id` int(11) default NULL,
  `requested_by_user_id` int(11) default NULL,
  `assigned_to_user_id` int(11) default NULL,
  `parameter_context_id` int(11) default NULL,
  `task_context_id` int(11) default NULL,
  `reference_parameter_id` int(11) default NULL,
  `data_element_id` int(11) default NULL,
  `data_type` varchar(255) default NULL,
  `data_id` int(11) default NULL,
  `subject` varchar(255) default NULL,
  `parameter_id` int(11) default NULL,
  `protocol_version_id` int(11) default NULL,
  `label` varchar(255) default NULL,
  `row_label` varchar(255) default NULL,
  `parameter_name` varchar(62) default NULL,
  `data_value` blob,
  `created_by_user_id` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated_by_user_id` int(11) NOT NULL default '0',
  `updated_at` datetime NOT NULL default '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 */;

/*Table structure for table `reactions` */

DROP TABLE IF EXISTS `reactions`;

CREATE TABLE `reactions` (
  `cd_id` int(11) NOT NULL auto_increment,
  `cd_structure` mediumblob NOT NULL,
  `cd_smiles` text,
  `cd_formula` varchar(100) default NULL,
  `cd_molweight` double default NULL,
  `cd_hash` int(11) NOT NULL,
  `cd_flags` varchar(20) default NULL,
  `cd_timestamp` datetime NOT NULL,
  `cd_fp1` int(11) NOT NULL,
  `cd_fp2` int(11) NOT NULL,
  `cd_fp3` int(11) NOT NULL,
  `cd_fp4` int(11) NOT NULL,
  `cd_fp5` int(11) NOT NULL,
  `cd_fp6` int(11) NOT NULL,
  `cd_fp7` int(11) NOT NULL,
  `cd_fp8` int(11) NOT NULL,
  `cd_fp9` int(11) NOT NULL,
  `cd_fp10` int(11) NOT NULL,
  `cd_fp11` int(11) NOT NULL,
  `cd_fp12` int(11) NOT NULL,
  `cd_fp13` int(11) NOT NULL,
  `cd_fp14` int(11) NOT NULL,
  `cd_fp15` int(11) NOT NULL,
  `cd_fp16` int(11) NOT NULL,
  `cd_fp17` int(11) NOT NULL,
  `cd_fp18` int(11) NOT NULL,
  `cd_fp19` int(11) NOT NULL,
  `cd_fp20` int(11) NOT NULL,
  `cd_fp21` int(11) NOT NULL,
  `cd_fp22` int(11) NOT NULL,
  `cd_fp23` int(11) NOT NULL,
  `cd_fp24` int(11) NOT NULL,
  `cd_fp25` int(11) NOT NULL,
  `cd_fp26` int(11) NOT NULL,
  `cd_fp27` int(11) NOT NULL,
  `cd_fp28` int(11) NOT NULL,
  `cd_fp29` int(11) NOT NULL,
  `cd_fp30` int(11) NOT NULL,
  `cd_fp31` int(11) NOT NULL,
  `cd_fp32` int(11) NOT NULL,
  `cd_fp33` int(11) NOT NULL,
  `cd_fp34` int(11) NOT NULL,
  `cd_fp35` int(11) NOT NULL,
  `cd_fp36` int(11) NOT NULL,
  `cd_fp37` int(11) NOT NULL,
  `cd_fp38` int(11) NOT NULL,
  `cd_fp39` int(11) NOT NULL,
  `cd_fp40` int(11) NOT NULL,
  `cd_fp41` int(11) NOT NULL,
  `cd_fp42` int(11) NOT NULL,
  `cd_fp43` int(11) NOT NULL,
  `cd_fp44` int(11) NOT NULL,
  `cd_fp45` int(11) NOT NULL,
  `cd_fp46` int(11) NOT NULL,
  `cd_fp47` int(11) NOT NULL,
  `cd_fp48` int(11) NOT NULL,
  `cd_fp49` int(11) NOT NULL,
  `cd_fp50` int(11) NOT NULL,
  `cd_fp51` int(11) NOT NULL,
  `cd_fp52` int(11) NOT NULL,
  `cd_fp53` int(11) NOT NULL,
  `cd_fp54` int(11) NOT NULL,
  `cd_fp55` int(11) NOT NULL,
  `cd_fp56` int(11) NOT NULL,
  `cd_fp57` int(11) NOT NULL,
  `cd_fp58` int(11) NOT NULL,
  `cd_fp59` int(11) NOT NULL,
  `cd_fp60` int(11) NOT NULL,
  `cd_fp61` int(11) NOT NULL,
  `cd_fp62` int(11) NOT NULL,
  `cd_fp63` int(11) NOT NULL,
  `cd_fp64` int(11) NOT NULL,
  PRIMARY KEY  (`cd_id`),
  KEY `reactions_hx` (`cd_hash`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `reactions_UL` */

DROP TABLE IF EXISTS `reactions_UL`;

CREATE TABLE `reactions_UL` (
  `update_id` int(11) NOT NULL auto_increment,
  `update_info` varchar(20) NOT NULL,
  PRIMARY KEY  (`update_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `registrations` */

DROP TABLE IF EXISTS `registrations`;

CREATE TABLE `registrations` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `description` text,
  `registration_date` datetime default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_by_user_id` int(32) NOT NULL default '1',
  `created_at` datetime NOT NULL,
  `updated_by_user_id` int(32) NOT NULL default '1',
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `report_columns` */

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

/*Table structure for table `reports` */

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

/*Table structure for table `request_lists` */

DROP TABLE IF EXISTS `request_lists`;

CREATE TABLE `request_lists` (
  `id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `request_services` */

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

/*Table structure for table `requests` */

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

/*Table structure for table `role_permissions` */

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

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `parent_id` int(11) default NULL,
  `description` varchar(1024) NOT NULL,
  `cache` longtext,
  `created_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL default '0000-00-00 00:00:00',
  `created_by_user_id` int(11) NOT NULL default '1',
  `updated_by_user_id` int(11) NOT NULL default '1',
  `type` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_role_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `roles_permissions` */

DROP TABLE IF EXISTS `roles_permissions`;

CREATE TABLE `roles_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_roles_permission_role_id` (`role_id`),
  KEY `fk_roles_permission_permission_id` (`permission_id`),
  CONSTRAINT `fk_roles_permission_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_roles_permission_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `samples` */

DROP TABLE IF EXISTS `samples`;

CREATE TABLE `samples` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `batch_id` int(11) default NULL,
  `container_id` int(11) default NULL,
  `composition_id` int(11) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '1',
  `created_by_user_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `schema_info` */

DROP TABLE IF EXISTS `schema_info`;

CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `sessions` */

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL auto_increment,
  `session_id` varchar(255) NOT NULL,
  `data` longtext,
  `created_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `site_controllers` */

DROP TABLE IF EXISTS `site_controllers`;

CREATE TABLE `site_controllers` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `builtin` int(10) unsigned default '0',
  PRIMARY KEY  (`id`),
  KEY `fk_site_controller_permission_id` (`permission_id`),
  CONSTRAINT `fk_site_controller_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `specimens` */

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

/*Table structure for table `studies` */

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

/*Table structure for table `study_logs` */

DROP TABLE IF EXISTS `study_logs`;

CREATE TABLE `study_logs` (
  `id` int(11) NOT NULL auto_increment,
  `study_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `auditable_id` int(11) default NULL,
  `auditable_type` varchar(255) default NULL,
  `action` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `comments` varchar(255) default NULL,
  `changes` text,
  `created_by` varchar(255) default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `study_logs_study_id_index` (`study_id`),
  KEY `study_logs_user_id_index` (`user_id`),
  KEY `study_logs_auditable_type_index` (`auditable_type`,`auditable_id`),
  KEY `study_logs_created_at_index` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `study_parameters` */

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

/*Table structure for table `study_protocols` */

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

/*Table structure for table `study_queues` */

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

/*Table structure for table `study_stages` */

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

/*Table structure for table `study_statistics` */

DROP TABLE IF EXISTS `study_statistics`;

/*!50001 DROP VIEW IF EXISTS `study_statistics` */;
/*!50001 DROP TABLE IF EXISTS `study_statistics` */;

/*!50001 CREATE TABLE `study_statistics` (
  `id` int(11) default NULL,
  `study_id` int(11) NOT NULL default '0',
  `parameter_role_id` int(11) default NULL,
  `parameter_type_id` int(11) default NULL,
  `data_type_id` int(11) default NULL,
  `avg_values` double default NULL,
  `stddev_values` double default NULL,
  `num_values` bigint(20) NOT NULL default '0',
  `num_unique` bigint(20) NOT NULL default '0',
  `max_values` double default NULL,
  `min_values` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 */;

/*Table structure for table `system_settings` */

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

/*Table structure for table `taggings` */

DROP TABLE IF EXISTS `taggings`;

CREATE TABLE `taggings` (
  `id` int(11) NOT NULL auto_increment,
  `tag_id` int(11) default NULL,
  `taggable_id` int(11) default NULL,
  `taggable_type` varchar(255) default NULL,
  `created_at` timestamp NULL default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tags` */

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `task_contexts` */

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

/*Table structure for table `task_files` */

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
  `created_by` varchar(32) NOT NULL default '',
  `created_at` datetime NOT NULL,
  `updated_by` varchar(32) NOT NULL default '',
  `updated_at` datetime NOT NULL,
  `task_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `task_references` */

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

/*Table structure for table `task_relations` */

DROP TABLE IF EXISTS `task_relations`;

CREATE TABLE `task_relations` (
  `id` int(11) NOT NULL auto_increment,
  `to_task_id` int(11) default NULL,
  `from_task_id` int(11) default NULL,
  `relation_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `task_result_texts` */

DROP TABLE IF EXISTS `task_result_texts`;

/*!50001 DROP VIEW IF EXISTS `task_result_texts` */;
/*!50001 DROP TABLE IF EXISTS `task_result_texts` */;

/*!50001 CREATE TABLE `task_result_texts` (
  `id` int(11) NOT NULL default '0',
  `row_no` int(11) NOT NULL,
  `column_no` int(11) default NULL,
  `task_id` int(11) default NULL,
  `parameter_context_id` int(11) default NULL,
  `task_context_id` int(11) default NULL,
  `reference_parameter_id` int(11) default NULL,
  `data_element_id` int(11) default NULL,
  `data_type` varchar(255) default NULL,
  `data_id` int(11) default NULL,
  `subject` varchar(255) default NULL,
  `parameter_id` int(11) default NULL,
  `protocol_version_id` int(11) default NULL,
  `label` varchar(255) default NULL,
  `row_label` varchar(255) default NULL,
  `parameter_name` varchar(62) default NULL,
  `data_value` text,
  `created_by_user_id` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_by_user_id` int(11) NOT NULL default '0',
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 */;

/*Table structure for table `task_result_values` */

DROP TABLE IF EXISTS `task_result_values`;

/*!50001 DROP VIEW IF EXISTS `task_result_values` */;
/*!50001 DROP TABLE IF EXISTS `task_result_values` */;

/*!50001 CREATE TABLE `task_result_values` (
  `id` int(11) NOT NULL default '0',
  `row_no` int(11) NOT NULL,
  `column_no` int(11) default NULL,
  `task_id` int(11) default NULL,
  `parameter_context_id` int(11) default NULL,
  `task_context_id` int(11) default NULL,
  `reference_parameter_id` int(11) default NULL,
  `data_element_id` int(11) default NULL,
  `data_type` varchar(255) default NULL,
  `data_id` int(11) default NULL,
  `subject` varchar(255) default NULL,
  `parameter_id` int(11) default NULL,
  `protocol_version_id` int(11) default NULL,
  `label` varchar(255) default NULL,
  `row_label` varchar(255) default NULL,
  `parameter_name` varchar(62) default NULL,
  `data_value` double default NULL,
  `created_by_USER_ID` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_by_USER_ID` int(11) NOT NULL default '0',
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 */;

/*Table structure for table `task_results` */

DROP TABLE IF EXISTS `task_results`;

/*!50001 DROP VIEW IF EXISTS `task_results` */;
/*!50001 DROP TABLE IF EXISTS `task_results` */;

/*!50001 CREATE TABLE `task_results` (
  `id` int(11) NOT NULL default '0',
  `protocol_version_id` int(11) default NULL,
  `parameter_context_id` int(11) NOT NULL default '0',
  `label` varchar(255) default NULL,
  `row_label` varchar(255) default NULL,
  `row_no` int(11) NOT NULL default '0',
  `column_no` int(11) default NULL,
  `task_id` int(11) default NULL,
  `parameter_id` int(11) default NULL,
  `parameter_name` varchar(62) default NULL,
  `data_value` blob,
  `created_by_user_id` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated_by_user_id` int(11) NOT NULL default '0',
  `updated_at` datetime NOT NULL default '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 */;

/*Table structure for table `task_statistics` */

DROP TABLE IF EXISTS `task_statistics`;

/*!50001 DROP VIEW IF EXISTS `task_statistics` */;
/*!50001 DROP TABLE IF EXISTS `task_statistics` */;

/*!50001 CREATE TABLE `task_statistics` (
  `id` bigint(20) default NULL,
  `task_id` int(11) default NULL,
  `parameter_id` int(11) default NULL,
  `parameter_role_id` int(11) default NULL,
  `parameter_type_id` int(11) default NULL,
  `data_type_id` int(11) default NULL,
  `avg_values` double default NULL,
  `stddev_values` double default NULL,
  `num_values` bigint(20) NOT NULL default '0',
  `num_unique` bigint(20) NOT NULL default '0',
  `max_values` blob,
  `min_values` blob
) ENGINE=MyISAM DEFAULT CHARSET=latin1 */;

/*Table structure for table `task_stats1` */

DROP TABLE IF EXISTS `task_stats1`;

/*!50001 DROP VIEW IF EXISTS `task_stats1` */;
/*!50001 DROP TABLE IF EXISTS `task_stats1` */;

/*!50001 CREATE TABLE `task_stats1` (
  `task_id` int(11) default NULL,
  `parameter_role_id` int(11) default NULL,
  `parameter_type_id` int(11) default NULL,
  `data_type_id` int(11) default NULL,
  `avg_values` double default NULL,
  `stddev_values` double default NULL,
  `num_values` bigint(20) NOT NULL default '0',
  `num_unique` bigint(20) NOT NULL default '0',
  `max_values` double default NULL,
  `min_values` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 */;

/*Table structure for table `task_stats2` */

DROP TABLE IF EXISTS `task_stats2`;

/*!50001 DROP VIEW IF EXISTS `task_stats2` */;
/*!50001 DROP TABLE IF EXISTS `task_stats2` */;

/*!50001 CREATE TABLE `task_stats2` (
  `task_id` int(11) default NULL,
  `parameter_id` int(11) default NULL,
  `avg_values` double default NULL,
  `stddev_values` double default NULL,
  `num_values` bigint(20) NOT NULL default '0',
  `num_unique` bigint(20) NOT NULL default '0',
  `max_values` double default NULL,
  `min_values` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 */;

/*Table structure for table `task_texts` */

DROP TABLE IF EXISTS `task_texts`;

CREATE TABLE `task_texts` (
  `id` int(11) NOT NULL auto_increment,
  `task_context_id` int(11) default NULL,
  `parameter_id` int(11) default NULL,
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

/*Table structure for table `task_values` */

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

/*Table structure for table `tasks` */

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

/*Table structure for table `tmp_data` */

DROP TABLE IF EXISTS `tmp_data`;

CREATE TABLE `tmp_data` (
  `id` int(10) unsigned NOT NULL auto_increment,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `treatment_groups` */

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

/*Table structure for table `treatment_items` */

DROP TABLE IF EXISTS `treatment_items`;

CREATE TABLE `treatment_items` (
  `id` int(11) NOT NULL auto_increment,
  `treatment_group_id` int(11) NOT NULL,
  `subject_type` varchar(255) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `sequence_order` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `user_settings` */

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

/*Table structure for table `users` */

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
  `is_disabled` tinyint(1) default '0',
  PRIMARY KEY  (`id`),
  KEY `fk_user_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `work_status` */

DROP TABLE IF EXISTS `work_status`;

CREATE TABLE `work_status` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `lock_version` int(11) NOT NULL default '0',
  `created_by` varchar(32) NOT NULL default '',
  `created_at` datetime NOT NULL,
  `updated_by` varchar(32) NOT NULL default '',
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*View structure for view compound_results */

/*!50001 DROP TABLE IF EXISTS `compound_results` */;
/*!50001 DROP VIEW IF EXISTS `compound_results` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`biorails`@`%` SQL SECURITY DEFINER VIEW `compound_results` AS select `ti`.`id` AS `id`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`p`.`parameter_context_id` AS `parameter_context_id`,`tr`.`task_context_id` AS `task_context_id`,`tr`.`data_element_id` AS `data_element_id`,`tr`.`parameter_id` AS `compound_parameter_id`,`tr`.`data_id` AS `compound_id`,`tr`.`data_name` AS `compound_name`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`ti`.`parameter_id` AS `parameter_id`,`p`.`name` AS `parameter_name`,`ti`.`data_value` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from ((((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_references` `tr`) join `task_values` `ti`) where ((`tc`.`id` = `tr`.`task_context_id`) and (`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`) and (`tr`.`data_type` = _latin1'Compound')) */;

/*View structure for view experiment_statistics */

/*!50001 DROP TABLE IF EXISTS `experiment_statistics` */;
/*!50001 DROP VIEW IF EXISTS `experiment_statistics` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`biorails`@`localhost` SQL SECURITY DEFINER VIEW `experiment_statistics` AS select ((`t`.`experiment_id` * 1000000) + `p`.`study_parameter_id`) AS `id`,`t`.`experiment_id` AS `experiment_id`,`p`.`study_parameter_id` AS `study_parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,avg(`r`.`data_value`) AS `avg_values`,std(`r`.`data_value`) AS `stddev_values`,count(`r`.`data_value`) AS `num_values`,count(distinct `r`.`data_value`) AS `num_unique`,max(`r`.`data_value`) AS `max_values`,min(`r`.`data_value`) AS `min_values` from ((`task_values` `r` join `parameters` `p`) join `tasks` `t`) where ((`p`.`id` = `r`.`parameter_id`) and (`t`.`id` = `r`.`task_id`) and (`p`.`study_parameter_id` is not null)) group by `t`.`experiment_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id`,`p`.`study_parameter_id` union select ((`t`.`experiment_id` * 1000000) + `p`.`study_parameter_id`) AS `id`,`t`.`experiment_id` AS `experiment_id`,`p`.`study_parameter_id` AS `study_parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_content`) AS `num_unique`,sum(NULL) AS `max_values`,sum(NULL) AS `min_values` from ((`task_texts` `r` join `parameters` `p`) join `tasks` `t`) where ((`p`.`id` = `r`.`parameter_id`) and (`p`.`study_parameter_id` is not null) and (`t`.`id` = `r`.`task_id`)) group by `t`.`experiment_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id`,`p`.`study_parameter_id` union select ((`t`.`experiment_id` * 1000000) + `p`.`study_parameter_id`) AS `id`,`t`.`experiment_id` AS `experiment_id`,`p`.`study_parameter_id` AS `study_parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_name`) AS `num_unique`,max(`r`.`data_id`) AS `max_values`,min(`r`.`data_id`) AS `min_values` from ((`task_references` `r` join `parameters` `p`) join `tasks` `t`) where ((`p`.`id` = `r`.`parameter_id`) and (`p`.`study_parameter_id` is not null) and (`t`.`id` = `r`.`task_id`)) group by `t`.`experiment_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id`,`p`.`study_parameter_id` */;

/*View structure for view process_statistics */

/*!50001 DROP TABLE IF EXISTS `process_statistics` */;
/*!50001 DROP VIEW IF EXISTS `process_statistics` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`biorails`@`localhost` SQL SECURITY DEFINER VIEW `process_statistics` AS select `p`.`id` AS `id`,`p`.`study_parameter_id` AS `study_parameter_id`,`p`.`protocol_version_id` AS `protocol_version_id`,`r`.`parameter_id` AS `parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,avg(`r`.`data_value`) AS `avg_values`,std(`r`.`data_value`) AS `stddev_values`,count(`r`.`data_value`) AS `num_values`,count(distinct `r`.`data_value`) AS `num_unique`,max(`r`.`data_value`) AS `max_values`,min(`r`.`data_value`) AS `min_values` from (`task_values` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `p`.`study_parameter_id`,`p`.`protocol_version_id`,`r`.`parameter_id`,`p`.`id` union select `p`.`id` AS `id`,`p`.`study_parameter_id` AS `study_parameter_id`,`p`.`protocol_version_id` AS `protocol_version_id`,`r`.`parameter_id` AS `parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_content`) AS `num_unique`,sum(NULL) AS `max_values`,sum(NULL) AS `min_values` from (`task_texts` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `p`.`study_parameter_id`,`p`.`protocol_version_id`,`r`.`parameter_id`,`p`.`id` union select `p`.`id` AS `id`,`p`.`study_parameter_id` AS `study_parameter_id`,`p`.`protocol_version_id` AS `protocol_version_id`,`r`.`parameter_id` AS `parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_name`) AS `num_unique`,max(`r`.`data_id`) AS `max_values`,min(`r`.`data_id`) AS `min_values` from (`task_references` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `p`.`study_parameter_id`,`p`.`protocol_version_id`,`r`.`parameter_id`,`p`.`id` */;

/*View structure for view queue_result_texts */

/*!50001 DROP TABLE IF EXISTS `queue_result_texts` */;
/*!50001 DROP VIEW IF EXISTS `queue_result_texts` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`biorails`@`%` SQL SECURITY DEFINER VIEW `queue_result_texts` AS select `ti`.`id` AS `id`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`qi`.`id` AS `queue_item_id`,`qi`.`request_service_id` AS `request_service_id`,`qi`.`study_queue_id` AS `study_queue_id`,`p`.`parameter_context_id` AS `parameter_context_id`,`tr`.`task_context_id` AS `task_context_id`,`tr`.`parameter_id` AS `reference_parameter_id`,`tr`.`data_element_id` AS `data_element_id`,`tr`.`data_type` AS `data_type`,`tr`.`data_id` AS `data_id`,`tr`.`data_name` AS `subject`,`ti`.`parameter_id` AS `parameter_id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`p`.`name` AS `parameter_name`,`ti`.`data_content` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from (((((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_references` `tr`) join `task_texts` `ti`) join `queue_items` `qi`) where ((`tc`.`id` = `tr`.`task_context_id`) and (`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`) and (`qi`.`task_id` = `tr`.`task_id`) and (`qi`.`data_id` = `tr`.`data_id`) and (`qi`.`data_type` = `tr`.`data_type`) and (`qi`.`data_name` = `tr`.`data_name`)) */;

/*View structure for view queue_result_values */

/*!50001 DROP TABLE IF EXISTS `queue_result_values` */;
/*!50001 DROP VIEW IF EXISTS `queue_result_values` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`biorails`@`%` SQL SECURITY DEFINER VIEW `queue_result_values` AS select `ti`.`id` AS `id`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`qi`.`id` AS `queue_item_id`,`qi`.`request_service_id` AS `request_service_id`,`qi`.`study_queue_id` AS `study_queue_id`,`p`.`parameter_context_id` AS `parameter_context_id`,`tr`.`task_context_id` AS `task_context_id`,`tr`.`parameter_id` AS `reference_parameter_id`,`tr`.`data_element_id` AS `data_element_id`,`tr`.`data_type` AS `data_type`,`tr`.`data_id` AS `data_id`,`tr`.`data_name` AS `subject`,`ti`.`parameter_id` AS `parameter_id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`p`.`name` AS `parameter_name`,`ti`.`data_value` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from (((((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_references` `tr`) join `task_values` `ti`) join `queue_items` `qi`) where ((`tc`.`id` = `tr`.`task_context_id`) and (`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`) and (`qi`.`task_id` = `tr`.`task_id`) and (`qi`.`data_id` = `tr`.`data_id`) and (`qi`.`data_type` = `tr`.`data_type`) and (`qi`.`data_name` = `tr`.`data_name`)) */;

/*View structure for view queue_results */

/*!50001 DROP TABLE IF EXISTS `queue_results` */;
/*!50001 DROP VIEW IF EXISTS `queue_results` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`biorails`@`%` SQL SECURITY DEFINER VIEW `queue_results` AS select `ti`.`id` AS `id`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`qi`.`id` AS `queue_item_id`,`qi`.`request_service_id` AS `request_service_id`,`qi`.`study_queue_id` AS `study_queue_id`,`qi`.`requested_by_user_id` AS `requested_by_user_id`,`qi`.`assigned_to_user_id` AS `assigned_to_user_id`,`p`.`parameter_context_id` AS `parameter_context_id`,`tr`.`task_context_id` AS `task_context_id`,`tr`.`parameter_id` AS `reference_parameter_id`,`tr`.`data_element_id` AS `data_element_id`,`tr`.`data_type` AS `data_type`,`tr`.`data_id` AS `data_id`,`tr`.`data_name` AS `subject`,`ti`.`parameter_id` AS `parameter_id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`p`.`name` AS `parameter_name`,`ti`.`data_content` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from (((((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_references` `tr`) join `task_texts` `ti`) join `queue_items` `qi`) where ((`tc`.`id` = `tr`.`task_context_id`) and (`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`) and (`qi`.`task_id` = `tr`.`task_id`) and (`qi`.`data_id` = `tr`.`data_id`) and (`qi`.`data_type` = `tr`.`data_type`) and (`qi`.`data_name` = `tr`.`data_name`)) union select `ti`.`id` AS `id`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`qi`.`id` AS `queue_item_id`,`qi`.`request_service_id` AS `request_service_id`,`qi`.`study_queue_id` AS `study_queue_id`,`qi`.`requested_by_user_id` AS `requested_by_user_id`,`qi`.`assigned_to_user_id` AS `assigned_to_user_id`,`p`.`parameter_context_id` AS `parameter_context_id`,`tr`.`task_context_id` AS `task_context_id`,`tr`.`parameter_id` AS `reference_parameter_id`,`tr`.`data_element_id` AS `data_element_id`,`tr`.`data_type` AS `data_type`,`tr`.`data_id` AS `data_id`,`tr`.`data_name` AS `subject`,`ti`.`parameter_id` AS `parameter_id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`p`.`name` AS `parameter_name`,`ti`.`data_value` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from (((((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_references` `tr`) join `task_values` `ti`) join `queue_items` `qi`) where ((`tc`.`id` = `tr`.`task_context_id`) and (`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`) and (`qi`.`task_id` = `tr`.`task_id`) and (`qi`.`data_id` = `tr`.`data_id`) and (`qi`.`data_type` = `tr`.`data_type`) and (`qi`.`data_name` = `tr`.`data_name`)) */;

/*View structure for view study_statistics */

/*!50001 DROP TABLE IF EXISTS `study_statistics` */;
/*!50001 DROP VIEW IF EXISTS `study_statistics` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`biorails`@`localhost` SQL SECURITY DEFINER VIEW `study_statistics` AS select `p`.`study_parameter_id` AS `id`,`e`.`study_id` AS `study_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,avg(`r`.`data_value`) AS `avg_values`,std(`r`.`data_value`) AS `stddev_values`,count(`r`.`data_value`) AS `num_values`,count(distinct `r`.`data_value`) AS `num_unique`,max(`r`.`data_value`) AS `max_values`,min(`r`.`data_value`) AS `min_values` from (((`task_values` `r` join `parameters` `p`) join `tasks` `t`) join `experiments` `e`) where ((`p`.`id` = `r`.`parameter_id`) and (`t`.`id` = `r`.`task_id`) and (`e`.`id` = `t`.`experiment_id`) and (`p`.`study_parameter_id` is not null)) group by `e`.`study_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`study_parameter_id` union select `p`.`study_parameter_id` AS `id`,`e`.`study_id` AS `study_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_content`) AS `num_unique`,sum(NULL) AS `max_values`,sum(NULL) AS `min_values` from (((`task_texts` `r` join `parameters` `p`) join `tasks` `t`) join `experiments` `e`) where ((`p`.`id` = `r`.`parameter_id`) and (`t`.`id` = `r`.`task_id`) and (`e`.`id` = `t`.`experiment_id`) and (`p`.`study_parameter_id` is not null)) group by `e`.`study_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`study_parameter_id` union select `p`.`study_parameter_id` AS `id`,`e`.`study_id` AS `study_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_name`) AS `num_unique`,max(`r`.`data_id`) AS `max_values`,min(`r`.`data_id`) AS `min_values` from (((`task_references` `r` join `parameters` `p`) join `tasks` `t`) join `experiments` `e`) where ((`p`.`id` = `r`.`parameter_id`) and (`t`.`id` = `r`.`task_id`) and (`e`.`id` = `t`.`experiment_id`) and (`p`.`study_parameter_id` is not null)) group by `e`.`study_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`study_parameter_id` */;

/*View structure for view task_result_texts */

/*!50001 DROP TABLE IF EXISTS `task_result_texts` */;
/*!50001 DROP VIEW IF EXISTS `task_result_texts` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`biorails`@`%` SQL SECURITY DEFINER VIEW `task_result_texts` AS select `ti`.`id` AS `id`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`p`.`parameter_context_id` AS `parameter_context_id`,`tr`.`task_context_id` AS `task_context_id`,`tr`.`parameter_id` AS `reference_parameter_id`,`tr`.`data_element_id` AS `data_element_id`,`tr`.`data_type` AS `data_type`,`tr`.`data_id` AS `data_id`,`tr`.`data_name` AS `subject`,`ti`.`parameter_id` AS `parameter_id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`p`.`name` AS `parameter_name`,`ti`.`data_content` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from ((((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_references` `tr`) join `task_texts` `ti`) where ((`tc`.`id` = `tr`.`task_context_id`) and (`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`)) */;

/*View structure for view task_result_values */

/*!50001 DROP TABLE IF EXISTS `task_result_values` */;
/*!50001 DROP VIEW IF EXISTS `task_result_values` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`biorails`@`%` SQL SECURITY DEFINER VIEW `task_result_values` AS select `ti`.`id` AS `id`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`p`.`parameter_context_id` AS `parameter_context_id`,`tr`.`task_context_id` AS `task_context_id`,`tr`.`parameter_id` AS `reference_parameter_id`,`tr`.`data_element_id` AS `data_element_id`,`tr`.`data_type` AS `data_type`,`tr`.`data_id` AS `data_id`,`tr`.`data_name` AS `subject`,`ti`.`parameter_id` AS `parameter_id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`p`.`name` AS `parameter_name`,`ti`.`data_value` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_USER_ID`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_USER_ID`,`ti`.`updated_at` AS `updated_at` from ((((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_references` `tr`) join `task_values` `ti`) where ((`tc`.`id` = `tr`.`task_context_id`) and (`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`)) */;

/*View structure for view task_results */

/*!50001 DROP TABLE IF EXISTS `task_results` */;
/*!50001 DROP VIEW IF EXISTS `task_results` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`biorails`@`%` SQL SECURITY DEFINER VIEW `task_results` AS select `ti`.`id` AS `id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`id` AS `parameter_context_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`ti`.`parameter_id` AS `parameter_id`,`p`.`name` AS `parameter_name`,`ti`.`data_value` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from (((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_values` `ti`) where ((`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`)) union select `ti`.`id` AS `id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`id` AS `parameter_context_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`ti`.`parameter_id` AS `parameter_id`,`p`.`name` AS `parameter_name`,`ti`.`data_content` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from (((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_texts` `ti`) where ((`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`)) union select `ti`.`id` AS `id`,`pc`.`protocol_version_id` AS `protocol_version_id`,`pc`.`id` AS `parameter_context_id`,`pc`.`label` AS `label`,`tc`.`label` AS `row_label`,`tc`.`row_no` AS `row_no`,`p`.`column_no` AS `column_no`,`tc`.`task_id` AS `task_id`,`ti`.`parameter_id` AS `parameter_id`,`p`.`name` AS `parameter_name`,`ti`.`data_name` AS `data_value`,`ti`.`created_by_user_id` AS `created_by_user_id`,`ti`.`created_at` AS `created_at`,`ti`.`updated_by_user_id` AS `updated_by_user_id`,`ti`.`updated_at` AS `updated_at` from (((`parameter_contexts` `pc` join `parameters` `p`) join `task_contexts` `tc`) join `task_references` `ti`) where ((`ti`.`task_context_id` = `tc`.`id`) and (`p`.`id` = `ti`.`parameter_id`) and (`pc`.`id` = `tc`.`parameter_context_id`)) */;

/*View structure for view task_statistics */

/*!50001 DROP TABLE IF EXISTS `task_statistics` */;
/*!50001 DROP VIEW IF EXISTS `task_statistics` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`biorails`@`localhost` SQL SECURITY DEFINER VIEW `task_statistics` AS select ((`r`.`task_id` * 100000) + `r`.`parameter_id`) AS `id`,`r`.`task_id` AS `task_id`,`r`.`parameter_id` AS `parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,avg(`r`.`data_value`) AS `avg_values`,std(`r`.`data_value`) AS `stddev_values`,count(`r`.`data_value`) AS `num_values`,count(distinct `r`.`data_value`) AS `num_unique`,max(`r`.`data_value`) AS `max_values`,min(`r`.`data_value`) AS `min_values` from (`task_values` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `r`.`task_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id` union select ((`r`.`task_id` * 100000) + `r`.`parameter_id`) AS `id`,`r`.`task_id` AS `task_id`,`r`.`parameter_id` AS `parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_content`) AS `num_unique`,min(`r`.`data_content`) AS `max_values`,max(`r`.`data_content`) AS `min_values` from (`task_texts` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `r`.`task_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id` union select ((`r`.`task_id` * 100000) + `r`.`parameter_id`) AS `id`,`r`.`task_id` AS `task_id`,`r`.`parameter_id` AS `parameter_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_name`) AS `num_unique`,max(`r`.`data_name`) AS `max_values`,min(`r`.`data_name`) AS `min_values` from (`task_references` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `r`.`task_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id` */;

/*View structure for view task_stats1 */

/*!50001 DROP TABLE IF EXISTS `task_stats1` */;
/*!50001 DROP VIEW IF EXISTS `task_stats1` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `task_stats1` AS select `r`.`task_id` AS `task_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,avg(`r`.`data_value`) AS `avg_values`,std(`r`.`data_value`) AS `stddev_values`,count(`r`.`data_value`) AS `num_values`,count(distinct `r`.`data_value`) AS `num_unique`,max(`r`.`data_value`) AS `max_values`,min(`r`.`data_value`) AS `min_values` from (`task_values` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `r`.`task_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id` union select `r`.`task_id` AS `task_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_content`) AS `num_unique`,sum(NULL) AS `max_values`,sum(NULL) AS `min_values` from (`task_texts` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `r`.`task_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id` union select `r`.`task_id` AS `task_id`,`p`.`parameter_role_id` AS `parameter_role_id`,`p`.`parameter_type_id` AS `parameter_type_id`,`p`.`data_type_id` AS `data_type_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_name`) AS `num_unique`,max(`r`.`data_id`) AS `max_values`,min(`r`.`data_id`) AS `min_values` from (`task_references` `r` join `parameters` `p`) where (`p`.`id` = `r`.`parameter_id`) group by `r`.`task_id`,`p`.`parameter_role_id`,`p`.`parameter_type_id`,`p`.`data_type_id` */;

/*View structure for view task_stats2 */

/*!50001 DROP TABLE IF EXISTS `task_stats2` */;
/*!50001 DROP VIEW IF EXISTS `task_stats2` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `task_stats2` AS select `r`.`task_id` AS `task_id`,`r`.`parameter_id` AS `parameter_id`,avg(`r`.`data_value`) AS `avg_values`,std(`r`.`data_value`) AS `stddev_values`,count(`r`.`data_value`) AS `num_values`,count(distinct `r`.`data_value`) AS `num_unique`,max(`r`.`data_value`) AS `max_values`,min(`r`.`data_value`) AS `min_values` from `task_values` `r` group by `r`.`task_id`,`r`.`parameter_id` union select `r`.`task_id` AS `task_id`,`r`.`parameter_id` AS `parameter_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_content`) AS `num_unique`,sum(NULL) AS `max_values`,sum(NULL) AS `min_values` from `task_texts` `r` group by `r`.`task_id`,`r`.`parameter_id` union select `r`.`task_id` AS `task_id`,`r`.`parameter_id` AS `parameter_id`,sum(NULL) AS `avg_values`,sum(NULL) AS `stddev_values`,count(`r`.`id`) AS `num_values`,count(distinct `r`.`data_name`) AS `num_unique`,max(`r`.`data_id`) AS `max_values`,min(`r`.`data_id`) AS `min_values` from `task_references` `r` group by `r`.`task_id`,`r`.`parameter_id` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
