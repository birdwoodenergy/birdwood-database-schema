-- Drop the constraint created_at
ALTER TABLE dbo.energy_flow
DROP CONSTRAINT UQ_EnergyFlow_CreatedAt;

-- Add Unique constraint that each combination of `created_at` and `company_id` is unique,
-- preventing duplicate energy flow row for the same company at a given timestamp
ALTER TABLE [dbo].[energy_flow]
ADD CONSTRAINT [UQ_EnergyFlow_CreatedAt_Company] UNIQUE NONCLUSTERED
(
    [created_at] ASC,
    [company_id] ASC
);
