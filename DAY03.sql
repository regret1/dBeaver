-- EMPLOYEE 테이블에서 현재 근무하는
-- 여성 사원의 사번, 사원명, 직급코드를 조회.
-- ENT_YN : 현재 근무 여부 파악하는 컬럼(퇴사여부)
-- WHERE 절에서도 함수 사용 가능

SELECT EMP_ID, EMP_NAME, JOB_CODE, ENT_YN
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = '2' AND ENT_YN = 'N';

-- 각 행마다 반복적으로 적용되고 실행 되는 함수를 단일 행 함수(SINGLE ROW FUNCTION)




-- 그룹 함수(GROUP FUNCTION) -- 
-- 하나 이상의 행을 그룹으로 묶어 연산 후 하나의 컬럼으로 반환
-- SUM(), AVG(), COUNT(), MAX(), MIN()

-- SUM() : 해당 컬럼들의 합계
SELECT SUM(SALARY)
FROM EMPLOYEE;

SELECT SUBSTR(EMP_NO,1,8)
FROM EMPLOYEE;

-- AVG() : 해당 컬럼들의 평균
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- MAX() , MIN() : 해당 컬럼들의 값 중 최대값 , 최소값
SELECT MAX(SALARY)
FROM EMPLOYEE;
SELECT MIN(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE에서
-- DEPT_CODE가 'D5'인 사원의
-- 평균 급여, 가장 높은 급여, 가장 낮은 급여, 급여합계 조회.

SELECT MAX(SALARY), AVG(SALARY), MIN(SALARY), SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'

SELECT COUNT(*)
FROM EMPLOYEE;

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;
-- COUNT는 컬럼 안에 NULL 값이 존재 할 경우 이를 카운팅 하지 않는다.


SELECT SYSDATE 
FROM DUAL;

-- 두 날짜 사이의 개월 수
SELECT HIRE_DATE "입사일",
	   MONTHS_BETWEEN(SYSDATE,HIRE_DATE) "입사 후 개월 수"
FROM EMPLOYEE;

-- ADD_MONTHS()
SELECT ADD_MONTHS(SYSDATE,3)
FROM DUAL;

SELECT SYSDATE, CURRENT_DATE
FROM DUAL;

SELECT ADD_MONTHS(CURRENT_DATE, 3)
FROM DUAL;

-- EXTRACT(YEAR|MONTH|DAY FROM 날짜데이터)
-- 지정한 날짜로 부터 날짜 값을 추출하는 함수
SELECT EXTRACT(YEAR FROM HIRE_DATE),
	   EXTRACT(MONTH FROM HIRE_DATE),
	   EXTRACT(DAY FROM HIRE_DATE)
FROM EMPLOYEE;


-- TO_CHAR()
-- 날짜/숫자 값을 문자 타입으로 변경해주는 함수
SELECT HIRE_DATE,
	   TO_CHAR(HIRE_DATE, 'YYYY.MM.DD'),
	   TO_CHAR(HIRE_DATE, 'YY-MON-DD')
FROM EMPLOYEE;

SELECT SALARY,
	   TO_CHAR(SALARY,'L999,999,999'),
	   TO_CHAR(SALARY,'000,000,000'),
	   TO_CHAR(SALARY,'L999,999')
FROM EMPLOYEE;
-- 9: 남은 빈 칸은 표시 X
-- 0: 남은 빈 칸은 0으로 표시


-- TO_DATE()
SELECT 20220910,
	   TO_DATE(20220910, 'YYYY/MM/DD')
FROM DUAL;

-- DECODE() --
-- JAVA의 3항 연산자
-- () ? 식1 : 식2;
-- ==> DECODE(컬럼|데이터, 비교값1, 결과1, 비교값2, 결과2, ..., 기본값)

-- 현재 근무하는 직원들의 성별을 남, 여로 구분지어 조회
SELECT EMP_NAME,EMP_NO,
	   DECODE(SUBSTR(EMP_NO,8,1), '1','남','2','여') 성별
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 모든 직원의 사번, 사원명, 부서코드, 직급코드, 근무여부, 관리자 여부를 조회
-- 근무여부가 'Y' 퇴사자로,
--			'N' 근무자로
-- 관리자 사번(MANAGER_ID)이 있으면 사원,
-- 						  없으면 관리자
SELECT *
FROM EMPLOYEE;

SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE,
	DECODE(ENT_YN , 'Y','퇴사자','N','근무자'),
	DECODE(MANAGER_ID, NULL,'관리자','사원')
FROM EMPLOYEE;


-- CASE 문
-- 자바의 IF, SWITCH처럼 사용 있는 함수 표현식
-- 사용방법

/*
*	CASE
*		WHEN (조건식) THEN 결과값
*		WHEN (조건식) THEN 결과값
*		ELSE 결과값
*	END
*/
SELECT EMP_ID , EMP_NAME, DEPT_CODE, JOB_CODE,
	   CASE
	   	WHEN ENT_YN='Y' THEN '퇴사자'
	   	ELSE '근무자'
	   END "근무여부",
	   CASE
	   	WHEN MANAGER_ID IS NULL THEN '관리자'
	   	ELSE '사원'
	   END
FROM EMPLOYEE;	
	   
	   
-- 숫자 관련 함수
-- ABS() : 절대값으로 표현
SELECT ABS(10), ABS(-10)
FROM DUAL;

-- MOD() : 나머지를 반환하는 함수
--         정수로 표현
SELECT MOD(10,3), MOD(10,2), MOD(10,6)
FROM DUAL;

-- ROUND() : 특정 값을 반올림할 때 사용 하는 함수
SELECT ROUND(123.456), ROUND(1234.56)
FROM DUAL;

SELECT ROUND(123.456,0),
		ROUND(123.456,1),
		ROUND(123.456,2),
		ROUND(123.456 , -2)
FROM DUAL;

-- CEIL() : 소수점 첫째 자리에서 올림
-- FLOOR() : 소수점 이하 버림
-- TRUNC() : 지정한 위치 이후부터 숫자를 버리는 함수
SELECT CEIL(123.456),
		FLOOR(123.456),
		TRUNC(123.456,1),
		TRUNC(123.456, 2),
		TRUNC(123.456, -2)
FROM DUAL;


-- 추가적인 날짜 관련 함수 --

-- NEXT_DAY(날짜, 요일)
-- 다가올 가장 가까운 요일을 반환
SELECT NEXT_DAY(CURRENT_DATE,'토요일'),
	   NEXT_DAY(CURRENT_DATE, '토'),
	   NEXT_DAY(CURRENT_DATE, 7)
FROM DUAL;
--	   NEXT_DAY(CURRENT_DATE, 'SATURDAY') 에러 발생

-- 현재 계정에 설정된 정보 등을 테이블 형태로 보관한다. 그러한 테이블을 데이터사전(데이터 딕셔너리)라고 부른다.
SELECT * FROM V$NLS_PARAMETERS;

--LAST_DAY() : 주어진 날짜의 마지막 일자를 조회하는 함수
SELECT LAST_DAY(SYSDATE)
FROM DUAL;

-- 날짜 끼리 +,- 연산도 가능
SELECT (SYSDATE - 10) "날짜",
	   (CURRENT_DATE - TO_DATE('19/03/03','YY/MM/DD'))
FROM DUAL;

--EMPLOYEE 테이블에서
-- 근무년수가 25년 이상인 사원들의
-- 사번, 사원명, 부서코드, 입사일 조회.
SELECT EMP_ID, EMP_NAME, DEPT_CODE,HIRE_DATE
FROM EMPLOYEE
-- WHERE MONTHS_BETWEEN(CURRENT_DATE,HIRE_DATE)/12 >= 25;
WHERE ADD_MONTHS(HIRE_DATE, 300) <= CURRENT_DATE ;  


SELECT TO_CHAR(CURRENT_DATE, 'AM HH:MM:SS'),
	   TO_CHAR(CURRENT_DATE, 'HH24:MM:SS'),
	   TO_CHAR(CURRENT_DATE, 'MON DY , YYYY'),
	   TO_CHAR(CURRENT_DATE, 'YYYY-MM-DD DAY'),
	   TO_CHAR(CURRENT_DATE, 'YEAR,Q')||'분기'
FROM DUAL;

SELECT TO_CHAR( TO_DATE('800303','YYMMDD'), 'YYYY-MM-DD'),
	   TO_CHAR( TO_DATE('800303','RRMMDD'), 'RRRR'),
	   TO_CHAR( TO_DATE('240303','YYMMDD'), 'YYYY'),
	   TO_CHAR( TO_DATE('240303','RRMMDD'), 'RRRR')	   
FROM DUAL;

-- YY : 현 세기 기준
-- 80 ==> 2080
-- 24 ==> 2024

-- RR : 반 세기 기준
-- 51~99 : 1900년대
-- 00~50 : 2000년대
-- 80 ==> 1980
-- 24 ==> 2024



-- SELECT 문의 실행 순서 --
/*
 * 
 * 5.SELECT 컬럼명 AS 별칭, 계산식, 함수식
 * 1.FROM 테이블명
 * 2.WHERE 조건
 * 3.GROUP BY 그룹으로 묶을 컬럼
 * 4.HAVING 그룹에 대한 조건식, 함수식
 * 6.ORDER BY 컬럼명 | 별칭 | 컬럼의 순서 [ASC|DESC][,컬럼명...]
 * 
 * 
 * 
 */

-- ORDER BY 절
-- SELECT을 통해 조회한 행의 결과들을 특정 기준에 맞춰
-- 정렬하는 구문.
-- ASC : 오름차순, DESC : 내림차순
SELECT EMP_ID, EMP_NAME 이름, SALARY,DEPT_CODE
FROM EMPLOYEE
-- ORDER BY EMP_NAME;
--ORDER BY EMP_NAME DESC;
--ORDER BY 이름; -- 컬럼명 대신 별칭 사용 가능
--ORDER BY 3 DESC;
ORDER BY DEPT_CODE DESC, EMP_ID;


-- 부서별 평균

-- 전체 평균
SELECT TRUNC(AVG(SALARY), -3)
FROM EMPLOYEE;

-- D1의 평균 급여
SELECT TRUNC(AVG(SALARY), -3)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6';

-- GROUP BY 절
-- 특정 컬럼이나 계산식을 하나의 그룹으로 묶어
-- 한 테이블 내에서 소그룹 별로 조회하고 할 때 선언 하는 구문

SELECT TRUNC(AVG(SALARY),-3) , DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT TRUNC(AVG(SALARY),-3)
FROM EMPLOYEE
GROUP BY EMP_ID ;

SELECT * FROM EMPLOYEE ORDER BY JOB_CODE;

-- EMPLOYEE 테이블에서
-- 부서 별 총 인원, 급여 합계, 급여 평균, 최대 급여, 최소 급여를 조회.
-- 부서 코드 기준으로 오름차순 정렬.
SELECT DEPT_CODE,
	   COUNT(*),
	   SUM(SALARY),
	   TRUNC(AVG(SALARY),-2),
	   MAX(SALARY),
	   MIN(SALARY),
	   DEPT_CODE 
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;

-- EMPLOYEE에서
-- 직급 코드 별 보너스를 받는 사원의 수를 조회.
-- 직급 코드 내림 차순 정렬.
-- 직급코드, 보너스 받는 사원수 조회
SELECT JOB_CODE,COUNT(BONUS)
FROM EMPLOYEE
GROUP BY JOB_CODE ORDER BY 1 DESC ;

-- GROUP BY 에서 주어진 컬럼뿐만이 아니라 함수식도 사용 가능

SELECT SUBSTR(EMP_NO,8,1), COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);

