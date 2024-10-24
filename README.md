The Covid Data Exploration project's SQL data analysis
A common language for storing, accessing, and modifying data in databases is SQL.

Data on COVID deaths and vaccinations worldwide from 2020-01-05 to 2024-05-05 are analyzed in this study. The analysis involved looking at data sets from 380,255 rows that included vaccination and COVID infection rates from every country in the world.
I used skills like CTE, Windows Functions, Joins, Aggregate Functions, Converting Data Type, and Creating Views.
Firstly, I sorted the data from ascending to descending order using the select * method. I picked Cameroon as my case study because it is my home country. I proceeded to choose the data I would need, choosing the location, date, total_cases, new_cases,
I then analyzed 
 1) Total Cases vs. Total Deaths, which illustrates the probability of death in Cameroon if you get COVID.
2) Total Cases vs. Population, which displays the proportion of the population with COVID-19
3) The nations with the highest rates of infection relative to their populations

4)The nations with the greatest number of deaths per population

BREAKING THINGS DOWN BY CONTINENTS

 1)Displaying the continents with the greatest number of deaths per population

2) Globally, the number of new cases, deaths, and death rates by nation 

3) The percentage of the population that has gotten at least one Covid vaccine is displayed by comparing the total population to vaccinations.

4)Using CTE to calculate the partition by in the earlier query.

5)Created several Views to store data for later visualizations




Please feel free to download and use all code as your own

