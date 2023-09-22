--집합 연산자
--서로 다른 쿼리 결과의 행들을 하나로 결합, 비교, 차이를
--  구할 수 있게 해주는 연산자
--UNION(합집합 중복 X,) UNION ALL(합집합 중복 o),
--INTERSECT(교집합), MINUS(차집합)
--위 아래 컬럼 개수와 데이터 타입이 정확히 일치해야함

SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION 
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20;

--중복 값 나옴(UNION ALL)
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION ALL
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20; 


--INTERSECT(교집합)
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
INTERSECT
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20; 

--  A-B차집합
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
MINUS
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20;

--   b-a 차집합
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20
MINUS
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%';













