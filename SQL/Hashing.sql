UPDATE Guest
SET PasswordHash = HASHBYTES('SHA2_256', PhoneNumber)
WHERE PasswordHash IS NULL;

GO

CREATE PROCEDURE sp_RegisterNewGuest
    @FirstName VARCHAR(20),
    @LastName VARCHAR(20),
    @PhoneNumber VARCHAR(20),
    @Email VARCHAR(100),
    @BirthDate DATE,
    @Gender CHAR(1),
    @Address VARCHAR(250),
    @NationalID VARCHAR(20),
    @Password VARCHAR(100) 
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Guest (FirstName, LastName, PhoneNumber, Email, BirthDate, Gender, Address, NationalID,RegisterDate, PasswordHash)
    VALUES (
        @FirstName, 
        @LastName, 
        @PhoneNumber, 
        @Email, 
        @BirthDate, 
        @Gender, 
        @Address, 
        @NationalID, 
        GETDATE(),
        HASHBYTES('SHA2_256', @Password) 
    );
END;


EXEC sp_RegisterNewGuest
    @FirstName = 'Amir', 
    @LastName = 'Ahmadi', 
    @PhoneNumber = '09129998877', 
    @Email = 'amir@gmail.com', 
    @BirthDate = '1993-11-05', 
    @Gender = 'M', 
    @Address = 'Shiraz, Iran', 
    @NationalID = '2281112233', 
    @Password = 'AmirPass@2026'