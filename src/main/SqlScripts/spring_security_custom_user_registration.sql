
DROP DATABASE `web_bike_warehouse`;
CREATE DATABASE  IF NOT EXISTS `web_bike_warehouse`;
USE `web_bike_warehouse`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+01:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
--
-- Table structure for table `bike`
--

DROP TABLE IF EXISTS `bike`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

CREATE TABLE `bike` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(45) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `details` varchar(1000) DEFAULT NULL,
  `image_url` varchar(400) DEFAULT NULL,
  `in_stock_from` DATE DEFAULT NULL,
  `price` DECIMAL(10,2) DEFAULT 0.00,
  `quantity_in_stock` INT DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Data for table `bike`
--
/*!40000 ALTER TABLE `bike` DISABLE KEYS */;

INSERT INTO `bike` VALUES
	(1,'Hercules','Jump','road','excellent bike','https://mec.imgix.net/medias/sys_master/high-res/high-res/8796369977374/5044850-BK006.jpg?w=2500&h=2500&auto=format&q=40&fit=fill&bg=FFF',
		CURDATE(), 234.45, 23),
	(2,'Specialized','Xtreme','mountain','well stuff','https://www.islabikes.com/wp-content/uploads/2015/10/Cnoc16-Red-MY2016-SRGB-USA-3.jpg',
		CURDATE(), 100.00, 2),
	(3,'Hercules','Go','road','excellent bike','https://mec.imgix.net/medias/sys_master/high-res/high-res/8796369977374/5044850-BK006.jpg?w=2500&h=2500&auto=format&q=40&fit=fill&bg=FFF',
		CURDATE(), 234.45, 23),
	(4,'Kross','Xtreme','mountain','well stuff','https://www.islabikes.com/wp-content/uploads/2015/10/Cnoc16-Red-MY2016-SRGB-USA-3.jpg',
		CURDATE(), 100.00, 2),
	(5,'jubilat','2','road','excellent bike','https://mec.imgix.net/medias/sys_master/high-res/high-res/8796369977374/5044850-BK006.jpg?w=2500&h=2500&auto=format&q=40&fit=fill&bg=FFF',
		CURDATE(), 234.45, 23),
	(6,'Specialized','Xtreme','mountain','well stuff','https://www.islabikes.com/wp-content/uploads/2015/10/Cnoc16-Red-MY2016-SRGB-USA-3.jpg',
		CURDATE(), 100.00, 2),
	(7,'Hercules','JX','road','excellent bike','https://mec.imgix.net/medias/sys_master/high-res/high-res/8796369977374/5044850-BK006.jpg?w=2500&h=2500&auto=format&q=40&fit=fill&bg=FFF',
		CURDATE(), 234.45, 23),
	(8,'Specialized','Xtreme','mountain','well stuff','https://www.islabikes.com/wp-content/uploads/2015/10/Cnoc16-Red-MY2016-SRGB-USA-3.jpg',
		CURDATE(), 100.00, 2);

/*!40000 ALTER TABLE `bike` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` char(80) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  UNIQUE KEY `authorities_idx_1` (`username`),
  UNIQUE KEY `authorities_idx_2` (`email`),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--
-- NOTE: The passwords are encrypted using BCrypt
--
-- A generation tool is avail at: http://www.luv2code.com/generate-bcrypt-password
--
-- Default passwords here are: fun123
--

INSERT INTO `user` (username,password,first_name,last_name,email)
VALUES 
('john','$2a$04$eFytJDGtjbThXa80FyOOBuFdK2IwjyWefYkMpiBEFlpBwDH.5PM0K','John','Doe','john@luv2code.com'),
('mary','$2a$04$eFytJDGtjbThXa80FyOOBuFdK2IwjyWefYkMpiBEFlpBwDH.5PM0K','Mary','Public','mary@luv2code.com'),
('susan','$2a$04$eFytJDGtjbThXa80FyOOBuFdK2IwjyWefYkMpiBEFlpBwDH.5PM0K','Susan','Adams','susan@luv2code.com');


--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `role` (name)
VALUES 
('ROLE_EMPLOYEE'),('ROLE_MANAGER'),('ROLE_ADMIN');

--
-- Table structure for table `users_roles` - join table
--

DROP TABLE IF EXISTS `users_roles`;

CREATE TABLE `users_roles` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  
  PRIMARY KEY (`user_id`,`role_id`),
  
  KEY `FK_ROLE_idx` (`role_id`),
  
  CONSTRAINT `FK_USER_05` FOREIGN KEY (`user_id`) 
  REFERENCES `user` (`id`) 
  ON DELETE NO ACTION ON UPDATE NO ACTION,
  
  CONSTRAINT `FK_ROLE` FOREIGN KEY (`role_id`) 
  REFERENCES `role` (`id`) 
  ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users_roles`
--

INSERT INTO `users_roles` (user_id,role_id)
VALUES 
(1, 1),
(2, 1),
(2, 2),
(3, 1),
(3, 3);

--
-- Table structure for table `comment`
--
DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(300) NOT NULL,
  `user_id` int(11) NOT NULL,
  `bike_id` int(11) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

--
-- sample data for table comments
--

INSERT INTO comment (content, user_id, bike_id) values
("funny", 1, 1),
("scary", 2, 1),
("hahahaha", 3, 1),
("lalalal", 1, 2),
("nice", 1, 3),
("horrible", 2, 2),
("bad quality", 3, 2),
("super fast", 2, 3),
("light", 3, 1);


--
-- Table structure for table `comments_users` - join table
--
DROP TABLE IF EXISTS `comments_users`;

CREATE TABLE `comments_users` (
  `comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  
  PRIMARY KEY (`comment_id`,`user_id`),
  
  KEY `FK_USER_idx` (`user_id`),
  
  CONSTRAINT `FK_COMMENT_USER` FOREIGN KEY (`comment_id`) 
  REFERENCES `comment` (`id`) 
  ON DELETE NO ACTION ON UPDATE NO ACTION,
  
  CONSTRAINT `FK_USER_COMMENT` FOREIGN KEY (`user_id`) 
  REFERENCES `user` (`id`) 
  ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- data for join table comments_users
--

INSERT INTO comments_users VALUES
(1,1),
(2,2),
(3,3),
(4,1),
(5,1),
(6,2),
(7,3),
(8,2),
(9,3);
--
-- Table structure for table `comments_bikes` - join table
--
DROP TABLE IF EXISTS `comments_bikes`;

CREATE TABLE `comments_bikes` (
  `comment_id` int(11) NOT NULL,
  `bike_id` int(11) NOT NULL,
  
  PRIMARY KEY (`comment_id`,`bike_id`),
  
  KEY `FK_BIKE_idx` (`bike_id`),
  
  CONSTRAINT `FK_COMMENT_BIKE` FOREIGN KEY (`comment_id`) 
  REFERENCES `comment` (`id`) 
  ON DELETE NO ACTION ON UPDATE NO ACTION,
  
  CONSTRAINT `FcommentK_BIKE_COMMENT` FOREIGN KEY (`bike_id`) 
  REFERENCES `bike` (`id`) 
  ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- data for comments_bikes
--

INSERT INTO comments_bikes VALUES
(1,1),
(2,1),
(3,1),
(4,2),
(5,3),
(6,2),
(7,2),
(8,3),
(9,1);

SET FOREIGN_KEY_CHECKS = 1;