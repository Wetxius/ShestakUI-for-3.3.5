----------------------------------------------------------------------------------------
-- Raid cooldowns(alRaidCD by Allez)
----------------------------------------------------------------------------------------
if not IsAddOnLoaded("DBM-SpellTimers") and SettingsCF["cooldown"].raid_enable == true then
	local show = {
		raid = SettingsCF["cooldown"].raid_show_inraid,
		party = SettingsCF["cooldown"].raid_show_inparty,
		arena = SettingsCF["cooldown"].raid_show_inarena,
	}
	local filter = COMBATLOG_OBJECT_AFFILIATION_RAID + COMBATLOG_OBJECT_AFFILIATION_PARTY + COMBATLOG_OBJECT_AFFILIATION_MINE
	local band = bit.band
	local sformat = string.format
	local floor = math.floor
	local timer = 0
	local bars = {}

	local FormatTime = function(time)
		if time >= 60 then
			return sformat("%.2d:%.2d", floor(time / 60), time % 60)
		else
			return sformat("%.2d", time)
		end
	end

	local CreateFS = function(frame, fsize, fstyle)
		local fstring = frame:CreateFontString(nil, "OVERLAY")
		fstring:SetFont(SettingsCF["media"].pixel_font, SettingsCF["cooldown"].raid_font_size, SettingsCF["media"].font_style)
		return fstring
	end
	
	local UpdatePositions = function()
		for i = 1, #bars do
			bars[i]:ClearAllPoints()
			if (i == 1) then
				bars[i]:SetPoint(unpack(SettingsCF["position"].raid_cooldown))
			else
				if SettingsCF["cooldown"].raid_upwards == true then
					bars[i]:SetPoint("BOTTOMLEFT", bars[i-1], "TOPLEFT", 0, 13)
				else
					bars[i]:SetPoint("TOPLEFT", bars[i-1], "BOTTOMLEFT", 0, -13)
				end
			end
			bars[i].id = i
		end
	end

	local StopTimer = function(bar)
		bar:SetScript("OnUpdate", nil)
		bar:Hide()
		tremove(bars, bar.id)
		UpdatePositions()
	end

	local BarUpdate = function(self, elapsed)
		local curTime = GetTime()
		if self.endTime < curTime then
			StopTimer(self)
			return
		end
		self:SetValue(100 - (curTime - self.startTime) / (self.endTime - self.startTime) * 100)
		self.right:SetText(FormatTime(self.endTime - curTime))
	end

	local OnEnter = function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:AddDoubleLine(self.spell, self.right:GetText())
		GameTooltip:SetClampedToScreen(true)
		GameTooltip:Show()
	end

	local OnLeave = function(self)
		GameTooltip:Hide()
	end

	local OnMouseDown = function(self, button)
		if button == "LeftButton" then
			SendChatMessage(sformat(L_COOLDOWNS.." %s: %s", self.left:GetText(), self.right:GetText()), "PARTY")
		elseif button == "RightButton" then
			StopTimer(self)
		end
	end

	local CreateBar = function()
		local bar = CreateFrame("Statusbar", nil, UIParent)
		if SettingsCF["cooldown"].raid_show_icon == true then
			bar:SetSize(SettingsCF["cooldown"].raid_width, SettingsCF["cooldown"].raid_height)
		else
			bar:SetSize(SettingsCF["cooldown"].raid_width + 28, SettingsCF["cooldown"].raid_height)
		end
		bar:SetStatusBarTexture(SettingsCF["media"].texture)
		bar:SetMinMaxValues(0, 100)
		
		bar.backdrop = CreateFrame("Frame", nil, bar)
		bar.backdrop:SetPoint("TOPLEFT", -2, 2)
		bar.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
		SettingsDB.CreateTemplate(bar.backdrop)
		bar.backdrop:SetFrameStrata("BACKGROUND")
		
		bar.bg = bar:CreateTexture(nil, "BACKGROUND")
		bar.bg:SetAllPoints(bar)
		bar.bg:SetTexture(SettingsCF["media"].texture)
		
		bar.left = CreateFS(bar)
		bar.left:SetPoint("LEFT", 2, UIParent:GetEffectiveScale())
		bar.left:SetJustifyH("LEFT")
		bar.left:SetSize(SettingsCF["cooldown"].raid_width - 35, SettingsCF["cooldown"].raid_font_size)
		
		bar.right = CreateFS(bar)
		bar.right:SetPoint("RIGHT", -2, UIParent:GetEffectiveScale())
		bar.right:SetJustifyH("RIGHT")
		
		if SettingsCF["cooldown"].raid_show_icon == true then
			bar.icon = CreateFrame("button", nil, bar)
			bar.icon:SetSize(21, 21)
			bar.icon:SetPoint("BOTTOMRIGHT", bar, "BOTTOMLEFT", -7, 0)
			
			bar.icon.backdrop = CreateFrame("Frame", nil, bar.icon)
			bar.icon.backdrop:SetPoint("TOPLEFT", -2, 2)
			bar.icon.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
			SettingsDB.CreateTemplate(bar.icon.backdrop)
			bar.icon.backdrop:SetFrameStrata("BACKGROUND")
		end
		return bar
	end

	local StartTimer = function(name, spellId)
		local bar = CreateBar()
		local spell, rank, icon = GetSpellInfo(spellId)
		bar.endTime = GetTime() + SettingsDB.raid_spells[spellId]
		bar.startTime = GetTime()
		bar.left:SetText(name.." - "..spell)
		bar.right:SetText(FormatTime(SettingsDB.raid_spells[spellId]))
		if SettingsCF["cooldown"].raid_show_icon == true then
			bar.icon:SetNormalTexture(icon)
			bar.icon:GetNormalTexture():SetTexCoord(0.07, 0.93, 0.07, 0.93)
		end
		bar.spell = spell
		bar:Show()
		local color = RAID_CLASS_COLORS[select(2, UnitClass(name))]
		bar:SetStatusBarColor(color.r, color.g, color.b)
		bar.bg:SetVertexColor(color.r, color.g, color.b, 0.25)
		bar:SetScript("OnUpdate", BarUpdate)
		bar:EnableMouse(true)
		bar:SetScript("OnEnter", OnEnter)
		bar:SetScript("OnLeave", OnLeave)
		bar:SetScript("OnMouseDown", OnMouseDown)
		tinsert(bars, bar)
		UpdatePositions()
	end

	local OnEvent = function(self, event, ...)
		if event == "COMBAT_LOG_EVENT_UNFILTERED" then
			local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = ...
			if band(sourceFlags, filter) == 0 then return end
			if eventType == "SPELL_RESURRECT" or eventType == "SPELL_CAST_SUCCESS" then
				local spellId = select(9, ...)
				if SettingsDB.raid_spells[spellId] and show[select(2, IsInInstance())] then
					StartTimer(sourceName, spellId)
				end
			end
		elseif event == "ZONE_CHANGED_NEW_AREA" and select(2, IsInInstance()) == "arena" then
			for k, v in pairs(bars) do
				StopTimer(v)
			end
		end
	end

	local addon = CreateFrame("frame")
	addon:SetScript("OnEvent", OnEvent)
	addon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	addon:RegisterEvent("ZONE_CHANGED_NEW_AREA")

	SlashCmdList["RaidCD"] = function(msg) 
		StartTimer(UnitName("player"), 48477)
		StartTimer(UnitName("player"), 6203)
		StartTimer(UnitName("player"), 6346)
		StartTimer(UnitName("player"), 29166)
		StartTimer(UnitName("player"), 32182)
		StartTimer(UnitName("player"), 2825)
	end
	SLASH_RaidCD1 = "/raidcd"
