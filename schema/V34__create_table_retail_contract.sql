SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[retail_contract](
	[id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[retail_tariff_id] [int] NOT NULL,
	[retailer_id] [int] NOT NULL,
	[network_tariff_id] [int] NULL,
	[network_provider_id] [int] NULL,
	[is_network_charges_bundled] [bit] NOT NULL,
	[created_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME()),
    [updated_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME()),
    [is_active] [bit] NOT NULL DEFAULT 1,
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[retail_contract] ADD  CONSTRAINT [PK_retail_contract] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[retail_contract]  WITH CHECK ADD  CONSTRAINT [FK_retail_contract_company_id] FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([id])
GO
ALTER TABLE [dbo].[retail_contract] CHECK CONSTRAINT [FK_retail_contract_company_id]
GO
ALTER TABLE [dbo].[retail_contract]  WITH CHECK ADD  CONSTRAINT [FK_retail_contract_network_provider] FOREIGN KEY([network_provider_id])
REFERENCES [dbo].[network_provider] ([id])
GO
ALTER TABLE [dbo].[retail_contract] CHECK CONSTRAINT [FK_retail_contract_network_provider]
GO
ALTER TABLE [dbo].[retail_contract]  WITH CHECK ADD  CONSTRAINT [FK_retail_contract_network_tariff] FOREIGN KEY([network_tariff_id])
REFERENCES [dbo].[network_tariff] ([id])
GO
ALTER TABLE [dbo].[retail_contract] CHECK CONSTRAINT [FK_retail_contract_network_tariff]
GO
ALTER TABLE [dbo].[retail_contract]  WITH CHECK ADD  CONSTRAINT [FK_retail_contract_retail_tariff] FOREIGN KEY([retail_tariff_id])
REFERENCES [dbo].[retail_tariff] ([id])
GO
ALTER TABLE [dbo].[retail_contract] CHECK CONSTRAINT [FK_retail_contract_retail_tariff]
GO
ALTER TABLE [dbo].[retail_contract]  WITH CHECK ADD  CONSTRAINT [FK_retail_contract_retailer] FOREIGN KEY([retailer_id])
REFERENCES [dbo].[retailer] ([id])
GO
ALTER TABLE [dbo].[retail_contract] CHECK CONSTRAINT [FK_retail_contract_retailer]
GO
CREATE UNIQUE INDEX [UQ_retail_contract_company_active]
ON [dbo].[retail_contract] ([company_id])
WHERE [is_active] = 1;
GO
ALTER TABLE [dbo].[retail_contract]
ADD CONSTRAINT CHK_retail_contract_date_start_date_lt_end_date CHECK ([start_date] < [end_date]);
GO
