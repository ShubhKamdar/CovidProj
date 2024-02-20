--SELECT *
--FROM CovidDeaths
--ORDER BY 3,4

--SELECT *
--FROM CovidVaccinations
--ORDER BY 3,4

--SELECT location, date, total_cases , new_cases , total_deaths ,population
--FROM CovidDeaths
--ORDER BY 1,2







--TOTAL CASES VS TOTAL DEATHS
--showing the probability of someone dying on a specific day if infected by COVID

--SELECT location, date, total_cases, total_deaths, 
--(CONVERT(FLOAT,total_deaths) / NULLIF(CONVERT(FLOAT, total_cases), 0)) * 100 AS DEATHPERCENTAGE
--FROM PortfolioProject..covidDeaths
--ORDER BY 1,2

----USA
--SELECT location, date, total_cases, total_deaths, 
--(CONVERT(FLOAT,total_deaths) / NULLIF(CONVERT(FLOAT, total_cases), 0)) * 100 AS DEATHPERCENTAGE
--FROM PortfolioProject..covidDeaths
--WHERE location like '%states%'
--ORDER BY 1,2

----GERMANY
--SELECT location, date, total_cases, total_deaths, 
--(CONVERT(FLOAT,total_deaths) / NULLIF(CONVERT(FLOAT, total_cases), 0)) * 100 AS DEATHPERCENTAGE
--FROM PortfolioProject..covidDeaths
--WHERE location = 'Germany'
--ORDER BY 1,2
----GERMANY RECORDED DEATHS MORE THAN THE TOTAL NUMBER OF CASES FOR THE FIRST 20 DAYS


----CHINA
--SELECT location, date, total_cases, total_deaths, 
--(CONVERT(FLOAT,total_deaths) / NULLIF(CONVERT(FLOAT, total_cases), 0)) * 100 AS DEATHPERCENTAGE
--FROM PortfolioProject..covidDeaths
--WHERE location = 'China'
--ORDER BY 1,2

----RUSSIA
--SELECT location, date, total_cases, total_deaths, 
--(CONVERT(FLOAT,total_deaths) / NULLIF(CONVERT(FLOAT, total_cases), 0)) * 100 AS DEATHPERCENTAGE
--FROM PortfolioProject..covidDeaths
--WHERE location = 'Russia'
--ORDER BY 1,2

----UK
--SELECT location, date, total_cases, total_deaths, 
--(CONVERT(FLOAT,total_deaths) / NULLIF(CONVERT(FLOAT, total_cases), 0)) * 100 AS DEATHPERCENTAGE
--FROM PortfolioProject..covidDeaths
--WHERE location like '%kingdom%'
--ORDER BY 1,2
--UK HAD A DEATHPERCENTAGE OF ALMOST 23% AT ONE POINT





--CASES VS POPULATION
--showing probability of someone being infected

--SELECT location, date, total_cases, population, 
--( NULLIF(CONVERT(FLOAT, total_cases), 0)/ CONVERT(FLOAT,population)) * 100 AS INFECTED_PERCENTAGE
--FROM PortfolioProject..covidDeaths
--ORDER BY 1,2

--USA
--SELECT location, date, total_cases, population, 
--( NULLIF(CONVERT(FLOAT, total_cases), 0)/ CONVERT(FLOAT,population)) * 100 AS INFECTED_PERCENTAGE
--FROM PortfolioProject..covidDeaths
--WHERE location  = 'UNITED STATES'
--ORDER BY 1,2
--30 PERCENT OF THE POPULATION WAS INFECTED 

--CHINA
--SELECT location, date, total_cases, population, 
--( NULLIF(CONVERT(FLOAT, total_cases), 0)/ CONVERT(FLOAT,population)) * 100 AS INFECTED_PERCENTAGE
--FROM PortfolioProject..covidDeaths
--WHERE location  = 'CHINA'
--ORDER BY 1,2
--JUMPED FROM 1 PERCENT TO 6 PERCENT IN A MATTER OF 10 DAYS

--RUSSIA
--SELECT location, date, total_cases, population, 
--( NULLIF(CONVERT(FLOAT, total_cases), 0)/ CONVERT(FLOAT,population)) * 100 AS INFECTED_PERCENTAGE
--FROM PortfolioProject..covidDeaths
--WHERE location  = 'RUSSIA'
--ORDER BY 1,2
-- 16 PERCENT OF THE POPULATION WAS INFECTED

--UK
--SELECT location, date, total_cases, population, 
--( NULLIF(CONVERT(FLOAT, total_cases), 0)/ CONVERT(FLOAT,population)) * 100 AS INFECTED_PERCENTAGE
--FROM PortfolioProject..covidDeaths
--WHERE location  = 'UNITED KINGDOM'
--ORDER BY 1,2
--36 PERCENT OF THE POPULATION WAS INFECTED

--GERMANY
--SELECT location, date, total_cases, population, 
--( NULLIF(CONVERT(FLOAT, total_cases), 0)/ CONVERT(FLOAT,population)) * 100 AS INFECTED_PERCENTAGE
--FROM PortfolioProject..covidDeaths
--WHERE location  = 'GERMANY'
--ORDER BY 1,2
-- 46 PERCENT OF THE POPULATIN WAS INFECTED






--INFECTED PERCENT AND DEATH PERCENT OF ALL THE COUNTRIES
--SELECT location,population,MAX(CAST(total_cases AS BIGINT) )AS MAXIMUM_CASES,
--MAX((NULLIF(CONVERT(FLOAT, total_cases), 0)/ CONVERT(FLOAT,population))) * 100 AS INFECTED_PERCENTAGE
--FROM CovidDeaths
--GROUP BY location ,population
--ORDER BY INFECTED_PERCENTAGE DESC 

