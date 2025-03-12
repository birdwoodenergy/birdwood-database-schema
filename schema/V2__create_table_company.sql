SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[created_at] [datetime2](3) NULL,
	[updated_at] [datetime2](3) NULL,
	[name] [varchar](50) NOT NULL,
	[address] [varchar](150) NOT NULL,
	[timezone] [varchar](30) NOT NULL,
	[latitude] [float] NOT NULL,
	[longitude] [float] NOT NULL,
	[contact_number] [varchar](20) NULL,
	[email_address] [varchar](30) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[company] ADD  CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[company] ADD  CONSTRAINT [UQ_Company_Name] UNIQUE NONCLUSTERED
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[company] ADD  DEFAULT (sysdatetime()) FOR [created_at]
GO
ALTER TABLE [dbo].[company] ADD  DEFAULT (sysdatetime()) FOR [updated_at]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[trg_UpdateTimestamp]
ON [dbo].[company]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.company
    SET updated_at = SYSDATETIME()
    FROM inserted
    WHERE dbo.company.id = inserted.id;
END;
GO
ALTER TABLE [dbo].[company] ENABLE TRIGGER [trg_UpdateTimestamp]
GO
