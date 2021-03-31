-- MariaDB dump 10.19  Distrib 10.5.9-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: conpany
-- ------------------------------------------------------
-- Server version	10.5.9-MariaDB-1:10.5.9+maria~focal

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
-- Table structure for table `t_alarm`
--

DROP TABLE IF EXISTS `t_alarm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_alarm` (
  `a_sno` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '알람_번호',
  `m_id` varchar(100) NOT NULL COMMENT '멤버_아이디',
  `b_sno` bigint(20) NOT NULL COMMENT '게시판_번호',
  `reg_date` datetime NOT NULL DEFAULT current_timestamp(),
  `mod_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `dlt_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `dlt_yn` char(1) NOT NULL DEFAULT 'n' COMMENT '삭제여부',
  PRIMARY KEY (`a_sno`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_alarm`
--

LOCK TABLES `t_alarm` WRITE;
/*!40000 ALTER TABLE `t_alarm` DISABLE KEYS */;
INSERT INTO `t_alarm` VALUES (1,'asde2016',1,'2021-03-26 07:27:25','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(2,'noel950',1,'2021-03-26 07:27:25','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(3,'test1',1,'2021-03-26 07:27:25','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(4,'test2',1,'2021-03-26 07:27:25','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(5,'test3',1,'2021-03-26 07:27:25','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(8,'asde2016',2,'2021-03-26 07:27:47','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(9,'noel950',2,'2021-03-26 07:27:47','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(10,'test1',2,'2021-03-26 07:27:47','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(11,'test2',2,'2021-03-26 07:27:47','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(12,'test3',2,'2021-03-26 07:27:47','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(15,'asde2016',3,'2021-03-26 07:27:57','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(16,'noel950',3,'2021-03-26 07:27:57','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(17,'test1',3,'2021-03-26 07:27:57','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(18,'test2',3,'2021-03-26 07:27:57','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(19,'test3',3,'2021-03-26 07:27:57','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(22,'asde2016',4,'2021-03-26 07:28:04','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(23,'noel950',4,'2021-03-26 07:28:04','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(24,'test1',4,'2021-03-26 07:28:04','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(25,'test2',4,'2021-03-26 07:28:04','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(26,'test3',4,'2021-03-26 07:28:04','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(29,'asde2016',5,'2021-03-26 07:28:18','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(30,'noel950',5,'2021-03-26 07:28:18','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(31,'test1',5,'2021-03-26 07:28:18','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(32,'test2',5,'2021-03-26 07:28:18','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(33,'test3',5,'2021-03-26 07:28:18','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(36,'asde2016',6,'2021-03-26 07:28:35','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(37,'noel950',6,'2021-03-26 07:28:35','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(38,'test1',6,'2021-03-26 07:28:35','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(39,'test2',6,'2021-03-26 07:28:35','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(40,'test3',6,'2021-03-26 07:28:35','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(43,'noel950',7,'2021-03-26 07:37:14','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(44,'test1',7,'2021-03-26 07:37:14','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(46,'noel950',8,'2021-03-26 07:37:46','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(47,'test1',8,'2021-03-26 07:37:46','0000-00-00 00:00:00','0000-00-00 00:00:00','n');
/*!40000 ALTER TABLE `t_alarm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_board`
--

DROP TABLE IF EXISTS `t_board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_board` (
  `b_sno` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '게시판_번호',
  `d_sno` bigint(20) NOT NULL COMMENT '부서_번호',
  `t_sno` int(11) NOT NULL DEFAULT 1 COMMENT '게시판_타입',
  `m_sno` bigint(20) NOT NULL COMMENT '멤버_아이디',
  `b_title` varchar(100) NOT NULL COMMENT '게시판_제목',
  `b_desc` varchar(3000) NOT NULL COMMENT '게시판_내용',
  `b_prog` varchar(100) DEFAULT NULL COMMENT '게시판_진행률',
  `b_etc` varchar(100) DEFAULT NULL COMMENT '게시판_비고',
  `b_views` bigint(20) NOT NULL DEFAULT 0 COMMENT '게시판_조회수',
  `reg_date` datetime NOT NULL DEFAULT current_timestamp(),
  `mod_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수정일',
  `dlt_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '삭제일',
  `dlt_yn` char(1) NOT NULL DEFAULT 'n' COMMENT '삭제여부',
  PRIMARY KEY (`b_sno`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_board`
--

LOCK TABLES `t_board` WRITE;
/*!40000 ALTER TABLE `t_board` DISABLE KEYS */;
INSERT INTO `t_board` VALUES (1,0,1,0,'설 연휴기간 고객지원 운영 안내','ㅁㄴㅇ','','',0,'2021-02-10 07:27:25','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(2,0,1,0,'업무 보고 방식 변경 안내','test','','',0,'2021-02-19 07:27:47','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(3,0,1,0,'3월 정기 상품 출시 및 개선 작업 안내 (3/4)','asd','','',0,'2021-02-25 07:27:57','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(4,0,1,0,'[Server] 상용서버 버전 업데이트 안내','asd','','',0,'2021-02-25 07:28:35','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(5,0,1,0,'코로나 관련사항 안내','asd','','',0,'2021-03-26 07:28:35','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(6,0,1,0,'전체 회식안내','asd','','',0,'2021-03-26 07:28:35','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(7,1,2,1,'자동화 홈페이지 개발 이슈','ㅁㄴㅇ','','',0,'2021-03-26 07:37:14','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(8,1,2,1,'솔루션 개발팀 회식 안내','ㅁㄴㅇ','','',0,'2021-03-26 07:37:46','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(9,1,3,1,'MES 자동화 홈페이지 프론트단 작업','1. 메인페이지 퍼블리싱 작업 진행중\n2. 서브페이지 작업 시작\n\n* 2일 이내 마무리될 예정 입니다.','80%','검토 필요',2,'2021-03-26 07:38:53','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(10,1,3,3,'웹 미쓰비시 통신단 개발 및 통신규칙 정의','웹 미쓰비시 통신단 개발 및 통신규칙 정의','15%','',0,'2021-03-26 07:45:01','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(11,4,3,4,'MES 자동화 홈페이지 개발구현','MES 자동화 홈페이지 개발구현','10%','',0,'2021-03-26 07:49:40','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(12,3,3,5,'자동화 홈페이지 관련 미팅','자동화 홈페이지 관련 미팅','100%','',7,'2021-03-26 08:00:01','2021-03-26 08:04:36','0000-00-00 00:00:00','n'),(13,1,3,2,'MES 자동화 홈페이지 개발구현','MES 자동화 홈페이지 개발구현','10%','검토 필요',0,'2021-03-26 08:18:31','0000-00-00 00:00:00','0000-00-00 00:00:00','n');
/*!40000 ALTER TABLE `t_board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_board_file`
--

DROP TABLE IF EXISTS `t_board_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_board_file` (
  `b_f_sno` bigint(20) NOT NULL AUTO_INCREMENT,
  `b_sno` bigint(20) NOT NULL COMMENT '게시판_번호',
  `b_f_name` varchar(100) NOT NULL COMMENT '게시판_파일_파일명',
  PRIMARY KEY (`b_f_sno`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_board_file`
--

LOCK TABLES `t_board_file` WRITE;
/*!40000 ALTER TABLE `t_board_file` DISABLE KEYS */;
INSERT INTO `t_board_file` VALUES (55,1,'test.html'),(56,5,'test.html'),(57,7,'favicon.ico');
/*!40000 ALTER TABLE `t_board_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_department`
--

DROP TABLE IF EXISTS `t_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_department` (
  `d_sno` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '부서_번호',
  `d_name` varchar(100) NOT NULL COMMENT '부서_이름',
  `reg_date` datetime NOT NULL DEFAULT current_timestamp(),
  `mod_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `dlt_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `dlt_yn` char(1) NOT NULL DEFAULT 'n' COMMENT '삭제여부',
  PRIMARY KEY (`d_sno`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_department`
--

LOCK TABLES `t_department` WRITE;
/*!40000 ALTER TABLE `t_department` DISABLE KEYS */;
INSERT INTO `t_department` VALUES (0,'관리자','2021-03-16 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(1,'솔루션 개발','2021-03-16 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(2,'유지보수','2021-03-16 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(3,'마케팅','2021-03-16 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(4,'품질관리','2021-03-16 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(5,'경영','2021-03-16 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(6,'디자인','2021-03-16 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','n');
/*!40000 ALTER TABLE `t_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_folder`
--

DROP TABLE IF EXISTS `t_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_folder` (
  `f_sno` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '폴더_번호',
  `p_f_sno` bigint(20) NOT NULL DEFAULT 0 COMMENT '부모_폴더_번호',
  `m_sno` bigint(20) NOT NULL COMMENT '멤버_번호',
  `f_t_no` int(11) NOT NULL COMMENT '폴더_타입_번호',
  `f_title` varchar(100) NOT NULL COMMENT '폴더_제목',
  `reg_date` datetime NOT NULL DEFAULT current_timestamp() COMMENT '등록일',
  `mod_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수정일',
  `dlt_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `dlt_yn` char(1) NOT NULL DEFAULT 'n' COMMENT '삭제여부',
  PRIMARY KEY (`f_sno`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_folder`
--

LOCK TABLES `t_folder` WRITE;
/*!40000 ALTER TABLE `t_folder` DISABLE KEYS */;
INSERT INTO `t_folder` VALUES (1,0,1,2,'솔루션 개발','2021-03-26 07:39:31','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(2,0,1,2,'디자인','2021-03-26 07:39:37','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(3,0,1,2,'유지보수','2021-03-26 07:39:43','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(4,0,1,2,'마케팅','2021-03-26 07:39:46','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(5,0,1,2,'PM','2021-03-26 07:39:50','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(6,0,1,2,'공유문서','2021-03-26 07:39:55','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(7,0,1,2,'문서서식','2021-03-26 07:39:59','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(8,0,1,2,'프로그램','2021-03-26 07:40:05','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(9,0,1,2,'서버관련','2021-03-26 07:40:25','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(10,0,1,2,'홈페이지 정보','2021-03-26 07:40:30','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(11,0,1,1,'업무관련','2021-03-26 07:41:42','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(12,0,1,1,'개인파일','2021-03-26 07:41:52','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(13,2,1,2,'디자인_01','2021-03-26 09:16:56','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(14,2,1,2,'디자인_02','2021-03-26 09:19:55','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(15,2,1,2,'디자인_03','2021-03-26 09:25:27','0000-00-00 00:00:00','0000-00-00 00:00:00','n');
/*!40000 ALTER TABLE `t_folder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_folder_file`
--

DROP TABLE IF EXISTS `t_folder_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_folder_file` (
  `f_f_sno` bigint(20) NOT NULL AUTO_INCREMENT,
  `f_sno` bigint(20) NOT NULL COMMENT '폴더_번호',
  `f_f_name` varchar(100) NOT NULL COMMENT '폴더_파일_파일명',
  PRIMARY KEY (`f_f_sno`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_folder_file`
--

LOCK TABLES `t_folder_file` WRITE;
/*!40000 ALTER TABLE `t_folder_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_folder_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_member`
--

DROP TABLE IF EXISTS `t_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_member` (
  `m_sno` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '멤버_번호',
  `d_sno` bigint(20) NOT NULL COMMENT '부서_번호',
  `m_id` varchar(100) NOT NULL COMMENT '멤버_아이디',
  `m_pwd` varchar(100) NOT NULL COMMENT '멤버_이름',
  `m_pos` varchar(100) DEFAULT NULL COMMENT '멤버_직급',
  `m_email` varchar(100) DEFAULT NULL COMMENT '멤버_이메일',
  `m_name` varchar(100) DEFAULT NULL COMMENT '멤버_이름',
  `m_age` varchar(100) DEFAULT NULL COMMENT '멤버_나이',
  `m_phone` varchar(100) DEFAULT NULL COMMENT '멤버_핸드폰번호',
  `m_address` varchar(100) DEFAULT NULL COMMENT '멤버_주소',
  `reg_date` datetime NOT NULL DEFAULT current_timestamp(),
  `mod_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수정일',
  `dlt_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '삭제일',
  `dlt_yn` char(1) NOT NULL DEFAULT 'n' COMMENT '삭제여부',
  PRIMARY KEY (`m_sno`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_member`
--

LOCK TABLES `t_member` WRITE;
/*!40000 ALTER TABLE `t_member` DISABLE KEYS */;
INSERT INTO `t_member` VALUES (0,0,'admin','1234','관리자','asde2016@naver.com','관리자',NULL,'01022627408','경기도 군포시 당동','2021-03-16 00:00:00','2021-03-25 07:26:33','0000-00-00 00:00:00','n'),(1,1,'asde2016','1234','주임','asde2016@naver.com','최재민',NULL,'01022627408','경기도 군포시 당동','2021-03-26 07:23:30','2021-03-26 07:36:08','0000-00-00 00:00:00','n'),(2,1,'noel950','1234','차장','noel950@naver.com','정의영',NULL,'01012341234','경기도 군포시 당정동','2021-03-26 07:24:04','2021-03-26 08:27:43','0000-00-00 00:00:00','n'),(3,1,'test1','1234','사원','','김소희',NULL,'','','2021-03-26 07:24:31','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(4,4,'test2','1234','사원','tjrghks@daum.net','정석환',NULL,'01012341234','경기도 오산시','2021-03-26 07:24:53','2021-03-26 07:49:07','0000-00-00 00:00:00','n'),(5,3,'test3','1234','주임','tkdrnr@hanmail.net','정상국',NULL,'01012341234','경기도 군포시 당동','2021-03-26 07:25:51','2021-03-26 07:59:19','0000-00-00 00:00:00','n');
/*!40000 ALTER TABLE `t_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_member_file`
--

DROP TABLE IF EXISTS `t_member_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_member_file` (
  `m_f_sno` bigint(20) NOT NULL AUTO_INCREMENT,
  `m_sno` bigint(20) NOT NULL COMMENT '멤버_번호',
  `m_f_name` varchar(100) NOT NULL COMMENT '멤버_파일_파일명',
  PRIMARY KEY (`m_f_sno`),
  UNIQUE KEY `t_member_file_UN` (`m_sno`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_member_file`
--

LOCK TABLES `t_member_file` WRITE;
/*!40000 ALTER TABLE `t_member_file` DISABLE KEYS */;
INSERT INTO `t_member_file` VALUES (3,0,'city.jpg'),(34,1,'profile.jpg'),(35,4,'seokhwan.jpg'),(36,5,'african-5505598_640.jpg'),(37,2,'uiyeong.jpg');
/*!40000 ALTER TABLE `t_member_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_type`
--

DROP TABLE IF EXISTS `t_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_type` (
  `t_sno` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '타입_번호',
  `t_name` varchar(100) NOT NULL COMMENT '타입_이름',
  `reg_date` datetime NOT NULL DEFAULT current_timestamp(),
  `mod_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수정일',
  `dlt_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '삭제일',
  `dlt_yn` char(1) NOT NULL DEFAULT 'n' COMMENT '삭제여부',
  PRIMARY KEY (`t_sno`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_type`
--

LOCK TABLES `t_type` WRITE;
/*!40000 ALTER TABLE `t_type` DISABLE KEYS */;
INSERT INTO `t_type` VALUES (1,'공지사항','2021-03-16 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(2,'부서','2021-03-16 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','n'),(3,'일일보고','2021-03-19 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','n');
/*!40000 ALTER TABLE `t_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-26 10:16:15
