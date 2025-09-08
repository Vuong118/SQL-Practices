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

SELECT TOP 5 SUM(o.OrderQty),n.Name
FROM [AdventureWorks2022].[Sales].[SalesOrderDetail] AS o
INNER JOIN [AdventureWorks2022].[Production].[Product] AS n
	ON o.ProductID = n.ProductID
GROUP BY n.Name 
ORDER BY SUM (o.OrderQty) DESC;