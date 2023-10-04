-- 프로시저(procedure) -> void 메서드 유사
-- 특정한 로직을 처리하고 결과값을 반환하지 않는 코드 덩어리 (쿼리)
-- 하지만 프로시저를 통해서 값을 리턴하는 방법도 있습니다.

CREATE OR REPLACE PROCEDURE guguproc
    (p_dan IN NUMBER) --매개변수 
IS 
BEGIN
    dbms_output.put_line(p_dan || '단');
    FOR i IN 1..9
    LOOP
        dbms_output.put_line(p_dan || 'x' || i || '='|| p_dan*i);
    END LOOP;
END;
EXEC guguproc(14);

--매개값(인수) 없는 프로시저
CREATE PROCEDURE p_test
IS --선언부
    v_msg VARCHAR2(30) := 'Hello procedure';
BEGIN --실행부
    dbms_output.put_line(v_msg);
END; -- 종료부

EXEC p_test; --프로시저 호출문


--IN 입력값을 여러 개 전달받는 프로시저
CREATE PROCEDURE my_new_job_proc
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE,
     p_max_sal IN jobs.max_salary%TYPE
    
    )
IS
BEGIN
    INSERT INTO jobs 
    VALUES(p_job_id,p_job_title,p_min_sal,p_max_sal);
    COMMIT;
END;

EXEC my_new_job_proc('JOB1', 'test job1', 10000, 20000);



--job_id를 확인해서
--이미 존재하는 데이터라면 수정, 없다면 새롭게 추가(job_id가 pk이기 때문)
CREATE OR REPLACE PROCEDURE my_new_job_proc --기존 프로시저 구조 수정
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE,
     p_max_sal IN jobs.max_salary%TYPE
    
    )
IS
    v_cnt NUMBER := 0;
BEGIN
--동일한 job_id가 있는지 체크
--이미 존재한다면 1, 존재하지 않는다면 0 ->v_cnt에 저장.
    SELECT
        COUNT(*)
    INTO 
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN --조회결과가 없다면 INSERT
        INSERT INTO jobs 
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
       
    ELSE --조회결과가 있다면 UPDATE
        UPDATE jobs
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal
        WHERE job_id = p_job_id;
    END IF;
    COMMIT;
END;


EXEC my_new_job_proc('JOB4', 'test job3', 10000, 20000);

SELECT * FROM jobs;


-------------------------------------------------------
--매개값(인수)의 디폴트값(기본값) 설정
CREATE OR REPLACE PROCEDURE my_new_job_proc --기존 프로시저 구조 수정
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE := 0,
     p_max_sal IN jobs.max_salary%TYPE := 1000
    
    )
IS
    v_cnt NUMBER := 0;
BEGIN
--동일한 job_id가 있는지 체크
--이미 존재한다면 1, 존재하지 않는다면 0 ->v_cnt에 저장.
    SELECT
        COUNT(*)
    INTO 
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN --조회결과가 없다면 INSERT
        INSERT INTO jobs 
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
       
    ELSE --조회결과가 있다면 UPDATE
        UPDATE jobs
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal
        WHERE job_id = p_job_id;
    END IF;
    COMMIT;
END;


EXEC my_new_job_proc('JOB5', 'test job5');

SELECT * FROM jobs;
----------------------------------

--OUT, IN OUT 매개변수 사용
--OUT 변수를 사용하면 프로시저 바깥쪽으로 값을 보냅니다.
--OUT을 이용해서 보낸 값은 바깥 익명 블록에서 실행해야 합니다. 
CREATE OR REPLACE PROCEDURE my_new_job_proc --기존 프로시저 구조 수정
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE := 0,
     p_max_sal IN jobs.max_salary%TYPE := 1000,
     p_result OUT VARCHAR2 --바깥쪽에서 출력을 하기위한 변수
    
    )
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100) := '존재하지 않는 값이라 INSERT처리되었어요';
BEGIN
--동일한 job_id가 있는지 체크
--이미 존재한다면 1, 존재하지 않는다면 0 ->v_cnt에 저장.
    SELECT
        COUNT(*)
    INTO 
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN --조회결과가 없다면 INSERT
        INSERT INTO jobs 
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
       
    ELSE --기존에 존재하는 데이터라면 조회된 결과를 추출.
        SELECT
            p_job_id || '의 최대 연봉: ' ||max_salary||',최소 연봉:' ||min_salary
            
        INTO 
            v_result --조회결과를 변수에 대입
        FROM jobs
        WHERE job_id = p_job_id;
        
    END IF;
    --out매개변수에 조회결과를 할당
    p_result := v_result;
    
    
    COMMIT;
END;

DECLARE
    msg VARCHAR2(100);
BEGIN
   my_new_job_proc('JOB2', 'test_job2', 2000, 8000, msg); 
   --msg가 p_result에게 이 값들을 담아 보냄
   dbms_output.put_line(msg); --p_result의 값을 바깥쪽인 여기에서 출력됨 
   
    my_new_job_proc('CEO', 'test_ceo', 20000, 80000, msg);
    dbms_output.put_line(msg);
END;

SELECT * FROM jobs;

-------------------------------------------------

--IN, OUT 동시 처리
CREATE OR REPLACE PROCEDURE my_parameter_test_proc
    (
    p_var1 IN VARCHAR2,
    p_var2 OUT VARCHAR2,
    p_var3 IN OUT VARCHAR2
    )

IS 

BEGIN 
    dbms_output.put_line('p_var1: '||p_var1); --IN :출력됨
    dbms_output.put_line('p_var2: '||p_var2);--OUT : 값이 전달되지 않음
    dbms_output.put_line('p_var3: '||p_var3); --IN OUT : IN의 성질을 가지고 있음
    
    --p_var1 := '결과1'; IN 변수는 값 할당 자체가 불가능
    p_var2 := '결과2';
    p_var3 := '결과3';

END;

DECLARE
    v_var1 VARCHAR2(10) := 'value1';
    v_var2 VARCHAR2(10) := 'value2';
    v_var3 VARCHAR2(10) := 'value3';
BEGIN
    my_parameter_test_proc(v_var1, v_var2, v_var3);
    
    dbms_output.put_line('v_var1:' ||v_var1);
    dbms_output.put_line('v_var2:' ||v_var2);
    dbms_output.put_line('v_var3:'||v_var3);
END;












