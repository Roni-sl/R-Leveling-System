local config = {}

config.EarnForKillingNPC = 15
config.message = "You got %d for killing NPC!" -- %d - is how much player recieves exp

hook.Add( "OnNPCKilled", "RLS.killing_npc.OnNPCKilled", function(npc, killer, weapon)
    if not killer:IsPlayer() then return end

    ply:AddExp(config.EarnForKillingNPC)
    RLS:Notify(ply, string.format(config.message, config.EarnForKillingNPC))
end)
