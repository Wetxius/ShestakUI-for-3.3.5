----------------------------------------------------------------------------------------
--	Global strings
----------------------------------------------------------------------------------------
_G.CHAT_GUILD_GET = "|Hchannel:Guild|h["..L_CHAT_GUILD.."]|h %s:\32"
_G.CHAT_PARTY_GET = "|Hchannel:Party|h["..L_CHAT_PARTY.."]|h %s:\32"
_G.CHAT_PARTY_LEADER_GET = "|Hchannel:party|h["..L_CHAT_PARTY_LEADER.."]|h %s:\32"
_G.CHAT_PARTY_GUIDE_GET = CHAT_PARTY_LEADER_GET
_G.CHAT_RAID_GET = "|Hchannel:raid|h["..L_CHAT_RAID.."]|h %s:\32"
_G.CHAT_RAID_LEADER_GET = "|Hchannel:raid|h["..L_CHAT_RAID_LEADER.."]|h %s:\32"
_G.CHAT_RAID_WARNING_GET = "["..L_CHAT_RAID_WARNING.."] %s:\32"
_G.CHAT_BATTLEGROUND_GET = "|Hchannel:Battleground|h["..L_CHAT_BATTLEGROUND.."]|h %s:\32"
_G.CHAT_BATTLEGROUND_LEADER_GET = "|Hchannel:Battleground|h["..L_CHAT_BATTLEGROUND_LEADER.."]|h %s:\32"
_G.CHAT_OFFICER_GET = "|Hchannel:o|h["..L_CHAT_OFFICER.."]|h %s:\32"
_G.ACHIEVEMENT_BROADCAST = "%s! %s!"
_G.ACHIEVEMENT_BROADCAST_SELF = "%s!"
_G.PLAYER_SERVER_FIRST_ACHIEVEMENT = "|Hplayer:%s|h[%s]|h! $a!"
_G.SERVER_FIRST_ACHIEVEMENT = "%s! $a!"
_G.CHAT_SAY_GET = "%s:\32"
_G.CHAT_YELL_GET = "%s:\32"
_G.CHAT_FLAG_AFK = "[AFK] "
_G.CHAT_FLAG_DND = "[DND] "
_G.CHAT_FLAG_GM = "|cff4154F5[GM]|r "
if SettingsDB.client == "ruRU" then
	_G.FACTION_STANDING_DECREASED = "Отношение |3-7(%s) -%d."
	_G.FACTION_STANDING_INCREASED = "Отношение |3-7(%s) +%d."
end
_G.ERR_FRIEND_ONLINE_SS = "|Hplayer:%s|h[%s]|h "..L_CHAT_COME_ONLINE_COLOR
_G.ERR_FRIEND_OFFLINE_S = "%s "..L_CHAT_GONE_OFFLINE_COLOR

----------------------------------------------------------------------------------------
--	Custom timestamps color
----------------------------------------------------------------------------------------
TIMESTAMP_FORMAT_HHMM = "|cff"..SettingsCF["chat"].time_color.."[%I:%M]|r "
TIMESTAMP_FORMAT_HHMMSS = "|cff"..SettingsCF["chat"].time_color.."[%I:%M:%S]|r "
TIMESTAMP_FORMAT_HHMMSS_24HR = "|cff"..SettingsCF["chat"].time_color.."[%H:%M:%S]|r "
TIMESTAMP_FORMAT_HHMMSS_AMPM = "|cff"..SettingsCF["chat"].time_color.."[%I:%M:%S %p]|r "
TIMESTAMP_FORMAT_HHMM_24HR = "|cff"..SettingsCF["chat"].time_color.."[%H:%M]|r "
TIMESTAMP_FORMAT_HHMM_AMPM = "|cff"..SettingsCF["chat"].time_color.."[%I:%M %p]|r "

local AddOn = CreateFrame("Frame")
local OnEvent = function(self, event, ...) self[event](self, event, ...) end
AddOn:SetScript("OnEvent", OnEvent)

local _G = _G
local replace = string.gsub
local find = string.find

local replaceschan = {
	["(%d+)%. .-"] = "[%1]",
}

-- Hide friends micro button
FriendsMicroButton:SetScript("OnShow", FriendsMicroButton.Hide)
FriendsMicroButton:Hide()

GeneralDockManagerOverflowButton:SetScript("OnShow", GeneralDockManagerOverflowButton.Hide)
GeneralDockManagerOverflowButton:Hide()

