-- Queries performed on patients table from https://www.sql-practice.com/

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

-- select first name and last name of patients who don't have allergies
SELECT first_name, last_name FROM patients
WHERE allergies IS NULL;

-- calculate average height and weight by gender, using aliases for column names
SELECT gender, AVG(height) as average_height, AVG(weight) AS average_weight FROM patients
GROUP BY gender;

-- select first names that begin with C
SELECT first_name FROM patients
WHERE first_name like 'C%';

-- show unique years that patients were born, ascending
SELECT DISTINCT YEAR(birth_date) FROM patients
ORDER BY birth_date;

-- Show unique first names from the patients table (HAVING used as WHERE can't be used with aggregate functions)
SELECT first_name FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1;

Show patient_id and first_name from patients where their first name starts and ends with 's' and is at least 5 characters long
SELECT patient_id, first_name FROM patients
WHERE LEN(first_name) > 4 AND first_name LIKE 's%s';

Show patient_id, first_name, last_name from patients whos primary_diagnosis is 'Dementia' (admissions table).
SELECT p.patient_id, p.first_name, p.last_name
FROM patients p
JOIN admissions a ON p.patient_id=a.patient_id
WHERE a.primary_diagnosis = 'Dementia';

Show patient_id, primary_diagnosis from admissions. Find patients admitted multiple times for the same primary_diagnosis
SELECT patient_id, primary_diagnosis FROM admissions
GROUP BY patient_id, primary_diagnosis
HAVING COUNT(primary_diagnosis) > 1;

Show the city and the total number of patients in the city in the order from most to least patients
SELECT city, COUNT(patient_id) FROM patients
GROUP BY city
ORDER BY COUNT(patient_id) DESC;
