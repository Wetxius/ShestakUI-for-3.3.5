local db = SettingsCF["unitframe"]
local floor, format, insert, sort = math.floor, string.format, table.insert, table.sort

local SetStyle = function(self, unit)
	local unit = (self:GetParent():GetName():match"oUF_PartyDPS") and "party" 
	or (self:GetParent():GetName():match"oUF_RaidDPS") and "raid"
	or (self:GetParent():GetName():match"oUF_MainTank") and "tank" or unit
	
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
	if self:GetAttribute("unitsuffix") == "target" or self:GetAttribute("unitsuffix") == "pet" then
		self:SetAttribute("initial-height", 27)
		self:SetAttribute("initial-width", 30)
	elseif unit == "raid" then
		self:SetAttribute("initial-height", 17)
		self:SetAttribute("initial-width", 104)
	elseif unit == "party" then
		self:SetAttribute("initial-height", 27)
		self:SetAttribute("initial-width", 140)
	else
		self:SetAttribute("initial-height", 20)
		self:SetAttribute("initial-width", 108)
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
	if (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") then
		self.Health:SetHeight(27)
	elseif unit == "raid" then
		self.Health:SetHeight(15)
	elseif unit == "party" then
		self.Health:SetHeight(21)
	else
		self.Health:SetHeight(17)
	end
	self.Health:SetStatusBarTexture(SettingsCF["media"].texture)

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
	
	if not (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") then
		self.Health.value = self.Health:CreateFontString(nil, "OVERLAY")
		self.Health.value:SetPoint("RIGHT", self.Health, "RIGHT", 0, 1)
		self.Health.value:SetFont(SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
		self.Health.value:SetTextColor(1, 1, 1)
		self.Health.value:SetShadowOffset(0, 0)
		
		self.Health.PostUpdate = PostUpdateRaidHealth
	end
	
	if not (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") then
		-- Power bar
		self.Power = CreateFrame("StatusBar", nil, self)
		if unit == "raid" then
			self.Power:SetHeight(1)
		elseif unit == "party" then
			self.Power:SetHeight(5)
		else
			self.Power:SetHeight(2)
		end
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
	if (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") then
		self.Info:SetPoint("CENTER", self.Health, "CENTER", 1, 0)
	else
		self.Info:SetPoint("LEFT", self.Health, "LEFT", 2, 1)
		self.Info:SetJustifyH("LEFT")
	end
	self.Info:SetFont(SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
	self.Info:SetShadowOffset(0, 0)
	if self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target" then
		self:Tag(self.Info, "[GetNameColor][NameArena]")
	else
		self:Tag(self.Info, "[GetNameColor][NameShort]")
	end
	
	-- LFD role icons
	if db.icons_lfd_role == true and not (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") then
		self.LFDRole = self.Health:CreateTexture(nil, "OVERLAY")
		self.LFDRole:SetHeight(12)
		self.LFDRole:SetWidth(12)
		self.LFDRole:SetPoint("TOPRIGHT", 2, 5)
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
		
		-- Master looter
		self.MasterLooter = self.Health:CreateTexture(nil, "OVERLAY")
		self.MasterLooter:SetHeight(11)
		self.MasterLooter:SetWidth(11)
		self.MasterLooter:SetPoint("TOPRIGHT", 3, 8)
	end
	
	-- Agro border
	if db.aggro_border == true then
		table.insert(self.__elements, UpdateThreat)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", UpdateThreat)
    end
	
	-- Raid marks
	if db.icons_raid_mark == true then
		self.RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:SetHeight(12)
		self.RaidIcon:SetWidth(12)
		self.RaidIcon:SetPoint("CENTER", self, "TOP")
	end
	
	-- Ready check icons
	if db.icons_ready_check == true then
		self.ReadyCheck = self.Health:CreateTexture(nil, "OVERLAY")
		self.ReadyCheck:SetHeight(12)
		self.ReadyCheck:SetWidth(12)
		self.ReadyCheck:SetPoint("BOTTOMRIGHT", 2, -1)
	end
	
	if unit == "party" and (not (self:GetAttribute("unitsuffix") == "target")) and (not (self:GetAttribute("unitsuffix") == "pet")) then
		self.Debuffs = CreateFrame("Frame", nil, self)
		self.Debuffs:SetPoint("TOPLEFT", self, "BOTTOMLEFT", -2, -5)
		self.Debuffs:SetHeight(18)
		self.Debuffs:SetWidth(144)
		self.Debuffs.size = 18
		self.Debuffs.spacing = 3
		self.Debuffs.initialAnchor = "LEFT"
		self.Debuffs.num = 7
		self.Debuffs["growth-y"] = "DOWN"
		self.Debuffs["growth-x"] = "RIGHT"
		self.Debuffs.PostCreateIcon = PostCreateAura
		self.Debuffs.PostUpdateIcon = PostUpdateIcon
	end
	
	-- Debuff highlight
	self.DebuffHighlight = self.Health:CreateTexture(nil, "OVERLAY")
	self.DebuffHighlight:SetAllPoints(self.Health)
	self.DebuffHighlight:SetTexture(SettingsCF["media"].highlight)
	self.DebuffHighlight:SetVertexColor(0, 0, 0, 0)
	self.DebuffHighlight:SetBlendMode("ADD")
	self.DebuffHighlightAlpha = 1
	self.DebuffHighlightFilter = true
	
	-- Range alpha
	if db.show_range == true and (not (self:GetAttribute("unitsuffix") == "target")) then
		self.Range = {insideAlpha = 1, outsideAlpha = db.range_alpha}
	end
	
	-- Smooth bars
	if db.plugins_smooth_bar == true then
		self.Health.Smooth = true
		if not (self:GetAttribute("unitsuffix") == "pet" or self:GetAttribute("unitsuffix") == "target") then
			self.Power.Smooth = true
		end
	end
	
	self:RegisterEvent("UNIT_PET", updateAllElements)
	
	return self
end

----------------------------------------------------------------------------------------
--	Default position of ShestakUI unitframes
----------------------------------------------------------------------------------------
oUF:RegisterStyle("ShestakDPS", SetStyle)
oUF:SetActiveStyle("ShestakDPS")
local party = oUF:SpawnHeader("oUF_PartyDPS", nil, "custom [@raid6,exists] hide;show",
	"showSolo", db.solo_mode,
	"showPlayer", db.player_in_party, 
	"showParty", true,
	"showRaid", true,	
	"yOffset", 28,
	"point", "BOTTOM",
	"template", "oUF_PartyV"
)
party:SetPoint(unpack(SettingsCF["position"].unitframes.party_dps))

if db.show_raid == true then
	local raid = oUF:SpawnHeader("oUF_RaidDPS", nil, "custom [@raid6,exists] show;hide",
		"showRaid", true, 
		"yOffset", -7,
		"point", "TOP",
		"groupFilter", "1,2,3,4",
		"groupingOrder", "1,2,3,4",
		"groupBy", "GROUP"
	)

	raid:SetPoint(unpack(SettingsCF["position"].unitframes.raid_dps))

	local raid2 = oUF:SpawnHeader("oUF_RaidDPS2", nil, "custom [@raid21,exists] show;hide",
		"showRaid", true, 
		"yOffset", -7,
		"point", "TOP",
		"groupFilter", "5,6,7,8",
		"groupingOrder", "5,6,7,8",
		"groupBy", "GROUP"
	)

	raid2:SetPoint("TOPLEFT", "oUF_RaidDPS", "TOPRIGHT", 7, 0)
end