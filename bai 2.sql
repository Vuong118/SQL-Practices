SELECT TOP (1000) [AddressID]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[City]
      ,[StateProvince]
      ,[CountryRegion]
      ,[PostalCode]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorksLT2022].[SalesLT].[Address]

Update [AdventureWorksLT2022].[SalesLT].[Address]
SET AddressLine1 = 'Thuan Thanh',AddressLine2 ='Mao Dien',City = 'Bac Ninh',StateProvince = 'Bac Ninh',CountryRegion = 'Viet Nam'
Where AddressID Between 600 And 700;
Insert Into [AdventureWorksLT2022].[SalesLT].[Address] (AddressLine1,City,StateProvince,CountryRegion,PostalCode)
Values ('BInh Cau','Bac Ninh','Bac Ninh','Viet Nam',118203);
Select Count (AddressID),City
FROM [AdventureWorksLT2022].[SalesLT].[Address]
Group By City
Order By City;