local config = {}

config.WhoReceiveDubleExp = { -- setup multiplyer for each rank
	["founder"] = 2,
	["superadmin"] = 1.5,
}

hook.Add("RLS.UpdateExpAmount", "RLS.double_exp", function(ply, exp)
	local multiplyer = config.WhoReceiveDubleExp[ply:GetUserGroup()] or 1

	return exp * multiplyer
end)
