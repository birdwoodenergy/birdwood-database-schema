SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aggregated_pv_measurements](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[company_data_provider_id] [int] NOT NULL,
	[created_at] [datetime2](3) NOT NULL,
	[updated_at] [datetime2](3) NULL,
	[total_pv_in_kw] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aggregated_pv_measurements] ADD  CONSTRAINT [PK_AggregatedPVMeasurements] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aggregated_pv_measurements] ADD  CONSTRAINT [UQ_AggregatedPVMeasurements_CreatedAt] UNIQUE NONCLUSTERED
(
	[created_at] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_AggregatedPVMeasurements_CreatedAt] ON [dbo].[aggregated_pv_measurements]
(
	[created_at] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aggregated_pv_measurements] ADD  DEFAULT (sysdatetime()) FOR [updated_at]
GO
ALTER TABLE [dbo].[aggregated_pv_measurements]  WITH CHECK ADD  CONSTRAINT [FK_aggregated_pv_measurements_company_data_provider] FOREIGN KEY([company_data_provider_id])
REFERENCES [dbo].[company_data_provider] ([id])
GO
ALTER TABLE [dbo].[aggregated_pv_measurements] CHECK CONSTRAINT [FK_aggregated_pv_measurements_company_data_provider]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

        CREATE TRIGGER [dbo].[trg_UpdateTimestamp_AggregatedPVMeasurements]
        ON [dbo].[aggregated_pv_measurements]
        AFTER UPDATE
        AS
        BEGIN
            SET NOCOUNT ON;
            UPDATE dbo.aggregated_pv_measurements
            SET updated_at = SYSDATETIME()
            FROM inserted
            WHERE dbo.aggregated_pv_measurements.id = inserted.id;
        END;
GO
ALTER TABLE [dbo].[aggregated_pv_measurements] ENABLE TRIGGER [trg_UpdateTimestamp_AggregatedPVMeasurements]
GO
