/*
Đề bài
Liệt kê danh sách nhân viên và phòng ban họ đang làm việc.
Tìm nhân viên có lương cao nhất trong từng phòng ban.
*/
WITH nhanvien AS (
SELECT	
	e.BusinessEntityID,
	e.JobTitle,
	d.Name
	FROM [AdventureWorks2022].[HumanResources].[EmployeeDepartmentHistory] edh
	JOIN [AdventureWorks2022].[HumanResources].[Employee] e
	ON edh.BusinessEntityID = e.BusinessEntityID
	JOIN [AdventureWorks2022].[HumanResources].[Department] d
	ON edh.DepartmentID = d.DepartmentID
	WHERE edh.EndDate IS NULL
),
luongcao AS (
	SELECT 
		edh.DepartmentID,
		MAX (eph.Rate) AS luongcaonhat
	FROM  [AdventureWorks2022].[HumanResources].[EmployeeDepartmentHistory] edh
	JOIN  [AdventureWorks2022].[HumanResources].[EmployeePayHistory] eph
	ON edh.DepartmentID = eph.BusinessEntityID
	WHERE edh.EndDate IS NULL 
	GROUP BY edh.DepartmentID
)
SELECT * FROM luongcao
CROSS JOIN nhanvien 
ORDER BY luongcaonhat DESC;
