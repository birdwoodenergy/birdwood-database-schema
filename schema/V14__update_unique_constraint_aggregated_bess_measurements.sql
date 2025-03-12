ALTER TABLE [dbo].[aggregated_bess_measurements]
DROP CONSTRAINT [UQ_AggregatedBESSMeasurements_CreatedAt];

ALTER TABLE [dbo].[aggregated_bess_measurements]
ADD CONSTRAINT [UQ_AggregatedBESSMeasurements_CreatedAt_CompanyDataProvider] UNIQUE NONCLUSTERED
(
    [created_at] ASC,
    [company_data_provider_id] ASC
);
