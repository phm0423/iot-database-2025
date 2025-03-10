/* 문제2 - 모든 사원의 연봉을 표시하는 보고서. 사원의 성과 이름(Name), 급여, 수당 여부 따른 연봉 포함 출력
			수당이 있으면 'Salary + Commission', 수당이 없으면 'Salary Only'라 표시, 별칭은 적절히. 연봉 높은순 정렬(107행)
*/
select concat(first_name, ' ', last_name) as 'Name'
	 , salary
	 , (salary * (1+ifnull(commission_pct, 0)))*12 as 'Annual Salary'
	 , if (commission_pct is null, 'Salary Only', 'Salary + Commission') as Commission
  from employees
 where salary
 order by salary desc;
 
/* 문제3 - 모든 사원의 성과 이름(Name), 입사일, 입사한 요일을 출력하시오. 이때 주(week)의 시작인 일요일부터 출력(107행)
*/
select concat(first_name, ' ', last_name) as 'Name'
	 , hire_date
     , date_format(hire_date, '%W') as 'Day of the week'
  from employees
  order by date_format(hire_date, '%w') asc, hire_date;


-- 집계함수
/* 샘플 -  모든 사원은 직속상사 및 직속 직원 가짐. 단 최상위 or 최하위 직원은 예외. 소속된 사원 중 어떤 사원의 상사로 근무중인 사원의 총수를 출력(1행)
*/
select count(distinct manager_id) as 'Count Managers'
  from employees;

/* 문제1 - 사원이 소속된 부서별로 급여 합계, 평균, 최댓값, 최솟값 집계
			출력 값은 여섯자리와 세자리 구분 기호, $ 표시 포함, 부서번호 오름차순 정렬
            단, 부서에 소속되지 않은 사원 정보 제외, 출력시 머리글은 아래처럼 별칭 처리(11행)
*/
select department_id
	 , concat('$', format(round(sum(salary), 0), 0)) as 'Sum Salary'
     , concat('$', format(round(avg(salary), 1), 1)) as 'Avg Salary'
     , concat('$', format(round(max(salary), 0), 0)) as 'Max Salary'
     , concat('$', format(round(min(salary), 0), 0)) as 'Min Salary'
  from employees
 where department_id is not null
group by department_id;

/* 문제2 - 업무별 급여 평균이 $10,000보다 큰 경우 조회하여 업무, 급여 평균을 출력
			단, 사원(CLECK) 제외하여 평균이 높은 순서대로 출력(7행)
*/
select job_id
	 , format(round(avg(salary),6),6) as 'Avg Salary'
  from employees
where salary > 10000
group by job_id
-- having job_id like '%CLERK%'
order by avg(salary) desc;
