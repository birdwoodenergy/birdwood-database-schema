ALTER TABLE [dbo].[aggregated_sub_load_measurements]
DROP CONSTRAINT [UQ_AggregatedSUBLOADMeasurements_CreatedAt];

ALTER TABLE [dbo].[aggregated_sub_load_measurements]
ADD CONSTRAINT [UQ_AggregatedSUBLOADMeasurements_CreatedAt_CompanyDataProvider] UNIQUE NONCLUSTERED
(
    [created_at] ASC,
    [company_data_provider_id] ASC
);
