
-- if you don't know how to change it, don't edit this please
RLS.Formula = function(level)
	return 1000*(1.25^level)
end

RLS.EnableHUD = true

RLS.SetLevelCommand = "!setlevel"
RLS.AddLevelCommand = "!addlevel"

RLS.SetExpCommand = "!setexp"
RLS.AddExpCommand = "!addexp"

RLS.CommandsAccess = { -- Who can run commands
	["founder"] = true,
	["superadmin"] = true,
}

-- MODULES CONFIG YOU CAN FIND IN MODULE FILE
RLS.DisableModules = { -- Set to 'true' to disable it
	["time_exp"] = false, -- Add Exp for playing on server every X minutes
	["killing_npc"] = false, -- Add reward for killing NPC
	["killing_player"] = false, -- Add reward for killing player
	["darkrp_integration"] = true, -- Add integration to darkrp to support level for shop items and jobs
	["vrondakis_comp"] = false, -- Add backward compatible, so, addons compitable with vrondakis level system now compitable with that too!
	["multiplyer_exp"] = false, -- Add multiplier of Exp for each rank
}
