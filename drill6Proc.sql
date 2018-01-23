USE db_LibraryManagementSystem
GO

CREATE PROC dbo.uspDrill6
AS
SELECT borrower_name, borrower_address, COUNT(bookLoans_cardNo) AS 'Number of books checked out' FROM tbl_Borrower
INNER JOIN tbl_BookLoans ON bookLoans_cardNo = borrower_cardNo
GROUP BY borrower_name, borrower_address
HAVING COUNT(bookLoans_cardNo) > 5
GO