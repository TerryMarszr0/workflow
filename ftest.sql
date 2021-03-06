/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50715
Source Host           : localhost:3306
Source Database       : ftest

Target Server Type    : MYSQL
Target Server Version : 50715
File Encoding         : 65001

Date: 2017-03-29 21:25:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------

-- ----------------------------
-- Table structure for client_status
-- ----------------------------
DROP TABLE IF EXISTS `client_status`;
CREATE TABLE `client_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pic_one` int(11) DEFAULT NULL,
  `pic_two` int(11) DEFAULT NULL,
  `face` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of client_status
-- ----------------------------

-- ----------------------------
-- Table structure for flow_action_info
-- ----------------------------
DROP TABLE IF EXISTS `flow_action_info`;
CREATE TABLE `flow_action_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `desc` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of flow_action_info
-- ----------------------------
INSERT INTO `flow_action_info` VALUES ('1', '主管审批', null);
INSERT INTO `flow_action_info` VALUES ('2', '经理审批', null);

-- ----------------------------
-- Table structure for flow_info
-- ----------------------------
DROP TABLE IF EXISTS `flow_info`;
CREATE TABLE `flow_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `desc` varchar(500) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `enable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of flow_info
-- ----------------------------
INSERT INTO `flow_info` VALUES ('1', '请假流程', '员工请假的流程', '2017-03-27 17:35:53', '1');
INSERT INTO `flow_info` VALUES ('2', '加班流程', null, '2017-03-27 17:37:20', '1');

-- ----------------------------
-- Table structure for flow_step_info
-- ----------------------------
DROP TABLE IF EXISTS `flow_step_info`;
CREATE TABLE `flow_step_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `flow_info` int(11) DEFAULT NULL,
  `flow_action_info` int(11) DEFAULT NULL,
  `repeat_no` int(11) DEFAULT NULL,
  `order_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `flow_info` (`flow_info`),
  KEY `flow_action_info` (`flow_action_info`),
  CONSTRAINT `flow_step_info_ibfk_1` FOREIGN KEY (`flow_info`) REFERENCES `flow_info` (`id`),
  CONSTRAINT `flow_step_info_ibfk_2` FOREIGN KEY (`flow_action_info`) REFERENCES `flow_action_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of flow_step_info
-- ----------------------------
INSERT INTO `flow_step_info` VALUES ('1', '主管审批', '1', '1', '1', '1');
INSERT INTO `flow_step_info` VALUES ('2', '经理审批', '1', '2', '1', '2');
INSERT INTO `flow_step_info` VALUES ('3', '主管审批', '2', '1', '1', '1');
INSERT INTO `flow_step_info` VALUES ('4', '经理审批', '2', '2', '1', '2');

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(80) DEFAULT NULL,
  `body` text,
  `pub_date` datetime DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `enable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '管理员', '2017-03-28 11:03:24', '1');
INSERT INTO `role` VALUES ('2', '员工', '2017-03-28 12:23:19', '1');
INSERT INTO `role` VALUES ('3', '主管', '2017-03-28 15:07:38', '1');
INSERT INTO `role` VALUES ('4', '经理', '2017-03-28 15:07:38', '1');

-- ----------------------------
-- Table structure for role_flow
-- ----------------------------
DROP TABLE IF EXISTS `role_flow`;
CREATE TABLE `role_flow` (
  `flow_info_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`flow_info_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `role_flow_ibfk_1` FOREIGN KEY (`flow_info_id`) REFERENCES `flow_info` (`id`),
  CONSTRAINT `role_flow_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_flow
-- ----------------------------
INSERT INTO `role_flow` VALUES ('1', '1');
INSERT INTO `role_flow` VALUES ('1', '2');
INSERT INTO `role_flow` VALUES ('2', '2');

-- ----------------------------
-- Table structure for tranct_proc
-- ----------------------------
DROP TABLE IF EXISTS `tranct_proc`;
CREATE TABLE `tranct_proc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `step_id` int(11) DEFAULT NULL,
  `step_action` int(11) DEFAULT NULL,
  `step_time` datetime DEFAULT NULL,
  `next_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `step_id` (`step_id`),
  KEY `next_user_id` (`next_user_id`),
  CONSTRAINT `tranct_proc_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `tranct_proc_ibfk_2` FOREIGN KEY (`step_id`) REFERENCES `flow_step_info` (`id`),
  CONSTRAINT `tranct_proc_ibfk_3` FOREIGN KEY (`next_user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tranct_proc
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'admin@example.com', '111111', '2016-12-29 16:36:35');
INSERT INTO `user` VALUES ('2', 'zyf', '1@1.com', '111111', '2016-12-29 16:36:39');
INSERT INTO `user` VALUES ('3', 'wqs', 'wqs@163.com', '111111', '2017-03-28 15:28:00');
INSERT INTO `user` VALUES ('4', 'hy', 'hy@163.com', '111111', '2017-03-28 15:32:00');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '1');
INSERT INTO `user_role` VALUES ('2', '2');
INSERT INTO `user_role` VALUES ('3', '3');
INSERT INTO `user_role` VALUES ('4', '4');
