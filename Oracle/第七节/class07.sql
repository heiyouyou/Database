/*�ѿ�����
   �ѿ������D�D�ǹ�ϵ�ĳ˷��������ֱ������������ݼ����е��������п��ܵķ�ʽ������ϡ�
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

--1.��ʾ10����������Ա���Ĳ������ƣ�Ա������������(emp,dept)
--˼·�������Ȳ�ѯ��DEPT���EMP������п���������ϣ�Ȼ��ͨ��WHERE�������˳���
SELECT D.DEPTNO,E.ENAME,E.SAL 
FROM EMP E,DEPT D --�õ�emp,dept���ݵĵѿ�����
WHERE D.DEPTNO = E.DEPTNO AND E.DEPTNO = 10-- ͨ��where���������ѿ�����

--2.��ѯ���ʸ����Լ�����ƽ�����ʵ�Ա����������������Ϣ
--����ÿ�����ŵ�ƽ������
SELECT DEPTNO,AVG(SAL) DEPT_SAL_AVG FROM EMP GROUP BY DEPTNO;
--��Ա�����ʺ�Ա�����ڲ��ŵ�ƽ���������Ƚ�
--˼·�����ȵý�ÿ�����ŵ�ƽ�����ʷ����ѯ������Ȼ����EMP����еѿ�����������ݣ����ͨ��WHERE������������
SELECT E.ENAME,E.SAL,E.DEPTNO,DEPT_SAL_AVG FROM EMP E,(SELECT DEPTNO,AVG(SAL) DEPT_SAL_AVG FROM EMP GROUP BY DEPTNO) DSA 
WHERE E.DEPTNO = DSA.DEPTNO AND E.SAL > DSA.DEPT_SAL_AVG;


��������:
  ������������һ���ѿ����������һ��ѡȡ���㹹�ɵġ�
  �����õѿ�������ɶ��������ݼ��ϵĳ����㣬
  Ȼ������ɵĽ�����Ͻ���ѡȡ���㣬
  ȷ��ֻ�ѷֱ������������ݼ��ϲ��Ҿ����ص�����(����ѡȡ����)���кϲ���һ��

left[outer] join(������)����ʡȥouter 
  ���ذ������(����)�е����м�¼���ұ�(����)�������ֶ���ȵļ�¼
right[outer] join(������) 
  ���ذ����ұ��е����м�¼������������ֶ���ȵļ�¼
inner join(��ֵ����) 
  ֻ�����������������ֶ���ȵ���
--ѧ����Ϣ��
CREATE TABLE T_STUDENT(
      F_ID INT,
      F_NAME VARCHAR2(30) 
);
--����һ�����Գɼ���(�ֶ�:�ɼ���ţ���Ŀ��������ѧ�����)
CREATE TABLE T_EXAM(
       F_ID INT,
       F_SUBJECT VARCHAR2(30),
       F_SCORE NUMBER(3,1),
       F_STUDENT_ID INT
);
--�����ӣ�
INSERT INTO T_STUDENT VALUES(1,'����');
INSERT INTO T_STUDENT VALUES(2,'����');
INSERT INTO T_STUDENT VALUES(3,'����');
INSERT INTO T_STUDENT VALUES(4,'����');

INSERT INTO T_EXAM VALUES(1,'Java',99,1);
INSERT INTO T_EXAM VALUES(2,'C++',99,1);
INSERT INTO T_EXAM VALUES(3,'Java',98,2);
INSERT INTO T_EXAM VALUES(4,'Java',59,3);
INSERT INTO T_EXAM VALUES(5,'Java',49,5);
DELETE FROM T_EXAM;
SELECT * FROM T_EXAM;
SELECT * FROM T_STUDENT;

--3.��������
SELECT S.F_NAME,E.F_SUBJECT,E.F_SCORE FROM T_STUDENT S 
LEFT JOIN T_EXAM E ON S.F_ID = E.F_STUDENT_ID;

--4.��������
SELECT S.F_NAME,E.F_SUBJECT,E.F_SCORE FROM T_STUDENT S 
RIGHT JOIN T_EXAM E ON S.F_ID = E.F_STUDENT_ID;

--5.��(��ֵ)����
--INNER JOIN�൱��WHERE�ؼ���
SELECT S.F_NAME,E.F_SUBJECT,E.F_SCORE FROM T_STUDENT S 
INNER JOIN T_EXAM E ON S.F_ID = E.F_STUDENT_ID;

--�����£�
SELECT * FROM EMP E INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO;
--�൱�ڣ�
SELECT * FROM EMP E,DEPT D WHERE E.DEPTNO = D.DEPTNO;
 

--6.������
--��ѯԱ����SMITH�� ���ϼ��쵼������
SELECT P.ENAME FROM EMP E,EMP P WHERE E.ENAME = 'SMITH' AND E.MGR = P.EMPNO;
SELECT * FROM EMP;
     select * from emp e inner join dept d on e.deptno(+)=d.deptno;
     select * from emp e inner join dept d on e.deptno=d.deptno;
     
--7.��ѯÿһ��ѧ�������������ԵĿ�Ŀ����ƽ���ɼ�
/*
  nvl(value1,replace_with)
�����ܣ����value1ΪNULL����nvl��������replace_with��ֵ�����򷵻�value1��ֵ�� 
*/
SELECT TS.F_NAME,--ѧ��������
(SELECT COUNT(*) FROM T_EXAM WHERE F_STUDENT_ID = TS.F_ID) SUBJECT_NUMS,--ÿ��ѧ�����ԵĿ�Ŀ��
(SELECT NVL(AVG(F_SCORE),0) FROM T_EXAM WHERE F_STUDENT_ID = TS.F_ID) AVG_SCORE--ÿ��ѧ��ƽ���ɼ�
FROM T_STUDENT TS;

SELECT * FROM T_EXAM;
SELECT * FROM T_STUDENT;
