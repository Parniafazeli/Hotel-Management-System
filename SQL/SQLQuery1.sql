USE Hotel;
--Retrieve Rooms that are Suite
Select RoomNumber
FROM Room
WHERE Type='Suite';

--rooms that are available
Select RoomNumber,Floor
FROM Room
WHERE Status='Available';


--list of Emma Johnson's Reservation with RoomNumber and CheckIn-CheckOut Date
SELECT CheckInDate, CheckOutDate,RoomNumber
FROM Reservation, Room_Reservation, Guest_Reservation, Guest, Room
WHERE Guest.FirstName='Emma' AND Guest.LastName='Johnson'
AND Guest.GuestID=Guest_Reservation.GuestID
AND Reservation.ReservationID=Guest_Reservation.ReservationID
AND Room_Reservation.ReservationID=Reservation.ReservationID
AND Room_Reservation.RoomID=Room.RoomID;

USE Hotel;
SELECT Service_Name , Quantity
FROM Service , Invoice_Service , Invoice , Guest, Guest_Reservation
WHERE Guest.FirstName='William' AND Guest.LastName='Wilson'
AND Guest.GuestID=Guest_Reservation.GuestID 
AND Guest_Reservation.ReservationID=Invoice.ReservationID
AND Invoice.InvoiceID=Invoice_Service.InvoiceID 
AND Service.ServiceID = Invoice_Service.ServiceID ;

USE Hotel;
SELECT 
    G.GuestID,
    G.FirstName + ' ' + G.LastName AS GuestName,
    SUM(I.Total_Amount) AS TotalSpent
FROM Guest G
JOIN Guest_Reservation GR ON G.GuestID = GR.GuestID
JOIN Reservation R ON GR.ReservationID = R.ReservationID
JOIN Invoice I ON R.ReservationID = I.ReservationID
GROUP BY G.GuestID, G.FirstName, G.LastName
ORDER BY TotalSpent DESC;

-- Housekeeper performance: 
SELECT 
    H.EmployeeId,
    E.FirstName + ' ' + E.LastName AS HousekeeperName,
    COUNT(DISTINCT C.RoomID) AS DistinctRoomsCleaned,
    MIN(C.CleaningDate) AS FirstCleaning,
    MAX(C.CleaningDate) AS LastCleaning
FROM HouseKeeper H
JOIN Employee E ON H.EmployeeId = E.EmployeeID
LEFT JOIN Cleaning C ON H.EmployeeId = C.HouseKeeperID
GROUP BY H.EmployeeId, E.FirstName, E.LastName
ORDER BY DistinctRoomsCleaned DESC;

 --Reservations with unpaid invoices 
SELECT 
    R.ReservationID,
    G.FirstName + ' ' + G.LastName AS GuestName,
    R.CheckInDate,
    R.CheckOutDate,
    I.Total_Amount,
    I.Payment_Method
FROM Reservation R
JOIN Guest_Reservation GR ON R.ReservationID = GR.ReservationID
JOIN Guest G ON GR.GuestID = G.GuestID
JOIN Invoice I ON R.ReservationID = I.ReservationID
WHERE I.Payment_Method = 'Pending'
   OR NOT EXISTS (SELECT 1 FROM Payment P WHERE P.ReservationID = R.ReservationID)
ORDER BY R.CheckInDate;

-- Average review rating per guest 
SELECT 
    G.GuestID,
    G.FirstName + ' ' + G.LastName AS GuestName,
    AVG(CAST(Rev.Rating AS FLOAT)) AS AvgRating,
    COUNT(Rev.ReviewID) AS NumberOfReviews
FROM Guest G, Review Rev
WHERE G.GuestID = Rev.GuestID
GROUP BY G.GuestID, G.FirstName, G.LastName
ORDER BY AvgRating DESC;

-- Rooms that were part of cancelled reservations 
SELECT DISTINCT R.RoomNumber, R.Type
FROM Room R
WHERE R.RoomID IN (
    SELECT RR.RoomID
    FROM Room_Reservation RR, Reservation Res
    WHERE RR.ReservationID = Res.ReservationID
      AND Res.ReservationStatus = 'Cancelled'
);

-- Housekeepers with 'Morning' shift 
SELECT E.EmployeeID, E.FirstName, E.LastName, H.Shift
FROM Employee E, HouseKeeper H
WHERE E.EmployeeID = H.EmployeeId
  AND H.Shift = 'Morning';