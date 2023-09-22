--���� ������
--���� �ٸ� ���� ����� ����� �ϳ��� ����, ��, ���̸�
--  ���� �� �ְ� ���ִ� ������
--UNION(������ �ߺ� X,) UNION ALL(������ �ߺ� o),
--INTERSECT(������), MINUS(������)
--�� �Ʒ� �÷� ������ ������ Ÿ���� ��Ȯ�� ��ġ�ؾ���

SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION 
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20;

--�ߺ� �� ����(UNION ALL)
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION ALL
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20; 


--INTERSECT(������)
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
INTERSECT
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20; 

--  A-B������
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
MINUS
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20;

--   b-a ������
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20
MINUS
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%';













