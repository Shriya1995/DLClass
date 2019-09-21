-- Analytic functions do not reduce the no. of rows unlike GROUP BY clause

-- Count over both dept ids 50 & 80
SELECT employee_id, department_id, COUNT(*) OVER () dept_cnt
FROM Employees
WHERE department_id IN (50, 80);

-----------------------------------
-- Count over each dept id 50 & 80
-----------------------------------
SELECT employee_id, department_id, 
COUNT(*) OVER (PARTITION BY department_id) dept_cnt
FROM Employees
WHERE department_id IN (50, 80);

-----------------------------------
-- Count of both dept ids 50 & 80
-----------------------------------

SELECT COUNT(*) OVER() FROM Employees WHERE department_id IN (50, 80);

-----------------------------------
-- ROW_NUMBER function to get serial no.s in a partition
-----------------------------------
SELECT employee_id, first_name, job_id, department_id, 
ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY hire_date) dept_sl
FROM Employees
WHERE department_id IN (50, 80);

-----------------------------------
-- RANK and DENSE_RANK
-----------------------------------
SELECT employee_id, first_name, job_id, salary, 
RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS Ranking,
DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) Dense_ranking
FROM Employees
WHERE department_id IN (50, 80);

-----------------------------------
-- LEAD and LAG
-- LEAD computes an expression based on the next rows
-- i.e. rows coming after the current row) and return value to current row
-- LEAD (expr, offset, default)
-- expr = expression to compute from leading row
-- offset = index of the leading row relative to the current row
-- default = value to return if the <offset> points to a row beyond partition range
-----------------------------------
SELECT employee_id, first_name, job_id, salary, 
LEAD(salary, 1, 0) OVER (PARTITION BY department_id ORDER BY salary DESC) next_lower_sal,
LAG(salary, 1, 0) OVER (PARTITION BY department_id ORDER BY salary DESC) prev_higher_sal
FROM Employees
WHERE department_id IN (50, 80);

-----------------------------------
-- FIRST_VALUE and LAST_VALUE
-- FIRST_VALUE returns the first result from an ordered set.
-- How many days after the first hire of each dept were the next employees hired?
-----------------------------------
SELECT employee_id, first_name, job_id, hire_date, FIRST_VALUE(hire_date) 
OVER (PARTITION BY department_id ORDER BY hire_date) day_gap
FROM Employees
WHERE department_id IN (50, 80)
ORDER BY department_id, day_gap;


-----------------------------------
-- CUME_DIST - display the cumulative distribution, or the relative position in the set, of each of the employees, as well as all the original data.
-----------------------------------
SELECT employee_id, first_name, department_id, salary,
       ROUND(CUME_DIST() OVER (ORDER BY salary DESC),4) AS cume_dist_sal
FROM   employees;

-----------------------------------
-- NTILE - Breaks a result set into a specified number of approximately equal groups, or buckets, rows permitting. 
-- If the no. of rows in the set is smaller than the number of buckets specified, 
-- the number of buckets will be reduced so there is one row per bucket.
-----------------------------------
SELECT employee_id, first_name, department_id, salary,
SUM(salary) OVER() AS total_sal,
       NTILE(5) OVER (PARTITION BY  department_id ORDER BY salary) AS quantile
FROM   employees;

-----------------------------------
-- PERCENT_RANK - Assigns value between 0-1 which represents the position of the current row relative to the set as a percentage
-----------------------------------
SELECT employee_id, first_name, department_id, salary,
        PERCENT_RANK() OVER (ORDER BY salary) AS percent_rank_sal,
       ROUND(PERCENT_RANK() OVER (ORDER BY salary)*100) AS percent_rank_sal_pct
FROM   employees;

