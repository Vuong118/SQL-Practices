/*
Bài 5 – View báo cáo doanh thu nâng cao (Views + tất cả)

Bối cảnh: Ban giám đốc muốn báo cáo bán hàng tổng hợp.

Tạo VIEW DoanhThuSanPham gồm:

ProductID,

SUM(OrderQty) tổng số lượng,

SUM(LineTotal) tổng doanh thu,

AVG(UnitPrice) giá trung bình,

MAX(OrderQty) đơn hàng lớn nhất.

Thêm cột DanhGia:

Nếu doanh thu > 1,000,000 → "Bán chạy".

Ngược lại → "Bán chậm".

Truy vấn top 5 sản phẩm có doanh thu cao nhất từ VIEW.
*/
CREATE VIEW DoanhThuSanPham AS 
SELECT 
p.ProductID,
SUM(s.OrderQty) tongsoluong,
SUM(s.LineTotal) tongdoanhthu,
AVG(s.UnitPrice) giatrungbinh,
MAX(s.OrderQty) dongiacaonhat,
CASE 
	WHEN SUM(s.LineTotal) > 1000000 THEN 'ban chay'
	ELSE 'ban cham'
END AS trangthai
FROM [AdventureWorks2022].[Sales].[SalesOrderDetail] s
JOIN [AdventureWorks2022].[Production].[Product] p
ON s.ProductID = p.ProductID
GROUP BY p.ProductID


SELECT  TOP 5 * FROM DoanhThuSanPham