USE db_LibraryManagementSystem
GO

CREATE PROC dbo.uspDrill4
AS
SELECT book_title, borrower_name, borrower_address FROM tbl_BookLoans
INNER JOIN tbl_Book ON book_id = bookLoans_bookID
INNER JOIN tbl_Borrower ON bookLoans_cardNo = borrower_cardNo
WHERE bookLoans_branchID = 1 AND bookLoans_dateDue = '2-20-2018' --I did this date because the datebase doesn't contain books for the day I wrote this.
GO