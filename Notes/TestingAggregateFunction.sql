USE [TestDB01]
GO

SELECT
Col1
, (SELECT dbo.MostCommon(Col2) FROM T1 where main.Col1 = Col1 GROUP BY Col1) AS CommonCol2
, (SELECT dbo.MostCommon(Col3) FROM T1 where main.Col1 = Col1 GROUP BY Col1) AS CommonCol3
FROM T1 AS main
GROUP BY Col1