/*笛卡尔积
   笛卡尔积――是关系的乘法，它将分别来自两个数据集合中的行以所有可能的方式进行组合。
   A  = {1, 2, 3}
   B =  {4, 5, 6}
   A * B = {
      (1,4), (1, 5), (1, 6)
      (2, 4), (2, 5), (2, 6)
      (3, 4), (3, 5), (3, 6)
   }
   3 * 3 = 9
 */
SELECT * FROM DEPT;
SELECT * FROM EMP;

--1.显示10部门下所有员工的部门名称，员工姓名，工资(emp,dept)
--思路：就是先查询出DEPT表和EMP表的所有可能数据组合，然后通过WHERE条件过滤出来
SELECT D.DEPTNO,E.ENAME,E.SAL 
FROM EMP E,DEPT D --得到emp,dept数据的笛卡尔积
WHERE D.DEPTNO = E.DEPTNO AND E.DEPTNO = 10-- 通过where条件消除笛卡尔积

--2.查询工资高于自己部门平均工资的员工的姓名，工资信息
--先求每个部门的平均工资
SELECT DEPTNO,AVG(SAL) DEPT_SAL_AVG FROM EMP GROUP BY DEPTNO;
--拿员工工资和员工所在部门的平均工资做比较
--思路：首先得将每个部门的平均工资分组查询出来，然后与EMP表进行笛卡尔积组合数据，最后通过WHERE进行条件过滤
SELECT E.ENAME,E.SAL,E.DEPTNO,DEPT_SAL_AVG FROM EMP E,(SELECT DEPTNO,AVG(SAL) DEPT_SAL_AVG FROM EMP GROUP BY DEPTNO) DSA 
WHERE E.DEPTNO = DSA.DEPTNO AND E.SAL > DSA.DEPT_SAL_AVG;


连接运算:
  连接运算是由一个笛卡尔积运算和一个选取运算构成的。
  首先用笛卡尔积完成对两个数据集合的乘运算，
  然后对生成的结果集合进行选取运算，
  确保只把分别来自两个数据集合并且具有重叠部分(符合选取运算)的行合并在一起。

left[outer] join(左连接)，可省去outer 
  返回包括左表(集合)中的所有记录和右表(集合)中联结字段相等的记录
right[outer] join(右连接) 
  返回包括右表中的所有记录和左表中联结字段相等的记录
inner join(等值连接) 
  只返回两个表中联结字段相等的行
--学生信息表
CREATE TABLE T_STUDENT(
      F_ID INT,
      F_NAME VARCHAR2(30) 
);
--创建一个考试成绩表(字段:成绩编号，科目，分数，学生编号)
CREATE TABLE T_EXAM(
       F_ID INT,
       F_SUBJECT VARCHAR2(30),
       F_SCORE NUMBER(3,1),
       F_STUDENT_ID INT
);
--外连接：
INSERT INTO T_STUDENT VALUES(1,'张三');
INSERT INTO T_STUDENT VALUES(2,'李四');
INSERT INTO T_STUDENT VALUES(3,'王五');
INSERT INTO T_STUDENT VALUES(4,'赵六');

INSERT INTO T_EXAM VALUES(1,'Java',99,1);
INSERT INTO T_EXAM VALUES(2,'C++',99,1);
INSERT INTO T_EXAM VALUES(3,'Java',98,2);
INSERT INTO T_EXAM VALUES(4,'Java',59,3);
INSERT INTO T_EXAM VALUES(5,'Java',49,5);
DELETE FROM T_EXAM;
SELECT * FROM T_EXAM;
SELECT * FROM T_STUDENT;

--3.左外联接
SELECT S.F_NAME,E.F_SUBJECT,E.F_SCORE FROM T_STUDENT S 
LEFT JOIN T_EXAM E ON S.F_ID = E.F_STUDENT_ID;

--4.右外联接
SELECT S.F_NAME,E.F_SUBJECT,E.F_SCORE FROM T_STUDENT S 
RIGHT JOIN T_EXAM E ON S.F_ID = E.F_STUDENT_ID;

--5.内(等值)连接
--INNER JOIN相当于WHERE关键字
SELECT S.F_NAME,E.F_SUBJECT,E.F_SCORE FROM T_STUDENT S 
INNER JOIN T_EXAM E ON S.F_ID = E.F_STUDENT_ID;

--如以下：
SELECT * FROM EMP E INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO;
--相当于：
SELECT * FROM EMP E,DEPT D WHERE E.DEPTNO = D.DEPTNO;
 

--6.自连接
--查询员工‘SMITH’ 的上级领导的姓名
SELECT P.ENAME FROM EMP E,EMP P WHERE E.ENAME = 'SMITH' AND E.MGR = P.EMPNO;
SELECT * FROM EMP;
     select * from emp e inner join dept d on e.deptno(+)=d.deptno;
     select * from emp e inner join dept d on e.deptno=d.deptno;
     
--7.查询每一个学生的姓名、考试的科目数、平均成绩
/*
  nvl(value1,replace_with)
　功能：如果value1为NULL，则nvl函数返回replace_with的值，否则返回value1的值。 
*/
SELECT TS.F_NAME,--学生的姓名
(SELECT COUNT(*) FROM T_EXAM WHERE F_STUDENT_ID = TS.F_ID) SUBJECT_NUMS,--每个学生考试的科目数
(SELECT NVL(AVG(F_SCORE),0) FROM T_EXAM WHERE F_STUDENT_ID = TS.F_ID) AVG_SCORE--每个学生平均成绩
FROM T_STUDENT TS;

SELECT * FROM T_EXAM;
SELECT * FROM T_STUDENT;
