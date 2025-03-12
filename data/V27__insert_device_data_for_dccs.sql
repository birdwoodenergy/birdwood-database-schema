-- INSERT devices for DCCS
DECLARE @company_name NVARCHAR(50) = 'DCCS';
DECLARE @company_id INT;
DECLARE @grid_company_data_provider_id INT;
DECLARE @pv_company_data_provider_id INT;
DECLARE @bess_company_data_provider_id INT;
DECLARE @sub_load_company_data_provider_id INT;
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
  INSERT INTO dbo.device (company_data_provider_id, type, serial_number, endpoint)
  VALUES (@grid_company_data_provider_id, 'GRID', 'grid_13', 'PL6Y3CMKM9')
END;

IF @pv_company_data_provider_id IS NULL
BEGIN
  PRINT 'Company ' + @company_name + ' does not have a PV company_data_provider entry.';
END;
ELSE
BEGIN
  -- INSERT pv device
  -- For Enphase, see if we could move api_key, client_id, and client_secret to company_data_provider.settings
  SET @pv_settings = '{"api_key": "d6ba8338c106bb86435a166cbda42c31", "client_id": "3953a9e8ce4a5518f9fce6586b53d2dc", "client_secret": "461872b3d95d4716867e58ae70380207"}';
  INSERT INTO dbo.device (company_data_provider_id, type, serial_number, endpoint, settings)
  VALUES (@pv_company_data_provider_id, 'PV', 'pv_25', '4095732', @pv_settings)
END;

IF @bess_company_data_provider_id IS NULL
BEGIN
  PRINT 'Company ' + @company_name + ' does not have a BESS company_data_provider entry.';
END;

IF @sub_load_company_data_provider_id IS NULL
BEGIN
  PRINT 'Company ' + @company_name + ' does not have a SUBLOAD company_data_provider entry.';
END;
ELSE
BEGIN
  -- INSERT sub_load device
  INSERT INTO dbo.device (company_data_provider_id, type, serial_number, endpoint)
  VALUES (@sub_load_company_data_provider_id, 'SUBLOAD', 'sub_load_2', 'JXTZH7WAZ6')

  INSERT INTO dbo.device (company_data_provider_id, type, serial_number, endpoint)
  VALUES (@sub_load_company_data_provider_id, 'SUBLOAD', 'sub_load_3', 'YOTAJLMD7V')

  INSERT INTO dbo.device (company_data_provider_id, type, serial_number, endpoint)
  VALUES (@sub_load_company_data_provider_id, 'SUBLOAD', 'sub_load_4', 'W5QQ6LVHI7')

  INSERT INTO dbo.device (company_data_provider_id, type, serial_number, endpoint)
  VALUES (@sub_load_company_data_provider_id, 'SUBLOAD', 'sub_load_5', '5JBQFH8FPP')
END;
