USE db_LibraryManagementSystem
GO

CREATE PROC dbo.uspDrill5
AS
SELECT libraryBranch_branchName, COUNT(bookLoans_BranchID) AS 'Number of Loaned Books' FROM tbl_LibraryBranch
INNER JOIN tbl_BookLoans ON bookLoans_branchID = libraryBranch_branchID
GROUP BY libraryBranch_branchName
GO