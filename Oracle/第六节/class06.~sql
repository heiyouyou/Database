SELECT * FROM EMP;
SELECT * FROM DEPT;

一、子查询
-- 1.单行子查询
--查询与员工SMITH属于同一部门的员工信息
--思路：首先得查询出SMITH所在的部门，然后将其当做一个结果集，进行条件筛选
SELECT * FROM EMP WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'SMITH');-- = 可用于单行查询，这里也可以用 IN

--2.多行子查询
--查询与部门10员工工作岗位相同的员工信息
--思路：首先得查询出部门10的工作岗位信息，然后将其当做一个结果集，进行条件筛选出相同岗位员工的信息
SELECT * FROM EMP WHERE JOB IN (SELECT JOB FROM EMP WHERE DEPTNO = 10);--IN 用于多行查询,这里不能用 =

-- 2.2 查询与部门10员工工作岗位不相同的员工信息
SELECT * FROM EMP WHERE JOB NOT IN (SELECT JOB FROM EMP WHERE DEPTNO = 10);

--3.多列子查询
--查询与SMITH的部门和岗位都相同的员工信息
--思路：先将SMITH的部门和岗位查询出来，然后将其作为一个结果集，进行条件筛选出具有岗位和部门员工的信息
SELECT * FROM EMP WHERE (DEPTNO,JOB) = (SELECT DEPTNO,JOB FROM EMP WHERE ENAME = 'SMITH');

--子查询中all关键字的使用:
--求出30号部门所有员工的工资
SELECT SAL FROM EMP WHERE DEPTNO = 30;
--4.显示工资比部门号30的所有员工的工资都要高的员工的，姓名，工资，部门号
--思路：至少要比部门号30的所有员工的工资中的最高者大
SELECT ENAME,SAL,DEPTNO FROM EMP WHERE SAL > ALL(SELECT SAL FROM EMP WHERE DEPTNO = 30); 
--方法二：
--思路：先求出30号部门所有员工的工资最高的，再进行比较查询
SELECT ENAME,SAL,DEPTNO FROM EMP WHERE SAL > (SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 30);

--子查询中any关键字的使用
--5.显示工资比部门号30的任意员工的工资都要高的员工的，姓名，工资，部门号
--至少要比部门号30的所有员工的工资中的最低者大
SELECT ENAME,SAL,DEPTNO FROM EMP WHERE SAL > ANY(SELECT SAL FROM EMP WHERE DEPTNO = 30);

--方法二：
--思路：先求出30号部门所有员工的工资最低的，再进行比较查询
SELECT ENAME,SAL,DEPTNO FROM EMP WHERE SAL > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30);

--内联视图子查询（分页查询）
--8.查询30号部门中工资排序前5名的员工信息。
/*
    rownum是Oracle对查询结果集加的一个伪列 (强调：先要有结果集)。
    简单的说rownum是对符合条件结果的序列号。它的值是从1开始的
    但是他却不受到sql中order by排序的影响
*/
SELECT ROWNUM AS ROWNUMER,E.* FROM (SELECT * FROM EMP WHERE DEPTNO = 30 ORDER BY SAL DESC) E WHERE ROWNUM <= 5;

--9.查询所有员工中工资排序在6到10名之间的员工信息。
/*
   页数1，每页显示行数: 5
   结束范围: <= 页数 * 显示行数
   开始范围: > (页数-1) * 显示行数
*/
--思路：先按升序将工资前10的查询出来作为一个结果集，然后将这个结果集工资后6位的查询出来
SELECT * FROM (SELECT ROWNUM RN,E.* FROM (SELECT * FROM EMP ORDER BY SAL DESC) E WHERE ROWNUM <=2*5) RN WHERE RN > (2-1)*5;
