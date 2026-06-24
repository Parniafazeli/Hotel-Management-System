
INSERT INTO Service (Service_Name, Description, Price) VALUES
( 'Breakfast', 'Full buffet breakfast', 250000),
( 'Laundry', 'Per piece', 80000),
( 'Massage', '60 minutes', 600000),
( 'HighSpeed Internet', '24-hour access', 50000),
( 'Airport Transfer', 'One way', 400000),
( 'Swimming Pool', 'Per use', 150000),
('Sauna', 'Per session', 120000),
('Late Fee', 'Per hour delay', 100000),
( 'Restaurant Meal', 'Lunch or dinner', 200000),
( 'Minibar Refill', 'Per refill', 300000);

INSERT INTO Invoice_Service (InvoiceID, ServiceID, Quantity) VALUES
(1, 1, 2),   -- Breakfast x2
(1, 2, 1),   -- Laundry x1
(2, 1, 1),
(2, 3, 1),
(3, 8, 1),   -- Late fee
(4, 4, 2),
(5, 5, 1),
(6, 8, 1),
(7, 6, 2),
(8, 7, 1),
(9, 1, 1),
(10, 2, 1);

INSERT INTO Invoice_Service (InvoiceID, ServiceID, Quantity) VALUES
(13,2,2),
(13,1,4)

UPDATE Invoice
    set Payment_Method='Credit'
    WHERE ReservationID = 11
 

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
);