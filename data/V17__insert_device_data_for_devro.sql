-- INSERT devices for Devro
DECLARE @company_name NVARCHAR(50) = 'Devro';
DECLARE @company_id INT;
DECLARE @grid_company_data_provider_id INT;
DECLARE @pv_company_data_provider_id INT;
DECLARE @bess_company_data_provider_id INT;
DECLARE @sub_load_company_data_provider_id INT;
DECLARE @company_data_provider_id INT;

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
  INSERT INTO dbo.device (company_data_provider_id, type, serial_number)
  VALUES (@grid_company_data_provider_id, 'GRID', 'grid_2')
END;

IF @pv_company_data_provider_id IS NULL
BEGIN
  PRINT 'Company ' + @company_name + ' does not have a PV company_data_provider entry.';
END;
ELSE
BEGIN
  -- INSERT pv device
  INSERT INTO dbo.device (company_data_provider_id, type, serial_number)
  VALUES (@pv_company_data_provider_id, 'PV', 'pv_2')
END;

IF @bess_company_data_provider_id IS NULL
BEGIN
  PRINT 'Company ' + @company_name + ' does not have a BESS company_data_provider entry.';
END;

IF @sub_load_company_data_provider_id IS NULL
BEGIN
  PRINT 'Company ' + @company_name + ' does not have a SUBLOAD company_data_provider entry.';
  RETURN;
END;
