/*
���� 1.
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� 
(AVG(�÷�) ���)
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
-EMPLOYEES ���̺��� job_id�� IT_PROG�� ������� ��ձ޿����� ���� ������� 
�����͸� ����ϼ���
*/

SELECT *
FROM employees 
WHERE salary > (SELECT avg(salary)
                FROM employees);
                
SELECT COUNT(*) AS �����
FROM employees 
WHERE salary > (SELECT avg(salary)
                FROM employees);
                
SELECT *
FROM employees
WHERE salary > all (SELECT avg(salary)
                FROM employees
                WHERE job_id = 'IT_PROG' );
/*
���� 2.
-DEPARTMENTS���̺��� manager_id�� 100�� ������� ��� ������ ���
EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
*/
SELECT *
FROM employees
WHERE department_id = (SELECT department_id
                         FROM departments  
                        WHERE manager_id = 100);

/*
���� 3.
-EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� 
����ϼ���
-EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
*/
SELECT *
FROM employees
WHERE manager_id >ALL (SELECT manager_id
            FROM employees
            WHERE first_name = 'Pat'); 
SELECT *
FROM employees
WHERE manager_id in(SELECT manager_id
                    FROM employees
                    WHERE first_name = 'James');
/*
���� 4.
-EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� 
�� ��ȣ, �̸��� ����ϼ���
*/
SELECT *
FROM(
        SELECT ROWNUM AS rn , tal.*
        FROM(
            SELECT first_name
            FROM employees
            ORDER BY first_name DESC
    )tal
)
WHERE rn BETWEEN 41 AND 50;
/*
���� 5.
-EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� 
�� ��ȣ, ���id, �̸�, ��ȣ, �Ի����� ����ϼ���.
*/
SELECT *
FROM (
SELECT ROWNUM as rn,tal.* 
FROM (
    SELECT employee_id, first_name, phone_number, hire_date
    FROM employees
    ORDER BY hire_date 
    )tal
   )
WHERE rn > 30 AND rn<=40;

/*
���� 6.
employees���̺� departments���̺��� left �����ϼ���
����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
����) �������̵� ���� �������� ����
*/
SELECT
    employee_id,
    e.first_name || ' ' ||e.last_name as fullname,
    d.department_id,
    d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY employee_id ;
/*
���� 7.
���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT
     e.employee_id,
    e.first_name || ' ' ||e.last_name as fullname,
     e.department_id,
     (
     SELECT 
        d.department_name
     FROM departments d
     WHERE e.department_id = d.department_id
     ) as department_name
FROM employees e
ORDER BY e.employee_id ;

/*
���� 8.
departments���̺� locations���̺��� left �����ϼ���
����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
����) �μ����̵� ���� �������� ����
*/
SELECT
    d.department_id, d.department_name, d.manager_id, 
    loc.location_id, loc.street_address, loc.postal_code, loc.city
FROM departments d
LEFT JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY d.department_id ;

/*
���� 9.
���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT
    d.department_id,
    d.department_name,
    d.manager_id,
    d.location_id,
    (SELECT 
        loc.street_address
         FROM locations loc
         WHERE d.location_id = loc.location_id
        ) as street_address,
        
    (SELECT 
        loc.postal_code
         FROM locations loc
         WHERE d.location_id = loc.location_id
        ) as postal_code,
    
    (SELECT 
      loc.city
    FROM locations loc
    WHERE d.location_id = loc.location_id
    ) as city
FROM departments d
ORDER BY d.department_id ;
/*
���� 10.
locations���̺� countries ���̺��� left �����ϼ���
����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
����) country_name���� �������� ����
*/
SELECT
    loc.location_id, loc.street_address, loc.city,
    co.country_id,
    co.country_name
FROM locations loc
LEFT JOIN countries co
ON loc.country_id = co.country_id
ORDER BY co.country_name ;
/*
���� 11.
���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT
 loc.location_id, loc.street_address, loc.city, loc.country_id,
 (SELECT
    co.country_name
 FROM countries co
 WHERE loc.country_id = co.country_id ) AS COUNTRY_NAME
FROM locations loc
ORDER BY country_name ;
 
    