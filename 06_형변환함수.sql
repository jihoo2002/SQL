--����ȯ �Լ� TO_CHAR, TO_NUMBER, TO_DATE

--��¥�� ���ڷ� TO_CHAR(��, ����)
SELECT TO_CHAR(sysdate) 
FROM dual;


SELECT TO_CHAR(sysdate, 'YY-MM-DD HH24:MI:SS') 
FROM dual; --HH24-> 24�ð����� ǥ���ϰڴ�

-- ���Ĺ��ڿ� �Բ� ����ϰ� ���� ���ڸ� ""�� ���� ����
SELECT
    first_name, 
    TO_CHAR(hire_date, 'YYYY"��" MM"��" DD"��"')
FROM employees;  --���Ĺ��ڰ� �ƴϴϱ� ""�� ����

--���ڸ� ���ڷ� TO_CHAT (��, ����)
--���Ŀ��� ����ϴ� '9'�� ���� ���� 9�� �ƴ϶�
--�ڸ����� ǥ���ϱ� ���� ��ȣ�Դϴ�. 
SELECT 
    TO_CHAR(20000, '99999')
FROM dual;--�ټ��ڸ��� ǥ��
--�־��� �ڸ����� ���ڸ� ��� ǥ���� �� ��� #���� ǥ��
SELECT 
    TO_CHAR(20000, '9999')
FROM dual;

SELECT 
    TO_CHAR(20000.29, '99999.9')
FROM dual;--�ݿø� ����

SELECT 
    TO_CHAR(20000, '99,999')
FROM dual;

SELECT
    TO_CHAR(salary, 'L99,999') AS salary
FROM employees; --L�� �������� ǥ�����ش�. 

--���ڸ� ���ڷ� TO_NUMBER(��, ����)
SELECT '2000' + 2000 --�ڵ� ����ȯ (���� -> ����) 
FROM dual;


SELECT TO_NUMBER('2000') + 2000
FROM dual; --����� ����ȯ (���� �̷��� �ؾ���)

SELECT '$3,300' + 2000
FROM dual; --����

SELECT TO_NUMBER('$3,300', '$9,999') +2000
FROM dual;--������ ������ �ƴ� ���ڴ� TO_NUMBER ����ؾ���

--���ڸ� ��¥�� ��ȯ�ϴ� �Լ� TO_DATE(��, ����)
SELECT TO_DATE('2023-04-13')
FROM dual;

SELECT sysdate - TO_DATE('2021-03-26')
FROM dual;

SELECT TO_DATE('2020/12/25', 'YY-MM-DD')
FROM dual;

--�־��� ���ڿ��� ��� ��ȯ�ؾ��Ѵ�!(������ �Ȱ��� �ؾ� ���� �ȳ�)
SELECT TO_DATE('2021-03-31 12:23:50', 'YY-MM-DD HH:MI:SS') 
FROM dual;


SELECT
TO_CHAR(TO_DATE('20050102', 'YYYYMMDD'),'YYYY"��" MM"��" DD"��"') AS dateInfo
FROM dual;

--null ���¸� ��ȯ�ϴ� �Լ� NVL(�÷�, ��ȯ�� Ÿ�ٰ�)
SELECT NULL FROM dual;
SELECT NVL(NULL, 0) FROM dual; 

SELECT
    first_name,
    NVL(commission_pct, 0) AS comm_pct
FROM employees;

--NULL ��ȯ �Լ� NVL2(�÷�, NULL�� �ƴ� ����� ��, NULL�� ����� ��)
SELECT
    NVL2(null,'�ξƴ�' , '����')
FROM dual;

SELECT
    first_name,
    NVL2(commission_pct, 'true', 'false')
FROM employees;

SELECT
    first_name,
    commission_pct,
    salary,
    NVL2(commission_pct, salary+ (salary *commission_pct)
    ,salary )AS real_salary --NULL�� �ƴϸ� ���ʽ� ��
FROM employees;

--null�� ����ȵ�
SELECT
    first_name,
    salary,
    salary+ (salary *commission_pct)
FROM employees;

--DECODE(�÷� Ȥ�� ǥ����, �׸�1, ���1, �׸�2, ���2 ......defalut)
SELECT
    DECODE('A', 'A', 'A�Դϴ�.' ,'B', 'B�Դϴ�.', 'C', 'C�Դϴ�. ','�����װ�!')
FROM dual;

SELECT
    job_id,
    salary,
    DECODE(
        job_id,
        'IT_PROG', salary*1.1,
        'FI_MGR', salary*1.2,
        'AD_VP', salary*1.3,
        salary -->defalut
    ) as result
FROM employees;

--case when then end
SELECT
    first_name,
    job_id,
    salary,
    (CASE job_id
        WHEN 'IT_PROG' THEN salary*1.1
        WHEN 'FI_MGR' THEN salary*1.2
        WHEN 'AD_VP' THEN salary*1.3
        WHEN 'FI_ACCOUNT' THEN salary*1.4
        ELSE salary -->defalut��
        END) AS result
FROM employees;

/*
���� 1.
�������ڸ� �������� employees���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 17�� �̻���
����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������. 
���� 1) �ټӳ���� ���� ��� ������� ����� �������� �մϴ�
*/
SELECT
    first_name,
     TO_NUMBER(ROUND((sysdate- hire_date)/365))as year
FROM employees
WHERE (sysdate- hire_date)/365>=17
ORDER BY year DESC;



/*
���� 2.
EMPLOYEES ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
100�̶�� �������, 
120�̶�� �����ӡ�
121�̶�� ���븮��
122��� �����塯
�������� ���ӿ��� ���� ����մϴ�.
���� 1) department_id�� 50�� ������� ������θ� ��ȸ�մϴ�
*/
SELECT
    first_name,
    manager_id,
    DECODE (
        manager_id,
        100, '���',
        120, '����',
        121, '�븮',
        122, '����',
        '�ӿ�'
        )as ����
FROM employees
WHERE department_id =50;

SELECT
    first_name,
    manager_id,
 (CASE manager_id
        WHEN 100 THEN '���'
        WHEN 120 THEN '����'
        WHEN 121 THEN '�븮'
        WHEN 122 THEN '����'
        ELSE '�ӿ�' 
        END) AS ����
FROM employees
WHERE department_id =50;