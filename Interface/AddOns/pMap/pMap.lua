----------------------------------------------------------------------------------------
--	WorldMap style(m_Map by Monolit)
----------------------------------------------------------------------------------------
WORLDMAP_RATIO_MINI = SettingsCF["map"].scale
WORLDMAP_WINDOWED_SIZE = WORLDMAP_RATIO_MINI

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("WORLD_MAP_UPDATE")

local SmallerMap = GetCVarBool("miniWorldMap")
if SmallerMap == nil then
	SetCVar("miniWorldMap", 1)
end

local MoveMap = GetCVarBool("advancedWorldMap")
if MoveMap == nil then
	SetCVar("advancedWorldMap", 1)
end

f:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		SetCVar("questPOI", 1)
		SetCVar("advancedWorldMap", 1)
		WorldMapBlobFrame.Show = SettingsDB.dummy
		WorldMapBlobFrame.Hide = SettingsDB.dummy
	elseif event == "WORLD_MAP_UPDATE" then
		if (GetNumDungeonMapLevels() == 0) then
			WorldMapLevelUpButton:Hide()
			WorldMapLevelDownButton:Hide()
		else
			WorldMapLevelUpButton:Show()
			WorldMapLevelDownButton:Show()
			WorldMapLevelUpButton:ClearAllPoints()
			WorldMapLevelUpButton:SetPoint("TOPLEFT", WorldMapFrameCloseButton, "BOTTOMLEFT", 8, 8)
			WorldMapLevelUpButton:SetFrameStrata("MEDIUM")
			WorldMapLevelUpButton:SetFrameLevel(90)
			WorldMapLevelDownButton:ClearAllPoints()
			WorldMapLevelDownButton:SetPoint("TOP", WorldMapLevelUpButton, "BOTTOM", 0, -2)
			WorldMapLevelDownButton:SetFrameStrata("MEDIUM")
			WorldMapLevelDownButton:SetFrameLevel(90)
		end
	end
end)

