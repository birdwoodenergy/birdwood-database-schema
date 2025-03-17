SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[retail_contract_network_tariff] (
    [id] INT NOT NULL PRIMARY KEY,
    [company_id] INT NOT NULL,
    [retail_contract_id] INT NOT NULL,
    [network_tariff_id] INT NOT NULL,
    [created_at] DATETIME2(7) NOT NULL DEFAULT (SYSDATETIME()),
    [updated_at] DATETIME2(7) NOT NULL DEFAULT (SYSDATETIME())
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[retail_contract_network_tariff] ADD CONSTRAINT [FK_retail_contract_network_tariff_company]
FOREIGN KEY ([company_id]) REFERENCES [dbo].[company] ([id])
GO

ALTER TABLE [dbo].[retail_contract_network_tariff] ADD CONSTRAINT [FK_retail_contract_network_tariff_retail_contract]
FOREIGN KEY ([retail_contract_id]) REFERENCES [dbo].[retail_contract] ([id])
GO

ALTER TABLE [dbo].[retail_contract_network_tariff] ADD CONSTRAINT [FK_retail_contract_network_tariff_network_tariff]
FOREIGN KEY ([network_tariff_id]) REFERENCES [dbo].[network_tariff] ([id])
GO
