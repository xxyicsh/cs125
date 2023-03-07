/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : cs125

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 07/03/2023 15:54:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for fooddata
-- ----------------------------
DROP TABLE IF EXISTS `fooddata`;
CREATE TABLE `fooddata` (
  `userid` int NOT NULL,
  `date` varchar(255) DEFAULT NULL,
  `meal` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `recommend` json DEFAULT NULL,
  `checked` json DEFAULT NULL,
  `fooddataid` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`fooddataid`),
  KEY `userid` (`userid`),
  CONSTRAINT `userid` FOREIGN KEY (`userid`) REFERENCES `userinfo` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of fooddata
-- ----------------------------
BEGIN;
INSERT INTO `fooddata` (`userid`, `date`, `meal`, `recommend`, `checked`, `fooddataid`) VALUES (4, '2023-03-06', 'snack', '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]', '[5]', 9);
INSERT INTO `fooddata` (`userid`, `date`, `meal`, `recommend`, `checked`, `fooddataid`) VALUES (5, '2023-03-06', 'snack', '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]', '[]', 10);
INSERT INTO `fooddata` (`userid`, `date`, `meal`, `recommend`, `checked`, `fooddataid`) VALUES (6, '2023-03-06', 'dinner', '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]', '[5, 2]', 12);
INSERT INTO `fooddata` (`userid`, `date`, `meal`, `recommend`, `checked`, `fooddataid`) VALUES (6, '2023-03-07', 'breakfast', '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]', '[1]', 13);
INSERT INTO `fooddata` (`userid`, `date`, `meal`, `recommend`, `checked`, `fooddataid`) VALUES (6, '2023-03-07', 'lunch', '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]', '[1]', 14);
INSERT INTO `fooddata` (`userid`, `date`, `meal`, `recommend`, `checked`, `fooddataid`) VALUES (6, '2023-03-07', 'snack', '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]', '[2, 3, 4]', 15);
COMMIT;

