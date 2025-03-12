WITH RateIDs AS (
    SELECT [id], [name]
    FROM [dbo].[network_time_period_rate]
),
ProviderIDs AS (
    SELECT [id], [name]
    FROM [dbo].[network_provider]
)
INSERT INTO [dbo].[network_tariff]
    ([network_charge_code], [description], [start_date], [end_date], [network_provider_id], [network_time_period_rate_id])
SELECT
    nt.[network_charge_code],
    nt.[description],
    nt.[start_date],
    nt.[end_date],
    p.[id],  -- Dynamically mapped provider ID
    r.[id]  -- Dynamically mapped time period rate ID
FROM (VALUES
    ('BLNRSS2', 'LV Residential ToU - Sun Soaker', '2024-07-01', '2025-07-01', 'Essential Energy', 'SS'),
    ('BLND1AR', 'LV Residential - Opt in Demand', '2024-07-01', '2025-07-01', 'Essential Energy', 'PSO-Int'),
    ('BLNC1AU', 'Controlled Load 1', '2024-07-01', '2025-07-01', 'Essential Energy', 'PSO-B'),
    ('BLNC2AU', 'Controlled Load 2', '2024-07-01', '2025-07-01', 'Essential Energy', 'EXP')
) AS nt ([network_charge_code], [description], [start_date], [end_date], [provider_name], [network_charge_code_lookup])
JOIN RateIDs r ON nt.[network_charge_code_lookup] = r.[name]
JOIN ProviderIDs p ON nt.[provider_name] = p.[name];
