SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ppa_contract_history](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[ppa_contract_id] [int] NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[created_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME()),
    [updated_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ppa_contract_history] ADD  CONSTRAINT [PK_ppa_contract_history] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ppa_contract_history]  WITH CHECK ADD  CONSTRAINT [FK_ppa_contract_history_company] FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([id])
GO
ALTER TABLE [dbo].[ppa_contract_history] CHECK CONSTRAINT [FK_ppa_contract_history_company]
GO
ALTER TABLE [dbo].[ppa_contract_history]  WITH CHECK ADD  CONSTRAINT [FK_ppa_contract_history_ppa_contract] FOREIGN KEY([ppa_contract_id])
REFERENCES [dbo].[ppa_contract] ([id])
GO
ALTER TABLE [dbo].[ppa_contract_history] CHECK CONSTRAINT [FK_ppa_contract_history_ppa_contract]
GO
