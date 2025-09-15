/*
bài toán : với mỗi khách hàng tìm đơn hàng đầu tiên họ đặt
*/
SELECT
    c.CustomerID,
    d.OrderDate,
    d.SalesOrderID
FROM [AdventureWorks2022].[Sales].[Customer] c
CROSS APPLY (
    SELECT TOP 1 s.SalesOrderID, s.OrderDate
    FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] s
    WHERE s.CustomerID = c.CustomerID
    ORDER BY s.OrderDate ASC  -- đơn đầu tiên
) AS d
ORDER BY c.CustomerID;
