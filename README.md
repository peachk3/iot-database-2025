# iot-database-2025
IoT 개발자 데이터베이스 저장소

## 1일차
- 데이터베이스 시스템
    - 통합된 데이터를 저장해서 운영하면서 동시에 여러 사람이 사용할 수 있또록 하는 시스템
    - 실시간 접근, 계속 변경, 동시 공유가 가능, 내용으로 참조(물리적으로 떨어져있어도 사용 가능)
    
    - DBMS - SQL Server, Oracle, MySQL, MariaDB, MongoDB...

- 데이터베이스 언어
    - SQL - Structured Query Language / 구조화된 질의 언어(프로그래밍언어와 동)
        - DDL : DB나 테이블 생성, 수정, 삭제 언어
        - DML : 데이터를 검색, 삽입, 수정, 삭제
        - DCL : 권한 부여, 해제 (제어 언어)

- MySQL 설치(Docker)
    1. 파워쉘 오픈
        ```shell
        > docker -v
        Docker version 27.5.1, build 9f9e405
        ```
    2. MySQL Docker 이미지 다운로드
        ```shell
        > docker pull mysql
        Using default tag: latest
        latest: Pulling from library/mysql
        d255dceb9ed5: Download complete
        df1ba1ac457a: Download complete
        2be0d473cadf: Download complete
        ...
        cc9646b08259: Download complete
        Digest: sha256:146682692a3aa409eae7b7dc6a30f637c6cb49b6ca901c2cd160becc81127d3b
        Status: Downloaded newer image for mysql:latest
        docker.io/library/mysql:latest
        ```
    3. MySQL Image 확인
        ``` shell
        > docker images
        REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
        mysql        latest    146682692a3a   4 weeks ago   1.09GB
        ```
    4. Docker 컨데이너에 생성
        - MySQL Port번호는 3306이 기본
        - Oracle Port 1521
        - SQL Server 1433
        ```shell
        > docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=12345 -d -p 3306:3306 mysql:latest
        ```
    5. 컨테이너 확인
        ``` shell
        > docker ps -a
        CONTAINER ID   IMAGE          COMMAND                   CREATED          STATUS          PORTS
        NAMES
        73c7b1918350   mysql:latest   "docker-entrypoint.s…"   21 seconds ago   Up 20 seconds   0.0.0.0:3306->3306/tcp, 33060/tcp   mysql-container
        ```
    6. Docker 컨테이너 시작, 중지 재시작
        ``` shell
        > docker stop mysql-container # 중지
        > docker start mysql-container # 시작
        > docker restart mysql-container # 재시작
        ```
    7. MySQL Docker 컨테이너 접속
        ``` shell
        > docker exec -it mysql-container bash # bash 리눅스의 powershell
        Enter password:
        Welcome to the MySQL monitor.  Commands end with ; or \g.
        Your MySQL connection id is 9
        Server version: 9.2.0 MySQL Community Server - GPL

        Copyright (c) 2000, 2025, Oracle and/or its affiliates.

        Oracle is a registered trademark of Oracle Corporation and/or its
        affiliates. Other names may be trademarks of their respective
        owners.

        Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

        mysql> show databases;
        +--------------------+
        | Database           |
        +--------------------+
        | information_schema |
        | mysql              |
        | performance_schema |
        | sys                |
        +--------------------+
        4 rows in set (0.02 sec)
        ```
<img src='./image/db001.png' width='700'>

- Workbench 설치
    - https://dev.mysql.com/downloads/workbench/ MySQL Workbench 8.0.41
    - 다운로드 후 custom 선택
    - MySQL Installer에서 Workbench, Sample만 설치
    - 경로 변경 (C:\DEV\Tool\)밑에 넣기

    - Workbench 실행 후
        1. MySQL connections + 클릭

- 관계 데이터 모델
    - 3단계 DB 구조 : 외부 스키마(실세계와 매핑) -> 개념 스키마(DB논리적 설계) -> 내부 스키마(물리적 설계) -> DB
    - 모델에 쓰이는 용어
        - 릴레이션 - 테이블과 매핑
        - 속성 - 테이블 컬럼(column)
        - 튜플 - 테이블 로우(row)
        - 관계 - 릴레이션 간 부모, 자식 연관

    - `무결성 제약 조건`
        - 키 - **기본키**, **외래키**, 슈퍼키, 후보키, 대리키, 대체키
        - 개체 무결성 제약조건, 참조 무결성 제약조건, 도메인 무결성 제약조건
            - 데이터 무결성 : 데이터베이스에 저장된 일관성과 정확성을 지키는 것
            - 도메인 무결성 : 릴레이션 내의 튜플들이 각 속성의 도메인에 지정된 값만 가져야 함
            - 개체 무결성 : 릴레이션은 기본키를 지정하고 그에 따른 무결성 원칙
                -> 기본키는 null 값을 가져서는 안 되고 릴레이션 내에 오직 하나의 값만 존재해야 함
            - 참조 무결성 : 릴레이션 간의 참조 관계를 선언하는 제약조건
                -> 자식 릴레이션의 외래키 - 부모 릴레이션의 기본키와 도메인이 같아야 함

    - 릴레이션(relation) : 행과 열로 구성된 테이블
        - 관계(relationship) : 릴레이션 내의 관계, 릴레이션 간의 관계
        - 속성(애트리뷰트) = 열(column)  / 열의 갯수 = 차수 
        - 튜플(tuple) = 행(row) / 행의 갯수 = 카디널리티
        - 스키마(내포) - 테이블의 헤더(각 데이터의 특징을 나타내는 속성, 자료 타입 등 정보 담음0)
            - 속성(attribute): 릴레이션의 스키마의 열
            - 도메인(domain): 속성이 가질 수 있는 값의 집합
            - 차수(degree) : 속성의 개수

        - 인스턴스(외연) - 스키마에 따라 테이블에 실제로 저장되는 데이터의 집합
            - 튜플(tuple) : 릴레이션의 행(row)
            - 카디널리티 : 튜플의 수
 
        - 기본키(Primary Key) : Unique & Not NULL
            - 여러 후보키 중 하나를 선정하여 대표로 삼는 키
            - 식별할 수 있는 고유한 값 가져야 함
            - NULL 허용 불가
        
        - 외래키(Foreign Key)
            - 다른 릴레이션의 기본키를 참조하는 속성
            - 자기 자신의 기본키를 참조할 수도 있음

