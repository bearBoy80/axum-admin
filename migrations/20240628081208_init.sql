-- Add migration script here
DROP TABLE IF EXISTS sys_dept;
CREATE TABLE sys_dept (
  dept_id BIGSERIAL PRIMARY KEY,
  pid BIGINT,
  sub_count INT DEFAULT 0,
  name VARCHAR(255) NOT NULL,
  dept_sort INT DEFAULT 999,
  enabled BOOLEAN NOT NULL,
  create_by VARCHAR(255),
  update_by VARCHAR(255),
  create_time TIMESTAMP,
  update_time TIMESTAMP
);

COMMENT ON COLUMN sys_dept.pid IS '上级部门';
COMMENT ON COLUMN sys_dept.sub_count IS '子部门数目';
COMMENT ON COLUMN sys_dept.name IS '名称';
COMMENT ON COLUMN sys_dept.dept_sort IS '排序';
COMMENT ON COLUMN sys_dept.enabled IS '状态';
COMMENT ON COLUMN sys_dept.create_by IS '创建者';
COMMENT ON COLUMN sys_dept.update_by IS '更新者';
COMMENT ON COLUMN sys_dept.create_time IS '创建日期';
COMMENT ON COLUMN sys_dept.update_time IS '更新时间';

CREATE INDEX idx_sys_dept_pid ON sys_dept (pid);
CREATE INDEX idx_sys_dept_enabled ON sys_dept (enabled);

BEGIN;
INSERT INTO sys_dept (pid, sub_count, name, dept_sort, enabled, create_by, update_by, create_time, update_time)
VALUES (7, 1, '研发部', 3, TRUE, 'admin', 'admin', '2019-03-25 09:15:32', '2020-08-02 14:48:47');
INSERT INTO sys_dept (pid, sub_count, name, dept_sort, enabled, create_by, update_by, create_time, update_time)
VALUES (7, 0, '运维部', 4, TRUE, 'admin', 'admin', '2019-03-25 09:20:44', '2020-05-17 14:27:27');
INSERT INTO sys_dept (pid, sub_count, name, dept_sort, enabled, create_by, update_by, create_time, update_time)
VALUES (8, 0, '测试部', 6, TRUE, 'admin', 'admin', '2019-03-25 09:52:18', '2020-06-08 11:59:21');
INSERT INTO sys_dept (pid, sub_count, name, dept_sort, enabled, create_by, update_by, create_time, update_time)
VALUES (NULL, 2, '华南分部', 0, TRUE, 'admin', 'admin', '2019-03-25 11:04:50', '2020-06-08 12:08:56');
INSERT INTO sys_dept (pid, sub_count, name, dept_sort, enabled, create_by, update_by, create_time, update_time)
VALUES (NULL, 2, '华北分部', 1, TRUE, 'admin', 'admin', '2019-03-25 11:04:53', '2020-05-14 12:54:00');
INSERT INTO sys_dept (pid, sub_count, name, dept_sort, enabled, create_by, update_by, create_time, update_time)
VALUES (8, 0, 'UI部门', 7, TRUE, 'admin', 'admin', '2020-05-13 22:56:53', '2020-05-14 12:54:13');
INSERT INTO sys_dept (pid, sub_count, name, dept_sort, enabled, create_by, update_by, create_time, update_time)
VALUES (2, 0, '研发一组', 999, TRUE, 'admin', 'admin', '2020-08-02 14:49:07', '2020-08-02 14:49:07');
COMMIT;
DROP TABLE IF EXISTS sys_dict;
CREATE TABLE sys_dict (
  dict_id BIGSERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(255),
  create_by VARCHAR(255),
  update_by VARCHAR(255),
  create_time TIMESTAMP,
  update_time TIMESTAMP
);

COMMENT ON COLUMN sys_dict.name IS '字典名称';
COMMENT ON COLUMN sys_dict.description IS '描述';
COMMENT ON COLUMN sys_dict.create_by IS '创建者';
COMMENT ON COLUMN sys_dict.update_by IS '更新者';
COMMENT ON COLUMN sys_dict.create_time IS '创建日期';
COMMENT ON COLUMN sys_dict.update_time IS '更新时间';

