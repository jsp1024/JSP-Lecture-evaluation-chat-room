-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        5.7.27-log - MySQL Community Server (GPL)
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- capstondesign 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `capstondesign` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `capstondesign`;

-- 테이블 capstondesign.chat 구조 내보내기
CREATE TABLE IF NOT EXISTS `chat` (
  `chatID` int(11) NOT NULL AUTO_INCREMENT,
  `fromID` varchar(20) DEFAULT NULL,
  `toID` varchar(20) DEFAULT NULL,
  `chatContent` varchar(100) DEFAULT NULL,
  `chatTime` datetime DEFAULT NULL,
  `chatRead` int(11) DEFAULT NULL,
  PRIMARY KEY (`chatID`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- 테이블 데이터 capstondesign.chat:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
INSERT INTO `chat` (`chatID`, `fromID`, `toID`, `chatContent`, `chatTime`, `chatRead`) VALUES
	(38, '123', '777', 'aaaa', '2019-11-11 13:27:41', 1),
	(39, '123', '777', 'aaaa', '2019-11-11 13:27:46', 1),
	(40, '777', '123', 'asdfasdf', '2019-11-11 13:28:17', 1);
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;

-- 테이블 capstondesign.chatuser 구조 내보내기
CREATE TABLE IF NOT EXISTS `chatuser` (
  `ChatuserID` varchar(20) DEFAULT NULL,
  `ChatuserPassword` varchar(20) DEFAULT NULL,
  `ChatuserName` varchar(20) DEFAULT NULL,
  `ChatuserAge` int(11) DEFAULT NULL,
  `ChatuserGender` varchar(20) DEFAULT NULL,
  `ChatuserEmail` varchar(50) DEFAULT NULL,
  `ChatuserProfile` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 capstondesign.chatuser:~4 rows (대략적) 내보내기
/*!40000 ALTER TABLE `chatuser` DISABLE KEYS */;
INSERT INTO `chatuser` (`ChatuserID`, `ChatuserPassword`, `ChatuserName`, `ChatuserAge`, `ChatuserGender`, `ChatuserEmail`, `ChatuserProfile`) VALUES
	('12312', '123', '123', 12312, '남자', NULL, NULL),
	('12312', '', '123', 12312, '남자', NULL, NULL),
	('1231', '12345', '12345', 1231, '남자', NULL, NULL),
	('1231', '', '12345', 1231, '남자', NULL, NULL);
/*!40000 ALTER TABLE `chatuser` ENABLE KEYS */;

-- 테이블 capstondesign.evaluation 구조 내보내기
CREATE TABLE IF NOT EXISTS `evaluation` (
  `evaluationID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` varchar(20) DEFAULT NULL,
  `lectureName` varchar(50) DEFAULT NULL,
  `professorName` varchar(20) DEFAULT NULL,
  `lectureYear` int(11) DEFAULT NULL,
  `semesterDivide` varchar(20) DEFAULT NULL,
  `lectureDivide` varchar(10) DEFAULT NULL,
  `evaluationTitle` varchar(50) DEFAULT NULL,
  `evaluationContent` varchar(2048) DEFAULT NULL,
  `totalScore` varchar(5) DEFAULT NULL,
  `creditScore` varchar(5) DEFAULT NULL,
  `comfortableScore` varchar(5) DEFAULT NULL,
  `lectureScore` varchar(5) DEFAULT NULL,
  `likeCount` int(11) DEFAULT NULL,
  PRIMARY KEY (`evaluationID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- 테이블 데이터 capstondesign.evaluation:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `evaluation` DISABLE KEYS */;
INSERT INTO `evaluation` (`evaluationID`, `userID`, `lectureName`, `professorName`, `lectureYear`, `semesterDivide`, `lectureDivide`, `evaluationTitle`, `evaluationContent`, `totalScore`, `creditScore`, `comfortableScore`, `lectureScore`, `likeCount`) VALUES
	(24, '777', '객체지향설계분석', '반종오', 2019, '2학기', '전공', 'SDFERW', 'DAFSSDFASFDA', 'A', 'A', 'A', 'A', 0);
/*!40000 ALTER TABLE `evaluation` ENABLE KEYS */;

-- 테이블 capstondesign.likey 구조 내보내기
CREATE TABLE IF NOT EXISTS `likey` (
  `userID` varchar(20) NOT NULL,
  `evaluationID` int(11) NOT NULL,
  `userIP` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`userID`,`evaluationID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 테이블 데이터 capstondesign.likey:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `likey` DISABLE KEYS */;
INSERT INTO `likey` (`userID`, `evaluationID`, `userIP`) VALUES
	('777', 7, '0:0:0:0:0:0:0:1'),
	('777', 9, '0:0:0:0:0:0:0:1'),
	('777', 10, '0:0:0:0:0:0:0:1'),
	('789', 15, '0:0:0:0:0:0:0:1');
/*!40000 ALTER TABLE `likey` ENABLE KEYS */;

-- 테이블 capstondesign.user 구조 내보내기
CREATE TABLE IF NOT EXISTS `user` (
  `userID` varchar(20) NOT NULL,
  `userPassword` varchar(64) DEFAULT NULL,
  `userEmail` varchar(20) DEFAULT NULL,
  `userEmailHash` varchar(64) DEFAULT NULL,
  `userEmailChacked` tinyint(1) DEFAULT NULL,
  `userName` varchar(20) DEFAULT NULL,
  `userAge` varchar(20) DEFAULT NULL,
  `userGender` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 capstondesign.user:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`userID`, `userPassword`, `userEmail`, `userEmailHash`, `userEmailChacked`, `userName`, `userAge`, `userGender`) VALUES
	('111', '123', 'jsp1024k@naver.com', '428ca42e5bbee0d858ec359cc8429eb3235f5fa73ef6542fafd264aff8542102', 1, '박재만', '21', '남자'),
	('123', '123', 'jsp1024k@naver.com', '428ca42e5bbee0d858ec359cc8429eb3235f5fa73ef6542fafd264aff8542102', 1, '가나다', '21', 'on'),
	('777', '123', 'jsp1024k@naver.com', '428ca42e5bbee0d858ec359cc8429eb3235f5fa73ef6542fafd264aff8542102', 1, '박재만', '21', 'on');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
