ALTER TABLE [dbo].[retail_contract] DROP CONSTRAINT [FK_retail_contract_retail_tariff];
GO
ALTER TABLE [dbo].[retail_contract] DROP CONSTRAINT [FK_retail_contract_retailer];
GO
ALTER TABLE [dbo].[retail_contract] DROP CONSTRAINT [FK_retail_contract_network_tariff];
GO
ALTER TABLE [dbo].[retail_contract] DROP CONSTRAINT [FK_retail_contract_network_provider];
GO
ALTER TABLE [dbo].[retail_contract]
DROP COLUMN [retail_tariff_id],
            [retailer_id],
            [network_tariff_id],
            [network_provider_id],
            [is_network_charges_bundled];
GO