BEGIN;
INSERT INTO sys_dict (name, description, create_time)
VALUES ('user_status', '用户状态', '2019-10-27 20:31:36');
INSERT INTO sys_dict (name, description, create_time)
VALUES ('dept_status', '部门状态', '2019-10-27 20:31:36');
INSERT INTO sys_dict (name, description, create_time)
VALUES ('job_status', '岗位状态', '2019-10-27 20:31:36');
COMMIT;

DROP TABLE IF EXISTS sys_dict_detail;
CREATE TABLE sys_dict_detail (
  detail_id BIGSERIAL PRIMARY KEY,
  dict_id BIGINT,
  label VARCHAR(255) NOT NULL,
  value VARCHAR(255) NOT NULL,
  dict_sort INT,
  create_by VARCHAR(255),
  update_by VARCHAR(255),
  create_time TIMESTAMP,
  update_time TIMESTAMP
);
COMMENT ON COLUMN sys_dict_detail.dict_id IS '字典id';
COMMENT ON COLUMN sys_dict_detail.label IS '字典标签';
COMMENT ON COLUMN sys_dict_detail.value IS '字典值';
COMMENT ON COLUMN sys_dict_detail.dict_sort IS '排序';
COMMENT ON COLUMN sys_dict_detail.create_by IS '创建者';
COMMENT ON COLUMN sys_dict_detail.update_by IS '更新者';
COMMENT ON COLUMN sys_dict_detail.create_time IS '创建日期';
COMMENT ON COLUMN sys_dict_detail.update_time IS '更新时间';

BEGIN;
INSERT INTO sys_dict_detail (dict_id, label, value, dict_sort, create_time)
VALUES (1, '激活', 'true', 1, '2019-10-27 20:31:36');
INSERT INTO sys_dict_detail (dict_id, label, value, dict_sort)
VALUES (1, '禁用', 'false', 2);
INSERT INTO sys_dict_detail (dict_id, label, value, dict_sort)
VALUES (4, '启用', 'true', 1);
INSERT INTO sys_dict_detail (dict_id, label, value, dict_sort, create_time)
VALUES (4, '停用', 'false', 2, '2019-10-27 20:31:36');
INSERT INTO sys_dict_detail (dict_id, label, value, dict_sort)
VALUES (5, '启用', 'true', 1);
INSERT INTO sys_dict_detail (dict_id, label, value, dict_sort, create_time)
VALUES (5, '停用', 'false', 2, '2019-10-27 20:31:36');
COMMIT;

DROP TABLE IF EXISTS sys_menu;
CREATE TABLE sys_menu (
  menu_id BIGSERIAL PRIMARY KEY,
  pid BIGINT,
  sub_count INT DEFAULT 0,
  type INT,
  title VARCHAR(100),
  name VARCHAR(100),
  component VARCHAR(255),
  menu_sort INT,
  icon VARCHAR(255),
  path VARCHAR(255),
  i_frame BOOLEAN,
  cache BOOLEAN DEFAULT FALSE,
  hidden BOOLEAN DEFAULT FALSE,
  permission VARCHAR(255),
  create_by VARCHAR(255),
  update_by VARCHAR(255),
  create_time TIMESTAMP,
  update_time TIMESTAMP
);

COMMENT ON COLUMN sys_menu.pid IS '上级菜单ID';
COMMENT ON COLUMN sys_menu.sub_count IS '子菜单数目';
COMMENT ON COLUMN sys_menu.type IS '菜单类型';
COMMENT ON COLUMN sys_menu.title IS '菜单标题';
COMMENT ON COLUMN sys_menu.name IS '组件名称';
COMMENT ON COLUMN sys_menu.component IS '组件';
COMMENT ON COLUMN sys_menu.menu_sort IS '排序';
COMMENT ON COLUMN sys_menu.icon IS '图标';
COMMENT ON COLUMN sys_menu.path IS '链接地址';
COMMENT ON COLUMN sys_menu.i_frame IS '是否外链';
COMMENT ON COLUMN sys_menu.cache IS '缓存';
COMMENT ON COLUMN sys_menu.hidden IS '隐藏';
COMMENT ON COLUMN sys_menu.permission IS '权限';
COMMENT ON COLUMN sys_menu.create_by IS '创建者';
COMMENT ON COLUMN sys_menu.update_by IS '更新者';
COMMENT ON COLUMN sys_menu.create_time IS '创建日期';
COMMENT ON COLUMN sys_menu.update_time IS '更新时间';

