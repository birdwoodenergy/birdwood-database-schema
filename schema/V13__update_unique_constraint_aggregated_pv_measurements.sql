ALTER TABLE [dbo].[aggregated_pv_measurements]
DROP CONSTRAINT [UQ_AggregatedPVMeasurements_CreatedAt];

ALTER TABLE [dbo].[aggregated_pv_measurements]
ADD CONSTRAINT [UQ_AggregatedPVMeasurements_CreatedAt_CompanyDataProvider] UNIQUE NONCLUSTERED
(
    [created_at] ASC,
    [company_data_provider_id] ASC
);
