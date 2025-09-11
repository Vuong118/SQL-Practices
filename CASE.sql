SELECT TOP (1000) [ProductID]
      ,[Name]
      ,[ProductNumber]
      ,[MakeFlag]
      ,[FinishedGoodsFlag]
      ,[Color]
      ,[SafetyStockLevel]
      ,[ReorderPoint]
      ,[StandardCost]
      ,[ListPrice]
      ,[Size]
      ,[SizeUnitMeasureCode]
      ,[WeightUnitMeasureCode]
      ,[Weight]
      ,[DaysToManufacture]
      ,[ProductLine]
      ,[Class]
      ,[Style]
      ,[ProductSubcategoryID]
      ,[ProductModelID]
      ,[SellStartDate]
      ,[SellEndDate]
      ,[DiscontinuedDate]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Production].[Product];
WITH khongban AS (
SELECT 
		Name,
		SellEndDate,
		DiscontinuedDate,
		CASE 
		WHEN YEAR(SellEndDate) = 2013 AND SellEndDate IS NOT NULL THEN 'Không Bán Dược'
		ELSE 'còn bán '
		END AS conban
  FROM [AdventureWorks2022].[Production].[Product]
  WHERE  FinishedGoodsFlag = 1
)
SELECT 
		Name,
		SellEndDate,
		conban
FROM khongban
WHERE YEAR(SellEndDate) = 2012 AND  conban <> 'Con ban'
ORDER BY SellEndDate;
