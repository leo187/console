/*
Navicat MySQL Data Transfer

Source Server         : local-mysql
Source Server Version : 50519
Source Host           : localhost:3306
Source Database       : console

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2019-06-19 10:57:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for console_menu
-- ----------------------------
DROP TABLE IF EXISTS `console_menu`;
CREATE TABLE `console_menu` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `MENU_NAME` varchar(64) DEFAULT NULL COMMENT '菜单名称',
  `MENU_DESC` varchar(64) DEFAULT NULL COMMENT '菜单描述',
  `PARENT_ID` int(11) DEFAULT NULL COMMENT '父分类id',
  `MENU_CODE` varchar(64) DEFAULT NULL COMMENT '编码',
  `MENU_HREF` varchar(512) DEFAULT NULL COMMENT '链接',
  `ISADMIN_MENU` varchar(2) DEFAULT NULL,
  `IS_DELETE` varchar(2) DEFAULT NULL,
  `ISCAN_UPDATE` varchar(2) DEFAULT NULL,
  `MENU_LEVEL` varchar(32) DEFAULT NULL COMMENT '级别',
  `BUTTON_HTMLCONTENT` varchar(512) DEFAULT NULL,
  `ISMENU` varchar(2) DEFAULT NULL,
  `MENU_PARM1` int(11) DEFAULT NULL,
  `MENU_PARM2` int(11) DEFAULT NULL,
  `MENU_PARM3` varchar(128) DEFAULT NULL,
  `MENU_PARM4` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of console_menu
-- ----------------------------
INSERT INTO `console_menu` VALUES ('1', '菜单管理', '菜单管理', '0', '', '', '0', '0', '0', '', '', '', '1', null, '', '');
INSERT INTO `console_menu` VALUES ('2', '授权管理', '授权管理', '1', '130000', 'adminDatagrid?type=console', '0', '0', '0', '1', '<a href=\"<%=rootPath%>superadmin/user/adminDatagrid.do?type=console\" \r\n\r\nstyle=\"color:#ffffff;\">授权管理</a>', '1', '1', null, 'console', '');
INSERT INTO `console_menu` VALUES ('3', '用户管理', '用户管理', '2', '131000', '', '0', '0', '0', '2', '', '1', '1', null, '', '');
INSERT INTO `console_menu` VALUES ('4', '角色管理', '角色管理', '2', '132000', '', '0', '0', '0', '2', '', '1', '1', null, '', '');
INSERT INTO `console_menu` VALUES ('5', '菜单管理', '菜单管理', '2', '133000', 'superadmin/ConsoleMenu/getConsoleMenu.do?url=consoleuser/console_user_menu', '0', '0', '0', '2', 'superadmin/ConsoleMenu/getAllConsoleMenus.do', '3', '1', null, '', '');
INSERT INTO `console_menu` VALUES ('6', '所有用户', '所有用户', '3', '131100', 'superadmin/ConsoleUser/getAllConsoleUser?userState=2', '0', '0', '0', '3', '<a href=\"javascript:void(0)\" onclick=\"jump(\"<%=rootPath\r\n\r\n%>superadmin/ConsoleUser/getAllConsoleUser.do?userState=2\")\">所有用户</a>', '1', '1', null, '', '');
INSERT INTO `console_menu` VALUES ('7', '已启用', '已启用', '3', '131200', 'superadmin/ConsoleUser/getAllConsoleUser?userState=1', '0', '0', '0', '3', '<a href=\"javascript:void(0)\" onclick=\"jump(\"<%=rootPath\r\n\r\n%>superadmin/ConsoleUser/getAllConsoleUser.do?userState=1\")\">已启用</a>', '1', '1', null, '', '');
INSERT INTO `console_menu` VALUES ('8', '已停用', '已停用', '3', '131300', 'superadmin/ConsoleUser/getAllConsoleUser?userState=0', '0', '0', '0', '3', '<a href=\"javascript:void(0)\" onclick=\"jump(\"<%=rootPath\r\n\r\n%>superadmin/ConsoleUser/getAllConsoleUser.do?userState=0\")\">已停用</a>', '1', '1', null, '', '');
INSERT INTO `console_menu` VALUES ('9', '角色管理', '角色管理', '4', '132100', 'superadmin/ConsoleRole/getConsoleRoles?type=1', '0', '0', '0', '3', '<a href=\"javascript:void(0)\" onclick=\"jump(\"<%=rootPath\r\n\r\n%>superadmin/ConsoleRole/getConsoleRoles.do?type=1\")\">角色管理</a>', '1', '1', null, '', '');
INSERT INTO `console_menu` VALUES ('10', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for console_role
-- ----------------------------
DROP TABLE IF EXISTS `console_role`;
CREATE TABLE `console_role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ROLENAME` varchar(64) DEFAULT NULL COMMENT '角色名称',
  `ROLE_CODE` varchar(64) DEFAULT NULL COMMENT '角色编码',
  `IS_DELETE` varchar(2) DEFAULT NULL COMMENT '是否已删除',
  `ROLEDESC` varchar(256) DEFAULT NULL COMMENT '角色描述',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `CREATE_USERID` int(11) DEFAULT NULL COMMENT '创建人id',
  `CREATE_USERNAME` varchar(64) DEFAULT NULL COMMENT '创建人名称',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of console_role
-- ----------------------------
INSERT INTO `console_role` VALUES ('1', '权限管理员', null, null, '权限管理员', '2019-06-18 14:57:53', null, null);
INSERT INTO `console_role` VALUES ('2', '用户管理员', null, null, '用户管理', '2019-06-19 02:54:44', null, null);

-- ----------------------------
-- Table structure for console_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `console_role_menu`;
CREATE TABLE `console_role_menu` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ROLE_ID` int(11) DEFAULT NULL COMMENT '角色Id',
  `MENU_ID` int(11) DEFAULT NULL COMMENT '菜单ID',
  `TYPE` varchar(2) DEFAULT NULL COMMENT '类型',
  `ISCHILDREN_LIKES` varchar(256) DEFAULT NULL COMMENT '关联',
  `ISSHOW` datetime DEFAULT NULL COMMENT '启用',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of console_role_menu
-- ----------------------------
INSERT INTO `console_role_menu` VALUES ('1', '1', '1', null, null, null);
INSERT INTO `console_role_menu` VALUES ('2', '1', '2', null, null, null);
INSERT INTO `console_role_menu` VALUES ('3', '1', '3', null, null, null);
INSERT INTO `console_role_menu` VALUES ('4', '1', '4', null, null, null);
INSERT INTO `console_role_menu` VALUES ('5', '1', '5', null, null, null);
INSERT INTO `console_role_menu` VALUES ('6', '1', '6', null, null, null);
INSERT INTO `console_role_menu` VALUES ('7', '1', '9', null, null, null);
INSERT INTO `console_role_menu` VALUES ('8', '1', '7', null, null, null);
INSERT INTO `console_role_menu` VALUES ('9', '1', '8', null, null, null);
INSERT INTO `console_role_menu` VALUES ('10', '2', '1', null, null, null);
INSERT INTO `console_role_menu` VALUES ('11', '2', '2', null, null, null);
INSERT INTO `console_role_menu` VALUES ('12', '2', '3', null, null, null);
INSERT INTO `console_role_menu` VALUES ('13', '2', '6', null, null, null);
INSERT INTO `console_role_menu` VALUES ('14', '2', '7', null, null, null);
INSERT INTO `console_role_menu` VALUES ('15', '2', '8', null, null, null);

-- ----------------------------
-- Table structure for console_user
-- ----------------------------
DROP TABLE IF EXISTS `console_user`;
CREATE TABLE `console_user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `USERNAME` varchar(128) DEFAULT NULL COMMENT '用户名',
  `PASSWORD` varchar(128) DEFAULT NULL COMMENT '密码',
  `TRUENAME` varchar(32) DEFAULT NULL COMMENT '真实姓名',
  `USER_SEX` varchar(4) DEFAULT NULL COMMENT '性别',
  `USER_BIRTHDAY` datetime DEFAULT NULL COMMENT '生日',
  `USER_EMAIL` varchar(128) DEFAULT NULL COMMENT 'email',
  `USER_CREATTIME` datetime DEFAULT NULL COMMENT '创建时间',
  `USER_STATUS` int(11) DEFAULT NULL COMMENT '类型',
  `TELEPHONE` varchar(32) DEFAULT NULL COMMENT '手机号',
  `MOBILE` varchar(32) DEFAULT NULL,
  `DEPARTMENT` varchar(32) DEFAULT NULL COMMENT '部门',
  `USER_PARM1` int(11) DEFAULT NULL,
  `USER_PARM2` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of console_user
-- ----------------------------
INSERT INTO `console_user` VALUES ('1', 'leo', '123456', 'leo', '1', null, '', null, '1', '', '', null, null, null);
INSERT INTO `console_user` VALUES ('2', 'admin', '123456', '老大', null, null, '123798@qq.com', '2019-06-19 02:55:51', '1', '', '13311112222', null, null, null);

-- ----------------------------
-- Table structure for console_user_role
-- ----------------------------
DROP TABLE IF EXISTS `console_user_role`;
CREATE TABLE `console_user_role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `USER_ID` int(11) DEFAULT NULL COMMENT '用户id',
  `ROLE_ID` int(11) DEFAULT NULL COMMENT '角色id',
  `ROLE_NAME` varchar(32) DEFAULT NULL COMMENT '角色姓名',
  `STATUS` int(11) DEFAULT NULL COMMENT '状态',
  `CREATE_USERID` int(11) DEFAULT NULL COMMENT '创建人id',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `PARM1` int(11) DEFAULT NULL,
  `PARM2` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of console_user_role
-- ----------------------------
INSERT INTO `console_user_role` VALUES ('2', '2', '1', '权限管理员', null, null, '2019-06-19 02:55:51', null, null);
INSERT INTO `console_user_role` VALUES ('3', '1', '2', '用户管理员', null, null, '2019-06-19 02:56:30', null, null);
