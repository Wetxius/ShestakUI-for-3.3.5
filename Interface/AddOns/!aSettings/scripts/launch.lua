----------------------------------------------------------------------------------------
--	First Time Launch and On Login file
----------------------------------------------------------------------------------------
local function InstallUI()
	-- Don't need to set CVar multiple time
	SetCVar("screenshotQuality", 8)
	SetCVar("cameraDistanceMax", 50)
	SetCVar("cameraDistanceMaxFactor", 3.4)
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("showClock", 0)
	SetCVar("rotateMinimap", 0)
	SetCVar("showItemLevel", 1)
	SetCVar("equipmentManager", 1)
	SetCVar("mapQuestDifficulty", 1)
	SetCVar("previewTalents", 1)
	SetCVar("showTutorials", 0)
	SetCVar("showNewbieTips", 0)
	SetCVar("UberTooltips", 1)
	SetCVar("showLootSpam", 1)
	SetCVar("chatMouseScroll", 1)
	SetCVar("removeChatDelay", 1)
	SetCVar("chatStyle", "im")
	SetCVar("WholeChatWindowClickable", 0)
	SetCVar("ConversationMode", "inline")
	SetCVar("colorblindMode", 0)
	SetCVar("hidePartyInRaid", 1)
	SetCVar("lootUnderMouse", 0)
	SetCVar("autoLootDefault", 1)
	
	if SettingsDB.myname == "Черешок" 
		or SettingsDB.myname == "Вершок"
		or SettingsDB.myname == "Вещмешок" 
		or SettingsDB.myname == "Гребешок" 
		or SettingsDB.myname == "Кулешок" 
		or SettingsDB.myname == "Лапушок" 
		or SettingsDB.myname == "Обушок" 
		or SettingsDB.myname == "Ремешок"
		or SettingsDB.myname == "Шестак" then
		SetCVar("nameplateAllowOverlap", 1)
		SetCVar("autoDismountFlying", 1)
		SetCVar("autoQuestWatch", 0)
		SetCVar("autoQuestProgress", 1)
		SetCVar("chatBubblesParty", 0)
		SetCVar("chatBubbles", 0)
		SetCVar("autoSelfCast", 1)
		SetCVar("guildMemberNotify", 1)
		SetCVar("UnitNameOwn", 0)
		SetCVar("UnitNameNPC", 0)
		SetCVar("UnitNameNonCombatCreatureName", 0)
		SetCVar("UnitNamePlayerGuild", 1)
		SetCVar("UnitNamePlayerPVPTitle", 0)
		SetCVar("UnitNameFriendlyPlayerName", 1)
		SetCVar("UnitNameFriendlyPetName", 0)
		SetCVar("UnitNameFriendlyGuardianName", 0)
		SetCVar("UnitNameFriendlyTotemName", 0)
		SetCVar("UnitNameEnemyPlayerName", 1)
		SetCVar("UnitNameEnemyPetName", 0)
		SetCVar("UnitNameEnemyGuardianName", 0)
		SetCVar("UnitNameEnemyTotemName", 1)
		SetCVar("nameplateShowFriends", 0)
		SetCVar("nameplateShowFriendlyPets", 0)
		SetCVar("nameplateShowFriendlyGuardians", 0)
		SetCVar("nameplateShowFriendlyTotems", 0)
		SetCVar("nameplateShowEnemies", 1)
		SetCVar("nameplateShowEnemyPets", 0)
		SetCVar("nameplateShowEnemyGuardians", 0)
		SetCVar("nameplateShowEnemyTotems", 0)
	end		
	
	-- Setting chat frames 
	if not IsAddOnLoaded("Prat") or not IsAddOnLoaded("Chatter") then
		FCF_SetLocked(ChatFrame1, 1)

		for i = 1, NUM_CHAT_WINDOWS do
			local frame = _G[format("ChatFrame%s", i)]
			local chatFrameId = frame:GetID()
			local chatName = FCF_GetChatWindowInfo(chatFrameId)
			
			-- Move general chat to bottom left
			if i == 1 then
				frame:ClearAllPoints()
				frame:SetPoint(unpack(SettingsCF["position"].chat))
			elseif i == 2 and (SettingsDB.myname == "Черешок" 
				or SettingsDB.myname == "Вершок"
				or SettingsDB.myname == "Вещмешок" 
				or SettingsDB.myname == "Гребешок" 
				or SettingsDB.myname == "Кулешок" 
				or SettingsDB.myname == "Лапушок" 
				or SettingsDB.myname == "Обушок" 
				or SettingsDB.myname == "Ремешок"
				or SettingsDB.myname == "Шестак") then
				frame:ClearAllPoints()
				frame:SetPoint("TOPRIGHT", 2000, 0)
			end

			-- Save new default position and dimension
			FCF_SavePositionAndDimensions(frame)
			
			-- Set default font size
			FCF_SetChatWindowFontSize(nil, frame, SettingsCF["chat"].font_size)
			
			-- Rename combat log tab
			if i == 2 then FCF_SetWindowName(frame, GUILD_BANK_LOG) end
		end
		
		-- Enable classcolor automatically on login and on each character without doing /configure each time
		ToggleChatColorNamesByClassGroup(true, "SAY")
		ToggleChatColorNamesByClassGroup(true, "EMOTE")
		ToggleChatColorNamesByClassGroup(true, "YELL")
		ToggleChatColorNamesByClassGroup(true, "GUILD")
		ToggleChatColorNamesByClassGroup(true, "GUILD_OFFICER")
		ToggleChatColorNamesByClassGroup(true, "OFFICER")
		ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "WHISPER")
		ToggleChatColorNamesByClassGroup(true, "PARTY")
		ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID")
		ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
		ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
		ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")	
		ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
	end
	InstalledUI = true
	SavedOptions.SetCVar = true

	ReloadUI()
