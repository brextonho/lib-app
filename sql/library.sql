CREATE DATABASE Library;

CREATE TABLE Members(
	memberId		VARCHAR(45)		NOT NULL,
    memberName		VARCHAR(45)		NOT NULL,
    faculty			VARCHAR(45)		NOT NULL,
    phone			INT				NOT NULL,
    email			VARCHAR(100)	NOT NULL,
    PRIMARY KEY(memberId));

CREATE TABLE Book(
	accessionNo		VARCHAR(5)	NOT NULL, 
    title			VARCHAR(80)	NOT NULL,
    isbn			VARCHAR(80) NOT NULL,
    publisher		VARCHAR(80) NOT NULL,
    publicationYear	INT			NOT NULL,
    PRIMARY KEY(accessionNo));

CREATE TABLE Fine(
	memberId		VARCHAR(45)	NOT NULL,
    fineAmount		INT			NOT NULL, 
    PRIMARY KEY(memberId),
    FOREIGN KEY(memberId) REFERENCES Members(memberId) ON DELETE CASCADE);

CREATE TABLE Payment(
	memberId	VARCHAR(45)	NOT NULL,
    paymentDate	DATE		NOT NULL,
    PRIMARY KEY(memberId, paymentDate),
    FOREIGN KEY(memberId) REFERENCES Members(memberId) ON DELETE CASCADE);

CREATE TABLE Author(
	accessionNo	VARCHAR(5)	NOT NULL,
    author		VARCHAR(45)	NOT NULL,
    PRIMARY KEY(accessionNo, author),
    FOREIGN KEY(accessionNo) REFERENCES Book(accessionNo) ON DELETE CASCADE);

CREATE TABLE Reservation(
	accessionNo		VARCHAR(5)	NOT NULL,
    reserveDate		DATE		NOT NULL,
    reservationMemberId	VARCHAR(45)	NOT NULL, 
    PRIMARY KEY(accessionNo),
    FOREIGN KEY(accessionNo) REFERENCES Book(accessionNo) ON DELETE CASCADE,
    FOREIGN KEY(reservationMemberId) REFERENCES Members(memberId) ON DELETE CASCADE);

CREATE TABLE Borrow(
	accessionNo		VARCHAR(5)	NOT NULL,
    borrowDate		DATE		NOT NULL,
    borrowMemberId	VARCHAR(45)	NOT NULL,
    returnDate		DATE,
    PRIMARY KEY(accessionNo, borrowDate),
    FOREIGN KEY(accessionNo) REFERENCES Book(accessionNo) ON DELETE CASCADE,
    FOREIGN KEY(borrowMemberId) REFERENCES Members(memberId) ON DELETE CASCADE);
    
SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/LibMems.txt' 
INTO TABLE members
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(@col1,@col2,@col3,@col4,@col5) set memberID=@col1,memberName=@col2,faculty=@col3,phone=@col4,email=@col5;
SELECT * FROM members;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/LibBooks.txt'
INTO TABLE book
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
(@col1,@col2,@col3,@col4,@col5,@col6,@col7,@col8) set accessionNo=@col1,title=@col2,isbn=@col6,publisher=@col7,publicationYear=@col8;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/LibBooks.txt' 
INTO TABLE author
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
(@col1,@col2,@col3,@col4,@col5,@col6,@col7,@col8) set accessionNo=@col1,author=@col3;