--SELECT location,population,MAX(CAST(total_deaths AS BIGINT)) AS MAXIMUM_DEATHS,
--MAX((NULLIF(CONVERT(FLOAT, total_deaths), 0)/ CONVERT(FLOAT,population))) * 100 AS DEATH_PERCENTAGE
--FROM CovidDeaths
--GROUP BY location ,population
--ORDER BY DEATH_PERCENTAGE DESC 





--DEATHCOUNT
--SELECT location,MAX(CAST(total_deaths AS BIGINT)) AS TOTALDEATHSS
--FROM CovidDeaths
--WHERE continent IS NOT NULL
--GROUP BY location
--ORDER BY TOTALDEATHSS DESC

--WHEN THE CONTINENT COLUMN WAS NULL THE EXCEL WAS GIVING INFORMATION ABOUT THE CONTINENTS IN THE LOCATION COLUMN
-- DEATHS IN A CONTINENT

--SELECT location , MAX(CAST(Total_deaths AS BIGINT)) AS TOTAL_DEATHS_CONTINENT
--FROM CovidDeaths
--WHERE continent IS NULL 
--AND location <> 'HIGH INCOME' AND location <>'UPPER MIDDLE INCOME' AND location <>'LOWER MIDDLE INCOME'AND location <> 'LOW INCOME'
--GROUP BY location
--ORDER BY TOTAL_DEATHS_CONTINENT DESC

--SELECT SUM(new_cases) AS TOTALCASES, SUM(CAST(new_deaths AS INT)) AS TOTALDEATHS,SUM(CAST(new_deaths AS INT))/SUM(new_cases) AS DEATHPERCENTAGE
--FROM CovidDeaths
--WHERE continent IS NOT NULL




--VACCINATIONS
--showing the dates on which people were vaccinated in a country and the total number of people vaccinated throughout the days
--SELECT CovidDeaths.continent,CovidDeaths.location,CovidDeaths.date, population, new_vaccinations,
--SUM(CAST(new_vaccinations AS BIGINT)) OVER (PARTITION BY COVIDDEATHS.LOCATION ORDER BY COVIDDEATHS.DATE,COVIDDEATHS.LOCATION) AS NumberOfPeopledVaccinatedAtATime
--FROM CovidDeaths
--JOIN CovidVaccinations
--ON CovidDeaths.location=CovidVaccinations.location
--AND CovidDeaths.date = CovidVaccinations.date
--WHERE CovidDeaths.continent IS NOT NULL
--ORDER BY 2,3


--WITH CTE_VACCINATION 
--AS
--(
--SELECT CovidDeaths.continent,CovidDeaths.location,CovidDeaths.date, population, new_vaccinations,
--SUM(CAST(new_vaccinations AS BIGINT)) OVER (PARTITION BY COVIDDEATHS.LOCATION ORDER BY COVIDDEATHS.DATE,COVIDDEATHS.LOCATION) AS NumberOfPeopledVaccinatedAtATime
--FROM CovidDeaths
--JOIN CovidVaccinations
--ON CovidDeaths.location=CovidVaccinations.location
--AND CovidDeaths.date = CovidVaccinations.date
--WHERE CovidDeaths.continent IS NOT NULL
--)
--SELECT *, (NumberOfPeopledVaccinatedAtATime/population) *100
--FROM CTE_VACCINATION
--ORDER BY 2,3

--MAKE TEMPTABLE WHEN YOU CAN THINK OF MORE CALCULATIONS

----drop table #TEMP_PercentPopulationVaccinated
--CREATE TABLE #TEMP_PercentPopulationVaccinated
--(
--Continent NVARCHAR(255),
--Location NVARCHAR(255),
--Date DATETIME,
--Population NUMERIC,
--New_vaccinations NUMERIC,
--NumberOfPeopledVaccinatedAtATime NUMERIC
--)

--INSERT INTO #TEMP_PercentPopulationVaccinated
--SELECT CovidDeaths.continent,CovidDeaths.location,CovidDeaths.date, population, new_vaccinations,
--SUM(CAST(new_vaccinations AS BIGINT)) OVER (PARTITION BY COVIDDEATHS.LOCATION ORDER BY COVIDDEATHS.DATE,COVIDDEATHS.LOCATION) AS NumberOfPeopledVaccinatedAtATime
--FROM CovidDeaths
--JOIN CovidVaccinations
--ON CovidDeaths.location=CovidVaccinations.location
--AND CovidDeaths.date = CovidVaccinations.date
----WHERE CovidDeaths.continent IS NOT NULL
----order by 2,3

--SELECT *,(NumberOfPeopledVaccinatedAtATime/Population)*100
--FROM #TEMP_PercentPopulationVaccinated
--ORDER BY 2,3




--creating view for tableau
CREATE VIEW PercentPopulationVaccinated AS
SELECT CovidDeaths.continent, CovidDeaths.location, CovidDeaths.date, CovidDeaths.population, CovidVaccinations.new_vaccinations
, SUM(CONVERT(BIGINT,CovidVaccinations.new_vaccinations)) OVER (PARTITION BY  CovidDeaths.Location ORDER BY CovidDeaths.location, CovidDeaths.Date) AS NumberOfPeopledVaccinatedAtATime
FROM CovidDeaths 
JOIN CovidVaccinations 
	ON CovidDeaths.location = CovidVaccinations.location
	AND CovidDeaths.date = CovidVaccinations.date
