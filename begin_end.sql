DECLARE @VAR INT;

BEGIN
	SET @VAR = 1;
	WHILE @VAR < 10
	BEGIN
		PRINT @VAR 
		 SET @VAR = @VAR + 1 ;
	END;
END;
	

BEGIN TRY
    BEGIN TRAN;
    UPDATE [AdventureWorks2022].[Production].[ProductInventory]
    SET Quantity = Quantity - 3
    WHERE ProductID = 100;

    COMMIT TRAN;
END TRY
BEGIN CATCH
    PRINT N'Lỗi xảy ra, rollback!';
    ROLLBACK TRAN;
END CATCH;


BEGIN TRY
    BEGIN TRAN;

    PRINT N'Bắt đầu cập nhật tồn kho...';

    UPDATE [AdventureWorks2022].[Production].[ProductInventory]
    SET Quantity = Quantity - 3
    WHERE ProductID = 800;

    UPDATE [AdventureWorks2022].[Production].[ProductInventory]
    SET Quantity = 5 
    WHERE ProductID = 800;

    COMMIT TRAN;
    PRINT N'Cập nhật thành công!';
END TRY
BEGIN CATCH
    PRINT N'⚠️ Lỗi xảy ra, rollback!';
    ROLLBACK TRAN;

    PRINT N'Thông tin lỗi:';
    PRINT ERROR_MESSAGE();
END CATCH;

