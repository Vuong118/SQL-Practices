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
LAG(OrderDate) --dùng lag để lấy dữ liệu từ đơn trước 
OVER (PARTITION BY CustomerID ORDER BY OrderDate) dontruoc,-- mỗi khách hàng xét riêng sắp xếp theo ngày đặt xác định đơn trước 
LEAD (OrderDate)--dùng lead để lấy dữ liệu từ đơn sau  
OVER (PARTITION BY CustomerID ORDER BY OrderDate) donsau,
FIRST_VALUE(OrderDate) -- lấy giá trị đầu tiên của bảng 
OVER (PARTITION BY CustomerID ORDER BY OrderDate -- chia dữ liệu theo từng khách hàng rồi sắp xếp theo orderdate
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING -- phạm vi từ giá trị tiên đến gía trị cuối cùng 
) dondau,
LAST_VALUE(OrderDate)-- lấy giá trị cuối cùng của bảng
OVER (PARTITION BY CustomerID ORDER BY OrderDate
ROWS BETWEEN  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING-- phạm vi từ giá trị tiên đến gía trị cuối cùng 
) doncuoi
  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
  ORDER BY CustomerID;