--Merger (���̺� ����)

/*
UPDATE, INSERT �� �ѹ濡 ó��
�� ���̺� �ش��ϴ� �����Ͱ� �ִٸ� update��,
������ insert�� ó���ض�
*/

CREATE TABLE emps_it AS (SELECT * FROM employees WHERE 1=2);

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES 
    (106, '�����', 'Ŵ', 'CHOONSIK', sysdate, 'IT_PROG');
    
    SELECT * FROM emps_it;
    
SELECT * FROM employees
WHERE job_id = 'IT_PROG';

MERGE INTO emps_it a --(������ �� Ÿ�� ���̺�)
    USING --���ս�ų ������ 
        (SELECT * FROM employees
            WHERE job_id = 'IT_PROG') b --�����ϰ��� �ϴ� �����͸� ���������� ǥ��.
    ON --���ս�ų �������� ���� ����
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN --������ ��ġ�ϴ� ��쿡�� Ÿ�����̺� �̷��� �����϶�
    UPDATE SET
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
        
         /*
        DELETE�� �ܵ����� �� ���� �����ϴ�.
        UPDATE ���Ŀ� DELETE �ۼ��� �����մϴ�.
        UPDATE �� ����� DELETE �ϵ��� ����Ǿ� �ֱ� ������
        ������ ��� �÷����� ������ ������ �ϴ� UPDATE�� �����ϰ�
        DELETE�� WHERE���� �Ʊ� ������ ������ ���� �����ؼ� �����մϴ�.
        */
        
        DELETE
            WHERE a.employee_id = b.employee_id
            --id�� ������ �����
            
        
WHEN NOT MATCHED THEN
    INSERT /*�Ӽ�(�÷�)*/VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
    

------------------------------------------------------

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '����', '��', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '�ϳ�', '��', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '���', '��', 'HMSON', '20/04/06', 'AD_VP');

SELECT * FROM emps_it;
/*
employees ���̺��� �Ź� ����ϰ� �����Ǵ� ���̺��̶�� ��������.
������ �����ʹ� email, phone, salary, comm_pct, man_id, dept_id��
������Ʈ �ϵ��� ó��
���� ���Ե� �����ʹ� �״�� �߰�.
*/

MERGE INTO emps_it a
    USING 
        (SELECT * FROM employees) b
    ON 
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN 
    UPDATE SET --�����ϱ� 
        a.email = b.email,
        a.phone_number = b.phone_number,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
        
WHEN NOT MATCHED THEN
    INSERT VALUES --�����ض� 
        (b.employee_id, b.first_name, b.last_name,
         b.email, b.phone_number, b.hire_date, b.job_id,
        b.salary, b.commission_pct, b.manager_id, b.department_id);

SELECT * FROM emps_it
ORDER BY employee_id ;

ROLLBACK;



---------------------------------------------------------
CREATE TABLE DEPTS AS (SELECT * FROM departments WHERE 1=2);

SELECT * FROM DEPTS;

--���� 1
INSERT INTO DEPTS
    (department_id, department_name, manager_id, location_id)
VALUES 
    (310, '�λ�',  null, 1800);

INSERT INTO DEPTS
(SELECT * FROM departments);

INSERT INTO emps
(SELECT * FROM employees);
--���� 2
2-(1)
UPDATE DEPTS SET department_name = 'IT_bank'
WHERE department_name ='IT Support';

--2-2
UPDATE DEPTS SET manager_id = 301
WHERE department_id = 290;

--2-3
UPDATE DEPTS SET department_name = 'IT_Help'
WHERE department_name = 'IT Helpdesk';

UPDATE DEPTS SET manager_id = 303
WHERE department_name = 'IT_Help';

UPDATE DEPTS SET location_id = 1800
WHERE department_name = 'IT_Help';


--2-4
UPDATE DEPTS
SET manager_id = 301
WHERE department_id IN(SELECT department_id
                        FROM DEPTS
                        WHERE department_name IN('����', 'ȸ���', '����', '�λ�', '����'));
--���� 3��
SELECT * FROM DEPTS;
DELETE FROM DEPTS
WHERE department_id = 320;

--3-2
DELETE FROM DEPTS
WHERE department_name = 'NOC';
--�ٸ� ���
DELETE FROM DEPTS
WHERE department_id = (SELECT department_id 
                        FROM DEPTS
                        WHERE department_name = 'NOC')
--4
DELETE FROM DEPTS
WHERE department_id > 200;

--4-2
UPDATE DEPTS SET manager_id = 100
WHERE manager_id is not null;


--4-4
MERGE INTO DEPTS a
    USING 
        (SELECT * FROM departments)b
    ON 
        (a.department_id = b.department_id)
WHEN MATCHED THEN 
    UPDATE SET --�����ϱ� 
        a.department_name = b.department_name,
        a.manager_id = b.manager_id,
        a.location_id = b.location_id
       
        
WHEN NOT MATCHED THEN
    INSERT VALUES --�����ض� 
        (b.department_id, b.department_name, b.manager_id,
         b.location_id);

--���� 5
CREATE TABLE jobs_it AS (SELECT * FROM jobs 
                            WHERE min_salary >6000);

--5-2
SELECT * FROM jobs_it;
INSERT INTO jobs_it
    (job_id, job_title, min_salary, max_salary)
VALUES 
    ('SEC_DEV', '���Ȱ�����', 6000, 19000);
    
    --5-4
   MERGE INTO jobs_it a
    USING 
        (SELECT * FROM jobs 
        WHERE min_salary>5000) b
    ON 
        (a.job_id = b.job_id)--������ ���Ǹ� ���� �Ѵ�. 
WHEN MATCHED THEN 
    UPDATE SET --�����ϱ� 
        a.min_salary = b.min_salary,
        a.max_salary = b.max_salary
        
    
WHEN NOT MATCHED THEN
    INSERT VALUES --�����ض� 
        (b.job_id, b.job_title, b.min_salary,
         b.max_salary);
 SELECT * FROM jobs_it;
    
    