# R Level System
Simple leveling system that can be used not only in darkrp

### Features
* Compatible with any gamemode
* Compatible with addons that work with [Vrondakis leveling system](https://github.com/vrondakis/Leveling-System)
* Compatible with [Job System | Job Employer NPCs](https://www.gmodstore.com/market/view/4569)
* Has darkrp integration
* Easy module system
* Easy configurable
* Compatible with MySQL(MySQLoo, tmysql4) or just sqlite

### For devs
That hooks is available:
```
Serverside:
	RLS.OnLevelChange(Player ply, number level): nothing to return
	RLS.OnExpChange(Player ply, number exp, bool is_level_updated): nothing to return
	RLS.UpdateExpAmount(Player ply, number exp): return number exp
```

### Suggest your modules please
If you have an idea for module, compitablity with an addon, just open [Issue](https://github.com/Roni-sl/R-Leveling-System/issues/new)

### ToDo
* TTT support
* Murder support
