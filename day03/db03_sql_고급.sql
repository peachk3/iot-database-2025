-- 내장함수
-- 4-1 -78과 78의 절대값을 구하시오.
SELECT ABS(-78), ABS(78);

-- 4-2 4.875를 소수점 첫번째 자리까지 반올림하시오.
SELECT ROUND(4.785, 1) AS 결과;

-- 4-3 고객별 평균 주문 금액을 100원 단위로 반올림한 값을 구하시오.
SELECT custid, ROUND(SUM(saleprice) / COUNT(*), -2) AS '평균금액'
  FROM Orders
 GROUP BY custid;


-- 문자열 내장함수
-- 4-4 도서 제목에서 야구가 포함된 도서명을 농구로 변경한 후 도서 목록을 출력하시오.
-- 변경 X, 보여질때만 바뀌고 데이터 값이 변경되지 않음!!
SELECT bookid
	 , REPLACE(bookname, '야구', '농구') AS bookname
     , publisher
     , price
FROM Book;

SELECT * FROM Book;

-- 추가 
SELECT 'Hello' 'MySQL';

SELECT CONCAT('Hello', 'MySQL','wOw'); 

-- 4-5 굿스포츠에서 출판한 도서의 제목과 제목의 문자수, 바이트 수를 구하시오.
SELECT bookname AS '제목'
	 , CHAR_LENGTH(bookname) AS '제목 문자수' -- 글자 길이를 구할때
     , LENGTH(bookname) AS '제목 바이트수' -- utf8에서 한글 한글자의 바이트 수는 3bytes
  FROM Book
 WHERE publisher = '굿스포츠';

-- 4-6 고객 중 성이 같은 사람이 몇 명이나 되는지 성(姓)별 인원수를 구하시오.
-- SUBSTR(자를 원본(문자열), 시작인덱스, 길이)
-- DB는 인덱스를 1부터 시작! (프로그래밍 언어와 차이점)
SELECT SUBSTR('Hello MySQL', 7, 5); -- 연습이 필요!

SELECT SUBSTR(name, 1, 1) AS '성씨 구분', COUNT(*) AS '인원수'
  FROM Customer
 GROUP BY SUBSTR(name, 1, 1);

-- 추가. trim(), Python strip()과 동일
SELECT CONCAT('--', TRIM('     Hello!     '), '--');
SELECT CONCAT('--', LTRIM('     Hello!     '), '--');
SELECT CONCAT('--', RTRIM('     Hello!     '), '--');

-- 새롭게 추가된 trim() 함수
SELECT TRIM('=' FROM '===- Hello- ===');


-- 날짜 시간 함수
SELECT SYSDATE(); -- Docker 서버시간을 따라서 GMT(그리니치 표준시)를 따름 +9hour

SELECT ADDDATE(SYSDATE(), INTERVAL 9 HOUR) AS '한국 시간';

-- 4-7 마당서점은 주문일부터 10일 후에 매출을 확정합니다. 각 주문의 확정일자를 구하시오.
SELECT orderid AS '주문 번호'
	 , orderdate AS '주문일자'
	 , ADDDATE(orderdate, INTERVAL 10 DAY) AS '주문 확정'
  FROM Orders;

-- 추가, 나라별 날짜, 시간을 표현하는 포맷이 다름
SELECT SYSDATE() AS '기본날짜/시간'
	 , DATE_FORMAT (SYSDATE(), '%M/%d/%Y %H:%i:%s');
 
-- 4-8 2014년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 나타내시오. 
-- 단, 주문일은 '%Y/%m/%d' 형태로 표시한다
-- %Y = 년도 전체 (ex 2025), %y = 년도 뒤 2자리(ex 25), %M = Febuary(월 이름), %b = Feb(월 약어) %m = 07(월 숫자)
-- %d = 일, %H = 16(24시간 기준), %h = 04(12시간 기준), %W = Monday, %w = 1(요일은 일요일 0)
-- %p = AM/PM
SELECT orderid AS '주문번호', DATE_FORMAT(orderdate, '%Y/%m/%d') AS '주문일', custid AS '고객번호', bookid AS '도서번호'
  FROM Orders
 WHERE orderdate = '2014-07-07';

-- DATEDIFF : D-day
SELECT DATEDIFF(SYSDATE(), '2025-02-03');

-- Formatting, 1000 단위마다 , 넣기
SELECT bookId
	 , FORMAT(price, 0) AS price
  FROM MyBook;

-- Null = Python None과 동일. 모든 다른 프로그래밍 언어에서는 전부 NULL
-- 추가. 금액이 NULL일 때 발생되는 현상
SELECT price - 5000
  FROM MyBook
 WHERE bookId = 3;

-- 핵심. 집계함수가 다꼬임
SELECT SUM(price) AS '합산은 그닥 문제 없음'
     , AVG(price) AS '평균은 NULL이 빠져서 꼬임'
     , COUNT(*) AS '모든 행의 갯수는 정확히 일치'
     , COUNT(price) AS 'NULL값은 갯수에서 제외'
  FROM MyBook;

-- NULL 값 확인. NULL은 비교연산자 (=, >, <, <>, ... 사용불가
-- NULL != ' '
-- IS 키워드 사용
SELECT *
  FROM MyBook
 WHERE price IS NULL; -- 반대는 IS NOT NULL

-- IFNULL 함수
SELECT bookId
	 , bookname
     , IFNULL(price, 0) AS price
  FROM MyBook;
  





