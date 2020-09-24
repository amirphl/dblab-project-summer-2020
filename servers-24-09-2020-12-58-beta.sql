﻿-- Generation time: Thu, 24 Sep 2020 12:58:29 +0000
-- DB name: u574849695_22
/*!40030 SET NAMES UTF8 */;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `servers`;
CREATE TABLE `servers` (
  `server_id` int(11) NOT NULL AUTO_INCREMENT,
  `bandwidth` double NOT NULL,
  `disk` int(11) NOT NULL,
  `ram` int(11) NOT NULL,
  `cpu` int(11) NOT NULL,
  `category` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `crashed` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`server_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO servers VALUES ('1','3','1406','56','56',' \"redhat\"','0'),
('2','0','7394','43','36',' \"windows\"','0'),
('3','1','9050','16','34',' \"windows\"','0'),
('4','8','9025','22','62',' \"windows\"','0'),
('5','4','73','25','29',' \"windows\"','0'),
('6','10','151','50','43',' \"opensuse\"','0'),
('7','1','6396','18','52','\"kali\"','0'),
('8','1','7212','26','6',' \"opensuse\"','0'),
('9','9','6948','11','44',' \"redhat\"','0'),
('10','6','9219','62','43',' \"redhat\"','0'),
('11','4','7741','38','18',' \"fedora\"','0'),
('12','3','1825','41','28',' \"fedora\"','0'),
('13','6','8036','35','42',' \"windows\"','0'),
('14','9','4369','50','5','\"kali\"','0'),
('15','8','9514','1','5',' \"opensuse\"','0'),
('16','4','1719','53','3',' \"opensuse\"','0'),
('17','4','2403','2','39',' \"windows\"','0'),
('18','10','7327','58','14',' \"opensuse\"','0'),
('19','5','2535','11','24',' \"opensuse\"','0'),
('20','0','1496','36','46','\"kali\"','0'),
('21','4','161','38','30',' \"redhat\"','0'),
('22','0','3266','29','43',' \"fedora\"','0'),
('23','1','9490','47','8',' \"fedora\"','0'),
('24','7','9727','2','25',' \"fedora\"','0'),
('25','2','8406','54','48',' \"opensuse\"','0'),
('26','8','8044','2','42',' \"redhat\"','0'),
('27','8','9781','32','42','\"kali\"','0'),
('28','4','6368','41','39',' \"windows\"','0'),
('29','4','4485','47','28',' \"opensuse\"','0'),
('30','3','1864','25','35',' \"opensuse\"','0'),
('31','10','2488','40','40',' \"opensuse\"','0'),
('32','9','7674','21','36','\"kali\"','0'),
('33','7','2076','25','5',' \"opensuse\"','0'),
('34','9','9771','26','15',' \"fedora\"','0'),
('35','0','2254','6','49',' \"redhat\"','0'),
('36','8','317','52','44',' \"opensuse\"','0'),
('37','10','3101','16','54',' \"fedora\"','0'),
('38','7','2586','41','37',' \"redhat\"','0'),
('39','4','382','43','11','\"kali\"','0'),
('40','0','7540','26','33','\"kali\"','0'),
('41','2','437','53','49',' \"fedora\"','0'),
('42','0','5034','10','43',' \"fedora\"','0'),
('43','3','5581','41','6',' \"windows\"','0'),
('44','6','9798','30','33',' \"fedora\"','0'),
('45','2','9165','7','27',' \"windows\"','0'),
('46','8','3425','12','10',' \"redhat\"','0'),
('47','1','8367','33','36','\"kali\"','0'),
('48','9','415','22','37',' \"fedora\"','0'),
('49','10','7373','49','28','\"kali\"','0'),
('50','10','6653','53','22',' \"windows\"','0'),
('51','2','8081','63','19',' \"opensuse\"','0'),
('52','0','6411','35','62',' \"windows\"','0'),
('53','2','5112','47','30',' \"windows\"','0'),
('54','7','6706','11','37',' \"redhat\"','0'),
('55','9','4957','32','8','\"kali\"','0'),
('56','9','3645','34','23',' \"opensuse\"','0'),
('57','8','8253','46','10',' \"opensuse\"','0'),
('58','1','6986','11','40',' \"opensuse\"','0'),
('59','8','7936','15','11',' \"opensuse\"','0'),
('60','7','3155','47','48',' \"opensuse\"','0'),
('61','5','1418','11','10',' \"redhat\"','0'),
('62','6','8923','42','22',' \"opensuse\"','0'),
('63','4','111','2','4',' \"opensuse\"','0'),
('64','3','934','51','16',' \"redhat\"','0'),
('65','1','406','27','11',' \"opensuse\"','0'),
('66','5','6591','61','20','\"kali\"','0'),
('67','5','5868','23','48','\"kali\"','0'),
('68','6','4756','57','25',' \"fedora\"','0'),
('69','1','7189','55','54','\"kali\"','0'),
('70','6','5756','26','57',' \"windows\"','0'),
('71','6','5578','23','62',' \"opensuse\"','0'),
('72','8','5491','42','19',' \"redhat\"','0'),
('73','2','1998','37','29',' \"opensuse\"','0'),
('74','2','288','61','59',' \"windows\"','0'),
('75','9','7969','57','15',' \"opensuse\"','0'),
('76','3','7918','8','34',' \"windows\"','0'),
('77','7','3432','48','3',' \"opensuse\"','0'),
('78','5','4810','29','60',' \"fedora\"','0'),
('79','0','179','14','12',' \"fedora\"','0'),
('80','5','6365','22','15','\"kali\"','0'),
('81','3','2003','26','47',' \"redhat\"','0'),
('82','6','421','39','45',' \"redhat\"','0'),
('83','1','3246','29','59',' \"windows\"','0'),
('84','4','6561','60','7',' \"fedora\"','0'),
('85','4','5282','34','56',' \"fedora\"','0'),
('86','5','1163','21','21',' \"redhat\"','0'),
('87','4','6820','7','3',' \"opensuse\"','0'),
('88','9','6107','53','14',' \"windows\"','0'),
('89','4','2560','28','55','\"kali\"','0'),
('90','7','7219','35','4',' \"windows\"','0'),
('91','3','2772','30','33','\"kali\"','0'),
('92','9','6576','7','55',' \"opensuse\"','0'),
('93','8','1011','34','26',' \"fedora\"','0'),
('94','6','8855','43','49',' \"windows\"','0'),
('95','0','2890','48','47','\"kali\"','0'),
('96','3','1053','47','23',' \"opensuse\"','0'),
('97','0','1658','42','18',' \"redhat\"','0'),
('98','1','9672','62','60',' \"redhat\"','0'),
('99','2','8301','39','17',' \"redhat\"','0'),
('100','3','5165','3','63',' \"fedora\"','0'); 




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