end

local function DisableUI()
	DisableAddOn("!aSettings"); 
	ReloadUI()
end

----------------------------------------------------------------------------------------
--	Popups
----------------------------------------------------------------------------------------
StaticPopupDialogs["INSTALL_UI"] = {
	text = L_POPUP_INSTALLUI,
	button1 = ACCEPT,
	button2 = CANCEL,
    OnAccept = InstallUI,
	OnCancel = function() InstalledUI = false SavedOptions.SetCVar = false end,
    timeout = 0,
    whileDead = 1,
	hideOnEscape = false,
}

StaticPopupDialogs["DISABLE_UI"] = {
	text = L_POPUP_DISABLEUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = DisableUI,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
}

StaticPopupDialogs["RESET_UI"] = {
	text = L_POPUP_RESETUI,
	button1 = ACCEPT,
	button2 = CANCEL,
    OnAccept = InstallUI,
	OnCancel = function() InstalledUI = true SavedOptions.SetCVar = true end,
    timeout = 0,
    whileDead = 1,
	hideOnEscape = true,
}

StaticPopupDialogs["SWITCH_RAID"] = {
	text = L_POPUP_SWITCH_RAID,
	button1 = DAMAGER,
	button2 = HEALER,
	OnAccept = function() DisableAddOn("oUF_ShestakHeal") EnableAddOn("oUF_ShestakDPS") ReloadUI() end,
	OnCancel = function() EnableAddOn("oUF_ShestakHeal") DisableAddOn("oUF_ShestakDPS") ReloadUI() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = false,
}

-- Help translate
StaticPopupDialogs["HELP_TRANSLATE"] = {
	text = "Please help us to translate the text settings for ShestakUI GUI. His translation, you can post to http://shestak.org.",
	button1 = OKAY,
    timeout = 0,
    whileDead = 1,
	hideOnEscape = true,
}

----------------------------------------------------------------------------------------
--	On logon function
----------------------------------------------------------------------------------------
local OnLogon = CreateFrame("Frame")
OnLogon:RegisterEvent("PLAYER_ENTERING_WORLD")
OnLogon:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	
	-- Show all bars
	if SettingsCF["actionbar"].always_enable == true then
		SetActionBarToggles( 1, 1, 1, 1, 0 )
	end
	
	-- Show empty buttons
	if SettingsCF["actionbar"].show_grid == true then
		ActionButton_HideGrid = function() end
		for i = 1, 12 do
			local button = _G[format("ActionButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)

			button = _G[format("BonusActionButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("MultiBarRightButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)

			button = _G[format("MultiBarBottomRightButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("MultiBarLeftButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("MultiBarBottomLeftButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
		end
	end

	if SettingsDB.getscreenresolution == "800x600"
	or SettingsDB.getscreenresolution == "1024x768"
	or SettingsDB.getscreenresolution == "720x576"
	or SettingsDB.getscreenresolution == "1024x600"
	or SettingsDB.getscreenresolution == "1152x864" then
		SetCVar("useUiScale", 0)
		StaticPopup_Show("DISABLE_UI")
	else
		SetCVar("useUiScale", 1)
		if SettingsCF["general"].multisampleprotect == true then
			SetMultisampleFormat(1)
		end
		if SettingsCF["general"].uiscale > 1 then SettingsCF["general"].uiscale = 1 end
		if SettingsCF["general"].uiscale < 0.64 then SettingsCF["general"].uiscale = 0.64 end
		SetCVar("uiScale", SettingsCF["general"].uiscale)
		if InstalledUI ~= true then
			if (SavedOptions == nil) then SavedOptions = {} end
			StaticPopup_Show("INSTALL_UI")
		end
	end
	
	if IsAddOnLoaded("oUF_ShestakDPS") and IsAddOnLoaded("oUF_ShestakHeal") then
		StaticPopup_Show("SWITCH_RAID")
	end
	
	SetCVar("showArenaEnemyFrames", 0)
	
	-- Force lua error enable
	SetCVar("scriptErrors", 1)
	
	-- Force chat CVar to be applied
	SetCVar("WholeChatWindowClickable", 0)
	SetCVar("ConversationMode", "inline")
	
	-- Welcome message
	if SettingsCF["general"].welcome_message == true then
		print("|cffffff00"..L_WELCOME_LINE_1..SettingsDB.version.." "..SettingsDB.client..".|r")
		print("|cffffff00"..L_WELCOME_LINE_2_1.." |cffffff00"..L_WELCOME_LINE_2_2)
	end
end)

SLASH_CONFIGURE1 = "/resetui"
SlashCmdList.CONFIGURE = function() StaticPopup_Show("RESET_UI") end

-- Help translate
if GetLocale() == "esES" or GetLocale() == "koKR" or GetLocale() == "esMX" then
	StaticPopup_Show("HELP_TRANSLATE")
end