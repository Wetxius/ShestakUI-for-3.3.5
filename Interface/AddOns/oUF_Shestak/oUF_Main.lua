----------------------------------------------------------------------------------------
--	
----------------------------------------------------------------------------------------
local db = SettingsCF["unitframe"]
local pos = SettingsCF["position"].unitframes
local _, class = UnitClass("player")
local r, g, b = unpack(oUF.colors.class[class])

local backdrop = {
	bgFile = SettingsCF["media"].blank,
	insets = {top = -1, left = -1, bottom = -1, right = -1},
}

local runeloadcolors = {
	[1] = {0.69, 0.31, 0.31},
	[2] = {0.69, 0.31, 0.31},
	[3] = {0.33, 0.59, 0.33},
	[4] = {0.33, 0.59, 0.33},
	[5] = {0.31, 0.45, 0.63},
	[6] = {0.31, 0.45, 0.63},
}

local SetStyle = function(self, unit)
	-- Set our own colors
	self.colors = SetColors

	-- Register click
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	
	local unit = (unit and unit:find("arena%dtarget")) and "arenatarget" 
	or (unit and unit:find("arena%d")) and "arena"
	or (unit and unit:find("boss%d")) and "boss" or unit
	
	-- Menu
	self.menu = SpawnMenu
	if (unit == "arena" and db.show_arena == true and unit ~= "arenatarget") or (unit == "boss" and db.show_boss == true) then
		self:SetAttribute("type2", "focus")
	else
		self:SetAttribute("*type2", "menu")
	end
	
	-- Backdrop for every units
	self.FrameBackdrop = CreateFrame("Frame", nil, self)
	SettingsDB.CreateTemplate(self.FrameBackdrop)
	self.FrameBackdrop:SetFrameStrata("BACKGROUND")
	self.FrameBackdrop:SetPoint("TOPLEFT", -2, 2)
	self.FrameBackdrop:SetPoint("BOTTOMRIGHT", 2, -2)

	-- Health bar
	self.Health = CreateFrame("StatusBar", self:GetName().."_Health", self)
	if unit == "player" or unit == "target" or unit == "arena" or unit == "boss" then
		self.Health:SetHeight(21)
	elseif unit == "arenatarget" then
		self.Health:SetHeight(27)
	else
		self.Health:SetHeight(13)
	end
	self.Health:SetPoint("TOPLEFT")
	self.Health:SetPoint("TOPRIGHT")
	self.Health:SetStatusBarTexture(SettingsCF["media"].texture)

	self.Health.frequentUpdates = true
	if db.own_color == true then
		self.Health.colorTapping = false
		self.Health.colorDisconnected = false
		self.Health.colorClass = false
		self.Health.colorReaction = false
		self.Health:SetStatusBarColor(unpack(SettingsCF["media"].uf_color))
	else
		self.Health.colorTapping = true
		self.Health.colorDisconnected = true
		self.Health.colorClass = true
		self.Health.colorReaction = true
	end
	if db.plugins_smooth_bar == true then
		self.Health.Smooth = true
	end
	
	self.Health.PostUpdate = PostUpdateHealth

	-- Health bar background
	self.Health.bg = self.Health:CreateTexture(nil, "BORDER")
	self.Health.bg:SetAllPoints()
	self.Health.bg:SetTexture(SettingsCF["media"].texture)
	if db.own_color == true then
		self.Health.bg:SetVertexColor(0.1, 0.1, 0.1)	
	else
		self.Health.bg.multiplier = 0.25
	end
	
	self.Health.value = SetFontString(self.Health, SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
	if unit == "player" or unit == "pet" or unit == "focus" then
		self.Health.value:SetPoint("RIGHT", self.Health, "RIGHT", 0, 1)
		self.Health.value:SetJustifyH("RIGHT")
	elseif unit == "arena" then
		if db.arena_on_right == true then
			self.Health.value:SetPoint("LEFT", self.Health, "LEFT", 2, 1)
			self.Health.value:SetJustifyH("LEFT")
		else
			self.Health.value:SetPoint("RIGHT", self.Health, "RIGHT", 0, 1)
			self.Health.value:SetJustifyH("RIGHT")
		end
	else
		self.Health.value:SetPoint("LEFT", self.Health, "LEFT", 2, 1)
		self.Health.value:SetJustifyH("LEFT")
	end

	-- Power bar
	self.Power = CreateFrame("StatusBar", self:GetName().."_Power", self)
	if unit == "player" or unit == "target" or unit == "arena" or unit == "boss" then
		self.Power:SetHeight(5)
	elseif unit == "arenatarget" then
		self.Power:SetHeight(0)
	else
		self.Power:SetHeight(2)
	end		
	self.Power:SetPoint("TOPLEFT", self.Health, "BOTTOMLEFT", 0, -1)
	self.Power:SetPoint("TOPRIGHT", self.Health, "BOTTOMRIGHT", 0, -1)
	self.Power:SetStatusBarTexture(SettingsCF["media"].texture)

	self.Power.frequentUpdates = true
	self.Power.colorDisconnected = true
	self.Power.colorTapping = true
	if db.own_color == true then
		self.Power.colorClass = true
	else
		self.Power.colorPower = true
	end
	if db.plugins_smooth_bar == true then
		self.Power.Smooth = true
	end

	self.Power.PreUpdate = PreUpdatePower
	self.Power.PostUpdate = PostUpdatePower
		
	self.Power.bg = self.Power:CreateTexture(nil, "BORDER")
	self.Power.bg:SetAllPoints()
	self.Power.bg:SetTexture(SettingsCF["media"].texture)
	self.Power.bg.multiplier = 0.3
	
	self.Power.value = SetFontString(self.Power, SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
	if unit == "player"then
		self.Power.value:SetPoint("RIGHT", self.Power, "RIGHT", 0, 1)
		self.Power.value:SetJustifyH("RIGHT")
	elseif unit == "arena" then
		if db.arena_on_right == true then
			self.Power.value:SetPoint("LEFT", self.Power, "LEFT", 2, 1)
			self.Power.value:SetJustifyH("LEFT")
		else
			self.Power.value:SetPoint("RIGHT", self.Power, "RIGHT", 0, 1)
			self.Power.value:SetJustifyH("RIGHT")
		end
	elseif unit=="pet" then
		self.Power.value:Hide()
	else
		self.Power.value:SetPoint("LEFT", self.Power, "LEFT", 2, 1)
		self.Power.value:SetJustifyH("LEFT")
	end

	-- Names
	if unit ~= "player" then
		self.Info = SetFontString(self.Health, SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
		if unit ~= "arenatarget" then
			self.Level = SetFontString(self.Power, SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
		end
		if unit == "target" then
			self.Info:SetPoint("RIGHT", self.Health, "RIGHT", 0, 1)
			self:Tag(self.Info, "[GetNameColor][NameLong]")
			self.Level:SetPoint("RIGHT", self.Power, 0, 1)
			self:Tag(self.Level, "[Talents] [cpoints] [Threat] [DiffColor][level][shortclassification]")
		elseif unit == "focus" or unit == "pet" then
			self.Info:SetPoint("LEFT", self.Health, "LEFT", 2, 1)
			self:Tag(self.Info, "[GetNameColor][NameMedium]")
			if unit == pet then
				self:RegisterEvent("UNIT_PET", UpdatePetInfo)
			end
		elseif unit == "arenatarget" then
			self.Info:SetPoint("CENTER", self.Health, "CENTER", 0, 1)
			self:Tag(self.Info, "[GetNameColor][NameArena]")
		elseif unit == "arena" then
			if db.arena_on_right == true then
				self.Info:SetPoint("RIGHT", self.Health, "RIGHT", 0, 1)
				self:Tag(self.Info, "[Talents] [GetNameColor][NameMedium]")
			else
				self.Info:SetPoint("LEFT", self.Health, "LEFT", 2, 1)
				self:Tag(self.Info, "[GetNameColor][NameMedium] [Talents]")
			end
		else
			self.Info:SetPoint("RIGHT", self.Health, "RIGHT", 0, 1)
			self:Tag(self.Info, "[GetNameColor][NameMedium]")
		end
	end

	if unit == "player" then
		-- Combat icon
		if db.icons_combat == true then
			self.Combat = self.Health:CreateTexture(nil, "OVERLAY")
			self.Combat:SetSize(12, 12)
			self.Combat:SetPoint("TOPRIGHT", 4, 8)
			self.Combat:SetTexture("Interface\\CharacterFrame\\UI-StateIcon")
			self.Combat:SetTexCoord(0.58, 0.90, 0.08, 0.41)
		end

		self.FlashInfo = CreateFrame("Frame", "FlashInfo", self)
		self.FlashInfo:SetScript("OnUpdate", UpdateManaLevel)
		self.FlashInfo.parent = self
		self.FlashInfo:SetToplevel(true)
		self.FlashInfo:SetAllPoints(self.Health)

		self.FlashInfo.ManaLevel = SetFontString(self.FlashInfo, SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
		self.FlashInfo.ManaLevel:SetPoint("CENTER", 0, 1)

		-- Resting icon
		if db.icons_resting == true and SettingsDB.mylevel ~= MAX_PLAYER_LEVEL then
			self.Resting = self.Power:CreateTexture(nil, "OVERLAY")
			self.Resting:SetSize(18, 18)
			self.Resting:SetPoint("BOTTOMLEFT", -8, -8)
			self.Resting:SetTexture("Interface\\CharacterFrame\\UI-StateIcon")
			self.Resting:SetTexCoord(0, 0.5, 0, 0.421875)
		end

		-- Leader/Assistant/ML icons
		if db.icons_leader == true then
			-- Leader icon
			self.Leader = self.Health:CreateTexture(nil, "OVERLAY")
			self.Leader:SetSize(14, 14)
			self.Leader:SetPoint("TOPLEFT", -3, 9)

			-- Assistant icon
			self.Assistant = self.Health:CreateTexture(nil, "OVERLAY")
			self.Assistant:SetSize(12, 12)
			self.Assistant:SetPoint("TOPLEFT", -3, 8)

			-- Master looter icon
			self.MasterLooter = self.Health:CreateTexture(nil, "OVERLAY")
			self.MasterLooter:SetHeight(12, 12)
			self.MasterLooter:SetPoint("TOPRIGHT", 3, 8)
		end
		
		-- LFD role icons
		if db.icons_lfd_role == true then 
			self.LFDRole = self.Health:CreateTexture(nil, "OVERLAY")
			self.LFDRole:SetHeight(12)
			self.LFDRole:SetWidth(12)
			self.LFDRole:SetPoint("TOPLEFT", 10, 8)
		end

		-- Rune bar
		if db.plugins_rune_bar == true and SettingsDB.myclass == "DEATHKNIGHT" then
			self.Runes = CreateFrame("Frame", nil, self)
			self.Runes:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
			self.Runes:SetHeight(7)
			self.Runes:SetWidth(217)
			self.Runes:SetBackdrop(backdrop)
			self.Runes:SetBackdropColor(0, 0, 0)

			for i = 1, 6 do
				self.Runes[i] = CreateFrame("StatusBar", self:GetName().."_Runes"..i, self)
				self.Runes[i]:SetSize((217 / 6 - 0.85), 7)
				if (i == 1) then
					self.Runes[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				else
					self.Runes[i]:SetPoint("TOPLEFT", self.Runes[i-1], "TOPRIGHT", 1, 0)
				end
				self.Runes[i]:SetStatusBarTexture(SettingsCF["media"].texture)
				self.Runes[i]:SetStatusBarColor(unpack(runeloadcolors[i]))
				
				self.Runes[i].bg = self.Runes[i]:CreateTexture(nil, "BORDER")
				self.Runes[i].bg:SetAllPoints()
				self.Runes[i].bg:SetTexture(SettingsCF["media"].texture)
				self.Runes[i].bg.multiplier = 0.25
				
				self.Runes[i].FrameBackdrop = CreateFrame("Frame", nil, self.Runes[i])
				SettingsDB.CreateTemplate(self.Runes[i].FrameBackdrop)
				self.Runes[i].FrameBackdrop:SetFrameStrata("BACKGROUND")
				self.Runes[i].FrameBackdrop:SetPoint("TOPLEFT", -2, 2)
				self.Runes[i].FrameBackdrop:SetPoint("BOTTOMRIGHT", 2, -2)
			end
		end

		-- Totem bar
		if db.plugins_totem_bar == true and SettingsDB.myclass == "SHAMAN" then
			self.TotemBar = {}
			self.TotemBar.Destroy = true
			for i = 1, 4 do
				self.TotemBar[i] = CreateFrame("StatusBar", self:GetName().."_TotemBar"..i, self)
				self.TotemBar[i]:SetSize((214 / 4), 7)
				if (i == 1) then
					self.TotemBar[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 7)
				else
					self.TotemBar[i]:SetPoint("TOPLEFT", self.TotemBar[i-1], "TOPRIGHT", 1, 0)
				end
				self.TotemBar[i]:SetStatusBarTexture(SettingsCF["media"].texture)
				self.TotemBar[i]:SetMinMaxValues(0, 1)

				self.TotemBar[i]:SetBackdrop(backdrop)
				self.TotemBar[i]:SetBackdropColor(0, 0, 0)

				self.TotemBar[i].bg = self.TotemBar[i]:CreateTexture(nil, "BORDER")
				self.TotemBar[i].bg:SetAllPoints()
				self.TotemBar[i].bg:SetTexture(SettingsCF["media"].texture)
				self.TotemBar[i].bg.multiplier = 0.25
				
				self.TotemBar[i].FrameBackdrop = CreateFrame("Frame", nil, self.TotemBar[i])
				SettingsDB.CreateTemplate(self.TotemBar[i].FrameBackdrop)
				self.TotemBar[i].FrameBackdrop:SetFrameStrata("BACKGROUND")
				self.TotemBar[i].FrameBackdrop:SetPoint("TOPLEFT", -2, 2)
				self.TotemBar[i].FrameBackdrop:SetPoint("BOTTOMRIGHT", 2, -2)
				
				if db.plugins_totem_bar_name == true then
					self.TotemBar[i].Name = SetFontString(self.TotemBar[i], SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
					self.TotemBar[i].Name:SetPoint("CENTER", self.TotemBar[i], "CENTER", 0, 1)
					self.TotemBar[i].Name:SetTextColor(1, 1, 1)
				end
			end
		end

		-- Druid mana
		if SettingsDB.myclass == "DRUID" then
			CreateFrame("Frame"):SetScript("OnUpdate", function() UpdateDruidMana(self) end)
			self.DruidMana = SetFontString(self.Power, SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
			self.DruidMana:SetTextColor(1, 0.49, 0.04)
		end
		
		-- Experience bar
		if SettingsDB.mylevel ~= MAX_PLAYER_LEVEL and db.plugins_experience_bar == true then
			self.Experience = CreateFrame("StatusBar", self:GetName().."_Experience", self)
			self.Experience:SetHeight(94)
			self.Experience:SetWidth(7)
			self.Experience:SetOrientation("Vertical")
			self.Experience:SetPoint("TOPLEFT", self, "TOPLEFT", -18, 28)
			self.Experience:SetStatusBarTexture(SettingsCF["media"].texture)
			self.Experience:SetStatusBarColor(r, g, b)
			self.Experience:SetBackdrop(backdrop)
			self.Experience:SetBackdropColor(0, 0, 0)
			self.Experience:SetAlpha(0)

			self.Experience:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
			self.Experience:HookScript("OnLeave", function(self) self:SetAlpha(0) end)

			self.Experience.bg = self.Experience:CreateTexture(nil, "BORDER")
			self.Experience.bg:SetAllPoints(self.Experience)
			self.Experience.bg:SetTexture(SettingsCF["media"].texture)
			self.Experience.bg:SetVertexColor(r, g, b, 0.25)

			self.Experience.FrameBackdrop = CreateFrame("Frame", nil, self.Experience)
			SettingsDB.CreateTemplate(self.Experience.FrameBackdrop)
			self.Experience.FrameBackdrop:SetFrameLevel(1)
			self.Experience.FrameBackdrop:SetPoint("TOPLEFT", -2, 2)
			self.Experience.FrameBackdrop:SetPoint("BOTTOMRIGHT", 2, -2)
			
			self.Experience.Tooltip = true
		end
		
		-- Reputation bar
		if db.plugins_reputation_bar == true then
			self.Reputation = CreateFrame("StatusBar", self:GetName().."_Reputation", self)
			self.Reputation:SetHeight(94)
			self.Reputation:SetWidth(7)
			self.Reputation:SetOrientation("Vertical")
			self.Reputation:SetPoint("TOPLEFT", self, "TOPLEFT", -32, 28)
			self.Reputation:SetStatusBarTexture(SettingsCF["media"].texture)
			self.Reputation:SetStatusBarColor(r, g, b)
			self.Reputation:SetBackdrop(backdrop)
			self.Reputation:SetBackdropColor(0, 0, 0)
			self.Reputation:SetAlpha(0)

			self.Reputation:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
			self.Reputation:HookScript("OnLeave", function(self) self:SetAlpha(0) end)

			self.Reputation.bg = self.Reputation:CreateTexture(nil, "BORDER")
			self.Reputation.bg:SetAllPoints(self.Reputation)
			self.Reputation.bg:SetTexture(SettingsCF["media"].texture)
			self.Reputation.bg:SetVertexColor(r, g, b, 0.25)

			self.Reputation.FrameBackdrop = CreateFrame("Frame", nil, self.Reputation)
			SettingsDB.CreateTemplate(self.Reputation.FrameBackdrop)
			self.Reputation.FrameBackdrop:SetFrameLevel(1)
			self.Reputation.FrameBackdrop:SetPoint("TOPLEFT", -2, 2)
			self.Reputation.FrameBackdrop:SetPoint("BOTTOMRIGHT", 2, -2)
			
			self.Reputation.PostUpdate = UpdateReputationColor
			self.Reputation.Tooltip = true
		end
		
		-- Swing bar
		if db.plugins_swing == true then
			self.Swing = CreateFrame("StatusBar", self:GetName().."_Swing", self)
			self.Swing:SetStatusBarTexture(SettingsCF["media"].texture)
			self.Swing:SetStatusBarColor(r, g, b)
			self.Swing:SetHeight(5)
			self.Swing:SetWidth(281)
			self.Swing:SetPoint("BOTTOMLEFT", "oUF_Player", "BOTTOMRIGHT", 35, 23)

			self.Swing.bg = self.Swing:CreateTexture(nil, "BORDER")
			self.Swing.bg:SetAllPoints(self.Swing)
			self.Swing.bg:SetTexture(SettingsCF["media"].texture)
			self.Swing.bg:SetVertexColor(r, g, b, 0.25)

			self.Swing.FrameBackdrop = CreateFrame("Frame", nil, self.Swing)
			SettingsDB.CreateTemplate(self.Swing.FrameBackdrop)
			self.Swing.FrameBackdrop:SetFrameLevel(1)
			self.Swing.FrameBackdrop:SetPoint("TOPLEFT", -2, 2)
			self.Swing.FrameBackdrop:SetPoint("BOTTOMRIGHT", 2, -2)
			
			self.Swing.Text = SetFontString(self.Swing, SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
			self.Swing.Text:SetPoint("CENTER", 0, 1)
			self.Swing.Text:SetTextColor(1, 1, 1)
		end
		
		-- GCD spark
		if db.plugins_gcd == true then
			self.GCD = CreateFrame("Frame", nil, self)
			self.GCD:SetWidth(220)
			self.GCD:SetHeight(3)
			self.GCD:SetFrameStrata("HIGH")
			self.GCD:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 0)

			self.GCD.Color = {1, 1, 1}
			self.GCD.Height = 3
			self.GCD.Width = 4
		end
		self:RegisterEvent("UNIT_PET", updateAllElements)
	end

	if unit == "pet" or unit == "targettarget" or unit == "focus" or unit == "focustarget" then
		self.Debuffs = CreateFrame("Frame", nil, self)
		self.Debuffs:SetHeight(25)
		self.Debuffs:SetWidth(109)
		self.Debuffs.size = 25
		self.Debuffs.spacing = 3
		self.Debuffs.num = 4
		self.Debuffs["growth-y"] = "DOWN"
		if unit == "pet" or unit == "focus" then
			self.Debuffs:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 2, -17)
			self.Debuffs.initialAnchor = "TOPRIGHT"
			self.Debuffs["growth-x"] = "LEFT"
		else
			self.Debuffs:SetPoint("TOPLEFT", self, "BOTTOMLEFT", -2, -17)
			self.Debuffs.initialAnchor = "TOPLEFT"
			self.Debuffs["growth-x"] = "RIGHT"
		end
		self.Debuffs.PostCreateIcon = PostCreateAura
		self.Debuffs.PostUpdateIcon = PostUpdateIcon
	end

	if unit == "player" or unit == "target" then
		if db.portrait_enable == true then
			self.Portrait = CreateFrame("PlayerModel", nil, self)
			self.Portrait:SetHeight(db.portrait_height)
			self.Portrait:SetWidth(db.portrait_width)
			if unit == "player" then
				self.Portrait:SetPoint(unpack(SettingsCF["position"].unitframes.player_portrait))
			elseif unit == "target" then
				self.Portrait:SetPoint(unpack(SettingsCF["position"].unitframes.target_portrait))
				self.Portrait.PostUpdate = PortraitPostUpdate
			end

			self.PortraitOverlay = CreateFrame("StatusBar", self:GetName().."_PortraitOverlay", self.Portrait)
			self.PortraitOverlay:SetFrameLevel(self.PortraitOverlay:GetFrameLevel() - 1)
			SettingsDB.CreateTemplate(self.PortraitOverlay)
			if db.portrait_classcolor_border == true then
				self.PortraitOverlay:SetBackdropBorderColor(r, g, b)
			end
			self.PortraitOverlay:SetPoint("TOPLEFT", -2, 2)
			self.PortraitOverlay:SetPoint("BOTTOMRIGHT", 2, -2)
		end

		if unit == "player" then
			self.Buffs = CreateFrame("Frame", nil, self)
			self.Buffs:SetHeight(53)
			self.Buffs:SetWidth(445)
			self.Buffs.size = 25
			self.Buffs.num = 36
			self.Buffs.spacing = 1
			self.Buffs["spacing-x"] = 3
			self.Buffs["spacing-y"] = 3
			self.Buffs:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -22, -20)
			self.Buffs.initialAnchor = "TOPRIGHT"
			self.Buffs["growth-x"] = "LEFT"
			self.Buffs["growth-y"] = "DOWN"
			self.Buffs.filter = true
			
			self.Buffs.PostCreateIcon = PostCreateAura
			self.Buffs.PostUpdateIcon = PostUpdateIcon

			self.Debuffs = CreateFrame("Frame", nil, self)
			self.Debuffs:SetHeight(165)
			self.Debuffs:SetWidth(221)
			self.Debuffs.size = 25
			self.Debuffs.spacing = 3
			self.Debuffs.initialAnchor = "BOTTOMRIGHT"
			self.Debuffs["growth-y"] = "UP"
			self.Debuffs["growth-x"] = "LEFT"
			if (SettingsDB.myclass == "DEATHKNIGHT" and db.plugins_rune_bar == true) or (SettingsDB.myclass == "SHAMAN" and db.plugins_totem_bar == true) then
				self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19)
			else
				self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 5)
			end
			
			self.Debuffs.PostCreateIcon = PostCreateAura
			self.Debuffs.PostUpdateIcon = PostUpdateIcon
			
			self.Enchant = CreateFrame("Frame", nil, self)
			self.Enchant:SetHeight(25)
			self.Enchant:SetWidth(53)
			self.Enchant:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -22, -76)
			self.Enchant.size = 25
			self.Enchant.spacing = 3
			self.Enchant.initialAnchor = "TOPRIGHT"
			self.Enchant["growth-x"] = "LEFT"
			self.PostCreateEnchantIcon = PostCreateAura
			self.PostUpdateEnchantIcons = CreateEnchantTimer
		end
		
		if unit == "target" then
			self.Auras = CreateFrame("Frame", nil, self)
			self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 5)
			self.Auras.initialAnchor = "BOTTOMLEFT"
			self.Auras["growth-x"] = "RIGHT"
			self.Auras["growth-y"] = "UP"
			self.Auras.numDebuffs = 16
			self.Auras.numBuffs = 32
			self.Auras:SetHeight(165)
			self.Auras:SetWidth(221)
			self.Auras.spacing = 3
			self.Auras.size = 25
			self.Auras.gap = true
			self.Auras.onlyShowPlayer = db.aura_player_aura_only
			self.Auras.PostCreateIcon = PostCreateAura
			self.Auras.PostUpdateIcon = PostUpdateIcon			

			if db.icons_combo_point == true then
				local CPoints = {}
				CPoints.unit = PlayerFrame.unit
				for i = 1, 5 do
					CPoints[i] = CreateFrame("StatusBar", nil, self)
					CPoints[i]:SetHeight(6)
					CPoints[i]:SetWidth(7)
					CPoints[i]:SetStatusBarTexture(SettingsCF["media"].blank)
					if i == 1 then
						CPoints[i]:SetPoint("BOTTOMRIGHT", self, "BOTTOMLEFT", -7, 0)
						CPoints[i]:SetStatusBarColor(0.9, 0.1, 0.1)
					else
						CPoints[i]:SetPoint("BOTTOM", CPoints[i-1], "TOP", 0, 7)
					end
					CPoints[i].overlay = CreateFrame("Frame", nil, CPoints[i])
					SettingsDB.CreateTemplate(CPoints[i].overlay)
					CPoints[i].overlay:SetFrameStrata("BACKGROUND")
					CPoints[i].overlay:SetPoint("TOPLEFT", -2, 2)
					CPoints[i].overlay:SetPoint("BOTTOMRIGHT", 2, -2)
				end
				CPoints[2]:SetStatusBarColor(0.9, 0.1, 0.1)
				CPoints[3]:SetStatusBarColor(0.9, 0.9, 0.1)
				CPoints[4]:SetStatusBarColor(0.9, 0.9, 0.1)
				CPoints[5]:SetStatusBarColor(0.1, 0.9, 0.1)
				self.CPoints = CPoints
				self:RegisterEvent("UNIT_COMBO_POINTS", UpdateCPoints)
			end
		end

		if db.plugins_combat_feedback == true then
			self.CombatFeedbackText = SetFontString(self.Health, SettingsCF["media"].pixel_font, db.font_size * 2, SettingsCF["media"].font_style)
			if db.portrait_enable == true then
				self.CombatFeedbackText:SetPoint("BOTTOM", self.Portrait, "BOTTOM", 0, 0)
				self.CombatFeedbackText:SetParent(self.Portrait)
			else
				self.CombatFeedbackText:SetPoint("CENTER", 0, 1)
			end
		end

		if db.icons_pvp == true then
			self.Status = SetFontString(self.Health, SettingsCF["media"].pixel_font, db.font_size * 2, SettingsCF["media"].font_style)
			self.Status:SetPoint("CENTER", 0, 1)
			self.Status:SetTextColor(0.69, 0.31, 0.31, 0)
			self:Tag(self.Status, "[pvp]")
			
			self:SetScript("OnEnter", function(self) FlashInfo.ManaLevel:Hide() self.Status:SetAlpha(1); UnitFrame_OnEnter(self) end)
			self:SetScript("OnLeave", function(self) FlashInfo.ManaLevel:Show() self.Status:SetAlpha(0); UnitFrame_OnLeave(self) end)
		end
	end

	if db.unit_castbar == true and unit ~= "arenatarget" then
		self.Castbar = CreateFrame("StatusBar", self:GetName().."_Castbar", self)
		self.Castbar:SetStatusBarTexture(SettingsCF["media"].texture, "OVERLAY")
		
		self.Castbar.bg = self.Castbar:CreateTexture(nil, "BORDER")
		self.Castbar.bg:SetAllPoints()
		self.Castbar.bg:SetTexture(SettingsCF["media"].texture)

		self.Castbar.Overlay = CreateFrame("Frame", nil, self.Castbar)
		SettingsDB.CreateTemplate(self.Castbar.Overlay)
		self.Castbar.Overlay:SetFrameStrata("BACKGROUND")
		self.Castbar.Overlay:SetPoint("TOPLEFT", -2, 2)
		self.Castbar.Overlay:SetPoint("BOTTOMRIGHT", 2, -2)
		
		self.Castbar.PostCastStart = PostCastStart
		self.Castbar.PostChannelStart = PostChannelStart

		if unit == "player" then
			if db.castbar_icon == true then
				self.Castbar:SetPoint(pos.player_castbar[1], pos.player_castbar[2], pos.player_castbar[3], pos.player_castbar[4], pos.player_castbar[5])
				self.Castbar:SetWidth(258)
			else
				self.Castbar:SetPoint(pos.player_castbar[1], pos.player_castbar[2], pos.player_castbar[3], pos.player_castbar[4]-23, pos.player_castbar[5])
				self.Castbar:SetWidth(281)
			end
			self.Castbar:SetHeight(16)
		elseif unit == "target" then
			if db.castbar_icon == true then
				if db.plugins_swing == true then
					self.Castbar:SetPoint(pos.target_castbar[1], pos.target_castbar[2], pos.target_castbar[3], pos.target_castbar[4], pos.target_castbar[5])
				else
					self.Castbar:SetPoint(pos.target_castbar[1], pos.target_castbar[2], pos.target_castbar[3], pos.target_castbar[4], pos.target_castbar[5] - 12)
				end
				self.Castbar:SetWidth(258)
			else
				if db.plugins_swing == true then
					self.Castbar:SetPoint(pos.target_castbar[1], pos.target_castbar[2], pos.target_castbar[3], pos.target_castbar[4] + 23, pos.target_castbar[5])
				else
					self.Castbar:SetPoint(pos.target_castbar[1], pos.target_castbar[2], pos.target_castbar[3], pos.target_castbar[4] + 23, pos.target_castbar[5] - 12)
				end
				self.Castbar:SetWidth(281)
			end
			self.Castbar:SetHeight(16)
		elseif unit == "arena" or unit == "boss" then
			self.Castbar:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -7)
			self.Castbar:SetWidth(150)
			self.Castbar:SetHeight(16)
		else
			self.Castbar:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -7)
			self.Castbar:SetWidth(105)
			self.Castbar:SetHeight(5)
		end
		
		if unit == "focus" then
			self.Castbar.Button = CreateFrame("Frame", nil, self.Castbar)
			self.Castbar.Button:SetHeight(65)
			self.Castbar.Button:SetWidth(65)
			self.Castbar.Button:SetPoint(unpack(pos.focus_castbar))
			SettingsDB.CreateTemplate(self.Castbar.Button)

			self.Castbar.Icon = self.Castbar.Button:CreateTexture(nil, "ARTWORK")
			self.Castbar.Icon:SetPoint("TOPLEFT", self.Castbar.Button, 2, -2)
			self.Castbar.Icon:SetPoint("BOTTOMRIGHT", self.Castbar.Button, -2, 2)
			self.Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			
			self.Castbar.Time = SetFontString(self.Castbar, SettingsCF["media"].pixel_font, db.font_size * 2, SettingsCF["media"].font_style)
			self.Castbar.Time:SetParent(self.Castbar.Button)
			self.Castbar.Time:SetPoint("CENTER", self.Castbar.Icon, "CENTER", 0, 1)
			self.Castbar.Time:SetTextColor(1, 1, 1)
			self.Castbar.CustomTimeText = CustomCastTimeText
		end

		if unit == "player" or unit == "target" or unit == "arena" or unit == "boss" then
			self.Castbar.Time = SetFontString(self.Health, SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
			self.Castbar.Time:SetPoint("RIGHT", self.Castbar, "RIGHT", 0, 1)
			self.Castbar.Time:SetTextColor(1, 1, 1)
			self.Castbar.Time:SetJustifyH("RIGHT")
			self.Castbar.CustomTimeText = CustomCastTimeText
			self.Castbar.CustomDelayText = CustomCastDelayText

			self.Castbar.Text = SetFontString(self.Health, SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
			self.Castbar.Text:SetPoint("LEFT", self.Castbar, "LEFT", 2, 1)
			self.Castbar.Text:SetPoint("RIGHT", self.Castbar.Time, "LEFT", -1, 0)
			self.Castbar.Text:SetTextColor(1, 1, 1)
			self.Castbar.Text:SetJustifyH("LEFT")

			self.Castbar:HookScript("OnShow", function() self.Castbar.Text:Show(); self.Castbar.Time:Show() end)
			self.Castbar:HookScript("OnHide", function() self.Castbar.Text:Hide(); self.Castbar.Time:Hide() end)

			if db.castbar_icon == true and unit ~= "arena" then
				self.Castbar.Button = CreateFrame("Frame", nil, self.Castbar)
				self.Castbar.Button:SetHeight(20)
				self.Castbar.Button:SetWidth(20)
				SettingsDB.CreateTemplate(self.Castbar.Button)

				self.Castbar.Icon = self.Castbar.Button:CreateTexture(nil, "ARTWORK")
				self.Castbar.Icon:SetPoint("TOPLEFT", self.Castbar.Button, 2, -2)
				self.Castbar.Icon:SetPoint("BOTTOMRIGHT", self.Castbar.Button, -2, 2)
				self.Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				
				if unit == "player" then
					self.Castbar.Button:SetPoint("RIGHT", self.Castbar, "LEFT", -5, 0)
				elseif unit == "target" then
					self.Castbar.Button:SetPoint("LEFT", self.Castbar, "RIGHT", 5, 0)
				end
			end
			
			if unit == "arena" then
				self.Castbar.Button = CreateFrame("Frame", nil, self.Castbar)
				self.Castbar.Button:SetHeight(20)
				self.Castbar.Button:SetWidth(20)
				SettingsDB.CreateTemplate(self.Castbar.Button)
				self.Castbar.Button:SetPoint("TOPRIGHT", self.Castbar, "TOPLEFT", -5, 2)

				self.Castbar.Icon = self.Castbar.Button:CreateTexture(nil, "ARTWORK")
				self.Castbar.Icon:SetPoint("TOPLEFT", self.Castbar.Button, 2, -2)
				self.Castbar.Icon:SetPoint("BOTTOMRIGHT", self.Castbar.Button, -2, 2)
				self.Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			end

			if unit == "player" and db.castbar_latency == true then
				self.Castbar.SafeZone = self.Castbar:CreateTexture(nil, "ARTWORK")
				self.Castbar.SafeZone:SetTexture(SettingsCF["media"].texture)
				self.Castbar.SafeZone:SetVertexColor(0.69, 0.31, 0.31, 1)

				self.Castbar.Latency = self.Castbar:CreateFontString(nil, "OVERLAY")
				self.Castbar.Latency:SetFont(SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
				self.Castbar.Latency:SetTextColor(1, 1, 1)
				self.Castbar.Latency:SetPoint("RIGHT", self.Castbar, "BOTTOMRIGHT", 0, 1)
				self.Castbar.Latency:SetJustifyH("RIGHT")
				
				self:RegisterEvent("UNIT_SPELLCAST_SENT", function(self, event, caster)
					if (caster == "player" or caster == "vehicle") then
						self.Castbar.castSent = GetTime()
					end
				end)
			end
		end
	end

	if not IsAddOnLoaded("Gladius") then
		if unit == "arena" then
			self.Trinket = CreateFrame("Frame", nil, self)
			self.Trinket:SetHeight(31)
			self.Trinket:SetWidth(31)
			if db.arena_on_right == true then
				self.Trinket:SetPoint("TOPRIGHT", self, "TOPLEFT", -5, 2)
			else
				self.Trinket:SetPoint("TOPLEFT", self, "TOPRIGHT", 5, 2)
			end
			self.Trinket.bg = SettingsDB.CreateTemplate(self.Trinket)
			self.Trinket.trinketUseAnnounce = true
			
			self.AuraTracker = CreateFrame("Frame", nil, self)
			self.AuraTracker:SetWidth(self.Trinket:GetWidth())
			self.AuraTracker:SetHeight(self.Trinket:GetHeight())
			self.AuraTracker:SetPoint("CENTER", self.Trinket, "CENTER")
			self.AuraTracker:SetFrameStrata("HIGH")
			
			self.AuraTracker.icon = self.AuraTracker:CreateTexture(nil, "ARTWORK")
			self.AuraTracker.icon:SetWidth(self.Trinket:GetWidth())
			self.AuraTracker.icon:SetHeight(self.Trinket:GetHeight())
			self.AuraTracker.icon:SetPoint("TOPLEFT", self.Trinket, 2, -2)
			self.AuraTracker.icon:SetPoint("BOTTOMRIGHT", self.Trinket, -2, 2)
			self.AuraTracker.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			
			self.AuraTracker.text = self.AuraTracker:CreateFontString(nil, "OVERLAY")
			self.AuraTracker.text:SetFont(SettingsCF["media"].pixel_font, db.font_size * 2, SettingsCF["media"].font_style)
			self.AuraTracker.text:SetPoint("CENTER", self.AuraTracker, 0, 0)
			self.AuraTracker:SetScript("OnUpdate", updateAuraTrackerTime)
		end
	end
	
	if SettingsDB.myclass == "HUNTER" then
		self:SetAttribute("type3", "spell")
		self:SetAttribute("spell3", GetSpellInfo(34477))
	elseif SettingsDB.myclass == "DRUID" then
		self:SetAttribute("type3", "spell")
		self:SetAttribute("spell3", GetSpellInfo(29166))
	elseif SettingsDB.myclass == "PALADIN" then
		self:SetAttribute("type3", "spell")
		self:SetAttribute("spell3", GetSpellInfo(31789))
	end

	if unit == "player" or unit == "target" then
		self:SetAttribute("initial-height", 27)
		self:SetAttribute("initial-width", 217)
	elseif unit == "arena" or unit == "boss" then
		self:SetAttribute("initial-height", 27)
		self:SetAttribute("initial-width", 150)
	elseif unit == "arenatarget" then
		self:SetAttribute("initial-height", 27)
		self:SetAttribute("initial-width", 30)
	else
		self:SetAttribute("initial-height", 16)
		self:SetAttribute("initial-width", 105)
	end

	if db.aggro_border == true and unit ~= "arenatarget" then
		table.insert(self.__elements, UpdateThreat)
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA", UpdateThreat)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", UpdateThreat)
	end
	
	if db.icons_raid_mark == true then
		self.RaidIcon = self:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:SetParent(self.Health)
		self.RaidIcon:SetSize((unit == "player" or unit == "target") and 15 or 12, (unit == "player" or unit == "target") and 15 or 12)
		self.RaidIcon:SetPoint("TOP", 0, 0)
	end
	
	if unit ~= "arenatarget" then
		self.DebuffHighlight = self.Health:CreateTexture(nil, "OVERLAY")
		self.DebuffHighlight:SetAllPoints(self.Health)
		self.DebuffHighlight:SetTexture(SettingsCF["media"].highlight)
		self.DebuffHighlight:SetVertexColor(0, 0, 0, 0)
		self.DebuffHighlight:SetBlendMode("ADD")
		self.DebuffHighlightAlpha = 1
		self.DebuffHighlightFilter = true
	end
	
	HideAura(self)
	return self
end

----------------------------------------------------------------------------------------
--	Default position of ShestakUI unitframes
----------------------------------------------------------------------------------------
oUF:RegisterStyle("Shestak", SetStyle)
oUF:SetActiveStyle("Shestak")
if SettingsCF["actionbar"].rightbars_three == true then
	oUF:Spawn("player", "oUF_Player"):SetPoint(pos.player[1], pos.player[2], pos.player[3], pos.player[4], pos.player[5])
else
	oUF:Spawn("player", "oUF_Player"):SetPoint(pos.player[1], pos.player[2], pos.player[3], pos.player[4], pos.player[5] + 28)
end
if SettingsCF["actionbar"].rightbars_three == true then
	oUF:Spawn("target", "oUF_Target"):SetPoint(pos.target[1], pos.target[2], pos.target[3], pos.target[4], pos.target[5])
else
	oUF:Spawn("target", "oUF_Target"):SetPoint(pos.target[1], pos.target[2], pos.target[3], pos.target[4], pos.target[5] + 28)
end
oUF:Spawn("pet", "oUF_Pet"):SetPoint(unpack(SettingsCF["position"].unitframes.pet))
oUF:Spawn("focus", "oUF_Focus"):SetPoint(unpack(SettingsCF["position"].unitframes.focus))
oUF:Spawn("focustarget", "oUF_FocusTarget"):SetPoint(unpack(SettingsCF["position"].unitframes.focus_target))
oUF:Spawn("targettarget", "oUF_TargetTarget"):SetPoint(unpack(SettingsCF["position"].unitframes.target_target))

if db.show_boss then
	local boss = {}
	for i = 1, MAX_BOSS_FRAMES do
		boss[i] = oUF:Spawn("boss"..i, "oUF_Boss"..i)
		if i == 1 then
			boss[i]:SetPoint(unpack(SettingsCF["position"].unitframes.boss))
		else
			boss[i]:SetPoint("BOTTOM", boss[i-1], "TOP", 0, 30)
		end
	end

	for i, v in ipairs(boss) do v:Show() end
end

if db.show_arena and not IsAddOnLoaded("Gladius") then
	local arena = {}
	for i = 1, 5 do
		arena[i] = oUF:Spawn("arena"..i, "oUF_Arena"..i)
		if i == 1 then
			if db.arena_on_right == true then
				arena[i]:SetPoint(pos.arena[1], pos.arena[2], pos.arena[3], pos.arena[4], pos.arena[5])
			else
				arena[i]:SetPoint("BOTTOMLEFT", pos.arena[2], "LEFT", pos.arena[4] + 75, pos.arena[5])
			end
		else
			arena[i]:SetPoint("BOTTOM", arena[i-1], "TOP", 0, 30)
		end
	end

	for i, v in ipairs(arena) do v:Show() end

	local arenatarget = {}
	for i = 1, 5 do
		arenatarget[i] = oUF:Spawn("arena"..i.."target", "oUF_Arena"..i.."Target")
		if i == 1 then
			if db.arena_on_right == true then
				arenatarget[i]:SetPoint("TOPRIGHT", arena[i], "TOPLEFT", -41, 0)
			else
				arenatarget[i]:SetPoint("TOPRIGHT", arena[i], "TOPLEFT", -7, 0)
			end
		else
			arenatarget[i]:SetPoint("BOTTOM", arenatarget[i-1], "TOP", 0, 30)
		end
	end

	for i, v in ipairs(arenatarget) do v:Show() end
end

----------------------------------------------------------------------------------------
--	Testmode(by Fernir)
----------------------------------------------------------------------------------------
SlashCmdList.TestUI = function() 
	if(oUF) then
		for i, v in pairs(oUF.units) do
			if not v.fff then
				v.fff = CreateFrame("frame")
				v.fffs = v.fff:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				v.fffs:SetFont(SettingsCF["media"].pixel_font, SettingsCF["unitframe"].font_size, SettingsCF["media"].font_style)
				v.fffs:SetAllPoints(v.fff)
				v.fffs:SetText(v:GetName())
			end
			SettingsDB.CreateTemplate(v.fff)
			v.fff:SetPoint("TOPLEFT", v, -2, 2)
			v.fff:SetPoint("BOTTOMRIGHT", v, 2, -2)
			if v.fff:IsVisible() then 
				v.fff:Hide()
			else
				v.fff:Show()
			end
		end
	end
end
SLASH_TestUI1 = "/testuf"