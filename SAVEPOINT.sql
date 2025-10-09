/*
Bài tập: Quản lý giao dịch bán hàng (AdventureWorks2022)
Mô tả:
Bạn là nhà phát triển cơ sở dữ liệu cho AdventureWorks2022. Bạn cần thực hiện
Kiểm tra số lượng sản phẩm có sẵn trong kho.
Tạo một bản ghi đơn hàng bán hàng mới.
Cập nhật số
Cập nhật thông tin khách hàng 
Bạn sẽ sử dụng SAVEPOINTđể đảm bảo
Yêu cầu:
Bắt đầu giao dịch: Bắt đầu một giao dịch mới.
Tạo SAVEPOINT check_inventory: Lưu trạng thái trước khi kiểm tra số lượng tồn tại.
Kiểm tra số lượng kho tồn tại: Kiểm tra lượng
Tạo SAVEPOINT create_order_header: Lưu trạng thái sau khi kiểm tra tồn tại.
Tạo đơn hàng: Thêm một bản ghi mới vàoSales.SalesOrderHeadervà Sales.SalesOrderDetail.
Tạo SAVEPOINT update_inventory: Lưu trạng thái sau khi tạo đơn hàng.
Cập nhật số lượng tồn kho: Giảm số lượng sản phẩm trong Production.ProductInventorysau khi bán hàng. 8
Tạo SAVEPOINT update_customer_points(Tùy chọn): Lưu trạng thái sau khi cập nhật kho
Kiểm tra lỗi: Giả sử có một lỗi xảy ra . Trong trường hợp này, hãy quay lạiSAVEPOINTthích hợp để hủy bỏ những thay đổi không mong muốn.
Hoàn thành tất cả giao dịch: Nếu không xảy ra lỗi, hãy thực hiện giao dịch.
*/

BEGIN TRAN
SAVE TRAN check_inventory
IF EXISTS (SELECT 1 FROM [AdventureWorks2022].[Production].ProductInventory WHERE ProductID = 707 AND LocationID = 7 AND Quantity >=10)
BEGIN 
SAVE TRAN create_order_header
INSERT INTO [AdventureWorks2022].[Sales].[SalesOrderHeader] (ShipToAddressID,BillToAddressID,CustomerID, OrderDate, DueDate, ShipDate, Status, SalesPersonID, TerritoryID, ShipMethodID, CreditCardID, CurrencyRateID, ModifiedDate)
VALUES (118,1,1, GETDATE(), GETDATE()+7, GETDATE()+3, 5, 279, 5, 5, 16281, 1, GETDATE());

DECLARE @SalesOrderID  INT = SCOPE_IDENTITY ();
INSERT INTO [AdventureWorks2022].[Sales].[SalesOrderDetail] (SpecialOfferID,SalesOrderID, OrderQty, ProductID, UnitPrice, UnitPriceDiscount, ModifiedDate)
VALUES (1,@SalesOrderID, 5, 707, 20.00, 0.00,GETDATE());
SAVE TRAN update_inventory
UPDATE [AdventureWorks2022].[Production].[ProductInventory] 
SET Quantity = Quantity - 5
WHERE ProductID =707 AND LocationID = 7
SAVE TRAN update_customer_points
COMMIT TRAN ;

END 
ELSE 
BEGIN 
ROLLBACK TRAN CHECK_INVEN
PRINT 'Không đủ số lượng sản phẩm trong kho.';
END;

-- 2. KIỂM TRA HEADER VÀ DETAIL CỦA ĐƠN HÀNG VỪA TẠO
SELECT TOP 1 
    H.SalesOrderID, 
    H.OrderDate, 
    D.ProductID, 
    D.OrderQty,
    D.UnitPrice,
    D.SpecialOfferID
FROM 
    Sales.SalesOrderHeader H
JOIN 
    Sales.SalesOrderDetail D ON H.SalesOrderID = D.SalesOrderID
WHERE 
    H.CustomerID = 1 
ORDER BY 
    H.SalesOrderID DESC; 


-- 3. KIỂM TRA SỐ LƯỢNG TỒN KHO SAU GIAO DỊCH
SELECT 
    ProductID, 
    LocationID, 
    Quantity AS New_Quantity
FROM 
    Production.ProductInventory
WHERE 
    ProductID = 707 AND LocationID = 7;