-- Set chat style
local function SetChatStyle(frame)
	local id = frame:GetID()
	local chat = frame:GetName()

	_G[chat]:SetClampRectInsets(0, 0, 0, 0)
	
	-- Removes crap from the bottom of the chatbox so it can go to the bottom of the screen
	_G[chat]:SetClampedToScreen(false)

	-- Stop the chat chat from fading out
	_G[chat]:SetFading(false)
	
	-- Set strata to low
	_G[chat]:SetFrameStrata("LOW")
	
	-- Move the chat edit box
	_G[chat.."EditBox"]:ClearAllPoints();
	_G[chat.."EditBox"]:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", -10, 20)
	_G[chat.."EditBox"]:SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPRIGHT", 11, 20)
	
	-- Hide textures
	for j = 1, #CHAT_FRAME_TEXTURES do
		_G[chat..CHAT_FRAME_TEXTURES[j]]:SetTexture(nil)
	end

	-- Removes Default ChatFrame Tabs texture				
	SettingsDB.Kill(_G[format("ChatFrame%sTabLeft", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sTabMiddle", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sTabRight", id)])

	SettingsDB.Kill(_G[format("ChatFrame%sTabSelectedLeft", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sTabSelectedMiddle", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sTabSelectedRight", id)])
	
	SettingsDB.Kill(_G[format("ChatFrame%sTabHighlightLeft", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sTabHighlightMiddle", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sTabHighlightRight", id)])

	-- Killing off the new chat tab selected feature
	SettingsDB.Kill(_G[format("ChatFrame%sTabSelectedLeft", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sTabSelectedMiddle", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sTabSelectedRight", id)])

	-- Kills off the new method of handling the Chat Frame scroll buttons as well as the resize button
	-- Note: This also needs to include the actual frame textures for the ButtonFrame onHover
	SettingsDB.Kill(_G[format("ChatFrame%sButtonFrameUpButton", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sButtonFrameDownButton", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sButtonFrameBottomButton", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sButtonFrameMinimizeButton", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sButtonFrame", id)])
	SettingsDB.Kill(_G["ChatFrameMenuButton"])

	-- Kills off the retarded new circle around the editbox
	SettingsDB.Kill(_G[format("ChatFrame%sEditBoxFocusLeft", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sEditBoxFocusMid", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sEditBoxFocusRight", id)])
	
	SettingsDB.Kill(_G[format("ChatFrame%sTabGlow", id)])

	-- Kill off editbox artwork
	local a, b, c = select(6, _G[chat.."EditBox"]:GetRegions()); SettingsDB.Kill (a); SettingsDB.Kill (b); SettingsDB.Kill (c)
	
	-- Disable alt key usage
	_G[chat.."EditBox"]:SetAltArrowKeyMode(false)
	
	-- Hide editbox on login
	_G[chat.."EditBox"]:Hide()
	
	-- Script to hide editbox instead of fading editbox to 0.35 alpha via IM Style
	_G[chat.."EditBox"]:HookScript("OnEditFocusGained", function(self) self:Show() end)
	_G[chat.."EditBox"]:HookScript("OnEditFocusLost", function(self) self:Hide() end)
	
	-- Hide edit box every time we click on a tab
	_G[chat.."Tab"]:HookScript("OnClick", function() _G[chat.."EditBox"]:Hide() end)
	
	-- Rename combag log to log
	if _G[chat] == _G["ChatFrame2"] then
		FCF_SetWindowName(_G[chat], GUILD_BANK_LOG)
	end
end

-- Setup chatframes 1 to 10 on login
local function SetupChat(self, event, addon)	
	if addon ~= "idChat" then return end
	self:UnregisterEvent("ADDON_LOADED")

	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%s", i)]
		SetChatStyle(frame)
	end
	
	-- Remember last channel
	ChatTypeInfo.SAY.sticky = 1
	ChatTypeInfo.PARTY.sticky = 1
	ChatTypeInfo.GUILD.sticky = 1
	ChatTypeInfo.OFFICER.sticky = 1
	ChatTypeInfo.RAID.sticky = 1
	ChatTypeInfo.RAID_WARNING.sticky = 1
	ChatTypeInfo.BATTLEGROUND.sticky = 1
	ChatTypeInfo.WHISPER.sticky = 1
	ChatTypeInfo.BN_WHISPER.sticky = 1
	ChatTypeInfo.CHANNEL.sticky = 1
	
	-- Hide Blizzard Chat option that we don't need
	InterfaceOptionsSocialPanelWholeChatWindowClickable:Hide()
	InterfaceOptionsSocialPanelWholeChatWindowClickable:SetScript("OnShow", function(self) self:Hide() end) 
	InterfaceOptionsSocialPanelConversationMode:Hide()
