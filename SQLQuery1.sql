SELECT TOP (1000) [DepartmentID]
      ,[Name]
      ,[GroupName]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[HumanResources].[Department]
SELECT Name AS n , CONCAT_WS(', ',DepartmentID  ,GroupName ,ModifiedDate) AS ad 
From [AdventureWorks2022].[HumanResources].[Department]
