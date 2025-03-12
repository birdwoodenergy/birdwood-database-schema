SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[energy_flow](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NOT NULL,
	[created_at] [datetime2](3) NOT NULL,
	[updated_at] [datetime2](3) NULL,
	[load_in_kw] [float] NOT NULL,
	[excess_pv_in_kw] [float] NOT NULL,
	[pv_generation_in_kw] [float] NOT NULL,
	[pv_to_load_in_kw] [float] NOT NULL,
	[average_power_factor] [float] NOT NULL,
	[export_capacity_in_kw] [float] NOT NULL,
	[curtailed_pv_in_kw] [float] NOT NULL,
	[exported_pv_in_kw] [float] NOT NULL,
	[bess_charge_discharge_in_kw] [float] NOT NULL,
	[bess_charge_from_curtailed_pv_in_kw] [float] NOT NULL,
	[bess_charge_from_excess_pv_in_kw] [float] NOT NULL,
	[bess_charge_from_grid_in_kw] [float] NOT NULL,
	[bess_discharge_to_load_in_kw] [float] NOT NULL,
	[bess_discharge_to_grid_in_kw] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[energy_flow] ADD  CONSTRAINT [PK_EnergyFlow] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[energy_flow] ADD  CONSTRAINT [UQ_EnergyFlow_CreatedAt] UNIQUE NONCLUSTERED
(
	[created_at] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_EnergyFlow_CreatedAt] ON [dbo].[energy_flow]
(
	[created_at] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[energy_flow] ADD  DEFAULT (sysdatetime()) FOR [updated_at]
GO
ALTER TABLE [dbo].[energy_flow]  WITH CHECK ADD  CONSTRAINT [FK_energy_flow_company] FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([id])
GO
ALTER TABLE [dbo].[energy_flow] CHECK CONSTRAINT [FK_energy_flow_company]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
        CREATE TRIGGER [dbo].[trg_UpdateTimestamp_EnergyFlow]
        ON [dbo].[energy_flow]
        AFTER UPDATE
        AS
        BEGIN
            SET NOCOUNT ON;
            UPDATE dbo.energy_flow
            SET updated_at = SYSDATETIME()
            FROM inserted
            WHERE dbo.energy_flow.id = inserted.id;
        END;
GO
ALTER TABLE [dbo].[energy_flow] ENABLE TRIGGER [trg_UpdateTimestamp_EnergyFlow]
GO
