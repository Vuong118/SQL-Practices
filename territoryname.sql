SELECT TOP (1000) [TerritoryID]
      ,[Name]
      ,[CountryRegionCode]
      ,[Group]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[CostYTD]
      ,[CostLastYear]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Sales].[SalesTerritory]
SELECT t.Name,
	COUNT(c.CustomerID) AS 'Soluongkhachhang'
FROM [AdventureWorks2022].[Sales].[SalesTerritory] AS t
INNER JOIN [AdventureWorks2022].[Sales].[Customer] AS c
	ON c.TerritoryID = t.TerritoryID
GROUP BY t.Name
ORDER BY COUNT(c.CustomerID)  DESC;

/* dùng count đếm số lượng khách hàng 
nối 2 bảng lại vs khóa c.TerritoryID = t.TerritoryID
nhóm name lại và sắp xếp lại theo số lượng khách hàng giảm dần */