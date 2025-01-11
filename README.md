# S.T.A.L.K.E.R. Trilogy Autoplitter

## Memory addresses
### Shadow of Chernobyl v1.0000

| Binary            | Offset1    | Offset2 | Offset3 | Offset4 | Offset5 | Offset6 |  Offset7  |  Offset8  |  Type     | Name             | Description                                                                                                               |
| ----------------- | ---------- |  -----  |  ----   |  ----   |  ----   |  ----   |   ----    |   ----    |  ------   | ---------------  | ----------------------------------------------------------------------------------------------------------------          |
| xrNetServer.dll   | 0xFAC4     |         |         |         |         |         |           |           |  bool     | Loading          | `true` while loading a level or save                                                                                      |
| xrCore.dll        | 0xBA040    |  0x4    |  0x0    |  0x40   |  0x8    |  0x20   |   0x14    |           |  string   | CurMap           | Displays currently loaded level name                                                                                      |
| xrGame.dll        | 0x54C2F9   |         |         |         |         |         |           |           |  bool     | NoControl        | `true` while in-game cinematic cutscene is playing. Or when player is being at level transition prompt                    |
| XR_3DA.exe        | 0x104928   |         |         |         |         |         |           |           |  float    | sync             | Tickrate of the game                                                                                                      |
| XR_3DA.exe        | 0x10A878   |  0xBC   |         |         |         |         |           |           |  string   | End              | Displays name of video file of any Wishgranter endings                                                                    |
| XR_3DA.exe        | 0x4163C    |  0xD30  |         |         |         |         |           |           |  string   | TrueEnd          | Same purpose as End pointer, but for a name of video file of True Ending, when Strelok destroys C-Consciousness           |

### Shadow of Chernobyl v1.0006
| Binary            | Offset1    | Offset2 | Offset3 | Offset4 | Offset5 | Offset6 |  Offset7  |  Offset8  |  Type     | Name             | Description                                                                                                               |
| ----------------- | ---------- |  -----  |  ----   |  ----   |  ----   |  ----   |   ----    |   ----    |  ------   | ---------------  | ----------------------------------------------------------------------------------------------------------------          |
| xrNetServer.dll   | 0x13E84    |         |         |         |         |         |           |           |  bool     | Loading          | `true` while loading a level or save                                                                                      |
| xrCore.dll        | 0xBF368    |  0x4    |  0x0    |  0x40   |  0x8    |  0x28   |   0x4     |           |  string   | CurMap           | Displays currently loaded level name                                                                                      |
| xrGame.dll        | 0x560668   |         |         |         |         |         |           |           |  bool     | NoControl        | `true` while in-game cinematic cutscene is playing. Or when player is being at level transition prompt                    |
| XR_3DA.exe        | 0x10BE80   |         |         |         |         |         |           |           |  float    | sync             | Tickrate of the game                                                                                                      |
| XR_3DA.exe        | 0x171DD4   |  0x180  |         |         |         |         |           |           |  string   | End              | Displays name of video file of any Wishgranter endings                                                                    |
| XR_3DA.exe        | 0x7D0F8    |  0x1CE  |         |         |         |         |           |           |  string   | TrueEnd          | Same purpose as End pointer, but for a name of video file of True Ending, when Strelok destroys C-Consciousness           |

### Clear Sky 1.5.10
| Binary            | Offset1    | Offset2 | Offset3 | Offset4 | Offset5 | Offset6 |  Offset7  |  Offset8  |  Type     | Name             | Description                                                                                                               |
| ----------------- | ---------- |  -----  |  ----   |  ----   |  ----   |  ----   |   ----    |   ----    |  ------   | ---------------  | ----------------------------------------------------------------------------------------------------------------          |
| xrGame.dll        | 0x2A6B19   |  0xE1   |         |         |         |         |           |           |  string   | Start            | Displays name of video file of Intro cutscene                                                                             |
| xrNetServer.dll   | 0x13E04    |         |         |         |         |         |           |           |  bool     | Loading          | `true` while loading a level or save                                                                                      |
| xrCore.dll        | 0xBE718    |  0x18   |  0x28   |  0x0    |         |         |           |           |  string   | CurMap           | Displays currently loaded level name                                                                                      |
| xrGame.dll        | 0x606320   |         |         |         |         |         |           |           |  bool     | NoControl        | `true` while in-game cinematic cutscene is playing. Or when player is being at level transition prompt                    |
| xrEngine.exe      | 0x96D50    |         |         |         |         |         |           |           |  float    | Sync             | Tickrate of the game                                                                                                      |
| xrEngine.exe      | 0x96CC0    |  0x30   |  0x10   |  0x4    |  0x34   |  0x4    |   0xC     |   0x16    |  string   | End              | Displays name of video file of Ending cutscene                                                                            |


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
