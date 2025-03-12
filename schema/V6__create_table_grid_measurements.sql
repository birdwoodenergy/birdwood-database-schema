SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[grid_measurements](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[device_id] [int] NOT NULL,
	[created_at] [datetime2](3) NOT NULL,
	[updated_at] [datetime2](3) NULL,
	[import_energy_in_kw] [float] NOT NULL,
	[export_energy_in_kw] [float] NOT NULL,
	[raw_import_energy_in_kw] [float] NULL,
	[raw_export_energy_in_kw] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[grid_measurements] ADD  CONSTRAINT [PK_GridMeasurements] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[grid_measurements] ADD  CONSTRAINT [UQ_GridMeasurements_CreatedAt] UNIQUE NONCLUSTERED
(
	[created_at] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_GridMeasurements_CreatedAt] ON [dbo].[grid_measurements]
(
	[created_at] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[grid_measurements] ADD  DEFAULT (sysdatetime()) FOR [updated_at]
GO
ALTER TABLE [dbo].[grid_measurements]  WITH CHECK ADD  CONSTRAINT [FK_grid_measurements_device] FOREIGN KEY([device_id])
REFERENCES [dbo].[device] ([id])
GO
ALTER TABLE [dbo].[grid_measurements] CHECK CONSTRAINT [FK_grid_measurements_device]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE TRIGGER [dbo].[trg_UpdateTimestamp_GridMeasurements]
    ON [dbo].[grid_measurements]
    AFTER UPDATE
    AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE dbo.grid_measurements
        SET updated_at = SYSDATETIME()
        WHERE id IN (SELECT id FROM inserted);
    END;
GO
ALTER TABLE [dbo].[grid_measurements] ENABLE TRIGGER [trg_UpdateTimestamp_GridMeasurements]
GO
