SELECT TOP (1000) [ShipMethodID]
      ,[Name]
      ,[ShipBase]
      ,[ShipRate]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Purchasing].[ShipMethod]

SELECT t.Name,
AVG(DATEDIFF(DAY, s.OrderDate, s.ShipDate)) AS AvgShippingDays
FROM [AdventureWorks2022].[Purchasing].[ShipMethod] AS t
INNER JOIN [AdventureWorks2022].[Sales].[SalesOrderHeader] AS s
    ON t.ShipMethodID = s.ShipMethodID
WHERE s.ShipDate IS NOT NULL
GROUP BY t.Name
ORDER BY AvgShippingDays;

/* dùng datediff để tính số ngày vận chuyển 
dùng avg để tính trung bình 
nối bảng ShipMethod với SalesOrderHeader 
lọc bỏ dòng shipdate null 
nhóm cột name lại và sắp xếp theo trung bình số ngày ship */
