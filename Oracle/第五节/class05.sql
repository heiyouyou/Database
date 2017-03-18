--分组函数：分组函数作用于一组数据，并对一组数据返回一个值。
--常见的几种分组函数有：count,max,min,avg,sum
--分组查询：
--语法格式：
--SELECT column, group_function  FROM table [WHERE condition] 或者 [GROUP BY group_by_expression] 
---或者 [HAVING group_condition] 或者 [ORDER BY column]; 

-- 1.查询雇员表的员工总数
--格式：SELECT COUNT(依据统计的字段) FROM 表名
--方法一：
SELECT COUNT(EMPNO) FROM EMP;
--方法二：
SELECT COUNT(ENAME) FROM EMP;
--方法三：
SELECT COUNT(DEPTNO) FROM EMP;
SELECT * FROM EMP;

--求员工表中职务的个数
--可以用DISTINCT去掉重复职位的数据（行）
SELECT COUNT(DISTINCT JOB) FROM EMP;
--COUNT会自动过滤掉NULL的记录或者数据
SELECT COUNT(COMM) FROM EMP;

--2.查询最高工资的员工的名字和工作岗位(Job)
--先求出最高工资
--格式：SELECT MAX(依据比较的字段) FROM 表名
SELECT MAX(SAL) FROM EMP;
--把求出的最高工资作为条件查询，注意了不要少了括号（）
SELECT ENAME,JOB FROM EMP WHERE SAL = (SELECT MAX(SAL) FROM EMP);
SELECT * FROM EMP
SELECT MIN(SAL) FROM EMP;
SELECT ENAME,JOB FROM EMP WHERE SAL = (SELECT MIN(SAL) FROM EMP);

--3.查询工资高于平均工资的员工信息。
--先求平均工资
--格式：SELECT AVG(依据求平均值的字段) FROM 表名
SELECT AVG(SAL) FROM EMP;
--将求出的平均工资作为条件查询
SELECT * FROM EMP WHERE SAL > (SELECT AVG(SAL) FROM EMP);

--group by 对查询的结果进行分组统计
--having 对分组统计的结果进行筛选(限制)
--4.查询每个部门的员工总数
--格式：SELECT 字段名,COUNT(依据某个字段统计) 自定义字段名(可以不写) FROM 表名 GROUD BY 字段名
--注意了：SELECT后面的字段名和GROUD BY后面的字段名要一样
SELECT DEPTNO,COUNT(*) DEPT_EMP_NUM FROM EMP GROUP BY DEPTNO
SELECT DEPTNO,COUNT(*) FROM EMP GROUP BY DEPTNO

--5.显示每个部门的最高工资和最低工资
--格式：SELECT 依据分组的字段名,MAX(依据比较的字段) 自定义字段名(可以不写),MIN(依据比较的字段) 自定义字段名(可以不写) FROM 表名 GROUD BY 依据分组的字段名 
--注意了：多个分组函数可以用逗号隔开，
--注意：group by子句一定要与分组函数结合使用,否则没有意义;group by子句中的列不必包含在SELECT 列表中
SELECT DEPTNO,MAX(SAL) MAX_SAL,MIN(SAL) MIN_SAL FROM EMP GROUP BY DEPTNO;
SELECT MAX(SAL) MAL_SAL,MIN(SAL) MIN_SAL FROM EMP GROUP BY DEPTNO;
SELECT DEPTNO,MAX(SAL),AVG(SAL) FROM EMP GROUP BY DEPTNO

--6.显示每个部门的每个岗位的最高工资和最低工资
--依据分组的条件字段有多个，可以用逗号隔开
SELECT DEPTNO,JOB,MAX(SAL),MIN(SAL) FROM EMP GROUP BY DEPTNO,JOB;

