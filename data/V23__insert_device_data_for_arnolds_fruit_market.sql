-- INSERT devices for BE116_Arnolds_Fruit_Market
DECLARE @company_name NVARCHAR(50) = 'BE116_Arnolds_Fruit_Market';
DECLARE @company_id INT;
DECLARE @grid_company_data_provider_id INT;
DECLARE @pv_company_data_provider_id INT;
DECLARE @bess_company_data_provider_id INT;
DECLARE @sub_load_company_data_provider_id INT;
DECLARE @grid_settings NVARCHAR(MAX);
DECLARE @pv_settings NVARCHAR(MAX);
DECLARE @bess_settings NVARCHAR(MAX);

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
  @pv_company_data_provider_id = (SELECT id FROM dbo.company_data_provider WHERE company_id = @company_id AND data_provider_type = 'PV'),
  @bess_company_data_provider_id = (SELECT id FROM dbo.company_data_provider WHERE company_id = @company_id AND data_provider_type = 'BESS'),
  @sub_load_company_data_provider_id = (SELECT id FROM dbo.company_data_provider WHERE company_id = @company_id AND data_provider_type = 'SUBLOAD');


IF @grid_company_data_provider_id IS NULL
BEGIN
  PRINT 'Company ' + @company_name + ' does not have a GRID company_data_provider entry.';
END
ELSE
BEGIN
  -- INSERT grid device
  SET @grid_settings = '{"grid_key": "GRID.PowerkW"}';
  INSERT INTO dbo.device (company_data_provider_id, type, serial_number, endpoint, settings)
  VALUES (@grid_company_data_provider_id, 'GRID', 'grid_9', '0000028001110000', @grid_settings)
END;

IF @pv_company_data_provider_id IS NULL
BEGIN
  PRINT 'Company ' + @company_name + ' does not have a PV company_data_provider entry.';
END;
ELSE
BEGIN
  -- INSERT pv device
  SET @pv_settings = '{"pv_key": "GRID.PowerkW"}';
  INSERT INTO dbo.device (company_data_provider_id, type, serial_number, endpoint, settings)
  VALUES (@pv_company_data_provider_id, 'PV', 'pv_9', '000002e001110000', @pv_settings)
END;

IF @bess_company_data_provider_id IS NULL
BEGIN
  PRINT 'Company ' + @company_name + ' does not have a BESS company_data_provider entry.';
END;
ELSE
BEGIN
  -- INSERT bess device
  SET @bess_settings = '{"charge_key": "STR.PowerkW", "soc_key": "STR.SOC"}';
  INSERT INTO dbo.device (company_data_provider_id, type, serial_number, endpoint, settings)
  VALUES (@bess_company_data_provider_id, 'BESS', 'bess_5', '0000028101110000', @bess_settings)
END;

IF @sub_load_company_data_provider_id IS NULL
BEGIN
  PRINT 'Company ' + @company_name + ' does not have a SUBLOAD company_data_provider entry.';
END;
