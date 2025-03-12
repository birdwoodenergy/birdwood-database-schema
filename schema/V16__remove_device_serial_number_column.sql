SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Drop the constraint on the serial_number column
ALTER TABLE [dbo].[device]
DROP CONSTRAINT UQ_device_serial_number;

-- Drop the serial_number column
ALTER TABLE [dbo].[device]
DROP COLUMN serial_number;