--7.显示每个部门的平均工资并且筛选出平均工资大于等于2000的部门
--格式：SELECT 依据分组的字段名,AVG(依据求平均值的字段) 自定义字段名(可以不写)FROM 表名 GROUD BY 依据分组的字段名 HAVING 条件
SELECT DEPTNO,AVG(SAL) AVG_SAL FROM EMP GROUP BY DEPTNO HAVING AVG(SAL) >= 2000;
--注意了：HAVING后面有多个条件时要用AND或者OR连接
--注意：如果一个语句里面有 order by, group by ,having 
--那么这些顺序是：[where] group by, having order by
SELECT DEPTNO,AVG(SAL),MIN(SAL) FROM EMP GROUP BY DEPTNO HAVING AVG(SAL) >= 2000 AND MIN(SAL) >= 1000;
--查询部门的员工人数大于五部门编号
SELECT DEPTNO,COUNT(*) FROM EMP GROUP BY DEPTNO HAVING COUNT(*)>5;

--如果一个查询语句使用了 group by 那么该语句查询的列只能是分组函数
--或者被分组的列(group by 列名称)
--8.查询每个部门的总工资
SELECT DEPTNO,SUM(SAL) FROM EMP GROUP BY DEPTNO;

--9.如果使用了分组函数,没有被分组的列不能查询
SELECT SUM(SAL) FROM EMP;

--二、数字函数
--DUAL一个虚拟不存在的表，只是作为一个坑存在
--10.求绝对值
SELECT ABS(100),ABS(-100) FROM DUAL;

--11.求平方根
SELECT SQRT(64),SQRT(16) FROM DUAL;

--12.求幂
--说明：POWER(底数,指数)
SELECT POWER(3,2),POWER(2,3) FROM DUAL;

--13.四舍五入
--说明：ROUND()第一个参数表示要进行四舍五入的数，第二个参数表示要保留的小数位数，不写参数，就是只保留整数位
SELECT ROUND(5555.6666,2),ROUND(5555.6666,1),ROUND(5555.6666) FROM DUAL;

--三、字符函数
--14.连接两个字符串
--格式：CONCAT(第一个字符串,第二个字符串)，只能是两个字符串拼接，不能少也不能多
SELECT CONCAT('010-','434842348') FROM DUAL;

--15.替换字符串
--格式：REPLACE(旧的字符串,要替换的某个字符串,替换成的新字符串)
SELECT REPLACE('HEI有有','HEI','黑') FROM DUAL;
--注意了：参数最少只能两个，最多只能三个，两个参数时，第三个参数默认是用空格替换
SELECT REPLACE('HEI有有','HEI') FROM DUAL;

--16.截取字符串
--SUBSTR(c1,n1[,n2])【参数】在字符表达式c1里，从n1开始取n2个字符;若不指定n2,则从第n1个字符直到结束的字串
SELECT SUBSTR('423424hieh',2,4) FROM DUAL;
SELECT SUBSTR('423424hieh',2) FROM DUAL;
--17.转大写
--格式：SELECT UPPER(要进行转大写的字符串) 自定义显示字段名称 FROM 表名
SELECT UPPER('afsdf') ISUPER FROM DUAL;
--18.转小写
--格式：SELECT LOWER(要进行转大写的字符串) 自定义显示字段名称 FROM 表名
SELECT LOWER('FSHa') ISLOWER FROM DUAL;

--四、转换函数
--19.将字符串转换成日期
--to_date(值,格式)
--注意了：TO_DATE()的第二参数是用来描述第一个日期参数的格式的，不是用来定义格式的
--HH:MI:SS，默认是12小时制，可以在HH后面加上24就可以显示24小时制，分钟用MI表示
SELECT TO_DATE('201605','YYYYMM'),TO_DATE('2016.05.28','YYYY.MM.DD'),TO_DATE('2016-05-28 23:38:12','YYYY-MM-DD HH24:MI:SS') FROM DUAL;

