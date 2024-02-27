SELECT*
FROM Portfolioproject..CovidDeaths
order by 3,4

--SELECT*
--FROM Portfolioproject..CovidVaccinations#xlsx$
--order by 3,4
--select the data that we are going to use

SELECT LOCATION, DATE, total_cases, new_cases, total_deaths, population
FROM Portfolioproject..CovidDeaths
order by 1,2

-- Looking at the Total cases VS Total Deaths

-- Looking TOTAL CASES vs TOTAL DEATHS
-- Shows Likelihood of dying if you contact covid in your country
SELECT Location,
    Date,
    total_cases,
    total_deaths,
    (CAST(total_deaths AS decimal) / CAST(total_cases AS decimal))*100 As DeathPercentage
FROM Portfolioproject..CovidDeaths
WHERE location like '%states%'
order by 1,2

-- Total cases vs population
-- shows what percentage of popuation got covid
SELECT Location,
    Date,
    total_cases,
    population,
    (CAST(total_cases AS decimal) / CAST(population AS decimal))*100 As DeathPercentage
FROM Portfolioproject..CovidDeaths
--WHERE location like '%states%'
order by 1,2

-- Looking at countries with Highest Infection rate compared to Population

SELECT location, MAX(total_deaths) as TotalDeathCount
FROM Portfolioproject..CovidDeaths
--WHERE location like '%states%'
Group by location
order by TotalDeathCount desc



SELECT Location,
    
    MAX(total_cases) as HighestInfectionCount ,
    population,
    MAX(CAST(total_cases AS decimal) / CAST(population AS decimal))*100 As PoluationPercentageInfected
FROM Portfolioproject..CovidDeaths
--WHERE location like '%states%'
Group by location, Population
order by PoluationPercentageInfected desc

-- LETS BREAK THINGS BY CONTINENT
-- showing the continents with the highest death count per population
SELECT continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
WHERE continent is not null
Group by continent
ORDER BY TotalDeathCount desc

SELECT location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
WHERE continent is  null
Group by location
ORDER BY TotalDeathCount desc


--GLOBAL NUMBERS
SELECT Date,SUM(new_cases) AS total_cases,SUM(cast(new_deaths as int)) AS total_deaths, 
SUM(CAST(new_deaths as int))/ SUM(New_cases)*100 AS DeathPercentage
FROM [Portfolioproject]..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
GROUP BY Date
ORDER BY 1,2

SELECT Date,SUM(new_cases) AS total_cases,SUM(cast(new_deaths as int)) AS total_deaths, 
ISNULL(SUM(CAST(new_deaths as int))/ NULLIF(SUM(New_cases),0)*100, 'No cases') AS DeathPercentage
FROM [Portfolioproject]..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
GROUP BY Date
ORDER BY 1,2

-- total population vs vaccination
SELECT dea.continent, dea.location,dea.date,dea.population, vac.new_vaccinations
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations#xlsx$ vac
on dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 1,2,3

