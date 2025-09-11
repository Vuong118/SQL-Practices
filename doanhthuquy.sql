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
  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader];

WITH doanhthu AS (
SELECT 
    SUM(TotalDue) Doanhthuquy,
    DATEPART(QUARTER, OrderDate) AS Quy
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE YEAR(OrderDate) = 2013 
GROUP BY DATEPART(QUARTER, OrderDate)

),
tong AS (
SELECT 
		SUM(Doanhthuquy) AS Tongdoanhthu
		FROM doanhthu
)
SELECT 
		q.Doanhthuquy,
		q.Quy,
		CAST(100.0 * q.Doanhthuquy / t.Tongdoanhthu AS  DECIMAL(5,2)) AS tytrong
	FROM tong t CROSS JOIN doanhthu AS q
ORDER BY Quy;