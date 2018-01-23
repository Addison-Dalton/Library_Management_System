USE db_LibraryManagementSystem
GO

CREATE PROC dbo.uspDrill2
AS
SELECT bookCopies_noOfCopies AS 'No. of The Lost Tribe', bookCopies_branchID AS BranchID FROM tbl_BookCopies
WHERE bookCopies_bookID = 1

GO