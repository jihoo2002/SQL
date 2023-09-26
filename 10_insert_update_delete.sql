--INSERT
--테이블 구조 확인
DESC departments;

-- INSERT 의 첫번째 방법 (모든 컬럼 데이터를 한번에 지정)
INSERT INTO departments
VALUES()


INSERT INTO departments
VALUES(300, '개발부');

SELECT * FROM departments;
ROLLBACK; --실행시점을 다시 뒤로 되돌리는 키워드

--INSERT의 두번째 방법(직접 컬럼을 지정하고 저장, not null확인하세요!)
INSERT INTO departments
(department_id, manager_id, department_name, location_id)
VALUES
    (290,206, '개발부', 1700); --departments테이블은 id와 name을 주지 않으면 오류남
    
SELECT * FROM departments;

    
ROLLBACK;

--사본 테이블 생성
--사본 테이블을 생성할 때 그냥 생성하면 -> 조회된 데이터까지 모두 복사
-- where 절에 false값(1=2)지정하면 -> 테이블의 구조만 복사되고, 데이터는 복사 x
CREATE TABLE emps AS 
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE 1 = 2); --관용적 표현 (false가 나옴)
--틀만 나오고 데이터는 false되어 나오지 않는다. 

SELECT * FROM emps;
DROP TABLE emps;

--INSERT (서브 쿼리)
INSERT INTO emps
(SELECT * FROM employees 
WHERE department_id = 50); --SELECT문의 결과만 집어넣겠다

----------------------------------------------------
--UPDATE
CREATE TABLE emps AS 
(SELECT *
FROM employees);

SELECT * FROM emps;

--UPDATE 를 진행할 떄는 누구를 수정할 지(where) 잘 지목해야 합니다
--그렇지 않으면 수정 대상이 테이블 전체로 지목됩니다. 
UPDATE emps SET salary = salary +salary *0.1 
WHERE employee_id =100;

UPDATE emps
SET phone_number = '010.4742.8917', manager_id = 102
WHERE employee_id = 100;

--UPDATE (서브쿼리)
UPDATE emps 
    SET (job_id, salary, manager_id) = 
    (
        SELECT job_id, salary, manager_id
        FROM emps
        WHERE employee_id = 100
    )
    WHERE employee_id = 101; --100번의 셀렉된 값들을 101번에 넣어주겠다.
    
  ----------------------------------------------------  
--DELETE
DELETE FROM emps
WHERE employee_id = 103;

SELECT * FROM emps;    
    
--DELETE (서브 쿼리) 
DELETE FROM emps 
WHERE department_id = (SELECT department_id FROM departments
                        WHERE department_name = 'IT');
    
    
    
    
    
    
    
    