local config = {}

config.message_style = 1 -- 1 - Default RLS chat notify, 2 - DarkRP notify
config.shop_message = "You need to have %d level to buy it!" -- %d is level required
config.job_message = "You need to have %d level to take this job!" -- %d is level required

config.AddLevelToItemsNames = true -- Adds name - Level 100 to names of item

local function CheckLevel(ply, ent)

	if ent.level and ent.level > ply:GetLevel() then
		
		if config.message_style == 1 then
			RLS:Notify(ply, string.format(config.message, ent.level))
		elseif config.message_style == 2 then
			DarkRP.notify(ply, NOTIFY_ERROR, 2, string.format(config.message, ent.level))
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

	job = RPExtraTeams[job]

	if job.level and job.level > ply:GetLevel() then
			
		if config.message_style == 1 then
			RLS:Notify(ply, string.format(config.message, job.level))
		elseif config.message_style == 2 then
			DarkRP.notify(ply, NOTIFY_ERROR, 2, string.format(config.message, job.level))
		end

		return false, true
	end
end)


local function LevelInItemsLabel()

	if not config.AddLevelToItemsNames then return end

	for k,v in pairs(DarkRPEntities) do
		if not v.level then continue end
		v.name = (v.name .. ' - Level '..v.level)
	end

	for k,v in pairs(RPExtraTeams) do
		if not v.level then continue end
		v.name = (v.name .. ' - Level '..v.level)
	end

	for k,v in pairs(CustomVehicles) do
		if not v.level then continue end
		v.name = (v.name .. ' - Level '..v.level)
	end

	for k,v in pairs(CustomShipments) do
		if not v.level then continue end
		v.name = (v.name .. ' - Level '..v.level)
	end

	local gm = GM and GM or GAMEMODE

	for k,v in pairs(gm.AmmoTypes) do
		if not v.level then continue end
		v.name = (v.name .. ' - Level '..v.level)
	end

end

hook.Add("OnReloaded", "RLS.darkrp_integration.OnReloaded", LevelInItemsLabel)
hook.Add("loadCustomDarkRPItems", "RLS.darkrp_integration.loadCustomDarkRPItems", LevelInItemsLabel)
