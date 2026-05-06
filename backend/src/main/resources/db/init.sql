CREATE DATABASE IF NOT EXISTS money
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE money;

SET NAMES utf8mb4;

SET FOREIGN_KEY_CHECKS = 0;

DROP PROCEDURE IF EXISTS SetDefaultPassword;
DROP PROCEDURE IF EXISTS UpdateCheckingIn;
DROP PROCEDURE IF EXISTS UpdateEmployeeInfo;
DROP PROCEDURE IF EXISTS CalculateYearlyBonus;
DROP PROCEDURE IF EXISTS GetCheckingInfoById;
DROP PROCEDURE IF EXISTS GetEmployeeInfoById;
DROP PROCEDURE IF EXISTS getRecordsBetweenDatesById;
DROP PROCEDURE IF EXISTS getRecordsBetweenDates;

DROP TABLE IF EXISTS salary_record;
DROP TABLE IF EXISTS salary;
DROP TABLE IF EXISTS checking_in;
DROP TABLE IF EXISTS checking;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE department (
  id INT PRIMARY KEY AUTO_INCREMENT,
  Dname VARCHAR(50) NOT NULL
);

CREATE TABLE employee (
  id VARCHAR(4) PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  sex VARCHAR(10) NOT NULL,
  phone VARCHAR(30),
  email VARCHAR(100),
  grade VARCHAR(30),
  hiredate DATE,
  power VARCHAR(1) NOT NULL DEFAULT '1',
  password VARCHAR(100) NOT NULL DEFAULT '123456',
  department_id INT,
  CONSTRAINT fk_employee_department
    FOREIGN KEY (department_id) REFERENCES department(id)
);

