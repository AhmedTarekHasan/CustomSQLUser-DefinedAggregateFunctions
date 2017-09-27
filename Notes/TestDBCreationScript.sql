USE [TestDB01]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[T1](
	[Col1] [nvarchar](100) NOT NULL,
	[Col2] [int] NOT NULL,
	[Col3] [int] NOT NULL,
 CONSTRAINT [PK_T1] PRIMARY KEY CLUSTERED 
(
	[Col1] ASC,
	[Col2] ASC,
	[Col3] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO T1(Col1, Col2, Col3)
VALUES('Ahmed', 1, 1)
, ('Ahmed', 1, 2)
, ('Ahmed',	1, 5)
, ('Ahmed',	1, 6)
, ('Ahmed',	2, 2)
, ('Ahmed',	3, 4)
, ('Ahmed',	4, 2)
, ('Ahmed',	5, 2)
, ('Ahmed',	6, 2)
, ('Ali', 2, 1)
, ('Ali', 2, 3)
, ('Ali', 2, 4)
, ('Ali', 2, 5)
, ('Ali', 2, 7)
, ('Ali', 2, 9)
, ('Ali', 3, 5)
, ('Ali', 4, 5)
, ('Ali', 6, 5)
, ('Sami', 2, 3)
, ('Sami', 2, 7)
, ('Sami', 5, 0)
, ('Sami', 5, 1)
, ('Sami', 5, 4)
, ('Sami', 8, 6)