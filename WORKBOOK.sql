-- BASIC SELECT 

-- 1번
SELECT DEPARTMENT_NAME "학과 명", CATEGORY 계열
FROM TB_DEPARTMENT;

-- 2번
SELECT DEPARTMENT_NAME || '의 정원은 ' || CAPACITY || '명 입니다' AS "학과별 정원"
FROM TB_DEPARTMENT;

-- 3번
SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
AND DEPARTMENT_NO = 1
AND SUBSTR(STUDENT_SSN, 8, 1) = '2' ;

-- 4번
SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

-- 5번
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY >= 20 AND CAPACITY <= 30;

--6번
SELECT PROFESSOR_NAME 
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

--7번
SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

--8번
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

--9번
SELECT DISTINCT(CATEGORY)
FROM TB_DEPARTMENT

--10번
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'N'
AND EXTRACT(YEAR FROM ENTRANCE_DATE) = 2002
AND STUDENT_ADDRESS LIKE '%전주%';


------------------------------------------------------------------------------------


--ADDITIONAL SELECT 

--1번
SELECT STUDENT_NO, STUDENT_NAME, ENTRANCE_DATE
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY ENTRANCE_DATE;

--2번
SELECT PROFESSOR_NAME, PROFESSOR_SSN 
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 3;

--3번
SELECT PROFESSOR_NAME "교수 이름" ,  
   FLOOR( MONTHS_BETWEEN(SYSDATE, TO_DATE( 19 || SUBSTR(PROFESSOR_SSN, 1, 6 ))) / 12 ) 나이
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY 나이;
-- EXTRACK(YEAR FROM SYSDATE) - 
-- EXTRACT ( YEAR FROM TO_DATE( 19 || SUBSTR(PROFESSOR_SSN, 1, 6 )) ) 나이

--4번
SELECT SUBSTR(PROFESSOR_NAME,2) 이름
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 4;

--5번
SELECT STUDENT_NO, STUDENT_NAME 
FROM TB_STUDENT
WHERE EXTRACT (YEAR FROM ENTRANCE_DATE)-
      EXTRACT (YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1,6)) ) > 19;

-- TO_CHAR( TO_DATE( SUBSTR(STUDENT_SSN , 1, INSTR(STUDENT_SSN , '-') -1) , 
-- 'RRMMDD') , 'RRRR') >= 20
		
--6번
SELECT TO_CHAR(TO_DATE('2020-12-25'),'DAY')
FROM DUAL;

--7번
-- YY는 현재 세기를 나타냄(21세기 : 20XX)
SELECT TO_DATE('99/10/11','YY/MM/DD'),TO_DATE('49/10/11','YY/MM/DD')
FROM DUAL;

-- RR는 1세기를 기준으로 50 이상은 19XX년 / 50년 미만은 20XX년을 나타냄
SELECT TO_DATE('99/10/11','RR/MM/DD'),TO_DATE('49/10/11','RR/MM/DD')
FROM DUAL;

--8번
SELECT STUDENT_NO, STUDENT_NAME 
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

--9번
SELECT ROUND(AVG(POINT),1) 평점 
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

--10번 
SELECT DEPARTMENT_NO 학과번호, COUNT(*) "학생수(명)"
FROM TB_STUDENT 
GROUP BY DEPARTMENT_NO 
ORDER BY 1;

--11번
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12번
SELECT SUBSTR(TERM_NO,1,4) 년도, ROUND(AVG(POINT),1) "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 1;

--13번
SELECT DEPARTMENT_NO 학과코드명, 
-- SUM( DECODE(ABSENCE_YN, 'Y', 1, 0) ) "휴학생 수"
   COUNT(DECODE(ABSENCE_YN, 'Y', 1)) "휴학생 수"
FROM TB_STUDENT
-- WHERE ABSENCE_YN = 'Y'
GROUP BY DEPARTMENT_NO 
ORDER BY DEPARTMENT_NO ;

--14번 
SELECT STUDENT_NAME 동일이름 , COUNT(*) "동명인 수" 
FROM TB_STUDENT
GROUP BY STUDENT_NAME 
HAVING COUNT(*) >= 2
ORDER BY 1;

--15번 
SELECT NVL ( SUBSTR(TERM_NO,1,4), ' ' )년도, 
	   NVL( SUBSTR(TERM_NO,5,2), ' ') 학기, 
       ROUND( AVG(POINT),1 ) 평점 
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP ( SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2) )
ORDER BY SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2);
--> ORDER BY 절에 함수 사용 가능


------------------------------------------------------------------------------------


--ADDITIONAL SELECT 2

--1번 
SELECT STUDENT_NAME "학생 이름" , STUDENT_ADDRESS 주소지 
FROM TB_STUDENT
ORDER BY STUDENT_NAME ;

--2번
SELECT STUDENT_NAME , STUDENT_SSN 
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;

