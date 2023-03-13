/* TWORZYMY NOW¥ TABELE I KOPIUJEMY DO NIEJ WARTOSCI Z [dbo].[FactResellerSalesXL_CCI] */
SELECT * into tmpFactResellerSalesXL From [dbo].[FactResellerSalesXL_CCI]

/* DODAJEMY CLUSTERED INDEX NA KOLUMNACH SalesOrderNumber I SalesOrderLineNumber */
ALTER TABLE [dbo].[tmpFactResellerSalesXL]
ADD CONSTRAINT [PK_tmp_SalesOrderNumber_SalesOrderLineNumber]
PRIMARY KEY CLUSTERED
(
	[SalesOrderNumber] ASC,
	[SalesOrderLineNumber] ASC
)

/* W£¥CZAMY STATYSTYKI I CZAS ¯EBY MIEÆ LEPSZY KONTRAST PORÓWNANIA INDEXÓW */
SET STATISTICS IO ON
SET STATISTICS TIME ON;

/* WYWO£UJEMY KOSZTOWNE QUERY Z AGREGACJAMI */
SELECT ProductKey, sum(SalesAmount) SalesAmount, sum(OrderQuantity) ct
FROM [dbo].[tmpFactResellerSalesXL]
GROUP BY ProductKey


/* WYWO£UJEMY TO SAMO ZAPYTANIE, ALE NA TABELI Z CCI */
SELECT ProductKey, sum(SalesAmount) SalesAmount, sum(OrderQuantity) ct
FROM dbo.FactResellerSalesXL_CCI
GROUP BY ProductKey
