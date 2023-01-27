-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.40-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for chestionar
DROP DATABASE IF EXISTS `chestionar`;
CREATE DATABASE IF NOT EXISTS `chestionar` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `chestionar`;

-- Dumping structure for table chestionar.answers
DROP TABLE IF EXISTS `answers`;
CREATE TABLE IF NOT EXISTS `answers` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPTION` varchar(500) NOT NULL DEFAULT '',
  `VARIANT` varchar(1) NOT NULL DEFAULT '',
  `IS_RIGHT` bit(1) NOT NULL DEFAULT b'0',
  `QUESTION_ID` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `FK_answers_questions` (`QUESTION_ID`),
  CONSTRAINT `FK_answers_questions` FOREIGN KEY (`QUESTION_ID`) REFERENCES `questions` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- Dumping data for table chestionar.answers: ~30 rows (approximately)
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
INSERT IGNORE INTO `answers` (`ID`, `DESCRIPTION`, `VARIANT`, `IS_RIGHT`, `QUESTION_ID`) VALUES
	(0, 'semnalizaţi schimbarea direcţiei de mers; pietonii vă vor acorda prioritate;', 'A', b'0', 1),
	(1, 'semnalizaţi schimbarea direcţiei de mers; acordaţi prioritate vehiculelor care circulă din partea stângă;', 'B', b'1', 1),
	(11, 'semnalizaţi schimbarea direcţiei de mers şi acordaţi prioritate de trecere pietonilor;', 'C', b'1', 1),
	(12, 'autoturismul urmează, fără deviere, cursa volanului;', 'A', b'0', 2),
	(13, 'autoturismul tinde să derapeze cu spatele spre exteriorul curbei;', 'B', b'1', 2),
	(14, 'roţile din faţă se învârtesc în gol;', 'C', b'0', 2),
	(15, 'să circule numai dacă verificarea medicală lunară este efectuată;', 'A', b'0', 3),
	(16, 'să circule numai pe sectoarele de drum pe care îi este permis accesul şi să respecte normele referitoare la masele totale maxime autorizate admise de autoritatea competentă;', 'B', b'1', 3),
	(17, 'să se informeze din timp, la administratorii de drum, în legătură cu eventualele limite maxime şi minime de viteză;', 'C', b'0', 3),
	(18, 'da, deoarece conducătorul autoturismului a semnalizat intenţia de a vira la stânga, iar spaţiul rămas liber permite trecerea camionului prin partea dreaptă;', 'A', b'1', 4),
	(19, 'nu, deoarece în intersecţii depăşirea este interzisă;', 'B', b'0', 4),
	(20, 'nu, deoarece depăşirea se execută numai pe partea stângă;', 'C', b'0', 4),
	(21, 'obligaţia de a folosi în permanenţă carburant biodegradabil;', 'A', b'0', 5),
	(22, 'deplasări urbane cu bicicleta, pe jos sau cu alte mijloace care nu poluează atmosfera;', 'B', b'0', 5),
	(23, 'un ansamblu de măsuri comportamentale, de control sau de verificare a vehiculului, prin care se realizează o importantă economie de energie şi protecţia mediului;', 'C', b'1', 5),
	(24, 'urmează un sector de drum îngustat temporar;', 'A', b'0', 6),
	(25, 'este interzisă schimbarea direcţiei de mers la dreapta în prima intersecţie;', 'B', b'0', 6),
	(26, 'urmează o intersecţie cu un drum fără prioritate;', 'C', b'1', 6),
	(27, 'prin folosirea luminilor de poziţie;', 'A', b'1', 7),
	(28, 'prin instalarea triunghiurilor reflectorizante şi prin folosirea luminilor de avarie;', 'B', b'1', 7),
	(29, 'prin purtarea vestei reflectorizante;', 'C', b'0', 7),
	(30, 'atunci când motorul nu atinge temperatura de funcţionare;', 'A', b'1', 8),
	(31, 'atunci când fumul de eşapament este de culoare neagră;', 'B', b'1', 8),
	(32, 'atunci când motorul funcţionează cu întreruperi;', 'C', b'1', 8),
	(33, 'se depăşeşte masa maximă admisă, înscrisă în certificatul de înmatriculare;', 'A', b'1', 9),
	(34, 'anvelopele sunt de mărimi şi caracteristici diferite faţă de cele înscrise în certificatul de înmatriculare;', 'B', b'1', 9),
	(35, 'autovehiculul depăşeşte înălţimea înscrisă în certificatul de înmatriculare;', 'C', b'0', 9),
	(36, 'zgomote în zona manetei frânei de mână;', 'A', b'0', 10),
	(37, 'un consum suplimentar de carburant;', 'B', b'1', 10),
	(38, 'încălzirea excesivă a butucilor roţilor din spate;', 'C', b'1', 10);
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;

-- Dumping structure for table chestionar.questions
DROP TABLE IF EXISTS `questions`;
CREATE TABLE IF NOT EXISTS `questions` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRIPTION` varchar(2000) NOT NULL DEFAULT '',
  `IMAGE` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Dumping data for table chestionar.questions: ~10 rows (approximately)
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT IGNORE INTO `questions` (`ID`, `DESCRIPTION`, `IMAGE`) VALUES
	(1, 'Cum veţi proceda dacă intenţionaţi să schimbaţi direcţia de mers spre dreapta?', 'assets/1.png'),
	(2, 'Ce tendinţă prezintă un autoturism cu tracţiune pe spate, dacă acceleraţi prea puternic în curbă?', 'assets/2.png'),
	(3, 'Ce obligaţii are conducătorul de autovehicule când circulă pe un drum public?', NULL),
	(4, 'Camionul execută corect depăşirea autoturismului?', NULL),
	(5, 'Ce se înţelege prin conducere ecologică a unui autovehicul?', NULL),
	(6, 'Ce semnificaţie are indicatorul din imagine?', 'assets/3.png'),
	(7, 'Cum veţi semnaliza faptul că autovehiculul cu care circulaţi a rămas în pană pe partea carosabilă?', NULL),
	(8, 'În care dintre situaţii consumul de carburant al unui motor creşte?', NULL),
	(9, 'Nu se poate circula cu un autoturism dacă:', NULL),
	(10, 'Neeliberarea completă a frânei de staţionare determină:', NULL);
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;

-- Dumping structure for table chestionar.tests
DROP TABLE IF EXISTS `tests`;
CREATE TABLE IF NOT EXISTS `tests` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CODE` varchar(8) NOT NULL DEFAULT '',
  `RIGHT` tinyint(4) NOT NULL DEFAULT '0',
  `WRONG` tinyint(4) NOT NULL DEFAULT '0',
  `OOT` bit(1) NOT NULL DEFAULT b'0',
  `FINISHED` bit(1) NOT NULL DEFAULT b'0',
  `TIME` int(3) NOT NULL DEFAULT '0',
  `QUESTION_NB` tinyint(2) NOT NULL DEFAULT '0',
  `CREATED` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table chestionar.tests: ~1 rows (approximately)
/*!40000 ALTER TABLE `tests` DISABLE KEYS */;
INSERT IGNORE INTO `tests` (`ID`, `CODE`, `RIGHT`, `WRONG`, `OOT`, `FINISHED`, `TIME`, `QUESTION_NB`, `CREATED`) VALUES
	(1, 'aaaaaaaa', 2, 0, b'0', b'0', 30, 5, '2023-01-26 23:45:22');
/*!40000 ALTER TABLE `tests` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