--3번
SELECT STUDENT_NAME 학생이름, STUDENT_NO 학번, STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT 
WHERE STUDENT_NO NOT LIKE 'A%'
AND (STUDENT_ADDRESS LIKE '강원도%' 
OR STUDENT_ADDRESS LIKE '경기도%');

--4번
SELECT PROFESSOR_NAME , PROFESSOR_SSN 
FROM TB_PROFESSOR 
WHERE DEPARTMENT_NO = '005'
ORDER BY PROFESSOR_SSN ;

--5번
SELECT  STUDENT_NO , TO_CHAR(POINT,'FM99.00') 
FROM TB_GRADE
WHERE TERM_NO = '200402'
AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC;
 
--6번
SELECT STUDENT_NO , STUDENT_NAME , DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
ORDER BY STUDENT_NAME;

-- 7번
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);

-- 8번 
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR
JOIN TB_CLASS USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO);

-- 선생님 풀이
--SELECT CLASS_NAME, PROFESSOR_NAME
--FROM TB_CLASS
--JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
--JOIN TB_PROFESSOR USING(PROFESSOR_NO);


-- 9번 
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR
JOIN TB_CLASS USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO)
WHERE PROFESSOR_NAME IN (SELECT PROFESSOR_NAME
                        FROM TB_PROFESSOR
                        JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
                        WHERE CATEGORY = '인문사회');

-- 선생님 풀이                       
--SELECT CLASS_NAME, PROFESSOR_NAME
--FROM TB_CLASS
--JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
--JOIN TB_PROFESSOR P USING(PROFESSOR_NO)
--JOIN TB_DEPARTMENT D ON(P.DEPARTMENT_NO = D.DEPARTMENT_NO)
--WHERE CATEGORY = '인문사회';
--> 컬럼의 정의가 애매모호하다.
--> 중복되는 컬럼명을 구분할 수 있도록
-- 테이블명.컬럼명 / 별칠.컬럼명으로 구분                       

-- 10번
SELECT STUDENT_NO 학번, STUDENT_NAME "학생 이름", ROUND(AVG(POINT),1) "전체 평점"
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NO = '059'
GROUP BY STUDENT_NAME, STUDENT_NO 
ORDER BY STUDENT_NO;

-- 선생님 풀이
--SELECT STUDENT_NO 학번, STUDENT_NAME "학생 이름", ROUND(AVG(POINT),1) "전체 평점"
--FROM TB_GRADE 
--JOIN TB_STUDENT USING(STUDENT_NO)
--JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
--WHERE DEPARTMENT_NAME = '음악학과'
--GROUP BY STUDENT_NO, STUDENT_NAME 
--ORDER BY 1;

-- 11번
SELECT DEPARTMENT_NAME 학과이름, STUDENT_NAME 학생이름, PROFESSOR_NAME 지도교수이름
FROM TB_STUDENT 
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
LEFT JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

-- 12번 
SELECT STUDENT_NAME, TERM_NO TERM_NAME
FROM TB_GRADE 
JOIN TB_STUDENT USING(STUDENT_NO)
JOIN TB_CLASS USING(CLASS_NO)
WHERE SUBSTR(TERM_NO, 1, 4) = '2007'
AND CLASS_NAME = '인간관계론';

-- 13번 *****
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE CATEGORY = '예체능'
AND PROFESSOR_NO IS NULL;

-- 14번 
SELECT STUDENT_NAME 학생이름, NVL(PROFESSOR_NAME, '지도교수 미지정') 교수이름
FROM TB_STUDENT TS
LEFT JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE TS.DEPARTMENT_NO = '020'
ORDER BY STUDENT_NO;

-- 15번 
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, DEPARTMENT_NAME "학과 이름", AVG(POINT) 평점
FROM TB_STUDENT 
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(STUDENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4.0
ORDER BY STUDENT_NO;

-- 16번
SELECT CLASS_NO, CLASS_NAME, TRUNC(AVG(POINT),8) 
FROM TB_CLASS 
JOIN TB_GRADE USING(CLASS_NO)
WHERE DEPARTMENT_NO = '034'
AND CLASS_TYPE LIKE '전공%'
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY CLASS_NO ;

-- 17번
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                       FROM TB_STUDENT
                       WHERE STUDENT_NAME = '최경희');
                      
-- 18번 *****
SELECT STUDENT_NO, STUDENT_NAME
FROM (SELECT STUDENT_NO, STUDENT_NAME ,AVG(POINT)
FROM TB_GRADE
JOIN TB_STUDENT USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '국어국문학과'
GROUP BY STUDENT_NO, STUDENT_NAME 
ORDER BY AVG(POINT) DESC)
WHERE ROWNUM = 1;
                      

-- 19번
SELECT DEPARTMENT_NAME "계열 학과명", ROUND(AVG(POINT),1) 전공평점 
FROM TB_DEPARTMENT
JOIN TB_CLASS USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(CLASS_NO)
WHERE CATEGORY = (SELECT CATEGORY
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = '환경조경학과')
GROUP BY DEPARTMENT_NAME
ORDER BY DEPARTMENT_NAME;













