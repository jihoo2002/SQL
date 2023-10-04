--WHILE ��

DECLARE
    v_num NUMBER := 0;
    v_count NUMBER := 1; --begin
BEGIN
    WHILE v_count <= 10 --end 
    
    LOOP  
   
        v_num := v_num +v_count;
        v_count := v_count + 1; --step
    END LOOP;
    dbms_output.put_line(v_num);
END;

--Ż�⹮

DECLARE
    v_num NUMBER := 0;
    v_count NUMBER := 1; --begin
BEGIN
    WHILE v_count <= 10 --end 
    LOOP  
        EXIT WHEN v_count = 5; --count =5�̸� Ż��
         
        v_num := v_num +v_count;
        v_count := v_count + 1; --step
    END LOOP;
    dbms_output.put_line(v_num);
END;

-- FOR��
DECLARE
    v_num NUMBER := 4;
    
BEGIN
    FOR i IN 1..9 -- .�� �ΰ� �ۼ��ؼ� ������ ǥ��
    LOOP
        dbms_output.put_line(v_num || 'x' || i || '=' || v_num*i);
    END LOOP;
END;

--continue��
DECLARE
    v_num NUMBER := 3;
    
BEGIN
    FOR i IN 1..9 -- .�� �ΰ� �ۼ��ؼ� ������ ǥ��
    LOOP
        CONTINUE WHEN i = 5;
        dbms_output.put_line(v_num || 'x' || i || '=' || v_num*i);
    END LOOP;
END;


-- 1. ��� �������� ����ϴ� �͸� ����� ���弼��. (2 ~ 9��)
-- ¦���ܸ� ����� �ּ���. (2, 4, 6, 8)
-- ����� ����Ŭ ������ �߿��� �������� �˾Ƴ��� �����ڰ� �����. (% ����~)

BEGIN
    FOR j in 2..9 LOOP
   FOR i IN 1..9
    -- .�� �ΰ� �ۼ��ؼ� ������ ǥ��
    
    LOOP
        
        dbms_output.put_line(j || 'x' || i || '=' || j*i);
    END LOOP;
    END LOOP;
END;


  
-- 2. INSERT�� 300�� �����ϴ� �͸� ����� ó���ϼ���.
-- board��� �̸��� ���̺��� ���弼��. (bno, writer, title �÷��� �����մϴ�.)
-- bno�� SEQUENCE�� �÷� �ֽð�, writer�� title�� ��ȣ�� �ٿ��� INSERT ������ �ּ���.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3 ....
CREATE TABLE board2 (
    bno NUMBER PRIMARY KEY ,
    writer VARCHAR2(30),
    title VARCHAR2(30)
);
CREATE SEQUENCE board_seq
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 300 
    MINVALUE 1 
    NOCACHE 
    NOCYCLE;
    
    DECLARE
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 300
LOOP
    INSERT INTO board
    VALUES(board_seq.NEXTVAL, 'test' ||v_count, 'title'||v_count);
    v_count := v_count + 1; --step
END LOOP;
 COMMIT;
END;

SELECT * FROM board2
ORDER BY bno ;


