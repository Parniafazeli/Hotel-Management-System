USE Hotel;
GO

CREATE OR ALTER FUNCTION fn_TotalPaidByGuest (@GuestID INT)
RETURNS DECIMAL(12,0)
AS
BEGIN
    DECLARE @Total DECIMAL(12,0);
    
    SELECT @Total = SUM(P.Amount)
    FROM Payment P
    INNER JOIN Reservation R ON P.ReservationID = R.ReservationID
    INNER JOIN Guest_Reservation GR ON R.ReservationID = GR.ReservationID
    WHERE GR.GuestID = @GuestID;
    
    RETURN ISNULL(@Total, 0);
END;
GO

-- 1.Retrieve the total paid by a specific guest (GuestID = 1)

SELECT dbo.fn_TotalPaidByGuest(1) AS TotalPaidByJohnSmith;

-- 2.Retrieve the total paid by all guests
SELECT 
    GuestID,
    FirstName + ' ' + LastName AS GuestName,
    dbo.fn_TotalPaidByGuest(GuestID) AS TotalPaid
FROM Guest
ORDER BY TotalPaid DESC;
GO

-- 3.Cursor to display unpaid invoices

DECLARE @ReservationID INT, @InvoiceID INT, @TotalAmount DECIMAL(12,0);

DECLARE cur_UnpaidInvoices CURSOR FOR
    SELECT InvoiceID, ReservationID, Total_Amount
    FROM Invoice
    WHERE Payment_Method = 'Pending';

OPEN cur_UnpaidInvoices;

FETCH NEXT FROM cur_UnpaidInvoices INTO @InvoiceID, @ReservationID, @TotalAmount;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Invoice ID: ' + CAST(@InvoiceID AS VARCHAR) + 
          ', Reservation ID: ' + CAST(@ReservationID AS VARCHAR) +
          ', Total Amount: ' + CAST(@TotalAmount AS VARCHAR);
    
    
    FETCH NEXT FROM cur_UnpaidInvoices INTO @InvoiceID, @ReservationID, @TotalAmount;
END;

CLOSE cur_UnpaidInvoices;
DEALLOCATE cur_UnpaidInvoices;
GO