CREATE UNIQUE INDEX uniq_sys_menu_title ON sys_menu (title);
CREATE UNIQUE INDEX uniq_sys_menu_name ON sys_menu (name);
CREATE INDEX idx_sys_menu_pid ON sys_menu (pid);

BEGIN;
INSERT INTO sys_menu (pid, sub_count, type, title, name, component, menu_sort, icon, path, i_frame, create_time)
VALUES (NULL, 7, 0, '系统管理', NULL, NULL, 1, 'system', 'system', FALSE, '2018-12-18 15:11:29');
INSERT INTO sys_menu (pid, sub_count, type, title, name, component, menu_sort, icon, path, i_frame, permission, create_time)
VALUES (1, 3, 1, '用户管理', 'User', 'system/user/index', 2, 'peoples', 'user', FALSE, 'user:list', '2018-12-18 15:14:44');
INSERT INTO sys_menu (pid, sub_count, type, title, name, component, menu_sort, icon, path, i_frame, permission, create_time)
VALUES (1, 3, 1, '角色管理', 'Role', 'system/role/index', 3, 'role', 'role', FALSE, 'roles:list', '2018-12-18 15:16:07');
INSERT INTO sys_menu (pid, sub_count, type, title, name, component, menu_sort, icon, path, i_frame, permission, create_time)
VALUES (1, 3, 1, '菜单管理', 'Menu', 'system/menu/index', 5, 'menu', 'menu', FALSE, 'menu:list', '2018-12-18 15:17:28');
COMMIT;

DROP TABLE IF EXISTS sys_role;
CREATE TABLE sys_role (
  role_id BIGSERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  level INT,
  description VARCHAR(255),
  data_scope VARCHAR(255),
  create_by VARCHAR(255),
  update_by VARCHAR(255),
  create_time TIMESTAMP,
  update_time TIMESTAMP
);

COMMENT ON TABLE sys_role IS '角色表';
COMMENT ON COLUMN sys_role.role_id IS 'ID';
COMMENT ON COLUMN sys_role.name IS '名称';
COMMENT ON COLUMN sys_role.level IS '角色级别';
COMMENT ON COLUMN sys_role.description IS '描述';
COMMENT ON COLUMN sys_role.data_scope IS '数据权限';
COMMENT ON COLUMN sys_role.create_by IS '创建者';
COMMENT ON COLUMN sys_role.update_by IS '更新者';
COMMENT ON COLUMN sys_role.create_time IS '创建日期';
COMMENT ON COLUMN sys_role.update_time IS '更新时间';

CREATE UNIQUE INDEX uniq_name ON sys_role (name);
CREATE INDEX role_name_index ON sys_role (name);

BEGIN;
INSERT INTO sys_role (name, level, description, data_scope, update_by, create_time, update_time)
VALUES ('超级管理员', 1, '-', '全部', 'admin', '2018-11-23 11:04:37', '2020-08-06 16:10:24');
INSERT INTO sys_role (name, level, description, data_scope, update_by, create_time, update_time)
VALUES ('普通用户', 2, '-', '本级', 'admin', '2018-11-23 13:09:06', '2020-09-05 10:45:12');
COMMIT;

DROP TABLE IF EXISTS sys_roles_depts;
CREATE TABLE sys_roles_depts (
  role_id BIGINT NOT NULL,
  dept_id BIGINT NOT NULL,
  PRIMARY KEY (role_id, dept_id)
);

COMMENT ON TABLE sys_roles_depts IS '角色部门关联';

