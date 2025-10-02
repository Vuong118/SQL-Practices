/*
ghi lại sự thay đổi lương mới cho một nhân viên vào bảng lịch sử.
Tên SP: usp_UpdateEmployeeSalary
Tham số IN:
@BusinessEntityID INT 
@NewSalary MONEY 
Yêu cầu:
INSERT: Thêm một bản ghi mới vào bảng HumanResources.EmployeePayHistory với các thông tin sau:
BusinessEntityID 
RateChangeDate 
Rate 
PayFrequency .
*/

ALTER PROCEDURE usp_UpdateEmployeeSalary @BusinessEntityID INT, @NewSalary MONEY 
AS 
BEGIN
INSERT INTO  [AdventureWorks2022].[HumanResources].[EmployeePayHistory] (BusinessEntityID,RateChangeDate,Rate, PayFrequency) 
VALUES (@BusinessEntityID, GETDATE(), @NewSalary, 2);
 SELECT 'Lương mới đã được ghi nhận thành công.' AS Result,*
FROM [AdventureWorks2022].[HumanResources].[EmployeePayHistory] e
	END
EXEC usp_UpdateEmployeeSalary @BusinessEntityID = 3, @NewSalary = 35.00;