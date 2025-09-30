/*
Ban gi�m ??c mu?n bi?t nh?ng kh�ch h�ng n�o (Customer) c� t?ng gi� tr? ??n h�ng cao nh?t trong t?ng n?m,
 .??ng th?i so s�nh v?i trung b�nh c?a to�n b? kh�ch h�ng n?m ?�.
C? th?:
Truy xu?t c�c c?t:
N?m (YEAR(OrderDate))
CustomerID
T?ng gi� tr? ??n h�ng c?a Customer trong n?m (SUM(LineTotal))
Trung b�nh gi� tr? ??n h�ng c?a t?t c? kh�ch h�ng trong n?m ?�
X?p h?ng c?a Customer theo t?ng gi� tr? ??n h�ng (Rank) trong n?m
Ch? l?y ra nh?ng Customer ??ng Top 3 trong t?ng n?m.
K?t qu? ph?i ???c s?p x?p theo n?m t?ng d?n, sau ?� theo Rank.
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