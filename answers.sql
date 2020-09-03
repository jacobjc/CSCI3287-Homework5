-- Jacob Christiansen - CSCI 3287 - Homework 5
-- 1
use aw;
select count(*) from DimCurrency;
select count(*) from DimTime;
-- etc
-- ANSWERS: DimCurrency: 105, DimTime: 1158, DimPromotion: 16, DimProduct: 158, DimProductSubcategory: 37, DimProductCategory: 4, DimEmployee: 296, DimSalesTerritory: 11, DimCustomer: 18343, DimGeography: 655

-- 2
use information_schema;
select TABLE_NAME, TABLE_ROWS from TABLES;
-- ANSWER: 59808

-- 3
-- ANSWER: They added "Dim" as a prefix to their Dimension Table names

-- 4
-- ANSWER: to indicate an employee's supervisor (thus the "parentEmployee" attributes)

-- 5
use aw;
select EnglishProductSubcategoryName from DimProductSubcategory;
-- ANSWER: Mountain Bikes, Road Bikes, Touring Bikes

-- 6
-- ProductSubcategoryKey: 1=mtn 2=road 3=tour
use aw;
select Tim.CalendarYear, Pro.ProductSubcategoryKey, sum(Sal.UnitPrice) TotalSales from FactInternetSales Sal
	join DimProduct Pro join DimTime Tim on Sal.ProductKey=Pro.ProductKey and Sal.OrderDateKey=Tim.TimeKey
    where (Tim.CalendarYear='2004' OR Tim.CalendarYear='2003' OR Tim.CalendarYear='2002' OR Tim.CalendarYear='2001') AND
    (Pro.ProductSubcategoryKey=1 OR Pro.ProductSubcategoryKey=2 OR Pro.ProductSubcategoryKey=3)
    group by Tim.CalendarYear, Pro.ProductSubcategoryKey
    order by TotalSales;
-- ANSWER: 2002

-- 7
use aw;
select Cus.Gender, Tim.CalendarYear, Tim.MonthNumberOfYear, sum(Sal.UnitPrice) TotalSales from FactInternetSales Sal
	join DimProduct Pro join DimTime Tim join DimCustomer Cus on Sal.ProductKey=Pro.ProductKey and Sal.OrderDateKey=Tim.TimeKey and Sal.CustomerKey=Cus.CustomerKey
    where (Pro.ProductSubcategoryKey=1 OR Pro.ProductSubcategoryKey=2 OR Pro.ProductSubcategoryKey=3)
    group by Cus.Gender, Tim.CalendarYear, Tim.MonthNumberOfYear
    order by TotalSales;
-- ANSWER: June 2004

-- 8
use aw;
select Tim.CalendarYear, Pro.ProductSubcategoryKey, Pro.ModelName, sum(Sal.UnitPrice-Sal.ProductStandardCost) Margin from FactInternetSales Sal
	join DimProduct Pro join DimTime Tim on Sal.ProductKey=Pro.ProductKey and Sal.OrderDateKey=Tim.TimeKey
    where Tim.CalendarYear='2003' AND (Pro.ProductSubcategoryKey=1 OR Pro.ProductSubcategoryKey=2 OR Pro.ProductSubcategoryKey=3)
    group by Tim.CalendarYear, Pro.ProductSubcategoryKey, ModelName
    order by Margin;
-- ANSWER: Mountain-200