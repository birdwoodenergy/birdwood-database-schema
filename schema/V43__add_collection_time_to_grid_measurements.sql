-- Add new columns collection_start_time and collection_end_time
ALTER TABLE [dbo].[grid_measurements]
    ADD collection_start_time [datetime2](3) NULL,
        collection_end_time [datetime2](3) NULL;

-- Drop UQ constraint UQ_GridMeasurements_CreatedAt_DeviceId
ALTER TABLE [dbo].[grid_measurements]
DROP CONSTRAINT [UQ_GridMeasurements_CreatedAt_DeviceId];

-- Add new UQ constraint based on createdAt, deviceId, collection_start_time, collection_end_time
ALTER TABLE [dbo].[grid_measurements]
ADD CONSTRAINT [UQ_GridMeasurements_CreatedAt_DeviceId_CollectionStartTime_CollectionEndTime]
UNIQUE NONCLUSTERED ([created_at], [device_id], [collection_start_time], [collection_end_time])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF,
IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY];
