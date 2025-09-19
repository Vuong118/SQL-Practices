/*
Tính tổng chi tiêu của mỗi khách hàng cho mỗi sản phẩm
*/
WITH banggia AS (
SELECT 
	sh.CustomerID,
	SUM(sd.OrderQty * sd.UnitPrice) AS tongtien,
	pe.FirstName,
	pe.LastName,
	pc.Name,
	ROW_NUMBER() OVER(PARTITION BY pc.Name ORDER BY SUM(sd.OrderQty * sd.UnitPrice) DESC) AS hang
FROM [AdventureWorks2022].[Sales].[SalesOrderDetail] sd
JOIN [AdventureWorks2022].[Sales].[SalesOrderHeader] sh 
ON SD.SalesOrderID = sh.SalesOrderID
JOIN [AdventureWorks2022].[Production].[Product] p
ON p.ProductID = sd.ProductID
JOIN[AdventureWorks2022].[Production].[ProductSubcategory] psc
ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN [AdventureWorks2022].[Production].[ProductCategory] pc
ON pc.ProductCategoryID = psc.ProductCategoryID
JOIN [AdventureWorks2022].[Sales].[Customer] c
ON sh.CustomerID = c.CustomerID
JOIN [AdventureWorks2022].[Person].[Person] pe
ON c.PersonID = pe.BusinessEntityID
GROUP BY sh.CustomerID,pe.FirstName,pe.LastName,pc.Name
)
SELECT
	CustomerID,
	FirstName,
	LastName,
	Name AS danhsachsp,
	tongtien,
	hang
FROM banggia
WHERE hang<=3
