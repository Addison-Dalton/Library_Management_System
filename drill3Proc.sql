USE db_LibraryManagementSystem
GO

CREATE PROC dbo.uspDrill3
AS
SELECT borrower_name FROM tbl_Borrower
WHERE NOT EXISTS (SELECT 1 FROM tbl_BookLoans WHERE bookLoans_cardNo = borrower_cardNo)
GO