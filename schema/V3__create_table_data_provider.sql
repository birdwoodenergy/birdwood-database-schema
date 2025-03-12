SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[data_provider](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[created_at] [datetime2](3) NULL,
	[updated_at] [datetime2](3) NULL,
	[name] [varchar](50) NOT NULL,
	[contact_number] [varchar](20) NULL,
	[email_address] [varchar](30) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[data_provider] ADD  CONSTRAINT [PK_DataProvider] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[data_provider] ADD  CONSTRAINT [UQ_DataProvider_Name] UNIQUE NONCLUSTERED
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[data_provider] ADD  DEFAULT (sysdatetime()) FOR [created_at]
GO
ALTER TABLE [dbo].[data_provider] ADD  DEFAULT (sysdatetime()) FOR [updated_at]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create a trigger to update 'updated_at' column on each update
CREATE TRIGGER [dbo].[trg_UpdateTimestamp_DataProvider]
ON [dbo].[data_provider]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.data_provider
    SET updated_at = SYSDATETIME()
    FROM inserted
    WHERE dbo.data_provider.id = inserted.id;
END;
GO
ALTER TABLE [dbo].[data_provider] ENABLE TRIGGER [trg_UpdateTimestamp_DataProvider]
GO
