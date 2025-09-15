/*
Bài toán : Doanh thu theo nhân viên
 Tính doanh thu của từng nhân viên bán hàng (SalesPersonID) trong năm 2014, kèm theo % so với tổng doanh thu công ty.
*/
  --tạo CTE nhanvien
WITH nhanvien AS (
SELECT
		SalesPersonID,
		SUM(TotalDue) AS Totaldueyear --tính tổng doanh thu nv theo năm 
	FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE YEAR(OrderDate) = 2014 AND SalesPersonID IS NOT NULL  --chỉ lấy các dòng có nhân viên
GROUP BY SalesPersonID

),
--tạo cte congty
congty AS (
	SELECT SUM(TotalDue) AS TongDoanhThuCongTy -- tính tổng doanh thu công ty năm 2014
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE YEAR(OrderDate) = 2014 --lọc năm 2014
)
SELECT SalesPersonID,
		Totaldueyear, --tổng doanh thu theo năm của nhân viên 
		CAST (100.0 * v.Totaldueyear / t.TongDoanhThuCongTy AS DECIMAL(5,2)) AS Phantram --tính phần trăm doanh thu nv so với công ty
-- ghép bảng nhanvien và congty với nhau
FROM nhanvien v
CROSS JOIN congty t 
ORDER BY v.Totaldueyear DESC;

