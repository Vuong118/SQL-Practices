/*
Bài toán Dùng PIVOT để tính doanh thu các tháng 
*/


--tạo subquery lấy tháng tách tháng ra từ orderdate va totaldue
SELECT
		--đặt tên các cột sau khi pivot
		[1] AS M01,[2] AS M02,[3] AS M03 ,[4] AS M04 ,[5] AS M05, [6] AS M06,[7] AS M07,
		[8] AS M08, [9] AS M09, [10] AS M10, [11] AS M11, [12] AS M12
	FROM (
	SELECT MONTH(OrderDate) AS OrderMonth,-- lấy tháng trong orderdate alias thành Ordermonth
	TotalDue-- tổng doanh thu
	FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
	WHERE YEAR(OrderDate) = 2013
)  AS s
-- PIVOT: xoay dữ liệu từ dạng hàng sang dạng cột
PIVOT (
	SUM(TotalDue) FOR OrderMonth IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])--tổng hợp doanh thu cho cột tháng sau khi pivot 
)  AS p