SELECT * FROM T_USER;
SELECT USER_ID,USER_NAME,USER_PASSWORD,USER_SEX,USER_PROVINCE,USER_CITY,
USER_MOBILE_PHONE FROM T_USER;
DELETE FROM T_USER WHERE USER_ID = 2;
-- ע���ˣ�������е������Ѿ��д�����ĳ��Լ�����ص㣬������ӣ����ǽ�Υ��Լ������������ɾ�����������
-- �������Լ��
-- �ص㣺Ψһ�ԣ��ǿ���
-- ˼�룺Ψһ�ԣ�������Լ�����ֶ���û����ͬ�����ݣ��ǿ��ԣ�������Լ�����ֶ���û�п�ֵ
-- ��ʽ��ALTER TABLE ���� ADD CONSTRAINT �Զ��������� PRIMARY KEY (��Ҫ���Լ�����ֶ���)
-- ����Լ������ͬʱԼ������ֶΣ��ö��Ÿ���
-- �������Լ���ı�������е������Ѿ��д���������Լ�����ص㣬������ӣ����ǽ�Υ��Լ������������ɾ��
ALTER TABLE T_USER ADD CONSTRAINT PK_USER_ID PRIMARY KEY (USER_ID,USER_NAME);
-- һ������ֻ�ܳ���һ�����������ܳ��ֶ��������������ܼ����಻��ͬ
ALTER TABLE T_USER ADD CONSTRAINT PK_USER_ID PRIMARY KEY (USER_NAME);
-- ɾ������Լ��
-- ��ʽ��ALTER TABLE ���� DROP CONSTRAINT ��Ҫɾ����������
ALTER TABLE T_USER DROP CONSTRAINT PK_USER_ID; 
DELETE FROM T_USER WHERE USER_ID = 1 AND USER_ID = 3;
DELETE FROM T_USER WHERE USER_ID = 2;
DELETE FROM T_USER WHERE USER_ID = 0 OR USER_ID = 7;
-- �����ӵ������г���NULL���߿գ�Ҳ��Υ��������Լ���ķǿ����ص�
INSERT INTO T_USER(USER_ID,USER_NAME) VALUES(0,'');
-- �������Υ��������Լ����Ψһ������
INSERT INTO T_USER(USER_ID,USER_NAME) VALUES(2,'HH');
UPDATE T_USER SET USER_NAME = '������' WHERE USER_ID = 2;
SELECT * FROM T_USER;

-- ΨһԼ�� UNIQUE
-- �ص㣺Ψһ��
-- ˼�룺Ψһ�ԣ�������Լ�����ֶ���û����ͬ������
-- ��ʽ��ALTER TABLE ���� ADD CONSTRAINT �Զ������ UNIQUE (ҪԼ�����ֶ�)
-- ͬ��Ҳ֧�ֶ���ֶ�Լ��
ALTER TABLE T_USER ADD CONSTRAINT UN_USER_TEL UNIQUE (USER_MOBILE_PHONE,USER_ID)
-- ɾ��ΨһԼ����
-- ��ʽ��ALTER TABLE ���� DROP CONSTRAINT ��Ҫɾ����ΨһԼ��
ALTER TABLE T_USER DROP CONSTRAINT UN_USER_TEL;
-- һ������֧����Ӷ��ΨһԼ����
ALTER TABLE T_USER ADD CONSTRAINT UN_USER_ID UNIQUE (USER_ID);

-- ���Լ�� CHECK
-- �ص㣺����������Լ��ָ���ֶ��µ�����
-- ˼�룺���Ǹ���ָ��������Լ��ָ���ֶ��µ����ݲ��ܳ�������֮���ֵ
-- ��ʽ��ALTER TABLE ���� ADD CONSTRAINT ���� CHECH (Լ��ָ���ֶε�����)
ALTER TABLE T_USER ADD CONSTRAINT CK_USER_SEX CHECK (USER_SEX = 'Ů' OR USER_SEX = '��');
-- -- һ������֧����Ӷ�����Լ��
ALTER TABLE T_USER ADD CONSTRAINT CK_USER_SEXNULL CHECK (USER_SEX IS NOT NULL);
ALTER TABLE T_USER ADD CONSTRAINT CK_USER_AGE CHECK (
      USER_AGE >=0 AND USER_AGE <=200
)
-- ɾ�����Լ��
-- ��ʽ��ALTER TABLE ���� DROP CONSTRAINT ��Ҫɾ���ļ��Լ��
ALTER TABLE T_USER DROP CONSTRAINT CK_USER_SEX;
-- �������Υ���˼��Լ�����Ա���Ϊ�յ�����������
INSERT INTO T_USER(USER_ID,USER_SEX) VALUES(0,NULL);
-- �������Υ���˼��Լ�������䲻�ܴ���200������������
INSERT INTO T_USER(USER_AGE) VALUES(2000);
ALTER TABLE T_USER ADD(USER_AGE NUMBER(10));
SELECT * FROM T_USER;
DELETE FROM T_USER WHERE USER_ID = 2;


