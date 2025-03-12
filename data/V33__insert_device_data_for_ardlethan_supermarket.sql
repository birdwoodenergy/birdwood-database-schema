-- INSERT devices for Ardlethan Supermarket
DECLARE @company_name NVARCHAR(50) = 'Ardlethan Supermarket';
DECLARE @company_id INT;
DECLARE @grid_company_data_provider_id INT;
DECLARE @pv_company_data_provider_id INT;
DECLARE @grid_settings NVARCHAR(MAX);
DECLARE @pv_settings NVARCHAR(MAX);

-- Retrieve company_id
SELECT @company_id = (SELECT id FROM dbo.company WHERE name = @company_name);

IF @company_id IS NULL
BEGIN
    PRINT 'Company ' + @company_name + ' does not exist. Insert operation aborted.';
    RETURN;
END

-- Retrieve company_data_provider_id
SELECT
  @grid_company_data_provider_id = (SELECT id FROM dbo.company_data_provider WHERE company_id = @company_id AND data_provider_type = 'GRID'),
  @pv_company_data_provider_id = (SELECT id FROM dbo.company_data_provider WHERE company_id = @company_id AND data_provider_type = 'PV');


IF @grid_company_data_provider_id IS NULL
BEGIN
  PRINT 'Company ' + @company_name + ' does not have a GRID company_data_provider entry.';
END
ELSE
BEGIN
  -- INSERT grid device
  SET @grid_settings = '{"gridGenerationChannels" : ["DD75335317102_C4", "DD75335317102_C5", "DD75335317102_C6"]}';
  INSERT INTO dbo.device (company_data_provider_id, type, endpoint, settings)
  VALUES (@grid_company_data_provider_id, 'GRID', 'DD75335317102', @grid_settings)
END;

IF @pv_company_data_provider_id IS NULL
BEGIN
  PRINT 'Company ' + @company_name + ' does not have a PV company_data_provider entry.';
END;
ELSE
BEGIN
  -- INSERT pv device
  SET @pv_settings = '{"solarGenerationChannels" : ["DD75335317102_C1", "DD75335317102_C2", "DD75335317102_C3"]}';
  INSERT INTO dbo.device (company_data_provider_id, type, endpoint, settings)
  VALUES (@pv_company_data_provider_id, 'PV', 'DD75335317102', @pv_settings)
END;
