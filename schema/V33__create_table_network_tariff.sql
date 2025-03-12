SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[network_tariff](
    [id] [int] IDENTITY(1,1) NOT NULL,
    [network_charge_code] [varchar](50) NOT NULL,
    [description] [varchar](50) NULL,
    [start_date] [date] NOT NULL,
    [end_date] [date] NOT NULL,
    [network_provider_id] [int] NOT NULL,
    [network_time_period_rate_id] [int] NOT NULL,
    [created_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME()),
    [updated_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME())
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[network_tariff]
    ADD CONSTRAINT [PK_network_tariff] PRIMARY KEY CLUSTERED ([id] ASC)
    WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

ALTER TABLE [dbo].[network_tariff]
    ADD CONSTRAINT [FK_network_tariff_network_provider] FOREIGN KEY([network_provider_id])
    REFERENCES [dbo].[network_provider] ([id])
GO

ALTER TABLE [dbo].[network_tariff]
    ADD CONSTRAINT [FK_network_tariff_network_time_period_rate] FOREIGN KEY([network_time_period_rate_id])
    REFERENCES [dbo].[network_time_period_rate] ([id])
GO
ALTER TABLE [dbo].[network_tariff]
ADD CONSTRAINT [UQ_network_tariff_name] UNIQUE ([network_charge_code]);
GO
ALTER TABLE [dbo].[network_tariff]
ADD CONSTRAINT CHK_network_tariff_start_date_lt_end_date CHECK ([start_date] < [end_date]);
GO
