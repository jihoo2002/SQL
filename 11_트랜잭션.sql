--����Ŀ�� Ȱ��ȭ ���� Ȯ��
SHOW AUTOCOMMIT;
--����Ŀ�� ��
SET AUTOCOMMIT ON;
--����Ŀ�� ����
SET AUTOCOMMIT OFF;

SELECT * FROM emps;

DELETE FROM emps WHERE employee_id = 304;
INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (304, 'lee', 'lee1234@gmail.com', sysdate, 1800);
    
--�������� ��� ������ ��������� ���(���)
--���� Ŀ�� �ܰ�� ȸ�� (����) �� Ʈ����� ����
ROLLBACK;
--���̺� ����Ʈ ����
--�ѹ��� ����Ʈ�� ���� �̸��� �ٿ��� ����.
--ANSIǥ�� ������ �ƴϱ� ������ �׷��� �������� ����
SAVEPOINT insert_park;
INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (306, 'kim', 'kim1234@gmail.com', sysdate, 1800);
    
ROLLBACK TO SAVEPOINT insert_park; --�� KIM������ ����

--�������� ��� ������ ��������� ���������� �����ϸ鼭 Ʈ����� ����
--Ŀ�� �Ŀ��� ��� ����� ����ϴ��� �ǵ��� �� �����ϴ�.
COMMIT; --Ȯ������ ����

