CREATE TABLE checking_in (
  employee_id VARCHAR(4) NOT NULL,
  month DATE NOT NULL,
  over_hours DECIMAL(10,2) NOT NULL DEFAULT 0,
  weekend_overtime DECIMAL(10,2) NOT NULL DEFAULT 0,
  holiday_overtime DECIMAL(10,2) NOT NULL DEFAULT 0,
  leave_day DECIMAL(10,2) NOT NULL DEFAULT 0,
  late_day DECIMAL(10,2) NOT NULL DEFAULT 0,
  early_leave DECIMAL(10,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (employee_id, month),
  CONSTRAINT fk_checking_employee
    FOREIGN KEY (employee_id) REFERENCES employee(id)
);

CREATE TABLE salary_record (
  employee_id VARCHAR(4) NOT NULL,
  month DATE NOT NULL,
  wage DECIMAL(10,2) NOT NULL DEFAULT 0,
  subsidy DECIMAL(10,2) NOT NULL DEFAULT 0,
  bonus DECIMAL(10,2) NOT NULL DEFAULT 0,
  from_checking_in DECIMAL(10,2) NOT NULL DEFAULT 0,
  deductMoney DECIMAL(10,2) NOT NULL DEFAULT 0,
  before_tax DECIMAL(10,2) NOT NULL DEFAULT 0,
  tax DECIMAL(10,2) NOT NULL DEFAULT 0,
  total DECIMAL(10,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (employee_id, month),
  CONSTRAINT fk_salary_employee
    FOREIGN KEY (employee_id) REFERENCES employee(id)
);

INSERT INTO department (id, Dname) VALUES
  (1, '产品研发中心'),
  (2, '财务共享中心'),
  (3, '人力资源部'),
  (4, '运营管理部');

INSERT INTO employee (id, name, sex, phone, email, grade, hiredate, power, password, department_id) VALUES
  ('1001', '陈一鸣', '男', '13810001001', 'yiming.chen@acme-corp.cn', 'P5', '2022-03-14', '1', '123456', 1),
  ('1002', '周嘉宁', '女', '13810001002', 'jianing.zhou@acme-corp.cn', 'P6', '2021-08-02', '1', '123456', 4),
  ('2001', '林若溪', '女', '13810002001', 'ruoxi.lin@acme-corp.cn', 'M1', '2020-11-16', '2', '123456', 2),
  ('3001', '沈浩然', '男', '13810003001', 'haoran.shen@acme-corp.cn', 'M1', '2019-06-24', '3', '123456', 3);

INSERT INTO checking_in
  (employee_id, month, over_hours, weekend_overtime, holiday_overtime, leave_day, late_day, early_leave)
VALUES
  ('1001', '2024-01-01', 8, 4, 0, 0, 0, 0),
  ('1001', '2024-02-01', 6, 0, 0, 1, 0, 0),
  ('1001', '2024-03-01', 10, 2, 0, 0, 0, 0),
  ('1001', '2024-04-01', 4, 0, 0, 0, 1, 0),
  ('1001', '2024-05-01', 7, 3, 0, 0, 0, 0),
  ('1001', '2024-06-01', 5, 0, 0, 0, 0, 0),
  ('1002', '2024-01-01', 3, 2, 0, 0, 0, 0),
  ('1002', '2024-02-01', 4, 0, 0, 0, 1, 0),
  ('1002', '2024-03-01', 6, 1, 0, 0, 0, 0),
  ('1002', '2024-04-01', 2, 0, 0, 1, 0, 0),
  ('1002', '2024-05-01', 5, 2, 0, 0, 0, 0),
  ('1002', '2024-06-01', 3, 0, 0, 0, 0, 1),
  ('2001', '2024-01-01', 5, 1, 0, 0, 0, 0),
  ('2001', '2024-02-01', 2, 0, 0, 0, 0, 0),
  ('2001', '2024-03-01', 4, 0, 0, 0, 0, 0),
  ('2001', '2024-04-01', 3, 1, 0, 0, 0, 0),
  ('2001', '2024-05-01', 6, 0, 0, 0, 0, 0),
  ('2001', '2024-06-01', 2, 0, 0, 1, 0, 0),
  ('3001', '2024-01-01', 2, 0, 0, 0, 0, 1),
  ('3001', '2024-02-01', 3, 0, 0, 0, 0, 0),
  ('3001', '2024-03-01', 4, 1, 0, 0, 0, 0),
  ('3001', '2024-04-01', 2, 0, 0, 0, 1, 0),
  ('3001', '2024-05-01', 5, 0, 0, 0, 0, 0),
  ('3001', '2024-06-01', 3, 1, 0, 0, 0, 0);

INSERT INTO salary_record
  (employee_id, month, wage, subsidy, bonus, from_checking_in, deductMoney, before_tax, tax, total)
VALUES
  ('1001', '2024-01-01', 18500, 1200, 1800, 0, 3250, 18250, 1215, 17035),
  ('1001', '2024-02-01', 18500, 650, 1500, -300, 3250, 17100, 880, 16220),
  ('1001', '2024-03-01', 18500, 1450, 1800, 0, 3250, 18500, 1290, 17210),
  ('1001', '2024-04-01', 18500, 420, 1500, -100, 3250, 17070, 872, 16198),
  ('1001', '2024-05-01', 18500, 1120, 1800, 0, 3250, 18170, 1186, 16984),
  ('1001', '2024-06-01', 18500, 520, 1600, 0, 3250, 17370, 953, 16417),
  ('1002', '2024-01-01', 16000, 720, 1200, 0, 2800, 15120, 615, 14505),
  ('1002', '2024-02-01', 16000, 500, 1200, -100, 2800, 14800, 555, 14245),
  ('1002', '2024-03-01', 16000, 860, 1400, 0, 2800, 15460, 683, 14777),
  ('1002', '2024-04-01', 16000, 260, 1200, -300, 2800, 14360, 467, 13893),
  ('1002', '2024-05-01', 16000, 760, 1500, 0, 2800, 15460, 683, 14777),
  ('1002', '2024-06-01', 16000, 380, 1200, -50, 2800, 14730, 541, 14189),
  ('2001', '2024-01-01', 22000, 780, 2200, 0, 3950, 21030, 2045, 18985),
  ('2001', '2024-02-01', 22000, 260, 2000, 0, 3950, 20310, 1820, 18490),
  ('2001', '2024-03-01', 22000, 520, 2200, 0, 3950, 20770, 1960, 18810),
  ('2001', '2024-04-01', 22000, 650, 2100, 0, 3950, 20800, 1970, 18830),
  ('2001', '2024-05-01', 22000, 780, 2300, 0, 3950, 21130, 2075, 19055),
  ('2001', '2024-06-01', 22000, 260, 2000, -300, 3950, 20010, 1730, 18280),
  ('3001', '2024-01-01', 21000, 260, 1800, -50, 3780, 19230, 1535, 17695),
  ('3001', '2024-02-01', 21000, 390, 1800, 0, 3780, 19410, 1600, 17810),
  ('3001', '2024-03-01', 21000, 650, 2000, 0, 3780, 19870, 1738, 18132),
  ('3001', '2024-04-01', 21000, 260, 1800, -100, 3780, 19180, 1520, 17660),
  ('3001', '2024-05-01', 21000, 520, 2100, 0, 3780, 19840, 1729, 18111),
  ('3001', '2024-06-01', 21000, 520, 1900, 0, 3780, 19640, 1669, 17971);

DELIMITER //

CREATE PROCEDURE getRecordsBetweenDates(
  IN p_start_date VARCHAR(20),
  IN p_end_date VARCHAR(20)
)
BEGIN
  SELECT
    e.id,
    e.name,
    d.Dname,
    DATE_FORMAT(s.month, '%Y-%m') AS month,
    s.wage,
    s.subsidy,
    s.bonus,
    s.from_checking_in,
    s.deductMoney,
    s.before_tax,
    s.tax,
    s.total
  FROM salary_record s
  JOIN employee e ON e.id = s.employee_id
  LEFT JOIN department d ON d.id = e.department_id
  WHERE DATE_FORMAT(s.month, '%Y-%m') BETWEEN LEFT(p_start_date, 7) AND LEFT(p_end_date, 7)
  ORDER BY s.month, e.id;
END //

CREATE PROCEDURE getRecordsBetweenDatesById(
  IN p_employee_id VARCHAR(4),
  IN p_start_date VARCHAR(20),
  IN p_end_date VARCHAR(20)
)
BEGIN
  SELECT
    DATE_FORMAT(s.month, '%Y-%m') AS month,
    s.wage,
    s.subsidy,
    s.bonus,
    s.from_checking_in,
    s.deductMoney,
    s.before_tax,
    s.tax,
    s.total
  FROM salary_record s
  WHERE s.employee_id = p_employee_id
    AND DATE_FORMAT(s.month, '%Y-%m') BETWEEN LEFT(p_start_date, 7) AND LEFT(p_end_date, 7)
  ORDER BY s.month;
END //

CREATE PROCEDURE GetEmployeeInfoById(
  IN p_employee_id VARCHAR(4)
)
BEGIN
  SELECT
    e.id,
    e.name,
    e.sex,
    e.phone,
    e.email,
    e.grade,
    DATE_FORMAT(e.hiredate, '%Y-%m-%d') AS hiredate,
    e.power,
    e.password,
    d.Dname
  FROM employee e
  LEFT JOIN department d ON d.id = e.department_id
  WHERE p_employee_id IS NULL
     OR p_employee_id = ''
     OR e.id = p_employee_id
  ORDER BY e.id;
END //

CREATE PROCEDURE GetCheckingInfoById(
  IN p_employee_id VARCHAR(4)
)
BEGIN
  SELECT
    e.id,
    e.name,
    DATE_FORMAT(c.month, '%Y-%m') AS month,
    c.over_hours,
    c.weekend_overtime,
    c.holiday_overtime,
    c.leave_day,
    c.late_day,
    c.early_leave
  FROM checking_in c
  JOIN employee e ON e.id = c.employee_id
  WHERE p_employee_id IS NULL
     OR p_employee_id = ''
     OR e.id = p_employee_id
  ORDER BY c.month, e.id;
END //

CREATE PROCEDURE CalculateYearlyBonus(
  IN p_bonus_year VARCHAR(4)
)
BEGIN
  SELECT
    e.id AS employee_id,
    e.name AS employee_name,
    ROUND(SUM(s.bonus) + SUM(s.total) * 0.10, 2) AS yearly_bonus
  FROM salary_record s
  JOIN employee e ON e.id = s.employee_id
  WHERE YEAR(s.month) = CAST(p_bonus_year AS UNSIGNED)
  GROUP BY e.id, e.name
  ORDER BY e.id;
END //

CREATE PROCEDURE UpdateEmployeeInfo(
  IN p_employee_id VARCHAR(4),
  IN p_employee_name VARCHAR(50),
  IN p_employee_sex VARCHAR(10),
  IN p_employee_phone VARCHAR(30),
  IN p_employee_email VARCHAR(100),
  IN p_employee_password VARCHAR(100)
)
BEGIN
  UPDATE employee
  SET name = p_employee_name,
      sex = p_employee_sex,
      phone = p_employee_phone,
      email = p_employee_email,
      password = p_employee_password
  WHERE id = p_employee_id;
END //

CREATE PROCEDURE UpdateCheckingIn(
  IN p_checking_month VARCHAR(20),
  IN p_employee_id VARCHAR(4),
  IN p_normal_over_hours DECIMAL(10,2),
  IN p_weekend_hours DECIMAL(10,2),
  IN p_holiday_hours DECIMAL(10,2),
  IN p_leave_days DECIMAL(10,2),
  IN p_late_days DECIMAL(10,2),
  IN p_early_leave_days DECIMAL(10,2)
)
BEGIN
  UPDATE checking_in
  SET over_hours = p_normal_over_hours,
      weekend_overtime = p_weekend_hours,
      holiday_overtime = p_holiday_hours,
      leave_day = p_leave_days,
      late_day = p_late_days,
      early_leave = p_early_leave_days
  WHERE employee_id = p_employee_id
    AND DATE_FORMAT(month, '%Y-%m') = LEFT(p_checking_month, 7);
END //

CREATE PROCEDURE SetDefaultPassword(
  IN p_employee_id VARCHAR(4)
)
BEGIN
  UPDATE employee
  SET password = '123456'
  WHERE id = p_employee_id;
END //

DELIMITER ;
