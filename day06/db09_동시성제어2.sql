START TRANSACTION;

SELECT * FROM Book;

INSERT INTO Book VALUES(98,'데이터베이스','한빛미디어', 25000);  

-- insert, update, delete는 락이 걸림 
UPDATE Book SET
        price = 48000
WHERE bookid = 98;

COMMIT;