USE db_LibraryManagementSystem
GO

CREATE PROC dbo.uspDrill1
AS
SELECT bookCopies_noOfCopies AS 'No. of The Lost Tribe', bookCopies_bookID AS 'Sharpstown' FROM tbl_BookCopies
WHERE bookCopies_bookID = 1 AND bookCopies_branchID = 1

GO