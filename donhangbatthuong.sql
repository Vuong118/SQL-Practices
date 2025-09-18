/*
ĐỀ Bài – Đơn hàng bất thường

Trong bảng Sales.SalesOrderDetail:

Hãy tìm những đơn hàng có giá trị lớn hơn 2 lần giá trị trung bình của tất cả đơn hàng.

Kết quả: SalesOrderID, TongGiaTri, GiaTriTrungBinh, HeSo.
*/
WITH giatri AS (
    SELECT
        S.SalesOrderID,
        SUM(S.UnitPrice) AS Tonggiatri
    FROM [AdventureWorks2022].[Sales].[SalesOrderDetail] S
    GROUP BY S.SalesOrderID
),
tb AS (
    SELECT AVG(Tonggiatri * 1.0) AS GiatriTrungBinh
    FROM giatri
)
SELECT 
    g.SalesOrderID,
    g.Tonggiatri,
    CAST(g.Tonggiatri * 1.0 / tb.GiatriTrungBinh AS DECIMAL(10,2)) AS HeSo
FROM giatri g
CROSS JOIN tb
WHERE g.Tonggiatri > 2 * tb.GiatriTrungBinh;
