----------------------------------------------------------------------------------------
--	By Foof and Tohveli
----------------------------------------------------------------------------------------
if SettingsDB.myclass ~= "PALADIN" then return end
 
local spells = (UnitFactionGroup("player") == "Horde") and {
		[1] = {20165,20165},
		[2] = {20166,20166},
		[3] = {20164,20164},
		[4] = {21084,21084},
        [5] = {20375,20375},
		[6] = {53736,53736},
	} or { -- ALLIANCE
		[1] = {20165,20165},
		[2] = {20166,20166},
		[3] = {20164,20164},
		[4] = {21084,21084},
        [5] = {20375,20375},
		[6] = {31801,31801}, 
	};

local _, class = UnitClass("player")
local color = RAID_CLASS_COLORS[class]	

local f = CreateFrame("Frame", "SealMenu", UIParent)
SettingsDB.CreatePanel(f, SettingsCF["minimap"].size + 4, #spells * 20 + 4, "BOTTOMLEFT", Minimap, "TOPLEFT", -2, 3)
f:SetBackdropBorderColor(0, 0, 0, 0)
f:SetBackdropColor(0, 0, 0, 0)
f:SetFrameStrata("HIGH")

for i, spell in pairs(spells) do
	local seal = GetSpellInfo(spell[1])
 
	local b = CreateFrame("Button", nil, f, "SecureActionButtonTemplate")
	SettingsDB.CreatePanel(b, SettingsCF["minimap"].size + 4, 20, "BOTTOMLEFT", f, "BOTTOMLEFT", 0, ((i - 1) * 21))
	b:SetBackdropColor(0, 0, 0, 0.8)
	b:SetBackdropBorderColor(color.r, color.g, color.b)
 
	local l = b:CreateFontString(nil, "OVERLAY", nil)
	l:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].font_style)
	l:SetText(seal)
	b:SetFontString(l)
 
	b:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	b:SetAttribute("type1", "spell")
	b:SetAttribute("spell1", seal)
	b:SetAttribute("type2", "spell")
	b:SetAttribute("spell2", GetSpellInfo(spell[2]))
end
f:Hide()

local b = CreateFrame("Button", nil, UIParent)
b:SetPoint("TOPLEFT", Minimap, "TOPLEFT")
b:SetWidth(25)
b:SetHeight(25)
b:SetScript("OnClick", function(self)
	if _G["SealMenu"]:IsShown() then
		_G["SealMenu"]:Hide()
	else
		_G["SealMenu"]:Show()
	end
end)

f:RegisterEvent("UNIT_SPELLCAST_SENT")
f:SetScript("OnEvent", function(self)
	if self:IsShown() then
		self:Hide()
	end
end)