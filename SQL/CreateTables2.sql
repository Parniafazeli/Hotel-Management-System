USE Hotel;


CREATE TABLE Guest_Reservation(
GuestID INT NOT NULL,
ReservationID INT NOT NULL,
FOREIGN KEY(GuestID) REFERENCES Guest(GuestID)
ON DELETE NO ACTION, 
FOREIGN KEY(ReservationID) REFERENCES Reservation(ReservationID)
ON DELETE CASCADE ,
PRIMARY KEY(GuestID, ReservationID)
)

CREATE TABLE Room_Reservation(
RoomID INT NOT NULL,
ReservationID INT NOT NULL,
FOREIGN KEY(RoomID) REFERENCES Room(RoomID)
ON DELETE CASCADE ,
FOREIGN KEY(ReservationID) REFERENCES Reservation(ReservationID)
ON DELETE NO ACTION ,
PRIMARY KEY(RoomID, ReservationID)
)

CREATE TABLE Invoice_Service(

InvoiceID INT NOT NULL,
ServiceID INT NOT NULL,
Quantity INT NOT NULL,
CHECK(Quantity>0),
FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID),
FOREIGN KEY (ServiceID) REFERENCES Service(ServiceID),
PRIMARY KEY(InvoiceID, ServiceID)

)

