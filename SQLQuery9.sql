SELECT TOP (1000) [CustomerID]
      ,[PersonID]
      ,[StoreID]
      ,[TerritoryID]
      ,[AccountNumber]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Sales].[Customer]

SELECT  c.CustomerID,
    p.FirstName,
    p.LastName,
    e.EmailAddress
FROM [AdventureWorks2022].[Sales].[Customer] AS c
INNER JOIN [AdventureWorks2022].[Person].[Person] AS p
    ON c.PersonID = p.BusinessEntityID
INNER JOIN [AdventureWorks2022].[Person].[EmailAddress] AS e
    ON p.BusinessEntityID = e.BusinessEntityID;
