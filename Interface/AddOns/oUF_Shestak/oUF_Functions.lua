local db = SettingsCF["unitframe"]

local SetUpAnimGroup = function(self)
	self.anim = self:CreateAnimationGroup("Flash")
	self.anim.fadein = self.anim:CreateAnimation("ALPHA", "FadeIn")
	self.anim.fadein:SetChange(1)
	self.anim.fadein:SetOrder(2)

	self.anim.fadeout = self.anim:CreateAnimation("ALPHA", "FadeOut")
	self.anim.fadeout:SetChange(-1)
	self.anim.fadeout:SetOrder(1)
end

local Flash = function(self, duration)
	if not self.anim then
		SetUpAnimGroup(self)
	end

	if not self.anim:IsPlaying() or duration ~= self.anim.fadein:GetDuration() then
		self.anim.fadein:SetDuration(duration)
		self.anim.fadeout:SetDuration(duration)
		self.anim:Play()
	end
end

local StopFlash = function(self)
	if self.anim then
		self.anim:Finish()
	end
end

function SpawnMenu(self)
	local unit = self.unit:sub(1, -2)
	local cunit = self.unit:gsub("^%l", string.upper)

	if cunit == "Vehicle" then
		cunit = "Pet"
	end

	if unit == "party" or unit == "partypet" then
		ToggleDropDownMenu(1, nil, _G["PartyMemberFrame"..self.id.."DropDown"], "cursor", 0, 0)
	elseif(_G[cunit.."FrameDropDown"]) then
		ToggleDropDownMenu(1, nil, _G[cunit.."FrameDropDown"], "cursor", 0, 0)
	end
end

