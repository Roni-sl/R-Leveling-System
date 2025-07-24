surface.CreateFont("RLS.MainFont", { font = "Roboto", size = 20, weight = 500, extended = true })

function RLS:DrawShadowText(text, font, x, y, color, tha, tva, shadow_color)
	shadow_color = shadow_color and shadow_color or Color(0,0,0)
	draw.SimpleText(text, font, x+1, y+1, shadow_color, tha, tva)
	draw.SimpleText(text, font, x, y, color, tha, tva)
end

local function SmoothApproach(current, target, frame_time)
	return math.Approach(
    current,
    target,
    math.Clamp(
      math.abs(target - current) * frame_time * 4, frame_time * 2, frame_time * 20000
    )
  )
end

local exp, need_exp, level = 0, 0, 0
hook.Add("HUDPaint", "RLS.HUDPaint", function()
	if not RLS.EnableHUD then return end

	-- Screen and HUD positioning
	local screenWidth, screenHeight = ScrW(), ScrH()
	local hudWidth = screenWidth / 3
	local hudX = hudWidth
	local hudY = RLS.HUDHeight
	local barHeight = 3

	-- Smoothly approach current values
	exp = SmoothApproach(exp, LocalPlayer():GetExp(), FrameTime())
	need_exp = SmoothApproach(need_exp, LocalPlayer():GetNeedExp(), FrameTime())
	level = SmoothApproach(level, LocalPlayer():GetLevel(), FrameTime())

	-- Draw background bar
	draw.RoundedBox(0, hudX, hudY, hudWidth, barHeight, Color(0,0,0,150))

	-- Draw experience progress bar (guard against division by zero)
	local progress = (need_exp > 0) and (exp / need_exp) or 0
	draw.RoundedBox(0, hudX, hudY, hudWidth * progress, barHeight, color_white)

	-- Draw level and experience text
	RLS:DrawShadowText(math.ceil(level).." lvl", "RLS.MainFont", hudX+5, hudY-20, color_white, 0, 0)
	RLS:DrawShadowText(math.ceil(progress*100).."% ("..math.ceil(exp).."/"..math.ceil(need_exp).." exp)", "RLS.MainFont", hudX+hudWidth-5, hudY-20, color_white, 2, 0)
end)
