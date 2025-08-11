# S.T.A.L.K.E.R. Trilogy Autosplitter

## Memory addresses
### Shadow of Chernobyl v1.0000-v1.0006

|  Type     | Name             | Description                                                                                                               |
|  ------   | ---------------  | ----------------------------------------------------------------------------------------------------------------          |
|  bool     | Loading          | `true` while player is connected to a local server                                                                        |
|  string   | CurMap           | Displays currently loaded shortened level name                                                                            |
|  bool     | isPaused         | `true` while game is paused                                                                                               |
|  bool     | Prompt           | `true` When player is being at level transition prompt                                                                    |
|  float    | sync             | Tickrate of the game                                                                                                      |
|  string   | End              | Displays name of video cutscenes                                                                                          |

### Clear Sky v1.5.10
|  Type     | Name             | Description                                                                                                               |
|  ------   | ---------------  | ----------------------------------------------------------------------------------------------------------------          |
|  string   | Start            | Displays name of video file of Intro cutscene                                                                             |
|  bool     | Loading          | `true` while player is connected to a local server                                                                        |
|  string   | CurMap           | Displays currently loaded shortened level name                                                                            |
|  bool     | NoControl        | `true` while in-game cinematic cutscene is playing.                                                                       |
|  float    | sync             | Tickrate of the game                                                                                                      |
|  string   | End              | Displays name of video file of Ending cutscene                                                                            |

### Call of Pripyat v1.6.02
|  Type     | Name             | Description                                                                                                               |
|  ------   | ---------------  | ----------------------------------------------------------------------------------------------------------------          |
|  bool     | Load             | `true` while player is connected to a local server                                                                        |
|  bool     | Load2            | `true` while game is loaded & player didn't leave loading screen yet                                                      |
|  string   | CurMap           | Displays currently loaded shortened level name                                                                            |
|  float    | sync             | Tickrate of the game                                                                                                      |
|  string   | End              | Displays shortened name of audio file of Ending cutscene                                                                  |



## Shadow of Chernobyl Wishgranter endings

These are the internal Wish Granter ending names that you get when you read the memory address mentioned above.

| Ending                          | Internal name               |
| ------------------------------- | -------------------------   |
| I want immortality              | final_immortal.ogm          |
| I want to rule the world        | final_to_monolith.ogm       |
| I want to be rich               | final_gold.ogm              |
| I want the zone to disappear    | final_blind.ogm             |
| Mankind must be controlled      | final_apocal.ogm            |

## Level names

These are the internal shortened location names that you get when you read the memory address mentioned above.

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