- SQL 기초
    - SQL 개요

    ```SQL
    -- DML SELECT문
    SELECT publisher, price
    FROM Book
    WHERE bookname LIKE '축구의 역사'; -- 주석입니다
    ```

- 실행파일(exe) 만들어지면 컴파일러
- 코드파일에서 바로 실행하면 인터프리터(내부적으로 컴파일은 수행)

## 2일차
- SQL 기초
    - 개요
        - 데이터베이스에 있는 데이터를 추출 및 처리 작업을 위해서 사용되는 프로그래밍 언어
        - 일반프로그래밍 언어와 차이점
            - DB에서만 문제해결 가능
            - 입출력을 모두 DB에서 테이블로 처리
            - 컴파일 및 실행은 DBMS가 수행

        - DML(데이터 조작어) - 검색, 삽입, 수정, 삭제
            - SELECT, INSERT, UPDATE, DELETE
        - DDL(데이터 정의어)
            - CREATE, ALTER, DROP
        - DCL(데이터 제어어)
            - GRANT, REVOKE

    - DML 중 SELECT
        - 이름, 조건, 속성 모두 여러 개 쓸 수 있음
        ```sql
        -- SELECT문 기본문법
        SELECT [ALL|DISTINCT] 컬럼명
          FROM 테이블명
        [WHERE 검색조건]
        [GROUP BY 속성명]
        [HAVING 집계함수 검색 조건]
        [ORDER BY 정렬할 속성 [ASC|DESC]]
        [WITH ROLLUP] 
        ```

        - 퀴리 연습(정렬까지): [SQL](./day02/db02_select_query_practice.sql)
        - 쿼리 연습(집계함수부터) : [SQL](./day02/db03_select_aggregate_~.sql)

## 3일차
- Visual Studio Code에서 MySQL 연동
    - 확장 > MySQL 검색
        - Weijan Chen 개인 개발자가 만든 MySQL 확장도 준수
        - Weijan Chen 개발한 Database Client 설치
            - 데이터베이스 아이콘 생성
        - Oracle에서 개발한 MySQL Shell for VS Code 사용 X 불편함
    - Database Client
        1. 툴바의 Database 아이콘 클릭
        2. Create Connection 클릭
        3. 정보 입력 > 연결 테스트

            <img src='./image/db002.png' width='600'>


        4. Workbench 처럼 사용

            <img src='./image/db003.png' width='600'>


