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
		[1] AS M01,[2] AS M02,[3] AS M03 ,[4] AS M04 ,[5] AS M05, [6] AS M06,[7] AS M07,
		[8] AS M08, [9] AS M09, [10] AS M10, [11] AS M11, [12] AS M12
	FROM (
	SELECT MONTH(OrderDate) AS OrderMonth, TotalDue
	FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
	WHERE YEAR(OrderDate) = 2013
)  AS s
PIVOT (
	SUM(TotalDue) FOR OrderMonth IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
)  AS p

/* tạo bảng con ;lấy tháng tách tháng ra từ orderdate va totaldue
pivot xoay tháng vừa tách ra thành cột 
lọc ra chỉ lấy dữ liệu ở năm 2013
tính tổng totaldue theo từng tháng

*/