local MapShrink = function()
	local WorldMapScaleDown = WORLDMAP_RATIO_MINI
	local bgframe = CreateFrame("Frame", nil, WorldMapButton)
	SettingsDB.CreateTemplate(bgframe)
	bgframe:SetFrameStrata("LOW")
	bgframe:SetScale (1 / WORLDMAP_RATIO_MINI)
	bgframe:SetPoint("TOPLEFT", WorldMapButton , "TOPLEFT", -2.5, 2.5)
	bgframe:SetPoint("BOTTOMRIGHT", WorldMapButton , "BOTTOMRIGHT", 2, -2)
	bgframe:SetBackdropColor(unpack(SettingsCF["media"].backdrop_color))
	bgframe:SetBackdropBorderColor(RAID_CLASS_COLORS[select(2,UnitClass("player"))].r, RAID_CLASS_COLORS[select(2,UnitClass("player"))].g, RAID_CLASS_COLORS[select(2,UnitClass("player"))].b)

	WorldMapPositioningGuide:ClearAllPoints()
	WorldMapPositioningGuide:SetPoint("TOP", UIParent, "TOP", 0, -30)
	WorldMapDetailFrame:ClearAllPoints()
	WorldMapDetailFrame:SetPoint(unpack(SettingsCF["position"].map))
	WorldMapButton:SetScale(WorldMapScaleDown)
	WorldMapFrameAreaFrame:SetScale(WorldMapScaleDown)
	WorldMapPOIFrame.ratio = WorldMapScaleDown
	WorldMapTitleButton:Show()
	WorldMapFrameMiniBorderLeft:Hide()
	WorldMapFrameMiniBorderRight:Hide()
	WorldMapFrameSizeUpButton:Hide()
	WorldMapFrameCloseButton:ClearAllPoints()
	WorldMapFrameCloseButton:SetPoint("TOPRIGHT", WorldMapButton, "TOPRIGHT")
	WorldMapFrameCloseButton:SetFrameStrata("HIGH")
	WorldMapFrameSizeDownButton:SetPoint("TOPRIGHT", WorldMapFrameMiniBorderRight, "TOPRIGHT", -66, 5)
	WorldMapFrameTitle:ClearAllPoints()
	WorldMapFrameTitle:SetPoint("TOPLEFT", WorldMapDetailFrame, 3, -1)
	WorldMapFrameTitle:SetFontObject("GameFontNormal")
	WorldMapFrameTitle:SetFont(SettingsCF["media"].font, 17)
	WorldMapFrameTitle:SetParent(WorldMapDetailFrame)
	WorldMapTitleButton:SetFrameStrata("TOOLTIP")
	WorldMapTitleButton:ClearAllPoints()
	WorldMapTitleButton:SetPoint("TOP", WorldMapFrame, "TOP", 0, -18)
	WorldMapTooltip:SetFrameStrata("TOOLTIP")
	WorldMapFrame_SetPOIMaxBounds()
	WorldMapQuestShowObjectivesText:SetFontObject("GameFontNormal")
	WorldMapQuestShowObjectivesText:SetFont(SettingsCF["media"].font, 17)
	WorldMapQuestShowObjectivesText:ClearAllPoints()
	WorldMapQuestShowObjectivesText:SetPoint("BOTTOMRIGHT", WorldMapButton, "BOTTOMRIGHT", 0, 4)
	WorldMapQuestShowObjectives:SetParent(WorldMapDetailFrame)
	WorldMapQuestShowObjectives:ClearAllPoints()
	WorldMapQuestShowObjectives:SetPoint("RIGHT", WorldMapQuestShowObjectivesText, "LEFT", 0, 0)
	WorldMapQuestShowObjectives:SetFrameStrata("TOOLTIP")
	WorldMapQuestShowObjectives:SetFrameLevel(20)
	WorldMapTrackQuest:SetParent(WorldMapDetailFrame)
	WorldMapTrackQuest:ClearAllPoints()
	WorldMapTrackQuest:SetPoint("BOTTOMLEFT", WorldMapButton, "BOTTOMLEFT", 0, 0)
	WorldMapTrackQuest:SetFrameStrata("TOOLTIP")
	WorldMapTrackQuest:SetFrameLevel(20)
	WorldMapTrackQuestText:SetFontObject("GameFontNormal")
	WorldMapTrackQuestText:SetFont(SettingsCF["media"].font, 17)
	
	-- 3.3.3, hide the dropdown added into this patch
	WorldMapLevelDropDown:SetAlpha(0)
	WorldMapLevelDropDown:SetScale(0.0001)
	-- Fix tooltip not hidding after leaving quest # tracker icon
	WorldMapQuestPOI_OnLeave = function()
		WorldMapTooltip:Hide()
	end
end
hooksecurefunc("WorldMap_ToggleSizeDown", MapShrink)

----------------------------------------------------------------------------------------
--	Creating coords
----------------------------------------------------------------------------------------
local function CreateText(offset)
	local text = WorldMapButton:CreateFontString(nil, "ARTWORK")
	text:SetPoint("TOPLEFT", WorldMapButton, 3, offset)
	text:SetFontObject("GameFontNormal")
	text:SetFont(SettingsCF["media"].font, 17)
	text:SetJustifyH("LEFT")
	return text
end

function MouseXY()
	local left, top = WorldMapDetailFrame:GetLeft() or 0, WorldMapDetailFrame:GetTop() or 0
	local width, height = WorldMapDetailFrame:GetWidth(), WorldMapDetailFrame:GetHeight()
	local scale = WorldMapDetailFrame:GetEffectiveScale()
	local x, y = GetCursorPosition()
	local cx = (x/scale - left) / width
	local cy = (top - y/scale) / height
	if cx < 0 or cx > 1 or cy < 0 or cy > 1 then
		return
	end
	return cx, cy
end

local function OnUpdate(player, cursor)
	local cx, cy = MouseXY()
	local px, py = GetPlayerMapPosition("player")
	if cx then
		cursor:SetFormattedText(L_MAP_CURSOR.."%.2d,%.2d", 100 * cx, 100 * cy)
	else
		cursor:SetText(L_MAP_CURSOR.."|cffff0000"..L_MAP_BOUNDS.."|r")
	end
	if px == 0 then
		player:SetText("")
	else
		player:SetFormattedText(UnitName("player")..": %.2d,%.2d", 100 * px, 100 * py)
	end
	if InCombatLockdown() then
		WorldMapFrameSizeDownButton:Disable() 
		WorldMapFrameSizeUpButton:Disable() 
	else
		WorldMapFrameSizeDownButton:Enable()
		WorldMapFrameSizeUpButton:Enable() 
	end