-- HAVING 구문
-- GROUP BY 한 소그룹에 대한 조건을 설정.

SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
WHERE SALARY > 3000000
GROUP BY DEPT_CODE;

-- 각 그룹별 평균을 구하고 그룹별 평균이 300만원 이상
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 3000000;

-- 부서별 급여 합계 중 900만원 초과하는
-- 부서 코드와 급여 합계를 조회.
SELECT DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE 
HAVING SUM(SALARY)> 9000000;

-- 급여 합계가 가장 높은 부서를 찾고,
-- 해당 부서의 부서코드와 급여 합계를 조회.
-- 1) 급여 합계가 가장 높은 부서 확인
-- 2) 급여 합계가 가장 높은 부서의 부서코드와 급여 합계 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
						FROM EMPLOYEE
						GROUP BY DEPT_CODE );


SELECT * FROM JOB;
-- 
-- SET OPERATOR --
-- 두 개 이상의 SELECT 한 결과를 합치거나, 중복 제거하거나 하는
-- 집합 형태의 결과로 조회하는 명령어
					
-- 합집합 -- 
-- 두 개 이상의 SELECT 한 결과(RsultSet)를 구하는 명령어
-- UNION : 중복이 있을 경우 중복되는거 1번만 보여준다
--
-- UNION ALL : 중복이 있을 경우 중복되는 내용도 그대로 조회하여 보여준다.

