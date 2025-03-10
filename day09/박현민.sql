-- 1. 회원 테이블에서 이메일, 모바일, 이름, 주소 수능로 출력 (31행)
select email
	 , mobile
     , names
     , addr 
  from membertbl;
  

-- 2. 함수 사용하여 아래와 같은 결과가 나오도록 쿼리작성 (59행)
select names as 도서명
	 , author as 저자
     , ISBN
     , price as 정가
  from bookstbl
order by ISBN;


-- 3. 다음과 같은 결과가 나오도록 SQL문을 작성하시오. (책을 한번도 빌린적이 없는 회원) (18행)
select*
  from membertbl as m, rentaltbl as r
 where r.memberIdx = m.Idx;
 
select distinct m.names as 비대여자명
	 , m.levels as 등급
     , m.addr as 주소
     , replace(r.rentalDate, r.rentalDate, null) as 대여일
  from membertbl as m, rentaltbl as r
 where  m.Idx not in(select m.Idx
				  from membertbl as m, rentaltbl as r
				  where r.memberIdx = m.Idx)
order by m.Levels, m.Names;


-- 4. 다음과 같은 결과 작성

select ifnull(d.Names, '--합계--') as 장르
	 , concat(format(sum(b.Price),0), '원') as 총합계금액
  from divtbl as d, bookstbl as b
 where d.Division = b.Division
group by d.names with rollup
order by d.Names is null asc, d.Names asc;
 
