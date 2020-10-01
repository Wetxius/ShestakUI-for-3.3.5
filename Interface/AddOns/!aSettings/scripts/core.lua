----------------------------------------------------------------------------------------
--	Moving some frames
----------------------------------------------------------------------------------------
-- Ticket frame
TicketStatusFrame:ClearAllPoints()
TicketStatusFrame:SetPoint(unpack(SettingsCF["position"].ticket))
TicketStatusFrame.SetPoint = SettingsDB.dummy

-- Battlefield score frame 
if WorldStateAlwaysUpFrame then
	WorldStateAlwaysUpFrame:ClearAllPoints()
	WorldStateAlwaysUpFrame:SetPoint(unpack(SettingsCF["position"].attempt))
	WorldStateAlwaysUpFrame.SetPoint = SettingsDB.dummy
	WorldStateAlwaysUpFrame:SetFrameStrata("BACKGROUND")
	WorldStateAlwaysUpFrame:SetFrameLevel(0)
end

-- CaptureBar frame
local mcb = CreateFrame("Frame")
local function OnEvent()
	if NUM_EXTENDED_UI_FRAMES > 0 then
		for i = 1, NUM_EXTENDED_UI_FRAMES do
			_G["WorldStateCaptureBar" .. i]:ClearAllPoints()
			_G["WorldStateCaptureBar" .. i]:SetPoint(unpack(SettingsCF["position"].capture_bar))
		end
	end
end
local mcb = CreateFrame("Frame")
mcb:RegisterEvent("PLAYER_LOGIN")
mcb:RegisterEvent("UPDATE_WORLD_STATES")
mcb:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
mcb:SetScript("OnEvent", OnEvent)

-- UIErrors frame
UIErrorsFrame:ClearAllPoints()
UIErrorsFrame:SetPoint(unpack(SettingsCF["position"].uierror))

-- Watch frame
WatchFrame:ClearAllPoints()
WatchFrame:SetPoint(unpack(SettingsCF["position"].quest))
WatchFrame:SetWidth(250)
WatchFrame:SetHeight(500)
WatchFrame.SetPoint = SettingsDB.dummy
WatchFrame.ClearAllPoints = SettingsDB.dummy

-- Vehicle indicator
hooksecurefunc(VehicleSeatIndicator, "SetPoint", function(_, _, parent)
    if (parent == "MinimapCluster") or (parent == _G["MinimapCluster"]) then
		VehicleSeatIndicator:ClearAllPoints()
		VehicleSeatIndicator:SetPoint(unpack(SettingsCF["position"].vehicle))
    end
end)

-- Achievement frame
local function Reanchor()
	local one, two, lfg = AchievementAlertFrame1, AchievementAlertFrame2, DungeonCompletionAlertFrame1
	if one then
		one:ClearAllPoints()
		one:SetPoint("TOP", UIParent, "TOP", 0, -20)
	end
	if two then
		two:ClearAllPoints()
		two:SetPoint("TOP", one, "BOTTOM", 0, -10)
	end
	if lfg:IsShown() then
		lfg:ClearAllPoints()
		if one then
			if two then
				lfg:SetPoint("TOP", two, "BOTTOM", 0, -10)
			else
				lfg:SetPoint("TOP", one, "BOTTOM", 0, -10)
			end
		else
			lfg:SetPoint("TOP", UIParent, "TOP", 0, -20)
		end
	end
end

local achframe = CreateFrame("Frame", nil, UIParent)
achframe:RegisterEvent("VARIABLES_LOADED")
achframe:SetScript("OnEvent", function()
	AlertFrame_FixAnchors = Reanchor
end)

----------------------------------------------------------------------------------------
--	Remove uiscale option via blizzard option
----------------------------------------------------------------------------------------
VideoOptionsResolutionPanelUIScaleSlider:Hide()
VideoOptionsResolutionPanelUseUIScale:Hide()

----------------------------------------------------------------------------------------
--	Quest level(yQuestLevel by yleaf)
----------------------------------------------------------------------------------------
local function questlevel()
	local buttons = QuestLogScrollFrame.buttons
	local numButtons = #buttons
	local scrollOffset = HybridScrollFrame_GetOffset(QuestLogScrollFrame)
	local numEntries, numQuests = GetNumQuestLogEntries()
	
	for i = 1, numButtons do
		local questIndex = i + scrollOffset
		local questLogTitle = buttons[i]
		if questIndex <= numEntries then
			local title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily = GetQuestLogTitle(questIndex)
			if not isHeader then
				questLogTitle:SetText("[" .. level .. "] " .. title)
				QuestLogTitleButton_Resize(questLogTitle)
			end
		end
	end
