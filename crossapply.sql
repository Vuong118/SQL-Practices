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
 --lấy từng khách hàng duyệt qua bảng trong CROSS APPLY 
 CROSS APPLY (SELECT
					TOP 1 s.SalesOrderID, s.OrderDate --với mỗi khách hàng vừa lấy ,chạy vào bảng SalesOrderHeader 
		FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] s
			WHERE s.CustomerID = c.CustomerID --lọc dòng có CustomerID trùng với nhau

) AS d
ORDER BY CustomerID;