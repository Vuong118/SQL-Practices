/*
ĐỀ Bài – Tìm nhân viên "đa phòng ban"

Trong bảng HumanResources.EmployeeDepartmentHistory:

Hãy tìm tất cả nhân viên từng làm ở từ 2 phòng ban trở lên.

Kết quả gồm: BusinessEntityID,JobTitle, SoPhongBan, DanhSachPhongBan.
*/
SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    COUNT(d.DepartmentID) AS sophongban,
    STRING_AGG(d.Name,' / ') AS danhsachphongban
FROM [AdventureWorks2022].[HumanResources].[Employee] e
JOIN [AdventureWorks2022].[HumanResources].[EmployeeDepartmentHistory] edh
    ON e.BusinessEntityID = edh.BusinessEntityID
JOIN [AdventureWorks2022].[HumanResources].[Department] d
    ON edh.DepartmentID = d.DepartmentID
GROUP BY e.BusinessEntityID, e.JobTitle
HAVING COUNT(d.DepartmentID) >= 2;
