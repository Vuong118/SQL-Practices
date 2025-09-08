SELECT TOP (1000) [CustomerID]
      ,[PersonID]
      ,[StoreID]
      ,[TerritoryID]
      ,[AccountNumber]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Sales].[Customer]

SELECT CONCAT_WS(' ',c.CustomerID,n.FirstName,n.LastName) AS 'ten khach hang',
		o.*
FROM [AdventureWorks2022].[Sales].[Customer] AS c
INNER JOIN [AdventureWorks2022].[Person].[Person] AS n
	ON c.PersonID = n.BusinessEntityID
INNER JOIN [AdventureWorks2022].[Sales].[SalesOrderHeader] AS o
	ON c.CustomerID = o.CustomerID
Where n.LastName LIKE 'Smith%';