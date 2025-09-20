/*
Phân tích tồn kho sản phẩm
Đề bài
Viết một truy vấn SQL để phân tích tình trạng tồn kho của các sản phẩm. Với mỗi sản phẩm, bạn cần xác định xem nó có đang được bán chậm hay không.

Yêu cầu:

Tính tổng số lượng bán (OrderQty) của mỗi sản phẩm (ProductID) trong năm 2022.

Tính tổng số lượng tồn kho (Quantity) của mỗi sản phẩm từ bảng Production.ProductInventory.

Xác định Tỷ lệ tồn kho trên doanh số (InventoryToSalesRatio) bằng cách chia tổng tồn kho cho tổng số lượng bán.

Phân loại sản phẩm dựa trên tỷ lệ này:

'Excessive': Nếu tỷ lệ > 50 (tồn kho gấp hơn 50 lần doanh số).

'Normal': Nếu tỷ lệ từ 10 đến 50.

'Low': Nếu tỷ lệ < 10.

'N/A': Nếu không có doanh số nào
*/
WITH tonkho AS (
SELECT
        ProductID,
        SUM(Quantity) AS tongtonkho
    FROM [AdventureWorks2022].[Production].[ProductInventory] 
    GROUP BY ProductID
 ),
 banra AS (
    SELECT
        ProductID,
        SUM(OrderQty) AS tongbanra
    FROM[AdventureWorks2022].[Sales].[SalesOrderDetail]
	GROUP BY ProductID
	
	),
 TL AS (
 SELECT 
	p.Name,
	p.ProductID,
	ISNULL(tongtonkho,0) tongtonkho, 
	COALESCE (tongbanra,0) tongbanra,
	CAST(ISNULL(tongtonkho, 0) AS FLOAT)/ NULLIF(COALESCE(tongbanra, 0), 0) AS tyletonkho
 FROM Production.Product AS p
    LEFT JOIN tonkho AS pis ON p.ProductID = pis.ProductID
    LEFT JOIN banra AS pss ON p.ProductID = pss.ProductID
)
 SELECT 
	ProductID,
	Name,
	tyletonkho,
	CASE 
		WHEN tongbanra = 0 AND tongtonkho > 0 THEN 'N\A'
		WHEN tyletonkho > 50 THEN 'cao'
		WHEN tyletonkho < 10 THEN 'thap'
		WHEN tyletonkho BETWEEN 10 AND  50 THEN 'binhthuong'
		ELSE 'N\A'
	END ketqua
FROM TL 
ORDER BY tyletonkho DESC ;