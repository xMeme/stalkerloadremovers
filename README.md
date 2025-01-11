# S.T.A.L.K.E.R. Trilogy Autoplitter

## Memory addresses
### Shadow of Chernobyl v1.0000-v1.0006

|  Type     | Name             | Description                                                                                                               |
|  ------   | ---------------  | ----------------------------------------------------------------------------------------------------------------          |
|  bool     | Loading          | `true` while loading a level or save                                                                                      |
|  string   | CurMap           | Displays currently loaded level name                                                                                      |
|  bool     | NoControl        | `true` while in-game cinematic cutscene is playing. Or when player is being at level transition prompt                    |
|  float    | sync             | Tickrate of the game                                                                                                      |
|  string   | End              | Displays name of video file of any Wishgranter endings                                                                    |
|  string   | TrueEnd          | Same purpose as End pointer, but for a name of video file of True Ending, when Strelok destroys C-Consciousness           |

### Clear Sky v1.5.10
|  Type     | Name             | Description                                                                                                               |
|  ------   | ---------------  | ----------------------------------------------------------------------------------------------------------------          |
|  string   | Start            | Displays name of video file of Intro cutscene                                                                             |
|  bool     | Loading          | `true` while loading a level or save                                                                                      |
|  string   | CurMap           | Displays currently loaded level name                                                                                      |
|  bool     | NoControl        | `true` while in-game cinematic cutscene is playing. Or when player is being at level transition prompt                    |
|  float    | Sync             | Tickrate of the game                                                                                                      |
|  string   | End              | Displays name of video file of Ending cutscene                                                                            |



## Shadow of Chernobyl Wishgranter endings

| Ending                          | Internal name               |
| ------------------------------- | -------------------------   |
| I want immortality              | final_immortal.ogm          |
| I want to rule the world        | final_to_monolith.ogm       |
| I want to be rich               | final_gold.ogm              |
| I want the zone to disappear    | final_blind.ogm             |
| Mankind must be controlled      | final_apocal.ogm            |

## Level names

These are the internal location names that you get when you read the memory address mentioned above.

### Shadow of Chernobyl

| Level                   | Internal name               |
| ----------------------- | -------------------------   |
| Cordon                  | escape\                     |
| Garbage                 | garbage\                    |
| Agroprom                | agroprom\                   |
| Agroprom Underground    | _agr_underground\           |
| Dark Valley             | darkvalley\                 |
| Lab X-18                | _labx18\                    |
| Rostok(100 RAD's Bar)   | bar\                        |
| Wild Territory          | rostok\                     |
| Yantar                  | yantar\                     |
| Lab X-16                | _brainlab\                  |
| Army Warehouses         | military\                   |
| Radar(aka Red Forest)   | radar\                      |
| Lab X-19                | _bunker\                    |
| Pripyat                 | pripyat\                    |
| Chernobyl NPP           | stancia\                    |
| Sarcophagus             | _sarcofag\                  |
| Monolith Control Center | _control_monolith\          |
| Chernobyl NPP (North)   | stancia_2\                  |

### Clear Sky

| Level                   | Internal name               |
| ----------------------- | -------------------------   |
| Swamps                  | marsh\                      |
| Cordon                  | escape\                     |
| Garbage                 | garbage\                    |
| Agroprom                | agroprom\                   |
| Agroprom Underground    | agroprom_underground\       |
| Dark Valley             | darkvalley\                 |
| Yantar                  | yantar\                     |
| Army Warehouses         | military\                   |
| Red Forest              | red_forest\                 |
| Limansk                 | limansk\                    |
| Deserted Hospital       | hospital\                   |
| Chernobyl NPP (North)   | stancia_2\                  |

### Call of Pripyat

| Level                   | Internal name               |
| ----------------------- | -------------------------   |
| Zaton                   | zaton\                      |
| Area around Jupiter     | jupiter\                    |
| Jupiter Underground     | jupiter_underground\        |
| Pripyat                 | pripyat\                    |
| Lab X-8                 | labx8\                      |
