-- Drop the FK_aggregated_sub_load_measurements_company_data_provider
ALTER TABLE dbo.aggregated_sub_load_measurements
DROP FK_aggregated_sub_load_measurements_company_data_provider;

-- Drop the constraint UQ_AggregatedSUBLOADMeasurements_CreatedAt_CompanyDataProvider
ALTER TABLE dbo.aggregated_sub_load_measurements
DROP CONSTRAINT UQ_AggregatedSUBLOADMeasurements_CreatedAt_CompanyDataProvider;

-- Drop the company_data_provider_id column
ALTER TABLE dbo.aggregated_sub_load_measurements
DROP COLUMN company_data_provider_id;

-- Add new column company_id
ALTER TABLE dbo.aggregated_sub_load_measurements
ADD company_id INT NOT NULL;

-- Create the new foreign key constraint for company_id
ALTER TABLE [dbo].[aggregated_sub_load_measurements]
WITH CHECK ADD CONSTRAINT [FK_aggregated_sub_load_measurements_company]
FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([id])
ON DELETE CASCADE;

-- Add Unique contraint that each combination of `created_at` and `company_id` is unique,
-- preventing duplicate aggregated measurements for the same company at a given timestamp
ALTER TABLE [dbo].[aggregated_sub_load_measurements]
ADD CONSTRAINT [UQ_AggregatedSUBLOADMeasurements_CreatedAt_Company] UNIQUE NONCLUSTERED
(
    [created_at] ASC,
    [company_id] ASC
);
