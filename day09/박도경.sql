-- 문제 1번
SELECT Email, Mobile, Names, Addr 
  FROM membertbl;

-- 문제 2번
SELECT Names AS '도서명', Author AS '저자', ISBN, Price AS '정가' 
  FROM bookstbl
 ORDER BY ISBN ASC;

-- 문제 3번
SELECT mem.Names AS '비대여자명', mem.Levels AS '등급', mem.Addr AS '주소', ren.rentalDate AS '대여일' 
  FROM  membertbl AS mem
  LEFT OUTER JOIN rentaltbl AS ren
    ON mem.Idx = ren.memberIdx
 WHERE ren.rentalDate IS NULL
 ORDER BY mem.Levels, mem.Names;

-- 문제 4번
SELECT IFNULL(di.Names, '--합계--') AS '장르',  format(sum(bo.Price),0) AS '총합계금액'
  FROM bookstbl bo
  JOIN divtbl di
    ON bo.Division = di.Division
 GROUP BY di.Names WITH ROLLUP
 ORDER BY (di.Names IS NULL) , di.Names ASC;