- SQL 기초
    - 기본 데이터형
        - 데이터베이스에는 엄청 많은 데이터형이 존재(데이터의 사이즈 저장용량을 절약하기 위함)
        - 주요 데이터형
            - SmallInt(2byte) - 65535가지 수(음수 포함)를 저장 (-32768 ~ 32767)
            - **Int(4)** - 모든 데이터타입의 기준! 42억 정수(음수 포함) 저장
            - BigInt(8) - Int보다 더 큰 수 저장
            - Float(4) - 소수점아래 7자리까지 저장
            - Deciaml(5~17) - Float보다 더 큰 수 저장
            - Char(n) - n은 가변(1 ~ 255). **고정 길이 문자열**
                - 주의점! Char(10)에 Hello 입력하면 **'Hello     '** 과 같이 저장
            - Varchar(n) - n은 가변(1 ~ 65535). **가변 길이 문자열**
                - 주의점! Varchar(10)에 Hello 입력하면 **'Hello'** 저장됨
            - Longtext(최대 4GB) - 뉴스나 영화스크립트 저장시 사용
            - LongBlob(최대 4GB) - mp3, mp4 음악, 영화 데이터 자체 저장시 사용
            - Date(3) - 2025-02-27까지 저장하는 타입
            - DateTime(8) - 2025-02-27 10:46:34 까지 저장하는 타입
            - JSON(8) - json 타입 데이터를 저장

    - DDL 중 CREATE :[SQL](./day03/db01_ddl_query.sql)

        ``` sql
        CREATE DATABASE 데이터베이스명
            [몇 가지 사항];

        CREATE TABLE 테이블명(
            컬럼(속성)명 제약사항들, ...  
            PRIMARY KEY (컬럼(들))
            FOREIGN KEY (컬럼(들)) REFERENCES 테이블명(컬럼(들)) ON 제약사항
        );
        ```
        - DDL문은 Workbench에서 마우스 클릭으로 많이 사용(개발자 - 사용빈도 낮음)
        - 테이블 생성 후 확인
            1. 메뉴 Database > Reverse  Engineer(데이터베이스를 ERD 변경) 클릭
            2. 연결은 패스
            3. Select Schemas to RE 에서 특정 DB 체크
            4. Excute 버튼 클릭
            5. ERD 확인
            
            <img src='./image/db004.png' width='600'>

    - DDL 중 ALTER
        ``` sql
        ALTER DATABASE 데이터베이스명
            [몇 가지 사항];

        ALTER TABLE 테이블명
            [ADD 속성명 데이터타입]
            [DROP COLUMN 속성명]
            [ALTER COLUMN 속성명 데이터타입]
            -- ...
        ```
        - 테이블 수정


    - DDL 중 DROP
        ``` sql
        DROP [DATABASE|TABLE|INDEX|...] 개체명
        ```
        - 테이블 삭제. 복구 안됨! 백업 필수

    - DML 중 INSERT, UPDATE, DELETE : [SQL](./day03/db02_dml_query.sql)
        ``` sql
        -- 삽입
        INSERT INTO 테이블명 [(컬럼리스트)]
        VALUES (값리스트);

        -- 다른 테이블의 데이터 가져오기
        INSERT INTO 테이블명 [(컬럼리스트)]
        SELECT 컬럼리스트 FROM 테이블명
        [WHERE 조건];

        -- 수정
        UPDATE 테이블명
           SET 속성 = 값
             [, 속성 = 값]
         WHERE 조건;

        -- 삭제
        DELETE FROM 테이블명
         WHERE 조건;
        ```
        - INSERT 데이터 삽입, 새로운 데이터 생성
        - UPDATE 데이터 수정, 기존 데이터 변경
        - DELETE 데이터 삭제
        - `UPDATE와 DELETE는 WHERE절 없이 사용하면 문제 발생 위험!!!`
            - 트랜잭션을 사용하지 않으면 복구가 어려움 **(조심할 것)**

- SQL 고급
    - 내장함수, NULL : [SQL](./day03/db03_sql_고급.sql)
        - 수학함수, 문자열함수, 날짜함수 등

## 4일차
- SQL 고급 : [SQL](./day04/db01_sql고급.sql)
    - 행번호 출력
        - LIMIT, OFFSET 잘 쓰면 필요없음
        - 행번호가 필요한 경우도 있음

- SubQuery 고급 : [SQL](./day04/db02_sql고급_서브쿼리.sql)
    - WHERE절 - 단일값(비교연산), 다중행(ALL|ANY|EXISTS|IN|NOT IN...) 
    - SELECT절 - 무조건 스칼라값(단일행 단일열)
    - FROM절 - 인라인뷰. 하나의 테이블처럼 사용 - 가상테이블

- SQL 고급
    - 뷰 : [SQL](./day04/db03_sql고급_뷰.sql)
        - 자주 사용할 쿼리로 만들어진 가상 테이블을 계속 사용하기 위해서 만든 객체
        - 입력, 수정도 가능. 조인된 뷰는 불가능
        - 보안적, 재사용성, 독립성을 위해서 사용
    - 인덱스 : [SQL](./day04/db04_sql고급_인덱스.sql)
        - 빠른 검색을 위해서 사용하는 개체
        - 클러스터 인덱스 : 기본키에 자동으로 생성되는 인덱스(테이블당 1개)
        - 논클러스터(보조) 인덱스 : 수동으로 컬럼들에 생성할 수 있는 인덱스(여러개 가능)
        - 주의점
            - WHERE절에 자주 사용하는 컬럼에 인덱스 생성
            - 조인문에 사용하는 컬럼(PK 포함) 인덱스 생성
            - 테이블당 인덱스 개수는 5개 미만 생성할 것(너무 많으면 성능 저하)
            - 자주 변경되는 컬럼에는 인덱스 생성하지 말 것(성능 저하)
            - NULL값이 많은 컬럼에 인덱스 생성하지 말 것(성능 저하)

- 데이터베이스 프로그래밍
    - 저장 프로시저 : [SQL](./day04/db05_저장프로시저.sql)
        - 많은 쿼리로 일을 처리해야 할 때, 파이썬 등 프로그램에서 구현하면 복잡함
        - 저장 프로시저 하나로 프로그램 구현시 코드가 매우 짧아짐
        - 개발 솔루션화, 구조화 해서 손쉽게 DB 처리를 가능하게 하기 위해서
        - 예제 : [SQL](./day04/db05_저장프로시저2.sql)
        