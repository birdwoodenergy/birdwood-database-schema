-- INSERT company_data_provider for BE8001_MCC_Junior
DECLARE @company_name NVARCHAR(50);
DECLARE @company_id INT;
DECLARE @grid_data_provider_name NVARCHAR(50);
DECLARE @grid_data_provider_id INT;
DECLARE @pv_data_provider_name NVARCHAR(50);
DECLARE @pv_data_provider_id INT;
DECLARE @bess_data_provider_name NVARCHAR(50);
DECLARE @bess_data_provider_id INT;
DECLARE @grid_company_data_provider_settings NVARCHAR(MAX);
DECLARE @pv_company_data_provider_settings NVARCHAR(MAX);

SET @company_name = 'BE8001_MCC_Junior';
SET @grid_data_provider_name = 'DNA1';
SET @pv_data_provider_name = 'DNA1';
SET @bess_data_provider_name = 'DNA1';

-- Fetch the company and data provider ids
SELECT @company_id = id
FROM dbo.company
WHERE name = @company_name;

SELECT @grid_data_provider_id = id
FROM dbo.data_provider
WHERE name = @grid_data_provider_name;

SELECT @pv_data_provider_id = id
FROM dbo.data_provider
WHERE name = @pv_data_provider_name;

SELECT @bess_data_provider_id = id
FROM dbo.data_provider
WHERE name = @bess_data_provider_name;

IF @company_id IS NOT NULL AND @grid_data_provider_id IS NOT NULL AND @pv_data_provider_id IS NOT NULL AND @bess_data_provider_id IS NOT NULL
BEGIN
    -- Insert Grid Data Provider
    SET @grid_company_data_provider_settings = '{"grid_threshold_in_kw": 1000, "grid_capacity_in_kw": 280}';
    INSERT INTO dbo.company_data_provider (company_id, data_provider_id, data_provider_type, site_id, settings)
    VALUES (@company_id, @grid_data_provider_id, 'GRID', '6567e5034c173061e92c794b', @grid_company_data_provider_settings);

    -- Insert PV Data Provider
    SET @pv_company_data_provider_settings = '{"pv_capacity_in_kw": 280}';
    INSERT INTO dbo.company_data_provider (company_id, data_provider_id, data_provider_type, site_id, settings)
    VALUES (@company_id, @pv_data_provider_id, 'PV', '6567e5034c173061e92c794b', @pv_company_data_provider_settings);

    -- Insert BESS Data Provider
    -- double check site_id for bess if correct!
    INSERT INTO dbo.company_data_provider (company_id, data_provider_id, data_provider_type, site_id)
    VALUES (@company_id, @bess_data_provider_id, 'BESS', '6567e5034c173061e92c794b');
END
ELSE
BEGIN
  IF @company_id IS NULL
  BEGIN
    PRINT 'Company ' + @company_name + ' does not exist. Insert operation aborted.'
    RETURN;
  END;

  IF @grid_data_provider_id IS NULL
  BEGIN
    PRINT 'Grid Data Provider ' + @grid_data_provider_name + ' does not exist. Insert operation aborted.'
    RETURN;
  END;

  IF @pv_data_provider_id IS NULL
  BEGIN
    PRINT 'PV Data Provider ' + @pv_data_provider_name + ' does not exist. Insert operation aborted.'
    RETURN;
  END;

  IF @bess_data_provider_id IS NULL
  BEGIN
    PRINT 'BESS Data Provider ' + @bess_data_provider_name + ' does not exist. Insert operation aborted.'
    RETURN;
  END;
END;
