RLS = RLS or {}

-- Thanks aStonedPenguin for solution
local include_sv = (SERVER) and include or function() end
local include_cl = (SERVER) and AddCSLuaFile or include
local include_sh = function(f)
	include_sv(f)
	include_cl(f)
end

-- Libs loading
include_sh("r_libs/mysqlite.lua")

-- System loading
include_sv("r_level_system/mysql_config.lua")
include_sh("r_level_system/config.lua")
include_sh("r_level_system/sh_core.lua")
include_sv("r_level_system/sv_core.lua")
include_cl("r_level_system/cl_core.lua")

-- Modules loading
if not RLS.DisableModules then RLS.DisableModules = {} end
local files, _ = file.Find("r_level_modules/*.lua", "LUA")

for _, f in ipairs(files) do
	if RLS.DisableModules[string.gsub(f, ".lua", "")] then continue end
	include_sh("r_level_modules/"..f)
end