end

local function OnEvent(self)
	local player = CreateText(-20)
	local cursor = CreateText(-40)
	local elapsed = 0
	self:SetScript("OnUpdate", function(self, u)
		elapsed = elapsed + u
		if(elapsed > 0.1) then
			OnUpdate(player, cursor)
			elapsed = 0
		end
	end)
end
local pMap = CreateFrame"Frame"
pMap:SetScript("OnEvent", OnEvent)
pMap:RegisterEvent("PLAYER_LOGIN")

----------------------------------------------------------------------------------------
--	New raid/party members MapBlips(by Nevcairiel)
----------------------------------------------------------------------------------------
if SettingsCF["map"].group_icons then
	local f = CreateFrame("Frame", "MapBlips", UIParent)
	function f:OverrideWorldMapUnit_Update(unit)
		if unit == nil then return end
		f:OnUpdate(unitFrame.icon, unitFrame.unit)
	end
	function f:gen_icon(unit, cond, party)
		local u = _G[unit]
		local icon = u.icon
		if cond then
			u.elapsed = 0.5
			u:SetScript("OnUpdate", function(self, elapsed)
				self.elapsed = self.elapsed - elapsed
				if self.elapsed <= 0 then
					self.elapsed = 0.5
					MapBlips:OnUpdate(self.icon, self.unit)
				end
			end)
			u:SetScript("OnEvent", nil)
			if party then
				icon:SetTexture("Interface\\AddOns\\!aSettings\\media\\party")
			end
		else
			u.elapsed = nil
			u:SetScript("OnUpdate", nil)
			u:SetScript("OnEvent", WorldMapUnit_OnEvent)
		end
	end
	function f:OnUpdate(icon, unit)
		if not (icon and unit) then return end
		local _, uname = UnitClass(unit)
		if not uname then return end
		if string.find(unit, "raid", 1, true) then
			local _, _, group = GetRaidRosterInfo(string.sub(unit, 5))
			if not group then return end
			icon:SetTexture(string.format("Interface\\AddOns\\!aSettings\\media\\Group%d", group))
		end
		local col = RAID_CLASS_COLORS[uname]
		if col then
			icon:SetVertexColor(col.r, col.g, col.b)
		end
	end
	local function OnInit()
		for i = 1, 4 do
			f:gen_icon(string.format("WorldMapParty%d", i), true, true)
		end
		for i = 1, 40 do
			f:gen_icon(string.format("WorldMapRaid%d", i), true)
		end
		WorldMapUnit_Update = f.OverrideWorldMapUnit_Update;
		f:UnregisterEvent("PLAYER_LOGIN")
		f.PLAYER_LOGIN = nil
	end
	f:RegisterEvent("PLAYER_LOGIN") 
	f:SetScript("OnEvent", OnInit)
end

----------------------------------------------------------------------------------------
--	BattlefieldMinimap style
----------------------------------------------------------------------------------------
if SettingsCF["map"].bg_map_stylization then
	local bm = CreateFrame("Frame")
	bm:RegisterEvent("ADDON_LOADED")
	bm:SetScript("OnEvent", function(self, event, addon)
		if not BattlefieldMinimap_Update then return end
		self:SetParent(BattlefieldMinimap)
		self:SetScript("OnShow", function()
			BattlefieldMinimapCorner:Hide()
			BattlefieldMinimapBackground:Hide()
			BattlefieldMinimapCloseButton:Hide()
		end)
		local background = CreateFrame("Frame", "BACKGROUND", BattlefieldMinimap)
		SettingsDB.CreateTemplate(background)
		background:SetFrameLevel(0)
		background:SetPoint("TOPLEFT", -2, 2)
		background:SetPoint("BOTTOMRIGHT", -4, 2)
		background:SetBackdropBorderColor(RAID_CLASS_COLORS[select(2,UnitClass("player"))].r, RAID_CLASS_COLORS[select(2,UnitClass("player"))].g, RAID_CLASS_COLORS[select(2,UnitClass("player"))].b)
		
		self:UnregisterEvent("ADDON_LOADED")
		self:SetScript("OnEvent", nil)
	end)
end