end

----------------------------------------------------------------------------------------
-- Enemy cooldowns(alEnemyCD by Allez)
----------------------------------------------------------------------------------------
if SettingsCF["cooldown"].enemy_enable ~= true then return end
if IsAddOnLoaded("Afflicted3") or IsAddOnLoaded("InterruptBar") then return end
local show = {
	none = SettingsCF["cooldown"].enemy_show_always,
	pvp = SettingsCF["cooldown"].enemy_show_inpvp,
	arena = SettingsCF["cooldown"].enemy_show_inarena,
}
local icons = {}
local band = bit.band
local pos = SettingsCF["position"].enemy_cooldown

local UpdatePositions = function()
	for i = 1, #icons do
		icons[i]:ClearAllPoints()
		if (i == 1) then
			if SettingsCF["unitframe"].plugins_swing == true then
				icons[i]:SetPoint(pos[1], pos[2], pos[3], pos[4], pos[5])
			else
				icons[i]:SetPoint(pos[1], pos[2], pos[3], pos[4], pos[5] - 12)
			end
		else
			icons[i]:SetPoint("LEFT", icons[i-1], "RIGHT", 3, 0)
		end
		icons[i].id = i
	end
end

local StopTimer = function(icon)
	icon:SetScript("OnUpdate", nil)
	icon:Hide()
	tremove(icons, icon.id)
	UpdatePositions()
end

local IconUpdate = function(self, elapsed)
	if (self.endTime < GetTime()) then
		StopTimer(self)
	end
end

local CreateIcon = function()
	local icon = CreateFrame("Frame", nil, UIParent)
	icon:SetWidth(SettingsCF["cooldown"].enemy_size)
	icon:SetHeight(SettingsCF["cooldown"].enemy_size)
	SettingsDB.CreateTemplate(icon)
	icon.Cooldown = CreateFrame("Cooldown", nil, icon)
	icon.Cooldown:SetPoint("TOPLEFT", 2, -2)
	icon.Cooldown:SetPoint("BOTTOMRIGHT", -2, 2)
	icon.Cooldown:SetReverse()
	icon.Texture = icon:CreateTexture(nil, "BORDER")
	icon.Texture:SetPoint("TOPLEFT", 2, -2)
	icon.Texture:SetPoint("BOTTOMRIGHT", -2, 2)
	return icon
end

local StartTimer = function(sID)
	local _,_,texture = GetSpellInfo(sID)
	local icon = CreateIcon()
	icon.Texture:SetTexture(texture)
	icon.Texture:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	icon.endTime = GetTime() + SettingsDB.enemy_spells[sID]
	icon:Show()
	icon:SetScript("OnUpdate", IconUpdate)
	CooldownFrame_SetTimer(icon.Cooldown, GetTime(), SettingsDB.enemy_spells[sID], 1)
	tinsert(icons, icon)
	UpdatePositions()
end

local OnEvent = function(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName = ...
		if eventType == "SPELL_CAST_SUCCESS" and band(sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE then			
			if sourceName ~= UnitName("player") then
				if SettingsDB.enemy_spells[spellID] and show[select(2, IsInInstance())] then
					StartTimer(spellID)
				end
			end
		end 
	elseif event == "ZONE_CHANGED_NEW_AREA" then
		for k, v in pairs(icons) do
			StopTimer(v)
		end
	end
end
	
local addon = CreateFrame("Frame")
addon:SetScript("OnEvent", OnEvent)
addon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
addon:RegisterEvent("ZONE_CHANGED_NEW_AREA")

SlashCmdList["EnemyCD"] = function(msg) 
	StartTimer(47528)
	StartTimer(19647)
	StartTimer(47476)
	StartTimer(51514)
end
SLASH_EnemyCD1 = "/enemycd"