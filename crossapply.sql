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
		c.CustomerID,
		d.OrderDate,
		d.SalesOrderID
 FROM [AdventureWorks2022].[Sales].[Customer] c
 CROSS APPLY (SELECT
					TOP 1 s.SalesOrderID, s.OrderDate
		FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] s
			WHERE s.CustomerID = c.CustomerID 
) AS d
ORDER BY CustomerID;

/*
lấy từng khách hàng duyệt qua bảng trong CROSS APPLY 
với mỗi khách hàng vừa lấy ,chạy vào bảng SalesOrderHeader 
lọc dòng có CustomerID trùng với nhau và xắp xếp theo orderdate

*/