end

local function SetupChatPosAndFont(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	for i = 1, NUM_CHAT_WINDOWS do
		local chat = _G[format("ChatFrame%s", i)]
		local id = chat:GetID()
		local name = FCF_GetChatWindowInfo(id)
		local point = GetChatWindowSavedPosition(id)
		local _, fontSize = FCF_GetChatWindowInfo(id)
		
		chat:SetFont(SettingsCF["media"].font, SettingsCF["chat"].font_size, SettingsCF["chat"].font_style)
		chat:SetSize(SettingsCF["chat"].width, SettingsCF["chat"].height)
		if i == 1 then
			chat:ClearAllPoints()
			chat:SetPoint(unpack(SettingsCF["position"].chat))
			FCF_SavePositionAndDimensions(chat)
		end
	end
	-- Reposition battle.net popup
	BNToastFrame:HookScript("OnShow", function(self)
		self:ClearAllPoints()
		self:SetPoint(unpack(SettingsCF["position"].bn_popup))
	end)
end

AddOn:RegisterEvent("ADDON_LOADED")
AddOn:RegisterEvent("PLAYER_ENTERING_WORLD")
AddOn["ADDON_LOADED"] = SetupChat
AddOn["PLAYER_ENTERING_WORLD"] = SetupChatPosAndFont

-- Setup temp chat (BN, WHISPER) when needed
local function SetupTempChat()
	local frame = FCF_GetCurrentChatFrame()
	SetChatStyle(frame)
end
hooksecurefunc("FCF_OpenTemporaryWindow", SetupTempChat)

-- Get colors for player classes
local function ClassColors(class)
	if not class then return end
	class = (replace(class, " ", "")):upper()
	local c = RAID_CLASS_COLORS[class]
	if c then
		return string.format("%02x%02x%02x", c.r*255, c.g*255, c.b*255)
	end
end

-- For Player Logins
local function CHAT_MSG_SYSTEM(...)
	local login = select(3, find(arg1, "^|Hplayer:(.+)|h%[(.+)%]|h "..L_CHAT_COME_ONLINE))
	--local classColor = "999999"
	--local foundColor = true

	if login then
		local found = false
		if GetNumFriends() > 0 then ShowFriends() end
		
		for friendIndex = 1, GetNumFriends() do
			local friendName, _, class = GetFriendInfo(friendIndex)
			if friendName == login then
				classColor = ClassColors(class)
				found = true
				break
			end
		end
		
		if not found then
			if IsInGuild() then GuildRoster() end
			for guildIndex = 1, GetNumGuildMembers(true) do
				local guildMemberName, _, _, _, _, _, _, _, _, _, class = GetGuildRosterInfo(guildIndex)
				if guildMemberName == login then
					classColor = ClassColors(class)
					break
				end
			end
		end
		
	end
	
	if login then
		-- Hook the message function
		local AddMessageOriginal = ChatFrame1.AddMessage
		local function AddMessageHook(frame, text, ...)
			text = replace(text, "^|Hplayer:(.+)|h%[(.+)%]|h", "|Hplayer:%1|h|cff"..classColor.."%2|r|h")
			ChatFrame1.AddMessage = AddMessageOriginal
			return AddMessageOriginal(frame, text, ...)
		end
		ChatFrame1.AddMessage = AddMessageHook
	end
end
AddOn:RegisterEvent("CHAT_MSG_SYSTEM")
AddOn["CHAT_MSG_SYSTEM"] = CHAT_MSG_SYSTEM

-- Hook into the AddMessage function
local function AddMessageHook(frame, text, ...)
	-- Chan text smaller or hidden
	for k,v in pairs(replaceschan) do
		text = text:gsub("|h%["..k.."%]|h", "|h"..v.."|h")
	end
	
	-- Chat highlight
	text = replace(text, L_CHAT_COME_ONLINE, L_CHAT_COME_ONLINE_COLOR)
	text = replace(text, L_CHAT_GONE_OFFLINE, L_CHAT_GONE_OFFLINE_COLOR)
	
	if find(text, replace(ERR_AUCTION_SOLD_S, "%%s", "")) then
		local itemname = text:match(replace(ERR_AUCTION_SOLD_S, "%%s", "(.+)"))
		text = "|cffef4341"..BUTTON_LAG_AUCTIONHOUSE.."|r - |cffBCD8FF"..ITEM_SOLD_COLON.."|r "
		local _, solditem = GetItemInfo(itemname)
		if solditem then
			text = text..solditem
		else
			text = text..itemname
		end
	end
	
	return AddMessageOriginal(frame, text, ...)
end

function SettingsDB.ChannelsEdits()
	for i = 1, NUM_CHAT_WINDOWS do
		if ( i ~= 2 ) then
			local frame = _G["ChatFrame"..i]
			AddMessageOriginal = frame.AddMessage
			frame.AddMessage = AddMessageHook
		end
	end
end
SettingsDB.ChannelsEdits()

----------------------------------------------------------------------------------------
--	Copy URL
----------------------------------------------------------------------------------------
local color = "00ff00"
local pattern = "[wWhH][wWtT][wWtT][\46pP]%S+[^%p%s]"

function string.color(text, color)
	return "|cff"..color..text.."|r"
end

function string.link(text, type, value, color)
	return "|H"..type..":"..tostring(value).."|h"..tostring(text):color(color or "ffffff").."|h"
end

StaticPopupDialogs["LINKME"] = {
	text = L_CHAT_URL,
	button2 = CANCEL,
	hasEditBox = true,
    hasWideEditBox = true,
	timeout = 0,
	exclusive = 1,
	hideOnEscape = true,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
	whileDead = 1,
	maxLetters = 255,
}

local function f(url)
	return string.link("["..url.."]", "url", url, color)
end

local function hook(self, text, ...)
	self:f(text:gsub(pattern, f), ...)
end

for i = 1, NUM_CHAT_WINDOWS do
	if ( i ~= 2 ) then
		local frame = _G["ChatFrame"..i]
		frame.f = frame.AddMessage
		frame.AddMessage = hook
	end
end

local f = ChatFrame_OnHyperlinkShow
function ChatFrame_OnHyperlinkShow(self, link, text, button)
	local type, value = link:match("(%a+):(.+)")
	if ( type == "url" ) then
		local dialog = StaticPopup_Show("LINKME")
		local editbox = _G[dialog:GetName().."WideEditBox"]  
		editbox:SetText(value)
		editbox:SetFocus()
		editbox:HighlightText()
		local button = _G[dialog:GetName().."Button2"]
            
		button:ClearAllPoints()
           
		button:SetPoint("CENTER", editbox, "CENTER", 0, -30)
	else
		f(self, link, text, button)
	end
end

----------------------------------------------------------------------------------------
--	Copy Chat
----------------------------------------------------------------------------------------
local lines = {}
local frame = nil
local editBox = nil
local isf = nil

local function CreatCopyFrame()
	frame = CreateFrame("Frame", "CopyFrame", UIParent)
	SettingsDB.CreateBlizzard(frame)
	frame:SetWidth(500)
	frame:SetHeight(300)
	frame:SetScale(0.85)
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
	frame:Hide()
	frame:SetFrameStrata("DIALOG")

	local scrollArea = CreateFrame("ScrollFrame", "CopyScroll", frame, "UIPanelScrollFrameTemplate")
	scrollArea:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -30)
	scrollArea:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 8)

	editBox = CreateFrame("EditBox", "CopyBox", frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	editBox:SetWidth(500)
	editBox:SetHeight(300)
	editBox:SetScript("OnEscapePressed", function() frame:Hide() end)

	scrollArea:SetScrollChild(editBox)

	local close = CreateFrame("Button", "CopyCloseButton", frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", frame, "TOPRIGHT")

	isf = true
end

local function GetLines(...)
	-- Grab all those 
	local ct = 1
	for i = select("#", ...), 1, -1 do
		local region = select(i, ...)
		if region:GetObjectType() == "FontString" then
			lines[ct] = tostring(region:GetText())
			ct = ct + 1
		end
	end
	return ct - 1
end

local function Copy(cf)
	local _, size = cf:GetFont()
	FCF_SetChatWindowFontSize(cf, cf, 0.01)
	local lineCt = GetLines(cf:GetRegions())
	local text = table.concat(lines, "\n", 1, lineCt)
	FCF_SetChatWindowFontSize(cf, cf, size)
	if not isf then CreatCopyFrame() end
	if frame:IsShown() then frame:Hide() return end
	frame:Show()
	editBox:SetText(text)
end

function SettingsDB.ChatCopyButtons()
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G[format("ChatFrame%d",  i)]
		local button = CreateFrame("Button", format("ButtonCF%d", i), cf)
		button:SetPoint("BOTTOMRIGHT", 0, 1)
		button:SetHeight(20)
		button:SetWidth(20)
		button:SetAlpha(0)
		SettingsDB.CreateBlizzard(button)
		button:SetBackdropBorderColor(RAID_CLASS_COLORS[select(2, UnitClass("player"))].r, RAID_CLASS_COLORS[select(2, UnitClass("player"))].g, RAID_CLASS_COLORS[select(2, UnitClass("player"))].b)

		local buttontext = button:CreateFontString(nil, "OVERLAY", nil)
		buttontext:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size * 2, SettingsCF["media"].font_style)
		buttontext:SetText("C")
		buttontext:SetPoint("CENTER")
		buttontext:SetJustifyH("CENTER")
		buttontext:SetJustifyV("CENTER")
		
		button:SetScript("OnMouseUp", function(self, btn)
			if i == 1 and btn == "RightButton" then
				ToggleFrame(ChatMenu)
			else
				Copy(cf)
			end
		end)
		button:SetScript("OnEnter", function() button:SetAlpha(1) end)
		button:SetScript("OnLeave", function() button:SetAlpha(0) end)
		local tab = _G[format("ChatFrame%dTab", i)]
		tab:SetScript("OnShow", function() button:Show() end)
		tab:SetScript("OnHide", function() button:Hide() end)
	end
end
SettingsDB.ChatCopyButtons()

----------------------------------------------------------------------------------------
--	Chat Filter
----------------------------------------------------------------------------------------
if SettingsCF["chat"].filter == true then
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_JOIN", function(msg) return true end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_LEAVE", function(msg) return true end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE", function(msg) return true end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", function(msg) return true end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", function(msg) return true end)
	DUEL_WINNER_KNOCKOUT = ""
	DUEL_WINNER_RETREAT = ""
	DRUNK_MESSAGE_ITEM_OTHER1 = ""
	DRUNK_MESSAGE_ITEM_OTHER2 = ""
	DRUNK_MESSAGE_ITEM_OTHER3 = ""
	DRUNK_MESSAGE_ITEM_OTHER4 = ""
	DRUNK_MESSAGE_OTHER1 = ""
	DRUNK_MESSAGE_OTHER2 = ""
	DRUNK_MESSAGE_OTHER3 = ""
	DRUNK_MESSAGE_OTHER4 = ""
	DRUNK_MESSAGE_ITEM_SELF1 = ""
	DRUNK_MESSAGE_ITEM_SELF2 = ""
	DRUNK_MESSAGE_ITEM_SELF3 = ""
	DRUNK_MESSAGE_ITEM_SELF4 = ""
	DRUNK_MESSAGE_SELF1 = ""
	DRUNK_MESSAGE_SELF2 = ""
	DRUNK_MESSAGE_SELF3 = ""
	DRUNK_MESSAGE_SELF4 = ""
	RAID_MULTI_LEAVE = ""
	RAID_MULTI_JOIN = ""
	ERR_PET_LEARN_ABILITY_S = ""
	ERR_PET_LEARN_SPELL_S = ""
	ERR_PET_SPELL_UNLEARNED_S = ""
end

----------------------------------------------------------------------------------------
--	Chat Scroll Module
----------------------------------------------------------------------------------------
hooksecurefunc("FloatingChatFrame_OnMouseScroll", function(self, dir)
	if dir > 0 then
		if IsShiftKeyDown() then
			self:ScrollToTop()
		elseif IsControlKeyDown() then
			self:ScrollUp()
			self:ScrollUp()
		end
	elseif dir < 0 then
		if IsShiftKeyDown() then
			self:ScrollToBottom()
		elseif IsControlKeyDown() then
			self:ScrollDown()
			self:ScrollDown()
		end
	end
end)

----------------------------------------------------------------------------------------
--	Tell Target
----------------------------------------------------------------------------------------
for i = 1, NUM_CHAT_WINDOWS do
	local editBox = _G["ChatFrame"..i.."EditBox"]
	editBox:HookScript("OnTextChanged", function(self)
	   local text = self:GetText()
	   if text:len() < 5 then
		  if text:sub(1, 4) == "/tt " then
			 local unitname, realm
			 unitname, realm = UnitName("target")
			 if unitname then unitname = gsub(unitname, " ", "") end
			 if unitname and not UnitIsSameServer("player", "target") then
				unitname = unitname .. "-" .. gsub(realm, " ", "")
			 end
			 ChatFrame_SendTell((unitname or SPELL_FAILED_BAD_TARGETS), ChatFrame1)
		  end
	   end
	end)
end

----------------------------------------------------------------------------------------
--	ChatBar(FavChatBar by Favorit)
----------------------------------------------------------------------------------------
if SettingsCF["chat"].chat_bar == true then
	local cbar = CreateFrame("Frame", "favchat", favchat)
	cbar:SetScript("OnEvent", function(self, event, ...) self[event](self, event, ...) end)
	cbar:RegisterEvent("ADDON_LOADED")

	function cbar:SW(button)
		if(button == "RightButton") then
			ChatFrame_OpenChat("/w ", SELECTED_DOCK_FRAME);		
		else
			ChatFrame_OpenChat("/s ", SELECTED_DOCK_FRAME);	
		end
	end

	function cbar:GO(button)
		if(button == "RightButton") then
			ChatFrame_OpenChat("/o ", SELECTED_DOCK_FRAME);		
		else
			ChatFrame_OpenChat("/g ", SELECTED_DOCK_FRAME);	
		end
	end

	function cbar:RP(button)
		if(button == "RightButton") then
			ChatFrame_OpenChat("/raid ", SELECTED_DOCK_FRAME);		
		else
			ChatFrame_OpenChat("/p ", SELECTED_DOCK_FRAME);	
		end
	end

	function cbar:GT(button)
		if(button == "RightButton") then
			ChatFrame_OpenChat("/2 ", SELECTED_DOCK_FRAME);		
		else
			ChatFrame_OpenChat("/1 ", SELECTED_DOCK_FRAME);	
		end
	end

	function cbar:YG(button)
		if(button == "RightButton") then
			ChatFrame_OpenChat("/y ", SELECTED_DOCK_FRAME);		
		else
			ChatFrame_OpenChat("/3 ", SELECTED_DOCK_FRAME);	
		end
	end

	function cbar:Style()
		favchat:ClearAllPoints()
		favchat:SetParent(UIParent)

		sw = CreateFrame("Button", "sw", favchat)
		sw:ClearAllPoints()
		sw:SetParent(favchat)
		sw:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 3, SettingsCF["chat"].height+4)
		sw:SetWidth(14)
		sw:SetHeight(14)
		SettingsDB.CreateTemplate(sw)
		sw:SetBackdropBorderColor(0.7, 0.33, 0.82, 1)
		sw:RegisterForClicks("AnyUp")
		sw:SetScript("OnClick", cbar.SW)
		swtex = sw:CreateTexture(nil, "ARTWORK")
		swtex:SetTexture(SettingsCF["media"].blank)
		swtex:SetVertexColor(0.8, 0.8, 0.8, 1)
		swtex:SetPoint("TOPLEFT", sw, "TOPLEFT", 2, -2)
		swtex:SetPoint("BOTTOMRIGHT", sw, "BOTTOMRIGHT", -2, 2)
		
		go = CreateFrame("Button", "go", favchat)
		go:ClearAllPoints()
		go:SetParent(favchat)
		go:SetPoint("TOP", sw, "BOTTOM", 0, -10)
		go:SetWidth(14)
		go:SetHeight(14)
		SettingsDB.CreateTemplate(go)
		go:SetBackdropBorderColor(0, 0.54, 0, 1)
		go:RegisterForClicks("AnyUp")
		go:SetScript("OnClick", cbar.GO)
		gotex = sw:CreateTexture(nil, "ARTWORK")
		gotex:SetTexture(SettingsCF["media"].blank)
		gotex:SetVertexColor(0, 0.8, 0, 1)
		gotex:SetPoint("TOPLEFT", go, "TOPLEFT", 2, -2)
		gotex:SetPoint("BOTTOMRIGHT", go, "BOTTOMRIGHT", -2, 2)
		
		rp = CreateFrame("Button", "rp", favchat)
		rp:ClearAllPoints()
		rp:SetParent(favchat)
		rp:SetPoint("TOP", go, "BOTTOM", 0, -10)
		rp:SetWidth(14)
		rp:SetHeight(14)
		SettingsDB.CreateTemplate(rp)
		rp:SetBackdropBorderColor(0.8, 0.4, 0.1, 1)
		rp:RegisterForClicks("AnyUp")
		rp:SetScript("OnClick", cbar.RP)
		rptex = rp:CreateTexture(nil, "ARTWORK")
		rptex:SetTexture(SettingsCF["media"].blank)
		rptex:SetVertexColor(0.11, 0.5, 0.7, 1)
		rptex:SetPoint("TOPLEFT", rp, "TOPLEFT", 2, -2)
		rptex:SetPoint("BOTTOMRIGHT", rp, "BOTTOMRIGHT", -2, 2)

		gt = CreateFrame("Button", "gt", favchat)
		gt:ClearAllPoints()
		gt:SetParent(favchat)
		gt:SetPoint("TOP", rp, "BOTTOM", 0, -10)
		gt:SetWidth(14)
		gt:SetHeight(14)
		SettingsDB.CreateTemplate(gt)
		gt:SetBackdropBorderColor(0.7, 0.7, 0, 1)
		gt:RegisterForClicks("AnyUp")
		gt:SetScript("OnClick", cbar.GT)
		gttex = rp:CreateTexture(nil, "ARTWORK")
		gttex:SetTexture(SettingsCF["media"].blank)
		gttex:SetVertexColor(0.93, 0.8, 0.8, 1)
		gttex:SetPoint("TOPLEFT", gt, "TOPLEFT", 2, -2)
		gttex:SetPoint("BOTTOMRIGHT", gt, "BOTTOMRIGHT", -2, 2)

		yg = CreateFrame("Button", "yg", favchat)
		yg:ClearAllPoints()
		yg:SetParent(favchat)
		yg:SetPoint("TOP", gt, "BOTTOM", 0, -10)
		yg:SetWidth(14)
		yg:SetHeight(14)
		SettingsDB.CreateTemplate(yg)
		yg:SetBackdropBorderColor(0.7, 0.13, 0.13, 1)
		yg:RegisterForClicks("AnyUp")
		yg:SetScript("OnClick", cbar.YG)
		ygtex = rp:CreateTexture(nil, "ARTWORK")
		ygtex:SetTexture(SettingsCF["media"].blank)
		ygtex:SetVertexColor(0.5, 1, 0.83, 1)
		ygtex:SetPoint("TOPLEFT", yg, "TOPLEFT", 2, -2)
		ygtex:SetPoint("BOTTOMRIGHT", yg, "BOTTOMRIGHT", -2, 2)
		
	end

	function cbar:ADDON_LOADED(event, name)
		self:Style()
	end
