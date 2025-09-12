SELECT TOP (1000) [BillOfMaterialsID]
      ,[ProductAssemblyID]
      ,[ComponentID]
      ,[StartDate]
      ,[EndDate]
      ,[UnitMeasureCode]
      ,[BOMLevel]
      ,[PerAssemblyQty]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Production].[BillOfMaterials]


 DECLARE @RootProductID INT = 811;
WITH cha AS (
	SELECT 
		ProductAssemblyID,
		ComponentID,
		CAST(PerAssemblyQTY AS DECIMAL (5,2))AS TotalQty,
		1 AS Lv
	FROM [AdventureWorks2022].[Production].[BillOfMaterials]
	WHERE ProductAssemblyID = @RootProductID
	AND EndDate IS NULL

UNION ALL 
	SELECT 
		g.ProductAssemblyID,
		g.ComponentID,
		CAST(c.TotalQty * g.PerAssemblyQty AS DECIMAL(5,2)) AS TotalQty,
		c.Lv + 1 
	FROM [AdventureWorks2022].[Production].[BillOfMaterials] AS g
	INNER JOIN cha AS c 
	ON g.ProductAssemblyID = c.ComponentID
	WHERE EndDate IS NULL
)
SELECT 
	ComponentID,
	SUM(TotalQty) * 10 AS TotalQtyFOR10
FROM cha 
GROUP BY ComponentID
ORDER BY ComponentID ASC;

/* 
đặt rootproduct = 811
tạo CTE đệ quy chọn các linh kiện và đặt chúng làm lv1 
lọc các linh kiện là linh kiện gốc và vẫn còn hạn 
UNION tất cả 
chọn các linh kiện con rồi tính tổng các linh kiện đặt làm lv n+1
nối bảng dữ liệu gốc với CTE cha
dùng g.ProductAssemblyID = c.ComponentID nối bảng cha với con 
phần Final
từ CTE cha in ra  ComponentID và tổng linh kiện con cho 10 sp 
*/