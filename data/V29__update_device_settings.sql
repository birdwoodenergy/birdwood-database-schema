BEGIN TRANSACTION;
BEGIN TRY
    -- Update all PV devices, changing pv_key from "GRID.PowerkW" to "GEN.PowerkW"
    UPDATE dbo.device
    SET settings = REPLACE(settings, '"pv_key": "GRID.PowerkW"', '"pv_key": "GEN.PowerkW"')
    WHERE type = 'PV'
      AND settings LIKE '%"pv_key": "GRID.PowerkW"%';

    -- Update all SUBLOAD devices, changing sub_load_key from "kW" to "SUBM.PowerkW"
    UPDATE dbo.device
    SET settings = REPLACE(settings, '"sub_load_key": "kW"', '"sub_load_key": "SUBM.PowerkW"')
    WHERE type = 'SUBLOAD'
      AND settings LIKE '%"sub_load_key": "kW"%';
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'An error occurred. Transaction rolled back.';
END CATCH;