end

----------------------------------------------------------------------------------------
--	Play sound files system(by Tukz)
----------------------------------------------------------------------------------------
if SettingsCF["chat"].whisp_sound == true then
	local SoundSys = CreateFrame("Frame")
	SoundSys:RegisterEvent("CHAT_MSG_WHISPER")
	SoundSys:RegisterEvent("CHAT_MSG_BN_WHISPER")
	SoundSys:HookScript("OnEvent", function(self, event, ...)
		if event == "CHAT_MSG_WHISPER" or "CHAT_MSG_BN_WHISPER" then
			PlaySoundFile(SettingsCF["media"].whisp_sound)
		end
	end)
end

----------------------------------------------------------------------------------------
--	Repeat spam filter(by Evl)
----------------------------------------------------------------------------------------
ChatFrame1.repeatFilter = true
ChatFrame1:SetTimeVisible(10)

local lastMessage
local repeatMessageFilter = function(self, event, text, sender, ...)
	if self.repeatFilter then
		if not self.repeatMessages or self.repeatCount > 100 then
			self.repeatCount = 0
			self.repeatMessages = {}
		end
		lastMessage = self.repeatMessages[sender]
		if lastMessage == text then
			return true
		end
		self.repeatMessages[sender] = text
		self.repeatCount = self.repeatCount + 1
	end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", repeatMessageFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", repeatMessageFilter)