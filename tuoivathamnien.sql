/*
Bài 2 – Thâm niên và tuổi (Date/Time + Conditional)

Bối cảnh: HR muốn danh sách nhân viên kèm tuổi và thâm niên.

Tính Tuoi 
Tính SoNamLamViec 

Thêm cột "XepLoai":

Nếu thâm niên < 10 → "Mới".

Nếu 10–15 → "Kinh nghiệm".

Nếu > 15 → "Cựu binh".

nối thêm bài quản lý khách hàng vào 
hiển thị full name , tên hoa ,tên thường ,short code

*/
WITH nhanvien AS (
SELECT 
	CONCAT(p.FirstName,' ', p.LastName) fullname,
	UPPER(p.FirstName) tenhoa,
	LOWER(p.LastName) tenthuong,
	SUBSTRING(p.LastName,1,3) ShortCode,
	REPLACE (p.FirstName,'a','@') thaychu,
	e.EmailAddress ,
	LEN(e.EmailAddress) dodai,
	p.BusinessEntityID
FROM [AdventureWorks2022].[Person].[Person] p
JOIN [AdventureWorks2022].[Person].[EmailAddress] e
ON e.BusinessEntityID = p.BusinessEntityID

),
sotuoi AS (
SELECT 
	DATEDIFF(YEAR,e.BirthDate,GETDATE()) Tuoi,
	DATEDIFF(YEAR,e.HireDate,GETDATE()) Sonamlamviec,
	e.BusinessEntityID
FROM [AdventureWorks2022].[HumanResources].[Employee] e

),
sapxep AS (
SELECT 
BusinessEntityID,
Tuoi,
Sonamlamviec,

CASE 
		WHEN Sonamlamviec < 10 THEN 'new'
		WHEN Sonamlamviec BETWEEN 10 AND 15 THEN 'experienced'
		WHEN Sonamlamviec > 15 THEN 'master'
END AS XepLoai
FROM sotuoi
)
SELECT 
	v.BusinessEntityID,
	v.fullname,
	v.tenhoa,
	v.tenthuong,
	s.Tuoi,
	s.Sonamlamviec,
	s.XepLoai
FROM sapxep s
JOIN nhanvien v
ON s.BusinessEntityID = v.BusinessEntityID