-- 차집합 --
-- MINUS : 두 개 이상의 결과 중 첫번째 결과만이 가진 내용을 보여주는 명령어
-- A와 B를 합쳣을 때 A만이 가진 결과를 보여준다.


-- 교집합 --
-- INTERSECT : 두 개 이상의 결과 중 중복되는 결과만 보여주듯 명령어.


-- UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


-- INTERSECT --
-- 교집합
-- D5부서의 직원 정보와
-- 급여 300만원 이상인 직원 정보를 합하여
-- D5부서이면서 300만원 이상인 직원 조회.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- MINUS --
-- 차집합
-- 첫번째 SELECT의 결과에서 나머지 결과들과  겹치는 부분을 뺀 고유의 결과를 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


-- JOIN --
-- 두개 이상의 테이블을 하나로 합쳐 사용하는 명령 구문


--1. 직원명과 주민번호를 조회함
--  단, 주민번호 9번째 자리부터 끝까지는 '*'문자로 채움
--  예 : 홍길동 771120-1******
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*')
FROM EMPLOYEE;
--2. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
SELECT EMP_NAME, JOB_CODE, SALARY*12
FROM EMPLOYEE;
--3. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원의 
--   수 조회함.
--   사번 사원명 부서코드 입사일
SELECT EMP_ID, EMP_NAME, DEPT_CODE,HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D9') AND TO_CHAR( HIRE_DATE, 'YYYY') = 2004;
--4. 직원명, 입사일, 입사한 달의 근무일수 조회
--   단, 주말도 포함함
SELECT EMP_NAME, HIRE_DATE,(TO_CHAR(LAST_DAY(HIRE_DATE),'DD') -TO_CHAR(HIRE_DATE,'DD'))
FROM EMPLOYEE;
--5. 직원명, 부서코드, 생년월일, 나이(만) 조회
--   단, 생년월일은 주민번호에서 추출해서, 
--   ㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--   나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함

