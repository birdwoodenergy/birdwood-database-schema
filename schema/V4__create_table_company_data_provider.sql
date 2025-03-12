SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company_data_provider](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NOT NULL,
	[data_provider_id] [int] NOT NULL,
	[created_at] [datetime2](3) NULL,
	[updated_at] [datetime2](3) NULL,
	[data_provider_type] [varchar](50) NOT NULL,
	[site_id] [nvarchar](255) NULL,
	[settings] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[company_data_provider] ADD  CONSTRAINT [PK_company_data_provider] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[company_data_provider] ADD  CONSTRAINT [UQ_company_id_site_id_pair] UNIQUE NONCLUSTERED
(
	[site_id] ASC,
	[company_id] ASC,
	[data_provider_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IDX_site_id] ON [dbo].[company_data_provider]
(
	[site_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_CompanyDataProvider_CompanyId] ON [dbo].[company_data_provider]
(
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_CompanyDataProvider_DataProviderId] ON [dbo].[company_data_provider]
(
	[data_provider_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[company_data_provider] ADD  DEFAULT (sysdatetime()) FOR [created_at]
GO
ALTER TABLE [dbo].[company_data_provider] ADD  DEFAULT (sysdatetime()) FOR [updated_at]
GO
ALTER TABLE [dbo].[company_data_provider]  WITH CHECK ADD  CONSTRAINT [FK_company_data_provider_company] FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[company_data_provider] CHECK CONSTRAINT [FK_company_data_provider_company]
GO
ALTER TABLE [dbo].[company_data_provider]  WITH CHECK ADD  CONSTRAINT [FK_company_data_provider_data_provider] FOREIGN KEY([data_provider_id])
REFERENCES [dbo].[data_provider] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[company_data_provider] CHECK CONSTRAINT [FK_company_data_provider_data_provider]
GO
ALTER TABLE [dbo].[company_data_provider]  WITH CHECK ADD  CONSTRAINT [CHK_company_data_provider_data_provider_type] CHECK  (([data_provider_type]='SUBLOAD' OR [data_provider_type]='BESS' OR [data_provider_type]='PV' OR [data_provider_type]='GRID'))
GO
ALTER TABLE [dbo].[company_data_provider] CHECK CONSTRAINT [CHK_company_data_provider_data_provider_type]
GO
ALTER TABLE [dbo].[company_data_provider]  WITH CHECK ADD  CONSTRAINT [CHK_company_data_provider_settings_IsJSON] CHECK  ((isjson([settings])=(1)))
GO
ALTER TABLE [dbo].[company_data_provider] CHECK CONSTRAINT [CHK_company_data_provider_settings_IsJSON]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create a trigger to avoid different companies from using the same site_id
CREATE TRIGGER [dbo].[trg_check_unique_site_id_per_company]
ON [dbo].[company_data_provider]
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @company_id INT, @site_id NVARCHAR(255);

    -- Retrieve the values being inserted or updated
    SELECT @company_id = company_id, @site_id = site_id
    FROM inserted;

    -- Check if the site_id is already associated with a different company_id
    IF EXISTS (
        SELECT 1
        FROM [dbo].[company_data_provider] AS existing_entries
        WHERE existing_entries.site_id = @site_id
        AND existing_entries.company_id != @company_id
    )
    BEGIN
        -- If the site_id is used by another company, raise an error
        RAISERROR ('The site_id is already associated with a different company.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

GO
ALTER TABLE [dbo].[company_data_provider] ENABLE TRIGGER [trg_check_unique_site_id_per_company]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create a trigger to update 'updated_at' column on each update
CREATE TRIGGER [dbo].[trg_UpdateTimestamp_CompanyDataProvider]
ON [dbo].[company_data_provider]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.company_data_provider
    SET updated_at = SYSDATETIME()
    FROM inserted
    WHERE dbo.company_data_provider.id = inserted.id;
END;
GO
ALTER TABLE [dbo].[company_data_provider] ENABLE TRIGGER [trg_UpdateTimestamp_CompanyDataProvider]
GO
