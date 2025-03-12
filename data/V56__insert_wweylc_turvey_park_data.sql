BEGIN TRANSACTION;

BEGIN TRY
    -- Insert company data if not exists
    IF EXISTS (SELECT 1 FROM dbo.company WHERE name = 'WWEYLC Turvey Park')
    BEGIN
        PRINT 'Company "WWEYLC Turvey Park" already exists. Skipping insert.';
    END
    ELSE
    BEGIN
        INSERT INTO dbo.company (name, address, timezone, latitude, longitude, contact_number, email_address)
        VALUES ('WWEYLC Turvey Park', '57 Fernleigh Road, Turvey Park NSW, Australia', 'Australia/NSW', NULL, NULL, NULL, NULL);
        PRINT 'Inserted company "WWEYLC Turvey Park".';
    END;

    -- Declare variables
    DECLARE @company_id INT;
    DECLARE @grid_data_provider_id INT;
    DECLARE @pv_data_provider_id INT;
    DECLARE @grid_company_data_provider_id INT;
    DECLARE @pv_company_data_provider_id INT;
    DECLARE @grid_settings NVARCHAR(MAX);
    DECLARE @pv_settings NVARCHAR(MAX);
    DECLARE @grid_device_endpoint NVARCHAR(50);
    DECLARE @pv_device_endpoint NVARCHAR(50);

    -- Set data provider names
    DECLARE @company_name NVARCHAR(50) = 'WWEYLC Turvey Park';
    DECLARE @grid_data_provider_name NVARCHAR(50) = 'Wattwatchers';
    DECLARE @pv_data_provider_name NVARCHAR(50) = 'Wattwatchers';

    -- Retrieve company ID
    SELECT @company_id = id FROM dbo.company WHERE name = @company_name;

    -- Retrieve data provider IDs
    SELECT @grid_data_provider_id = id FROM dbo.data_provider WHERE name = @grid_data_provider_name;
    SELECT @pv_data_provider_id = id FROM dbo.data_provider WHERE name = @pv_data_provider_name;

    -- Insert company_data_provider if not exists
    IF @company_id IS NOT NULL AND @grid_data_provider_id IS NOT NULL
    BEGIN
        IF EXISTS (SELECT 1 FROM dbo.company_data_provider WHERE company_id = @company_id AND data_provider_id = @grid_data_provider_id AND data_provider_type = 'GRID')
        BEGIN
            PRINT 'Company Data Provider (GRID) already exists for "' + @company_name + '". Skipping insert.';
        END
        ELSE
        BEGIN
            INSERT INTO dbo.company_data_provider (company_id, data_provider_id, data_provider_type)
            VALUES (@company_id, @grid_data_provider_id, 'GRID');
            PRINT 'Inserted Company Data Provider (GRID) for "' + @company_name + '".';
        END;
    END;

    IF @company_id IS NOT NULL AND @pv_data_provider_id IS NOT NULL
    BEGIN
        IF EXISTS (SELECT 1 FROM dbo.company_data_provider WHERE company_id = @company_id AND data_provider_id = @pv_data_provider_id AND data_provider_type = 'PV')
        BEGIN
            PRINT 'Company Data Provider (PV) already exists for "' + @company_name + '". Skipping insert.';
        END
        ELSE
        BEGIN
            INSERT INTO dbo.company_data_provider (company_id, data_provider_id, data_provider_type)
            VALUES (@company_id, @pv_data_provider_id, 'PV');
            PRINT 'Inserted Company Data Provider (PV) for "' + @company_name + '".';
        END;
    END;

    -- Retrieve company_data_provider IDs
    SELECT @grid_company_data_provider_id = id FROM dbo.company_data_provider WHERE company_id = @company_id AND data_provider_type = 'GRID';
    SELECT @pv_company_data_provider_id = id FROM dbo.company_data_provider WHERE company_id = @company_id AND data_provider_type = 'PV';

    -- Insert devices if not exists
    IF @grid_company_data_provider_id IS NOT NULL
    BEGIN
        SET @grid_device_endpoint = 'DD55335297139';
        IF EXISTS (SELECT 1 FROM dbo.device WHERE company_data_provider_id = @grid_company_data_provider_id AND type = 'GRID' AND endpoint = @grid_device_endpoint)
        BEGIN
            PRINT 'Device (GRID) with endpoint "' + @grid_device_endpoint + '" already exists for "' + @company_name + '". Skipping insert.';
        END
        ELSE
        BEGIN
            SET @grid_settings = NULL;
            INSERT INTO dbo.device (company_data_provider_id, type, endpoint, settings)
            VALUES (@grid_company_data_provider_id, 'GRID', @grid_device_endpoint, @grid_settings);
            PRINT 'Inserted Device (GRID) with endpoint "' + @grid_device_endpoint + '" for "' + @company_name + '".';
        END;
    END;

    IF @pv_company_data_provider_id IS NOT NULL
    BEGIN
        SET @pv_device_endpoint = 'DD55335297139';
        IF EXISTS (SELECT 1 FROM dbo.device WHERE company_data_provider_id = @pv_company_data_provider_id AND type = 'PV' AND endpoint = @pv_device_endpoint)
        BEGIN
            PRINT 'Device (PV) with endpoint "' + @pv_device_endpoint + '" already exists for "' + @company_name + '". Skipping insert.';
        END
        ELSE
        BEGIN
            SET @pv_settings = NULL;
            INSERT INTO dbo.device (company_data_provider_id, type, endpoint, settings)
            VALUES (@pv_company_data_provider_id, 'PV', @pv_device_endpoint, @pv_settings);
            PRINT 'Inserted Device (PV) with endpoint "' + @pv_device_endpoint + '" for "' + @company_name + '".';
        END;
    END;

    -- Commit transaction
    COMMIT TRANSACTION;
    PRINT 'Transaction committed successfully.';
END TRY
BEGIN CATCH
    -- Rollback in case of any error
    ROLLBACK TRANSACTION;
    PRINT 'Transaction rolled back due to an error.';
    THROW;
END CATCH;
