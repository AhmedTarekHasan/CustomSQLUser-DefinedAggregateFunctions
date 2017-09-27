--Turning on CLR functionality
--By default, CLR is disabled in SQL Server so to turn it on
--we need to run this command against our database
EXEC sp_configure 'clr enabled', 1
GO
RECONFIGURE
GO

-- Creating the SQL assembly and linking it to the C# library DLL we created
CREATE ASSEMBLY SQLAggregateFunctions
AUTHORIZATION dbo
FROM 'C:\SQLAggregateFunctions.dll'
WITH PERMISSION_SET = SAFE
GO

CREATE AGGREGATE dbo.MostCommon (@value nvarchar(MAX)) RETURNS nvarchar(MAX)
EXTERNAL NAME SQLAggregateFunctions.[SQLAggregateFunctions.MostCommon]
--EXTERNAL NAME SQLAssemblyName.[C#NameSpace".C#ClassName].C#MethodName


/*
DROP AGGREGATE dbo.MostCommon
DROP ASSEMBLY SQLAggregateFunctions
*/