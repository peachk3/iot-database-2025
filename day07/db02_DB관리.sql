-- 데이터베이스 관리
show databases;

-- information_schema, performance_schema, mysql 등은 시스템 DB라서 개발자, DBA 사용하는 게 아님
use madang;

-- 하나의 DB 내에 존재하는 테이블들 확인
show tables;

-- 테이블의 구조
desc madang.NewBook;

select * from V_orders;


-- 사용자 추가
-- madang 데이터베이스만 접근할 수 있는 사용자 madang 생성
-- 내부 접속용
create user madang@localhost identified by 'madang';

-- 외부 접속용
create user madang@'%' identified by 'madang';

-- DCL : grant, revoke
-- 데이터 삽입, 조회, 수정만 권한 부여
grant select, insert, update on madang.* to madang@localhost with grant option;
grant select, insert, update on madang.* to madang@'%' with grant option;
flush privileges;

-- 사용자 madang에게 madangDB를 사용할 수 있는 모든 권한 부여 -> root와 권한이 같아짐
grant all privileges on madang.* to madang@localhost with grant option;
grant all privileges on madang.* to madang@'%' with grant option;
flush privileges;

-- 권한 해제
-- madang 사용자의 권한 중 select 권한만 제거
revoke select on madang.* from madang@localhost;
revoke all privileges on madang.* from madang@localhost;
revoke all privileges on madang.* from madang@'%';
flush privileges;