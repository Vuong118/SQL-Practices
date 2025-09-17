/*
Đề bài
Tạo bảng NhanVien với các cột
MaNV (int, khóa chính)
TenNV (nvarchar(50))
PhongBan (nvarchar(50))
Luong (decimal(10,2))
Thêm vào bảng 4 nhân viên bằng lệnh INSERT.
Cập nhật (UPDATE) lương cho 1 nhân viên bất kỳ.
Xóa (DELETE) 1 nhân viên thuộc phòng "IT".
Truy vấn (SELECT) để
Liệt kê tất cả nhân viên.
Tìm nhân viên có lương cao nhất.
Đếm số lượng nhân viên trong mỗi phòng ban.
*/

-- Tạo bảng nhanvien
CREATE TABLE nhanvien (
Manv INT PRIMARY KEY,
Tennv nvarchar(50),
Phongban Nvarchar(50),
Luong Decimal(10,2)
);


--Thêm dữ liệu 4 nhân viên
INSERT INTO nhanvien (Manv,Tennv,Phongban,Luong)
VALUES 
		(36,'Trương Tuấn Tú','IT',2000.00),
		(33,'Lê Đình Hoàng','Nhân sự',1000.00),
		(38,'Trương Văn Bắc','IT',8000.00),
		(2,'Lê Lan Hương','Kế toán ',90000.00);
--tăng gấp đôi lương nv
UPDATE nhanvien 
SET Luong = Luong * 2
WHERE Manv = 2;
--xóa 1 nv IT có lương cao hơn 3000.00
DELETE nhanvien
WHERE Phongban =N'IT' AND Luong > 3000.00;

SELECT
	Manv,
	Tennv,
	COUNT(Phongban) soluongnv,
	MAX (Luong) AS luongcaonhat 
	FROM nhanvien
	GROUP BY Manv,Tennv,Luong
	ORDER BY Luong DESC;
