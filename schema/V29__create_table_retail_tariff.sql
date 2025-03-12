SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[retail_tariff](
    [id] [int] IDENTITY(1,1) NOT NULL,
    [tariff_name] [varchar](50) NOT NULL,
    [description] [varchar](50) NULL,
    [start_date] [date] NOT NULL,
    [end_date] [date] NOT NULL,
    [retailer_id] [int] NOT NULL,
    [retail_time_period_rate_id] [int] NOT NULL,
    [created_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME()),
    [updated_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME())
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[retail_tariff]
    ADD CONSTRAINT [PK_retail_tariff] PRIMARY KEY CLUSTERED ([id] ASC)
    WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

ALTER TABLE [dbo].[retail_tariff]
    WITH CHECK ADD CONSTRAINT [FK_retail_tariff_retail_time_period_rate]
    FOREIGN KEY([retail_time_period_rate_id])
    REFERENCES [dbo].[retail_time_period_rate] ([id])
GO

ALTER TABLE [dbo].[retail_tariff]
    CHECK CONSTRAINT [FK_retail_tariff_retail_time_period_rate]
GO

ALTER TABLE [dbo].[retail_tariff]
    WITH CHECK ADD CONSTRAINT [FK_retail_tariff_retailer]
    FOREIGN KEY([retailer_id])
    REFERENCES [dbo].[retailer] ([id])
GO

ALTER TABLE [dbo].[retail_tariff]
    CHECK CONSTRAINT [FK_retail_tariff_retailer]
GO
ALTER TABLE [dbo].[retail_tariff]
ADD CONSTRAINT [UQ_retail_tariff_name] UNIQUE ([tariff_name]);
GO
ALTER TABLE [dbo].[retail_tariff]
ADD CONSTRAINT CHK_retail_tariff_start_date_lt_end_date CHECK ([start_date] < [end_date]);
GO
