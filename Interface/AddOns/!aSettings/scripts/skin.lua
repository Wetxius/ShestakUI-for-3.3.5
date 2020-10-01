----------------------------------------------------------------------------------------
--	Reskin Blizzard windows(by Tukz and Co)
----------------------------------------------------------------------------------------
local function SetModifiedBackdrop(self)
	local color = RAID_CLASS_COLORS[SettingsDB.myclass]
	self:SetBackdropColor(color.r, color.g, color.b, 0.15)
	self:SetBackdropBorderColor(color.r, color.g, color.b)
end

local function SetOriginalBackdrop(self)
	self:SetBackdropColor(0, 0, 0, 0.8)
	self:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
end

local function SkinButton(f)
	f:SetNormalTexture("")
	f:SetHighlightTexture("")
	f:SetPushedTexture("")
	f:SetDisabledTexture("")
	SettingsDB.CreateBlizzard(f)
	f:HookScript("OnEnter", SetModifiedBackdrop)
	f:HookScript("OnLeave", SetOriginalBackdrop)
end

local SkinBlizzUI = CreateFrame("Frame")
SkinBlizzUI:RegisterEvent("ADDON_LOADED")
SkinBlizzUI:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Skinner") then return end

	-- Stuff not in Blizzard load-on-demand
	if addon == "!aSettings" then
		-- Blizzard Frame reskin
		local skins = {
			"StaticPopup1",
			"StaticPopup2",
			"AutoCompleteBox",
			"GameMenuFrame",
			"InterfaceOptionsFrame",
			"VideoOptionsFrame",
			"AudioOptionsFrame",
			"LFDDungeonReadyStatus",
			"LFDDungeonReadyDialog",
			"BNToastFrame",
			"TicketStatusFrameButton",
			"DropDownList1MenuBackdrop",
			"DropDownList2MenuBackdrop",
			"DropDownList1Backdrop",
			"DropDownList2Backdrop",
			"LFDSearchStatus",
			"ColorPickerFrame",
			"ConsolidatedBuffsTooltip",
			"ReadyCheckFrame",
			"LFDRoleCheckPopup",
			"VoiceChatTalkers",
			"ChannelPulloutBackground",
		}
 
		-- Reskin popup buttons
		for i = 1, 2 do
			for j = 1, 2 do
				SkinButton(_G["StaticPopup"..i.."Button"..j])
			end
		end
 
		for i = 1, getn(skins) do
			SettingsDB.CreateBlizzard(_G[skins[i]])
		end
 
		local ChatMenus = {
			"ChatMenu",
			"EmoteMenu",
			"LanguageMenu",
			"VoiceMacroMenu"
		}
 
		for i = 1, getn(ChatMenus) do
			if _G[ChatMenus[i]] == _G["ChatMenu"] then
				_G[ChatMenus[i]]:HookScript("OnShow", function(self) SettingsDB.CreateBlizzard(self) self:ClearAllPoints() self:SetPoint("BOTTOMRIGHT", ChatFrame1, "BOTTOMRIGHT", 0, 30) end)
			else
				_G[ChatMenus[i]]:HookScript("OnShow", function(self) SettingsDB.CreateBlizzard(self) end)
			end
		end
 
		-- Reskin all esc/menu buttons
		local BlizzardMenuButtons = {
			"Options",
			"SoundOptions",
			"UIOptions",
			"Keybindings",
			"Macros",
			"AddOns",
			"Logout",
			"Quit",
			"Continue",
			"MacOptions"
		}
		
		for i = 1, getn(BlizzardMenuButtons) do
		local UIMenuButtons = _G["GameMenuButton"..BlizzardMenuButtons[i]]
			if UIMenuButtons then
				SkinButton(UIMenuButtons)
			end
		end
 
		-- Hide header textures and move text
		local BlizzardHeader = {
			"GameMenuFrame",
			"InterfaceOptionsFrame",
			"AudioOptionsFrame",
			"VideoOptionsFrame",
			"ColorPickerFrame"
		}
		
		for i = 1, getn(BlizzardHeader) do
			local title = _G[BlizzardHeader[i].."Header"]
			if title then
				title:SetTexture("")
				title:ClearAllPoints()
				if title == _G["GameMenuFrameHeader"] then
					title:SetPoint("TOP", GameMenuFrame, 0, 7)
				else
					title:SetPoint("TOP", BlizzardHeader[i], 0, 0)
				end
			end
		end
		
		-- Reskin "normal" buttons
		local BlizzardButtons = {
			"VideoOptionsFrameOkay",
			"VideoOptionsFrameCancel",
			"VideoOptionsFrameDefaults",
			"VideoOptionsFrameApply",
			"AudioOptionsFrameOkay",
			"AudioOptionsFrameCancel",
			"AudioOptionsFrameDefaults",
			"InterfaceOptionsFrameDefaults",
			"InterfaceOptionsFrameOkay",
			"InterfaceOptionsFrameCancel",
			"ColorPickerOkayButton",
			"ColorPickerCancelButton",
			"ReadyCheckFrameYesButton",
			"ReadyCheckFrameNoButton",
			--"LFDDungeonReadyDialogLeaveQueueButton",
			--"LFDDungeonReadyDialogEnterDungeonButton",
		}
		
		for i = 1, getn(BlizzardButtons) do
		local UIButtons = _G[BlizzardButtons[i]]
			if UIButtons then
				SkinButton(UIButtons)
			end
		end
		
		-- Button position
		_G["VideoOptionsFrameCancel"]:ClearAllPoints()
		_G["VideoOptionsFrameCancel"]:SetPoint("RIGHT", _G["VideoOptionsFrameApply"], "LEFT", -4, 0)		 
		_G["VideoOptionsFrameOkay"]:ClearAllPoints()
		_G["VideoOptionsFrameOkay"]:SetPoint("RIGHT", _G["VideoOptionsFrameCancel"], "LEFT", -4, 0)	
		_G["AudioOptionsFrameOkay"]:ClearAllPoints()
		_G["AudioOptionsFrameOkay"]:SetPoint("RIGHT", _G["AudioOptionsFrameCancel"], "LEFT", -4, 0)		 	 
		_G["InterfaceOptionsFrameOkay"]:ClearAllPoints()
		_G["InterfaceOptionsFrameOkay"]:SetPoint("RIGHT", _G["InterfaceOptionsFrameCancel"], "LEFT", -4, 0)
		_G["ColorPickerCancelButton"]:ClearAllPoints()
		_G["ColorPickerCancelButton"]:SetPoint("BOTTOMRIGHT", ColorPickerFrame, "BOTTOMRIGHT", -6, 6)
		_G["ColorPickerOkayButton"]:ClearAllPoints()
		_G["ColorPickerOkayButton"]:SetPoint("RIGHT", _G["ColorPickerCancelButton"], "LEFT", -4, 0)
		_G["ReadyCheckFrameYesButton"]:SetParent(_G["ReadyCheckFrame"])
		_G["ReadyCheckFrameNoButton"]:SetParent(_G["ReadyCheckFrame"]) 
		_G["ReadyCheckFrameYesButton"]:SetPoint("RIGHT", _G["ReadyCheckFrame"], "CENTER", -3, 0)
		_G["ReadyCheckFrameNoButton"]:SetPoint("LEFT", _G["ReadyCheckFrameYesButton"], "RIGHT", 5, 0)
		_G["ReadyCheckFrameText"]:SetParent(_G["ReadyCheckFrame"])
		_G["ReadyCheckFrameText"]:ClearAllPoints()
		_G["ReadyCheckFrameText"]:SetPoint("TOP", 0, -12)
		
		-- Others
		_G["ReadyCheckListenerFrame"]:SetAlpha(0)
		_G["ReadyCheckFrame"]:HookScript("OnShow", function(self) if UnitIsUnit("player", self.initiator) then self:Hide() end end)
	end
	
	-- MAC menu/option panel(by Affli)
	if IsMacClient() then
		-- Skin main frame and reposition the header
		SettingsDB.CreateBlizzard(MacOptionsFrame)
		MacOptionsFrameHeader:SetTexture("")
		MacOptionsFrameHeader:ClearAllPoints()
		MacOptionsFrameHeader:SetPoint("TOP", MacOptionsFrame, 0, 0)
 
		-- Skin internal frames
		SettingsDB.CreateBlizzard(MacOptionsFrameMovieRecording)
		SettingsDB.CreateBlizzard(MacOptionsITunesRemote)
 
		-- Skin buttons
		SkinButton(_G["MacOptionsFrameCancel"])
		SkinButton(_G["MacOptionsFrameOkay"])
		SkinButton(_G["MacOptionsButtonKeybindings"])
		SkinButton(_G["MacOptionsFrameDefaults"])
		SkinButton(_G["MacOptionsButtonCompress"])
 
		-- Reposition and resize buttons
		tPoint, tRTo, tRP, tX, tY =  _G["MacOptionsButtonCompress"]:GetPoint()
		_G["MacOptionsButtonCompress"]:SetWidth(136)
		_G["MacOptionsButtonCompress"]:SetPoint(tPoint, tRTo, tRP, tX + 4, tY)
 
		_G["MacOptionsFrameCancel"]:SetWidth(96)
		_G["MacOptionsFrameCancel"]:SetHeight(22)
		tPoint, tRTo, tRP, tX, tY =  _G["MacOptionsFrameCancel"]:GetPoint()
		_G["MacOptionsFrameCancel"]:SetPoint(tPoint, tRTo, tRP, tX - 2, tY)
 
		_G["MacOptionsFrameOkay"]:ClearAllPoints()
		_G["MacOptionsFrameOkay"]:SetWidth(96)
		_G["MacOptionsFrameOkay"]:SetHeight(22)
		_G["MacOptionsFrameOkay"]:SetPoint("LEFT", _G["MacOptionsFrameCancel"], -99, 0)
 
		_G["MacOptionsButtonKeybindings"]:ClearAllPoints()
		_G["MacOptionsButtonKeybindings"]:SetWidth(96)
		_G["MacOptionsButtonKeybindings"]:SetHeight(22)
		_G["MacOptionsButtonKeybindings"]:SetPoint("LEFT", _G["MacOptionsFrameOkay"], -99, 0)
 
		_G["MacOptionsFrameDefaults"]:SetWidth(96)
		_G["MacOptionsFrameDefaults"]:SetHeight(22)
	end
end)