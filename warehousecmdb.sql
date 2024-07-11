/*
Navicat MySQL Data Transfer

Source Server         : cmdb-test
Source Server Version : 50741
Source Host           : localhost:3306
Source Database       : warehousecmdb

Target Server Type    : MYSQL
Target Server Version : 50741
File Encoding         : 65001

Date: 2023-05-26 17:15:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for authorizerole
-- ----------------------------
DROP TABLE IF EXISTS `authorizerole`;
CREATE TABLE `authorizerole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group` varchar(200) DEFAULT NULL COMMENT '属组',
  `name` varchar(200) DEFAULT NULL COMMENT '规则名',
  `title` varchar(200) DEFAULT NULL COMMENT '标题',
  `authorized` varchar(200) DEFAULT NULL COMMENT '已授权用户',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authorizerole
-- ----------------------------
INSERT INTO `authorizerole` VALUES ('1', '5008', 'all', '超级权限', '');
INSERT INTO `authorizerole` VALUES ('2', '5001', 'user', '用户管理', '');
INSERT INTO `authorizerole` VALUES ('3', '5001', 'AuthorizeRole', '授权规则管理', '');
INSERT INTO `authorizerole` VALUES ('4', '5006', 'viewProductUpdateDiff', '生产更新代码审核', '');
INSERT INTO `authorizerole` VALUES ('5', '5006', 'ProductUpdateDiff', '查看生产更新记录', '');
INSERT INTO `authorizerole` VALUES ('6', '5001', 'AuthorizeRoleGroup', '授权规则组管理', null);
INSERT INTO `authorizerole` VALUES ('7', '5009', 'excel', '导出到Excel', null);
INSERT INTO `authorizerole` VALUES ('8', '5003', 'viewHostDailyCheck', '查看巡检结果', null);
INSERT INTO `authorizerole` VALUES ('10', '5003', 'HostDailyCheck', '查看巡检记录', null);
INSERT INTO `authorizerole` VALUES ('11', '5003', 'HostDailyCheckReport', '查看巡检报表', null);
INSERT INTO `authorizerole` VALUES ('12', '5003', 'downloadHostDailyCheck', '打包下载巡检结果', null);
INSERT INTO `authorizerole` VALUES ('13', '5004', 'NetworkDevice', '查看设备信息', null);
INSERT INTO `authorizerole` VALUES ('14', '5004', 'NetworkConfigManagement', '查看备份记录', null);
INSERT INTO `authorizerole` VALUES ('15', '5004', 'viewNetworkConfig', '查看设备配置', null);
INSERT INTO `authorizerole` VALUES ('16', '5004', 'viewNetworkConfigDiff', '比较设备配置', null);
INSERT INTO `authorizerole` VALUES ('17', '5004', 'downloadNetworkConfig', '打包下载最新配置', null);
INSERT INTO `authorizerole` VALUES ('18', '5005', 'SMSUsers', '接收用户管理', null);
INSERT INTO `authorizerole` VALUES ('19', '5005', 'SMSHistory', '发送记录查看', null);
INSERT INTO `authorizerole` VALUES ('20', '5002', 'caninet', '机柜管理', null);
INSERT INTO `authorizerole` VALUES ('21', '5002', 'supplier', '供应商管理', null);
INSERT INTO `authorizerole` VALUES ('22', '5002', 'device', '设备管理', null);
INSERT INTO `authorizerole` VALUES ('23', '5007', 'OperationLog', '日志查看', null);
INSERT INTO `authorizerole` VALUES ('24', '5001', 'AuthorizationForUser', '给用户授权', null);
INSERT INTO `authorizerole` VALUES ('25', '5009', 'addapi', 'Insert权限', null);
INSERT INTO `authorizerole` VALUES ('26', '5009', 'updateapi', 'Update权限', null);
INSERT INTO `authorizerole` VALUES ('27', '5009', 'delapi', 'Delete权限', null);
INSERT INTO `authorizerole` VALUES ('28', '5009', 'listapi', 'Select权限', null);
INSERT INTO `authorizerole` VALUES ('29', '5009', 'nav_yunwei', '运维导航', null);
INSERT INTO `authorizerole` VALUES ('31', '5012', 'fov_report', '全量FOV查看', null);

-- ----------------------------
-- Table structure for authorizerolegroup
-- ----------------------------
DROP TABLE IF EXISTS `authorizerolegroup`;
CREATE TABLE `authorizerolegroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_ame` varchar(200) DEFAULT NULL COMMENT '组名',
  `include_role` varchar(200) DEFAULT NULL COMMENT '包含模块',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5013 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authorizerolegroup
-- ----------------------------
INSERT INTO `authorizerolegroup` VALUES ('5001', '用户及权限管理模块', null);
INSERT INTO `authorizerolegroup` VALUES ('5002', '资产管理模块', null);
INSERT INTO `authorizerolegroup` VALUES ('5003', '系统巡检模块', null);
INSERT INTO `authorizerolegroup` VALUES ('5004', '网络配置管理模块', null);
INSERT INTO `authorizerolegroup` VALUES ('5005', '短信平台模块', null);
INSERT INTO `authorizerolegroup` VALUES ('5006', '生产更新模块', null);
INSERT INTO `authorizerolegroup` VALUES ('5007', '日志记录模块', null);
INSERT INTO `authorizerolegroup` VALUES ('5008', '超级权限', null);
INSERT INTO `authorizerolegroup` VALUES ('5009', '其它功能模块', null);
INSERT INTO `authorizerolegroup` VALUES ('5012', '冠捷现场', null);

-- ----------------------------
-- Table structure for caninet
-- ----------------------------
DROP TABLE IF EXISTS `caninet`;
CREATE TABLE `caninet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL COMMENT '机柜名',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of caninet
-- ----------------------------

-- ----------------------------
-- Table structure for device
-- ----------------------------
DROP TABLE IF EXISTS `device`;
CREATE TABLE `device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caninet` varchar(200) DEFAULT NULL COMMENT '机柜',
  `name` varchar(200) DEFAULT NULL COMMENT '设备名称',
  `model_no` varchar(200) DEFAULT NULL COMMENT '型号',
  `serial_no` varchar(200) DEFAULT NULL COMMENT '序列号',
  `express_service_code` varchar(200) DEFAULT NULL COMMENT '快速服务代码',
  `cpu` varchar(200) DEFAULT NULL COMMENT 'CPU',
  `memory` varchar(200) DEFAULT NULL COMMENT '内存',
  `hard_disk` varchar(200) DEFAULT NULL COMMENT '硬盘',
  `raid` varchar(200) DEFAULT NULL COMMENT 'RAID卡',
  `other_control_card` varchar(200) DEFAULT NULL COMMENT '其他控制卡',
  `power` varchar(200) DEFAULT NULL COMMENT '电源',
  `management_ip` varchar(200) DEFAULT NULL COMMENT '管理IP',
  `purchase_date` varchar(200) DEFAULT NULL COMMENT '采购日期',
  `supplier` varchar(200) DEFAULT NULL COMMENT '供货商',
  `ups` varchar(200) DEFAULT NULL COMMENT '是否开启',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of device
-- ----------------------------

-- ----------------------------
-- Table structure for email_notice
-- ----------------------------
DROP TABLE IF EXISTS `email_notice`;
CREATE TABLE `email_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project` varchar(255) NOT NULL COMMENT '项目名',
  `content` varchar(255) NOT NULL COMMENT '内容',
  `enclosure` varchar(255) DEFAULT NULL COMMENT '附件',
  `Timestamp` varchar(255) NOT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='邮件通知表';

-- ----------------------------
-- Records of email_notice
-- ----------------------------

-- ----------------------------
-- Table structure for fov_report
-- ----------------------------
DROP TABLE IF EXISTS `fov_report`;
CREATE TABLE `fov_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `line` varchar(200) NOT NULL,
  `model` varchar(200) NOT NULL,
  `path` varchar(200) NOT NULL,
  `notes` varchar(200) DEFAULT NULL,
  `Timestamp` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fov_report
-- ----------------------------
INSERT INTO `fov_report` VALUES ('1', 'M080', '9519P01-PLTVJY301XXGF-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\8\\9519P01-PLTVJY301XXGF-AA0_fovs', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('2', 'M080', 'D449P01-PLTVMW951XAD4-AAB', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\8\\D449P01-PLTVMW951XAD4-AAB', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('3', 'M080', 'D449P01-PLTVMY391XAD1-AAB', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\8\\D449P01-PLTVMY391XAD1-AAB', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('4', 'M080', 'C985-P0C-PLTVLWA51XXB4-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\8\\C985-P0C-PLTVLWA51XXB4-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('5', 'M080', 'A008P01-PLTVMY741XADE-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\8\\A008P01-PLTVMY741XADE-AB0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('6', 'M080', 'B739PD0-PLTVKU331XAAE-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\8\\B739PD0-PLTVKU331XAAE-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('7', 'M080', '9856P01-PLTVMQA41XADN-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\8\\9856P01-PLTVMQA41XADN-AB0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('8', 'M080', 'C932-PLTVLQ901XXB1-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\8\\C932-PLTVLQ901XXB1-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('9', 'M080', 'D580-PLTVMQA11XACJ-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\8\\D580-PLTVMQA11XACJ-AB0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('10', 'M090', '8967P0B-PLTVJW321XXGE-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\8967P0B-PLTVJW321XXGE-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('11', 'M090', '8967P0B-PLTVLW321XXGK-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\8967P0B-PLTVLW321XXGK-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('12', 'M090', 'C745P01-PLTVMIA21XADF-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\C745P01-PLTVMIA21XADF-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('13', 'M090', 'C745P01-PLTVMT651XAE4-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\C745P01-PLTVMT651XAE4-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('14', 'M090', 'C745P01-PLTVMI601XAAC-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\C745P01-PLTVMI601XAAC-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('15', 'M090', 'A860-PLTVLO181XADT-AA1', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\A860-PLTVLO181XADT-AA1', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('16', 'M090', '9165P01-PLTVKY291XADM-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\9165P01-PLTVKY291XADM-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('17', 'M090', 'B031P0D-ADTVJ1628ACA-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\B031P0D-ADTVJ1628ACA-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('18', 'M090', 'D621-PLTVMW951XAD5-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\D621-PLTVMW951XAD5-AB0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('19', 'M090', '9187P01-PLTVLI351XXB5-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\9187P01-PLTVLI351XXB5-AB0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('20', 'M090', 'B718P01-PLTVKL671XAAF_AA1', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\B718\\B718P01-PLTVKL671XAAF_AA1-M090', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('21', 'M011', 'D174P01-ADTVM2240AAB-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\D174-ADTVM2240AAB-AA0', '缺Img15', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('22', 'M011', 'D449P01-PLTVMW371XAD2-AAB', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\D449P01-PLTVMW371XAD2-AAB', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('23', 'M011', 'D449P01-PLTVMW951XAD4-AAB', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\D449P01-PLTVMW951XAD4-AAB', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('24', 'M011', 'D449P01-PLTVMY311XACZ-AAB', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\D449P01-PLTVMY311XACZ-AAB', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('25', 'M011', 'D449P01-PLTVMY391XAD1-AAB', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\D449P01-PLTVMY391XAD1-AAB', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('26', 'M011', 'D174P01-ADTVM2240AAP-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\D174-ADTVM2240AAP-AA0', '缺Img15', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('27', 'M011', 'D174P01-ADTVM2240AAL-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\D174P01-ADTVM2240AAL-AA0', '缺Img15', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('28', 'M011', 'A942-ADTVM2225AAG-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\A942-ADTVM2225AAG-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('29', 'M011', 'B718P01-PLTVKL671XAAF_AA1', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\B718P01-PLTVKL671XAAF_AA1', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('30', 'M011', 'D174-ADTVM2240AAB-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('31', 'M013', '9749P01-PLTVIQ331XACB-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\13\\9749P01-PLTVIQ331XACB-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('32', 'M013', 'C529P01-PLTVLJ501XAGZ-AA1', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\13\\C529P01-PLTVLJ501XAGZ-AA1', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('33', 'M013', 'C745P01-PLTVMIA21XADF-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\13\\C745P01-PLTVMIA21XADF-AA0', '缺Img5', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('34', 'M013', '7801P01-PLTVJL271XXW2-AA1', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\13\\7801P01-PLTVJL271XXW2-AA1', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('35', 'M013', 'C965P0D-PLTVMIA81XAEA-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\13\\C965P0D-PLTVMIA81XAEA-AB0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('36', 'M080', 'D580-PLTVMQA11XACJ-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\8\\D580', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('37', 'M090', '9187P01-PLTVLI351XXB5-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\9187', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('38', 'M080', '9856P01-PLTVMQA41XADN-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\8\\9856', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('39', 'M090', '9187P01-PLTVLI351XXB6-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\9187', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('40', 'M013', 'C965P0D-PLTVMTB52XXP2-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\13\\c965', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('41', 'M011', '9165P01-PLTVKY291XADM-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\9165', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('42', 'M090', '8967P0B-PLTVJJ321XXGK-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\8967\\', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('43', 'M013', 'A025P01-PLTVLM681XXF6-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\13\\A025', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('44', 'M013', '9892P0B-ADTVM2255AAR-AB1', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\13\\9892', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('45', 'M013', 'A018P0A-PLTVLIA21XAAM-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\13\\A018\\A018P0A-PLTVLIA21XAAM-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('46', 'M090', 'D580-PLTVMQA11XAD7-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\D580\\D580-PLTVMQA11XAD7-AB0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('47', 'M090', 'A860-PLTVLO181XADT-AA1', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\A860\\A860-PLTVLO181XADT-AA1', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('48', 'M013', 'A008P01-PLTVMWA61XACG-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\13\\A008\\A008P01-PLTVMWA61XACG-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('49', 'M080', 'B739PD0-PLTVKU331XXAF-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\8\\B739\\B739PD0-PLTVKU331XXAF-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('50', 'M013', 'C965P0D-PLTVMIA81XXE1-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\13\\C965\\C965P0D-PLTVMIA81XXE1-AB0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('51', 'M011', 'D449P01-PLTVMWA81XADT-AAB', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\D449\\D449P01-PLTVMWA81XADT-AAB', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('52', 'M080', '9856P01-PLTVMYA21XAEE-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\8\\9856\\9856P01-PLTVMYA21XAEE-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('53', 'M011', 'D580-PLTVMQA11XACJ-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\D580\\D580-PLTVMQA11XACJ-AB0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('54', 'M090', 'C745P0D-PLTVLI621XAH8-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\C745\\C745P0D-PLTVLI621XAH8-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('55', 'M013', 'D621-PLTVMY411XACI-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\13\\D621\\D621-PLTVMY411XACI-AB0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('56', 'M090', 'C745P01-PLTVMIA21XADG-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\9\\C745\\C745P01-PLTVMIA21XADG-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('57', 'M011', 'A008P01-PLTVMY741XADE-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\A008\\A008P01-PLTVMY741XADE-AB0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('58', 'M013', 'A018P0A-PLTVLY421XADK-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\13\\A018\\A018P0A-PLTVLY421XADK-AA0', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('59', 'M080', '9856P0A-PLTVLQ321XAHC-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\MI8-生产数据物料\\9856', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('60', 'M080', '9856P01-PLTVLY521XAAZ-AAO', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\MI8-生产数据物料\\9856', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('61', 'M011', '9856P01-PLTVMYA21XAEE-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\9856\\9856P01-PLTVMYA21XAEE-AA0', 'fov不全', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('62', 'M011', 'B897-ADTVL1811ABM-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\B897', '', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('63', 'M011', 'C745P01-PLTVMIA21XADG-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\C745\\C745P01-PLTVMIA21XADG-AA0', 'fov不全', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('64', 'M080', 'C529P02-PLTVMIA11XXA3-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\8\\C529\\C529P02-PLTVMIA11XXA3-AB0', 'fov不全', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('65', 'M013', 'C965P0D-PLTVMIA21XADP-AB0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\13\\C965\\C965P0D-PLTVMIA21XADP-AB0', 'fov不全', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('66', 'M011', 'A025P01-PLTVLM681XXF6-AA0', '\\\\192.168.2.71\\public\\工业质检\\项目\\冠捷\\冠捷产线建模物料和测试物料\\all_fovs\\11\\A025\\A025P01-PLTVLM681XXF6-AA0', 'fov不全', '2023/5/26 12:49:17');
INSERT INTO `fov_report` VALUES ('67', '', '', '', '', '');

-- ----------------------------
-- Table structure for hostdailycheck
-- ----------------------------
DROP TABLE IF EXISTS `hostdailycheck`;
CREATE TABLE `hostdailycheck` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Hostname` varchar(200) DEFAULT NULL COMMENT '主机名',
  `LastCheck` varchar(200) DEFAULT NULL COMMENT '最近一次检查',
  `FilePath` varchar(200) DEFAULT NULL COMMENT '文件路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hostdailycheck
-- ----------------------------
INSERT INTO `hostdailycheck` VALUES ('1', 'offline-deploy', '2023-05-23 16:36:52', 'upload/HostDailyCheck/HostDailyCheck-offline-deploy-20230523.txt');
INSERT INTO `hostdailycheck` VALUES ('2', 'offline-deploy', '2023-05-23 16:38:57', 'upload/HostDailyCheck/HostDailyCheck-offline-deploy-20230523.txt');
INSERT INTO `hostdailycheck` VALUES ('3', 'offline-deploy', '2023-05-23 16:40:38', 'upload/HostDailyCheck/HostDailyCheck-offline-deploy-20230523.txt');

-- ----------------------------
-- Table structure for hostdailycheckreport
-- ----------------------------
DROP TABLE IF EXISTS `hostdailycheckreport`;
CREATE TABLE `hostdailycheckreport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `DateTime` varchar(200) DEFAULT NULL COMMENT '时间戳',
  `Hostname` varchar(200) DEFAULT NULL COMMENT '主机名',
  `OSRelease` varchar(200) DEFAULT NULL COMMENT '发行版本',
  `Kernel` varchar(200) DEFAULT NULL COMMENT '内核',
  `Language` varchar(200) DEFAULT NULL COMMENT '语言/编码',
  `LastReboot` varchar(200) DEFAULT NULL COMMENT '最近启动时间',
  `Uptime` varchar(200) DEFAULT NULL COMMENT '运行时间',
  `CPUs` varchar(200) DEFAULT NULL COMMENT 'CPU数量',
  `CPUType` varchar(200) DEFAULT NULL COMMENT 'CPU类型',
  `Arch` varchar(200) DEFAULT NULL COMMENT 'CPU架构',
  `MemTotal` varchar(200) DEFAULT NULL COMMENT '内存总容量',
  `MemFree` varchar(200) DEFAULT NULL COMMENT '内存剩余',
  `MemUsedPercent` varchar(200) DEFAULT NULL COMMENT '内存使用率',
  `DiskTotal` varchar(200) DEFAULT NULL COMMENT '硬盘总容量',
  `DiskFree` varchar(200) DEFAULT NULL COMMENT '硬盘剩余',
  `DiskUsedPercent` varchar(200) DEFAULT NULL COMMENT '硬盘使用率',
  `InodeTotal` varchar(200) DEFAULT NULL COMMENT 'Inode总量',
  `InodeFree` varchar(200) DEFAULT NULL COMMENT 'Inode剩余',
  `InodeUsedPercent` varchar(200) DEFAULT NULL COMMENT 'Inode使用率',
  `IP` varchar(200) DEFAULT NULL COMMENT 'IP地址',
  `MAC` text COMMENT 'MAC地址',
  `Gateway` varchar(200) DEFAULT NULL COMMENT '默认网关',
  `DNS` varchar(200) DEFAULT NULL COMMENT 'DNS',
  `Listen` varchar(200) DEFAULT NULL COMMENT '监听',
  `Selinux` varchar(200) DEFAULT NULL COMMENT 'Selinux',
  `Firewall` varchar(200) DEFAULT NULL COMMENT '防火墙',
  `USERs` varchar(200) DEFAULT NULL COMMENT '用户数',
  `USEREmptyPassword` varchar(200) DEFAULT NULL COMMENT '含空密码用户',
  `USERTheSameUID` varchar(200) DEFAULT NULL COMMENT '含相同UID用户',
  `PasswordExpiry` varchar(200) DEFAULT NULL COMMENT '密码过期（天）',
  `RootUser` varchar(200) DEFAULT NULL COMMENT '特权用户数量',
  `Sudoers` varchar(200) DEFAULT NULL COMMENT 'sudo授权',
  `SSHAuthorized` varchar(200) DEFAULT NULL COMMENT 'SSH信任主机',
  `SSHDProtocolVersion` varchar(200) DEFAULT NULL COMMENT 'SSH协议版本',
  `SSHDPermitRootLogin` varchar(200) DEFAULT NULL COMMENT '允许root远程登录',
  `DefunctProsess` varchar(200) DEFAULT NULL COMMENT '僵尸进程数量',
  `SelfInitiatedService` varchar(200) DEFAULT NULL COMMENT '自启动服务数量',
  `SelfInitiatedProgram` varchar(200) DEFAULT NULL COMMENT '自启动程序数量',
  `RuningService` varchar(200) DEFAULT NULL COMMENT '运行中服务数',
  `Crontab` varchar(200) DEFAULT NULL COMMENT '计划任务数',
  `Syslog` varchar(200) DEFAULT NULL COMMENT '日志服务',
  `SNMP` varchar(200) DEFAULT NULL COMMENT 'SNMP',
  `NTP` varchar(200) DEFAULT NULL COMMENT 'NTP',
  `JDK` varchar(200) DEFAULT NULL COMMENT 'JDK版本',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hostdailycheckreport
-- ----------------------------

-- ----------------------------
-- Table structure for networkconfigmanagement
-- ----------------------------
DROP TABLE IF EXISTS `networkconfigmanagement`;
CREATE TABLE `networkconfigmanagement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `DeviceName` varchar(200) DEFAULT NULL COMMENT '设备名',
  `LastCheckTime` varchar(200) DEFAULT NULL COMMENT '时间戳',
  `ConfigFilePath` varchar(200) DEFAULT NULL COMMENT '配置文件路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of networkconfigmanagement
-- ----------------------------

-- ----------------------------
-- Table structure for networkconfigmanagementreport
-- ----------------------------
DROP TABLE IF EXISTS `networkconfigmanagementreport`;
CREATE TABLE `networkconfigmanagementreport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `DeviceName` varchar(200) DEFAULT NULL COMMENT '设备名',
  `LastCheckTime` varchar(200) DEFAULT NULL COMMENT '最后检查时间',
  `LastChageTime` varchar(200) DEFAULT NULL COMMENT '最后变更时间',
  `ChageDetail` varchar(200) DEFAULT NULL COMMENT '变更内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of networkconfigmanagementreport
-- ----------------------------

-- ----------------------------
-- Table structure for networkdevice
-- ----------------------------
DROP TABLE IF EXISTS `networkdevice`;
CREATE TABLE `networkdevice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `DeviceName` varchar(200) DEFAULT NULL COMMENT '设备名',
  `IPAddr` varchar(200) DEFAULT NULL COMMENT '管理IP',
  `Username` varchar(200) DEFAULT NULL COMMENT '用户名',
  `Passwd` varchar(200) DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of networkdevice
-- ----------------------------

-- ----------------------------
-- Table structure for operationlog
-- ----------------------------
DROP TABLE IF EXISTS `operationlog`;
CREATE TABLE `operationlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Timestamp` varchar(200) DEFAULT NULL COMMENT '时间戳',
  `User` varchar(200) DEFAULT NULL COMMENT '用户',
  `Entryip` varchar(200) DEFAULT NULL COMMENT '登录IP',
  `Level` varchar(200) DEFAULT NULL COMMENT '日志等级',
  `Messages` varchar(200) DEFAULT NULL COMMENT '日志信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=343 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of operationlog
-- ----------------------------
INSERT INTO `operationlog` VALUES ('111', '2023-05-22 16:15:26', 'warehouseadmin', '127.0.0.1', 'INFO', '为数据表 fov_report 添加一条记录,id=1');
INSERT INTO `operationlog` VALUES ('112', '2023-05-22 16:16:33', 'warehouseadmin', '127.0.0.1', 'INFO', '从数据表 fov_report 删除一条记录，id=1');
INSERT INTO `operationlog` VALUES ('113', '2023-05-22 16:16:41', 'warehouseadmin', '127.0.0.1', 'INFO', '为数据表 fov_report 添加一条记录,id=2');
INSERT INTO `operationlog` VALUES ('114', '2023-05-22 16:16:53', 'warehouseadmin', '127.0.0.1', 'INFO', '导出文件 全量FOV_2023.05.22.xls');
INSERT INTO `operationlog` VALUES ('115', '2023-05-22 16:17:45', 'warehouseadmin', '127.0.0.1', 'INFO', '修改数据表 fov_report 一条记录,id=2');
INSERT INTO `operationlog` VALUES ('116', '2023-05-22 16:19:04', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('117', '2023-05-22 16:19:15', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('118', '2023-05-22 16:25:25', 'warehouseadmin', '192.168.4.41', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('119', '2023-05-22 16:58:33', 'warehouseadmin', '192.168.4.41', 'INFO', '为数据表 fov_report 添加一条记录,id=19');
INSERT INTO `operationlog` VALUES ('120', '2023-05-22 17:08:44', 'warehouseadmin', '192.168.4.41', 'INFO', '为数据表 fov_report 添加一条记录,id=32');
INSERT INTO `operationlog` VALUES ('121', '2023-05-22 18:25:39', 'warehouseadmin', '192.168.4.41', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('122', '2023-05-22 18:29:24', 'anonymous', '192.168.4.41', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('123', '2023-05-22 18:29:27', 'warehouseadmin', '192.168.4.41', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('124', '2023-05-22 18:32:47', 'anonymous', '192.168.4.41', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('125', '2023-05-22 18:32:50', 'warehouseadmin', '192.168.4.41', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('126', '2023-05-22 18:38:39', 'anonymous', '192.168.4.41', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('127', '2023-05-22 18:38:43', 'warehouseadmin', '192.168.4.41', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('128', '2023-05-23 09:28:29', 'anonymous', '192.168.4.41', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('129', '2023-05-23 09:33:26', 'warehouseadmin', '192.168.4.41', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('130', '2023-05-23 09:34:13', 'anonymous', '192.168.4.41', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('131', '2023-05-23 09:34:21', 'warehouseadmin', '192.168.4.41', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('132', '2023-05-23 10:25:36', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('133', '2023-05-23 10:26:54', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('134', '2023-05-23 10:26:57', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('135', '2023-05-23 10:27:32', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('136', '2023-05-23 10:27:34', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('137', '2023-05-23 10:28:45', 'warehouseadmin', '127.0.0.1', 'INFO', '为数据表 AuthorizeRoleGroup 添加一条记录,id=5012');
INSERT INTO `operationlog` VALUES ('138', '2023-05-23 10:29:50', 'warehouseadmin', '127.0.0.1', 'INFO', '添加授权规则 全量FOV查看');
INSERT INTO `operationlog` VALUES ('139', '2023-05-23 10:30:24', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('140', '2023-05-23 10:30:24', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('141', '2023-05-23 10:30:32', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('142', '2023-05-23 10:30:34', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('143', '2023-05-23 10:33:17', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('144', '2023-05-23 10:33:19', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('145', '2023-05-23 10:33:46', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('146', '2023-05-23 10:33:46', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('147', '2023-05-23 10:33:50', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('148', '2023-05-23 10:33:52', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('149', '2023-05-23 10:38:28', 'liyu', '127.0.0.1', 'INFO', '导出文件 全量FOV_2023.05.23.xls');
INSERT INTO `operationlog` VALUES ('150', '2023-05-23 10:38:48', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('151', '2023-05-23 10:38:51', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('152', '2023-05-23 10:39:21', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('153', '2023-05-23 10:39:21', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('154', '2023-05-23 10:39:27', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('155', '2023-05-23 10:39:29', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('156', '2023-05-23 10:41:43', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('157', '2023-05-23 10:41:44', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('158', '2023-05-23 10:41:54', 'warehouseadmin', '127.0.0.1', 'INFO', '为数据表 fov_report 添加一条记录,id=45');
INSERT INTO `operationlog` VALUES ('159', '2023-05-23 11:11:16', 'anonymous', '192.168.4.41', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('160', '2023-05-23 11:32:40', 'warehouseadmin', '192.168.4.41', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('161', '2023-05-23 11:32:44', 'warehouseadmin', '192.168.4.41', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('162', '2023-05-23 11:33:36', 'warehouseadmin', '192.168.4.41', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('163', '2023-05-23 11:38:42', 'anonymous', '192.168.4.41', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('164', '2023-05-23 11:38:47', 'warehouseadmin', '192.168.4.41', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('165', '2023-05-23 11:39:49', 'anonymous', '192.168.4.41', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('166', '2023-05-23 11:39:54', 'warehouseadmin', '192.168.4.41', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('167', '2023-05-23 11:58:17', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('168', '2023-05-23 11:58:21', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('169', '2023-05-23 11:58:51', 'warehouseadmin', '127.0.0.1', 'INFO', '导出文件 全量FOV_2023.05.23.xls');
INSERT INTO `operationlog` VALUES ('170', '2023-05-23 12:19:56', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('171', '2023-05-23 12:19:58', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('172', '2023-05-23 12:57:53', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('173', '2023-05-23 12:57:55', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('174', '2023-05-23 12:58:34', 'warehouseadmin', '127.0.0.1', 'INFO', '导出文件 全量FOV_2023.05.23.xls');
INSERT INTO `operationlog` VALUES ('175', '2023-05-23 12:58:42', 'warehouseadmin', '127.0.0.1', 'INFO', '导出文件 全量FOV_2023.05.23.xls');
INSERT INTO `operationlog` VALUES ('176', '2023-05-23 15:17:21', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('177', '2023-05-23 15:17:21', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('178', '2023-05-23 15:18:00', 'warehouseadmin', '127.0.0.1', 'INFO', '从数据表 AuthorizeRole 删除一条记录，id=30');
INSERT INTO `operationlog` VALUES ('179', '2023-05-23 15:18:29', 'warehouseadmin', '127.0.0.1', 'INFO', '添加授权规则 全量FOV查看');
INSERT INTO `operationlog` VALUES ('180', '2023-05-23 15:18:46', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 mayugui 授权成功！');
INSERT INTO `operationlog` VALUES ('181', '2023-05-23 15:18:46', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('182', '2023-05-23 15:19:05', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 mayugui 授权成功！');
INSERT INTO `operationlog` VALUES ('183', '2023-05-23 15:19:05', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('184', '2023-05-23 15:19:20', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('185', '2023-05-23 15:19:29', 'mayugui', '127.0.0.1', 'INFO', '用户 mayugui 登录成功！');
INSERT INTO `operationlog` VALUES ('186', '2023-05-23 15:19:35', 'anonymous', '127.0.0.1', 'INFO', '用户 mayugui 退出系统！');
INSERT INTO `operationlog` VALUES ('187', '2023-05-23 15:19:38', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('188', '2023-05-23 15:19:46', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 mayugui 授权成功！');
INSERT INTO `operationlog` VALUES ('189', '2023-05-23 15:19:46', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('190', '2023-05-23 15:20:07', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('191', '2023-05-23 15:20:07', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('192', '2023-05-23 15:20:12', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('193', '2023-05-23 15:20:14', 'mayugui', '127.0.0.1', 'INFO', '用户 mayugui 登录成功！');
INSERT INTO `operationlog` VALUES ('194', '2023-05-23 15:20:29', 'anonymous', '127.0.0.1', 'INFO', '用户 mayugui 退出系统！');
INSERT INTO `operationlog` VALUES ('195', '2023-05-23 15:20:31', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('196', '2023-05-23 15:37:29', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('197', '2023-05-23 15:37:32', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('198', '2023-05-23 16:08:25', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('199', '2023-05-23 16:08:28', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('200', '2023-05-23 16:19:14', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('201', '2023-05-23 16:19:16', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('202', '2023-05-23 16:19:33', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('203', '2023-05-23 16:19:36', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('204', '2023-05-23 16:19:46', 'warehouseadmin', '127.0.0.1', 'INFO', '为数据表 fov_report 添加一条记录,id=46');
INSERT INTO `operationlog` VALUES ('205', '2023-05-23 16:20:21', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('206', '2023-05-23 16:20:23', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('207', '2023-05-23 16:20:26', 'liyu', '127.0.0.1', 'INFO', '导出文件 全量FOV_2023.05.23.xls');
INSERT INTO `operationlog` VALUES ('208', '2023-05-23 16:34:57', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('209', '2023-05-23 16:34:59', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('210', '2023-05-23 16:57:44', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('211', '2023-05-23 16:57:47', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('212', '2023-05-23 17:04:36', 'liyu', '127.0.0.1', 'INFO', '修改数据表 fov_report 一条记录,id=46');
INSERT INTO `operationlog` VALUES ('213', '2023-05-23 17:04:59', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('214', '2023-05-23 17:05:01', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('215', '2023-05-23 17:05:23', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('216', '2023-05-23 17:05:23', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('217', '2023-05-23 17:05:29', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('218', '2023-05-23 17:05:31', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('219', '2023-05-23 17:05:59', 'liyu', '127.0.0.1', 'INFO', '修改数据表 fov_report 一条记录,id=46');
INSERT INTO `operationlog` VALUES ('220', '2023-05-23 17:07:41', 'liyu', '127.0.0.1', 'INFO', '修改数据表 fov_report 一条记录,id=46');
INSERT INTO `operationlog` VALUES ('221', '2023-05-23 17:22:02', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('222', '2023-05-23 17:22:05', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('223', '2023-05-23 17:36:18', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('224', '2023-05-23 17:36:20', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('225', '2023-05-23 17:38:49', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('226', '2023-05-23 17:38:51', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('227', '2023-05-23 17:40:10', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('228', '2023-05-23 17:40:10', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('229', '2023-05-23 17:40:18', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('230', '2023-05-23 17:40:20', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('231', '2023-05-23 18:20:14', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('232', '2023-05-23 18:20:16', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('233', '2023-05-23 21:53:59', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('234', '2023-05-23 21:53:59', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('235', '2023-05-23 21:54:06', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('236', '2023-05-23 21:54:09', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('237', '2023-05-23 21:56:37', 'liyu', '127.0.0.1', 'INFO', '导出文件 查看设备信息_2023.05.23.xls');
INSERT INTO `operationlog` VALUES ('238', '2023-05-24 09:31:39', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('239', '2023-05-24 09:31:41', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('240', '2023-05-24 09:32:30', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('241', '2023-05-24 09:32:30', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('242', '2023-05-24 09:32:33', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('243', '2023-05-24 09:32:33', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('244', '2023-05-24 09:33:08', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('245', '2023-05-24 09:33:08', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('246', '2023-05-24 09:33:24', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('247', '2023-05-24 09:33:26', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('248', '2023-05-24 09:33:41', 'liyu', '127.0.0.1', 'INFO', '导出文件 机柜管理_2023.05.24.xls');
INSERT INTO `operationlog` VALUES ('249', '2023-05-24 09:36:30', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('250', '2023-05-24 09:36:33', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('251', '2023-05-24 09:41:17', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('252', '2023-05-24 09:41:19', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('253', '2023-05-24 09:41:57', 'warehouseadmin', '127.0.0.1', 'INFO', '为数据表 fov_report 添加一条记录,id=47');
INSERT INTO `operationlog` VALUES ('254', '2023-05-24 09:43:46', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('255', '2023-05-24 09:43:48', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('256', '2023-05-24 09:59:14', 'liyu', '127.0.0.1', 'INFO', '导出文件 全量FOV_2023.05.24.xls');
INSERT INTO `operationlog` VALUES ('257', '2023-05-24 09:59:36', 'liyu', '127.0.0.1', 'INFO', '导出文件 全量FOV_2023.05.24.xls');
INSERT INTO `operationlog` VALUES ('258', '2023-05-24 10:20:18', 'liyu', '127.0.0.1', 'INFO', '从数据表 fov_report 删除一条记录，id=47');
INSERT INTO `operationlog` VALUES ('259', '2023-05-24 10:20:34', 'liyu', '127.0.0.1', 'INFO', '为数据表 fov_report 添加一条记录,id=49');
INSERT INTO `operationlog` VALUES ('260', '2023-05-24 10:20:44', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('261', '2023-05-24 10:20:47', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('262', '2023-05-24 10:22:16', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('263', '2023-05-24 10:22:17', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('264', '2023-05-24 10:22:22', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('265', '2023-05-24 10:22:24', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('266', '2023-05-24 10:22:31', 'liyu', '127.0.0.1', 'INFO', '从数据表 fov_report 删除一条记录，id=49');
INSERT INTO `operationlog` VALUES ('267', '2023-05-24 10:22:50', 'liyu', '127.0.0.1', 'INFO', '为数据表 fov_report 添加一条记录,id=50');
INSERT INTO `operationlog` VALUES ('268', '2023-05-24 10:23:15', 'liyu', '127.0.0.1', 'INFO', '为数据表 fov_report 添加一条记录,id=51');
INSERT INTO `operationlog` VALUES ('269', '2023-05-24 10:23:23', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('270', '2023-05-24 10:23:25', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('271', '2023-05-24 10:53:07', 'warehouseadmin', '127.0.0.1', 'INFO', '从数据表 fov_report 删除一条记录，id=50');
INSERT INTO `operationlog` VALUES ('272', '2023-05-24 10:53:28', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('273', '2023-05-24 10:53:30', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('274', '2023-05-24 10:58:35', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('275', '2023-05-24 10:58:38', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('276', '2023-05-24 10:59:14', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('277', '2023-05-24 10:59:14', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('278', '2023-05-24 10:59:25', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('279', '2023-05-24 10:59:27', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('280', '2023-05-24 11:00:53', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('281', '2023-05-24 11:00:56', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('282', '2023-05-24 11:01:04', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('283', '2023-05-24 11:01:07', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('284', '2023-05-24 11:01:31', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('285', '2023-05-24 11:01:31', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('286', '2023-05-24 11:01:43', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('287', '2023-05-24 11:01:45', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('288', '2023-05-24 14:18:53', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('289', '2023-05-24 14:18:55', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('290', '2023-05-24 14:19:07', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('291', '2023-05-24 14:19:07', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('292', '2023-05-24 14:19:13', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('293', '2023-05-24 14:19:16', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('294', '2023-05-24 14:19:20', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('295', '2023-05-24 14:19:21', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('296', '2023-05-24 14:22:29', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('297', '2023-05-24 14:22:31', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('298', '2023-05-24 14:24:11', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('299', '2023-05-24 14:24:13', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('300', '2023-05-24 14:24:16', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('301', '2023-05-24 14:24:19', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('302', '2023-05-24 14:24:24', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('303', '2023-05-24 14:24:27', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('304', '2023-05-24 14:24:35', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('305', '2023-05-24 14:24:36', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('306', '2023-05-24 14:24:43', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('307', '2023-05-24 14:24:45', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('308', '2023-05-24 14:52:02', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('309', '2023-05-24 14:52:05', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('310', '2023-05-24 14:52:14', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('311', '2023-05-24 14:52:14', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('312', '2023-05-24 14:52:26', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('313', '2023-05-24 14:52:26', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('314', '2023-05-24 14:52:33', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('315', '2023-05-24 14:52:36', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('316', '2023-05-24 14:59:38', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('317', '2023-05-24 14:59:40', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('318', '2023-05-24 15:09:30', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('319', '2023-05-24 15:09:33', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('320', '2023-05-24 15:09:40', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('321', '2023-05-24 15:09:40', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('322', '2023-05-24 15:09:45', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('323', '2023-05-24 15:09:48', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('324', '2023-05-24 15:10:03', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('325', '2023-05-24 15:10:05', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('326', '2023-05-24 15:10:15', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('327', '2023-05-24 15:10:15', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('328', '2023-05-24 15:10:23', 'anonymous', '127.0.0.1', 'INFO', '用户 warehouseadmin 退出系统！');
INSERT INTO `operationlog` VALUES ('329', '2023-05-24 15:10:26', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('330', '2023-05-24 15:16:28', 'anonymous', '127.0.0.1', 'INFO', '用户 liyu 退出系统！');
INSERT INTO `operationlog` VALUES ('331', '2023-05-24 15:16:30', 'warehouseadmin', '127.0.0.1', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('332', '2023-05-24 15:16:42', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('333', '2023-05-24 16:33:58', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('334', '2023-05-24 16:33:58', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('335', '2023-05-25 09:21:57', 'liyu', '127.0.0.1', 'INFO', '用户 liyu 登录成功！');
INSERT INTO `operationlog` VALUES ('336', '2023-05-25 09:28:33', 'warehouseadmin', '127.0.0.1', 'INFO', '给用户 liyu 授权成功！');
INSERT INTO `operationlog` VALUES ('337', '2023-05-25 09:28:33', 'warehouseadmin', '127.0.0.1', 'INFO', '管理员更新了您的权限！请重新登录');
INSERT INTO `operationlog` VALUES ('338', '2023-05-25 10:07:06', 'liyu', '127.0.0.1', 'INFO', '从数据表 fov_report 删除一条记录，id=46');
INSERT INTO `operationlog` VALUES ('339', '2023-05-25 10:09:31', 'liyu', '127.0.0.1', 'INFO', '修改数据表 fov_report 一条记录,id=45');
INSERT INTO `operationlog` VALUES ('340', '2023-05-25 10:10:03', 'liyu', '127.0.0.1', 'INFO', '为数据表 fov_report 添加一条记录,id=54');
INSERT INTO `operationlog` VALUES ('341', '2023-05-25 11:03:06', 'warehouseadmin', '192.168.4.41', 'INFO', '用户 warehouseadmin 登录成功！');
INSERT INTO `operationlog` VALUES ('342', '2023-05-26 16:02:40', 'warehouseadmin', '192.168.4.41', 'INFO', '用户 warehouseadmin 登录成功！');

-- ----------------------------
-- Table structure for packinfo
-- ----------------------------
DROP TABLE IF EXISTS `packinfo`;
CREATE TABLE `packinfo` (
  `AutoID` int(11) NOT NULL AUTO_INCREMENT,
  `project` varchar(255) NOT NULL DEFAULT '0',
  `packcontent` varchar(255) DEFAULT '0',
  `statuscode` varchar(255) DEFAULT '0',
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`AutoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of packinfo
-- ----------------------------

-- ----------------------------
-- Table structure for productupdatediff
-- ----------------------------
DROP TABLE IF EXISTS `productupdatediff`;
CREATE TABLE `productupdatediff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `UUID` varchar(200) DEFAULT NULL COMMENT 'UUID',
  `Timestamp` varchar(200) DEFAULT NULL COMMENT '时间戳',
  `HostName` varchar(200) DEFAULT NULL COMMENT '主机名',
  `PackageLocation` varchar(200) DEFAULT NULL COMMENT '更新包位置',
  `DiffFileLocation` varchar(200) DEFAULT NULL COMMENT 'Diff文件位置',
  `Title` varchar(200) DEFAULT NULL COMMENT '更新主题',
  `ProjectLeader` varchar(200) DEFAULT NULL COMMENT '更新申请人',
  `Executor` varchar(200) DEFAULT NULL COMMENT '执行人',
  `Status` varchar(200) DEFAULT NULL COMMENT '更新状态',
  `restart_times` varchar(200) DEFAULT '0' COMMENT '重启次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of productupdatediff
-- ----------------------------

-- ----------------------------
-- Table structure for service_boot_info
-- ----------------------------
DROP TABLE IF EXISTS `service_boot_info`;
CREATE TABLE `service_boot_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` varchar(200) DEFAULT NULL COMMENT '时间戳',
  `hostname` varchar(200) DEFAULT NULL COMMENT '主机名',
  `action` varchar(200) DEFAULT NULL COMMENT '执行操作',
  `app` varchar(200) DEFAULT NULL COMMENT '产品线',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of service_boot_info
-- ----------------------------

-- ----------------------------
-- Table structure for smshistory
-- ----------------------------
DROP TABLE IF EXISTS `smshistory`;
CREATE TABLE `smshistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `MSG_TIM` varchar(200) DEFAULT NULL COMMENT '时间戳',
  `UserName` varchar(200) DEFAULT NULL COMMENT '短信接收人',
  `USRMP` varchar(200) DEFAULT NULL COMMENT '手机号码',
  `SMSCONTENT` varchar(200) DEFAULT NULL COMMENT '短信内容',
  `RETURNMESSAGE` varchar(200) DEFAULT NULL COMMENT '返回信息',
  `ERRORCODE` varchar(200) DEFAULT NULL COMMENT '状态码',
  `RSPCOD` varchar(200) DEFAULT NULL COMMENT 'RSPCOD',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of smshistory
-- ----------------------------

-- ----------------------------
-- Table structure for smsusers
-- ----------------------------
DROP TABLE IF EXISTS `smsusers`;
CREATE TABLE `smsusers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(200) DEFAULT NULL COMMENT '用户名',
  `Mobile` varchar(200) DEFAULT NULL COMMENT '手机号码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of smsusers
-- ----------------------------
INSERT INTO `smsusers` VALUES ('1', 'liyu', '18665966895');

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(200) DEFAULT NULL COMMENT '公司名称',
  `staff_name` varchar(200) DEFAULT NULL COMMENT '联系人',
  `duties` varchar(200) DEFAULT NULL COMMENT '职务',
  `phone` varchar(200) DEFAULT NULL COMMENT '固话',
  `mobile` varchar(200) DEFAULT NULL COMMENT '手机',
  `qq` varchar(200) DEFAULT NULL COMMENT 'QQ',
  `email` varchar(200) DEFAULT NULL COMMENT 'EMAIL',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of supplier
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(200) DEFAULT NULL COMMENT '用户名',
  `real_name` varchar(200) DEFAULT NULL COMMENT '实名',
  `password` varchar(200) DEFAULT NULL COMMENT '密码',
  `mobile` varchar(200) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱地址',
  `role_id` varchar(200) DEFAULT NULL COMMENT '已授权模块',
  `status` varchar(200) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'warehouseadmin', '超级管理员', '$chiper$6eaec42d83b5db0e1524e7cca49e257217a13ec63fa85199bfd4f29495b1bfc3', '18665966895', 'yu.li@warehouse.com', '1', '0');
INSERT INTO `user` VALUES ('11', 'liyu', '李毓', '$chiper$6eaec42d83b5db0e1524e7cca49e257217a13ec63fa85199bfd4f29495b1bfc3', '18665966895', 'yu.li@warehouse.com', '25,26,27,31', '0');

