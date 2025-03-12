SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create unique constraint based on the combination of device columns company_data_provider_id, type, and endpoint
ALTER TABLE [dbo].[device]
ADD CONSTRAINT UQ_device_company_type_endpoint
UNIQUE (company_data_provider_id, type, endpoint);
