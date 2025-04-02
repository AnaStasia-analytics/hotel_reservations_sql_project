# hotel_reservations_sql_project
Dataset link: https://www.kaggle.com/datasets/ahsan81/hotel-reservations-classification-dataset

# 1. Data Exploration & Preparation with SQL:
   
The first part of this project involved exploratory data analysis to become familiar with the dataset, its dimensions, ranges, and to prepare the data for further analysis. 

## Key steps and findings include:

### Dataset Integrity:

The dataset contains no duplicate records, verified using booking_id as the primary key.

There are no missing values in any columns.

### Dataset Scope:

The data covers hotel reservations for a single property from July 2017 to December 2018 (based on arrival dates).

### Data Cleaning:

A total of 118 records were excluded for the following reasons:

•		37 records contained invalid dates (e.g., February 29, 2018, which does not exist). 

•		3 records had an unusually high number of children (9 or 10), which appeared as outliers. The next highest value in this column was 3.

•	  78 records showed both no_of_weekend_nights and no_of_week_nights equal to 0.
   
### Insights on "0-night" stays:

•		These records likely represent complimentary or extra-hour stays for early arrivals or late departures.

•		All of these reservations have an average room price of 0 and belong to the "Complimentary" or "Online" marketing segments.

•		Despite the zero-night stay, lead times varied, and most bookings were not cancelled.

# 2. Data Analysis with SQL:
   
The second phase of the analysis focused on answering key business questions in the following areas:

### Reservations

Assessing growth and demand dynamics.

•	Reservation trends by month and year, including average reservation counts per year.

•	Reservation distribution across market segments for each year.

### Cancellations

Understanding cancellation dynamics across given period and marketing segments.

•	Cancellation ratios by year and month.

•	Cancellation trends by market segment and year.

### Guest Composition & Preferences

Identifying customer profiles and preferences.

•	Most common guest composition.

•	Popular room types and meal plan preferences.

•	Average length of stay.

•	Repeated guest %.

•	Average lead time and its correlation with cancellations.

### Hotel Occupation & Revenue

Evaluating performance and profitability.

•	Average monthly and yearly room occupation.
•	Occupation rate (actual vs. available rooms).
•	Monthly and yearly revenue.
•	Revenue per available room (RevPAR).
