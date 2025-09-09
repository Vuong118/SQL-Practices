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

 SELECT c.CustomerID,
		s.AccountNumber
  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] AS s
  RIGHT JOIN [AdventureWorks2022].[Sales].[Customer] AS c
	ON c.CustomerID = s.CustomerID
	AND YEAR(s.OrderDate) = 2014
WHERE s.SalesOrderID IS NULL ;
/* dùng right join để lấy full thông tin từ bên khách hàng và lấy thêm dữ liệu trùng nhau từ bảng [SalesOrderHeader]
đk nối c.CustomerID = s.CustomerID và lọc chỉ lấy đơn hàng từ năm 2014
WHERE s.SalesOrderID IS NULL chỉ lấy những dòng là null */