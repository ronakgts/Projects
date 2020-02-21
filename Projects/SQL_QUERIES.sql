
SELECT DISTINCT PATIENT_ID,BIRTH_DATE,
       DAY(BIRTH_DATE) AS BIRTH_DAY,
       MONTH(BIRTH_DATE) AS BIRTH_MONTH,
       YEAR(BIRTH_DATE) AS BIRTH_YEAR
 FROM RX_FILL_INFO;


 SELECT GETDATE() AS CDT_GETDATE,CURRENT_TIMESTAMP AS  CDT_CTS;


SELECT SYSDATETIME() AS CDT_SDT,GETDATE() AS CDT_GD;



SELECT SYSDATETIME() AS CDT_SDT,
       CAST(SYSDATETIME() AS DATE) AS CD_SDT,
	   CAST(SYSDATETIME() AS TIME) AS CT_SDT;


SELECT DISTINCT PATIENT_ID,BIRTH_DATE,
       CAST(BIRTH_DATE AS DATETIME2) AS BD_DT2,
	   CAST(BIRTH_DATE AS VARCHAR(10)) AS BD_VC,
	   CAST(BIRTH_DATE AS VARCHAR(4)) AS BD_VC_YR
 FROM RX_FILL_INFO;


SELECT SYSDATETIME() AS SDT,
       DATEPART(year,SYSDATETIME()) AS YR,
       DATEPART(quarter,SYSDATETIME()) AS QTR,
       DATEPART(month,SYSDATETIME()) AS MTH,
       DATEPART(dayofyear,SYSDATETIME()) AS DOY,
       DATEPART(day,SYSDATETIME()) AS DY,
       DATEPART(week,SYSDATETIME()) AS WK,
       DATEPART(weekday,SYSDATETIME()) AS WKDY,
       DATEPART(hour,SYSDATETIME()) AS HR,
       DATEPART(minute,SYSDATETIME()) AS MIN,
       DATEPART(second,SYSDATETIME()) AS SEC,
       DATEPART(millisecond,SYSDATETIME()) AS MLS,
       DATEPART(microsecond,SYSDATETIME()) AS MS,
       DATEPART(nanosecond,SYSDATETIME()) AS NS,
       DATEPART(ISO_WEEK,SYSDATETIME()) AS ISOWEEK;

SELECT SYSDATETIME() AS SDT,
       DATEPART(dayofyear,SYSDATETIME()) AS DOY,
       DATENAME(week,SYSDATETIME()) AS WK,
       DATENAME(weekday,SYSDATETIME()) AS WKDY;

	   
SELECT SYSDATETIME() AS SDT,
       DATENAME(year,SYSDATETIME()) AS YR,
       DATENAME(quarter,SYSDATETIME()) AS QTR,
       DATENAME(month,SYSDATETIME()) AS MTH,
       DATENAME(dayofyear,SYSDATETIME()) AS DOY,
       DATENAME(day,SYSDATETIME()) AS DY,
       DATENAME(week,SYSDATETIME()) AS WK,
       DATENAME(weekday,SYSDATETIME()) AS WKDY,
       DATENAME(hour,SYSDATETIME()) AS HR,
       DATENAME(minute,SYSDATETIME()) AS MIN,
       DATENAME(second,SYSDATETIME()) AS SEC,
       DATENAME(millisecond,SYSDATETIME()) AS MLS,
       DATENAME(microsecond,SYSDATETIME()) AS MS,
       DATENAME(nanosecond,SYSDATETIME()) AS NS,
       DATENAME(ISO_WEEK,SYSDATETIME()) AS ISOWEEK;


	   
SELECT SERVICE_DATE,
       DATEADD(year,1,SERVICE_DATE) AS NEXT_YEAR,
       DATEADD(month,1,SERVICE_DATE) AS NEXT_MONTH,
       DATEADD(week,1,SERVICE_DATE) AS NEXT_WEEK,
       DATEADD(day,1,SERVICE_DATE) AS NEXT_DAY
 FROM RX_FILL_INFO;


 
