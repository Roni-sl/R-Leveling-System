local config = {}

config.EarnForKillingPlayer = 15
config.message = "You got %d for killing player!" -- %d - is how much player recieves exp

hook.Add( "PlayerDeath", "RLS.killing_player.PlayerDeath", function(victim, weapon, killer)
	if not killer:IsPlayer() then return end
	if victim == killer then return end

	ply:AddExp(config.EarnForKillingPlayer)
	RLS:Notify(ply, string.format(config.message, config.EarnForKillingPlayer))
end)
