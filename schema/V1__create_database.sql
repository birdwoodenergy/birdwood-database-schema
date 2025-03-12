IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'birdwood_db')
BEGIN
  CREATE DATABASE birdwood_db;
END;
