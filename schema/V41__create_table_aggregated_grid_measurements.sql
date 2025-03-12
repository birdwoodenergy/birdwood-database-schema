SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aggregated_grid_measurements](
    [id] [int] IDENTITY(1,1) NOT NULL,
    [company_id] [int] NOT NULL,
    [created_at] [datetime2](3) NOT NULL,
    [updated_at] [datetime2](3) NULL,
    [total_import_energy_in_kw] [float] NULL,
    [total_export_energy_in_kw] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aggregated_grid_measurements] ADD CONSTRAINT [PK_AggregatedGRIDMeasurements] PRIMARY KEY CLUSTERED
(
    [id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aggregated_grid_measurements] ADD CONSTRAINT [UQ_aggregated_grid_measurements_created_at_company] UNIQUE NONCLUSTERED
(
    [created_at] ASC,
    [company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_AggregatedGRIDMeasurements_CreatedAt] ON [dbo].[aggregated_grid_measurements]
(
    [created_at] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[aggregated_grid_measurements] ADD DEFAULT (sysdatetime()) FOR [updated_at]
GO
ALTER TABLE [dbo].[aggregated_grid_measurements] WITH CHECK ADD CONSTRAINT [FK_aggregated_grid_measurements_company] FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[aggregated_grid_measurements] CHECK CONSTRAINT [FK_aggregated_grid_measurements_company]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    CREATE TRIGGER [dbo].[trg_UpdateTimestamp_AggregatedGRIDMeasurements]
    ON [dbo].[aggregated_grid_measurements]
    AFTER UPDATE
    AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE dbo.aggregated_grid_measurements
        SET updated_at = SYSDATETIME()
        FROM inserted
        WHERE dbo.aggregated_grid_measurements.id = inserted.id;
    END;
GO
ALTER TABLE [dbo].[aggregated_grid_measurements] ENABLE TRIGGER [trg_UpdateTimestamp_AggregatedGRIDMeasurements]
GO
