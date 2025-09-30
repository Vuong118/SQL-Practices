/*
Thủ tục kiểm tra tồn kho sản phẩm

Tạo stored procedure usp_CheckInventory với tham số @ProductID.

Nếu sản phẩm có trong Production.ProductInventory → trả về ProductID, Quantity.

Nếu không có → in ra thông báo "Sản phẩm không tồn tại trong kho".
*/

CREATE PROCEDURE prodc @productid INT 
AS 
BEGIN
    SET NOCOUNT ON;

    IF EXISTS 
    (
        SELECT 1 
        FROM [AdventureWorks2022].[Production].[ProductInventory]
        WHERE ProductID = @productid
    )
    BEGIN
        SELECT 
            ProductID,
            Quantity
        FROM [AdventureWorks2022].[Production].[ProductInventory]
        WHERE ProductID = @productid;
    END
ELSE 
BEGIN 
PRINT N'Không tìm thấy sản phẩm';
END
END;
GO
EXEC prodc  @productid = 33333