SetFontString = function(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(0, 0)
	return fs
end

local ShortValue = function(value)
	if value >= 1e6 then
		return ("%.1fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e3 or value <= -1e3 then
		return ("%.1fk"):format(value / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return value
	end
end

PostUpdateHealth = function(health, unit, min, max)
	if (unit and unit:find("arena%dtarget")) then return end
	if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
		health:SetValue(0)
		if not UnitIsConnected(unit) then
			health.value:SetText("|cffD7BEA5"..L_UF_OFFLINE.."|r")
		elseif UnitIsDead(unit) then
			health.value:SetText("|cffD7BEA5"..L_UF_DEAD.."|r")
		elseif UnitIsGhost(unit) then
			health.value:SetText("|cffD7BEA5"..L_UF_GHOST.."|r")
		end
	else
		local r, g, b	
		if (db.own_color ~= true and db.enemy_health_color and unit == "target" and UnitIsEnemy(unit, "player")) or (db.own_color ~= true and unit == "target" and not UnitIsPlayer(unit) and UnitIsFriend(unit, "player")) then
			local c = SetColors.reaction[UnitReaction(unit, "player")]
			if c then 
				r, g, b = c[1], c[2], c[3]
				health:SetStatusBarColor(r, g, b)
			else
				r, g, b = 75/255,  175/255, 76/255
				health:SetStatusBarColor(r, g, b)
			end	
		end
		if unit == "pet" or unit == "vehicle" then
			local _, class = UnitClass("player")
			local r, g, b = unpack(oUF.colors.class[class])
			if db.own_color == true then
				health:SetStatusBarColor(unpack(SettingsCF["media"].uf_color))
				health.bg:SetVertexColor(0.1, 0.1, 0.1)
			else
				if b then
					health:SetStatusBarColor(r, g, b)
				end
			end
		end
		if min ~= max then
			local r, g, b
			r, g, b = oUF.ColorGradient(min/max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
			if unit == "player" and health:GetAttribute("normalUnit") ~= "pet" then
				if db.show_total_value == true then
					if db.color_value == true then
						health.value:SetFormattedText("|cff559655%s|r |cffD7BEA5-|r |cff559655%s|r", ShortValue(min), ShortValue(max))
					else
						health.value:SetFormattedText("|cffffffff%s|r |cffffffff-|r |cffffffff%s|r", ShortValue(min), ShortValue(max))
					end
				else
					if db.color_value == true then
						health.value:SetFormattedText("|cffAF5050%d|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", min, r * 255, g * 255, b * 255, floor(min / max * 100))
					else
						health.value:SetFormattedText("|cffffffff%d|r |cffffffff-|r |cffffffff%d%%|r", min, floor(min / max * 100))
					end
				end
			elseif unit == "target" then
				if db.show_total_value == true then
					if db.color_value == true then
						health.value:SetFormattedText("|cff559655%s|r |cffD7BEA5-|r |cff559655%s|r", ShortValue(min), ShortValue(max))
					else
						health.value:SetFormattedText("|cffffffff%s|r |cffffffff-|r |cffffffff%s|r", ShortValue(min), ShortValue(max))
					end
				else
					if db.color_value == true then
						health.value:SetFormattedText("|cff%02x%02x%02x%d%%|r |cffD7BEA5-|r |cffAF5050%s|r", r * 255, g * 255, b * 255, floor(min / max * 100), ShortValue(min))
					else
						health.value:SetFormattedText("|cffffffff%d%%|r |cffffffff-|r |cffffffff%s|r", floor(min / max * 100), ShortValue(min))
					end
				end
			else
				if db.color_value == true then
					health.value:SetFormattedText("|cff%02x%02x%02x%d%%|r", r * 255, g * 255, b * 255, floor(min / max * 100))
				else
					health.value:SetFormattedText("|cffffffff%d%%|r", floor(min / max * 100))
				end
			end
		else
			if unit == "player" and unit ~= "pet" then
				if db.color_value == true then
					health.value:SetText("|cff559655"..max.."|r")
				else
					health.value:SetText("|cffffffff"..max.."|r")
				end
			else
				if db.color_value == true then
					health.value:SetText("|cff559655"..ShortValue(max).."|r")
				else
					health.value:SetText("|cffffffff"..ShortValue(max).."|r")
				end
			end
		end
	end
end

PostUpdateRaidHealth = function(health, unit, min, max)
	if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
		health:SetValue(0)
		if not UnitIsConnected(unit) then
			health.value:SetText("|cffD7BEA5"..L_UF_OFFLINE.."|r")
		elseif UnitIsDead(unit) then
			health.value:SetText("|cffD7BEA5"..L_UF_DEAD.."|r")
		elseif UnitIsGhost(unit) then
			health.value:SetText("|cffD7BEA5"..L_UF_GHOST.."|r")
		end
	else
		if min ~= max then
			local r, g, b
			r, g, b = oUF.ColorGradient(min/max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
			if db.color_value == true then
				if db.deficit_health == true then
					health.value:SetText("|cffFFFFFF".."-"..ShortValue(max-min))
				else
					health.value:SetFormattedText("|cff%02x%02x%02x%d%%|r", r * 255, g * 255, b * 255, floor(min / max * 100))
				end
			else
				if db.deficit_health == true then
					health.value:SetText("|cffFFFFFF".."-"..ShortValue(max-min))
				else
					health.value:SetFormattedText("|cffffffff%d%%|r", floor(min / max * 100))
				end
			end
		else
			if db.color_value == true then
				health.value:SetText("|cff559655"..ShortValue(max).."|r")
			else
				health.value:SetText("|cffffffff"..ShortValue(max).."|r")
			end
		end
		if db.alpha_health == true then
			if(min / max > 0.95) then 
				health:SetAlpha(0.6)
				--self.Power:SetAlpha(0.6)
				--self.FrameBackdrop:SetAlpha(0.6)
			else
				health:SetAlpha(1)
				--self.Power:SetAlpha(1)
				--self.FrameBackdrop:SetAlpha(1)
			end
		end
	end
end

PreUpdatePower = function(power, unit)
	local _, pType = UnitPowerType(unit)
	
	local color = SetColors.power[pType]
	if color then
		power:SetStatusBarColor(color[1], color[2], color[3])
	end
end

PostUpdatePower = function(power, unit, min, max)
	if (unit and unit:find("arena%dtarget")) then return end
	local self = power:GetParent()
	local pType, pToken = UnitPowerType(unit)
	local color = SetColors.power[pToken]

	if color then
		power.value:SetTextColor(color[1], color[2], color[3])
	end

	if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
		power:SetValue(0)
	end
	
	if unit == "focus" or unit == "focustarget" or unit == "targettarget" then return end
	
	if not UnitIsConnected(unit) then
		power.value:SetText()
	elseif UnitIsDead(unit) or UnitIsGhost(unit) then
		power.value:SetText()
	else
		if min ~= max then
			if pType == 0 then
				if unit == "target" then
					if db.show_total_value == true then
						if db.color_value == true then
							power.value:SetFormattedText("%s |cffD7BEA5-|r %s", ShortValue(max - (max - min)), ShortValue(max))
						else
							power.value:SetFormattedText("|cffffffff%s - %s|r", ShortValue(max - (max - min)), ShortValue(max))
						end
					else
						if db.color_value == true then
							power.value:SetFormattedText("%d%% |cffD7BEA5-|r %s", floor(min / max * 100), ShortValue(max - (max - min)))
						else
							power.value:SetFormattedText("|cffffffff%d%% - %s|r", floor(min / max * 100), ShortValue(max - (max - min)))
						end
					end
				elseif unit == "player" and power:GetAttribute("normalUnit") == "pet" or unit == "pet" then
					if db.show_total_value == true then
						if db.color_value == true then
							power.value:SetFormattedText("%s |cffD7BEA5-|r %s", ShortValue(max - (max - min)), ShortValue(max))
						else
							power.value:SetFormattedText("%s |cffffffff-|r %s", ShortValue(max - (max - min)), ShortValue(max))
						end
					else
						if db.color_value == true then
							power.value:SetFormattedText("%d%%", floor(min / max * 100))
						else
							power.value:SetFormattedText("|cffffffff%d%%|r", floor(min / max * 100))
						end
					end
				elseif (unit and unit:find("arena%d")) then
					if db.color_value == true then
						power.value:SetFormattedText("|cffD7BEA5%d%% - %s|r", floor(min / max * 100), ShortValue(max - (max - min)))
					else
						power.value:SetFormattedText("|cffffffff%d%% - %s|r", floor(min / max * 100), ShortValue(max - (max - min)))
					end
				else
					if db.show_total_value == true then
						if db.color_value == true then
							power.value:SetFormattedText("%s |cffD7BEA5-|r %s", ShortValue(max - (max - min)), ShortValue(max))
						else
							power.value:SetFormattedText("|cffffffff%s - %s|r", ShortValue(max - (max - min)), ShortValue(max))
						end
					else
						if db.color_value == true then
							power.value:SetFormattedText("%d |cffD7BEA5-|r %d%%", max - (max - min), floor(min / max * 100))
						else
							power.value:SetFormattedText("|cffffffff%d - %d%%|r", max - (max - min), floor(min / max * 100))
						end
					end
				end
			else
				if db.color_value == true then
					power.value:SetText(max - (max - min))
				else
					power.value:SetText("|cffffffff"..max - (max - min).."|r")
				end
			end
		else
			if unit == "pet" or unit == "target" or (unit and unit:find("arena%d")) then
				if db.color_value == true then
					power.value:SetText(ShortValue(min))
				else
					power.value:SetText("|cffffffff"..ShortValue(min).."|r")
				end
			else
				if db.color_value == true then
					power.value:SetText(min)
				else
					power.value:SetText("|cffffffff"..min.."|r")
				end
			end
		end
	end
end

local delay = 0
local viperAspectName = GetSpellInfo(34074)
UpdateManaLevel = function(self, elapsed)
	delay = delay + elapsed
	if self.parent.unit ~= "player" or delay < 0.2 or UnitIsDeadOrGhost("player") or UnitPowerType("player") ~= 0 then return end
	delay = 0

	local percMana = UnitMana("player") / UnitManaMax("player") * 100

	if AotV then
		local viper = UnitBuff("player", viperAspectName)
		if percMana >= 80 and viper then
			self.ManaLevel:SetText("|cffaf5050"..L_UF_DRAGON.."|r")
			Flash(self, 0.3)
		elseif percMana <= 20 and not viper then
			self.ManaLevel:SetText("|cffaf5050"..L_UF_VIPER.."|r")
			Flash(self, 0.3)
		else
			self.ManaLevel:SetText()
			StopFlash(self)
		end
	else
		if percMana <= 20 then
			self.ManaLevel:SetText("|cffaf5050"..L_UF_MANA.."|r")
			Flash(self, 0.3)
		else
			self.ManaLevel:SetText()
			StopFlash(self)
		end
	end
end

UpdateDruidMana = function(self)
	if self.unit ~= "player" then return end

	local num, str = UnitPowerType("player")
	if num ~= 0 then
		local min, max = UnitPower("player", 0), UnitPowerMax("player", 0)

		local percMana = min / max * 100
		if percMana <= 20 then
			self.FlashInfo.ManaLevel:SetText("|cffaf5050"..L_UF_MANA.."|r")
			Flash(self.FlashInfo, 0.3)
		else
			self.FlashInfo.ManaLevel:SetText()
			StopFlash(self.FlashInfo)
		end

		if min ~= max then
			if self.Power.value:GetText() then
				self.DruidMana:SetPoint("RIGHT", self.Power.value, "LEFT", -1, 0)
				self.DruidMana:SetFormattedText("%d%%|r |cffD7BEA5-|r", floor(min / max * 100))
				self.DruidMana:SetJustifyH("RIGHT")
			else
				self.DruidMana:SetPoint("LEFT", self.Power, "LEFT", 4, 1)
				self.DruidMana:SetFormattedText("%d%%", floor(min / max * 100))
			end
		else
			self.DruidMana:SetText()
		end

		self.DruidMana:SetAlpha(1)
	else
		self.DruidMana:SetAlpha(0)
	end
end

UpdateCPoints = function(self, event, unit)
	if unit == PlayerFrame.unit and unit ~= self.CPoints.unit then
		self.CPoints.unit = unit
	end
end

UpdateReputationColor = function(self, event, unit, bar)
	local name, id = GetWatchedFactionInfo()
	bar:SetStatusBarColor(FACTION_BAR_COLORS[id].r, FACTION_BAR_COLORS[id].g, FACTION_BAR_COLORS[id].b)
end

UpdatePetInfo = function(self, event)
	if self.Info then self.Info:UpdateTag(self.unit) end
end

PostCastStart = function(Castbar, unit, name, rank, text, castid)
	Castbar.channeling = false

	if unit == "vehicle" then unit = "player" end

	if unit == "player" and db.castbar_latency == true then
		local latency = GetTime() - Castbar.castSent
		latency = latency > Castbar.max and Castbar.max or latency
		Castbar.Latency:SetText(("%dms"):format(latency * 1e3))
		Castbar.SafeZone:SetWidth(Castbar:GetWidth() * latency / Castbar.max)
		Castbar.SafeZone:ClearAllPoints()
		Castbar.SafeZone:SetPoint("TOPRIGHT")
		Castbar.SafeZone:SetPoint("BOTTOMRIGHT")
	end

	local r, g, b, color
	if(UnitIsPlayer(unit)) then
		local _, class = UnitClass(unit)
		color = oUF.colors.class[class]
	else
		local reaction = UnitReaction(unit, "player");
		if reaction then
			r = FACTION_BAR_COLORS[reaction].r;
			g = FACTION_BAR_COLORS[reaction].g;
			b = FACTION_BAR_COLORS[reaction].b;
		else
			r, g, b = 1, 1, 1
		end
	end

	if color then
		r, g, b = color[1], color[2], color[3]
	end
	
	if Castbar.interrupt and UnitCanAttack("player", unit) then
		Castbar:SetStatusBarColor(1, 0, 0)
		Castbar.bg:SetVertexColor(1, 0, 0, 0.25)
	else
		if unit == "pet" or unit == "vehicle" then
			local _, class = UnitClass("player")
			local r, g, b = unpack(oUF.colors.class[class])
			if db.own_color == true then
				Castbar:SetStatusBarColor(unpack(SettingsCF["media"].uf_color))
				Castbar.bg:SetVertexColor(0.1, 0.1, 0.1)
			else
				if b then
					Castbar:SetStatusBarColor(r, g, b)
					Castbar.bg:SetVertexColor(r, g, b, 0.25)
				end
			end
		else
			if db.own_color == true then
				Castbar:SetStatusBarColor(unpack(SettingsCF["media"].uf_color))
				Castbar.bg:SetVertexColor(0.1, 0.1, 0.1)
			else
				Castbar:SetStatusBarColor(r, g, b)
				Castbar.bg:SetVertexColor(r, g, b, 0.25)
			end
		end
	end
end

PostChannelStart = function(Castbar, unit, name, rank, text)
	Castbar.channeling = true
	if unit == "vehicle" then unit = "player" end

	if unit == "player" and db.castbar_latency == true then
		local latency = GetTime() - Castbar.castSent
		latency = latency > Castbar.max and Castbar.max or latency
		Castbar.Latency:SetText(("%dms"):format(latency * 1e3))
		Castbar.SafeZone:SetWidth(Castbar:GetWidth() * latency / Castbar.max)
		Castbar.SafeZone:ClearAllPoints()
		Castbar.SafeZone:SetPoint("TOPLEFT")
		Castbar.SafeZone:SetPoint("BOTTOMLEFT")
	end

	local r, g, b, color
	if(UnitIsPlayer(unit)) then
		local _, class = UnitClass(unit)
		color = oUF.colors.class[class]
	else
		local reaction = UnitReaction(unit, "player");
		if reaction then
			r = FACTION_BAR_COLORS[reaction].r;
			g = FACTION_BAR_COLORS[reaction].g;
			b = FACTION_BAR_COLORS[reaction].b;
		else
			r, g, b = 1, 1, 1
		end
	end

	if color then
		r, g, b = color[1], color[2], color[3]
	end
	
	if Castbar.interrupt and UnitCanAttack("player", unit) then
		Castbar:SetStatusBarColor(1, 0, 0)
		Castbar.bg:SetVertexColor(1, 0, 0, 0.25)
	else		
		if unit == "pet" or unit == "vehicle" then
			local _, class = UnitClass("player")
			local r, g, b = unpack(oUF.colors.class[class])
			if db.own_color == true then
				Castbar:SetStatusBarColor(unpack(SettingsCF["media"].uf_color))
				Castbar.bg:SetVertexColor(0.1, 0.1, 0.1)
			else
				if b then
					Castbar:SetStatusBarColor(r, g, b)
					Castbar.bg:SetVertexColor(r, g, b, 0.25)
				end
			end
		else
			if db.own_color == true then
				Castbar:SetStatusBarColor(unpack(SettingsCF["media"].uf_color))
				Castbar.bg:SetVertexColor(0.1, 0.1, 0.1)
			else
				Castbar:SetStatusBarColor(r, g, b)
				Castbar.bg:SetVertexColor(r, g, b, 0.25)
			end
		end
	end
end

CustomCastTimeText = function(self, duration)
	self.Time:SetText(("%.1f / %.1f"):format(self.channeling and duration or self.max - duration, self.max))
end

CustomCastDelayText = function(self, duration)
	self.Time:SetText(("%.1f |cffaf5050%s %.1f|r"):format(self.channeling and duration or self.max - duration, self.channeling and "- " or "+", self.delay))
end

local FormatTime = function(s)
	local day, hour, minute = 86400, 3600, 60
	if s >= day then
		return format("%dd", floor(s/day + 0.5)), s % day
	elseif s >= hour then
		return format("%dh", floor(s/hour + 0.5)), s % hour
	elseif s >= minute then
		return format("%dm", floor(s/minute + 0.5)), s % minute
	elseif s >= minute / 12 then
		return floor(s + 0.5), (s * 100 - floor(s * 100))/100
	end
	return format("%.1f", s), (s * 100 - floor(s * 100))/100
end

local CreateAuraTimer = function(self, elapsed)
	if self.timeLeft then
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed >= 0.1 then
			if not self.first then
				self.timeLeft = self.timeLeft - self.elapsed
			else
				self.timeLeft = self.timeLeft - GetTime()
				self.first = false
			end
			if self.timeLeft > 0 then
				local time = FormatTime(self.timeLeft)
				self.remaining:SetText(time)
				self.remaining:SetTextColor(1, 1, 1)
			else
				self.remaining:Hide()
				self:SetScript("OnUpdate", nil)
			end
			self.elapsed = 0
		end
	end
end

updateAuraTrackerTime = function(self, elapsed)
	if self.active then
		self.timeleft = self.timeleft - elapsed
		if self.timeleft <= 5 then
			self.text:SetTextColor(1, 0, 0)
		else
			self.text:SetTextColor(1, 1, 1)
		end
		if self.timeleft <= 0 then
			self.icon:SetTexture("")
			self.text:SetText("")
		end	
		self.text:SetFormattedText("%.1f", self.timeleft)
	end
end

HideAura = function(self)
	if self.unit == "player" then
		if not db.aura_player_auras then
			self.Buffs:Hide()
			self.Debuffs:Hide()
			self.Enchant:Hide()
			BuffFrame:Hide()
			TemporaryEnchantFrame:Hide()
		else
			BuffFrame:Hide()
			TemporaryEnchantFrame:Hide()
		end
		BuffFrame:UnregisterEvent("UNIT_AURA")
	elseif self.unit == "pet" and not db.aura_pet_debuffs or self.unit == "focus" and not db.aura_focus_debuffs 
	or self.unit == "focustarget" and not db.aura_fot_debuffs or self.unit == "targettarget" and not db.aura_tot_debuffs then
		self.Debuffs:Hide()
	elseif self.unit == "target" and not db.aura_target_auras then
		self.Auras:Hide()
	end
end

local CancelAura = function(self, button)
	if button == "RightButton" and not self.debuff then
		CancelUnitBuff("player", self:GetID())
	end
end

PostCreateAura = function(element, button)
	SettingsDB.CreateTemplate(button)
	
	button.remaining = SetFontString(button, SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
	button.remaining:SetPoint("CENTER", button, "CENTER", 1, 1)
	button.remaining:SetTextColor(1, 1, 1)
	
	button.cd.noOCC = true				-- hide OmniCC CDs
	button.cd.noCooldownCount = true	-- hide CDC CDs
	
	button.icon:SetPoint("TOPLEFT", 2, -2)
	button.icon:SetPoint("BOTTOMRIGHT", -2, 2)
	button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button.icon:SetDrawLayer("ARTWORK")

	button.count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 1)
	button.count:SetJustifyH("RIGHT")
	button.count:SetFont(SettingsCF["media"].pixel_font, db.font_size, SettingsCF["media"].font_style)
	button.count:SetTextColor(1, 1, 1)

	if SettingsCF["unitframe"].aura_show_spiral == true then
		element.disableCooldown = false
		button.cd:SetReverse()
		button.overlayFrame = CreateFrame("Frame", nil, button, nil)
		button.cd:SetFrameLevel(button:GetFrameLevel() + 1)
		button.cd:ClearAllPoints()
		button.cd:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
		button.cd:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
		button.overlayFrame:SetFrameLevel(button.cd:GetFrameLevel() + 1)
		button.count:SetParent(button.overlayFrame)
		button.remaining:SetParent(button.overlayFrame)
	else
		element.disableCooldown = true
	end

	if unit == "player" then
		button:SetScript("OnMouseUp", CancelAura)
	end
end

CreateEnchantTimer = function(self, icons)
	for i = 1, 2 do
		local icon = icons[i]
		if icon.expTime then
			icon.timeLeft = icon.expTime - GetTime()
			icon.remaining:Show()
		else
			icon.remaining:Hide()
		end
		icon:SetScript("OnUpdate", CreateAuraTimer)
	end
end

PostUpdateIcon = function(icons, unit, icon, index, offset)
	local _, _, _, _, dtype, duration, expirationTime, unitCaster, _ = UnitAura(unit, index, icon.filter)
	
	if icon.debuff then
		if(not UnitIsFriend("player", unit) and icon.owner ~= "player" and icon.owner ~= "vehicle") then
			icon:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
			icon.icon:SetDesaturated(true)
		else
			if SettingsCF["unitframe"].aura_debuff_color_type == true then
				local color = DebuffTypeColor[dtype] or DebuffTypeColor.none
				icon:SetBackdropBorderColor(color.r, color.g, color.b)
				icon.icon:SetDesaturated(false)
			else
				icon:SetBackdropBorderColor(1, 0, 0)
			end
		end
	else
		icon:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
	end

	if duration and duration > 0 and db.aura_show_timer == true then
		icon.remaining:Show()
		icon.timeLeft = expirationTime
		icon:SetScript("OnUpdate", CreateAuraTimer)
	else
		icon.remaining:Hide()
		icon.timeLeft = math.huge
		icon:SetScript("OnUpdate", nil)
	end

	icon.first = true
end

PortraitPostUpdate = function(element, unit)
	if not UnitExists(unit) or not UnitIsConnected(unit) or not UnitIsVisible(unit) then
		element:SetAlpha(0)
	else
		element:SetAlpha(1)
	end
end

UpdateThreat = function(self, event, unit)
	if self.unit ~= unit then return end
	local threat = UnitThreatSituation(self.unit)
	if threat and threat > 1 then
		r, g, b = GetThreatStatusColor(threat)
		if self.FrameBackdrop then
			self.FrameBackdrop:SetBackdropBorderColor(r, g, b)
		end
	else
		if self.FrameBackdrop then
			self.FrameBackdrop:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
		end
	end 
end

updateAllElements = function(frame)
	for _, v in ipairs(frame.__elements) do
		v(frame, "UpdateElement", frame.unit)
	end
end