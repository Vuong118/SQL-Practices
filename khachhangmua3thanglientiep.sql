/*
Bài toán : tìm danh sách khách hàng có đơn mua 3 tháng liên tiếp 

dùng CTE (Common Table Expression) để tách các bước logic.
ROW_NUMBER() để đánh số thứ tự tháng.
GROUP BY + HAVING để lọc chuỗi dài ≥ 3 tháng.
*/


--bảng danhsach để lấy tháng có đơn theo khách hàng 
WITH danhsach AS (
    SELECT CustomerID,
		--dùng hàm DATEFROMPARTS để gộp sô lần mua trong tháng của năm đó thành 1 ngày và cho ngày đó bằng 1 để tạo ngày đầu tháng 
           DATEFROMPARTS(YEAR(OrderDate), MONTH(OrderDate), 1) AS thang,
           COUNT(*) AS SoDon -- đếm số đơn 
    FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
    GROUP BY CustomerID, YEAR(OrderDate), MONTH(OrderDate)
),
--bảng sapxep dùng row_number để đánh dấu số tháng bắt đầu từ 1
sapxep AS (
    SELECT CustomerID,
           thang,
           SoDon,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY thang) AS row
    FROM danhsach --lấy dữ liệu từ bảng danhsach
),
--bảng chuoi dùng hàm DATEADD để đưa các tháng liên tiếp về cùng 1 nhóm để dễ kiểm tra chuỗi tháng liên tục
chuoi AS (
    SELECT CustomerID,
           thang,
           SoDon,
           DATEADD(MONTH, -row, thang) AS grp
    FROM sapxep
),
--bảng hon3 dùng nhóm lại customerid và  grp tìm những khách hàng đã mua >= 3 tháng liên tiếp
hon3 AS (
    SELECT CustomerID, grp
    FROM chuoi
    GROUP BY CustomerID, grp
    HAVING COUNT(*) >= 3
)
SELECT c.CustomerID,
		t.thang
--nối bảng hon3 và chuoi lại để nhóm lại và in ra id khách hàng và những tháng đã mua hàng liên tiếp
FROM hon3 AS c
INNER JOIN chuoi AS t ON c.CustomerID = t.CustomerID
GROUP BY c.CustomerID,t.thang
ORDER BY CustomerID;