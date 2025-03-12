SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[network_time_period](
    [id] [int] IDENTITY(1,1) NOT NULL,
    [charge_type] [varchar](50) NULL,
    [date_type] [varchar](50) NOT NULL,
    [start_time] [time](7) NOT NULL,
    [end_time] [time](7) NOT NULL,
    [network_time_period_rate_id] [int] NOT NULL,
    [created_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME()),
    [updated_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME())
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[network_time_period]
    ADD CONSTRAINT [PK_network_time_period_rate] PRIMARY KEY CLUSTERED ([id] ASC)
    WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

ALTER TABLE [dbo].[network_time_period]
    ADD CONSTRAINT [FK_network_time_period_network_time_period_rate] FOREIGN KEY([network_time_period_rate_id])
    REFERENCES [dbo].[network_time_period_rate] ([id])
GO
ALTER TABLE [dbo].[network_time_period]
ADD CONSTRAINT [UQ_network_time_period_rate_date_charge] UNIQUE ([network_time_period_rate_id], [date_type], [charge_type], [start_time], [end_time]);
GO
