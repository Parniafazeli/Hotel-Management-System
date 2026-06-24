
USE Hotel;

CREATE TRIGGER trg_UpdateInvoiceTotal
ON Invoice_Service
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    UPDATE Invoice
    SET Total_Amount = (
        SELECT ISNULL(SUM(ins.Quantity * s.Price), 0)
        FROM Invoice_Service ins
        JOIN Service s ON ins.ServiceID = s.ServiceID
        WHERE ins.InvoiceID = Invoice.InvoiceID
    ),
    Tax_Amount = (
        SELECT ISNULL(SUM(ins.Quantity * s.Price), 0) * 0.1
        FROM Invoice_Service ins
        JOIN Service s ON ins.ServiceID = s.ServiceID
        WHERE ins.InvoiceID = Invoice.InvoiceID
    )
    WHERE Invoice.InvoiceID IN (
        SELECT InvoiceID FROM inserted
        UNION
        SELECT InvoiceID FROM deleted
    );

END;
GO