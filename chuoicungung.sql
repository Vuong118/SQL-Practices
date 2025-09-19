/*
Bài toán 3: Phân tích chuỗi cung ứng sản phẩm (Product Supply Chain Analysis)
Tình huống: Bạn muốn tìm những sản phẩm có nhiều nhà cung cấp nhất.
Thử thách:
Viết truy vấn để liệt kê các sản phẩm (tên sản phẩm) và số lượng nhà cung cấp của chúng, sau đó sắp xếp theo thứ tự giảm dần số lượng nhà cung cấp.
*/
WITH vendor AS (
SELECT
	p.Name,
	
	COUNT (pv.BusinessEntityID) so_nhataitro
FROM [AdventureWorks2022].[Production].[Product] p
JOIN [AdventureWorks2022].[Purchasing].[ProductVendor] pv
ON p.ProductID = pv.ProductID
JOIN [AdventureWorks2022].[Purchasing].[Vendor] v
ON pv.BusinessEntityID = v.BusinessEntityID
GROUP BY p.Name
)
SELECT 
	c.Name AS ten_sanpham,
	v.Name AS ten_nhataitro,
	c.so_nhataitro
FROM vendor c
CROSS JOIN [AdventureWorks2022].[Purchasing].[Vendor] v
ORDER BY c.so_nhataitro DESC;