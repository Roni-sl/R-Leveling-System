local config = {}

config.HowOften = 15 -- in minutes
config.HowMuchExp = 120
config.message = "You got %d for playing on server!" -- %d - is how much player recieves exp

if SERVER then

    hook.Add("PlayerInitialSpawn", "RLS.time_exp.PlayerInitialSpawn", function(ply)
        timer.Create("RLS.time_exp:"..ply:SteamID64(), config.HowOften*60, 0, function()
            if not IsValid(ply) then return end
            ply:AddExp(config.HowMuchExp)
            RLS:Notify(ply, string.format(config.message, config.HowMuchExp))
        end)
    end)

    hook.Add("PlayerDisconnected", "RLS.time_exp.PlayerDisconnected", function(ply)
        timer.Remove("RLS.time_exp:"..ply:SteamID64())
    end)

end
