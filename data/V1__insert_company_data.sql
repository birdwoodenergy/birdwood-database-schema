--Data for the company table
INSERT INTO [dbo].[company]
    ([name],[address],[timezone],[latitude],[longitude],[contact_number],[email_address])  --TODO: Add the customer_number & email_id
        VALUES
        (N'Devro',N'GREAT WESTERN HIGHWAY, KELSO, NSW 2795',N'Australia/NSW',-33.4188539,149.6061412,NULL,NULL),
        (N'Lanteri',N'1/136 Brett Rd, Euston, NSW 2737',N'Australia/Victoria',-34.2595931,142.1119565,NULL,NULL),
        (N'Media Point',N'186 Paramount Boulevard, DERRIMUT VIC 3030',N'Australia/Victoria',-37.7877525,144.7728707,NULL,NULL),
        (N'So Soft',N'27 WILTSHIRE LANE, DELACOMBE, VIC 3356',N'Australia/Victoria',-37.5746386,143.8093824,NULL,NULL),
        (N'BE122_Lorne',N'STRIBLING RESERVE OTWAY ST, LORNE VIC 3232',N'Australia/Victoria',-38.5435037,143.97011342113717,NULL,NULL),
        (N'BE105_Sands',N'2 Sands boulevarde, Torquay, VIC 3228',N'Australia/Victoria',-38.3133,144.347,NULL,NULL),
        (N'BE116_Arnolds_Fruit_Market',N'6 Osburn St, Wodonga VIC 3690 ',N'Australia/Victoria',-36.120449960544335,146.8992138442355,NULL,NULL),
        (N'BE111_WCC_Cube',N'118 Hovell Street, Wodonga VIC',N'Australia/Victoria',-36.123557,146.889058,NULL,NULL),
        (N'YR13_Yarra_Aquatics',N'2435 Warburton Hwy, Yarra Junction VIC 3797',N'Australia/Victoria',-37.78088856089678,145.61089640270657,NULL,NULL),
        (N'BE8001_MCC_Junior',N'17 Ambrose Way, North Mackay QLD 4740',N'Australia/Queensland',-21.114,149.175316,NULL,NULL),
        (N'BE8002_MCC_Senior',N'9 Quarry St, North Mackay QLD 4740',N'Australia/Queensland',-21.1129,149.182357,NULL,NULL),
        (N'DCCS',N'23 Walter St, Moorabbin VIC 3181',N'Australia/Victoria',-37.9338222372747, 145.06541923084995,NULL,NULL),
        (N'Marciano',N'41 COWRA AVE, KOORLONG, VIC 3501',N'Australia/Victoria',-34.2595931, 142.1119565,NULL,NULL)
        ;
