-- 7-1 : 계절학기 테이블
DROP TABLE IF EXISTS Summer;	-- 기존 테이블이 존재하면 삭제

CREATE TABLE Summer(
	sid INTEGER, 
    class VARCHAR(20),
    price INTEGER
);

-- 데이터 확인
SELECT * FROM Summer;

-- 기본 데이터 추가(MYSQL 다중 데이터 한꺼번에 INSERT)
INSERT INTO Summer VALUES (100,'JAVA',20000),(150,'PYTHON',15000),(200,'C',10000),(250,'JAVA',20000);

-- 계절학기를 듣는 학생의 학번과 수강과목
SELECT sid
	 , class
  FROM Summer;
  
-- C강좌 수강료?
SELECT price
  FROM Summer
 WHERE class LIKE '%C%';
 
 -- 수강료가 가장 비싼 과목은?
 SELECT DISTINCT(class) 
   FROM Summer
  WHERE price = (
		SELECT MAX(price)
          FROM Summer);
          
-- 계절학기 학생 수와 수강료 총액
SELECT COUNT(*) AS "학생수"
	 , SUM(price) AS "수강료 총액"
  FROM Summer;
  
/* 이상현상(abnormal) */
-- 삭제이상
DELETE FROM Summer WHERE sid = 200; -- C 강좌 수강료를 찾을 수 없다

-- 삽입이상
INSERT INTO Summer VALUES (NULL, 'C++','25000');

SELECT count(*) -- NULL 포함 카운트 ->4개로
  FROM Summer;
  
SELECT COUNT(sid) -- 특정 칼럼 카운트 -> NULL값 제외 3개로
  FROM Summer;

-- 수정이상 
UPDATE Summer 
   SET price = 15000
 WHERE sid = 100;
 
DELETE FROM Summer;
SELECT * FROM Summer;
