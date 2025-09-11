SELECT TOP (1000) [SalesOrderID]
      ,[RevisionNumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[Status]
      ,[OnlineOrderFlag]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[AccountNumber]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[TerritoryID]
      ,[BillToAddressID]
      ,[ShipToAddressID]
      ,[ShipMethodID]
      ,[CreditCardID]
      ,[CreditCardApprovalCode]
      ,[CurrencyRateID]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]
      ,[Comment]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader];

WITH danhsach AS (
    SELECT CustomerID,
           DATEFROMPARTS(YEAR(OrderDate), MONTH(OrderDate), 1) AS thang,
           COUNT(*) AS SoDon
    FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
    GROUP BY CustomerID, YEAR(OrderDate), MONTH(OrderDate)
),
sapxep AS (
    SELECT CustomerID,
           thang,
           SoDon,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY thang) AS row
    FROM danhsach
),
chuoi AS (
    SELECT CustomerID,
           thang,
           SoDon,
           DATEADD(MONTH, -row, thang) AS grp
    FROM sapxep
),
hon3 AS (
    SELECT CustomerID, grp
    FROM chuoi
    GROUP BY CustomerID, grp
    HAVING COUNT(*) >= 3
)
SELECT c.CustomerID,
		t.thang
FROM hon3 AS c
INNER JOIN chuoi AS t ON c.CustomerID = t.CustomerID
GROUP BY c.CustomerID,t.thang
ORDER BY CustomerID;


/* bảng danhsach để lấy tháng có đơn theo khách hàng 
dùng hàm DATEFROMPARTS để gộp lại số lần mua trong 1 tháng thành 1 lần
COUNT để đếm số đơn 
bảng sapxep dùng row_number để đánh dấu số tháng bắt đầu từ 1
lấy dữ liệu từ bảng danhsach
bảng chuoi dùng hàm DATEADD dùng biến dãy tháng liên tiếp thành 1 mốc chung để gom nhóm lại
bảng hon3 dùng nhóm lại customerid và  grp tìm những khách hàng đã mua >= 3 tháng liên tiếp
nối bảng hon3 và chuoi lại để nhóm lại và in ra id khách hàng và những tháng đã mua hàng liên tiếp
*/