/*
WITH khachhang AS (
    SELECT 
        h.CustomerID,
        SUM(d.OrderQty * d.UnitPrice) AS Tongdoanhthu
    FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] h
    JOIN [AdventureWorks2022].[Sales].[SalesOrderDetail] d
        ON h.SalesOrderID = d.SalesOrderID
    GROUP BY h.CustomerID
)
 bài toán dùng bảng view trên : Tìm trung bình doanh thu của Top 3 khách hàng chi tiêu nhiều nhất ở mỗi TerritoryID và xác định Territory nào có giá trị này cao nhất.



*/
-- Lấy tổng chi tiêu của từng khách và gắn Territory
WITH ranker AS (
    SELECT 
        c.TerritoryID,
        k.CustomerID,
        k.Tongdoanhthu AS Tongchitieu,
        ROW_NUMBER() OVER(PARTITION BY c.TerritoryID ORDER BY k.Tongdoanhthu DESC) AS bxh
    FROM khachhang AS k
    JOIN [AdventureWorks2022].[Sales].[Customer] AS c
        ON k.CustomerID = c.CustomerID
),

--Tính toán trung bình Top 3 và khách chi nhiều nhất
tbchitieu AS (
    SELECT 
		
        TerritoryID,
        MAX(CASE WHEN bxh IS NOT NULL THEN Tongchitieu END) AS tieunhieunhat,
        AVG(Tongchitieu) AS trungbinhdoanhthu,
		bxh
    FROM ranker
			WHERE bxh <=3
    GROUP BY TerritoryID,bxh
)
SELECT *
FROM tbchitieu
ORDER BY TerritoryID;
