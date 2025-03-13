SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[regulatory_environmental_rate](
	[id] INT NOT NULL PRIMARY KEY,
    [state] [varchar](50) NOT NULL,
	[type] [varchar](50) NOT NULL,
	[rate] [float] NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[created_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME()),
    [updated_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[regulatory_environmental_rate]  WITH CHECK ADD CONSTRAINT [CHK_re_type_values] CHECK ([type] IN ('regulatory', 'environmental'));
GO
ALTER TABLE [dbo].[regulatory_environmental_rate] CHECK CONSTRAINT [CHK_re_type_values]
GO
ALTER TABLE [dbo].[regulatory_environmental_rate]
ADD CONSTRAINT CHK_regulatory_environmental_rate_start_date_lt_end_date CHECK ([start_date] < [end_date]);
GO
