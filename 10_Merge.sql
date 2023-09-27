--Merger (테이블 병합)

/*
UPDATE, INSERT 를 한방에 처리
한 테이블에 해당하는 데이터가 있다면 update를,
없으면 insert로 처리해라
*/

CREATE TABLE emps_it AS (SELECT * FROM employees WHERE 1=2);

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES 
    (106, '츈식이', '킴', 'CHOONSIK', sysdate, 'IT_PROG');
    
    SELECT * FROM emps_it;
    
SELECT * FROM employees
WHERE job_id = 'IT_PROG';

MERGE INTO emps_it a --(머지를 할 타켓 테이블)
    USING --병합시킬 데이터 
        (SELECT * FROM employees
            WHERE job_id = 'IT_PROG') b --병합하고자 하는 데이터를 서브쿼리로 표현.
    ON --병합시킬 데이터의 연결 조건
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN --조건이 일치하는 경우에는 타켓테이블에 이렇게 실행하라
    UPDATE SET
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
        
         /*
        DELETE만 단독으로 쓸 수는 없습니다.
        UPDATE 이후에 DELETE 작성이 가능합니다.
        UPDATE 된 대상을 DELETE 하도록 설계되어 있기 때문에
        삭제할 대상 컬럼들을 동일한 값으로 일단 UPDATE를 진행하고
        DELETE의 WHERE절에 아까 지정한 동일한 값을 지정해서 삭제합니다.
        */
        
        DELETE
            WHERE a.employee_id = b.employee_id
            --id가 같으면 지우기
            
        
WHEN NOT MATCHED THEN
    INSERT /*속성(컬럼)*/VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
    

------------------------------------------------------

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '렉스', '박', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '니나', '최', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '흥민', '손', 'HMSON', '20/04/06', 'AD_VP');

SELECT * FROM emps_it;
/*
employees 테이블을 매번 빈번하게 수정되는 테이블이라고 가정하자.
기존의 데이터는 email, phone, salary, comm_pct, man_id, dept_id을
업데이트 하도록 처리
새로 유입된 데이터는 그대로 추가.
*/

MERGE INTO emps_it a
    USING 
        (SELECT * FROM employees) b
    ON 
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN 
    UPDATE SET --수정하기 
        a.email = b.email,
        a.phone_number = b.phone_number,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
        
WHEN NOT MATCHED THEN
    INSERT VALUES --삽입해라 
        (b.employee_id, b.first_name, b.last_name,
         b.email, b.phone_number, b.hire_date, b.job_id,
        b.salary, b.commission_pct, b.manager_id, b.department_id);

SELECT * FROM emps_it
ORDER BY employee_id ;

ROLLBACK;



---------------------------------------------------------
CREATE TABLE DEPTS AS (SELECT * FROM departments WHERE 1=2);

SELECT * FROM DEPTS;

--문제 1
INSERT INTO DEPTS
    (department_id, department_name, manager_id, location_id)
VALUES 
    (310, '인사',  null, 1800);

INSERT INTO DEPTS
(SELECT * FROM departments);

INSERT INTO emps
(SELECT * FROM employees);
--문제 2
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
                        WHERE department_name IN('개발', '회계부', '재정', '인사', '영업'));
--문제 3번
SELECT * FROM DEPTS;
DELETE FROM DEPTS
WHERE department_id = 320;

--3-2
DELETE FROM DEPTS
WHERE department_name = 'NOC';
--다른 방식
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
    UPDATE SET --수정하기 
        a.department_name = b.department_name,
        a.manager_id = b.manager_id,
        a.location_id = b.location_id
       
        
WHEN NOT MATCHED THEN
    INSERT VALUES --삽입해라 
        (b.department_id, b.department_name, b.manager_id,
         b.location_id);

--문제 5
CREATE TABLE jobs_it AS (SELECT * FROM jobs 
                            WHERE min_salary >6000);

--5-2
SELECT * FROM jobs_it;
INSERT INTO jobs_it
    (job_id, job_title, min_salary, max_salary)
VALUES 
    ('SEC_DEV', '보안개발팀', 6000, 19000);
    
    --5-4
   MERGE INTO jobs_it a
    USING 
        (SELECT * FROM jobs 
        WHERE min_salary>5000) b
    ON 
        (a.job_id = b.job_id)--병합의 조건만 들어가야 한다. 
WHEN MATCHED THEN 
    UPDATE SET --수정하기 
        a.min_salary = b.min_salary,
        a.max_salary = b.max_salary
        
    
WHEN NOT MATCHED THEN
    INSERT VALUES --삽입해라 
        (b.job_id, b.job_title, b.min_salary,
         b.max_salary);
 SELECT * FROM jobs_it;
    
    