DROP TABLE IF EXISTS sys_roles_menus;
CREATE TABLE sys_roles_menus (
  menu_id BIGINT NOT NULL,
  role_id BIGINT NOT NULL,
  PRIMARY KEY (menu_id, role_id)
);

COMMENT ON TABLE sys_roles_menus IS '角色菜单关联';
COMMENT ON COLUMN sys_roles_menus.menu_id IS '菜单ID';
COMMENT ON COLUMN sys_roles_menus.role_id IS '角色ID';

BEGIN;
INSERT INTO sys_roles_menus (menu_id, role_id) VALUES (1, 1);
INSERT INTO sys_roles_menus (menu_id, role_id) VALUES (2, 1);
INSERT INTO sys_roles_menus (menu_id, role_id) VALUES (3, 1);
INSERT INTO sys_roles_menus (menu_id, role_id) VALUES (5, 1);
INSERT INTO sys_roles_menus (menu_id, role_id) VALUES (6, 1);
INSERT INTO sys_roles_menus (menu_id, role_id) VALUES (7, 1);
COMMIT;

DROP TABLE IF EXISTS sys_user;
CREATE TABLE sys_user (
  user_id BIGSERIAL PRIMARY KEY,
  dept_id BIGINT,
  username VARCHAR(180),
  nick_name VARCHAR(255),
  gender VARCHAR(2),
  phone VARCHAR(255),
  email VARCHAR(180),
  avatar_name VARCHAR(255),
  avatar_path VARCHAR(255),
  password VARCHAR(255),
  is_admin BOOLEAN DEFAULT FALSE,
  enabled BOOLEAN,
  create_by VARCHAR(255),
  update_by VARCHAR(255),
  pwd_reset_time TIMESTAMP,
  create_time TIMESTAMP,
  update_time TIMESTAMP
);

COMMENT ON TABLE sys_user IS '系统用户';
COMMENT ON COLUMN sys_user.user_id IS 'ID';
COMMENT ON COLUMN sys_user.dept_id IS '部门名称';
COMMENT ON COLUMN sys_user.username IS '用户名';
COMMENT ON COLUMN sys_user.nick_name IS '昵称';
COMMENT ON COLUMN sys_user.gender IS '性别';
COMMENT ON COLUMN sys_user.phone IS '手机号码';
COMMENT ON COLUMN sys_user.email IS '邮箱';
COMMENT ON COLUMN sys_user.avatar_name IS '头像地址';
COMMENT ON COLUMN sys_user.avatar_path IS '头像真实路径';
COMMENT ON COLUMN sys_user.password IS '密码';
COMMENT ON COLUMN sys_user.is_admin IS '是否为admin账号';
COMMENT ON COLUMN sys_user.enabled IS '状态：1启用、0禁用';
COMMENT ON COLUMN sys_user.create_by IS '创建者';
COMMENT ON COLUMN sys_user.update_by IS '更新者';
COMMENT ON COLUMN sys_user.pwd_reset_time IS '修改密码的时间';
COMMENT ON COLUMN sys_user.create_time IS '创建日期';
COMMENT ON COLUMN sys_user.update_time IS '更新时间';

CREATE UNIQUE INDEX uniq_username ON sys_user (username);
CREATE UNIQUE INDEX uniq_email ON sys_user (email);
CREATE INDEX FK5rwmryny6jthaaxkogownknqp ON sys_user (dept_id);
CREATE INDEX inx_enabled ON sys_user (enabled);

--add casbin_rule
CREATE TABLE IF NOT EXISTS casbin_rule (
    id SERIAL PRIMARY KEY,
    ptype VARCHAR NOT NULL,
    v0 VARCHAR NOT NULL,
    v1 VARCHAR NOT NULL,
    v2 VARCHAR NOT NULL,
    v3 VARCHAR NOT NULL,
    v4 VARCHAR NOT NULL,
    v5 VARCHAR NOT NULL,
    CONSTRAINT unique_key_sqlx_adapter UNIQUE(ptype, v0, v1, v2, v3, v4, v5)
);
