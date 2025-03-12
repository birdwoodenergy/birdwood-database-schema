SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ppa_contract](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NOT NULL,
	[type] [varchar](50) NULL,
	[import_rate] [float] NULL,
	[export_rate] [float] NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[created_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME()),
    [updated_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME()),
    [is_active] [bit] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ppa_contract] ADD  CONSTRAINT [PK_ppa_contract] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ppa_contract]  WITH CHECK ADD  CONSTRAINT [FK_ppa_contract_company] FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([id])
GO
ALTER TABLE [dbo].[ppa_contract] CHECK CONSTRAINT [FK_ppa_contract_company]
GO
ALTER TABLE [dbo].[ppa_contract]  WITH CHECK ADD CONSTRAINT [CHK_type_values] CHECK ([type] IN ('lease', 'consumption', 'generation'));
GO
ALTER TABLE [dbo].[ppa_contract] CHECK CONSTRAINT [CHK_type_values]
GO
CREATE UNIQUE INDEX [UQ_ppa_contract_company_active]
ON [dbo].[ppa_contract] ([company_id])
WHERE [is_active] = 1;
GO
ALTER TABLE [dbo].[ppa_contract]
ADD CONSTRAINT CHK_ppa_contract_start_date_lt_end_date CHECK ([start_date] < [end_date]);
GO
