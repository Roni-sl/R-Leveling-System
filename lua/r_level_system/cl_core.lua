surface.CreateFont("RLS.MainFont", { font = "Roboto", size = 20, weight = 500, extended = true })

function RLS:DrawShadowText(text, font, x, y, color, tha, tva, shadow_color)
    shadow_color = shadow_color and shadow_color or Color(0,0,0)
    draw.SimpleText(text, font, x+1, y+1, shadow_color, tha, tva)
    draw.SimpleText(text, font, x, y, color, tha, tva)
end

local exp, need_exp, level = 0, 0, 0
hook.Add("HUDPaint", "RLS.HUDPaint", function()
    if not RLS.EnableHUD then return end

    local scr_w, scr_h = ScrW(), ScrH()
    local x, y = scr_w/3, 30
    local w, h = x, 2

    exp = math.Approach(
        exp, LocalPlayer():GetExp(),
        math.Clamp(
            math.abs((LocalPlayer():GetExp() - exp) * FrameTime() * 4),
            FrameTime() * 2,
            FrameTime() * 20000
        )
    )

    need_exp = math.Approach(
        need_exp, LocalPlayer():GetNeedExp(),
        math.Clamp(
            math.abs((LocalPlayer():GetNeedExp() - need_exp) * FrameTime() * 4),
            FrameTime() * 2,
            FrameTime() * 20000
        )
    )

    level = math.Approach(
        level, LocalPlayer():GetLevel(),
        math.Clamp(
            math.abs((LocalPlayer():GetLevel() - level) * FrameTime() * 4),
            FrameTime() * 2,
            FrameTime() * 20000
        )
    )

    draw.RoundedBox(0, w, y, w, 3, Color(0,0,0,150))
    draw.RoundedBox(0, w, y, w*(exp/need_exp), 3, color_white)

    RLS:DrawShadowText(math.ceil(level).." lvl", "RLS.MainFont", x+5, y-20, color_white, 0, 0)
    RLS:DrawShadowText(math.ceil(exp/need_exp*100).."% ("..math.ceil(exp).."/"..math.ceil(need_exp).." exp)", "RLS.MainFont", x*2-5, y-20, color_white, 2, 0)
end)
