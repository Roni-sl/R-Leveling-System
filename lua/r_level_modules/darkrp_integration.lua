local config = {}

config.message_style = 1 -- 1 - Default RLS chat notify, 2 - DarkRP notify
config.shop_message = "You need to have %d level to buy it!" -- %d is level required
config.job_message = "You need to have %d level to take this job!" -- %d is level required

config.AddLevelToItemsNames = true -- Adds name - Level 100 to names of item

local function CheckLevel(ply, ent)

	if ent.level and ent.level > ply:GetLevel() then
		local msg = config.shop_message
		if ent.job then -- If it's a job, use job_message
			msg = config.job_message
		end
		if config.message_style == 1 then
			RLS:Notify(ply, string.format(msg, ent.level))
		elseif config.message_style == 2 then
			DarkRP.notify(ply, NOTIFY_ERROR, 2, string.format(msg, ent.level))
		end

		return false, true
	end
end

hook.Add('canBuyPistol', 'RLS.darkrp_integration.canBuyPistol', CheckLevel)
hook.Add('canBuyAmmo', 'RLS.darkrp_integration.canBuyAmmo', CheckLevel)
hook.Add('canBuyShipment', 'RLS.darkrp_integration.canBuyShipment', CheckLevel)
hook.Add('canBuyVehicle', 'RLS.darkrp_integration.canBuyVehicle', CheckLevel)
hook.Add('canBuyCustomEntity', 'RLS.darkrp_integration.canBuyCustomEntity', CheckLevel)

hook.Add('playerCanChangeTeam', 'RLS.darkrp_integration.playerCanChangeTeam', function(ply, job)

	if ENPC then return end -- Compitablity with Job System | Job Employer NPCs (https://www.gmodstore.com/market/view/4569)

	local jobTable = istable(job) and job or RPExtraTeams[job]

	if jobTable and jobTable.level and jobTable.level > ply:GetLevel() then
		if config.message_style == 1 then
			RLS:Notify(ply, string.format(config.job_message, jobTable.level))
		elseif config.message_style == 2 then
			DarkRP.notify(ply, NOTIFY_ERROR, 2, string.format(config.job_message, jobTable.level))
		end

		return false, true
	end
end)


local function LevelInItemsLabel()

	if not config.AddLevelToItemsNames then return end

	local function appendLevelSuffix(tbl)
		for k,v in pairs(tbl) do
			if not v.level then continue end
			if not string.EndsWith(v.name, ' - Level '..v.level) then
				v.name = (v.name .. ' - Level '..v.level)
			end
		end
	end

	appendLevelSuffix(DarkRPEntities)
	appendLevelSuffix(RPExtraTeams)
	appendLevelSuffix(CustomVehicles)
	appendLevelSuffix(CustomShipments)

	local gm = GM and GM or GAMEMODE
	appendLevelSuffix(gm.AmmoTypes)

end

hook.Add("OnReloaded", "RLS.darkrp_integration.OnReloaded", LevelInItemsLabel)
hook.Add("loadCustomDarkRPItems", "RLS.darkrp_integration.loadCustomDarkRPItems", LevelInItemsLabel)
