SELECT * FROM employees;

--where�� ��(������ ���� ��/�ҹ��ڸ� �����մϴ�.)
SELECT first_name, last_name, job_id
FROM employees
WHERE job_id = 'IT_PROG';

SELECT * FROM employees
WHERE last_name = 'King';

SELECT *
FROM employees
WHERE department_id = 90; --���ڴ� Ȭ����ǥ �� �ʿ� x

SELECT * 
FROM employees
WHERE salary >=15000 
AND salary <20000;

SELECT * FROM employees
WHERE hire_date = '04/01/30';

--������ �� ����
SELECT *
FROM employees
WHERE salary BETWEEN 15000 AND 20000;

SELECT *
FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

--IN �������� ��� (Ư�� ����� ���� �� ��� OR�� ���)
SELECT *
FROM employees
WHERE manager_id IN (100, 101, 102); --�� �� �ϳ��� ���ԵǸ� ���

SELECT *
FROM employees
WHERE job_id IN ('IT_PROG', 'AD_VP');

--LIKE ������
--% �� ��� ���ڵ�, _�� �������� �ڸ�(��ġ)�� ã�Ƴ���
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '03%'; --%�ڿ� ��� ���� �͵� ������� 03���� �����ϸ� ���

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '%15';

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '%05%'; --�� �� � ���ڰ� ���� 05 �����ϸ� ��ȸ�ض�
--LIKE�� ��ġ �� ���� �� �����ϰ� ���

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '___05%'; --�� ������ �ǳʶٰ�

--AND, OR
--AND�� OR���� ���� ������ ����.
SELECT * FROM employees
WHERE job_id = 'IT_PROG'
OR job_id = 'FI_MGR'
AND salary >= 6000;

SELECT * FROM employees
WHERE (job_id = 'IT_PROG'
OR job_id = 'FI_MGR') -- () ���� ����
AND salary >= 6000;

--�������� ����(SELECT ������ ���� �������� ��ġ�˴ϴ�.)
--ASC : asscending ��������
--DESC : descending ��������
SELECT *
FROM employees
ORDER BY hire_date ASC; -- hire_date�� �������� �������� ����
--��� ASC�� �⺻��

SELECT *
FROM employees
ORDER BY hire_date DESC;

SELECT * 
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name ASC;

SELECT *
FROM employees --�÷�
WHERE salary >= 5000 -- ����
ORDER BY employee_id DESC;

SELECT 
    first_name,
    salary*12 AS pay
    FROM employees
    ORDER BY pay ASC;






