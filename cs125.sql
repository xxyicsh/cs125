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

 Date: 16/03/2023 12:23:31
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;

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
INSERT INTO `fooddata` (`userid`, `date`, `meal`, `recommend`, `checked`, `fooddataid`) VALUES (6, '2023-03-08', 'snack', '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]', '[1, 2, 3, 4]', 16);
INSERT INTO `fooddata` (`userid`, `date`, `meal`, `recommend`, `checked`, `fooddataid`) VALUES (6, '2023-03-08', 'lunch', '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]', '[1, 2]', 17);
INSERT INTO `fooddata` (`userid`, `date`, `meal`, `recommend`, `checked`, `fooddataid`) VALUES (8, '2023-03-16', 'lunch', '[32, 33, 31, 4, 7, 14, 16, 23, 5, 13]', '[]', 19);
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
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (8, 'breakfast,snack', 'cookie', '[]', 170);
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
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (36, 'snack', 'chocolate dounut', '[\"chocolate\"]', 272);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (37, 'snack', 'strawberry dounut', '[\"strawberry\"]', 280);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (38, 'breakfast,snack', 'waffle', '[]', 200);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (39, 'breakfast,snack', 'chocolate crossiant', '[\"chocolate\"]', 340);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (40, 'breakfast,snack', 'strawberry crossiant', '[\"strawberry\"]', 330);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (41, 'snack', 'grass jelly', '[]', 114);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (42, 'snack', 'pudding', '[\"milk\"]', 100);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (43, 'snack', 'peanut butter', '[\"peanut\"]', 96);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (44, 'snack', 'cheddar cheese', '[\"cheese\"]', 116);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (45, 'snack', 'cheesecake', '[\"cheese\"]', 280);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (46, 'snack', 'tiramiso', '[]', 305);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (47, 'snack', 'blueberry cheesecake', '[\"blueberry\", \"cheese\"]', 495);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (48, 'snack', 'strawberry cheesecake', '[\"strawberry\", \"cheese\"]', 180);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (49, 'snack', 'beef jerky', '[\"beef\"]', 80);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (50, 'lunch,dinner', 'grilled chicken breast', '[\"chicken\"]', 166);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (51, 'lunch,dinner,snack', 'garlic bread', '[]', 170);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (52, 'lunch,dinner', 'new york steak', '[\"beef\"]', 180);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (53, 'lunch,dinner', 'american wagyu steak', '[\"beef\"]', 220);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (54, 'breakfast', 'strawberry smoothie', '[\"strawberry\"]', 375);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (55, 'breakfast,snack', 'americano', '[\"coffee\"]', 15);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (56, 'breakfast,snack', 'bacon', '[\"pork\"]', 80);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (57, 'breakfast,snack', 'McMuffin', '[\"egg\", \"pork\"]', 300);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (58, 'breakfast,snack', 'bagel', '[]', 277);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (59, 'breakfast,snack', 'eclair', '[]', 190);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (60, 'breakfast,snack', 'energy bar', '[]', 130);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (61, 'breakfast,snack', 'espresso', '[\"coffee\"]', 1);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (62, 'breakfast,snack', 'cappuchino', '[\"coffee\"]', 140);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (63, 'breakfast,snack', 'latte', '[\"coffee\"]', 50);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (64, 'breakfast', 'vanilla latte', '[\"coffee\"]', 73);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (65, 'breakfast,snack', 'mocha', '[\"coffee\"]', 120);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (66, 'breakfast,snack', 'nuttella', '[\"chocolate\"]', 80);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (67, 'breakfast,snack', 'poptarts', '[]', 200);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (68, 'breakfast', 'porridge', '[]', 185);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (69, 'breakfast,lunch,dinner,snack', 'salmon', '[\"fish\"]', 280);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (70, 'breakfast,lunch,dinner,snack', 'tuna', '[\"fish\"]', 120);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (71, 'breakfast,snack', 'hash browns', '[]', 150);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (72, 'lunch,dinner', 'masala', '[]', 100);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (73, 'lunch,dinner', 'beef wellington', '[\"beef\"]', 747);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (74, 'lunch,dinner', 'cauliflower cheese', '[\"cheese\"]', 120);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (75, 'lunch,dinner', 'hotpot', '[]', 1400);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (76, 'lunch,dinner', 'liver and bacon', '[\"pork\"]', 225);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (77, 'lunch,dinner,snack', 'pork pie', '[\"pork\"]', 235);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (78, 'lunch,dinner', 'shrimp', '[\"shrimp\"]', 60);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (79, 'lunch,dinner,snack', 'steak pie', '[\"beef\"]', 235);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (80, 'lunch,dinner,snack', 'apple pie', '[\"apple\"]', 320);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (81, 'lunch,dinner', 'cheese burger', '[\"beef\", \"cheese\"]', 425);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (82, 'lunch,dinner', 'hamburger', '[\"beef\"]', 300);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (83, 'lunch,dinner', 'double cheese burger', '[\"beef\", \"cheese\"]', 440);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (84, 'lunch,dinner', 'chicken and waffle', '[\"chicken\"]', 410);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (85, 'breakfast,lunch,dinner,snack', 'sweet potato', '[\"potato\"]', 164);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (86, 'lunch,dinner', 'cream pasta', '[\"milk\"]', 382);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (87, 'lunch,dinner', 'pasta', '[]', 130);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (88, 'lunch,dinner', 'spaghetti', '[]', 452);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (89, 'lunch,dinner', 'cream spaghetti', '[\"milk\"]', 555);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (90, 'lunch,dinner', 'pepperoni pizza', '[\"pork\"]', 298);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (91, 'lunch,dinner', 'veggie pizza', '[]', 182);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (92, 'lunch,dinner', 'chicken pizza', '[\"chicken\"]', 190);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (93, 'lunch,dinner', 'cheese pizza', '[\"cheese\"]', 200);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (94, 'lunch,dinner', 'beef pizza', '[\"beef\"]', 325);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (95, 'lunch,dinner', 'chicken taco', '[\"chicken\"]', 220);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (96, 'lunch,dinner', 'beef taco', '[\"beef\"]', 265);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (97, 'lunch,dinner', 'veggie taco', '[]', 195);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (98, 'lunch,dinner', 'sushi rolls', '[\"fish\"]', 147);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (99, 'lunch,dinner', 'fried rich', '[]', 228);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (100, 'breakfast,snack', 'butter toast', '[\"butter\"]', 128);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (101, 'breakfast,snack', 'jam toast', '[]', 128);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (102, 'breakfast,snack', 'cheese egg', '[\"cheese\", \"egg\"]', 350);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (103, 'breakfast,snack', 'bacon egg', '[\"egg\", \"pork\"]', 331);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (104, 'breakfast,snack', 'cheese omelet', '[\"cheese\", \"egg\"]', 407);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (105, 'breakfast,snack', 'veggie omelet', '[\"egg\"]', 350);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (106, 'breakfast,snack', 'ham omelet', '[\"egg\", \"pork\"]', 387);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (107, 'breakfast,snack', 'bananas', '[\"bananas\"]', 105);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (108, 'breakfast,snack', 'blueberry', '[\"blueberry\"]', 42);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (109, 'breakfast,snack', 'orange', '[\"orange\"]', 62);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (110, 'breakfast,snack', 'apple', '[\"apple\"]', 104);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (111, 'breakfast,snack', 'grapes', '[\"grapes\"]', 52);
INSERT INTO `meal` (`id`, `tag`, `name`, `contains`, `calories`) VALUES (112, 'breakfast,snack', 'mangoes', '[\"mangoes\"]', 90);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`userid`, `username`, `password`) VALUES (4, 'louis', '112211');
INSERT INTO `user` (`userid`, `username`, `password`) VALUES (5, 'steven', 'aabbcc');
INSERT INTO `user` (`userid`, `username`, `password`) VALUES (6, 'alex', 'aabbcc');
INSERT INTO `user` (`userid`, `username`, `password`) VALUES (7, 'dido', '$2b$12$HtgaRyEewp.kdWl5pAGnXeTUfndZkmOVKPf57uDi6txzc7TMu2xYS');
INSERT INTO `user` (`userid`, `username`, `password`) VALUES (8, 'evan', '$2b$12$Wlaja5i9RoJtdGEf470/p.b2TwPJpWs1TL7dWfS4XEhkFxJr2Vhy2');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
BEGIN;
INSERT INTO `userinfo` (`userid`, `username`, `gender`, `age`, `height`, `weight`, `target`, `calories`) VALUES (4, 'louis', 'male', 22, 170, 80, 75, 2048);
INSERT INTO `userinfo` (`userid`, `username`, `gender`, `age`, `height`, `weight`, `target`, `calories`) VALUES (5, 'steven', 'male', 0, 0, 0, 0, 0);
INSERT INTO `userinfo` (`userid`, `username`, `gender`, `age`, `height`, `weight`, `target`, `calories`) VALUES (6, 'alex', 'male', 22, 170, 70, 65, 1908);
INSERT INTO `userinfo` (`userid`, `username`, `gender`, `age`, `height`, `weight`, `target`, `calories`) VALUES (7, 'dido', 'male', 0, 0, 0, 0, 0);
INSERT INTO `userinfo` (`userid`, `username`, `gender`, `age`, `height`, `weight`, `target`, `calories`) VALUES (8, 'evan', 'male', 22, 170, 80, 75, 2082);
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
INSERT INTO `userpref` (`userid`, `breakfast`, `lunch`, `dinner`, `snack`, `dislike`, `allergies`) VALUES (8, 1, 1, 1, 1, '[\"apple\"]', '[\"gluton\"]');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
