-- check total number of rows = 36275

SELECT COUNT(*)
FROM HOTEL_RESERVATIONS;

-- check duplicates as per primary_key - booking_id column = no duplicates
SELECT COUNT(DISTINCT BOOKING_ID)
FROM HOTEL_RESERVATIONS;

-- check for any NULL (missing) values = no missing values
SELECT 
	SUM(CASE WHEN booking_id IS NULL THEN 1 ELSE 0 END) AS missing_column1
	, SUM(CASE WHEN no_of_adults IS NULL THEN 1 ELSE 0 END) AS missing_column2
	, SUM(CASE WHEN no_of_children IS NULL THEN 1 ELSE 0 END) AS missing_column3
	, SUM(CASE WHEN no_of_weekend_nights IS NULL THEN 1 ELSE 0 END) AS missing_column4
	, SUM(CASE WHEN no_of_week_nights IS NULL THEN 1 ELSE 0 END) AS missing_column5
	, SUM(CASE WHEN type_of_meal_plan IS NULL THEN 1 ELSE 0 END) AS missing_column6
	, SUM(CASE WHEN parking IS NULL THEN 1 ELSE 0 END) AS missing_column7
	, SUM(CASE WHEN room_type IS NULL THEN 1 ELSE 0 END) AS missing_column8
	, SUM(CASE WHEN lead_time IS NULL THEN 1 ELSE 0 END) AS missing_column9
	, SUM(CASE WHEN arrival_year IS NULL THEN 1 ELSE 0 END) AS missing_column10
	, SUM(CASE WHEN arrival_month IS NULL THEN 1 ELSE 0 END) AS missing_column11
	, SUM(CASE WHEN arrival_date IS NULL THEN 1 ELSE 0 END) AS missing_column12
	, SUM(CASE WHEN market_segment_type IS NULL THEN 1 ELSE 0 END) AS missing_column13
	, SUM(CASE WHEN repeated_guest IS NULL THEN 1 ELSE 0 END) AS missing_column14
	, SUM(CASE WHEN no_of_previous_cancellations IS NULL THEN 1 ELSE 0 END) AS missing_column15
	, SUM(CASE WHEN no_of_previous_bookings_not_canceled IS NULL THEN 1 ELSE 0 END) AS missing_column16
	, SUM(CASE WHEN avg_price_per_room IS NULL THEN 1 ELSE 0 END) AS missing_column17
	, SUM(CASE WHEN no_of_special_requests IS NULL THEN 1 ELSE 0 END) AS missing_column18
	, SUM(CASE WHEN booking_status IS NULL THEN 1 ELSE 0 END) AS missing_column19
FROM HOTEL_RESERVATIONS;

-- check first day of reservations in dataset = 1/07/2017
SELECT ARRIVAL_YEAR,
	ARRIVAL_MONTH,
	ARRIVAL_DATE
FROM HOTEL_RESERVATIONS
GROUP BY 1,2,3
ORDER BY 1,2,3
LIMIT 1;

-- check last day of reservations in dataset = 31/12/2018
SELECT ARRIVAL_YEAR,
	ARRIVAL_MONTH,
	ARRIVAL_DATE
FROM HOTEL_RESERVATIONS
GROUP BY 1,2,3
ORDER BY 1 DESC,2 DESC,3 DESC
LIMIT 1;

-- check reservation trend by date = error: date/time field value out of range: "2018-2-29" 
SELECT TO_DATE(ARRIVAL_YEAR || '-' || ARRIVAL_MONTH || '-' || ARRIVAL_DATE,'YYYY-MM-DD') AS ARRIVAL_DATE
FROM HOTEL_RESERVATIONS;


-- find all lines with non existing date = 37 lines
SELECT COUNT (*)
FROM HOTEL_RESERVATIONS
WHERE ARRIVAL_YEAR = 2018
	AND ARRIVAL_MONTH = 2
	AND ARRIVAL_DATE = 29;
	

-- check max and min value in no_of _adults column = Min: 0 Max: 4
SELECT MAX(NO_OF_ADULTS),
	MIN(NO_OF_ADULTS)
FROM HOTEL_RESERVATIONS;


-- check max and min value in no_of_children column = Min: 0 Max: 10
SELECT MAX(NO_OF_CHILDREN),
	MIN(NO_OF_CHILDREN)
FROM HOTEL_RESERVATIONS;


