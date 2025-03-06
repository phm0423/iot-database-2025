-- 기존 테이블 삭제
DROP TABLE if exists NewBook;

-- 테이블 생성
create table NewBook (
	bookid integer auto_increment primary key,
    bookname varchar(100),
    publisher varchar(100),
    price integer
);

-- 500만건 데미데이터 생성 설정
set session cte_max_recursion_depth = 5000000;

-- 더미데이터 생성
INSERT into NewBook (bookname, publisher, price)
with recursive cte (n) as
(
	select 1
    union all
    select n+1 from cte where n < 5000000
)
select concat('Book', lpad(n, 7, '0')) -- Book0000001
	 , concat('Comp', lpad(n, 7, '0')) -- Comp5000000
     , floor(3000 + rand() * 30000) as price -- 책 가격을 3000~33000
from cte;

-- 데이터 확인
select count(*) FROM NewBook;


select * from NewBook
 where price in (5523, 5223, 8883, 7879, 24568, 16871, 8866);
 
-- 인덱스 생성
create index idx_book on NewBook(price);