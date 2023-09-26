
 --�׷� �Լ� AVG, MAX, MIN , SUM, COUNT
 
 SELECT
    AVG(salary),
    MAX(salary),
    MIN(salary),
    SUM(salary),
    COUNT(salary)
 FROM employees;
 
SELECT COUNT(*) FROM employees; --�� �� ������ ��
SELECT COUNT(first_name) FROM employees;
SELECT COUNT(commission_pct) FROM employees;--null�� �ƴ� ���� ��
SELECT COUNT(manager_id) FROM employees; --null�� �ƴ� ���� ��
 
 --�μ����� �׷�ȭ, �׷��Լ��� ���
 SELECT
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id; --�μ��� ��� 

/*��������
�׷� �Լ��� �Ϲ� Į���� ���ÿ� �׳� ����� �� �����ϴ�.
*/
 SELECT
    department_id,
    AVG(salary)
 FROM employees; --����

--GROUP BY���� ����� �� group���� ������ ������ �ٸ� �÷� ��ȸ �Ұ���
  SELECT
    job_id,
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id; --���� | ��� �׷�ȭ �Ǿ�� ��
 
 --GROUP BY���� 2�� �̻� ���
SELECT
    job_id,
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id ;
 
 --GROUP BY �� ���� �׷�ȭ�Ҷ� ������ �� ���  having �� ���
 
SELECT
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary)>100000; --�׷��� ���� 

SELECT
    job_id,
    count(*)
FROM employees
GROUP BY job_id 
HAVING count(*) >= 5;

--�μ� ���̵� 50�̻��ΰ͵��� �׷�ȭ��Ű��, �׷� ���� ����� 5000�̻� ��ȸ
SELECT
    department_id,
    AVG(salary) as ���
FROM employees
WHERE department_id >=50
GROUP BY department_id
HAVING AVG(salary) >=5000
ORDER BY department_id DESC;
--FROM- WHERE- GROUPBY- HAVING-SELECT- ORDER BY
 
/*
���� 1.
��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���.
*/
SELECT
    job_id,
    count(*) AS �����
FROM employees
GROUP BY job_id;

SELECT
    job_id,
    avg(salary) AS ��տ���
FROM employees
GROUP BY job_id
ORDER BY avg(salary) DESC;
/*
���� 2.
��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
(TO_CHAR() �Լ��� ����ؼ� ������ ��ȯ�մϴ�. �׸��� �װ��� �׷�ȭ �մϴ�.)
*/
 SELECT
count(*) AS �����,
to_char(hire_date, 'YYYY') AS �Ի�⵵
FROM employees
GROUP BY to_char(hire_date, 'YYYY')
ORDER BY �Ի�⵵ ASC;
 
/*
���� 3.
�޿��� 5000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. 
�� �μ� ��� �޿��� 7000�̻��� �μ��� ����ϼ���.
*/
SELECT
    department_id,
    avg(salary)
FROM employees
WHERE salary >=5000
GROUP BY department_id
HAVING avg(salary) >= 7000;


/*
���� 4.
��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.
*/

 SELECT
    department_id AS �μ���,
    TRUNC(avg(salary+(salary*commission_pct)), 2) AS ���,
    sum(salary+(salary*commission_pct)) AS �հ�,
    count(*)
 FROM employees
 where commission_pct is not null
 GROUP BY department_id;
 