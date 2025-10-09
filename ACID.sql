-- Dữ liệu kiểm tra ban đầu

SELECT SUM(i.Quantity) AS SoLuongTonKhoHienTai
FROM [AdventureWorks2022].[Production].[ProductInventory] i
WHERE i.ProductID = 318 AND i.LocationID = 5;

BEGIN TRANSACTION
UPDATE [AdventureWorks2022].[Production].[ProductInventory] 
SET Quantity = Quantity - 10
WHERE ProductID = 318

DECLARE @SOLUONGTHEM INT;
DECLARE @SALESORDERID INT = 43665;
DECLARE @PRODUCTID INT = 777;
SELECT 
 @SOLUONGTHEM = (OrderQty + 10)
FROM [AdventureWorks2022].[Sales].[SalesOrderDetail]

INSERT INTO  [AdventureWorks2022].[Sales].[SalesOrderDetail]  (SpecialOfferID,SalesOrderID,OrderQty,ProductID,UnitPrice,UnitPriceDiscount,rowguid,ModifiedDate)
VALUES (1,@SALESORDERID,@SOLUONGTHEM,@PRODUCTID,88.3636,36.36,NEWID(),GETDATE() )
BEGIN TRY
DECLARE @Quantity INT;
SELECT 
	Quantity 
FROM [AdventureWorks2022].[Production].[ProductInventory]
WHERE @Quantity = Quantity
BEGIN TRAN 
IF (@Quantity < 0 )
BEGIN 
ROLLBACK TRANSACTION;
PRINT 'SO LUONG KHONG DU '
END

ELSE 
BEGIN 
COMMIT TRANSACTION;
PRINT 'GIA DICH THÀNH CONG'
END 
END TRY 
BEGIN CATCH 
ROLLBACK TRAN ;
PRINT 'LỖI HE THONG'
END CATCH 