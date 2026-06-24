USE Hotel;
GO

--Returns the number of reservations for a specific guest
CREATE FUNCTION GetReservationCount(@GuestID INT)
RETURNS INT
AS
BEGIN 
    DECLARE @Count INT;
    SELECT @Count = COUNT(*)
    FROM Guest_Reservation GR
    WHERE GR.GuestID = @GuestID;

    RETURN @Count;
END;
GO



SELECT *
FROM Guest_Reservation
WHERE GuestID = 2;

DECLARE @Count INT;
SET @Count = dbo.GetReservationCount(2);
PRINT @Count;


--Returns rooms that have no reservations within a given date range

GO
CREATE FUNCTION GetAvailableRoomsByDate(@StartDate DATE , @EndDate DATE)
RETURNS TABLE
AS
RETURN(
    SELECT
        R.RoomNumber,
        R.Type,
        R.PricePerNight,
        R.Capacity,
        R.Floor
    FROM Room R
    WHERE
    NOT EXISTS
    (
    SELECT *
    FROM Room_Reservation RR JOIN Reservation Res
    ON RR.ReservationID=Res.ReservationID
    WHERE RR.RoomID=R.RoomID
    AND ( RES.CheckInDate < @EndDate
        AND RES.CheckOutDate > @StartDate)
    )
);
GO

SELECT *
FROM dbo.GetAvailableRoomsByDate('2025-05-10', '2025-06-02');




--Index on Payment_Method column in Payment table 
-- improve search performance for reservation payments
CREATE NONCLUSTERED INDEX IX_Payment_PaymentMethod
ON Payment(Payment_Method);
GO

--Index on GuestID column in Guest_Reservation table 
--optimize searching and joining reservation records by guest
CREATE NONCLUSTERED INDEX IX_GuestReservation_GuestID
ON Guest_Reservation(GuestID);
GO
