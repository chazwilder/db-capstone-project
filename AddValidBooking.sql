CREATE PROCEDURE AddValidBooking (IN CHECK_DATE DATE, IN TABLE_ID INT)
BEGIN 
SET autocommit = 0;
START TRANSACTION;

	IF EXISTS (
		SELECT * FROM Bookings
		WHERE TABLEID = TABLE_ID
		AND BOOKINGDATE = CHECK_DATE
	) THEN
		
		ROLLBACK;
		SELECT CONCAT('Table ',TABLE_ID,' is already booked. Booking Cancelled') as BOOKING_STATUS;
	ELSE 
		INSERT INTO Bookings(BookingDate,TableID)
		VALUES (CHECK_DATE,TABLE_ID);
		COMMIT;
        SELECT CONCAT('Table ',TABLE_ID,' has successfully been booked. See you soon!') as BOOKING_STATUS;
	END IF;
 END