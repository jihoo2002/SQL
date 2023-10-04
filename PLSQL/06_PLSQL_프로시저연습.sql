/*
프로시저명 divisor_proc
숫자 하나를 전달받아 해당 값의 약수의 개수를 출력하는 프로시저를 선언합니다.
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
부서번호, 부서명, 작업 flag(I: insert, U:update, D:delete)을 매개변수로 받아 
depts 테이블에 
각각 INSERT, UPDATE, DELETE 하는 depts_proc 란 이름의 프로시저를 만들어보자.
그리고 정상종료라면 commit, 예외라면 롤백 처리하도록 처리하세요.
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
            dbms_output.put_line('삭제하고자 하는 부서가 존재하지 않습니다.');
            RETURN;
        END IF;
        
        DELETE FROM depts
        WHERE department_id = p_department_id;
    ELSE
        dbms_output.put_line('해당 flag에 대한 동작이 준비되지 않았습니다.');
    END IF;
    
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('예외가 발생했습니다.');
        dbms_output.put_line('ERROR MSG: ' || SQLERRM);
        ROLLBACK;

END;

EXEC depts_proc (270, '오락부', 'U');

SELECT * FROM depts;
/*
employee_id를 입력받아 employees에 존재하면,
근속년수를 out하는 프로시저를 작성하세요. (익명블록에서 프로시저를 실행)
없다면 exception처리하세요
*/
CREATE OR REPLACE PROCEDURE my_employ
(
 p_employee_id IN employees.employee_id%TYPE,
 p_result OUT VARCHAR2
)
IS
 v_cnt NUMBER := 0;
  v_result VARCHAR2(100) := '존재하지 않는 값이에요';
BEGIN
    SELECT
    COUNT(*)
    INTO v_cnt
    FROM employees
    WHERE employee_id = p_employee_id;
    
--    IF v_cnt = 0 THEN
--     EXCEPTION WHEN OTHERS THEN
--        dbms_output.put_line('예외가 발생했습니다.');
--    END IF;
  IF v_cnt = 1 THEN  
    SELECT
       '근속년수:' || ROUND((sysdate- hire_date)/365,0)||'년'
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
프로시저명 - new_emp_proc
employees 테이블의 복사 테이블 emps를 생성합니다.
employee_id, last_name, email, hire_date, job_id를 입력받아
존재하면 이름, 이메일, 입사일, 직업을 update, 
없다면 insert하는 merge문을 작성하세요

머지를 할 타겟 테이블 -> emps
병합시킬 데이터 -> 프로시저로 전달받은 employee_id를 dual에 select 때려서 비교.
프로시저가 전달받아야 할 값: 사번, last_name, email, hire_date, job_id
*/
CREATE OR REPLACE PROCEDURE new_emp_proc 
(p_employee_id IN employees.employee_id%TYPE,
 p_last_name IN employees.last_name%TYPE,
 p_email IN employees.email%TYPE,
 p_hire_date IN employees.hire_date%TYPE,
 p_job_id IN employees.job_id%TYPE)
 
 IS
 BEGIN
    MERGE INTO emps a --(머지를 할 타켓 테이블)
    USING --병합시킬 데이터 
        (SELECT * FROM employees
        WHERE ) b --병합하고자 하는 데이터를 서브쿼리로 표현.
    ON --병합시킬 데이터의 연결 조건
        (a.p_employee_id = b.employee_id)
WHEN MATCHED THEN --조건이 일치하는 경우에는 타켓테이블에 이렇게 실행하라
   UPDATE 
    SET last_name = p_last_name,
        email = p_email,
        hire_date = p_hire_date,
        job_id = p_job_id
       
    WHEN NOT MATCHED THEN
    INSERT /*속성(컬럼)*/VALUES
    (b.employee_id,  b.last_name,
    b.email,  b.hire_date, b.job_id);

    
 END;
 
 
    new_emp_proc (208,'춘식이', 'dljslfkj', '2023/10/04', 'AD VP');
   
SELECT * FROM emps;
 
 
 
 
 
    