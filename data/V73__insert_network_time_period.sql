WITH RateIDs AS (
    SELECT [id], [name]
    FROM [dbo].[network_time_period_rate]
)
INSERT INTO [dbo].[network_time_period]
    ([charge_type], [date_type], [start_time], [end_time], [network_time_period_rate_id])
SELECT
    ntp.[charge_type],
    ntp.[date_type],
    ntp.[start_time],
    ntp.[end_time],
    r.[id]
FROM (VALUES
    ('off_peak', 'everyday', '12:00:00', '14:59:59', 'SS'),
    ('peak', 'everyday', '15:00:00', '21:59:59', 'SS'),
    ('off_peak', 'everyday', '22:00:00', '06:59:59', 'SS'),
    ('peak', 'everyday', '07:00:00', '09:59:59', 'SS'),

    ('off_peak', 'Weekday', '12:00:00', '14:59:59', 'PSO-Int'),
    ('shoulder', 'Weekday', '15:00:00', '16:59:59', 'PSO-Int'),
    ('peak', 'Weekday', '17:00:00', '19:59:59', 'PSO-Int'),
    ('shoulder', 'weekday', '20:00:00', '21:59:59', 'PSO-Int'),

    ('off_peak', 'weekday', '22:00:00', '06:59:59', 'PSO-B'),
    ('shoulder', 'weekday', '07:00:00', '11:59:59', 'PSO-B'),
    ('off_peak', 'everyday', '10:00:00', '11:59:59', 'PSO-B'),
    ('off_peak', 'weekend', '12:00:00', '11:59:59', 'PSO-B'),

    ('off_peak', 'weekday', '12:00:00', '14:59:59', 'EXP'),
    ('shoulder', 'weekday', '15:00:00', '16:59:59', 'EXP'),
    ('peak', 'weekday', '17:00:00', '19:59:59', 'EXP'),
    ('shoulder', 'weekday', '20:00:00', '21:59:59', 'EXP'),

    ('off_peak', 'weekday', '22:00:00', '06:59:59', 'ANY'),
    ('peak', 'weekday', '07:00:00', '08:59:59', 'ANY'),
    ('shoulder', 'weekday', '09:00:00', '11:59:59', 'ANY'),
    ('off_peak', 'weekend', '12:00:00', '11:59:59', 'ANY'),

    ('export_charge', 'everyday', '10:00:00', '14:59:59', 'STO-EChannel'),
    ('export_rebate', 'everyday', '17:00:00', '19:59:59', 'STO-EChannel'),
    ('anytime', 'everyday', '12:00:00', '11:59:59', 'STO-EChannel'),

    ('off_peak', 'everyday', '12:00:00', '14:59:59', 'STO-BChannel'),
    ('shoulder', 'everyday', '15:00:00', '16:59:59', 'STO-BChannel'),
    ('peak', 'everyday', '17:00:00', '19:59:59', 'STO-BChannel'),
    ('shoulder', 'everyday', '20:00:00', '21:59:59', 'STO-BChannel'),

    ('off_peak', 'everyday', '22:00:00', '06:59:59', 'STO-BChannel'),
    ('shoulder', 'everyday', '07:00:00', '09:59:59', 'STO-BChannel'),
    ('sun_saver', 'everyday', '10:00:00', '11:59:59', 'STO-BChannel'),

    ('export_charge', 'everyday', '10:00:00', '14:59:59', '5-9 Hours'),
    ('export_rebate', 'everyday', '17:00:00', '19:59:59', '5-9 Hours')
) AS ntp([charge_type], [date_type], [start_time], [end_time], [network_charge_code])
JOIN RateIDs r ON ntp.[network_charge_code] = r.[name];
