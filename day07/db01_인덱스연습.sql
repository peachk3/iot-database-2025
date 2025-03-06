-- 기존 테이블 삭제
DROP TABLE IF EXISTS NewBook;

-- 테이블 생성
create table NewBook(
	bookid INT auto_increment primary KEY,
    bookname varchar(100),
    publisher varchar(100),
    price integer
);

-- 500만 건 더미데이터 생성 설정
set session cte_max_recursion_depth = 5000000;

-- 더미데이터 생성
insert into NewBook (bookname, publisher, price)
with recursive cte(n) as
(
	select 1
    union all
    select n+1 from cte where n < 5000000
)
select concat('Book', lpad(n, 7, '0')) -- Book0000001 ~ Book5000000
	 , concat('Comp', lpad(n, 7, '0')) -- Comp0000001 ~ Comp5000000
     , floor(3000 + rand() * 30000) as price -- 책 가격 30000 ~ 330000
from cte;

select count(*) from NewBook;

select * from NewBook                                                                                   
 where price between 20000 and 25000;
 
-- 가격을 7개 정도 검색할 수 있는 쿼리 작성
select * from NewBook
 where price in (8377, 23562, 24300, 5700, 12983, 15000, 12395);
 
-- 인덱스 생성
-- > 조회 실행 시간 단축시켜줌!! 
create index idx_book on NewBook(price);
 

