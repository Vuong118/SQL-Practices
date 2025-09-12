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
	CustomerID,
	OrderDate,
	SalesOrderID,
LAG(OrderDate)
OVER (PARTITION BY CustomerID ORDER BY OrderDate) dontruoc,
LEAD (OrderDate)
OVER (PARTITION BY CustomerID ORDER BY OrderDate) donsau,
FIRST_VALUE(OrderDate)
OVER (PARTITION BY CustomerID ORDER BY OrderDate
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) dondau,
LAST_VALUE(OrderDate)
OVER (PARTITION BY CustomerID ORDER BY OrderDate
ROWS BETWEEN  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) doncuoi
  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
  ORDER BY CustomerID;