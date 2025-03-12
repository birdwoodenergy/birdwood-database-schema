ALTER TABLE [dbo].[grid_measurements]
DROP CONSTRAINT [UQ_GridMeasurements_CreatedAt];

ALTER TABLE [dbo].[grid_measurements]
ADD CONSTRAINT [UQ_GridMeasurements_CreatedAt_DeviceId]
UNIQUE NONCLUSTERED ([created_at], [device_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF,
IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY];
