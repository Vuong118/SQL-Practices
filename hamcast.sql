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

/*SELECT TOP 5 CustomerID,
		SUM(TotalDue) AS Tongtien,
		COUNT(*) AS Sodon
  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] 
  WHERE YEAR(OrderDate) = 2013
  GROUP BY CustomerID
  ORDER BY SUM(TotalDue) DESC;
*/
WITH nhanvien AS (
SELECT 
		SalesPersonID,
		SUM(TotalDue) AS Totaldueyear
	FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE YEAR(OrderDate) = 2014 AND SalesPersonID IS NOT NULL 
GROUP BY SalesPersonID

),
congty AS (
	SELECT SUM(TotalDue) AS TongDoanhThuCongTy
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE YEAR(OrderDate) = 2014
)
SELECT SalesPersonID,
		Totaldueyear,
		CAST (100.0 * v.Totaldueyear / t.TongDoanhThuCongTy AS DECIMAL(5,2)) AS Phantram
FROM nhanvien v CROSS JOIN congty t
ORDER BY v.Totaldueyear DESC;

/* 
tạo CTE nhanvien tính tổng doanh thu nv theo năm 2014	
tạo CTE cty tính tổng doanh thu cty 
nối 2 bảng lại dùng hàm CAST DECIMAL(5,2) để tính phần trăm doanh thu từng năm của nhân viên so với
% doanh thu của cty
*/