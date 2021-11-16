-- select all rows from patients table

SELECT * FROM patients;

-- select the height and weight of all patients

SELECT height, weight FROM patients;

-- select all male patients
SELECT * FROM patients
WHERE gender = "M";

-- select a list of provinces that patients are from, no duplicates

SELECT DISTINCT province_id FROM patients;

-- select a list of patients whose weight is greater than 100

SELECT * FROM patients
WHERE weight > 100; 

-- select a list of patients whose weight is between 100 and 120

SELECT * FROM patients
WHERE weight BETWEEN 100 AND 120; 

-- select a list of cities that patients are from within Ontario, listed alphabetically

SELECT DISTINCT city FROM patients
WHERE province_id = "ON"
ORDER BY city;



