SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sub_load_measurements](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[device_id] [int] NOT NULL,
	[created_at] [datetime2](3) NOT NULL,
	[updated_at] [datetime2](3) NULL,
	[sub_load_in_kw] [float] NOT NULL,
	[raw_sub_load_in_kw] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[sub_load_measurements] ADD  CONSTRAINT [PK_SubLoadMeasurements] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[sub_load_measurements] ADD  CONSTRAINT [UQ_SubLoadMeasurements_CreatedAt_DeviceId] UNIQUE NONCLUSTERED
(
	[created_at] ASC,
	[device_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SubLoadMeasurements_CreatedAt_DeviceId] ON [dbo].[sub_load_measurements]
(
	[created_at] ASC,
	[device_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[sub_load_measurements] ADD  DEFAULT (sysdatetime()) FOR [updated_at]
GO
ALTER TABLE [dbo].[sub_load_measurements]  WITH CHECK ADD  CONSTRAINT [FK_sub_load_measurements_device] FOREIGN KEY([device_id])
REFERENCES [dbo].[device] ([id])
GO
ALTER TABLE [dbo].[sub_load_measurements] CHECK CONSTRAINT [FK_sub_load_measurements_device]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE TRIGGER [dbo].[trg_UpdateTimestamp_SubLoadMeasurements]
    ON [dbo].[sub_load_measurements]
    AFTER UPDATE
    AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE dbo.sub_load_measurements
        SET updated_at = SYSDATETIME()
        WHERE id IN (SELECT id FROM inserted);
    END;
GO
ALTER TABLE [dbo].[sub_load_measurements] ENABLE TRIGGER [trg_UpdateTimestamp_SubLoadMeasurements]
GO
