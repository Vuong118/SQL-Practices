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
  FROM [AdventureWorks2022].[Sales].[SalesTerritory];


   SELECT 
        s.Name AS TerritoryName,
        sh.SalesPersonID,
		sh.TotalDue,
        RANK()OVER(PARTITION BY s.TerritoryID ORDER BY sh.TotalDue ASC) AS 'Rank'
    FROM [AdventureWorks2022].[Sales].[SalesTerritory] AS s
    INNER JOIN [AdventureWorks2022].[Sales].[SalesPerson] AS sp
        ON s.TerritoryID = sp.TerritoryID
    INNER JOIN [AdventureWorks2022].[Sales].[SalesOrderHeader] AS sh
        ON sh.SalesPersonID = sp.BusinessEntityID
    WHERE YEAR(sh.OrderDate) = 2014;


/* dùng hàm rank để xếp hạng nhân viên 
PARTITION dùng để chia từng khu vực thành nhóm nhỏ rồi dùng order by xếp hạng theo thứ tự
nối bảng SalesTerritory với bảng SalesPerson  qua khóa  Territory
nối bảng SalesPerson với SalesOrderHeader qua SalesPersonID,BusinessEntityID
lọc orderdate để tìm năm 2014 */