SELECT SERVICE_DATE,
       DATEADD(day,1,SERVICE_DATE) AS NEXT_DAY1,
       DATEADD(dayofyear,1,SERVICE_DATE) AS NEXT_DAY2,
       DATEADD(weekday,1,SERVICE_DATE) AS NEXT_DAY3
 FROM RX_FILL_INFO;



 SELECT CAST('2012-12-31' AS DATE) AS BEG_DATE,
       CAST('2013-12-31' AS DATE) AS END_DATE,
	   DATEDIFF(day,CAST('2012-12-31' AS DATE),CAST('2013-12-31' AS DATE)) AS DIFF_DY;

 SELECT CAST('2012-12-31' AS DATE) AS BEG_DATE,
       CAST('2013-12-31' AS DATE) AS END_DATE,
	   DATEDIFF(day,'2012-12-31', '2013-12-31') AS DIFF_DY;


	   
SELECT DATEDIFF(day,CAST('2013-12-30 09:45:30' AS DATETIME2),CAST('2013-12-31 10:45:30' AS DATETIME2)) AS DIFF;

--Time diff

SELECT DATEDIFF(second,CAST('2013-12-30 09:45:30' AS DATETIME2),CAST('2013-12-31 10:45:30' AS DATETIME2)) AS DIFF;

SELECT CAST(CAST('2013-12-31 10:45:30' AS DATETIME2) AS DATE) AS MyDate;
SELECT CAST(CAST('2013-12-31 10:45:30' AS DATETIME2) AS TIME) AS MyTime;


SELECT CONVERT(varchar(8),CAST('2013-12-31 10:45:30' AS DATETIME2),112) AS TxtDate;







SELECT YEAR(OrderDate)* 10000 + MONTH(OrderDate) * 100 + DAY(OrderDate) FROM Orders


SELECT 
DAY(orderdate) as monthday,
COUNT(*) as numorders, AVG(totalprice) as avgtotalprice
FROM orders
GROUP BY 
DAY(orderdate)
ORDER BY monthday



SELECT (CASE WHEN ShipDate = CAST(ShipDate as DATE) 					
             THEN 'PURE' ELSE 'MIXED' END) as datetype,					
       COUNT(*), MIN(OrderLineId), MAX(OrderLineId)					
FROM OrderLines ol					
GROUP BY (CASE WHEN ShipDate = CAST(ShipDate as DATE) 					
               THEN 'PURE' ELSE 'MIXED' END)					


SELECT shipdate, COUNT(*)
FROM orderlines
GROUP BY shipdate
ORDER BY shipdate



SELECT s.ShipDate as thedate, s.numship, b.numbill				
FROM (SELECT ShipDate, COUNT(*) as numship				
      FROM OrderLines				
      GROUP BY ShipDate				
     ) s LEFT OUTER JOIN				
     (SELECT BillDate, COUNT(*) as numbill				
      FROM OrderLines				
      GROUP BY BillDate				
     ) b				
     ON s.ShipDate = b. BillDate				
ORDER BY thedate				


SELECT COALESCE(s.ShipDate, b.BillDate) as thedate,					
       COALESCE(s.numship, 0) as numship, COALESCE(b.numbill, 0) as numbill					
FROM (SELECT ShipDate, COUNT(*) as numship					
      FROM OrderLines					
      GROUP BY ShipDate					
     ) s FULL OUTER JOIN					
     (SELECT BillDate, COUNT(*) as numbill					
      FROM OrderLines					
      GROUP BY BillDate					
     ) b					
     ON s.ShipDate = b. BillDate					
ORDER BY thedate					



SELECT thedate, SUM(isship) as numships, SUM(isbill) as numbills
FROM ((SELECT ShipDate as thedate, 1 as isship, 0 as isbill
       FROM OrderLines
      ) UNION ALL
      (SELECT BillDate as thedate, 0 as isship, 1 as isbill
       FROM OrderLines)
     ) bs
GROUP BY thedate
ORDER BY thedate





SELECT YEAR(OrderDate) as year, MONTH(OrderDate) as month,						
       COUNT(DISTINCT CustomerId) as numcustomers						
FROM Orders o						
GROUP BY YEAR(OrderDate), MONTH(OrderDate)						
ORDER BY year, month						


						

