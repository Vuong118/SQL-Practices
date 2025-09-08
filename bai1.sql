SELECT TOP (1000) [CustomerID]
      ,[AddressID]
      ,[AddressType]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorksLT2022].[SalesLT].[CustomerAddress]

SELECT *  FROM [AdventureWorksLT2022].[SalesLT].[Address] AS c
	INNER JOIN [AdventureWorksLT2022].[SalesLT].[CustomerAddress] AS ca
		ON c.AddressID = ca.AddressID
  Where c.AddressID = 621;
