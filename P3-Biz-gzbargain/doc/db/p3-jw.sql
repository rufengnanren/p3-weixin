/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50037
Source Host           : localhost:3306
Source Database       : p3-jw

Target Server Type    : MYSQL
Target Server Version : 50037
File Encoding         : 65001

Date: 2015-10-10 19:01:59
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `gz_wx_act_bargain`
-- ----------------------------
DROP TABLE IF EXISTS `gz_wx_act_bargain`;
CREATE TABLE `gz_wx_act_bargain` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `act_name` varchar(100) NOT NULL COMMENT '砍价活动名称',
  `act_detail` varchar(500) default NULL COMMENT '活动详情',
  `act_rule` varchar(1000) default NULL COMMENT '活动规则',
  `act_content` text COMMENT '活动内容',
  `begain_time` datetime default NULL COMMENT '活动开始时间',
  `end_time` datetime NOT NULL COMMENT ' 活动结束时间',
  `product_num` int(11) NOT NULL COMMENT '产品数量',
  `product_unit` varchar(10) NOT NULL COMMENT '产品单位',
  `product_name` varchar(255) NOT NULL COMMENT '产品名称',
  `product_price` decimal(11,2) NOT NULL COMMENT '产品价格',
  `foucs_user_can_join` varchar(1) default NULL COMMENT '是否关注用户参与',
  `show_rate` int(11) NOT NULL COMMENT '展示比例',
  `create_time` datetime default NULL COMMENT '创建时间',
  `product_remain_num` int(11) NOT NULL COMMENT '产品剩余数量',
  `jwid` varchar(64) NOT NULL COMMENT '对应微信平台原始id',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='砍价活动表';

-- ----------------------------
-- Records of gz_wx_act_bargain
-- ----------------------------
INSERT INTO `gz_wx_act_bargain` VALUES ('actgzbargain00001', '浓情七夕 为爱发声', '<span>如此高端的活动只给铁杆粉：参与本活动的前需关注“贵州联通”服务号。</span> <span>我们拼的是手快和人气：最先砍价至0元宝的两位用户可以各获得千元的 电蟒CrazyBoa 2 Face 便携式蓝牙音箱一个。</span> <span>来，po几张我们大奖电蟒CrazyBoa 2 Face 便携式蓝牙音箱的美照</span>', '1,2', '', '2015-10-10 15:54:44', '2015-10-10 15:54:44', '2', '个', '蓝牙音箱', '1000.00', '1', '1', '2015-10-10 15:54:44', '2', 'gh_fd03cca3459e');

-- ----------------------------
-- Table structure for `gz_wx_act_bargain_awards`
-- ----------------------------
DROP TABLE IF EXISTS `gz_wx_act_bargain_awards`;
CREATE TABLE `gz_wx_act_bargain_awards` (
  `id` varchar(32) NOT NULL,
  `act_id` varchar(32) NOT NULL COMMENT '活动id',
  `awards_seq` int(11) NOT NULL COMMENT '奖品序号',
  `openid` varchar(100) NOT NULL COMMENT '兑奖人openid',
  `nickname` varchar(200) default NULL COMMENT '兑奖人昵称',
  `real_name` varchar(100) default NULL COMMENT '真实姓名',
  `mobile` varchar(50) default NULL COMMENT '手机号',
  `address` varchar(200) default NULL COMMENT '详细地址',
  `awards_code` varchar(64) NOT NULL COMMENT '兑奖码',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `jwid` varchar(64) NOT NULL COMMENT '对应微信平台原始id',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uniq_actid_awardsseq` USING BTREE (`act_id`,`awards_seq`),
  UNIQUE KEY `uniq_actid_openid` (`act_id`,`openid`),
  KEY `idx_openid` (`openid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='领取奖品记录表';

-- ----------------------------
-- Records of gz_wx_act_bargain_awards
-- ----------------------------

-- ----------------------------
-- Table structure for `gz_wx_act_bargain_record`
-- ----------------------------
DROP TABLE IF EXISTS `gz_wx_act_bargain_record`;
CREATE TABLE `gz_wx_act_bargain_record` (
  `id` varchar(32) NOT NULL COMMENT '记录id',
  `registration_id` varchar(32) NOT NULL COMMENT '报名id',
  `openid` varchar(100) NOT NULL COMMENT '砍价人openid',
  `nickname` varchar(200) NOT NULL COMMENT '砍价人昵称',
  `cut_price` decimal(11,2) NOT NULL COMMENT '砍掉价格',
  `curr_price` decimal(11,2) NOT NULL COMMENT '砍后价格',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `jwid` varchar(64) NOT NULL COMMENT '对应微信平台原始id',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uniq_registrationid_openid` USING BTREE (`registration_id`,`openid`),
  KEY `idx_registrationid` (`registration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='砍价帮砍记录表';

-- ----------------------------
-- Records of gz_wx_act_bargain_record
-- ----------------------------

-- ----------------------------
-- Table structure for `gz_wx_act_bargain_registration`
-- ----------------------------
DROP TABLE IF EXISTS `gz_wx_act_bargain_registration`;
CREATE TABLE `gz_wx_act_bargain_registration` (
  `id` varchar(32) NOT NULL,
  `act_id` varchar(32) NOT NULL COMMENT '活动id',
  `openid` varchar(100) NOT NULL COMMENT '活动所属人openid',
  `nickname` varchar(200) NOT NULL COMMENT '活动所属人昵称',
  `product_name` varchar(255) NOT NULL COMMENT '产品名称',
  `product_price` decimal(11,2) NOT NULL COMMENT '产品价格',
  `product_new_price` decimal(11,2) NOT NULL COMMENT '砍后价格',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime default NULL COMMENT '更新时间',
  `awards_status` varchar(2) default '0' COMMENT '领奖状态0:未领奖;1:已领奖',
  `jwid` varchar(64) NOT NULL COMMENT '对应微信平台原始id',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uniq_actid_openid` USING BTREE (`act_id`,`openid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='砍价报名表';

-- ----------------------------
-- Records of gz_wx_act_bargain_registration
-- ----------------------------
INSERT INTO `gz_wx_act_bargain_registration` VALUES ('C2610EE5A2C24471A9CC356957932CEF', 'actgzbargain00001', 'oR0jFt_DTsAUJebWqG99WfRw', '匿名', '蓝牙音箱', '1000.00', '1000.00', '2015-10-10 17:03:34', null, null, 'jwid0000001');
INSERT INTO `gz_wx_act_bargain_registration` VALUES ('E881EBE9F89B44C5B55CA9945A2B8F73', 'actgzbargain00001', 'oR0jFt_DTsAUJebWqGeq3A1VWfRw', 'JEFF', '蓝牙音箱', '1000.00', '1000.00', '2015-10-10 16:04:05', null, null, '1');