-- ----------------------------
-- Table structure for meal
-- ----------------------------
DROP TABLE IF EXISTS `meal`;
CREATE TABLE `meal` (
  `id` int DEFAULT NULL,
  `tag` varchar(254) DEFAULT NULL,
  `name` varchar(254) DEFAULT NULL,
  `contains` varchar(254) DEFAULT NULL,
  `calories` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of meal
-- ----------------------------
BEGIN;
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (1, 'breakfast', 'butter toast', '[\"toast\", \"butter\"]', 66);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (2, 'breakfast,snack', 'cereal', '[\"cereal\"]', 200);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (3, 'breakfast,snack', 'peach yogurt', '[\"yogurt\", \"peach\"]', 170);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (4, 'breakfast', 'omelette', '[\"egg\"]', 207);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (5, 'breakfast', 'cheese bagel', '[\"cheese\"]', 450);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (6, 'breakfast', 'chocolate smoothie', '[\"milk\", \"chocolate\"]', 350);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (7, 'breakfast,snack', 'peanut muffin', '[\"peanut\"]', 240);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (8, 'breakfast,snack', 'biscuits', '[\"biscuits\"]', 170);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (9, 'breakfast', 'scrambled eggs', '[\"egg\"]', 78);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (10, 'breakfast', 'sausage', '[\"pork\"]', 160);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (11, 'breakfast,snack', 'blueberry pancake', '[\"blueberry\"]', 200);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (12, 'breakfast,lunch,dinner', 'fried egg rice', '[\"egg\"]', 333);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (13, 'breakfast', 'cinnamon roll', '[\"cinnamon\"]', 525);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (14, 'breakfast,snack', 'crossiant', '[]', 300);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (15, 'breakfast', 'egg salad', '[\"egg\"]', 200);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (16, 'lunch,dinner', 'chicken sandwich', '[\"chicken\"]', 360);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (17, 'lunch,dinner', 'caesar salad', '[\"chicken\"]', 110);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (18, 'lunch,dinner', 'tomato soup', '[\"tomato\"]', 90);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (19, 'lunch,dinner', 'shrimp fry', '[\"shrimp\"]', 210);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (20, 'lunch,dinner', 'pork sandwich', '[\"pork\"]', 420);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (21, 'lunch,dinner', 'broccoli alfredo', '[\"broccoli\"]', 1120);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (22, 'lunch,dinner', 'baked potato', '[\"potato\"]', 161);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (23, 'lunch,dinner', 'turkey chili', '[\"turkey\"]', 402);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (24, 'lunch,dinner', 'beef burrito', '[\"beef\"]', 600);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (25, 'lunch,dinner', 'chicken noodle', '[\"chicken\"]', 110);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (26, 'lunch,dinner', 'steak', '[\"beef\"]', 190);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (27, 'lunch,dinner', 'fish tacos', '[\"fish\"]', 315);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (28, 'lunch,dinner', 'chicken rice bowl', '[\"chicken\"]', 700);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (29, 'lunch,dinner', 'vegetable panini', '[]', 536);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (30, 'lunch,dinner', 'tuna poke bowl', '[\"fish\"]', 590);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (31, 'snack', 'chips', '[\"potato\"]', 150);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (32, 'snack', 'popcorn', '[\"corn\"]', 34);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (33, 'snack', 'nuts', '[\"nut\"]', 100);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (34, 'snack', 'granola bars', '[\"nut\"]', 203);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (35, 'snack', 'chocolate bar', '[\"chocolate\"]', 230);
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`userid`, `username`, `password`) VALUES (4, 'louis', '112211');
INSERT INTO `user` (`userid`, `username`, `password`) VALUES (5, 'steven', 'aabbcc');
INSERT INTO `user` (`userid`, `username`, `password`) VALUES (6, 'alex', 'aabbcc');
INSERT INTO `user` (`userid`, `username`, `password`) VALUES (7, 'dido', '$2b$12$HtgaRyEewp.kdWl5pAGnXeTUfndZkmOVKPf57uDi6txzc7TMu2xYS');
COMMIT;

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `height` int DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `target` double DEFAULT NULL,
  `calories` int DEFAULT NULL,
  PRIMARY KEY (`userid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
BEGIN;
INSERT INTO `userinfo` (`userid`, `username`, `gender`, `age`, `height`, `weight`, `target`, `calories`) VALUES (4, 'louis', 'male', 22, 170, 80, 75, 2048);
INSERT INTO `userinfo` (`userid`, `username`, `gender`, `age`, `height`, `weight`, `target`, `calories`) VALUES (5, 'steven', 'male', 0, 0, 0, 0, 0);
INSERT INTO `userinfo` (`userid`, `username`, `gender`, `age`, `height`, `weight`, `target`, `calories`) VALUES (6, 'alex', 'male', 22, 170, 70, 65, 1908);
INSERT INTO `userinfo` (`userid`, `username`, `gender`, `age`, `height`, `weight`, `target`, `calories`) VALUES (7, 'dido', 'male', 0, 0, 0, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for userpref
-- ----------------------------
DROP TABLE IF EXISTS `userpref`;
CREATE TABLE `userpref` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `breakfast` int DEFAULT NULL,
  `lunch` int DEFAULT NULL,
  `dinner` int DEFAULT NULL,
  `snack` int DEFAULT NULL,
  `dislike` json DEFAULT NULL,
  `allergies` json DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of userpref
-- ----------------------------
BEGIN;
INSERT INTO `userpref` (`userid`, `breakfast`, `lunch`, `dinner`, `snack`, `dislike`, `allergies`) VALUES (4, 1, 1, 1, 1, '[\"apple\"]', '[\"gluton\"]');
INSERT INTO `userpref` (`userid`, `breakfast`, `lunch`, `dinner`, `snack`, `dislike`, `allergies`) VALUES (5, 0, 0, 0, 0, '[]', '[]');
INSERT INTO `userpref` (`userid`, `breakfast`, `lunch`, `dinner`, `snack`, `dislike`, `allergies`) VALUES (6, 0, 0, 0, 0, '[]', '[]');
INSERT INTO `userpref` (`userid`, `breakfast`, `lunch`, `dinner`, `snack`, `dislike`, `allergies`) VALUES (7, 0, 0, 0, 0, '[]', '[]');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
