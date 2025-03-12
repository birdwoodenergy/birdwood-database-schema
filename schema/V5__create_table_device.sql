SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[device](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[company_data_provider_id] [int] NOT NULL,
	[created_at] [datetime2](3) NULL,
	[updated_at] [datetime2](3) NULL,
	[type] [varchar](50) NOT NULL,
	[serial_number] [varchar](255) NOT NULL,
	[endpoint] [varchar](100) NULL,
	[settings] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[device] ADD PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[device] ADD  CONSTRAINT [UQ_device_serial_number] UNIQUE NONCLUSTERED
(
	[serial_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[device] ADD  CONSTRAINT [DEFAULT_device_created_at]  DEFAULT (sysdatetime()) FOR [created_at]
GO
ALTER TABLE [dbo].[device] ADD  CONSTRAINT [DEFAULT_device_updated_at]  DEFAULT (sysdatetime()) FOR [updated_at]
GO
ALTER TABLE [dbo].[device]  WITH CHECK ADD  CONSTRAINT [FK_device_company_data_provider] FOREIGN KEY([company_data_provider_id])
REFERENCES [dbo].[company_data_provider] ([id])
GO
ALTER TABLE [dbo].[device] CHECK CONSTRAINT [FK_device_company_data_provider]
GO
ALTER TABLE [dbo].[device]  WITH CHECK ADD  CONSTRAINT [CHK_device_settings_IsJSON] CHECK  ((isjson([settings])=(1)))
GO
ALTER TABLE [dbo].[device] CHECK CONSTRAINT [CHK_device_settings_IsJSON]
GO
ALTER TABLE [dbo].[device]  WITH CHECK ADD  CONSTRAINT [CHK_device_type] CHECK  (([type]='SUBLOAD' OR [type]='BESS' OR [type]='PV' OR [type]='GRID'))
GO
ALTER TABLE [dbo].[device] CHECK CONSTRAINT [CHK_device_type]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create a trigger to update 'updated_at' column on each update
CREATE TRIGGER [dbo].[trg_UpdateTimestamp_Device]
ON [dbo].[device]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.device
    SET updated_at = SYSDATETIME()
    FROM inserted
    WHERE dbo.device.id = inserted.id;
END;
GO
ALTER TABLE [dbo].[device] ENABLE TRIGGER [trg_UpdateTimestamp_Device]
GO