-- check there is no reservations with 0 adults and 0 children = 0 lines
SELECT *
FROM HOTEL_RESERVATIONS
WHERE NO_OF_CHILDREN = 0
	AND NO_OF_ADULTS = 0;
	

-- explore reservation distribution by number of children in a room = only 3 lines from the dataset have 9 or 10 children count, the rest are 3,2,1 or 0
SELECT DISTINCT NO_OF_CHILDREN,
	COUNT(BOOKING_ID) AS CNT_OF_INSTANCES
FROM HOTEL_RESERVATIONS
GROUP BY 1
ORDER BY 2;


-- check distinct values in no_weekend_nights column = from 0 to 7
SELECT DISTINCT NO_OF_WEEKEND_NIGHTS
FROM HOTEL_RESERVATIONS
ORDER BY 1;


-- check distinct values in no_week_nights column = from 0 to 17
SELECT DISTINCT NO_OF_WEEK_NIGHTS
FROM HOTEL_RESERVATIONS
ORDER BY 1;


-- check if there are rows with 0 weekend and week nights = 78 lines
SELECT COUNT (*)
FROM HOTEL_RESERVATIONS
WHERE NO_OF_WEEK_NIGHTS = 0
	AND NO_OF_WEEKEND_NIGHTS = 0;
	

-- check 'lead_time' column range = Min: 0, Max 443
SELECT MIN(LEAD_TIME),
	MAX (LEAD_TIME)
FROM HOTEL_RESERVATIONS;


-- check 'avg_price_per_room' column range = Min: 0, Max: 540
SELECT MAX(AVG_PRICE_PER_ROOM),
	MIN(AVG_PRICE_PER_ROOM)
FROM HOTEL_RESERVATIONS;


--check average price per room = 103
SELECT ROUND(AVG(AVG_PRICE_PER_ROOM),0)
FROM HOTEL_RESERVATIONS;


-- check 'no_of_previous_cancellations' column range = 1,2,3,4,5,6,11,13
SELECT DISTINCT NO_OF_PREVIOUS_CANCELLATIONS
FROM HOTEL_RESERVATIONS
ORDER BY 1;


-- check no_of_previous_bookings_not_cancelled column range = : from 0 to 58
SELECT DISTINCT NO_OF_PREVIOUS_BOOKINGS_NOT_CANCELED
FROM HOTEL_RESERVATIONS
ORDER BY 1;

-- check distinct values in columns: 

-- booking status = Result: Cancelled, Not_Cancelled
SELECT DISTINCT BOOKING_STATUS
FROM HOTEL_RESERVATIONS;

-- no_of_special_requests: Result: from 0 to 5
SELECT DISTINCT NO_OF_SPECIAL_REQUESTS
FROM HOTEL_RESERVATIONS
ORDER BY 1;

-- repeated_guest: 0 for new guest, 1 for repeated guest
SELECT DISTINCT REPEATED_GUEST
FROM HOTEL_RESERVATIONS;

-- market_segment_type: Aviation, Complementary, Corporate, Offline, Online
SELECT DISTINCT MARKET_SEGMENT_TYPE
FROM HOTEL_RESERVATIONS;

-- room_type: 7 room types: Room_Type_1 ... Room_Type_7
SELECT DISTINCT ROOM_TYPE
FROM HOTEL_RESERVATIONS;

-- type_of_meal_plan: Meal Plan 1, 2 & 3 & Not Selected
SELECT DISTINCT TYPE_OF_MEAL_PLAN
FROM HOTEL_RESERVATIONS;


CREATE MATERIALIZED VIEW CLEANED_HOTEL_BOOKINGS_MV4 AS
SELECT *,
	TO_DATE(ARRIVAL_YEAR || '-' || ARRIVAL_MONTH || '-' || ARRIVAL_DATE,'YYYY-MM-DD') AS ARRIVAL_DATE_FULL
FROM HOTEL_RESERVATIONS
WHERE BOOKING_ID NOT IN
		(SELECT BOOKING_ID
			FROM HOTEL_RESERVATIONS
			WHERE ARRIVAL_YEAR = 2018
				AND ARRIVAL_MONTH = 2
				AND ARRIVAL_DATE = 29 )
	AND NO_OF_CHILDREN NOT IN (9,10)
	AND (NO_OF_WEEK_NIGHTS + NO_OF_WEEKEND_NIGHTS) <> 0;






















