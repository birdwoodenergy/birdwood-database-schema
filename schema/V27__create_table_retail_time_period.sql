SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[retail_time_period](
    [id] [int] IDENTITY(1,1) NOT NULL,
    [date_type] [varchar](50) NOT NULL,
    [charge_type] [varchar](50) NOT NULL,
    [start_time] [time](7) NOT NULL,
    [end_time] [time](7) NOT NULL,
    [start_date] [date] NOT NULL,
    [end_date] [date] NOT NULL,
    [retail_time_period_rate_id] [int] NOT NULL,
    [created_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME()),
    [updated_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[retail_time_period] ADD CONSTRAINT [PK_retail_time_period] PRIMARY KEY CLUSTERED
(
    [id] ASC
) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[retail_time_period]  WITH CHECK ADD  CONSTRAINT [FK_retail_time_period_retail_time_period_rate] FOREIGN KEY([retail_time_period_rate_id])
REFERENCES [dbo].[retail_time_period_rate] ([id])
GO
ALTER TABLE [dbo].[retail_time_period] CHECK CONSTRAINT [FK_retail_time_period_retail_time_period_rate]
GO
ALTER TABLE [dbo].[retail_time_period]
ADD CONSTRAINT [UQ_retail_time_period_rate_date_charge] UNIQUE ([retail_time_period_rate_id], [date_type], [charge_type]);
GO
ALTER TABLE [dbo].[retail_time_period]
    ADD CONSTRAINT [CHK_retail_time_period_start_date_lt_end_date] CHECK (
        [start_date] < [end_date]
    );
GO
