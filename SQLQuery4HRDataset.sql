

----------- EMPLOYMENT STATUS ANALYSIS----------------------------------------------
-- Looking at the types of employment status
SELECT distinct EmploymentStatus FROM [SQL Portfolio].[dbo].[HRDataset]
-- 3 types: Active, Terminated for cause, Voluntarily Terminated.


--Looking at the Employee Distribution in the company
SELECT Position, 
COUNT(Position) as Employeecount 
FROM [SQL Portfolio]..HRDataset
GROUP BY Position
ORDER BY Employeecount
-- We have 2 c-suite level staff, Product Technicians are the most in the company at a total of 194


-- Looking at percentage of people still employed by the company
SELECT EmploymentStatus, 
COUNT(EmploymentStatus) AS Employeecount, 
COUNT(*)*100.0/(SELECT count(EmploymentStatus) 
					 From [SQL Portfolio]..HRDataset) as percentageofemployee  
FROM [SQL Portfolio]..HRDataset
GROUP BY EmploymentStatus
-- There are 207 Active employees (67%), 88 voluntarily terminated (28%), 16 Terminated for cause (5%). 311 Total Employees



-------- DEPARTMENTAL ANALYSIS-------------------------------------------------------
SELECT Department FROM [SQL Portfolio]..HRDataset
group by Department
-- 6 Departments: Admin Offices, Executive Offices, IT/IS, Production, Sales, Software Engineerng


-- Looking at the list of positions under each department.
SELECT Department, Position FROM [SQL Portfolio]..HRDataset
group by Department, Position
-- Too many to write out. IT/IS Department has the most variety in positions.


-------- GENDER ANALYSIS----------------------------------------------------------
--Looking at the Gender distibution in the company for those currently employed.
SELECT Sex, COUNT(SEX) AS EmployeeCount 
FROM [SQL Portfolio]..HRDataset
WHERE  EmploymentStatus='Active'
GROUP BY Sex
-- There are more Females than Males. F116, M91 currently employed at the company

--Looking at Positions in the company with the highest Female presence
SELECT Position, COUNT(Position)AS EmployeeCount FROM [SQL Portfolio]..HRDataset
WHERE Sex='F' and EmploymentStatus='Active'
GROUP BY Position
ORDER BY EmployeeCount
-- Wow the CEO, CIO are both Women. Most women are Product Technicians


--Looking at Positions in the company with the highest Male presence 
SELECT Position, COUNT(Position)AS EmployeeCount FROM [SQL Portfolio]..HRDataset
WHERE Sex='M' and EmploymentStatus='Active'
GROUP BY Position
ORDER BY EmployeeCount
-- The highest position in the company OF a male staff is Director. 
-- Most men employed by the company are production technicians. That makes sense considering the high volume of product Technicians


---------- RACIAL ANALYSIS -------------------------------------------------------
-- Looking at the racial categories available at the company
SELECT DISTINCT RaceDesc FROM [SQL Portfolio]..HRDataset
-- 6 categories available. American Indian or Alaska Ntive, Asian, Black or African American, Hispanic, Two or more races, White


-- Looking at Racial proportions in the company for all employment status
SELECT RaceDesc, COUNT (*) AS RaceCount,
COUNT(*)*100/(select COUNT(*) FROM [SQL Portfolio]..HRDataset) AS RacePercent
FROM [SQL Portfolio]..HRDataset
GROUP BY RaceDesc
 White people make up 60% of the company. Followed by 25% back people, 9% Hispanic people,

-- Looking at the racial divide of people laid off
SELECT RaceDesc, COUNT (*) AS RaceCount,
(COUNT(EmpID)*100.0)/(select COUNT(RaceDesc) FROM [SQL Portfolio]..HRDataset WHERE EmploymentStatus LIKE 'Terminated for Cause' ) AS RacePercent
FROM [SQL Portfolio]..HRDataset
WHERE EmploymentStatus LIKE 'Terminated for Cause'
GROUP BY RaceDesc
-- White people make 56% of the layoffs,then black people at 37%. this makes absolute sense considering they make up the largest groups at the company.
