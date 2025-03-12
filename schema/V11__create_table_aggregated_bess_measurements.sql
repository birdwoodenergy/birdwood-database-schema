SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aggregated_bess_measurements](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[company_data_provider_id] [int] NOT NULL,
	[created_at] [datetime2](3) NOT NULL,
	[updated_at] [datetime2](3) NULL,
	[total_charge_in_kw] [float] NOT NULL,
	[total_discharge_in_kw] [float] NOT NULL,
	[average_soc] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aggregated_bess_measurements] ADD  CONSTRAINT [PK_AggregatedBESSMeasurements] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aggregated_bess_measurements] ADD  CONSTRAINT [UQ_AggregatedBESSMeasurements_CreatedAt] UNIQUE NONCLUSTERED
(
	[created_at] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_AggregatedBESSMeasurements_CreatedAt] ON [dbo].[aggregated_bess_measurements]
(
	[created_at] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aggregated_bess_measurements] ADD  DEFAULT (sysdatetime()) FOR [updated_at]
GO
ALTER TABLE [dbo].[aggregated_bess_measurements]  WITH CHECK ADD  CONSTRAINT [FK_aggregated_bess_measurements_company_data_provider] FOREIGN KEY([company_data_provider_id])
REFERENCES [dbo].[company_data_provider] ([id])
GO
ALTER TABLE [dbo].[aggregated_bess_measurements] CHECK CONSTRAINT [FK_aggregated_bess_measurements_company_data_provider]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

        CREATE TRIGGER [dbo].[trg_UpdateTimestamp_AggregatedBESSMeasurements]
        ON [dbo].[aggregated_bess_measurements]
        AFTER UPDATE
        AS
        BEGIN
            SET NOCOUNT ON;
            UPDATE dbo.aggregated_bess_measurements
            SET updated_at = SYSDATETIME()
            FROM inserted
            WHERE dbo.aggregated_bess_measurements.id = inserted.id;
        END;
GO
ALTER TABLE [dbo].[aggregated_bess_measurements] ENABLE TRIGGER [trg_UpdateTimestamp_AggregatedBESSMeasurements]
GO
