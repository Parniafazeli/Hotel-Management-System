USE Hotel;
GO

CREATE TABLE Guest(
GuestID INT IDENTITY(1,1) PRIMARY KEY,
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(20) Not Null,
PhoneNumber VARCHAR(20) Not Null,
Email VARCHAR(100),
BirthDate Date,
Gender CHAR(1) NOT NULL,
Address VARCHAR(250),
NationalID Varchar(20) NOT NULL,
UNIQUE(NationalID)
)

ALTER TABLE Guest
ADD PasswordHash VARBINARY(32);

GO
CREATE TABLE Service(
ServiceID INT  IDENTITY(1,1) NOT NULL,
Servie_Name VARCHAR(20) NOT NULL,
Description VARCHAR(100) ,
Price DECIMAL(9,0) NOT NULL,
PRIMARY KEY(ServiceID)
)
EXEC sp_rename 'Service.Servie_Name', 'Service_Name', 'COLUMN';

GO
CREATE TABLE Employee(

EmployeeID INT IDENTITY(1,1),
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(20) Not Null,
HireDate DATE ,
Salary DECIMAL (12,0) NOT NULL,
PhoneNumber VARCHAR(20) Not Null

PRIMARY KEY(EmployeeID)
)
USE Hotel

CREATE TABLE HouseKeeper(
EmployeeId INT PRIMARY KEY,
FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeID)
ON DELETE CASCADE  ON UPDATE CASCADE,
Shift VARCHAR(30),
)

CREATE TABLE Cleaning(
HouseKeeperID INT NOT NULL,
RoomID INT NOT NULL,
CleaningDate Date,
FOREIGN KEY(HouseKeeperID) REFERENCES HouseKeeper(EmployeeID)
ON DELETE CASCADE  ON UPDATE CASCADE,
PRIMARY KEY(HouseKeeperID,RoomID)
)


CREATE TABLE Receptionist(
EmployeeId INT PRIMARY KEY,
FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeID)
ON DELETE CASCADE  ON UPDATE CASCADE,
DeskNumber INT NOT NULL,
)
CREATE TABLE Manager(
EmployeeId INT PRIMARY KEY,
FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeID)
ON DELETE CASCADE  ON UPDATE CASCADE,
)

CREATE TABLE Manager_Department(
ManagerID INT NOT NULL,
DepartmentName VARCHAR(50) NOT NULL,
FOREIGN KEY (ManagerID) REFERENCES Manager(EmployeeID)
ON DELETE CASCADE  ON UPDATE CASCADE,
PRIMARY KEY (ManagerID, DepartmentName),
)

CREATE TABLE Room(
RoomID INT  IDENTITY(1,1),
RoomNumber VARCHAR(10) NOT NULL,
PricePerNight DECIMAL(12,0) NOT NULL,
Type VARCHAR(20) NOT NULL,
Floor INT ,
Capacity INT NOT NULL,
Status VARCHAR(20) NOT NULL,
CHECK (Status IN ('Available', 'Occupied', 'Cleaning', 'Maintenance')),
PRIMARY KEY(RoomID),

)

CREATE TABLE Reservation(
ReservationID INT IDENTITY(1,1),
BookerID INT NOT NULL ,
CheckInDate DATE NOT NULL,
CheckOutDate Date Not null,
ReservationDate Date Not Null,
ReservationStatus VARCHAR(15) NOT NULL,

PRIMARY KEY(ReservationID),
FOREIGN KEY(BookerID) REFERENCES Guest(GuestID)
ON DELETE NO ACTION ON UPDATE CASCADE

);

ALTER TABLE Reservation
ADD CONSTRAINT Status_Constraint
CHECK(ReservationStatus IN('Confirmed' ,'Cancelled' ,'CheckedOut', 'CheckedIn' , 'Pending'));
ALTER TABLE Reservation
DROP CONSTRAINT Status_Constraint;

CREATE TABLE Payment(
ReservationID INT NOT NULL,
Payment_Number INT NOT NULL, 
Amount DECIMAL(12,0) NOT NULL,
PaymentDate DATE,
Payment_Method VARCHAR(10) NOT NULL,

FOREIGN KEY(ReservationID) REFERENCES Reservation(ReservationID)
ON DELETE CASCADE,
PRIMARY KEY(ReservationID,Payment_Number)
)


CREATE TABLE Invoice(
InvoiceID INT IDENTITY(1,1),
ReservationID INT NOT NULL,
Total_Amount DECIMAL(12,0) NOT NULL,
Payment_Method VARCHAR(10) NOT NULL,
Tax_Amount DECIMAL (9,0) NOT NULL,
Issue_Date DATE ,
PRIMARY KEY(InvoiceID ),
FOREIGN KEY(ReservationID) REFERENCES Reservation(ReservationID)
ON DELETE NO ACTION ON UPDATE CASCADE
);

ALTER TABLE Invoice
ADD PaymentStatus VARCHAR(10);

UPDATE Invoice
SET PaymentStatus = 'Paid';

ALTER TABLE Invoice
ALTER COLUMN PaymentStatus VARCHAR(10) NOT NULL;

ALTER TABLE Invoice
ADD CONSTRAINT CHK_Invoice_PaymentStatus
CHECK (PaymentStatus IN ('Pending', 'Paid'));

ALTER TABLE Invoice
DROP CONSTRAINT CHK_Invoice_PaymentStatus;

ALTER TABLE Invoice
ADD CONSTRAINT DF_Invoice_TotalAmount DEFAULT 0 FOR Total_Amount;
ALTER TABLE Invoice
ADD CONSTRAINT DF_Invoice_TaxAmount DEFAULT 0 FOR Tax_Amount;

CREATE TABLE Review(
ReviewID INT IDENTITY(1,1),
GuestID INT NOT  NULL DEFAULT -1,
Comments VARCHAR(250),
Rating INT NOT NULL,
Review_Date DATE,
CONSTRAINT CHECK_RATING
CHECK (Rating BETWEEN 1 AND 5),
PRIMARY KEY(ReviewID),
FOREIGN KEY(GuestID) REFERENCES Guest(GuestID)
ON DELETE SET DEFAULT ON UPDATE CASCADE

)
USE Hotel
ALTER TABLE Guest
ADD RegisterDate Date;





