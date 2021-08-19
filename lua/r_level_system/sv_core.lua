/*
	Base stuff
*/

hook.Add("DatabaseInitialized", "RLS.DatabaseInitialized", function()
	MySQLite.query([[
		CREATE TABLE IF NOT EXISTS r_level_system (
		steamid VARCHAR(255) PRIMARY KEY,
		level INTEGER,
		exp INTEGER
		);
	]], nil, function(e) print(e) end)
end)

hook.Add("PlayerInitialSpawn", "RLS.PlayerInitialSpawn", function(ply)
	local steamid = MySQLite.SQLStr(ply:SteamID())

	MySQLite.query(
		string.format("SELECT * FROM r_level_system WHERE steamid = %s;", steamid),
		function(data)
			local level = 1
			local exp = 0

			if data then
				level = tonumber(data[1].level)
				exp = tonumber(data[1].exp)
			else
				MySQLite.query(string.format("INSERT INTO r_level_system(steamid, level, exp) VALUES (%s, %d, %d);",
					steamid,
					level,
					exp
				))
			end

			ply:SetLevel(level, true)
			ply:SetExp(exp, true)
		end
	)
end)

/*
	Meta stuff
*/

local meta = FindMetaTable("Player")

function meta:SetLevel(lvl, without_hook)
	self:SetNWInt("RLS.Level", lvl)

  self:SyncRLS()

  if without_hook then
    return
  end

	hook.Run("RLS.OnLevelChange", self, lvl)
end

function meta:AddLevel(lvl)
	self:SetLevel(self:GetLevel() + lvl)
end

function meta:SetExp(exp, without_hook)

	self:SetNWInt("RLS.Exp", exp)

	self:IsPassedLevel(function(is_level_updated)
    self:SyncRLS()

    if without_hook then
      return
    end

		hook.Run("RLS.OnExpChange", self, exp, is_level_updated)
	end)
end

function meta:AddExp(exp)
	exp = hook.Run("RLS.UpdateExpAmount", self, exp) or exp

	self:SetExp(self:GetExp() + exp)
end

function meta:IsPassedLevel(func)
	local cur_exp, need_exp = self:GetExp(), self:GetNeedExp()
	local is_level_updated = false
	if cur_exp >= need_exp then
		self:AddLevel(1)
		self:SetExp(cur_exp-need_exp)
		is_level_updated = true
	end
	if func then func(is_level_updated) end
end

function meta:SyncRLS()
	MySQLite.query(string.format([[
			UPDATE r_level_system
			SET level = %d,
			exp = %d
			WHERE steamid = %s;
		]],
		self:GetLevel(),
		self:GetExp(),
		MySQLite.SQLStr(self:SteamID())
	))
end

/*
	Commands stuff
*/

concommand.Add("r", function(ply, cmd, args)

	if not RLS.CommandsAccess[ply:GetUserGroup()] then
		RLS:Notify(ply, "You don't have rights to use that commands!")
		return
	end


	local target = RLS:FindPlayer(args[2])
	local value = tonumber(args[3])

	if not target or not value then
		RLS:Notify(ply, "Not enough arguments! Command syntax: !command <player name> <level>")
		return
	end

	local t_name = target:Name()

	if args[1] == "setlevel" then

		target:SetLevel(value)
		RLS.CommandNotify(ply, "set", value, "level(s) for", t_name)
	elseif args[1] == "addlevel" then

		target:AddLevel(value)
		RLS.CommandNotify(ply, "added", value, "level(s) for", t_name)
	elseif args[1] == "setexp" then

		target:SetExp(value)
		RLS.CommandNotify(ply, "set", value, "exp for", t_name)
	elseif args[1] == "addexp" then

		target:AddExp(value)
		RLS.CommandNotify(ply, "add", value, "exp for", t_name)
	end
end)

hook.Add("PlayerSay", "RLS.PlayerSay", function(ply, text)
	local args = string.Explode(" ", text)

	if args[1] == RLS.SetLevelCommand then
		RLS:SendCommand(ply, 'setlevel', args[2], args[3])
		return ""
	elseif args[1] == RLS.AddLevelCommand then
		RLS:SendCommand(ply, 'addlevel', args[2], args[3])
		return ""
	elseif args[1] == RLS.SetExpCommand then
		RLS:SendCommand(ply, 'setexp', args[2], args[3])
		return ""
	elseif args[1] == RLS.AddExpCommand then
		RLS:SendCommand(ply, 'addexp', args[2], args[3])
		return ""
	end
end)

/*
	Util stuff
*/

function RLS:SendCommand(ply, command, target, value)
	ply:ConCommand(string.format("r %s %s %s", command, target, value))
end
