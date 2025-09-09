SELECT TOP (1000) [ProductID]
      ,[ComponentID]
      ,[TotalQuantity]
  FROM [AdventureWorks2022].[dbo].[BOM]


DECLARE  @RootProductID INT = 1;
WITH BOM_CTE AS (
	SELECT ProductID, ComponentID, TotalQuantity, 1 AS Level
	FROM [AdventureWorks2022].[dbo].[BOM] 
	WHERE ProductID = @RootProductID
	UNION ALL
	SELECT b.ProductID,b.ComponentID,c.TotalQuantity * b.TotalQuantity , c.level +1 AS level
	FROM [AdventureWorks2022].[dbo].[BOM] AS b
	INNER JOIN BOM_CTE AS c ON b.ProductID = c.ComponentID 
)
SELECT * FROM BOM_CTE ORDER BY level,ProductID ASC;

/* đặt @RootProductID là biến gốc
tạo CTE BOM 
từ bảng BOM lọc những linh kiện gốc 
nối tất cả dữ liệu trên xuống dưới
nối bảng BOM với BOM_CTE tìm linh kiện con rồi
tính tích lũy bằng c.TotalQuantity * b.TotalQuantity 
c.level +1 AS level tăng lv lên
lấy tất cả các cột ở BOM_CTE rồi xắp xếp theo thứ tự lv
*/