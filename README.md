# R Level System
Simple leveling system which can be used not only in darkrp

### Features
* Compitable with any gamemode
* Compitable with addons which compitable with [Vrondakis leveling system](https://github.com/vrondakis/Leveling-System)
* Compitable with [Job System | Job Employer NPCs](https://www.gmodstore.com/market/view/4569)
* Has darkrp integration
* Easy module system
* Easy configurable
* Compitable with MySQL(MySQLoo, tmysql4) or just sqlite

### For devs
That hooks is available:
```
Serverside:
    RLS.OnLevelChange(Player ply, number level): nothing to return
    RLS.OnExpChange(Player ply, number exp, bool is_level_updated): nothing to return
    RLS.UpdateExpAmount(Player ply, number exp): return number exp
```

### Suggest your modules please
If you have an idea for module, compitablity with an addon, just open [Issue](https://github.com/Roni-sl/)

### ToDo
* TTT support
* Murder support
