local config = {}

config.EarnForKillingPlayer = 15
config.message = "You got %d for killing player!" -- %d - is how much player recieves exp

hook.Add( "PlayerDeath", "RLS.killing_player.PlayerDeath", function(victim, weapon, killer)
	if killer:IsPlayer() and victim ~= killer then 
		killer:AddExp(config.EarnForKillingPlayer)
		RLS:Notify(killer, string.format(config.message, config.EarnForKillingPlayer))
	end	
end)
