/*
    Meta stuff
*/

local meta = FindMetaTable("Player")

function meta:GetLevel()
    return self:GetNWInt("RLS.Level")
end

function meta:GetExp()
    return self:GetNWInt("RLS.Exp")
end

function meta:GetNeedExp()
	return RLS.Formula(self:GetLevel())
end

/*
    Util stuff
*/

function RLS:FindPlayer(name)
    if name == nil then return false end

    for k, v in pairs(player.GetAll()) do
        if string.find(v:Name(), name, 1, true) then
            return v
        end
    end

    return false
end

local tag = "RLS.SendNotify"

if SERVER then
    util.AddNetworkString(tag)

    function RLS:Notify(target, ...)
        local tbl = { Color(220, 175, 95), "[RLS] ", color_white, ... }
        net.Start(tag)
		net.WriteTable(tbl)
		net.Send(target)
    end

    function RLS:NotifyAll(...)
        local tbl = { Color(220, 175, 95), "[RLS] ", color_white, ... }
        net.Start(tag)
		net.WriteTable(tbl)
		net.Broadcast()
    end

    function RLS.CommandNotify(target, text, value, text2, t_name)
        RLS:Notify(
            target, 
            Color(126, 170, 199), "You ", 
            color_white, text, " ", 
            Color(126, 170, 199), value, 
            color_white, " ", text2, " ", 
            Color(126, 170, 199), t_name
        )
    end
else
    function RLS:Notify(...)
        chat.AddText(Color(221, 227, 108), "[RLS] ", color_white, ...)
    end

    net.Receive(tag, function()
        local data = net.ReadTable()
        chat.AddText(unpack(data))
    end)
end
