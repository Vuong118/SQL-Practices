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

SELECT YEAR(n.OrderDate) AS 'Nam',
	SUM(t.LineTotal) AS 'Doanhthutheonam'
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] AS n
INNER JOIN [AdventureWorks2022].[Sales].[SalesOrderDetail] AS t
	ON n.SalesOrderID = t.SalesOrderID
GROUP BY YEAR(OrderDate)
 ORDER BY YEAR(OrderDate) ASC;
 
 /* dùng hàm YEAR để lọc lấy năm 
 sum để tính tổng doanh thu 
 nối 2 bảng SalesOrderHeader và SalesOrderDetail lại 
 GROUP YEAR(OrderDate) nhóm lại để tính tổng doanh thu mỗi năm
 ORDER BY YEAR(OrderDate) ASC để sắp xếp theo thứ tự từng năm */