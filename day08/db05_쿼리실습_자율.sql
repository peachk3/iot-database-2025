-- 쿼리실습 자율
-- JOIN
/* hr 스키마에 있는 Employees, Departments 테이블의 구조를 파악한 후 사원 수가 5명 이상인 부서의 부서명과 사원 수를 출력하시오.
   이때 사원 수가 많은 순으로 정렬하시오.(5행)
*/
select dep.department_name, count(emp.employee_id)
  from employees as emp join departments as dep
    on emp.department_id = dep.department_id
 group by emp.department_id
 having count(emp.employee_id) >= 5
 order by count(emp.employee_id) desc;
  
select department_id, department_name
  from departments;


-- 서브쿼리
/* 사원의 급여 정보 중 업무별 최소 급여를 받는 사원의 성과 이름(name)으로 별칭, 업무, 급여, 입사일을 출력하시오
*/
select concat(first_name, ' ', last_name) as 'name', job_id, salary, hire_date
  from employees
 where (salary, job_id) in (select min(salary), job_id
							  from employees
							 group by job_id);
 
 
/* 모든 사원의 소속 부서 평균 연봉을 계산하여 사원별로 성과 이름(name), 업무, 급여, 부서 번호, 부서 평균 연봉(Department avg salary)를 출력하시오.(107행)
*/
select concat(first_name, ' ', last_name) as 'name'
	 , job_id, salary
     , department_id
     , round((select avg(salary)
		  from employees emp2 
		 where emp1.department_id = emp2.department_id),0) as 'Department avg salary'
  from employees emp1;
  
  
-- 집합연산자
/* 모든 사원의 업무 이력 변경 정보 및 업무 변경에 따른 부서 정보를 사번이 바른 순서대로 출력하시오.
*/
select employee_id, job_id, department_id
  from employees
 union all
select employee_id, job_id, department_id
  from job_history
  order by employee_id;
  
