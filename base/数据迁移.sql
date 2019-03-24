SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS DS_BASE_UNIT;
CREATE TABLE DS_BASE_UNIT (
  ID bigint(18) NOT NULL COMMENT 'ID',
  STATUS int(1) COMMENT '状态(1启用,0禁用)',
  NAME varchar(512) COMMENT '应用名称',
  APPID varchar(256) COMMENT '应用ID',
  APPSECRET varchar(256) COMMENT '应用秘钥',
  RETURNURL varchar(1024) COMMENT '回调地址',
  TYPE int(1) COMMENT '类型(0非第三方,1第三方)',
  CREATETIME varchar(19) COMMENT '创建时间',
  LASTTIME bigint(18) COMMENT '最后更新时间',
  MEMO varchar(1024) COMMENT '备注说明',
  PRIMARY KEY (ID)
) COMMENT='授权应用的配置信息';

DROP TABLE IF EXISTS DS_BASE_BIND;
CREATE TABLE DS_BASE_BIND (
  ID bigint(18) NOT NULL COMMENT '应用ID',
  NAME varchar(30) COMMENT '应用名称',
  STATUS int(1) COMMENT '状态(1启用,0禁用)',
  APPID varchar(64) COMMENT '第三方应用ID',
  APPSECRET varchar(128) COMMENT '第三方应用密钥',
  APPKEYPRIVATE varchar(2048) COMMENT '第三方应用私钥',
  APPKEYPUBLIC varchar(2048) COMMENT '第三方应用公钥',
  APPRETURNURL varchar(256) COMMENT '第三方应用回调地址',
  APPTYPE varchar(32) COMMENT '第三方应用类型',
  MEMO varchar(30) COMMENT '备注',
  CREATETIME varchar(19) COMMENT '创建时间',
  LASTTIME bigint(18) COMMENT '最后更新时间',
  PRIMARY KEY (ID)
) COMMENT='第三方应用配置信息';

DROP TABLE IF EXISTS DS_BASE_LOGIN;
CREATE TABLE DS_BASE_LOGIN
(
   ID                   BIGINT NOT NULL COMMENT '主键',
   LOGINTIME            VARCHAR(19) COMMENT '登录时间',
   LOGOUTTIME           VARCHAR(19) COMMENT '登出时间',
   TIMEOUTTIME          VARCHAR(19) COMMENT '超时时间',
   PWDTIME              VARCHAR(19) COMMENT '密码修改时间,没修改则为空,修改成功后直接登出',
   TICKET               VARCHAR(128) COMMENT '登录标识',
   IP                   VARCHAR(128) COMMENT 'IP地址',
   ACCOUNT              VARCHAR(64) COMMENT '操作人账号',
   NAME                 VARCHAR(30) COMMENT '操作人名称',
   STATUS               INT COMMENT '状态(0失败,1成功)',
   PRIMARY KEY (ID)
) COMMENT '系统登录日志';

DROP TABLE IF EXISTS DS_BASE_USERTYPE;
CREATE TABLE DS_BASE_USERTYPE
(
   ID                   BIGINT NOT NULL COMMENT '主键',
   NAME                 VARCHAR(300) COMMENT '名称',
   ALIAS                VARCHAR(300) COMMENT '标识',
   STATUS               INT(1) COMMENT '状态(1)',
   SEQ                  BIGINT(18) COMMENT '排序',
   MEMO                 VARCHAR(1000) COMMENT '扩展信息',
   RESOURCES            VARCHAR(4000) COMMENT '资源集合',
   PRIMARY KEY (ID)
) COMMENT '用户类型';

DROP TABLE IF EXISTS DS_BASE_USER;
CREATE TABLE DS_BASE_USER (
  ID bigint(18) NOT NULL COMMENT '主键',
  BINDID bigint(18) COMMENT '所属来源应用ID',
  STATUS int(1) COMMENT '状态(1启用,0禁用)',
  OPENID varchar(255) COMMENT 'OPENID',
  UNIONID varchar(300) COMMENT 'UNIONID',
  BM varchar(128) COMMENT '唯一标识(可为id或身份证等信息)',
  SSQY varchar(12) COMMENT '最长12位的区域编码',
  NAME varchar(30) COMMENT '姓名',
  MOBILE varchar(30) COMMENT '手机',
  ACCOUNT varchar(64) COMMENT '自定义账号',
  PASSWORD varchar(64) COMMENT '密码',
  WORKCARD varchar(64) COMMENT '工作证号',
  SEX int(1) COMMENT '性别(0未知,1男,2女)',
  COUNTRY varchar(60) COMMENT '国家',
  PROVINCE varchar(60) COMMENT '省份',
  CITY varchar(60) COMMENT '城市',
  AVATAR varchar(300) COMMENT '头像',
  IDCARD varchar(18) COMMENT '身份证号',
  EMAIL varchar(300) COMMENT '电子邮件',
  PHONE varchar(30) COMMENT '电话',
  ORGPID bigint(20) COMMENT '单位ID',
  ORGID bigint(20) COMMENT '部门ID',
  TYPE varchar(300) COMMENT '类型',
  TYPENAME varchar(300) COMMENT '类型名称',
  EXALIAS varchar(300) COMMENT '类型扩展标识',
  EXNAME varchar(300) COMMENT '类型扩展名称',
  CREATETIME varchar(19) COMMENT '创建时间',
  LASTTIME bigint(18) COMMENT '最后更新时间',
  CAKEY varchar(32) COMMENT 'CA证书的KEY',
  PRIMARY KEY (ID)
) COMMENT='系统用户';