end
hooksecurefunc("QuestLog_Update", questlevel)
QuestLogScrollFrameScrollBar:HookScript("OnValueChanged", questlevel)

----------------------------------------------------------------------------------------
--	Auto invite by whisper
----------------------------------------------------------------------------------------
local ainvenabled = false

local autoinvite = CreateFrame("Frame")
autoinvite:RegisterEvent("CHAT_MSG_WHISPER")
autoinvite:SetScript("OnEvent", function(self, event, arg1, arg2)
    if ((not UnitExists("party1") or IsPartyLeader("player")) and arg1:lower():match(SettingsCF["misc"].invite_keyword)) and ainvenabled == true then
        InviteUnit(arg2)
    end
end)

function SlashCmdList.AUTOINVITE(msg, editbox)
	if (msg == "off") then
		ainvenabled = false
		print("|cffffff00"..L_INVITE_DISABLE..".")
	elseif (msg == "") then
		ainvenabled = true
		print("|cffffff00"..L_INVITE_ENABLE_T..".")
		ainvkeyword = SettingsCF["misc"].invite_keyword
	else
		ainvenabled = true
		print("|cffffff00"..L_INVITE_ENABLE .. msg..".")
		ainvkeyword = msg
	end
end
SLASH_AUTOINVITE1 = "/ainv"

----------------------------------------------------------------------------------------
--	Force readycheck warning 
----------------------------------------------------------------------------------------
local ShowReadyCheckHook = function(self, initiator, timeLeft)
	if initiator ~= "player" then
		PlaySound("ReadyCheck")
	end
end
hooksecurefunc("ShowReadyCheck", ShowReadyCheckHook)

----------------------------------------------------------------------------------------
--	ALT+Click to buy a stack
----------------------------------------------------------------------------------------
local savedMerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClick;
function MerchantItemButton_OnModifiedClick(self, ...)
	if IsAltKeyDown() then
		local maxStack = select(8, GetItemInfo(GetMerchantItemLink(this:GetID())))
		local name, texture, price, quantity, numAvailable, isUsable, extendedCost = GetMerchantItemInfo(this:GetID())
		if maxStack and maxStack > 1 then
			BuyMerchantItem(this:GetID(), floor(maxStack / quantity))
		end
	end
	savedMerchantItemButton_OnModifiedClick(self, ...)
end

