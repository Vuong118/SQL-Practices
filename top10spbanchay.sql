SELECT TOP (1000) [SalesOrderID]
      ,[SalesOrderDetailID]
      ,[CarrierTrackingNumber]
      ,[OrderQty]
      ,[ProductID]
      ,[SpecialOfferID]
      ,[UnitPrice]
      ,[UnitPriceDiscount]
      ,[LineTotal]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Sales].[SalesOrderDetail]

SELECT TOP 10  s.OrderQty,
	p.ProductID,
	p.Name
FROM [AdventureWorks2022].[Sales].[SalesOrderDetail] AS s
INNER JOIN [AdventureWorks2022].[Production].[Product] AS p
	ON s.ProductID = p.ProductID
ORDER BY s.OrderQty DESC;