USE Hotel;
GO

BEGIN TRY
    BEGIN TRANSACTION CheckoutTransaction;

     DECLARE @ReservationID INT = 11;
     DECLARE @NightCount INT;
     DECLARE @TotalRoomCost DECIMAL(12,0);
     DECLARE @PaidAmount DECIMAL(12,0);
     DECLARE @RemainingRoomPayment DECIMAL(12,0);
     DECLARE @ServiceCost DECIMAL(12,0);
     DECLARE @TaxCost DECIMAL(12,0)
     DECLARE @InvoiceCost DECIMAL(12,0);
     DECLARE @TotalBill DECIMAL(12,0);
     DECLARE @NextPaymentNumber INT;

    SELECT @NightCount = DATEDIFF(DAY, CheckInDate, CheckOutDate)
    FROM Reservation
    WHERE ReservationID = @ReservationID;


    SELECT @TotalRoomCost = ISNULL(SUM(r.PricePerNight * @NightCount), 0)
    FROM Room_Reservation rr
    JOIN Room r ON rr.RoomID = r.RoomID
    WHERE rr.ReservationID = @ReservationID;

    SELECT @PaidAmount = ISNULL(SUM(Amount), 0)
    FROM Payment
    WHERE ReservationID = @ReservationID;


    SET @RemainingRoomPayment = @TotalRoomCost - @PaidAmount;
    IF @RemainingRoomPayment < 0 SET @RemainingRoomPayment = 0;

    IF @RemainingRoomPayment > 0
    BEGIN
        SELECT @NextPaymentNumber = ISNULL(MAX(Payment_Number), 0) + 1
        FROM Payment
        WHERE ReservationID = @ReservationID;

        INSERT INTO Payment (
            ReservationID,
            Payment_Number,
            Amount,
            PaymentDate,
            Payment_Method
        )
        VALUES (
            @ReservationID,
            @NextPaymentNumber,
            @RemainingRoomPayment,
            GETDATE(),
            'Credit'
        );
    END

    SELECT
    @ServiceCost = ISNULL(SUM(Total_Amount), 0),
    @TaxCost = ISNULL(SUM(Tax_Amount), 0)
    FROM Invoice i
    WHERE i.ReservationID = @ReservationID
    AND i.PaymentStatus = 'Pending';


    SET @InvoiceCost = @ServiceCost + @TaxCost;

    UPDATE Invoice
    SET PaymentStatus = 'Paid', Payment_Method='Credit'
    WHERE ReservationID = @ReservationID
    AND PaymentStatus = 'Pending';

    UPDATE Reservation
    SET ReservationStatus = 'CheckedOut'
    WHERE ReservationID = @ReservationID;

    UPDATE Room
    SET Status = 'Available'
    WHERE RoomID IN (
        SELECT RoomID
        FROM Room_Reservation
        WHERE ReservationID = @ReservationID
    );

    SET @TotalBill =
        @RemainingRoomPayment + @InvoiceCost;

     
    PRINT '========== CHECKOUT REPORT ==========';
    PRINT 'Room Cost: ' + CAST(@TotalRoomCost AS VARCHAR);
    PRINT 'Paid Room: ' + CAST(@PaidAmount AS VARCHAR);
    PRINT 'Remaining Room Payment: ' + CAST(@RemainingRoomPayment AS VARCHAR);

    PRINT 'Service Cost: ' + CAST(@ServiceCost AS VARCHAR);
    PRINT 'Tax Cost: ' + CAST(@TaxCost AS VARCHAR);
    PRINT 'Service Total: ' + CAST(@InvoiceCost AS VARCHAR);

    PRINT '-------------------------------------';
    PRINT 'TOTAL BILL: ' + CAST(@TotalBill AS VARCHAR);

    PRINT '=====================================';

    COMMIT TRANSACTION CheckoutTransaction; 

END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION CheckoutTransaction;

    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH;
GO