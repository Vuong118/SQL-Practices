/*
Bài toán 2: Phân tích hiệu suất nhân viên bán hàng (Salesperson Performance Analysis)
Tình huống: Bạn cần so sánh doanh số của mỗi nhân viên bán hàng với doanh số trung bình của tất cả các nhân viên bán hàng trong cùng một năm.
*/

WITH doanhthu AS (
SELECT
	sp.BusinessEntityID,
	soh.SalesPersonID,
	SUM(sod.OrderQty * sod.UnitPrice) tongdoanhso,
	YEAR(soh.OrderDate) nam
FROM [AdventureWorks2022].[Sales].[SalesPerson] sp
JOIN [AdventureWorks2022].[Sales].[SalesOrderHeader] soh
ON sp.BusinessEntityID = soh.SalesPersonID
JOIN [AdventureWorks2022].[Sales].[SalesOrderDetail] sod
ON soh.SalesOrderID = sod.SalesOrderID

GROUP BY soh.SalesPersonID,YEAR(soh.OrderDate),sp.BusinessEntityID
)
SELECT 
	SalesPersonID,
	FirstName,
	LastName,
	tongdoanhso,
	AVG(tongdoanhso)OVER (PARTITION BY nam) AS doanhso_trungbinh_nam,
	FORMAT(((tongdoanhso - AVG(tongdoanhso) OVER (PARTITION BY nam)) * 100.0 / AVG(tongdoanhso) OVER (PARTITION BY nam)), 'N2') + '%' AS phan_tram_chenh_lech,
	nam
FROM doanhthu d
JOIN [AdventureWorks2022].[HumanResources].[Employee] e
ON d.BusinessEntityID = e.BusinessEntityID
JOIN [AdventureWorks2022].[Person].[Person] p
ON p.BusinessEntityID = e.BusinessEntityID
ORDER BY tongdoanhso DESC