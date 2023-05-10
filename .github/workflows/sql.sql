--which areas have lower/higher access to vaccines based on income?
create table vaccination_rates( age integer,
name varchar, vaccination_status varchar, income integer,
state varchar
);
\copy vaccination_rates(age, name, vaccination_status, income,state) FROM 
'C:\Users\Salma\OneDrive\Desktop\Comp Sci- 232 (Spring Term 
2021)\our-world-in-data-vaccination-coverage-by-income.csv' DELIMITER ',' CSV HEADER
SELECT
AVG(ALL vaccination_status),
avg_vaccination_rate
FROM
vaccination_rates
GROUP BY income, state;

--Which day had the lowest vaccination record and in which state?
create table us_vaccination( entity varchar,
code varchar,
day date, daily_vaccinations int
);
\copy us_vaccination(entity, code, day, daily_vaccinations) FROM 'C:\Users\Melanie\OneDrive\Desktop\Comp Sci- 232 (Spring Term 2021)\us-daily-covid-vaccine-doses-administered.csv' DELIMITER ',' CSV HEADER
--FIRST SOLUTION
select entity, daily_vaccinations, day
from us_vaccination
group by entity, day, daily_vaccinations
order by daily_vaccinations, entity asc limit 1;
--SECOND SOLUTION
select entity, daily_vaccinations, day from us_vaccination
where daily_vaccinations >= 0
group by entity, day, daily_vaccinations
order by daily_vaccinations, entity asc limit 1;

--which areas have been/not been vaccinated based on political affinity?
ALTER TABLE vaccination_rates ADD political_affiliation varchar:
\copy vaccination_rates(age, name, vaccination_status, income,state,political_affiliation) FROM 'C:\Users\Salma\OneDrive\Desktop\Comp Sci- 232 (Spring Term 2021)\covid-cdc-gov-covid-data-tracker.csv' DELIMITER ',' CSV HEADER
SELECT vaccination_rates, political_affiliation
FROM table_name
WHERE democratic OR republican OR third_party OR none_of_the_above
GROUP BY political_affiliation, state;

--Which state has the most vaccinations up to this day (May 12, 2021) according to the dataset?
create table us_vaccination( entity varchar,
code varchar,
day date, daily_vaccinations int
);
\copy us_vaccination(entity, code, day, daily_vaccinations) FROM 'C:\Users\Melanie\OneDrive\Desktop\Comp Sci- 232 (Spring Term 2021)\us-daily-covid-vaccine-doses-administered.csv' DELIMITER ',' CSV HEADER
--FIRST SOLUTION
select entity,
round(sum(daily_vaccinations), 2) as sum_vaccine
from us_vaccination
group by entity
order by sum_vaccine desc limit 1; --SECOND SOLUTION
select entity,
round(sum(daily_vaccinations), 2) as sum_vaccine from us_vaccination
where entity != 'United States'
group by entity
order by sum_vaccine desc limit 1;

--Which day had the highest vaccination record in New York?
create table us_vaccination( entity varchar,
code varchar,
day date, daily_vaccinations int
);
\copy us_vaccination(entity, code, day, daily_vaccinations) FROM 'C:\Users\Melanie\OneDrive\Desktop\Comp Sci- 232 (Spring Term 2021)\us-daily-covid-vaccine-doses-administered.csv' DELIMITER ',' CSV HEADER
select entity, daily_vaccinations, day from us_vaccination
where entity = 'New York State'
group by entity, day, daily_vaccinations order by daily_vaccinations desc limit 1;

--Which entity in the dataset should have an increase of access to vaccinations?
create table us_vaccination( entity varchar,
code varchar,
day date, daily_vaccinations int
);
\copy us_vaccination(entity, code, day, daily_vaccinations) FROM 'C:\Users\Melanie\OneDrive\Desktop\Comp Sci- 232 (Spring Term 2021)\us-daily-covid-vaccine-doses-administered.csv' DELIMITER ',' CSV HEADER
select entity,
round(avg(daily_vaccinations), 2) as avg_vaccine
from us_vaccination group by entity order by avg_vaccine asc;

--How many Americans are currently fully vaccinated as of May 12th in the United States?
create table us_vaccination( entity varchar,
code varchar,
day date, daily_vaccinations int
);
\copy us_vaccination(entity, code, day, daily_vaccinations) FROM ‘'C:\Users\Melanie\OneDrive\Desktop\Comp Sci- 232 (Spring Term 2021)\us-daily-covid-vaccine-doses-administered.csv' DELIMITER ',' CSV HEADER
SELECT entity, sum(daily_vaccinations) FROM us_vaccination
where entity = 'United States'
group by entity;

--How many people under 18 have been vaccinated ?
create table us_vaccination( entity varchar,
code varchar,
day date, daily_vaccinations int, age int
);
SELECT age, COUNT(daily_vaccinations) FROM us_vaccination
WHERE age < 18
group by age;

--What is the average rate of vaccination per day?
create table us_vaccination( entity varchar,
code varchar,
day date, daily_vaccinations int
);
\copy us_vaccination(entity, code, day, daily_vaccinations) FROM 'C:\Users\Melanie\OneDrive\Desktop\Comp Sci- 232 (Spring Term 2021)\us-daily-covid-vaccine-doses-administered.csv' DELIMITER ',' CSV HEADER
select day,
round(avg(daily_vaccinations), 2) as avg_vaccine
from us_vaccination
group by day
order by day asc, avg_vaccine;

--Which age group is more likely to get vaccinated?
create table us_vaccination( entity varchar,
code varchar,
age int,
day date, daily_vaccinations int
);
select entity, age,
round(avg(daily_vaccinations), 2) as avg_vaccine
from us_vaccination
group by age
order by avg_vaccine desc, age;