--20.将将日期或数据转换为char数据类型
--格式：SELECT TO_CHAR(TO_DATE(参数1,参数2),提取格式) FROM DUAL
--转换得到日期的年份
SELECT TO_CHAR(TO_DATE('2016-05-28 23:38:12','YYYY-MM-DD HH24:MI:SS'),'YYYY') FROM DUAL;
--转换得到日期的月份
SELECT TO_CHAR(TO_DATE('2016-05-28 23:38:12','YYYY-MM-DD HH24:MI:SS'),'MM') FROM DUAL;
--转换得到日期的日(几号)
SELECT TO_CHAR(TO_DATE('2016-05-28 23:38:12','YYYY-MM-DD HH24:MI:SS'),'DD') FROM DUAL;
--转换得到日期的星期
SELECT TO_CHAR(TO_DATE('2016-05-28 23:38:12','YYYY-MM-DD HH24:MI:SS'),'DAY') FROM DUAL;
--转换得到日期的小时
SELECT TO_CHAR(TO_DATE('2016-05-28 23:38:12','YYYY-MM-DD HH24:MI:SS'),'HH') FROM DUAL;
--转换得到日期的分
SELECT TO_CHAR(TO_DATE('2016-05-28 23:38:12','YYYY-MM-DD HH24:MI:SS'),'MI') FROM DUAL;
--转换得到日期的秒
SELECT TO_CHAR(TO_DATE('2016-05-28 23:38:12','YYYY-MM-DD HH24:MI:SS'),'SS') FROM DUAL;

--五、日期函数
--21.返回在日期d1基础上再加n1个月后新的日期。
--格式：SELECT 指定日期字段,ADD_MONTHS(指定日期字段,n1) FROM 表名
--说明：返回在指定日期字段基础上再加n1个月后新的日期。
--注意了：没有ADD_DAYS()或者ADD_DATE()函数
SELECT SYSDATE,ADD_MONTHS(SYSDATE,3) FROM DUAL;
SELECT TO_DATE('201605','YYYYMM'),ADD_MONTHS(TO_DATE('201605','YYYYMM'),3) FROM DUAL;

--22.返回日期d1所在月份最后一天的日期
--格式：SELECT d1,LAST_DAY(d1) FROM DUAL;
SELECT SYSDATE,LAST_DAY(SYSDATE) FROM DUAL;
SELECT TO_DATE('201605','YYYYMM'),LAST_DAY(TO_DATE('201605','YYYYMM')) FROM DUAL;

--23.返回日期d1到日期d2之间的月数。
--格式：SELECT 日期d1,MONTHS_BETWEEN(日期d1,日期d2) FROM 表名;
SELECT SYSDATE,MONTHS_BETWEEN(SYSDATE,TO_DATE('2016-04-28 23:38:12','YYYY-MM-DD HH24:MI:SS')),
MONTHS_BETWEEN(SYSDATE,TO_DATE('2015-01-01','YYYY-MM-DD')) FROM DUAL;

--24.截取日期的指定部分
--格式：SELECT EXTRACT(截取的日期某部分 FROM 日期类型 指定日期) FROM 表名
--截取日期的年份
SELECT EXTRACT(YEAR FROM DATE '2015-01-01') FROM DUAL;
--截取日期的月份
SELECT EXTRACT(MONTH FROM DATE '2015-01-01') FROM DUAL;
--截取日期的第几天
SELECT EXTRACT(DAY FROM DATE '2015-01-01') FROM DUAL;

SELECT 
EXTRACT(HOUR FROM TIMESTAMP '2015-2-16 2:38:40' ) 小时,
EXTRACT(minute FROM TIMESTAMP '2015-2-16 2:38:40 ' ) 分钟,
EXTRACT(second FROM timestamp '2015-2-16 2:38:40 ' ) 秒,
EXTRACT(DAY FROM TIMESTAMP '2015-2-16 2:38:40 ' ) 日,
EXTRACT(MONTH FROM TIMESTAMP '2015-2-16 2:38:40 ' ) 月,
EXTRACT(YEAR FROM TIMESTAMP '2015-2-16 2:38:40 ' ) 年
FROM DUAL;

--注意：函数的()后面可以给该函数的返回值指定一个自定义名称
