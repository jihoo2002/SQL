/*
# �������� 
:SQL ���� �ȿ� �� �ٸ� SQL�� �����ϴ� ���,
���� ���� ���Ǹ� ���ÿ� ó���� �� �ֽ��ϴ�.
WHERE, SELECT, FROM ���� �ۼ� ����
- ���������� ������� () �ȿ� �����.
 ������������ �������� 1�� ���Ͽ��� �մϴ�.
- �������� ������ ���� ����� �ϳ� �ݵ�� ���� �մϴ�.
- �ؼ��� ���� ���������� ���� ���� �ؼ��ϸ� �˴ϴ�.
*/
            
--'Nancy'�� �޿����� �޿��� ���� ����� �˻��ϴ� ����
SELECT first_name FROM employees
WHERE salary >(SELECT salary from employees
            WHERE first_name = 'Nancy');

--employee_id�� 103���� ����� job_id�� 
--������ job_id�� ���� ��� ��ȸ
SELECT * FROM employees
WHERE job_id = (SELECT job_id FROM employees
                WHERE employee_id = 103 );
--���� ������ ���������� �����ϴ� ���� �������� ������ �����ڸ�
--����� �� �����ϴ�.
--���� �� ������ : �ַ� �� ������(=, >, <, >=,<= <>)�� ����ϴ� ���
--�ϳ��� �ุ ��ȯ�ؾ� �մϴ�. 
--�̷� ��쿡�� ���� �� �����ڸ� ����ؾ� �մϴ�.
SELECT * FROM employees
WHERE job_id = (SELECT job_id FROM employees
                WHERE job_id = 'IT_PROG'); --5���� id�� ����(����)

--���� �� ������ (IN, ANY, ALL)
--IN : ��ȸ�� ����� � ���� ���� ���� Ȯ���մϴ�. 
SELECT * FROM employees
WHERE job_id IN (SELECT job_id FROM employees
                WHERE job_id = 'IT_PROG');

--first_name �� David�� ������� �޿��� 
--���� �޿��� ���� �޴� ����� ��ȸ

SELECT * FROM employees
WHERE salary IN(SELECT salary FROM employees
                WHERE first_name = 'David'); 
--David��� �̸��� ���� ������� ���� �� �ϳ��� ���ٸ� ���