--6. 직원들의 입사일로 부터 년도만 가지고, 각 년도별 입사인원수를 구하시오.
--  아래의 년도에 입사한 인원수를 조회하시오.
-- => 힌트 COUNT(DECODE())
-- =>     TO_CHAR(EXTRACT())
--
--	-------------------------------------------------------------
--	전체직원수   2001년   2002년   2003년   2004년
--	-------------------------------------------------------------
SELECT
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2001', 1, NULL)) AS "2001년",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2002', 1, NULL)) AS "2002년",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2003', 1, NULL)) AS "2003년",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2004', 1, NULL)) AS "2004년"
FROM EMPLOYEE;

--7.  부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회함
--  => case 사용
--   부서코드 기준 오름차순 정렬함.
SELECT DECODE(DEPT_CODE , 'D5','총무부','D6','기획부','D9','영업부')
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D6','D9')
--8.
-- 오늘은 연봉 협상의 날입니다.
-- 다음에 해당하는 사원들의 급여를 인상하고자 한다.
-- 직급코드가 J5인 사원들은 급여의 20%,
-- 직급코드가 J6인 사원들은 급여의 15%,
-- 직급코드가 J7인 사원들은 급여의 10%
-- 그 외 직급은 급여의 5%를 인상하려고 할 때,
-- EMPLOYEE 테이블에서 
-- 해당 조건을 만족하는 사원들의 사번, 사원명,
-- 직급코드, 인상될 급여 정보를 조회하여
-- 미리 확인해보자!
-- DECODE / CASE

-- DECODE --
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY,DECODE(JOB_CODE , 'J5',SALARY*1.2,'J6',SALARY*1.15,'J7',SALARY*1.1,SALARY*1.05) 
FROM EMPLOYEE;
-- CASE --

--9.
-- EMPLOYEE 테이블에서 직급 별
-- 그룹을 편성하여, 직급 코드, 급여 합계
-- 급여 평균, 인원 수 를 조회 하시오.
-- (단, 조회 결과는 인원수로 내림차순 하여
--  출력하고, 인원수는 3명을 초과하는 직급만을
--  조회 하시오.)
SELECT JOB_CODE,SUM(SALARY),TRUNC(AVG(SALARY),-3),COUNT(JOB_CODE)
FROM EMPLOYEE
GROUP BY JOB_CODE 
HAVING COUNT(JOB_CODE )>3
ORDER BY 4 DESC;









