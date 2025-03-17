SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[regulatory_environmental_company] (
    [id] INT NOT NULL PRIMARY KEY,
    [company_id] INT NOT NULL,
    [regulatory_environmental_rate_id] INT NOT NULL,
    [created_at] DATETIME2(7) NOT NULL DEFAULT (SYSDATETIME()),
    [updated_at] DATETIME2(7) NOT NULL DEFAULT (SYSDATETIME())
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[regulatory_environmental_company] ADD CONSTRAINT [FK_regulatory_environmental_company]
FOREIGN KEY ([company_id]) REFERENCES [dbo].[company] ([id])
GO

ALTER TABLE [dbo].[regulatory_environmental_company] ADD CONSTRAINT [FK_regulatory_environmental_company_rate_id]
FOREIGN KEY ([regulatory_environmental_rate_id]) REFERENCES [dbo].[regulatory_environmental_rate] ([id])
GO
