USE HOTEL
--Create Roles

CREATE ROLE ReceptionistRole;
CREATE ROLE ManagerRole;
Create ROLE AccountantRole;

--Create SQL Server Logins

CREATE LOGIN ReceptionistLogin
WITH PASSWORD='Receptionist123';

CREATE LOGIN ManagerLogin
WITH PASSWORD='Manager123';

CREATE LOGIN AccountantLogin
WITH PASSWORD='Accountant123';

--Create Database Users

CREATE USER ReceptionistUser
FOR LOGIN ReceptionistLogin;

CREATE USER ManagerUser
FOR LOGIN ManagerLogin;

CREATE USER AccountantUser
FOR LOGIN AccountantLogin;

--Assign Users to Custom Roles

EXECUTE sp_AddRoleMember 'ReceptionistRole', 'ReceptionistUser';
EXECUTE sp_AddRoleMember 'ManagerRole' , 'ManagerUser' ;
EXECUTE sp_AddRoleMember 'AccountantRole' , 'AccountantUser' ;


--Give Full Database Control to Manager

EXECUTE sp_AddRoleMember 'db_owner', 'ManagerUser';

--Accountant Permissions

GRANT SELECT, INSERT, UPDATE ON Invoice TO AccountantRole;
GRANT SELECT, INSERT, UPDATE ON Payment TO AccountantRole;
GRANT SELECT, INSERT, UPDATE ON Invoice_Service TO AccountantRole;
GRANT SELECT ON Service TO AccountantRole;
GRANT SELECT ON Reservation TO AccountantRole;
GRANT SELECT ON Guest TO AccountantRole;
GRANT SELECT ON Guest_Reservation TO AccountantRole;

--Receptionist Permissions

GRANT SELECT, INSERT, UPDATE ON Guest TO ReceptionistRole;
GRANT SELECT, INSERT, UPDATE ON Reservation TO ReceptionistRole;
GRANT SELECT ON Room TO ReceptionistRole;
GRANT SELECT, INSERT,UPDATE ON Guest_Reservation TO ReceptionistRole;
GRANT SELECT, INSERT,UPDATE ON Room_Reservation TO ReceptionistRole;