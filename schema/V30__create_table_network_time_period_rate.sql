SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[network_time_period_rate](
    [id] [int] IDENTITY(1,1) NOT NULL,
    [name] [varchar](50) NOT NULL,
    [description] [varchar](50) NULL,
    [all_rate] [float] NULL,
    [peak_rate] [float] NULL,
    [shoulder_rate] [float] NULL,
    [off_peak_rate] [float] NULL,
    [sun_saver_rate] [float] NULL,
    [created_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME()),
    [updated_at] [datetime2](7) NOT NULL DEFAULT (SYSDATETIME())
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[network_time_period_rate]
    ADD CONSTRAINT [PK_network_time_period] PRIMARY KEY CLUSTERED ([id] ASC)
    WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[network_time_period_rate]
ADD CONSTRAINT [UQ_network_time_period_rate_name] UNIQUE ([name]);
GO
