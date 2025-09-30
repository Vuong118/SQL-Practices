/*
Ban giám ??c mu?n bi?t nh?ng khách hàng nào (Customer) có t?ng giá tr? ??n hàng cao nh?t trong t?ng n?m,
 .??ng th?i so sánh v?i trung bình c?a toàn b? khách hàng n?m ?ó.
C? th?:
Truy xu?t các c?t:
N?m (YEAR(OrderDate))
CustomerID
T?ng giá tr? ??n hàng c?a Customer trong n?m (SUM(LineTotal))
Trung bình giá tr? ??n hàng c?a t?t c? khách hàng trong n?m ?ó
X?p h?ng c?a Customer theo t?ng giá tr? ??n hàng (Rank) trong n?m
Ch? l?y ra nh?ng Customer ??ng Top 3 trong t?ng n?m.
K?t qu? ph?i ???c s?p x?p theo n?m t?ng d?n, sau ?ó theo Rank.
*/

WITH giatri AS ( 
SELECT
	c.CustomerID,
	YEAR(sh.OrderDate) nam,
	SUM(sd.OrderQty * sd.UnitPrice) tonggiatridon
FROM [AdventureWorks2022].[Sales].[Customer] c
JOIN [AdventureWorks2022].[Sales].[SalesOrderHeader] sh
ON sh.CustomerID = c.CustomerID
JOIN [AdventureWorks2022].[Sales].[SalesOrderDetail]  sd
ON sd.SalesOrderID = sh.SalesOrderID
GROUP BY c.CustomerID,YEAR(sh.OrderDate)
),
tb AS (
SELECT 
	CustomerID,
	nam,
	tonggiatridon,
	AVG(tonggiatridon) OVER (PARTITION BY nam ) trungbinhgiatri,
	RANK() OVER (PARTITION BY Nam ORDER BY tonggiatridon DESC) AS XepHang
FROM giatri 
GROUP BY CustomerID,
	nam,
	tonggiatridon
)
SELECT 
	CustomerID,
	nam,
	tonggiatridon,
	trungbinhgiatri,
	XepHang
FROM tb
WHERE XepHang <= 3
ORDER BY nam,XepHang