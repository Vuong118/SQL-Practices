/*
Bài toán quản lý hồ sơ nhân viên trong công ty
Tạo Cấu Trúc Bảng

Thêm và Sửa Đổi Dữ Liệu

Truy Vấn Dữ Liệu

Xóa Dữ Liệu
*/
CREATE TABLE SinhVien (
masv INT NOT NULL ,
tensv nVARCHAR(50) NOT NULL,
ngaysinh DATETIME NOT NULL
)

CREATE TABLE KhoaHoc (
makh INT NOT NULL PRIMARY KEY,
tenkh nVARCHAR(50) NOT NULL 
)

CREATE TABLE DangKy (
masv INT NOT NULL FOREIGN KEY REFERENCES SinhVien (masv),
makh INT NOT NULL FOREIGN KEY REFERENCES  KhoaHoc (makh),
ngaydangky DATETIME 
)
INSERT INTO DangKy VALUES
(1,1,23/9/2009),
(2,2,20/9/2009),
(3,3,21/9/2009),
(4,1,23/9/2009),
(5,1,20/9/2009),
(6,2,21/9/2009)


INSERT INTO SinhVien VALUES
(1,'truong tuan tu ',11/2/2000),
(2,'truong van bac ', 10/3/2003),
(3,'pham van dong ',25/6/2002),
(4,'truong tuan tai ',11/2/2000),
(5,'truong van giang ', 10/3/2003),
(6,'pham van tien ',25/6/2002)


INSERT INTO KhoaHoc VALUES
(1,'co so du lieu'),
(2,'phat trien web'),
(3,'lap trinh game' )

SELECT 
	d.masv,
	s.tensv,
	k.tenkh
	
FROM DangKy d
JOIN SinhVien s
ON d.masv = s.masv
JOIN KhoaHoc k
ON d.makh = k.makh 
WHERE k.tenkh = 'co so du lieu ';


SELECT 
	k.tenkh,
	COUNT(d.masv) soluongsv
	
FROM DangKy d
JOIN KhoaHoc k
ON d.makh = k.makh 
GROUP BY k.tenkh

DELETE DangKy
WHERE masv =3

UPDATE DangKy
SET ngaydangky = '02/07/2003'
WHERE masv = 1
