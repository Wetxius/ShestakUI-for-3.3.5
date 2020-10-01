----------------------------------------------------------------------------------------
--	By Foof and Tohveli
----------------------------------------------------------------------------------------
if SettingsDB.myclass ~= "MAGE" then return end
 
local spells = (UnitFactionGroup("player") == "Horde") and {
		[1] = {53140,53142},	-- Dalaran
		[2] = {3567,11417},		-- Orgrimmar
		[3] = {3563,11418},		-- Undercity
		[4] = {3566,11420},		-- Thunder Bluff
		[5] = {32272,32267},	-- Silvermoon
		[6] = {35715,35717},	-- Shattrath
		[7] = {49358,49361},	-- Stonard
	} or { -- ALLIANCE
		[1] = {53140,53142},	-- Dalaran
		[2] = {3561,10059},		-- Stormwind
		[3] = {3562,11416},		-- Ironforge
		[4] = {3565,11419},		-- Darnassus
		[5] = {32271,32266},	-- Exodar
		[6] = {33690,33691},	-- Shattrath
		[7] = {49359,49360},	-- Theramore
	};

local _, class = UnitClass("player")
local color = RAID_CLASS_COLORS[class]

local f = CreateFrame("Frame", "TeleportMenu", UIParent)
SettingsDB.CreatePanel(f, SettingsCF["minimap"].size + 4, (#spells+1) * 20 + 4, "BOTTOMLEFT", Minimap, "TOPLEFT", -2, 3)
f:SetBackdropBorderColor(0, 0, 0, 0)
f:SetBackdropColor(0, 0, 0, 0)
f:SetFrameStrata("HIGH")

local r = CreateFrame("Frame", nil, f)
SettingsDB.CreatePanel(r, SettingsCF["minimap"].size + 4, 20, "BOTTOMLEFT", f, "BOTTOMLEFT", 0, 0)
r:SetBackdropColor(0, 0, 0, 0.8)
r:SetBackdropBorderColor(color.r, color.g, color.b)

local l = r:CreateFontString("TeleportMenuReagentText", "OVERLAY", nil)
l:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].font_style)
l:SetPoint("CENTER", r, "CENTER")

for i, spell in pairs(spells) do
	local teleport = GetSpellInfo(spell[1])
 
	local b = CreateFrame("Button", nil, f, "SecureActionButtonTemplate")
	SettingsDB.CreatePanel(b, SettingsCF["minimap"].size + 4, 20, "BOTTOMLEFT", f, "BOTTOMLEFT", 0, (i * 21))
	b:SetBackdropColor(0, 0, 0, 0.8)
	b:SetBackdropBorderColor(color.r, color.g, color.b)
 
	local l = b:CreateFontString(nil, "OVERLAY", nil)
	l:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].font_style)
	l:SetText(string.sub(teleport, string.find(teleport,":") + 1))
	b:SetFontString(l)
 
	b:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	b:SetAttribute("type1", "spell")
	b:SetAttribute("spell1", teleport)
	b:SetAttribute("type2", "spell")
	b:SetAttribute("spell2", GetSpellInfo(spell[2]))
end
f:Hide()

local b = CreateFrame("Button", nil, UIParent)
b:SetPoint("TOPLEFT", Minimap, "TOPLEFT")
b:SetWidth(25)
b:SetHeight(25)
b:SetScript("OnClick", function(self)
	if _G["TeleportMenu"]:IsShown() then
		_G["TeleportMenu"]:Hide()
	else
		_G["TeleportMenuReagentText"]:SetText(MINIMAP_TRACKING_VENDOR_REAGENT..": [ "..GetItemCount(17031).." ] | [ "..GetItemCount(17032).." ]")
		_G["TeleportMenu"]:Show()
	end
end)

f:RegisterEvent("UNIT_SPELLCAST_START")
f:SetScript("OnEvent", function(self)
	if self:IsShown() then
		self:Hide()
	end
end)