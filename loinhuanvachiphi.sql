/*
ĐỀ BÀI :Phân tích Chi tiết Lợi nhuận và Chi phí Đơn hàng Bán hàng 
Sử dụng các bảng Sales.SalesOrderDetail và Production.Product,
hãy tạo một báo cáo chi tiết các thông tin cho mỗi mặt hàng trong các đơn hàng bán hàng
*/

SELECT 

p.ProductID,

p.Name,

sod.OrderQty,

sod.UnitPrice,

p.StandardCost,

CAST (COALESCE (p.StandardCost,10.00) AS FLOAT ) chiphi,

(sod.UnitPrice - COALESCE (p.StandardCost,10.00))*sod.OrderQty AS Loinhuan, 
CASE 
WHEN (sod.UnitPrice - COALESCE (p.StandardCost,10.00))*sod.OrderQty > 100 THEN 'Loi nhuan cao'

WHEN (sod.UnitPrice - COALESCE (p.StandardCost,10.00))*sod.OrderQty BETWEEN 10 AND 100 THEN 'Loi nhuan vua phai'

WHEN  (sod.UnitPrice - COALESCE (p.StandardCost,10.00))*sod.OrderQty < 10 THEN 'Khong co loi nhuan'
END AS phanloai ,
ROUND ((sod.UnitPrice - COALESCE (p.StandardCost,10.00))*sod.OrderQty , 2) lamtron,

(CAST(ROUND((SOD.UnitPrice - COALESCE(P.StandardCost, 10.00)) * SOD.OrderQty, 0) AS INT) % 5 + 5) % 5 AS SODU,

ABS (sod.UnitPrice-COALESCE (p.StandardCost,10.00)) chenhlechtuyetdoi,

 CASE
        WHEN COALESCE(NULLIF(SOD.UnitPrice, COALESCE(p.StandardCost, 10.00)), 0) = 0 THEN 'No Difference' 
        WHEN CEILING(ABS(SOD.UnitPrice - COALESCE(P.StandardCost, 10.00)) / CAST(COALESCE(P.StandardCost, 10.00) AS FLOAT)) > 1 THEN 'khac nhieu'
        ELSE 'khac it'
    END AS khacbiet,
FLOOR ((sod.UnitPrice - COALESCE (p.StandardCost,10.00))*sod.OrderQty) giatriloinhuan

FROM [AdventureWorks2022].[Sales].[SalesOrderDetail] sod

JOIN [AdventureWorks2022].[Production].[Product] p

ON p.ProductID = sod.ProductID