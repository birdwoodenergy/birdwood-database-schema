ALTER TABLE [dbo].[pv_measurements]
ALTER COLUMN [raw_pv_in_kw] FLOAT (53) NULL;

ALTER TABLE [dbo].[pv_measurements]
ALTER COLUMN [pv_in_kw] FLOAT (53) NULL;
