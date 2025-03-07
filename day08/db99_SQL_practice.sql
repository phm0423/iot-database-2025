-- select
/* 샘플 -  사원정보 테이블에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호 출력
			이름은 성과 이름 연결하여 Name으로 출력(107행) 
*/
select employee_id
	 , concat(first_name, ' ', last_name) as 'Name'
     , salary
     , job_id
     , hire_date
     , manager_id
  from employees;

/* 문제1 - 사원정보 테이블에서 사원의 성과 이름은 Name, 업무는 Job, 급여는 Salary, 연봉에 $100 보너스 추가하여 계산값은 Icreased Ann_Salary
			, 급여에 $100추가한 연봉은 Increased Salary 라고 출력하시오(107행)
*/
select concat(first_name, ' ', last_name) as 'Name'
	 , job_id as 'Job'
     , salary as 'Salary'
     , (salary*12)+100 as 'Increased Ann_Salary'
     , (salary+100)*12 as 'IncreasedSalary'
  from employees;
  
/* 문제2 - 사원정보 테이블에서 모든 사원의 이름(last_name)과 연봉을 ' 이름: 1 Year Salary = $연봉' 형식으로 출력, 1 Year Salary라고 별칭출력(107행)
*/
select concat(last_name,': 1 Year Salary = $', salary*12) as '1 Year Salary'
  from employees;
  
/* 문제3 - 부서별로 담당하는 업무를 한번식만 출력하시오(20행)
*/
select distinct(department_id)
	 , job_id
  from employees;
  
-- Where, Order by
/* 샘플- HR부서에서 급여보고서 작성하려함. 사정정보 테이블에서 급여가 $7,000 ~ $10,000 범위 이외인 사람의 성과 이름(Name으로 별칭) 및 급여가 작은순서 출력(75행)
*/
select concat(first_name, ' ', last_name) as 'Name'
	 , salary
  from employees
 where salary not between 7000 and 10000
order by salary;

/* 문제1 - 사원의 성(last_name) 중에 'e' 및 'o' 글자가 포함된 사원을 출력하시오. 이때 머리글은 e AND o Name이라고 출력(10행)
*/
select last_name as 'e AND o Name'
  from employees
 where last_name like '%e%' and last_name like '%o%';
 
/* 문제2 - 현재 날짜 타입으로 날짜 확인, 1995년 5월 20일부터 1996년 5월 20일 사이 고용된 사원들의 이름(Name별칭), 사원번호 고용일자 출력하시오. 입사일 빠른순 정렬(8행)
*/
select date_add(sysdate(), interval 9 hour) as 'SYSDATE()';

select last_name as 'Name'
	 , employee_id
     , hire_date
  from employees
 where hire_date between '1995-05-20' and '1996-05-20'
order by hire_date;

/* 문제3 - 급여와 수당률에 대한 지출보고서 작성. 수당 받는 모든 사원의 성과 이름(Name), 급여, 업무, 수당률 출력
			급여가 큰 순서대로 정렬, 그병가 같으면 수당율이 큰 순서대로 정렬
*/
select concat(first_name, ' ', last_name) as 'Name'
	 , salary
     , job_id
     , commission_pct
  from employees
 where commission_pct
order by salary desc, commission_pct desc;

-- 단일 행 함수 및 변환 함수
/* 샘플 - 60번 IT 부서의 사원 급여를 12.3% 인상하기로 함. IT 부서 사원의 인상된 급여를 정수만(반올림) 표시하는 보고서 작성.
			출력 형식은 사번, 이름과 성(Name), 급여, 인상된 급여(Increased Salary) 순으로 출력 (5행)
*/
select employee_id
	 , concat(first_name, ' ', last_name) as 'Name'
     , salary
     , round(salary * 1.123, 0) as 'Increased Salary'
  from employees
 where department_id = 60;     
 
/* 문제1 - 이름이's'로 끝나는 각 사원의 이름과 업무를 아래의 예와 같이 출력. 출력시 성과 이름은 첫 글자를 대문자로, 업무는 모두 대문자,
			Employee JOBs.로 표시(18행)
            EX) Sigal Tobias is a PU_CLERK
*/
select concat(first_name, ' ', last_name, ' is a ', upper(job_id)) as 'Employee JOBs.'
  from employees
 where last_name like '%s';
 
/* 문제2 - 모든 사원의 연봉을 표시하는 보고서. 사원의 성과 이름(Name), 급여, 수당 여부 따른 연봉 포함 출력
			수당이 있으면 'Salary + Commission', 수당이 없으면 'Salary Only'라 표시, 별칭은 적절히. 연봉 높은순 정렬(107행)
*/
select concat(first_name, ' ', last_name) as 'Name'
	 , salary
     , (salary * (1+commission_pct))*12 as 'Annual Salary'
  from employees
 where salary
 order by salary desc;