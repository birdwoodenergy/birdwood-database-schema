ALTER TABLE [dbo].[grid_measurements]
ALTER COLUMN [raw_import_energy_in_kw] FLOAT (53) NULL;

ALTER TABLE [dbo].[grid_measurements]
ALTER COLUMN [raw_export_energy_in_kw] FLOAT (53) NULL;

ALTER TABLE [dbo].[grid_measurements]
ALTER COLUMN [import_energy_in_kw] FLOAT (53) NULL;

ALTER TABLE [dbo].[grid_measurements]
ALTER COLUMN [export_energy_in_kw] FLOAT (53) NULL;
