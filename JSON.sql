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
  FROM [AdventureWorks2022].[Production].[Product]


SELECT TOP 5
	ProductID,
	Name,
	ListPrice,
	CASE
		WHEN ListPrice < 100 THEN 'gi� re'
		WHEN ListPrice BETWEEN  100 AND 500 THEN 'trung b�nh'
		ELSE 'gi� cao'
		END AS Phanloai
	  FROM [AdventureWorks2022].[Production].[Product]
FOR JSON AUTO, ROOT('Products');