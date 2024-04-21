--SELECT USED DATA

SELECT * FROM covid_data cd WHERE "location" = 'Poland';

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM covid_data cd
WHERE continent IS NOT NULL;

-- DEATH PERCENTAGE 
SELECT location, date, total_cases, total_deaths,
((total_deaths::FLOAT)/(total_cases::FLOAT)*100) AS death_percentage
FROM covid_data cd 
WHERE location = 'Poland'
ORDER BY "location","date" ;

-- TOTAL CASES AND POPULATION
SELECT location, date, total_cases, population,
(total_cases::FLOAT/population)*100 AS cases_percentage
FROM covid_data cd  
WHERE location = 'Poland' 
AND total_cases IS NOT NULL
ORDER BY cases_percentage DESC;

-- COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION
SELECT "location",
MAX((total_cases::FLOAT/population)*100) AS infection_rate
FROM covid_data cd 
WHERE total_cases IS NOT NULL AND
population IS NOT NULL
GROUP BY "location" 
ORDER BY infection_rate DESC;

-- COUNTRIES WITH HIGHEST DEATH RATE COMPARED TO POPULATION
SELECT "location",
MAX((total_deaths::FLOAT/population)*100) AS death_rate
FROM covid_data cd 
WHERE total_deaths IS NOT NULL AND
population IS NOT NULL
GROUP BY "location" 
ORDER BY death_rate DESC;

-- POPULATION VS VACCINATION
select "location","date" ,new_vaccinations,new_cases
from covid_data cd
where new_vaccinations is not null and "location" = 'Poland'
order by "date";

-- COMPARE TOTAL DEATH - INTERVAL 1 DAY
select 
    TO_DATE(cd1.date, 'YYYY-MM-DD') AS date1,
    TO_DATE(cd2.date, 'YYYY-MM-DD') AS date2,
    cd1.total_deaths AS deaths_on_date1,
    cd2.total_deaths AS deaths_on_date2
from 
    covid_data cd1
join 
    covid_data cd2 ON TO_DATE(cd1.date, 'YYYY-MM-DD') + INTERVAL '1 day' = TO_DATE(cd2.date, 'YYYY-MM-DD')
                AND cd1.date < cd2.date
where 
    cd1.location = 'Poland' AND cd2.location = 'Poland'
order by 
    TO_DATE(cd1.date, 'YYYY-MM-DD') DESC;