DROP TABLE IF EXISTS DS_BASE_SYSTEM;
CREATE TABLE DS_BASE_SYSTEM
(
   ID                   BIGINT(18) NOT NULL COMMENT '主键',
   NAME                 VARCHAR(300) COMMENT '名称',
   ALIAS                VARCHAR(128) COMMENT '系统别名',
   PASSWORD             VARCHAR(64) COMMENT '访问密码',
   DOMAINURL            VARCHAR(300) COMMENT '网络地址和端口',
   ROOTURL              VARCHAR(300) COMMENT '应用根路径',
   MENUURL              VARCHAR(300) COMMENT '菜单地址',
   STATUS               INT(1) COMMENT '状态(1启用,0禁用)',
   SEQ                  BIGINT(18) COMMENT '排序',
   MEMO                 VARCHAR(300) COMMENT '备注',
   PRIMARY KEY (ID)
) COMMENT '应用系统';

DROP TABLE IF EXISTS DS_BASE_FUNC;
CREATE TABLE DS_BASE_FUNC
(
   ID                   BIGINT(18) NOT NULL COMMENT '主键',
   PID                  BIGINT(18) COMMENT '上级ID(本表)',
   SYSTEMID             BIGINT(18) COMMENT '所属系统ID',
   NAME                 VARCHAR(300) COMMENT '名称',
   ALIAS                VARCHAR(300) COMMENT '标识',
   URI                  VARCHAR(300) COMMENT '对应的URI',
   IMG                  VARCHAR(100) COMMENT '显示图标',
   STATUS               INT(1) COMMENT '状态(0不是菜单,1菜单,不是菜单不能添加下级)',
   SEQ                  BIGINT(18) COMMENT '排序',
   MEMO                 VARCHAR(3000) COMMENT '扩展信息',
   RESOURCES            VARCHAR(4000) COMMENT '资源集合',
   PRIMARY KEY (ID),
   CONSTRAINT FK_DS_BASE_FUNC_SYSTEM FOREIGN KEY (SYSTEMID)
      REFERENCES DS_BASE_SYSTEM (ID) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT FK_DS_BASE_FUNC FOREIGN KEY (PID)
      REFERENCES DS_BASE_FUNC (ID) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT '功能';

DROP TABLE IF EXISTS DS_BASE_ROLE;
CREATE TABLE DS_BASE_ROLE
(
   ID                   BIGINT(18) NOT NULL COMMENT '主键',
   PID                  BIGINT(18) COMMENT '上级ID(本表)',
   SYSTEMID             BIGINT(18) NOT NULL COMMENT '所属系统ID',
   NAME                 VARCHAR(300) COMMENT '名称',
   SEQ                  BIGINT(18) COMMENT '排序',
   MEMO                 VARCHAR(300) COMMENT '备注',
   PRIMARY KEY (ID),
   CONSTRAINT FK_DS_BASE_ROLE_SYSTEM FOREIGN KEY (SYSTEMID)
      REFERENCES DS_BASE_SYSTEM (ID) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT FK_DS_BASE_ROLE FOREIGN KEY (PID)
      REFERENCES DS_BASE_ROLE (ID) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT '角色';

DROP TABLE IF EXISTS DS_BASE_ROLEFUNC;
CREATE TABLE DS_BASE_ROLEFUNC
(
   ID                   BIGINT(18) NOT NULL COMMENT '主键ID',
   SYSTEMID             BIGINT(18) COMMENT '系统ID',
   ROLEID               BIGINT(18) COMMENT '角色ID',
   FUNCID               BIGINT(18) COMMENT '功能ID',
   PRIMARY KEY (ID),
   CONSTRAINT FK_DS_BASE_ROLEFUNC_SYSTEM FOREIGN KEY (SYSTEMID)
      REFERENCES DS_BASE_SYSTEM (ID) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT FK_DS_BASE_ROLEFUNC_FUNC FOREIGN KEY (FUNCID)
      REFERENCES DS_BASE_FUNC (ID) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT FK_DS_BASE_ROLEFUNC_ROLE FOREIGN KEY (ROLEID)
      REFERENCES DS_BASE_ROLE (ID) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT '角色功能关系';

DROP TABLE IF EXISTS DS_BASE_ORG;
CREATE TABLE DS_BASE_ORG
(
   ID                   BIGINT(18) NOT NULL COMMENT '部门ID',
   PID                  BIGINT(18) COMMENT '上级ID(本表)',
   NAME                 VARCHAR(300) COMMENT '名称',
   STATUS               INT(1) COMMENT '类型(2单位,1部门,0岗位)',
   SEQ                  BIGINT(18) COMMENT '排序',
   DUTYSCOPE            VARCHAR(3000) COMMENT '职责范围',
   MEMO                 VARCHAR(3000) COMMENT '备注',
   PRIMARY KEY (ID),
   CONSTRAINT FK_DS_BASE_ORG FOREIGN KEY (PID)
      REFERENCES DS_BASE_ORG (ID) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT '组织机构';

DROP TABLE IF EXISTS DS_BASE_ORGROLE;
CREATE TABLE DS_BASE_ORGROLE
(
   ID                   BIGINT(18) NOT NULL COMMENT '主键ID',
   ORGID                BIGINT(18) NOT NULL COMMENT '岗位ID',
   ROLEID               BIGINT(18) COMMENT '角色ID',
   PRIMARY KEY (ID),
   CONSTRAINT FK_DS_BASE_ORGROLE_ORG FOREIGN KEY (ORGID)
      REFERENCES DS_BASE_ORG (ID) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT FK_DS_BASE_ORGROLE_ROLE FOREIGN KEY (ROLEID)
      REFERENCES DS_BASE_ROLE (ID) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT '岗位角色关系';

DROP TABLE IF EXISTS DS_BASE_USERORG;
CREATE TABLE DS_BASE_USERORG
(
   ID                   BIGINT(18) NOT NULL COMMENT '主键ID',
   ORGID                BIGINT(18) NOT NULL COMMENT '岗位ID',
   USERID               BIGINT(18) COMMENT '用户ID',
   PRIMARY KEY (ID),
   CONSTRAINT FK_DS_BASE_USERORG_ORG FOREIGN KEY (ORGID)
      REFERENCES DS_BASE_ORG (ID) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT FK_DS_BASE_USERORG_USER FOREIGN KEY (USERID)
      REFERENCES DS_BASE_USER (ID) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT '用户岗位关系';

DROP TABLE IF EXISTS DS_BASE_DICT;
CREATE TABLE DS_BASE_DICT  (
  ID bigint(18) NOT NULL COMMENT '主键',
  NAME varchar(300) COMMENT '引用名',
  LABEL varchar(300) COMMENT '名称',
  LEVEL int(1) COMMENT '层级(0任意树形,1列表,n=>n级属性)',
  RULE varchar(300) COMMENT '编码规则(level==n时可选)',
  SEQ bigint(18) COMMENT '排序',
  UPDATETIME bigint(18) COMMENT '最后更新时间',
  PRIMARY KEY (ID)
) COMMENT = '字典分类';

DROP TABLE IF EXISTS DS_BASE_DICT_DATA;
CREATE TABLE DS_BASE_DICT_DATA  (
  ID varchar(18) NOT NULL COMMENT '主键',
  PID varchar(18) COMMENT '上级ID(本表,所属字典项)',
  NAME varchar(180) NOT NULL COMMENT '引用名',
  LABEL varchar(300) COMMENT '名称',
  MARK varchar(128) COMMENT '标记',
  LEVEL int(10) COMMENT '层级',
  STATUS int(1) COMMENT '状态(1树叉,0树叶)',
  SEQ bigint(18) COMMENT '排序',
  MEMO varchar(300) COMMENT '备注',
  PRIMARY KEY (ID, NAME)
) COMMENT = '字典项';

INSERT INTO DS_BASE_LOGIN (
       ID,LOGINTIME,LOGOUTTIME,TIMEOUTTIME,PWDTIME,TICKET,IP,ACCOUNT,NAME,STATUS)
SELECT ID,LOGINTIME,LOGOUTTIME,TIMEOUTTIME,PWDTIME,TICKET,IP,ACCOUNT,NAME,STATUS from DS_COMMON_LOGIN;

INSERT INTO DS_BASE_USERTYPE (
       ID,NAME,ALIAS,STATUS,SEQ,MEMO,RESOURCES)
SELECT ID,NAME,ALIAS,STATUS,SEQ,MEMO,RESOURCES from DS_COMMON_USERTYPE;

INSERT INTO DS_BASE_USER (
       ID,STATUS,OPENID,UNIONID,BM,SSQY,NAME,MOBILE,ACCOUNT,PASSWORD,WORKCARD,SEX,COUNTRY,PROVINCE,CITY,AVATAR,IDCARD,EMAIL,PHONE,ORGPID,ORGID,TYPE,TYPENAME,EXALIAS,EXNAME,CREATETIME,LASTTIME)
SELECT ID,STATUS,'',    '',     '',''  ,NAME,MOBILE,ACCOUNT,PASSWORD,WORKCARD,SEX,'',     '',      '',  '',    IDCARD,EMAIL,PHONE,ORGPID,ORGID,TYPE,TYPENAME,EXALIAS,EXNAME,CREATETIME,0,       from DS_COMMON_USER;

INSERT INTO DS_BASE_SYSTEM (
       ID,NAME,ALIAS,PASSWORD,DOMAINURL,ROOTURL,MENUURL,STATUS,SEQ,MEMO)
SELECT ID,NAME,ALIAS,PASSWORD,DOMAINURL,ROOTURL,MENUURL,STATUS,SEQ,MEMO from DS_COMMON_SYSTEM;

update DS_BASE_SYSTEM set ALIAS='base', ROOTURL=replace(ROOTURL,'DsCommon','base'), MENUURL=replace(MENUURL,'DsCommon','base') where ALIAS='DsCommon';
update DS_BASE_SYSTEM set MENUURL=concat(ROOTURL, '/sso/menu') where length(ROOTURL) > 0 and length(MENUURL) > 0;

INSERT INTO DS_BASE_FUNC (
       ID,PID,SYSTEMID,NAME,ALIAS,        URI,                           IMG,STATUS,SEQ,MEMO,RESOURCES)
SELECT ID,PID,SYSTEMID,NAME,ALIAS,replace(URI,'/ds/common/','/ds/base/'),IMG,STATUS,SEQ,MEMO,replace(RESOURCES,'/ds/common/','/ds/base/') from DS_COMMON_FUNC;
update DS_BASE_FUNC set URI=replace(URI,'getCommonLogin.jsp','getBaseLogin.jsp') where URI like '%/ds/base/log/getCommonLogin.jsp';

INSERT INTO DS_BASE_ROLE (
       ID,PID,SYSTEMID,NAME,SEQ,MEMO)
SELECT ID,PID,SYSTEMID,NAME,SEQ,MEMO from DS_COMMON_ROLE;

INSERT INTO DS_BASE_ROLEFUNC (
       ID,SYSTEMID,ROLEID,FUNCID)
SELECT ID,SYSTEMID,ROLEID,FUNCID from DS_COMMON_ROLEFUNC;

INSERT INTO DS_BASE_ORG (
       ID,PID,NAME,STATUS,SEQ,DUTYSCOPE,MEMO)
SELECT ID,PID,NAME,STATUS,SEQ,DUTYSCOPE,MEMO from DS_COMMON_ORG;

INSERT INTO DS_BASE_ORGROLE (
       ID,PID,NAME,STATUS,SEQ,DUTYSCOPE,MEMO)
SELECT ID,PID,NAME,STATUS,SEQ,DUTYSCOPE,MEMO from DS_COMMON_ORGROLE;

INSERT INTO DS_BASE_USERORG (
       ID,ORGID,USERID)
SELECT ID,ORGID,USERID from DS_COMMON_USERORG;

INSERT INTO DS_BASE_DICT (
       ID,NAME,LABEL,LEVEL,SEQ,UPDATETIME)
SELECT ID,NAME,LABEL,    0,SEQ,1 from DS_COMMON_DICT where STATUS=1;

INSERT INTO DS_BASE_DICT (
       ID,NAME,LABEL,LEVEL,SEQ,UPDATETIME)
SELECT ID,NAME,LABEL,    1,SEQ,1 from DS_COMMON_DICT where STATUS=0;

INSERT INTO DS_BASE_DICT_DATA (
       ID,     PID,      NAME,  LABEL,  STATUS,  SEQ,  MEMO, LEVEL)
SELECT a.ALIAS,b.ALIAS,a.NAME,a.LABEL,a.STATUS,a.SEQ,a.MEMO, 0 from DS_COMMON_DICT_DATA a LEFT JOIN DS_COMMON_DICT_DATA b ON b.ID=a.PID;

update DS_BASE_DICT_DATA set LEVEL=1 where NAME in (select NAME from DS_BASE_DICT where LEVEL=1);


