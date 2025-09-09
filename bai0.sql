SELECT TOP (1000) [SalesOrderID]
      ,[RevisionNumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[Status]
      ,[OnlineOrderFlag]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[AccountNumber]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[TerritoryID]
      ,[BillToAddressID]
      ,[ShipToAddressID]
      ,[ShipMethodID]
      ,[CreditCardID]
      ,[CreditCardApprovalCode]
      ,[CurrencyRateID]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]
      ,[Comment]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]


SELECT 
	
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] AS h
INNER JOIN [AdventureWorks2022].[Sales].[SalesOrderDetail] AS s
	ON h.SalesOrderID = s.SalesOrderID
INNER JOIN [AdventureWorks2022].[Sales].[Customer] AS c
	ON h.CustomerID = c.CustomerID
INNER JOIN [AdventureWorks2022].[Person].[Person] AS ps
	ON c.PersonID  = ps.BusinessEntityID
INNER JOIN [AdventureWorks2022].[Person].[EmailAddress] AS e
	ON ps.PersonID = e.BusinessEntityID
INNER JOIN [AdventureWorks2022].[Production].[Product] AS p
	ON s.ProductID = p.ProductID
INNER JOIN [AdventureWorks2022].[Sales].[SalesPerson] AS sr
	ON h.SalesPersonID = sr.BusinessEntityID
