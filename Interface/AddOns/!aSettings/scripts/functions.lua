----------------------------------------------------------------------------------------
--	Auto UIScale
----------------------------------------------------------------------------------------
function SettingsDB.UIScale()
	-- High resolution whitelist
	if not (SettingsDB.getscreenresolution == "1680x945"
		or SettingsDB.getscreenresolution == "2560x1440" 
		or SettingsDB.getscreenresolution == "1680x1050" 
		or SettingsDB.getscreenresolution == "1920x1080" 
		or SettingsDB.getscreenresolution == "1920x1200" 
		or SettingsDB.getscreenresolution == "1600x900" 
		or SettingsDB.getscreenresolution == "2048x1152" 
		or SettingsDB.getscreenresolution == "1776x1000" 
		or SettingsDB.getscreenresolution == "2560x1600" 
		or SettingsDB.getscreenresolution == "1600x1200") then
		SettingsDB.lowversion = true		
	end

	if SettingsCF["general"].auto_scale == true then
		SettingsCF["general"].uiscale = 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")
	end
end
SettingsDB.UIScale()

-- Pixel perfect script of custom ui scale
local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/SettingsCF["general"].uiscale
local function scale(x)
    return mult*math.floor(x/mult+.5)
end

function SettingsDB.Scale(x) return scale(x) end
SettingsDB.mult = mult

----------------------------------------------------------------------------------------
--	Template functions
----------------------------------------------------------------------------------------
function SettingsDB.CreateTemplate(f)
	f:SetBackdrop({
		bgFile = SettingsCF["media"].blank, 
		edgeFile = SettingsCF["media"].blank, 
		tile = false, tileSize = 0, edgeSize = mult, 
		insets = {left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	f:SetBackdropColor(unpack(SettingsCF["media"].backdrop_color))
	f:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
end

function SettingsDB.CreateBlizzard(f)
	f:SetBackdrop({
		bgFile = SettingsCF["media"].blank, 
		edgeFile = SettingsCF["media"].blank, 
		tile = false, tileSize = 0, edgeSize = mult, 
		insets = {left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	f:SetBackdropColor(0, 0, 0, 0.8)
	f:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
end

function SettingsDB.CreatePanel(f, w, h, a1, p, a2, x, y)
	sh = scale(h)
	sw = scale(w)
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	f:SetBackdrop({
		bgFile = SettingsCF["media"].blank, 
		edgeFile = SettingsCF["media"].blank, 
		tile = false, tileSize = 0, edgeSize = mult, 
		insets = {left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	f:SetBackdropColor(unpack(SettingsCF["media"].backdrop_color))
	f:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
end

function SettingsDB.CreateOverlay(parent)
	local overlay = CreateFrame("Frame", nil, parent)
	overlay:SetFrameLevel(parent:GetFrameLevel() + 1)
	overlay:SetFrameStrata(parent:GetFrameStrata())
	overlay:SetPoint("TOPLEFT", 3, -3)
	overlay:SetPoint("BOTTOMRIGHT", -3, 3)
	overlay:SetBackdrop({
		bgFile = SettingsCF["media"].blank,
		edgeFile = SettingsCF["media"].blank,
		tile = false, tileSize = 0, edgeSize = mult,
		insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	overlay:SetBackdropColor(unpack(SettingsCF["media"].overlay_color))
	overlay:SetBackdropBorderColor(0, 0, 0, 0)
end

----------------------------------------------------------------------------------------
--	Info text function
----------------------------------------------------------------------------------------
local InfoFrame = CreateFrame("Frame", nil, UIParent)
InfoFrame:SetScript("OnUpdate", FadingFrame_OnUpdate)
InfoFrame.fadeInTime = 0.5
InfoFrame.fadeOutTime = 2
InfoFrame.holdTime = 3
InfoFrame:Hide()

local InfoText = InfoFrame:CreateFontString("InfoText", "OVERLAY")
InfoText:SetFont(SettingsCF["media"].font, 25, "OUTLINE")
InfoText:SetPoint("CENTER", UIParent, "CENTER", 0, 90)
InfoText:SetTextColor(0.41, 0.8, 0.94)

function SettingsDB.InfoTextShow(s)
    InfoText:SetText(s)
    FadingFrame_Show(InfoFrame)
end

----------------------------------------------------------------------------------------
--	Kill object function
----------------------------------------------------------------------------------------
function SettingsDB.Kill(object)
	object.Show = SettingsDB.dummy
	object:Hide()
end