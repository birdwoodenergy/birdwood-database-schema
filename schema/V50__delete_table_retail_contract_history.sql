ALTER TABLE [dbo].[retail_contract_history] DROP CONSTRAINT [FK_retail_contract_history_company];
GO

ALTER TABLE [dbo].[retail_contract_history] DROP CONSTRAINT [FK_retail_contract_history_retail_contract];
GO

ALTER TABLE [dbo].[retail_contract_history] DROP CONSTRAINT [PK_retail_contract_history];
GO

DROP TABLE [dbo].[retail_contract_history];
GO
