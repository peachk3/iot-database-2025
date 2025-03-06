-- 08 트랜잭션 
-- 테이블 생성 
CREATE TABLE BANK(
	name VARCHAR(40) PRIMARY KEY,
    balance INTEGER 
);

-- 데이터 추가
INSERT INTO BANK VALUES ('박지성',1000000),('김연아',1000000);

-- 트랜잭션은 업무 논리적 단위(All or Nothing)
-- START TRANSACTION; 으로 트랜잭션 시작
-- 성공시 COMMIT;
-- 실패시 ROLLBACK;

-- 트랜잭션 시작
START TRANSACTION;

-- 박지성 계좌를 읽어온다
SELECT * FROM BANK WHERE name = '박지성';
-- 김연아 계좌를 읽어온다
SELECT * FROM BANK WHERE name = '김연아';

-- 박지성 계좌에서 10000원 인출
UPDATE BANK SET
	   balance = balance - 10000
 WHERE name = '박지성';
 
 -- 김연아 계좌에서 10000원 입금
UPDATE BANK SET
	   balance = balance + 10000
 WHERE name = '김연아';
 
 -- 트랜잭션 종료
 -- 두개의 명령어를 다 수행하는 것이 아닌 커밋 또는 롤백 중 택 1
 -- UPDATE, DELETE 수행 할 때에는 TRANSACTION을 수행하면 데이터로스의 리스크를 줄일 수 있다.
 COMMIT;
 ROLLBACK;
 
 SELECT * FROM BANK;
