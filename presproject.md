Project
========================================================
author: Richard Loeur & Arnaud Lemoine & Antoine Cremel
date: 18/12/2019
autosize: true

- The URL of the deployed shiny app : 

- The URL of the pushed code on github :   

- The URL of the presentation on Rpubs : 

Transport Project
========================================================

Our datasets:

- SNCF train dataset (they used to have train I guess) 

This dataset contain lines that discribe a train line so we have the train departure and arrival stations, the journey time (in minutes) and some more information like delay, cancelation...

- 2015 US flights 

This dataset is representing all the fligths in the US for the year 2015. It contain the fligth number, the airline, the departure and arrival airport as well as the date et information about the distance or delay and more.

Summary of the Train Dataset
========================================================


```
      year          month                 service    
 Min.   :2015   Min.   : 1.000   International: 432  
 1st Qu.:2016   1st Qu.: 3.000   National     :3600  
 Median :2017   Median : 6.000   NA's         :1430  
 Mean   :2017   Mean   : 6.369                       
 3rd Qu.:2018   3rd Qu.: 9.000                       
 Max.   :2018   Max.   :12.000                       
                                                     
            departure_station             arrival_station journey_time_avg
 PARIS LYON          :1139    PARIS LYON          :1139   Min.   : 45.96  
 PARIS MONTPARNASSE  : 752    PARIS MONTPARNASSE  : 752   1st Qu.:100.77  
 PARIS EST           : 282    PARIS EST           : 282   Median :160.84  
 LYON PART DIEU      : 246    LYON PART DIEU      : 246   Mean   :165.39  
 PARIS NORD          : 188    PARIS NORD          : 188   3rd Qu.:205.70  
 MARSEILLE ST CHARLES: 174    MARSEILLE ST CHARLES: 174   Max.   :481.00  
 (Other)             :2681    (Other)             :2681                   
 total_num_trips num_of_canceled_trains comment_cancellations
 Min.   :  6.0   Min.   :  0.000        Mode:logical         
 1st Qu.:181.0   1st Qu.:  0.000        NA's:5462            
 Median :238.0   Median :  1.000                             
 Mean   :281.1   Mean   :  7.737                             
 3rd Qu.:390.0   3rd Qu.:  4.000                             
 Max.   :878.0   Max.   :279.000                             
                                                             
 num_late_at_departure avg_delay_late_at_departure avg_delay_all_departing
 Min.   :  0.00        Min.   :  0.00              Min.   : -4.468        
 1st Qu.: 10.00        1st Qu.: 11.98              1st Qu.:  0.896        
 Median : 23.00        Median : 15.84              Median :  1.783        
 Mean   : 41.58        Mean   : 16.81              Mean   :  2.539        
 3rd Qu.: 51.75        3rd Qu.: 20.28              3rd Qu.:  3.243        
 Max.   :451.00        Max.   :173.57              Max.   :173.571        
                                                                          
 comment_delays_at_departure num_arriving_late avg_delay_late_on_arrival
 Mode:logical                Min.   :  0.00    Min.   :  0.00           
 NA's:5462                   1st Qu.: 17.00    1st Qu.: 23.81           
                             Median : 30.00    Median : 30.76           
                             Mean   : 38.03    Mean   : 32.45           
                             3rd Qu.: 50.00    3rd Qu.: 38.77           
                             Max.   :235.00    Max.   :258.00           
                             NA's   :9         NA's   :9                
 avg_delay_all_arriving
 Min.   :-143.969      
 1st Qu.:   2.706      
 Median :   4.581      
 Mean   :   5.287      
 3rd Qu.:   7.252      
 Max.   :  36.817      
                       
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                comment_delays_on_arrival     
 Ce mois-ci, l'OD a Ã©tÃ© touchÃ©e par les incidents suivants: \nLe 3 : Avarie Ã  la catÃ©naire Ã  lâ\200\231entrÃ©e de la gare de Paris Montparnasse (46 TGV ; 476mn)\nLe 6 : Ã©pisode neigeux sur toute la France (187 TGV ; 18980mn ; 23 suppressions)\nLe 7 : Ã©pisode neigeux sur toute la France (134 TGV ; 6294mn ; 77 suppressions)\nLe 8 : Ã©pisode neigeux sur toute la France (166 TGV ; 2814mn ; 30 suppressions)\nLe 9 : Ã©pisode neigeux sur toute la France (151 TGV ; 2830mn ; 15 suppressions)\nLe 15 : Incident catÃ©naire Ã  lâ\200\231entrÃ©e de la gare de Paris Montparnasse (78 TGV ; 2349mn ; 15 suppressions)\nLe 15 : DÃ©rangement dâ\200\231installation sur la ligne grande vitesse (22 TGV ; 672mn)\nLe 21 : PrÃ©sences de ChÃ¨vres aux abords de la ligne grande vitesse Ã  Marcoussis (15 TGV ; 292mn)\nLe 21 : Avarie MatÃ©rielle sur la ligne grande vitesse au niveau de St Leger (62 TGV ; 2150mn)\nLe 28 : BÃ¢che dans la catÃ©naire Ã  lâ\200\231entrÃ©e de la gare de Paris Montparnasse (28 TGV ; 605mn):  34  
 Mois marquÃ© par neuf accidents de personne et cinq heurts d'animaux, qui ont eu un fort impact sur l'ensemble des relations                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          :  19  
 Ce mois-ci, l'OD a Ã©tÃ© touchÃ©e par: _x000D_\nLe 7 : DÃ©faillance matÃ©rielle Ã  la sortie de la gare de Paris Montparnasse (87 TGV ; 2202â\200\231)_x000D_\nLe 11 : Divergence entre les Ã©quipements au sol et les TGV en circulation sur la grande ceinture parisienne (36 TGV ; 1034â\200\231)_x000D_\nLe 13 : DÃ©rangement dâ\200\231aiguille sur le tronc commun des lignes grandes vitesse Ã  St Arnoult (19 TGV ; 289â\200\231)_x000D_\nLe 13 : DÃ©faut dâ\200\231alimentation Ã©lectrique Ã  la sortie de la gare de Paris Montparnasse (30 TGV ; 422â\200\231)_x000D_\nLe 17 : Rupture catÃ©naire en gare de Paris Montparnasse (75 TGV ; 4801â\200\231)_x000D_\nLe 19 : Personnes dans les voies Ã  la sortie de la gare de Paris Montparnasse (24 TGV ; 363â\200\231)_x000D_\nLe 23 : PrÃ©sence dâ\200\231objets pris dans la catÃ©naire Ã  la sortie du Mans (16 TGV ; 372â\200\231)_x000D_\nDu 29 au 31 : DÃ©rangement du poste de Vanves (450 TGV ; 27110â\200\231)                                                                                                    :  18  
 Des travaux de modernisation de l'infrastructure ont perturbÃ© la rÃ©gularitÃ© de cette relation en Juillet                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           :  17  
 Des travaux de modernisation de l'infrastructure ont perturbÃ© la rÃ©gularitÃ© de cette relation en Juin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              :  16  
 (Other)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               :1437  
 NA's                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  :3921  
 delay_cause_external_cause delay_cause_rail_infrastructure
 Min.   :0.0000             Min.   :0.0000                 
 1st Qu.:0.1667             1st Qu.:0.1515                 
 Median :0.2571             Median :0.2353                 
 Mean   :0.2780             Mean   :0.2518                 
 3rd Qu.:0.3684             3rd Qu.:0.3333                 
 Max.   :1.0000             Max.   :1.0000                 
 NA's   :170                NA's   :170                    
 delay_cause_traffic_management delay_cause_rolling_stock
 Min.   :0.0000                 Min.   :0.00000          
 1st Qu.:0.0800                 1st Qu.:0.09292          
 Median :0.1613                 Median :0.15843          
 Mean   :0.1831                 Mean   :0.17877          
 3rd Qu.:0.2571                 3rd Qu.:0.24000          
 Max.   :1.0000                 Max.   :1.00000          
 NA's   :170                    NA's   :170              
 delay_cause_station_management delay_cause_travelers num_greater_15_min_late
 Min.   :0.00000                Min.   :0.00000       Min.   :  0.00         
 1st Qu.:0.00000                1st Qu.:0.00000       1st Qu.: 11.00         
 Median :0.05263                Median :0.02128       Median : 20.00         
 Mean   :0.06999                Mean   :0.03730       Mean   : 26.09         
 3rd Qu.:0.10256                3rd Qu.:0.05769       3rd Qu.: 35.00         
 Max.   :1.00000                Max.   :0.66667       Max.   :192.00         
 NA's   :170                    NA's   :170           NA's   :5              
 avg_delay_late_greater_15_min num_greater_30_min_late num_greater_60_min_late
 Min.   :-118.022              Min.   : 0.00           Min.   : 0.000         
 1st Qu.:   8.994              1st Qu.: 4.00           1st Qu.: 1.000         
 Median :  31.533              Median : 9.00           Median : 3.000         
 Mean   :  28.984              Mean   :11.65           Mean   : 4.197         
 3rd Qu.:  41.000              3rd Qu.:16.00           3rd Qu.: 6.000         
 Max.   : 258.000              Max.   :91.00           Max.   :36.000         
 NA's   :5                     NA's   :5               NA's   :5              
```