----------------------------------------------------------------------------------------
--	Auto greed on green items(by Tekkub) and NeedTheOrb(By Myrilandell of Lothar)
----------------------------------------------------------------------------------------
if SettingsDB.mylevel == MAX_PLAYER_LEVEL and SettingsCF["misc"].auto_greed == true then
	local autogreed = CreateFrame("Frame")
	autogreed:RegisterEvent("START_LOOT_ROLL")
	autogreed:SetScript("OnEvent", function(self, event, id)
		local name = select(2, GetLootRollItemInfo(id))
		if (name == select(1, GetItemInfo(43102))) then
			RollOnLoot(id, 2)
		end
		if(id and select(4, GetLootRollItemInfo(id))==2 and not (select(5, GetLootRollItemInfo(id)))) then
			if RollOnLoot(id, 3) then
				RollOnLoot(id, 3)
			else
				RollOnLoot(id, 2)
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Disenchant confirmation(tekKrush by Tekkub)
----------------------------------------------------------------------------------------
if SettingsCF["misc"].auto_confirm_de == true then
	local acd = CreateFrame("Frame")
	acd:RegisterEvent("CONFIRM_DISENCHANT_ROLL")
	acd:RegisterEvent("CONFIRM_LOOT_ROLL")
	acd:RegisterEvent("LOOT_BIND_CONFIRM")
	acd:SetScript("OnEvent", function(self, event, ...)
		for i = 1, STATICPOPUP_NUMDIALOGS do
			local frame = _G["StaticPopup"..i]
			if (frame.which == "CONFIRM_LOOT_ROLL" or frame.which == "LOOT_BIND" or frame.which == "LOOT_BIND_CONFIRM") and frame:IsVisible() then StaticPopup_OnClick(frame, 1) end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Auto decline duels
----------------------------------------------------------------------------------------
if SettingsCF["misc"].auto_decline_duel == true then
    local dd = CreateFrame("Frame")
    dd:RegisterEvent("DUEL_REQUESTED")
    dd:SetScript("OnEvent", function(self, event, name)
		HideUIPanel(StaticPopup1)
		CancelDuel()
		SettingsDB.InfoTextShow(L_INFO_DUEL..name)
		print(format("|cffffff00"..L_INFO_DUEL..name.."."))
    end)
end

----------------------------------------------------------------------------------------
--	Accept invites from guild memers or friend list 
----------------------------------------------------------------------------------------
if SettingsCF["misc"].auto_accept_invite == true then
    local IsFriend = function(name)
        for i = 1, GetNumFriends() do if(GetFriendInfo(i) == name) then return true end end
        if(IsInGuild()) then for i = 1, GetNumGuildMembers() do if(GetGuildRosterInfo(i) == name) then return true end end end
    end

    local ai = CreateFrame("Frame")
    ai:RegisterEvent("PARTY_INVITE_REQUEST")
    ai:SetScript("OnEvent", function(frame, event, name)
        if(IsFriend(name)) then
			SettingsDB.InfoTextShow(L_INFO_INVITE..name)
			print(format("|cffffff00"..L_INFO_INVITE..name.."."))
            AcceptGroup()
            for i = 1, 4 do
                local frame = _G["StaticPopup"..i]
                if(frame:IsVisible() and frame.which == "PARTY_INVITE") then
                    frame.inviteAccepted = 1
                    StaticPopup_Hide("PARTY_INVITE")
                    return
                end
            end
        else
            SendWho(name)
        end
    end)
end

----------------------------------------------------------------------------------------
--	Auto resurection
----------------------------------------------------------------------------------------
if SettingsCF["misc"].auto_resurrection == true then
	local WINTERGRASP
	WINTERGRASP = L_ZONE_WINTERGRASP

	local autoreleasepvp = CreateFrame("frame")
	autoreleasepvp:RegisterEvent("PLAYER_DEAD")
	autoreleasepvp:SetScript("OnEvent", function(self, event)
		local soulstone = GetSpellInfo(20707)
		if (SettingsDB.myclass ~= "SHAMAN") or not (soulstone and UnitBuff("player", soulstone)) then
			if (tostring(GetZoneText()) == WINTERGRASP) then
				RepopMe()
			end
			if MiniMapBattlefieldFrame.status == "active" then
				RepopMe()
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Mob marking(by ALZA)
----------------------------------------------------------------------------------------
if SettingsCF["misc"].shift_marking == true then
	local menuFrame = CreateFrame("Frame", "MarkingFrame", UIParent, "UIDropDownMenuTemplate")
	local menuList = {
		{text = RAID_TARGET_NONE,
		func = function() SetRaidTarget("target", 0) end},
		{text = RAID_TARGET_8,
		func = function() SetRaidTarget("target", 8) end},
		{text = "|cffff0000"..RAID_TARGET_7.."|r",
		func = function() SetRaidTarget("target", 7) end},
		{text = "|cff00ffff"..RAID_TARGET_6.."|r",
		func = function() SetRaidTarget("target", 6) end},
		{text = "|cffC7C7C7"..RAID_TARGET_5.."|r",
		func = function() SetRaidTarget("target", 5) end},
		{text = "|cff00ff00"..RAID_TARGET_4.."|r",
		func = function() SetRaidTarget("target", 4) end},
		{text = "|cff912CEE"..RAID_TARGET_3.."|r",
		func = function() SetRaidTarget("target", 3) end},
		{text = "|cffFF8000"..RAID_TARGET_2.."|r",
		func = function() SetRaidTarget("target", 2) end},
		{text = "|cffffff00"..RAID_TARGET_1.."|r",
		func = function() SetRaidTarget("target", 1) end},
	}

	WorldFrame:HookScript("OnMouseDown", function(self, button)
		if (button == "LeftButton" and IsShiftKeyDown() and UnitExists("mouseover")) then
			local inParty = (GetNumPartyMembers() > 0)
			local inRaid = (GetNumRaidMembers() > 0)
			if (inRaid and (IsRaidLeader() or IsRaidOfficer()) or (inParty and not inRaid)) then
				EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 1)
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Check Flask(Flasked North by v6o)
----------------------------------------------------------------------------------------
local checkflask = CreateFrame("Frame")
checkflask:SetScript("OnEvent", function(self, event, ...)
	local PlayerGUID = UnitGUID("player")
	local _, CombatEvent, _, _, _, DestGUID, _, _, SpellID = ...
	if CombatEvent == "SPELL_AURA_APPLIED" and DestGUID == PlayerGUID then
		if SpellID == 67016 then
			SettingsDB.InfoTextShow(L_FLASK_SPD)
		elseif SpellID == 67017 then
			SettingsDB.InfoTextShow(L_FLASK_AP)
		elseif SpellID == 67018 then
			SettingsDB.InfoTextShow(L_FLASK_STR)
		end
	end
end)
checkflask:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

----------------------------------------------------------------------------------------
--	Universal Mount macro : /script Mountz ("your_ground_mount","your_flying_mount")(by ALZA or maybe by Monolit?)
----------------------------------------------------------------------------------------
function Mountz(groundmount, flyingmount)
    local num = GetNumCompanions("MOUNT")
    if not num or IsMounted() then
        Dismount()
        return
    end
    if CanExitVehicle() then 
        VehicleExit()
        return
    end
    local x, y = GetPlayerMapPosition("player")
    local wgtime = GetWintergraspWaitTime()
    local flyablex = (IsFlyableArea() and (not (GetZoneText() == L_ZONE_DALARAN or (GetZoneText() == L_ZONE_WINTERGRASP and wgtime == nil)) or GetSubZoneText() == L_ZONE_KRASUS or (GetSubZoneText() == L_ZONE_UNDERBELLY and ((x*100)<32)) or (GetSubZoneText() == L_ZONE_VC and (x*100)<33))) and (UnitLevel("player")>67 or (GetCurrentMapContinent()==3 and UnitLevel("player")>59))
    if IsAltKeyDown() then
        flyablex = not flyablex
    end
    for i = 1, num, 1 do
        local _, info = GetCompanionInfo("MOUNT", i)
        if flyingmount and info == flyingmount and flyablex then
            CallCompanion("MOUNT", i)
            return
        elseif groundmount and info == groundmount and not flyablex then
            CallCompanion("MOUNT", i)
            return
        end
    end
end

----------------------------------------------------------------------------------------
--	Protection from hidden windows auction at the opening of other windows(by Fernir)
----------------------------------------------------------------------------------------
local eventframe = CreateFrame("Frame")
eventframe:RegisterEvent("ADDON_LOADED")
eventframe:SetScript("OnEvent", function(self, event, addon)
    if addon == "Blizzard_AuctionUI" then
        AuctionFrame:SetMovable(true)
        AuctionFrame:SetClampedToScreen(true)
        AuctionFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
        AuctionFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)

        local handleAuctionFrame = function(self)
            if AuctionFrame:GetAttribute("UIPanelLayout-enabled") then
                if AuctionFrame:IsVisible() then
                    AuctionFrame.Hide = function() end
                    HideUIPanel(AuctionFrame)
                    AuctionFrame.Hide = nil
                end
                AuctionFrame:SetAttribute("UIPanelLayout-enabled", nil)
            else
                if AuctionFrame:IsVisible() then
                    AuctionFrame.IsShown = function() end
                    ShowUIPanel(AuctionFrame)
                    AuctionFrame.IsShown = nil
                end
            end
        end
        hooksecurefunc("AuctionFrame_Show", handleAuctionFrame)
        hooksecurefunc("AuctionFrame_Hide", handleAuctionFrame)
      
      self:UnregisterEvent"ADDON_LOADED"
      self:SetScript("OnEvent", nil)
    end
end)  

----------------------------------------------------------------------------------------
--	Quest automation(idQuestAutomation by Industrial)
----------------------------------------------------------------------------------------
if SettingsCF["misc"].auto_quest == true then
	local addon = CreateFrame("Frame")
	addon.completed_quests = {}
	addon.uncompleted_quests = {}

	function addon:canAutomate ()
		if IsShiftKeyDown() then
			return false
		else
			return true
		end
	end

	function addon:strip_text (text)
		if not text then return end
		text = text:gsub("%[.*%]%s*","")
		text = text:gsub("|c%x%x%x%x%x%x%x%x(.+)|r","%1")
		text = text:gsub("(.+) %(.+%)", "%1")
		text = text:trim()
		return text
	end

	function addon:QUEST_PROGRESS ()
		if not self:canAutomate() then return end
		if IsQuestCompletable() then
			CompleteQuest()
		end
	end

	function addon:QUEST_LOG_UPDATE ()
		if not self:canAutomate() then return end
		local start_entry = GetQuestLogSelection()
		local num_entries = GetNumQuestLogEntries()
		local title
		local is_complete
		local no_objectives

		self.completed_quests = {}
		self.uncompleted_quests = {}

		if num_entries > 0 then
			for i = 1, num_entries do
				SelectQuestLogEntry(i)
				title, _, _, _, _, _, is_complete = GetQuestLogTitle(i)
				no_objectives = GetNumQuestLeaderBoards(i) == 0
				if title and (is_complete or no_objectives) then
					self.completed_quests[title] = true
				else
					self.uncompleted_quests[title] = true
				end
			end
		end

		SelectQuestLogEntry(start_entry)
	end

	function addon:GOSSIP_SHOW ()
		if not self:canAutomate() then return end

		local button
		local text

		for i = 1, 32 do
			button = _G["GossipTitleButton" .. i]
			if button:IsVisible() then
				text = self:strip_text(button:GetText())
				if button.type == "Available" then
					button:Click()
				elseif button.type == "Active" then
					if self.completed_quests[text] then
						button:Click()
					end
				end
			end
		end
	end

	function addon:QUEST_GREETING (...)
		if not self:canAutomate() then return end

		local button
		local text

		for i = 1, 32 do
			button = _G["QuestTitleButton" .. i]
			if button:IsVisible() then
				text = self:strip_text(button:GetText())
				if self.completed_quests[text] then
					button:Click()
				elseif not self.uncompleted_quests[text] then
					button:Click()
				end
			end
		end
	end

	function addon:QUEST_DETAIL ()
		if not self:canAutomate() then return end
		AcceptQuest()
	end

	function addon:QUEST_COMPLETE (event)
		if not self:canAutomate() then return end
		if GetNumQuestChoices() <= 1 then
			GetQuestReward(QuestFrameRewardPanel.itemChoice)
		end
	end

	function addon.onevent (self, event, ...)
		if self[event] then
			self[event](self, ...)
		end
	end

	addon:SetScript("OnEvent", addon.onevent)
	addon:RegisterEvent("GOSSIP_SHOW")
	addon:RegisterEvent("QUEST_COMPLETE")
	addon:RegisterEvent("QUEST_DETAIL")
	addon:RegisterEvent("QUEST_FINISHED")
	addon:RegisterEvent("QUEST_GREETING")
	addon:RegisterEvent("QUEST_LOG_UPDATE")
	addon:RegisterEvent("QUEST_PROGRESS")

	_G.idQuestAutomation = addon
end

----------------------------------------------------------------------------------------
--	Spin camera while afk(by Telroth and Eclípsé)
----------------------------------------------------------------------------------------
if SettingsCF["misc"].afk_spin_camera == true then
	local SpinCam = CreateFrame("Frame")

	local OnEvent = function(self, event, unit)
		if (event == "PLAYER_FLAGS_CHANGED") then
			if unit == "player" then
				if UnitIsAFK(unit) then
					SpinStart()
				else
					SpinStop()
				end
			end
		elseif (event == "PLAYER_LEAVING_WORLD") then
			SpinStop()
		end
	end
	SpinCam:RegisterEvent("PLAYER_ENTERING_WORLD")
	SpinCam:RegisterEvent("PLAYER_LEAVING_WORLD")
	SpinCam:RegisterEvent("PLAYER_FLAGS_CHANGED")
	SpinCam:SetScript("OnEvent", OnEvent)

	function SpinStart()
		spinning = true
		SaveView(4)
		ResetView(5)
		SetView(5)
		MoveViewRightStart(0.1)
		UIParent:Hide()
	end

	function SpinStop()
		if not spinning then return end
		spinning = nil
		MoveViewRightStop()
		SetView(4)
		UIParent:Show()
	end
end