USE db_LibraryManagementSystem
GO

CREATE PROC dbo.uspDrill7
AS
SELECT book_title,bookCopies_noOfCopies FROM tbl_BookCopies
INNER JOIN tbl_BookAuthors ON bookauthors_authorName LIKE '%Stephen King%'
INNER JOIN tbl_Book ON book_id = bookCopies_bookID
WHERE bookCopies_branchID = 3 AND book_id = bookauthors_bookID

GO