Summary of the Flights Dataset
========================================================


```
      YEAR          MONTH             DAY        DAY_OF_WEEK   
 Min.   :2015   Min.   : 1.000   Min.   : 1.0   Min.   :1.000  
 1st Qu.:2015   1st Qu.: 4.000   1st Qu.: 8.0   1st Qu.:2.000  
 Median :2015   Median : 7.000   Median :16.0   Median :4.000  
 Mean   :2015   Mean   : 6.524   Mean   :15.7   Mean   :3.927  
 3rd Qu.:2015   3rd Qu.: 9.000   3rd Qu.:23.0   3rd Qu.:6.000  
 Max.   :2015   Max.   :12.000   Max.   :31.0   Max.   :7.000  
                                                               
    AIRLINE        FLIGHT_NUMBER   TAIL_NUMBER      ORIGIN_AIRPORT   
 WN     :1261855   Min.   :   1          :  14721   ATL    : 346836  
 DL     : 875881   1st Qu.: 730   N480HA :   3768   ORD    : 285884  
 AA     : 725984   Median :1690   N484HA :   3723   DFW    : 239551  
 OO     : 588353   Mean   :2173   N488HA :   3723   DEN    : 196055  
 EV     : 571977   3rd Qu.:3230   N493HA :   3585   LAX    : 194673  
 UA     : 515723   Max.   :9855   N478HA :   3577   SFO    : 148008  
 (Other):1279306                  (Other):5785982   (Other):4408072  
 DESTINATION_AIRPORT SCHEDULED_DEPARTURE DEPARTURE_TIME  DEPARTURE_DELAY  
 ATL    : 346904     Min.   :   1        Min.   :   1    Min.   : -82.00  
 ORD    : 285906     1st Qu.: 917        1st Qu.: 921    1st Qu.:  -5.00  
 DFW    : 239582     Median :1325        Median :1330    Median :  -2.00  
 DEN    : 196010     Mean   :1330        Mean   :1335    Mean   :   9.37  
 LAX    : 194696     3rd Qu.:1730        3rd Qu.:1740    3rd Qu.:   7.00  
 SFO    : 147966     Max.   :2359        Max.   :2400    Max.   :1988.00  
 (Other):4408015                         NA's   :86153   NA's   :86153    
    TAXI_OUT        WHEELS_OFF    SCHEDULED_TIME   ELAPSED_TIME   
 Min.   :  1.00   Min.   :   1    Min.   : 18.0   Min.   : 14     
 1st Qu.: 11.00   1st Qu.: 935    1st Qu.: 85.0   1st Qu.: 82     
 Median : 14.00   Median :1343    Median :123.0   Median :118     
 Mean   : 16.07   Mean   :1357    Mean   :141.7   Mean   :137     
 3rd Qu.: 19.00   3rd Qu.:1754    3rd Qu.:173.0   3rd Qu.:168     
 Max.   :225.00   Max.   :2400    Max.   :718.0   Max.   :766     
 NA's   :89047    NA's   :89047   NA's   :6       NA's   :105071  
    AIR_TIME         DISTANCE        WHEELS_ON        TAXI_IN      
 Min.   :  7.0    Min.   :  21.0   Min.   :   1    Min.   :  1.00  
 1st Qu.: 60.0    1st Qu.: 373.0   1st Qu.:1054    1st Qu.:  4.00  
 Median : 94.0    Median : 647.0   Median :1509    Median :  6.00  
 Mean   :113.5    Mean   : 822.4   Mean   :1471    Mean   :  7.43  
 3rd Qu.:144.0    3rd Qu.:1062.0   3rd Qu.:1911    3rd Qu.:  9.00  
 Max.   :690.0    Max.   :4983.0   Max.   :2400    Max.   :248.00  
 NA's   :105071                    NA's   :92513   NA's   :92513   
 SCHEDULED_ARRIVAL  ARRIVAL_TIME   ARRIVAL_DELAY        DIVERTED      
 Min.   :   1      Min.   :   1    Min.   : -87.00   Min.   :0.00000  
 1st Qu.:1110      1st Qu.:1059    1st Qu.: -13.00   1st Qu.:0.00000  
 Median :1520      Median :1512    Median :  -5.00   Median :0.00000  
 Mean   :1494      Mean   :1476    Mean   :   4.41   Mean   :0.00261  
 3rd Qu.:1918      3rd Qu.:1917    3rd Qu.:   8.00   3rd Qu.:0.00000  
 Max.   :2400      Max.   :2400    Max.   :1971.00   Max.   :1.00000  
                   NA's   :92513   NA's   :105071                     
   CANCELLED       CANCELLATION_REASON AIR_SYSTEM_DELAY  SECURITY_DELAY   
 Min.   :0.00000    :5729195           Min.   :   0      Min.   :  0      
 1st Qu.:0.00000   A:  25262           1st Qu.:   0      1st Qu.:  0      
 Median :0.00000   B:  48851           Median :   2      Median :  0      
 Mean   :0.01545   C:  15749           Mean   :  13      Mean   :  0      
 3rd Qu.:0.00000   D:     22           3rd Qu.:  18      3rd Qu.:  0      
 Max.   :1.00000                       Max.   :1134      Max.   :573      
                                       NA's   :4755640   NA's   :4755640  
 AIRLINE_DELAY     LATE_AIRCRAFT_DELAY WEATHER_DELAY    
 Min.   :   0      Min.   :   0        Min.   :   0     
 1st Qu.:   0      1st Qu.:   0        1st Qu.:   0     
 Median :   2      Median :   3        Median :   0     
 Mean   :  19      Mean   :  23        Mean   :   3     
 3rd Qu.:  19      3rd Qu.:  29        3rd Qu.:   0     
 Max.   :1971      Max.   :1331        Max.   :1211     
 NA's   :4755640   NA's   :4755640     NA's   :4755640  
```


What we can learn from the Flights Dataset
========================================================

We can see that the most popular Airlines in the US in 2015 where Southwest Airlines Co. with 1 261 855 fligths that year. The second one is American Airlines Inc. with 725 984 flights.
Unsurprinsing is the fact that Southwest Airlines is also the airline with the most delayed flights with 646 569.

