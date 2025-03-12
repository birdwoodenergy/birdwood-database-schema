-- Add new columns collection_start_time and collection_end_time
ALTER TABLE [dbo].[aggregated_grid_measurements]
    ADD collection_start_time [datetime2](3) NULL,
        collection_end_time [datetime2](3) NULL;

-- Drop UQ constraint UQ_aggregated_grid_measurements_created_at_company
ALTER TABLE [dbo].[aggregated_grid_measurements]
DROP CONSTRAINT [UQ_aggregated_grid_measurements_created_at_company];

-- Add new UQ constraint based on createdAt, company, collection_start_time, collection_end_time
ALTER TABLE [dbo].[aggregated_grid_measurements]
ADD CONSTRAINT [UQ_AggregatedGridMeasurements_CreatedAt_Company_CollectionStartTime_CollectionEndTime]
UNIQUE NONCLUSTERED ([created_at], [company_id], [collection_start_time], [collection_end_time])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF,
IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY];
