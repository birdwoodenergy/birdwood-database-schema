

INSERT INTO [dbo].[network_time_period_rate]
    ([name], [description], [all_rate], [peak_rate],
     [shoulder_rate], [off_peak_rate], [sun_saver_rate])
VALUES
    ('SS', 'Sun Soaker - Interval Meter', NULL, 15.8671, NULL, 5.4028, NULL),
    ('PSO-Int', 'Peak, Shoulder, & Off-peak - Interval Meter', NULL, 8.8434, 5.905, 3.5188, NULL),
    ('PSO-B', 'Peak, Shoulder, & Off-peak - Basic Meter', NULL, 21.4808, 16.2652, 8.1693, NULL),
    ('EXP', 'Export - Interval Meter', NULL, NULL, NULL, NULL, NULL),
    ('ANY', 'Anytime', NULL, NULL, NULL, NULL, NULL),
    ('STO-EChannel', 'Storage - Interval Meter Consumption (E Channel)', NULL, NULL, NULL, NULL, NULL),
    ('STO-BChannel', 'Storage - Interval Meter Generation (B Channel)', NULL, NULL, NULL, NULL, NULL),
    ('5-9 Hours', 'Controlled Load', 2.713, NULL, NULL, NULL, NULL),
    ('10-19 hours', 'Controlled Load', 5.7748, NULL, NULL, NULL, NULL);
