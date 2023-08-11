--primary key, not null
create database Phase2Db
use Phase2Db
--unique: not duplicate, u can write null in unique column but once
--we can write multiple unique /table
create table Emps
(Id int primary key,
Fname nvarchar(50) not null,
Lname nvarchar(50) not null,
mobile varchar(10) unique,
email nvarchar(100) unique
)
insert into Emps values(101,'Ethan','Hunt','9876543210','ethan@yahoo.com')
insert into Emps(Id,Fname,Lname,email)values(102,'Ryan','Rey','ryan@yahoo.com')

--insert into Emps(Id,Fname,Lname,email)values(103,'Chris','Evans','chris@yahoo.com')
--Violation of UNIQUE KEY constraint 'UQ_Emps_A32E2E1C085ADA81'. 
--Cannot insert duplicate key in object 'dbo.Emps'. The duplicate key value is (<NULL>).
insert into Emps(Id,Fname,Lname,mobile)values(103,'Chris','Evans','8765904312')
select * from Emps
insert into Emps(Id,Fname,Lname,email)values(104,'Chris','Evans','chris@yahoo.com')

select * from Emps


----------------another example of use of unique with not null
drop table Emps

create table Emps
(Id int primary key,
Fname nvarchar(50) not null,
Lname nvarchar(50) not null,
mobile varchar(10) unique not null,
email nvarchar(100) unique not null
)
insert into Emps values(101,'Ethan','Hunt','9876543210','ethan@yahoo.com')
insert into Emps(Id,Fname,Lname,email,mobile)values(102,'Ryan','Rey','ryan@yahoo.com',9812763450)
insert into Emps(Id,Fname,Lname,email,mobile)values(103,'Chris','Evans','chris@yahoo.com',9812763405)
select * from Emps

--- example using check

drop table Emps

create table Emps
(Id int primary key,
Fname nvarchar(50) not null,
Lname nvarchar(50) not null,
Salary float check(Salary>=10000)
)

insert into Emps values (1,'Ethan','Hunt',60000)
insert into Emps values (2,'Ryan','Rey',50000)

--insert into Emps values(3,'Chris','Evans',8000)
--The INSERT statement conflicted with the CHECK constraint --"CK_EmpsSalary_45F365D3". 
--The conflict occurred in database "Phase2Db", table "dbo.Emps", column 'Salary'.


----example using pattern check using check

create table Employee
(Id int primary key,
Fname nvarchar(50) not null,
Lname nvarchar(50) not null,
Mobile varchar(10) not null unique check (Mobile like'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
insert into Employee values(101,'Ethan','Hunt','9876543210')

--insert into Employee values(102,'Ryan','Rey','99665577')
--The INSERT statement conflicted with the CHECK constraint "CK_EmployeeMobile_49C3F6B7". 
--The conflict occurred in database "Phase2Db", table "dbo.Employee", column 'Mobile'.

---example using default

drop table Employee
create table Employee
(Id int primary key,
Fname nvarchar(50) not null,
Lname nvarchar(50) not null,
Mobile varchar(10) not null unique check (Mobile like'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
City nvarchar(50) default 'Delhi'
)

insert into Employee (Id,Fname, Lname, Mobile) values(101,'Ethan','Hunt','9876543210')
insert into Employee (Id,Fname, Lname, Mobile, City) values(102,'Ryan','Rey','9876543201','Noida')
select * from Employee


---identity
--identity(seed, increment)
--default seed=1, increment=1
create table Customer
(CId int identity,
CName nvarchar(50) not null,
CCity nvarchar(50) not null
)
insert into Customer values('Raj','Delhi')
insert into Customer values('Ravi','Noida')
insert into Customer values('Mithun','Hyderabad')

select * from Customer
------------------------------------
drop table Customer

create table Customer
(CId int identity(5,2),   --seed is the starting value and increment is adding identity(seed, increment)
CName nvarchar(50) not null,
CCity nvarchar(50) not null
)
insert into Customer values('Raj','Delhi')
insert into Customer values('Ravi','Noida')
insert into Customer values('Mithun','Hyderabad')

select * from Customer
-----------------------------------------
drop table Customer
create table Customer
(CId int identity(1000,1),   
CName nvarchar(50) not null,
CCity nvarchar(50) not null
)
insert into Customer values('Raj','Delhi')
insert into Customer values('Ravi','Noida')
insert into Customer values('Mithun','Hyderabad')
select * from Customer

-----------------------------------------------------------------------------------------------------------------------
-----------reference key
------------------------------------------------------------
create table Student
(SId int primary key,
Sname nvarchar(50) not null,
SAge int)

--The INSERT statement conflicted with the FOREIGN KEY constraint "FK_Exam_SId_4222D4EF".
--The conflict occurred in database "Phase2Db", table "db0.Student", column 'SID'.

create table Category
(CId int primary key,
CName nvarchar(50) unique)
insert into Category values (1,'Clothing')
insert into Category values (2,'Electronic')
insert into Category values (3,'Grooming')

create table Product
(PId int primary key identity,
Pname nvarchar(50) not null,
Category int foreign key references Category)
insert into Product values ('T-shirt', 1)
insert into Product values ('Shirt', 1)
insert into Product values ('Face Wash', 2)
insert into Product values ('Face Cream', 2)

insert into Product values ('Bag',5)
---The INSERT statement conflicated with the FOREIGN KEY constraint "FK_Product_Category_48CFD27E".
--The conflict occurred in database "Phase2DB", table "dbo.Category", column 'CId'.

select * from Category
select * from Product 

select * from Product,Category where Category.CId = Product.Category

select Product.PId, Product.Pname,Category.CName from Product,Category where Category.CId=Product.Category

select p.PId,p.Pname,c.CId,c.CName from Product as p,Category as c where c.CId=p.Category