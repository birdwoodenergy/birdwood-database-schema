SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bess_measurements](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[device_id] [int] NOT NULL,
	[created_at] [datetime2](3) NOT NULL,
	[updated_at] [datetime2](3) NULL,
	[charge_in_kw] [float] NOT NULL,
	[discharge_in_kw] [float] NOT NULL,
	[soc] [float] NOT NULL,
	[raw_charge_in_kw] [float] NULL,
	[raw_discharge_in_kw] [float] NULL,
	[raw_soc] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[bess_measurements] ADD  CONSTRAINT [PK_BESSMeasurements] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[bess_measurements] ADD  CONSTRAINT [UQ_BESSMeasurements_CreatedAt_DeviceId] UNIQUE NONCLUSTERED
(
	[created_at] ASC,
	[device_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_BESSMeasurements_CreatedAt_DeviceId] ON [dbo].[bess_measurements]
(
	[created_at] ASC,
	[device_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[bess_measurements] ADD  DEFAULT (sysdatetime()) FOR [updated_at]
GO
ALTER TABLE [dbo].[bess_measurements]  WITH CHECK ADD  CONSTRAINT [FK_bess_measurements_device] FOREIGN KEY([device_id])
REFERENCES [dbo].[device] ([id])
GO
ALTER TABLE [dbo].[bess_measurements] CHECK CONSTRAINT [FK_bess_measurements_device]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

        CREATE TRIGGER [dbo].[trg_UpdateTimestamp_BESSMeasurements]
        ON [dbo].[bess_measurements]
        AFTER UPDATE
        AS
        BEGIN
            SET NOCOUNT ON;
            UPDATE dbo.bess_measurements
            SET updated_at = SYSDATETIME()
            FROM inserted
            WHERE dbo.bess_measurements.id = inserted.id;
        END;
GO
ALTER TABLE [dbo].[bess_measurements] ENABLE TRIGGER [trg_UpdateTimestamp_BESSMeasurements]
GO
