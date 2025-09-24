/*
Bài 1 – String Functions (quản lý khách hàng)

Bối cảnh: Bộ phận Marketing cần danh sách khách hàng để gửi email cá nhân hóa.
Yêu cầu:

Ghép FirstName + ' ' + LastName thành FullName.

Hiển thị FirstName viết hoa, LastName viết thường.

Lấy 3 ký tự đầu tiên trong LastName làm ShortCode.

Thay chữ a trong FirstName thành @.

Đếm độ dài EmailPromotion (dùng LEN).
*/
SELECT 
	CONCAT(p.FirstName,' ', p.LastName) fullname,
	UPPER(p.FirstName) viethoa,
	LOWER(p.LastName) vietthuong,
	SUBSTRING(p.LastName,1,3) ShortCode,
	REPLACE (p.FirstName,'a','@') thaychu,
	e.EmailAddress ,
	LEN(e.EmailAddress) dodai
FROM [AdventureWorks2022].[Person].[Person] p
JOIN [AdventureWorks2022].[Person].[EmailAddress] e
ON e.BusinessEntityID = p.BusinessEntityID;

