-- INSERT company_data_provider for Ardlethan Supermarket
DECLARE @company_name NVARCHAR(50);
DECLARE @company_id INT;
DECLARE @grid_data_provider_name NVARCHAR(50);
DECLARE @grid_data_provider_id INT;
DECLARE @pv_data_provider_name NVARCHAR(50);
DECLARE @pv_data_provider_id INT;
DECLARE @grid_company_data_provider_settings NVARCHAR(MAX);
DECLARE @pv_company_data_provider_settings NVARCHAR(MAX);

SET @company_name = 'Ardlethan Supermarket';
SET @grid_data_provider_name = 'Wattwatchers';
SET @pv_data_provider_name = 'Wattwatchers';

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

IF @company_id IS NOT NULL AND @grid_data_provider_id IS NOT NULL AND @pv_data_provider_id IS NOT NULL
BEGIN
    -- Insert Grid Data Provider
    INSERT INTO dbo.company_data_provider (company_id, data_provider_id, data_provider_type)
    VALUES (@company_id, @grid_data_provider_id, 'GRID');

    -- Insert PV Data Provider
    INSERT INTO dbo.company_data_provider (company_id, data_provider_id, data_provider_type)
    VALUES (@company_id, @pv_data_provider_id, 'PV');
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
END;
