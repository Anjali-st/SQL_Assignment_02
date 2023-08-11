CREATE DATABASE ExerciseDb;

USE ExerciseDb;

CREATE TABLE Publisher (
    PID INT PRIMARY KEY,
    Publisher VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Category (
    CID INT PRIMARY KEY,
    Category VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Author (
    AID INT PRIMARY KEY,
    AuthorName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Book (
    BID INT PRIMARY KEY,
    BName VARCHAR(100) NOT NULL,
    BPrice DECIMAL(10, 2),
    Author INT,
    Publisher INT,
    Category INT,
    FOREIGN KEY (Author) REFERENCES Author(AID),
    FOREIGN KEY (Publisher) REFERENCES Publisher(PID),
    FOREIGN KEY (Category) REFERENCES Category(CID)
);

INSERT INTO Publisher (PID, Publisher) VALUES
(1, 'Publisher1'),
(2, 'Publisher2'),
(3, 'Publisher3');

INSERT INTO Category (CID, Category) VALUES
(1, 'Action'),
(2, 'Science Fiction'),
(3, 'Mystery');

INSERT INTO Author (AID, AuthorName) VALUES
(1, 'John Snow'),
(2, 'Michael'),
(3, 'John');

INSERT INTO Book (BID, BName, BPrice, Author, Publisher, Category) VALUES
(1, 'Book1', 199, 1, 1, 1),
(2, 'Book2', 799, 2, 2, 2),
(3, 'Book3', 289, 3, 3, 3),
(4, 'Book4', 499, 1, 1, 1),
(5, 'Book5', 1399, 2, 2, 2),
(6, 'Book6', 1596, 3, 3, 3);

-- Show book details
SELECT BID, BName, BPrice, AuthorName AS Author, Publisher.Publisher AS Publisher, Category.Category AS Category
FROM Book
JOIN Author ON Book.Author = Author.AID
JOIN Publisher ON Book.Publisher = Publisher.PID
JOIN Category ON Book.Category = Category.CID;


