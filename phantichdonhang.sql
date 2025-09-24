/*
Bài 3 – Phân tích đơn hàng (Numeric + String)

Bối cảnh: Sales cần phân tích chi tiết từng đơn hàng.

Tính ThanhTien .

Làm tròn ThanhTien xuống (FLOOR), lên (CEILING), và 2 số thập phân (ROUND).

Tạo OrderCode = SalesOrderID + ký tự đầu trong ProductID.

Nếu UnitPriceDiscount < 0.05 → ghi "Ít giảm giá", ngược lại "Giảm nhiều".
*/
WITH donhang AS (
SELECT 
	s.UnitPriceDiscount,
	s.SalesOrderID,
	s.ProductID,
	SUM(s.UnitPrice * s.OrderQty * (1 - s.UnitPriceDiscount)) thanhtien
FROM[AdventureWorks2022].[Sales].[SalesOrderDetail] s
GROUP BY s.SalesOrderID,s.ProductID,s.UnitPriceDiscount
)
SELECT
s.SalesOrderID,
s.thanhtien,
FLOOR (s.thanhtien) tronxuong,
CEILING(s.thanhtien) tronlen,
ROUND(s.thanhtien,2) sothapphan,
CONCAT (
	s.SalesOrderID ,', ',
	LEFT(s.ProductID,1)
) AS  OrderCode,
CASE 
WHEN s.UnitPriceDiscount < 0.05 THEN 'it giam gia'
ELSE 'giam gia nhieu'
END   AS discount
FROM donhang s