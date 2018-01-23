USE db_LibraryManagementSystem
GO

CREATE PROC dbo.Populate_db_LibraryManagementSystem
AS
BEGIN

	/******************************************************
	 * If our tables already exist, drop and recreate them
	 ******************************************************/
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES tbl_Book)
		DROP TABLE tbl_BookAuthors, tbl_BookLoans, tbl_Borrower, tbl_BookCopies, tbl_Book, tbl_LibraryBranch, tbl_Publisher;
		
		
	/******************************************************
	 * Build our database tables and define ther schema
	 ******************************************************/
	CREATE TABLE tbl_Publisher (
	publisher_name VARCHAR(50) PRIMARY KEY NOT NULL,
	publisher_address VARCHAR(50) NOT NULL,
	publisher_phone VARCHAR(30) NOT NULL
	);

	CREATE TABLE tbl_Book (
		book_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
		book_title VARCHAR(50) NOT NULL,
		book_publisherName VARCHAR(50) NOT NULL CONSTRAINT fk_publisher_name FOREIGN KEY REFERENCES tbl_Publisher(publisher_name) ON UPDATE CASCADE ON DELETE CASCADE 
	);

	CREATE TABLE tbl_BookAuthors (
		bookauthors_bookID INT NOT NULL CONSTRAINT fk_authors_bookID FOREIGN KEY REFERENCES tbl_book(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
		bookauthors_authorName VARCHAR(50) NOT NULL,
		CONSTRAINT pk_authorID PRIMARY KEY (bookauthors_bookid, bookauthors_authorName)
	);

	CREATE TABLE tbl_Borrower (
		borrower_cardNo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
		borrower_name VARCHAR(50) NOT NULL,
		borrower_address VARCHAR(50) NOT NULL,
		borrower_phone VARCHAR(30) NOT NULL
	);

	CREATE TABLE tbl_LibraryBranch (
		libraryBranch_branchID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
		libraryBranch_branchName VARCHAR(50) NOT NULL,
		libraryBranch_address VARCHAR(50) NOT NULL
	);

	CREATE TABLE tbl_BookCopies (
		bookCopies_bookID INT NOT NULL CONSTRAINT fk_bookCopies_bookID FOREIGN KEY REFERENCES tbl_Book(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
		bookCopies_branchID INT NOT NULL CONSTRAINT fk_bookCopies_branchID FOREIGN KEY REFERENCES tbl_LibraryBranch(libraryBranch_branchID) ON UPDATE CASCADE ON DELETE CASCADE,
		bookCopies_noOfCopies INT NOT NULL,
		CONSTRAINT pk_bookCopiesID PRIMARY KEY (bookCopies_bookID, bookCopies_branchID)
	);

	CREATE TABLE tbl_BookLoans (
		bookLoans_bookID INT NOT NULL CONSTRAINT fk_bookLoans_bookID FOREIGN KEY REFERENCES tbl_Book(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
		bookLoans_branchID INT NOT NULL CONSTRAINT fk_bookLoans_branchID FOREIGN KEY REFERENCES tbl_LibraryBranch(libraryBranch_branchID) ON UPDATE CASCADE ON DELETE CASCADE,
		bookLoans_cardNo INT NOT NULL CONSTRAINT fk_bookLoans_cardNo FOREIGN KEY REFERENCES tbl_Borrower(borrower_cardNo) ON UPDATE CASCADE ON DELETE CASCADE,
		bookLoans_dateOut DATE NOT NULL,
		bookLoans_dateDue DATE NOT NULL,
		CONSTRAINT pk_bookLoansID PRIMARY KEY (bookLoans_bookID, bookLoans_branchID, bookLoans_cardNo)
	);

	/******************************************************
		 * Populate tables
	******************************************************/
	INSERT INTO tbl_Publisher
	(publisher_name, publisher_address, publisher_phone)
	VALUES
	('Ten-Penny Press', '11 Street Rd. New York, New York', '111-111-1111'),
	('Printing-Pages', '123 Avenue Ln. Denver, CO.', '222-222-2222')
	;

	INSERT INTO tbl_Book
	(book_title, book_publisherName)
	VALUES
	('The Lost Tribe', 'Ten-Penny Press'),
	('The Great Gatsby', 'Ten-Penny Press'),
	('The Grapes of Wrath', 'Ten-Penny Press'),
	('Nineteen Eighty-Four','Ten-Penny Press'),
	('Ulysses', 'Ten-Penny Press'),
	('Lolita', 'Ten-Penny Press'),
	('Catch-22', 'Ten-Penny Press'),
	('The Catcher in the Rye', 'Ten-Penny Press'),
	('Beloved', 'Ten-Penny Press'),
	('The Sound and the Fury', 'Ten-Penny Press'),
	('To Kill a Mockingbird', 'Printing-Pages'),
	('The Lord of the Rings', 'Printing-Pages'),
	('One Hundred Years of Solitude', 'Printing-Pages'),
	('Brave New World', 'Printing-Pages'),
	('To the Lighthouse', 'Printing-Pages'),
	('Invisible Man', 'Printing-Pages'),
	('Gone with the Wind', 'Printing-Pages'),
	('Jane Eyre', 'Printing-Pages'),
	('On the Road', 'Printing-Pages'),
	('Pride and Prejudice', 'Printing-Pages'),
	('Lord of the Flies', 'Printing-Pages'),
	('IT', 'Ten-Penny Press'),
	('Misery', 'Ten-Penny Press')
	;

	INSERT INTO tbl_BookAuthors
	(bookauthors_bookID, bookauthors_authorName)
	VALUES
	(1, 'Brad Manuel'),
	(2, 'F. Scott Fitzgerald'),
	(3, 'John Steinbeck'),
	(4, 'George Orwell'),
	(5, 'James Joyce'),
	(6, 'Vladimir Nabokov'),
	(7, 'Joseph Heller'),
	(8, 'J.D. Salinger'),
	(9, 'Toni Morrison'),
	(10, 'William Faulkner'),
	(11, 'Harper Lee'),
	(12, 'J.R.R. Tolkien'),
	(13, 'Gabriel Garcia Marquez'),
	(14, 'Aldous Huxley'),
	(15, 'Virginia Woolf'),
	(16, 'Ralph Ellison'),
	(17, 'Margaret Mitchell'),
	(18, 'Charlotte Bronte'),
	(19, 'Jack Kerouac'),
	(20, 'Jane Austen'),
	(21, 'William Golding'),
	(22, 'Stephen King'),
	(23, 'Stephen King')
    ;

	INSERT INTO tbl_Borrower
	(borrower_name, borrower_address, borrower_phone)
	VALUES
	('Mannix Cotton','226-2483 Risus. St.','390-685-7146'),
	('Serena Goff','Ap #442-6674 Sem Rd.','948-286-6604'),
	('Caesar Lancaster','3070 Aenean St.','970-591-3271'),
	('Peter Patel','631-2710 Phasellus Road','337-192-6648'),
	('Oliver Houston','Ap #449-7029 Nec Avenue','173-833-5924'),
	('Meghan Reeves','5751 Iaculis Rd.','589-301-2740'),
	('Jacqueline Black','330-2749 A Rd.','204-302-5157'),
	('Galena Espinoza','P.O. Box 712, 8289 Diam St.','145-470-4952'),
	('Suki Bird','Ap #799-4581 Risus Street','984-481-0503'),
	('Steven Love','Ap #723-9390 Aenean Rd.','914-550-5705')
	;

	INSERT INTO tbl_LibraryBranch
	(libraryBranch_branchName, libraryBranch_address)
	VALUES
	('Sharpstown','251-3809 Dolor. Av.'),
	('LittleTown','999-5020 Metus Street'),
	('Central','854-6316 Main St.'),
	('Westside','P.O. Box 249, 3057 Mauris St.')
	;

	INSERT INTO tbl_BookCopies
	(bookCopies_bookID, bookCopies_branchID, bookCopies_noOfCopies)
	VALUES
	(1, 1, 10),
	(2, 1, 2),
	(3, 1, 3),
	(4, 1, 15),
	(5, 1, 5),
	(6, 1, 7),
	(7, 1, 4),
	(8, 1, 2),
	(9, 1, 3),
	(10, 1, 2),
	(11, 2, 4),
	(12, 2, 5),
	(13, 2, 8),
	(14, 2, 2),
	(15, 2, 14),
	(16, 2, 10),
	(17, 2, 9),
	(18, 2, 10),
	(19, 2, 10),
	(20, 2, 10),
	(21, 2, 8),
	(22, 2, 7),
	(23, 2, 10),
	(1, 3, 10),
	(2, 3, 2),
	(3, 3, 3),
	(4, 3, 4),
	(5, 3, 5),
	(6, 3, 10),
	(7, 3, 10),
	(8, 3, 11),
	(9, 3, 14),
	(10, 3, 2),
	(22, 3, 2),
	(11, 4, 10),
	(12, 4, 10),
	(13, 4, 5),
	(14, 4, 5),
	(15, 4, 7),
	(16, 4, 2),
	(17, 4, 6),
	(18, 4, 10),
	(19, 4, 9),
	(20, 4, 10)
	;

	INSERT INTO tbl_BookLoans
	(bookLoans_bookID, bookLoans_branchID, bookLoans_cardNo, bookLoans_dateOut, bookLoans_dateDue)
	VALUES
	(1, 1, 1, '2018-1-20', '2018-2-20'),
	(2, 1, 1, '2018-1-20', '2018-2-20'),
	(3, 1, 1, '2018-1-20', '2018-2-20'),
	(4, 1, 1, '2018-1-20', '2018-2-20'),
	(6, 1, 1, '2018-1-20', '2018-2-20'),
	(9, 1, 1, '2018-1-20', '2018-2-20'),
	(10, 1, 2, '2018-1-20', '2018-2-20'),
	(13, 2, 2, '2018-1-2', '2018-2-2'),
	(14, 2, 2, '2018-1-2', '2018-2-2'),
	(15, 2, 2, '2018-1-2', '2018-2-2'),
	(16, 2, 2, '2018-1-2', '2018-2-2'),
	(17, 2, 2, '2018-1-2', '2018-2-2'),
	(22, 2, 2, '2018-1-2', '2018-2-2'),
	(18, 2, 2, '2018-1-2', '2018-2-2'),

	(1, 3, 3, '2017-12-20', '2018-1-20'),
	(2, 3, 4, '2017-12-23', '2018-1-23'),
	(3, 3, 5, '2018-1-1', '2018-2-1'),
	(4, 3, 3, '2018-1-4', '2018-2-4'),
	(5, 3, 3, '2018-1-12', '2018-2-12'),
	(6, 3, 7, '2018-1-15', '2018-2-15'),
	(7, 3, 7, '2018-1-4', '2018-2-4'),
	(9, 3, 8, '2018-1-20', '2018-2-20'),
	(10, 3, 4, '2018-1-15', '2018-2-15'),
	(13, 4, 9, '2018-1-12', '2018-2-12'),
	(14, 4, 9, '2018-1-1', '2018-2-1'),
	(15, 4, 8, '2018-1-4', '2018-2-4'),
	(16, 4, 7, '2018-1-12', '2018-2-12'),
	(17, 4, 7, '2018-1-15', '2018-2-15'),
	(18, 4, 7, '2018-1-1', '2018-2-1'),
	(19, 4, 6, '2018-1-4', '2018-2-4'),
	(20, 4, 5, '2018-1-12', '2018-2-12'),
	(21, 2, 4, '2018-1-4', '2018-2-4'),
	(22, 2, 4, '2018-1-15', '2018-2-15'),
	(23, 2, 4, '2018-1-12', '2018-2-12'),
	(1, 1, 9, '2018-1-13', '2018-2-13'),
	(1, 1, 2, '2018-1-4', '2018-2-4'),
	(2, 1, 3, '2018-1-12', '2018-2-12'),
	(3, 1, 3, '2018-1-15', '2018-2-15'),
	(14, 2, 9, '2018-1-1', '2018-2-1'),
	(14, 2, 7, '2017-11-20', '2017-12-20'),
	(16, 2, 8, '2018-1-19', '2018-2-19'),
	(17, 2, 8, '2018-1-1', '2018-2-1'),
	(3, 3, 4, '2018-1-12', '2018-2-12'),
	(4, 3, 2, '2018-1-2', '2018-2-2'),
	(1, 3, 2, '2018-1-12', '2018-2-12'),
	(5, 3, 2, '2018-1-4', '2018-2-4'),
	(15, 4, 6, '2018-1-7', '2018-2-7'),
	(16, 4, 4, '2018-1-7', '2018-2-7'),
	(17, 4, 5, '2018-1-21', '2018-2-21'),
	(18, 4, 5, '2018-1-7', '2018-2-7'),
	(8, 1, 1, '2018-1-12', '2018-2-12'),
	(19, 2, 4, '2018-1-6', '2018-2-6')
	;
END 
GO
