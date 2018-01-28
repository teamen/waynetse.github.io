-- Adminer 4.3.1 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `_lft` int(10) unsigned NOT NULL DEFAULT 0,
  `_rgt` int(10) unsigned NOT NULL DEFAULT 0,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories__lft__rgt_parent_id_index` (`_lft`,`_rgt`,`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`id`, `name`, `_lft`, `_rgt`, `parent_id`, `created_at`, `updated_at`) VALUES
(1,	'技術',	1,	16,	NULL,	'2018-01-27 23:14:56',	'2018-01-27 23:14:56'),
(2,	'前端',	2,	9,	1,	'2018-01-27 23:14:56',	'2018-01-27 23:14:56'),
(3,	'JavaScript',	3,	4,	2,	'2018-01-27 23:14:56',	'2018-01-27 23:14:56'),
(4,	'CSS',	5,	6,	2,	'2018-01-27 23:14:56',	'2018-01-27 23:14:56'),
(5,	'HTML',	7,	8,	2,	'2018-01-27 23:14:56',	'2018-01-27 23:14:56'),
(6,	'後端',	10,	15,	1,	'2018-01-27 23:14:56',	'2018-01-27 23:14:56'),
(7,	'SQL',	11,	12,	6,	'2018-01-27 23:14:56',	'2018-01-27 23:14:56'),
(8,	'PHP',	13,	14,	6,	'2018-01-27 23:14:56',	'2018-01-27 23:14:56');

-- 2018-01-28 07:46:41
