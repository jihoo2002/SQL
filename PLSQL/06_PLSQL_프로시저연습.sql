/*
���ν����� divisor_proc
���� �ϳ��� ���޹޾� �ش� ���� ����� ������ ����ϴ� ���ν����� �����մϴ�.
*/
CREATE OR REPLACE PROCEDURE divisor_proc
(p_num IN NUMBER)
IS
    p_cnt NUMBER := 0;
BEGIN
DECLARE
     v_count NUMBER := 1;
BEGIN
   WHILE v_count <= p_num
   
   LOOP
    v_count := v_count+1;
    IF MOD(p_num, v_count) =0 THEN 
    p_cnt := p_cnt+ 1;
    END LOOP;
     dbms_output.put_line(p_cnt);
    
END;
EXEC divisor_proc(5);
/*
�μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
depts ���̺� 
���� INSERT, UPDATE, DELETE �ϴ� depts_proc �� �̸��� ���ν����� ������.
�׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
*/
CREATE OR REPLACE PROCEDURE depts_proc
    (
    p_department_id IN depts.department_id%TYPE,
    p_department_name IN depts.department_name%TYPE,
    p_flag IN VARCHAR2
    )
IS
    v_cnt NUMBER := 0;
BEGIN

    SELECT COUNT(*)
    INTO v_cnt
    FROM depts
    WHERE department_id = p_department_id;
    
    IF p_flag = 'I' THEN
        INSERT INTO depts
        (department_id, department_name)
        VALUES(p_department_id, p_department_name);
    ELSIF p_flag = 'U' THEN
        UPDATE depts
        SET department_name = p_department_name
        WHERE department_id = p_department_id;
    ELSIF p_flag = 'D' THEN
        IF v_cnt = 0 THEN
            dbms_output.put_line('�����ϰ��� �ϴ� �μ��� �������� �ʽ��ϴ�.');
            RETURN;
        END IF;
        
        DELETE FROM depts
        WHERE department_id = p_department_id;
    ELSE
        dbms_output.put_line('�ش� flag�� ���� ������ �غ���� �ʾҽ��ϴ�.');
    END IF;
    
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('���ܰ� �߻��߽��ϴ�.');
        dbms_output.put_line('ERROR MSG: ' || SQLERRM);
        ROLLBACK;

END;

EXEC depts_proc (270, '������', 'U');

SELECT * FROM depts;
/*
employee_id�� �Է¹޾� employees�� �����ϸ�,
�ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. (�͸��Ͽ��� ���ν����� ����)
���ٸ� exceptionó���ϼ���
*/
CREATE OR REPLACE PROCEDURE my_employ
(
 p_employee_id IN employees.employee_id%TYPE,
 p_result OUT VARCHAR2
)
IS
 v_cnt NUMBER := 0;
  v_result VARCHAR2(100) := '�������� �ʴ� ���̿���';
BEGIN
    SELECT
    COUNT(*)
    INTO v_cnt
    FROM employees
    WHERE employee_id = p_employee_id;
    
--    IF v_cnt = 0 THEN
--     EXCEPTION WHEN OTHERS THEN
--        dbms_output.put_line('���ܰ� �߻��߽��ϴ�.');
--    END IF;
  IF v_cnt = 1 THEN  
    SELECT
       '�ټӳ��:' || ROUND((sysdate- hire_date)/365,0)||'��'
    INTO v_result
    FROM employees
    WHERE employee_id = p_employee_id;
     p_result := v_result;
    END IF;
END; 

DECLARE
    msg VARCHAR2(100);
BEGIN
    my_employ(100,msg);
    dbms_output.put_line(msg);
END;

SELECT employee_id FROM dual;
/*
���ν����� - new_emp_proc
employees ���̺��� ���� ���̺� emps�� �����մϴ�.
employee_id, last_name, email, hire_date, job_id�� �Է¹޾�
�����ϸ� �̸�, �̸���, �Ի���, ������ update, 
���ٸ� insert�ϴ� merge���� �ۼ��ϼ���

������ �� Ÿ�� ���̺� -> emps
���ս�ų ������ -> ���ν����� ���޹��� employee_id�� dual�� select ������ ��.
���ν����� ���޹޾ƾ� �� ��: ���, last_name, email, hire_date, job_id
*/
CREATE OR REPLACE PROCEDURE new_emp_proc 
(p_employee_id IN employees.employee_id%TYPE,
 p_last_name IN employees.last_name%TYPE,
 p_email IN employees.email%TYPE,
 p_hire_date IN employees.hire_date%TYPE,
 p_job_id IN employees.job_id%TYPE)
 
 IS
 BEGIN
    MERGE INTO emps a --(������ �� Ÿ�� ���̺�)
    USING --���ս�ų ������ 
        (SELECT * FROM employees
        WHERE ) b --�����ϰ��� �ϴ� �����͸� ���������� ǥ��.
    ON --���ս�ų �������� ���� ����
        (a.p_employee_id = b.employee_id)
WHEN MATCHED THEN --������ ��ġ�ϴ� ��쿡�� Ÿ�����̺� �̷��� �����϶�
   UPDATE 
    SET last_name = p_last_name,
        email = p_email,
        hire_date = p_hire_date,
        job_id = p_job_id
       
    WHEN NOT MATCHED THEN
    INSERT /*�Ӽ�(�÷�)*/VALUES
    (b.employee_id,  b.last_name,
    b.email,  b.hire_date, b.job_id);

    
 END;
 
 
    new_emp_proc (208,'�����', 'dljslfkj', '2023/10/04', 'AD VP');
   
SELECT * FROM emps;
 
 
 
 
 
    