-- ����һ���ɼ����ӱ�
CREATE TABLE ORACLE_SCORE(
       STU_ID NUMBER(10),
       STU_SCORE NUMBER(3)
)
CREATE TABLE ORACLE_SCORE(
       USER_ID NUMBER(10),
       SCORE   NUMBER(3)
);

-- ���Լ�� FOREIGN KEY
-- �ص㣺�����ӹ�ϵ�����Լ�������ڴӱ������
-- ˼�룺Ҫ���������ҵ�Լ�������Ĺ����ֶδ��ڣ��ſ��Խ����ݲ���ӱ��У�
-- ��ɾ�������еĹ������ֶ�����ʱ������ֱ��ɾ�����������ON DELETE CASCADE ���� ON DELETE SET NULL��ɾ��
-- ��ֱ��ɾ���ӱ��еĹ����ֶ������ǿ���ɾ����
-- ֻ��ͨ������ɾ���ӱ����ݣ�����ͨ���ӱ�ɾ����������
-- ��ʽ��ALTER TABLE �ӱ��� ADD CONSTRAINT ����� FOREIGN KEY(Ҫ�����Ĵӱ��ֶ�) REFERENCES ������(Ҫ�����������ֶ�)
ALTER TABLE ORACLE_SCORE ADD CONSTRAINT  FK_ORSR_ID FOREIGN KEY(USER_ID) REFERENCES T_USER(USER_ID)
-- ON DELETE CASCADE;-- ON DELETE CASCADE:��ɾ�������е�һ������ʱ���ӱ��ж�Ӧ������Ҳ�ᱻɾ��
ON DELETE SET NULL; -- ON DELETE SET NULL����ɾ�������е�һ������ʱ���ӱ��Ӧ���ֶ����ݱ�ɿ�NULL��ɾ������ʱ���ӱ���������Ϊnull��
DROP TABLE ORACLE_SCORE
-- �ҵ��˷������Լ���Ĺ����ֶΣ����Բ������ݵ��ӱ���
INSERT INTO ORACLE_SCORE(USER_ID,SCORE) VALUES(5,100);
-- �������������û���ҵ������ֶεĴ��ڣ�����Υ�������Լ�������������� 
INSERT INTO ORACLE_SCORE(USER_ID,SCORE) VALUES(6,90);

-- Ҳ�����ڴ������ʱ�����Լ�����൱������ֶ�һ��
CREATE TABLE ORACLE_SCORE(
       USER_ID NUMBER(10),
       SCORE   NUMBER(3),
       CONSTRAINT  FK_ORSR_ID 
       FOREIGN KEY(USER_ID) REFERENCES T_USER(USER_ID),
       CONSTRAINT CK_ORSE_SCORE CHECK (SCORE<=100 AND SCORE>=0)
);
-- ֱ������ɾ�������е�һ���������ݣ��ǲ���ɾ���ģ�Υ�������Լ��������
-- ������ON DELETE CASCADE �� ON DELETE SET NULL ���ﵽɾ��
DELETE FROM T_USER WHERE USER_ID = '5';
-- ��ֱ��ɾ���ӱ��еĹ����ֶ������ǿ���ɾ����
-- ֻ��ͨ������ɾ���ӱ����ݣ�����ͨ���ӱ�ɾ����������
DELETE FROM ORACLE_SCORE WHERE USER_ID = '5'
-- �޸�Լ������
-- ��ʽ��ALTER TABLE ���� RENAME CONSTRAINT ��Լ���� TO ��Լ����
ALTER TABLE ORACLE_SCORE RENAME CONSTRAINT FK_ORSR_ID TO FK_ID
SELECT * FROM T_USER
SELECT * FROM ORACLE_SCORE
UPDATE T_USER SET USER_ID = 2 WHERE USER_ID = 5; 
-- DDL��䣺DROP TABLE��TRUNCATE TABLE����������Υ������������Լ��
DROP TABLE T_USER;
ROLLBACK;


