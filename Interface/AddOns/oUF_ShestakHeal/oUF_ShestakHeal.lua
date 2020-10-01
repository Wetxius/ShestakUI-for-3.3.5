local db = SettingsCF["unitframe"]
local pos = SettingsCF["position"].unitframes
local floor, format, insert, sort = math.floor, string.format, table.insert, table.sort

local ShortValue = function(value)
	if value >= 1e6 then
		return ("%.1fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e3 or value <= -1e3 then
		return ("%.1fk"):format(value / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return value
	end
end

local countOffsets = {
	TOPLEFT = {6, 1},
	TOPRIGHT = {-6, 1},
	BOTTOMLEFT = {6, 1},
	BOTTOMRIGHT = {-6, 1},
	LEFT = {6, 1},
	RIGHT = {-6, 1},
	TOP = {0, 0},
	BOTTOM = {0, 0},
}

local auraWatchIcon = function(element, icon)
	SettingsDB.CreateTemplate(icon)
	if (icon.cd) then
		icon.cd:SetReverse()
	end
end

local createAuraWatch = function(self, unit)
	local auras = CreateFrame("Frame", nil, self)
	auras:SetPoint("TOPLEFT", self.Health, 0, 0)
	auras:SetPoint("BOTTOMRIGHT", self.Health, 0, 0)
	auras.presentAlpha = 1
	auras.missingAlpha = 0
	auras.icons = {}
	auras.PostCreateIcon = auraWatchIcon
	
	local buffs = {}
	
	if (SettingsDB.buffids["ALL"]) then
		for key, value in pairs(SettingsDB.buffids["ALL"]) do
			tinsert(buffs, value)
		end
	end
	
	if (SettingsDB.buffids[SettingsDB.myclass]) then
		for key, value in pairs(SettingsDB.buffids[SettingsDB.myclass]) do
			tinsert(buffs, value)
		end
	end
	
	if (buffs) then
		for key, spell in pairs(buffs) do
			local icon = CreateFrame("Frame", nil, auras)
			icon.spellID = spell[1]
			icon.anyUnit = spell[4]
			icon:SetWidth(6)
			icon:SetHeight(6)
			icon:SetPoint(spell[2], 0, 0)
			
			local tex = icon:CreateTexture(nil, "OVERLAY")
			tex:SetAllPoints(icon)
			tex:SetTexture(SettingsCF["media"].blank)
			if (spell[3]) then
				tex:SetVertexColor(unpack(spell[3]))
			else
				tex:SetVertexColor(0.8, 0.8, 0.8)
			end
			
			local count = icon:CreateFontString(nil, "OVERLAY")
			count:SetFont(SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
			count:SetPoint("CENTER", unpack(countOffsets[spell[2]]))
			icon.count = count
			
			auras.icons[spell[1]] = icon
		end
	end
	
	self.AuraWatch = auras
end

local SetStyle = function(self, unit)
	-- Set our own colors
	self.colors = SetColors
	
	-- Register click
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	
	-- Menu
	self.menu = SpawnMenu
	self:SetAttribute("type2", "menu")

	-- Width and height
	if (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") and not (self:GetParent():GetName():match"oUF_MainTank") then
		self:SetAttribute("initial-height", 14)
		self:SetAttribute("initial-width", 60.2)
	else
		self:SetAttribute("initial-height", 26)
		self:SetAttribute("initial-width", 60.2)
	end
	
	-- Backdrop for every units
	self.FrameBackdrop = CreateFrame("Frame", nil, self)
	SettingsDB.CreateTemplate(self.FrameBackdrop)
	self.FrameBackdrop:SetFrameStrata("BACKGROUND")
	self.FrameBackdrop:SetPoint("TOPLEFT", -2, 2)
	self.FrameBackdrop:SetPoint("BOTTOMRIGHT", 2, -2)
	
	-- Health bar
	self.Health = CreateFrame("StatusBar", nil, self)
	self.Health:SetPoint("TOPLEFT")
	self.Health:SetPoint("TOPRIGHT")
	if (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") and not (self:GetParent():GetName():match"oUF_MainTank") then
		self.Health:SetHeight(14)
	else
		self.Health:SetHeight(23)
	end
	self.Health:SetStatusBarTexture(SettingsCF["media"].texture)
	
	if db.vertical_health == true then
		self.Health:SetOrientation("VERTICAL")
	end
	
	self.Health.frequentUpdates = true
	self.Health.colorTapping = true
	self.Health.colorDisconnected = true
	self.Health.colorClassPet = false
	if db.own_color == true then
		self.Health.colorReaction = false
		self.Health.colorClass = false
		self.Health:SetStatusBarColor(unpack(SettingsCF["media"].uf_color))
	else
		self.Health.colorReaction = true
		self.Health.colorClass = true
	end
	
	-- Health bar background
	self.Health.bg = self.Health:CreateTexture(nil, "BORDER")
	self.Health.bg:SetAllPoints(self.Health)
	self.Health.bg:SetTexture(SettingsCF["media"].texture)
	if db.own_color == true then
		self.Health.bg:SetVertexColor(0.1, 0.1, 0.1)	
	else
		self.Health.bg.multiplier = 0.25
	end
	
	if not (self:GetAttribute("unitsuffix") == "pet" or (self:GetAttribute("unitsuffix") == "target" and not (self:GetParent():GetName():match"oUF_MainTank"))) then
		self.Health.value = self.Health:CreateFontString(nil, "OVERLAY")
		self.Health.value:SetPoint("CENTER", self.Health, "CENTER", 0, -5)
		self.Health.value:SetFont(SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
		self.Health.value:SetTextColor(1, 1, 1)
		self.Health.value:SetShadowOffset(0, 0)
		
		self.Health.PostUpdate = PostUpdateRaidHealth

		-- Power bar
		self.Power = CreateFrame("StatusBar", nil, self)
		self.Power:SetHeight(2)
		self.Power:SetPoint("TOPLEFT", self.Health, "BOTTOMLEFT", 0, -1)
		self.Power:SetPoint("TOPRIGHT", self.Health, "BOTTOMRIGHT", 0, -1)
		self.Power:SetStatusBarTexture(SettingsCF["media"].texture)

		self.Power.frequentUpdates = true
		self.Power.colorDisconnected = true
		if db.own_color == true then
			self.Power.colorClass = true
		else
			self.Power.colorPower = true
		end

		-- Power bar background
		self.Power.bg = self.Power:CreateTexture(nil, "BORDER")
		self.Power.bg:SetAllPoints(self.Power)
		self.Power.bg:SetTexture(SettingsCF["media"].texture)
		self.Power.bg:SetAlpha(1)
		self.Power.bg.multiplier = 0.3
	end
	
	-- Names
	self.Info = self.Health:CreateFontString(nil, "OVERLAY")
	if (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") and not (self:GetParent():GetName():match"oUF_MainTank") then
		self.Info:SetPoint("CENTER", self.Health, "CENTER", 0, 1)
	else
		self.Info:SetPoint("CENTER", self.Health, "CENTER", 0, 4)
	end
	self.Info:SetFont(SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
	self:Tag(self.Info, "[GetNameColor][NameShort]")
	
	-- Agro border
    if db.aggro_border == true then
		table.insert(self.__elements, UpdateThreat)
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA", UpdateThreat)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", UpdateThreat)
	end
	
	-- Raid marks
	if db.icons_raid_mark == true then
		self.RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:SetHeight(12)
		self.RaidIcon:SetWidth(12)
		self.RaidIcon:SetPoint("BOTTOMLEFT", -2, -5)
	end
	
	-- LFD role icons
	if db.icons_lfd_role == true and not (self:GetAttribute("unitsuffix") == "target") then 
		self.LFDRole = self.Health:CreateTexture(nil, "OVERLAY")
		self.LFDRole:SetHeight(12)
		self.LFDRole:SetWidth(12)
		self.LFDRole:SetPoint("TOP", 0, 8)
	end
	
	-- Ready check icons
	if db.icons_ready_check == true and not (self:GetAttribute("unitsuffix") == "target") then
		self.ReadyCheck = self.Health:CreateTexture(nil, "OVERLAY")
		self.ReadyCheck:SetHeight(12)
		self.ReadyCheck:SetWidth(12)
		self.ReadyCheck:SetPoint("BOTTOMRIGHT", 2, -1)
	end
	
	-- Leader/Assistant/ML icons
	if db.icons_leader == true and not (self:GetAttribute("unitsuffix") == "target") then
		-- Leader icon
		self.Leader = self.Health:CreateTexture(nil, "OVERLAY")
		self.Leader:SetHeight(12)
		self.Leader:SetWidth(12)
		self.Leader:SetPoint("TOPLEFT", -3, 8)
	
		-- Assistant icon
		self.Assistant = self.Health:CreateTexture(nil, "OVERLAY")
		self.Assistant:SetHeight(12)
		self.Assistant:SetWidth(12)
		self.Assistant:SetPoint("TOPLEFT", -3, 8)
		
		-- Master looter icon
		self.MasterLooter = self.Health:CreateTexture(nil, "OVERLAY")
		self.MasterLooter:SetHeight(12)
		self.MasterLooter:SetWidth(12)
		self.MasterLooter:SetPoint("TOPRIGHT", 3, 8)
	end
	
	-- Debuff highlight
	if not (self:GetAttribute("unitsuffix") == "target") then
		self.DebuffHighlight = self.Health:CreateTexture(nil, "OVERLAY")
		self.DebuffHighlight:SetAllPoints(self.Health)
		self.DebuffHighlight:SetTexture(SettingsCF["media"].highlight)
		self.DebuffHighlight:SetVertexColor(0, 0, 0, 0)
		self.DebuffHighlight:SetBlendMode("ADD")
		self.DebuffHighlightAlpha = 1
		self.DebuffHighlightFilter = true
	end
	
	-- Incoming heal text/bar
	if IsAddOnLoaded("oUF_HealComm4") and db.plugins_healcomm == true then
		if db.plugins_healcomm_bar == true then
			self.HealCommBar = CreateFrame("StatusBar", nil, self.Health)
			self.HealCommBar:SetHeight(0)
			self.HealCommBar:SetWidth(0)
			self.HealCommBar:SetStatusBarTexture(self.Health:GetStatusBarTexture():GetTexture())
			self.HealCommBar:SetStatusBarColor(0, 1, 0, 0.35)
			self.HealCommBar:SetPoint("LEFT", self.Health, "LEFT")
		end
		if db.plugins_healcomm_text == true then
			self.HealCommText = self.Health:CreateFontString(self.Health, "OVERLAY")
			self.HealCommText:SetFont(SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
			self.HealCommText:SetTextColor(0, 1, 0)
			self.HealCommText:SetPoint("CENTER", self.Health, 0, 10)
			self.HealCommTextFormat = ShortValue
		end	
		self.allowHealCommOverflow = db.plugins_healcomm_over
		self.HealCommOthersOnly = db.plugins_healcomm_others
	end
	
	-- Support oUF_ResComm
	if IsAddOnLoaded("oUF_ResComm") then
		self.ResComm = self.Health:CreateTexture(nil, "OVERLAY")
		self.ResComm:SetTexture([[Interface\Icons\Spell_Holy_Resurrection]])
		self.ResComm:SetAllPoints(self.Health)
		self.ResComm:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		self.ResComm:SetBlendMode("ADD")
		self.ResComm:SetAlpha(.25)
		self.ResComm.OthersOnly = true
	end

	-- Range alpha
	if db.show_range == true and not (self:GetAttribute("unitsuffix") == "target") then
		self.Range = {insideAlpha = 1, outsideAlpha = db.range_alpha}
	end
	
	-- Smooth bars
	if db.plugins_smooth_bar == true then
		self.Health.Smooth = true
		if not (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") then
			self.Power.Smooth = true
		end
	end

	if db.plugins_aura_watch == true and not (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") then
		-- Classbuffs
		createAuraWatch(self,unit)
		
		-- Raid debuffs
		self.RaidDebuffs = CreateFrame("Frame", nil, self)
		self.RaidDebuffs:SetHeight(19)
		self.RaidDebuffs:SetWidth(19)
		self.RaidDebuffs:SetPoint("CENTER", self, 0, 2)
		self.RaidDebuffs:SetFrameStrata("HIGH")
		SettingsDB.CreateTemplate(self.RaidDebuffs)

		self.RaidDebuffs.icon = self.RaidDebuffs:CreateTexture(nil, "OVERLAY")
		self.RaidDebuffs.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		self.RaidDebuffs.icon:SetPoint("TOPLEFT", 2, -2)
		self.RaidDebuffs.icon:SetPoint("BOTTOMRIGHT", -2, 2)
		
		if db.aura_show_spiral == true then
			self.RaidDebuffs.cd = CreateFrame("Cooldown", nil, self.RaidDebuffs)
			self.RaidDebuffs.cd:SetPoint("TOPLEFT", 2, -2)
			self.RaidDebuffs.cd:SetPoint("BOTTOMRIGHT", -2, 2)
			self.RaidDebuffs.cd:SetReverse()
		end

		self.RaidDebuffs.count = self.RaidDebuffs:CreateFontString(nil, "OVERLAY")
		self.RaidDebuffs.count:SetFont(SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
		self.RaidDebuffs.count:SetPoint("BOTTOMRIGHT", self.RaidDebuffs, "BOTTOMRIGHT", 2, 0)
		self.RaidDebuffs.count:SetTextColor(1, 1, 1)
		oUF_RaidDebuffs:RegisterDebuffs(SettingsDB.debuffids)
	end
	
	-- Update script to all elements
	self:RegisterEvent("UNIT_PET", updateAllElements)
	
	return self
end

----------------------------------------------------------------------------------------
--	Default position of ShestakUI unitframes
----------------------------------------------------------------------------------------
oUF:RegisterStyle("ShestakHeal", SetStyle)
oUF:SetActiveStyle("ShestakHeal")
local party = oUF:SpawnHeader("oUF_Party", nil, "custom [@raid6,exists] hide;show",
	"showSolo", db.solo_mode,
	"showPlayer", db.player_in_party, 
	"showParty", true,
	"showRaid", true,			
	"xOffset", 7,
	"point", "LEFT",
	"template", "oUF_PartyH"
)
if db.player_in_party == true then
	party:SetPoint(pos.party_heal[1], pos.party_heal[2], pos.party_heal[3], pos.party_heal[4], pos.party_heal[5])
else
	party:SetPoint(pos.party_heal[1], pos.party_heal[2], pos.party_heal[3], pos.party_heal[4] + 32, pos.party_heal[5])
end

if db.show_raid == true then
	local raid = oUF:SpawnHeader("oUF_RaidHeal", nil, "custom [@raid6,exists] show;hide",
		"showRaid", true,
		"xoffset", 7,
		"yOffset", -5,
		"point", "LEFT",
		"groupFilter", db.raid_groups,
		"groupingOrder", db.raid_groups,
		"groupBy", "GROUP",
		"maxColumns", 8,
		"unitsPerColumn", 5,
		"columnSpacing", 7,
		"columnAnchorPoint", "TOP"		
	)
	raid:SetPoint(unpack(SettingsCF["position"].unitframes.raid_heal))
	
	if db.raid_tanks == true then
		local raidtank = oUF:SpawnHeader("oUF_MainTank", nil, "raid",
			"showRaid", true,
			"yOffset", -7,
			"groupFilter", "MAINTANK",
			"template", "oUF_MainTank"
		)
		raidtank:SetPoint(unpack(SettingsCF["position"].unitframes.tank))
	end
end