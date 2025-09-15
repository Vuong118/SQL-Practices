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

  --đặt sp gốc rootproduct = 811
 DECLARE @RootProductID INT = 811;
 --tạo CTE đệ quy cha 
WITH cha AS (
	--chọn các linh kiện và đặt chúng làm Lv1 
	SELECT 
		ProductAssemblyID, --linh kiện gốc
		ComponentID,		--linh kiện con
		CAST(PerAssemblyQTY AS DECIMAL (5,2))AS TotalQty,-- số lượng cần cho 1 sp gốc
		1 AS Lv
	FROM [AdventureWorks2022].[Production].[BillOfMaterials]
	--lọc các linh kiện là linh kiện gốc và vẫn còn bán
	WHERE ProductAssemblyID = @RootProductID
	AND EndDate IS NULL

UNION ALL 
--đệ quy các linh kiện con rồi tính tổng các linh kiện đặt làm lv n+1
	SELECT 
		g.ProductAssemblyID,
		g.ComponentID,			
		CAST(c.TotalQty * g.PerAssemblyQty AS DECIMAL(5,2)) AS TotalQty,
		c.Lv + 1 
	FROM [AdventureWorks2022].[Production].[BillOfMaterials] AS g
	INNER JOIN cha AS c  --nối bảng dữ liệu gốc với CTE cha
	ON g.ProductAssemblyID = c.ComponentID
	WHERE EndDate IS NULL -- lọc các linh kiện vẫn còn bán
)
--từ CTE cha in ra  ComponentID và tổng linh kiện con cho 10 sp 
SELECT 
	ComponentID,
	SUM(TotalQty) * 10 AS TotalQtyFOR10  -- tổng linh kiện cho 10sp bằng tổng linh kiện con *10
FROM cha 
GROUP BY ComponentID
ORDER BY ComponentID ASC;