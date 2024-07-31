
Covid Data Exploration

Skills used: Joins, CTE, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types


Select *
From [Covid deaths] Deaths
Where continent is not null 
order by 3,4

Select *
From dbo.[Covid Vaccinations]
Where continent is not null 
order by 3,4

-- Select Data that we are going to be Using

Select Location, date, total_cases, new_cases, total_deaths, population
From [Covid deaths] Deaths
Where continent is not null 
order by 1,2

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in Cameroon

Select Location, date, total_cases,total_deaths, (cast(total_deaths as int)*1.0 /total_cases)*100 as DeathPercentage
From [Covid deaths] Deaths
Where continent is not null 
order by 1,2


Select Location, date, total_cases,total_deaths, (cast(total_deaths as int)*1.0 /total_cases)*100 as DeathPercentage
From [Covid deaths] Deaths
Where location like '%Cameroon%'
and continent is not null 
order by 1,2


-- Total Cases vs Population
-- Shows what percentage of population is infected with Covid

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From [Covid deaths] Deaths
--Where location like '%Cameroon%'
order by 1,2

-- Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From [Covid deaths] Deaths
--Where location like '%Cameroon%'
Group by Location, Population
order by PercentPopulationInfected desc

-- Countries with Highest Death Count per Population

Select Location, MAX(cast(Total_deaths as int)*1.0) as TotalDeathCount
From [Covid deaths] Deaths
--Where location like '%Cameroon%'
Where continent is not null 
Group by Location
order by TotalDeathCount desc



-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population


Select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From [Covid deaths] Deaths
Where continent is null 
Group by location
order by TotalDeathCount desc


Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From [Covid deaths] Deaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc


-- GLOBAL NUMBERS

Select Date, SUM(new_cases) as newcase, SUM(cast(new_deaths as int)*1.0) as newdeaths, 
CASE
When SUM(cast(new_deaths as int)*1.0) =0
THEN SUM(New_Cases)+1/1
Else SUM(cast(new_deaths as int)*1.0)/SUM(New_Cases) *100 
end as deathpercentages
From [Covid deaths] Deaths
--Where location like '%Cameroon%'
where continent is not null 
Group By date
order by 1,2

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From [Covid deaths] Deaths
--Where location like '%states%'
where continent is not null 
Group By continent
order by 1,2


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From [Covid deaths] dea
Join dbo.[Covid Vaccinations] vac
	On dea.location = vac.location
	and dea.date = vac.date


Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From [Covid deaths] dea
Join dbo.[Covid Vaccinations] vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3


-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [Covid deaths] dea
Join dbo.[Covid Vaccinations] vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac



---Creating View to store data for later visualizations
 
 Create View deathpercentage as 
 Select Location, date, total_cases,total_deaths, (cast(total_deaths as int)*1.0 /total_cases)*100 as DeathPercentage
From [Covid deaths] Deaths
Where continent is not null 
--order by 1,2

Create View PercentPopulationInfected as
Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From [Covid deaths] Deaths
--Where location like '%Cameroon%'
--order by 1,2

Create View Countrieswithhighinfection as
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From [Covid deaths] Deaths
--Where location like '%Cameroon%'
Group by Location, Population
--order by PercentPopulationInfected desc

Create View Countrieswithhighdeaths as
Select Location, MAX(cast(Total_deaths as int)*1.0) as TotalDeathCount
From [Covid deaths] Deaths
--Where location like '%Cameroon%'
Where continent is not null 
Group by Location
--order by TotalDeathCount desc

Create View Contidentdeathcount as
Select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From [Covid deaths] Deaths
Where continent is null 
Group by location
--order by TotalDeathCount desc





