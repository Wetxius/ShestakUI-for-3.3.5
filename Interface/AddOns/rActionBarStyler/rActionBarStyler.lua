local fbar1 = CreateFrame("Frame", "Bar1Holder", UIParent)
fbar1:SetWidth((SettingsCF["actionbar"].button_size * 12) + 33)
fbar1:SetHeight(SettingsCF["actionbar"].button_size + 2)
fbar1:SetPoint(unpack(SettingsCF["position"].actionbars.bar1))
fbar1:Show()

local fbar2 = CreateFrame("Frame", "Bar2Holder", UIParent)
fbar2:SetWidth((SettingsCF["actionbar"].button_size * 12) + 33)
fbar2:SetHeight(SettingsCF["actionbar"].button_size + 2)
fbar2:SetPoint(unpack(SettingsCF["position"].actionbars.bar2))
fbar2:Show()

local fbar3 = CreateFrame("Frame", "Bar3Holder", UIParent)
if SettingsCF["actionbar"].rightbars_three == true then
	fbar3:SetHeight((SettingsCF["actionbar"].button_size * 12) + 33)
	fbar3:SetWidth(SettingsCF["actionbar"].button_size + 2)
else
	fbar3:SetWidth((SettingsCF["actionbar"].button_size * 12) + 33)
	fbar3:SetHeight(SettingsCF["actionbar"].button_size + 2)
	fbar3:SetPoint(unpack(SettingsCF["position"].actionbars.bar3_bottom))
end
fbar3:Show()

local fbar45 = CreateFrame("Frame", "Bar45Holder", UIParent)
if SettingsCF["actionbar"].rightbars_three == true then
	fbar45:SetWidth((SettingsCF["actionbar"].button_size * 3) + 6)
	fbar45:SetHeight((SettingsCF["actionbar"].button_size * 12) + 33)
else
	fbar45:SetWidth((SettingsCF["actionbar"].button_size * 2) + 3)
	fbar45:SetHeight((SettingsCF["actionbar"].button_size * 12) + 33)
end
fbar45:SetPoint(unpack(SettingsCF["position"].actionbars.bar45)) 
fbar45:Show()

local fbag = CreateFrame("Frame", "BagHolder", UIParent)
fbag:SetWidth(198)
fbag:SetHeight(39)
fbag:SetPoint(unpack(SettingsCF["position"].actionbars.bags))
fbag:Show()

local fmicro = CreateFrame("Frame", "MicroMenuHolder", UIParent)
fmicro:SetWidth(253)
fmicro:SetHeight(37)
fmicro:SetPoint(unpack(SettingsCF["position"].actionbars.menu))
fmicro:Show()

local fpet = CreateFrame("Frame", "PetBarHolder", UIParent)
if SettingsCF["actionbar"].petbar_horizontal == true then
	fpet:SetWidth((SettingsCF["actionbar"].button_size * 10) + 27)
	fpet:SetHeight(SettingsCF["actionbar"].button_size + 2)
else
	fpet:SetWidth(SettingsCF["actionbar"].button_size + 2)
	fpet:SetHeight((SettingsCF["actionbar"].button_size * 10) + 27)
end
if SettingsCF["actionbar"].rightbars_three == true then
	if SettingsCF["actionbar"].petbar_horizontal == true then
		fpet:SetPoint(unpack(SettingsCF["position"].actionbars.pet_horizontal))
	else
		fpet:SetPoint(unpack(SettingsCF["position"].actionbars.pet_vertical))
	end
else
	if SettingsCF["actionbar"].petbar_horizontal == true then
		fpet:SetPoint(unpack(SettingsCF["position"].actionbars.pet_horizontal))
	else
		fpet:SetPoint(unpack(SettingsCF["position"].actionbars.pet_vertical))
	end
end

local fshift = CreateFrame("Frame", "ShapeShiftHolder", UIParent)
fshift:SetWidth(196)
fshift:SetHeight(SettingsCF["actionbar"].button_size + 2)
fshift:SetPoint(unpack(SettingsCF["position"].actionbars.stance))

local vehicle = CreateFrame("BUTTON", nil, UIParent, "SecureActionButtonTemplate")
vehicle:SetWidth(SettingsCF["actionbar"].button_size)
vehicle:SetHeight(SettingsCF["actionbar"].button_size)
vehicle:SetPoint(unpack(SettingsCF["position"].actionbars.vehicle)) 
SettingsDB.CreateTemplate(vehicle)

vehicle:RegisterForClicks("AnyUp")
vehicle:SetScript("OnClick", function(self) VehicleExit() end)

vehicle:SetNormalTexture("Interface\\AddOns\\!aSettings\\media\\vehicle")
vehicle:SetPushedTexture("Interface\\AddOns\\!aSettings\\media\\vehicle")
vehicle:SetHighlightTexture("Interface\\AddOns\\!aSettings\\media\\vehicle")

vehicle:RegisterEvent("UNIT_ENTERING_VEHICLE")
vehicle:RegisterEvent("UNIT_ENTERED_VEHICLE")
vehicle:RegisterEvent("UNIT_EXITING_VEHICLE")
vehicle:RegisterEvent("UNIT_EXITED_VEHICLE")
vehicle:SetScript("OnEvent", function(self, event, ...)
local arg1 = ...;
	if(((event == "UNIT_ENTERING_VEHICLE") or (event == "UNIT_ENTERED_VEHICLE")) and arg1 == "player") then
		vehicle:SetAlpha(1)
	elseif(((event == "UNIT_EXITING_VEHICLE") or (event == "UNIT_EXITED_VEHICLE")) and arg1 == "player") then
		vehicle:SetAlpha(0)
	end
end)  
vehicle:SetAlpha(0)

local i, f

for i = 1, 12 do
	_G["ActionButton"..i]:SetParent(fbar1)
end
ActionButton1:ClearAllPoints()
ActionButton1:SetPoint("BOTTOMLEFT", fbar1, "BOTTOMLEFT", 0, 0)
for i = 2, 12 do
	local b = _G["ActionButton"..i]
	local b2 = _G["ActionButton"..i - 1]
	b:ClearAllPoints()
	b:SetPoint("LEFT", b2, "RIGHT", 3, 0)
end

BonusActionBarFrame:SetParent(fbar1)
BonusActionBarFrame:SetWidth(0.01)
BonusActionBarTexture0:Hide()
BonusActionBarTexture1:Hide()
BonusActionButton1:ClearAllPoints()
BonusActionButton1:SetPoint("BOTTOMLEFT", fbar1, "BOTTOMLEFT", 0, 0)
for i = 2, 12 do
	local b = _G["BonusActionButton"..i]
	local b2 = _G["BonusActionButton"..i - 1]
	b:ClearAllPoints()
	b:SetPoint("LEFT", b2, "RIGHT", 3, 0)
end

MultiBarBottomLeftButton1:ClearAllPoints()
MultiBarBottomLeftButton1:SetPoint("BOTTOMLEFT", fbar2, "BOTTOMLEFT", 0, 0)
for i = 2, 12 do
	local b = _G["MultiBarBottomLeftButton"..i]
	local b2 = _G["MultiBarBottomLeftButton"..i - 1]
	b:ClearAllPoints()
	b:SetPoint("LEFT", b2, "RIGHT", 3, 0)
end

if SettingsCF["actionbar"].rightbars_three == true then
	MultiBarBottomRight:SetParent(fbar45)
	MultiBarBottomRight:ClearAllPoints()
	MultiBarBottomRightButton1:ClearAllPoints()
	MultiBarBottomRightButton1:SetPoint("TOPRIGHT", fbar45, "TOPRIGHT", -((SettingsCF["actionbar"].button_size * 2) + 6), 0)
	for i = 2, 12 do
		local b = _G["MultiBarBottomRightButton"..i]
		local b2 = _G["MultiBarBottomRightButton"..i - 1]
		b:ClearAllPoints()
		b:SetPoint("TOP", b2, "BOTTOM", 0, -3)
	end
else
	MultiBarBottomRight:SetParent(fbar3)
	MultiBarBottomRight:ClearAllPoints()
	MultiBarBottomRightButton1:ClearAllPoints()
	MultiBarBottomRightButton1:SetPoint("BOTTOMLEFT", fbar3, "BOTTOMLEFT", 0, 0)
	for i = 2, 12 do
		local b = _G["MultiBarBottomRightButton"..i]
		local b2 = _G["MultiBarBottomRightButton"..i - 1]
		b:ClearAllPoints()
		b:SetPoint("LEFT", b2, "RIGHT", 3, 0)
	end
end

MultiBarLeft:SetParent(fbar45)
MultiBarLeft:ClearAllPoints()
MultiBarLeftButton1:ClearAllPoints()
MultiBarLeftButton1:SetPoint("TOPRIGHT", fbar45, "TOPRIGHT", -(SettingsCF["actionbar"].button_size + 3), 0)
for i = 2, 12 do
	local b = _G["MultiBarLeftButton"..i]
	local b2 = _G["MultiBarLeftButton"..i - 1]
	b:ClearAllPoints()
	b:SetPoint("TOP", b2, "BOTTOM", 0, -3)
end

MultiBarRight:SetParent(fbar45)
MultiBarRight:ClearAllPoints()
MultiBarRightButton1:ClearAllPoints()
MultiBarRightButton1:SetPoint("TOPRIGHT", fbar45, "TOPRIGHT", 0, 0)
for i = 2, 12 do
	local b = _G["MultiBarRightButton"..i]
	local b2 = _G["MultiBarRightButton"..i - 1]
	b:ClearAllPoints()
	b:SetPoint("TOP", b2, "BOTTOM", 0, -3)
end

ShapeshiftBarFrame:SetParent(fshift)
ShapeshiftButton1:ClearAllPoints()
ShapeshiftButton1:SetPoint("BOTTOMLEFT", fshift, "BOTTOMLEFT", 0, 0)
local function MoveShapeshift()
	ShapeshiftButton1:SetPoint("BOTTOMLEFT", fshift, "BOTTOMLEFT", 0, 0)
end
if not InCombatLockdown() then
	hooksecurefunc("ShapeshiftBar_Update", MoveShapeshift)
end
for i = 2, 10 do
	local b = _G["ShapeshiftButton"..i]
	local b2 = _G["ShapeshiftButton"..i - 1]
	b:ClearAllPoints()
	b:SetPoint("LEFT", b2, "RIGHT", 3, 0)
end

if SettingsDB.myclass == "SHAMAN" then
	if MultiCastActionBarFrame then
		MultiCastActionBarFrame:SetParent(fshift)
		MultiCastActionBarFrame:ClearAllPoints()
		MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", fshift, "BOTTOMLEFT", 0, 0)

		for i = 1, 4 do
			local b = _G["MultiCastSlotButton"..i]
			local b2 = _G["MultiCastActionButton"..i]

			b:ClearAllPoints()
			b:SetAllPoints(b2)
		end

		MultiCastActionBarFrame.SetParent = SettingsDB.dummy
		MultiCastActionBarFrame.SetPoint = SettingsDB.dummy
		--MultiCastRecallSpellButton.SetPoint = SettingsDB.dummy --It Tainty when switching panels during the battle
	end
end

PossessBarFrame:SetParent(fshift)
PossessButton1:ClearAllPoints()
PossessButton1:SetPoint("BOTTOMLEFT", fshift, "BOTTOMLEFT")

if SettingsCF["actionbar"].petbar_horizontal == true then
	PetActionBarFrame:SetParent(fpet)
	PetActionButton1:ClearAllPoints()
	PetActionButton1:SetPoint("BOTTOMLEFT", fpet, "BOTTOMLEFT", 0, 0)
	for i = 2, 10 do
		local b = _G["PetActionButton"..i]
		local b2 = _G["PetActionButton"..i - 1]
		b:ClearAllPoints()
		b:SetPoint("LEFT", b2, "RIGHT", 3, 0)
	end
else
	PetActionBarFrame:SetParent(fpet)
	PetActionButton1:ClearAllPoints()
	PetActionButton1:SetPoint("TOPRIGHT", fpet, "TOPRIGHT", 0, 0)
	for i = 2, 10 do
		local b = _G["PetActionButton"..i]
		local b2 = _G["PetActionButton"..i - 1]
		b:ClearAllPoints()
		b:SetPoint("TOP", b2, "BOTTOM", 0, -3)
	end
end

local BagButtons = {
	MainMenuBarBackpackButton,
	CharacterBag0Slot,
	CharacterBag1Slot,
	CharacterBag2Slot,
	CharacterBag3Slot,
	KeyRingButton,
}  

local function MoveBagButtons()
	for _, f in pairs(BagButtons) do
		f:SetParent(fbag)
    end
	MainMenuBarBackpackButton:ClearAllPoints();
	MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", -1, 2)
end  
MoveBagButtons();  
  
local MicroButtons = {
	CharacterMicroButton,
	SpellbookMicroButton,
	TalentMicroButton,
	AchievementMicroButton,
	QuestLogMicroButton,
	SocialsMicroButton,
	PVPMicroButton,
	LFDMicroButton,
	MainMenuMicroButton,
	HelpMicroButton,
}

local function MoveMicroButtons(skinName)
	for _, f in pairs(MicroButtons) do
		f:SetParent(fmicro)
    end
	CharacterMicroButton:ClearAllPoints();
	CharacterMicroButton:SetPoint("BOTTOMLEFT", -1, 0)
	SocialsMicroButton:ClearAllPoints()
	SocialsMicroButton:SetPoint("LEFT", QuestLogMicroButton, "RIGHT", -3, 0)
end
hooksecurefunc("VehicleMenuBar_MoveMicroButtons", MoveMicroButtons); 
MoveMicroButtons()

local function showhideactionbuttons(alpha)
	local f = "ActionButton"
	for i = 1, 12 do
		_G[f..i]:SetAlpha(alpha)
	end
end
BonusActionBarFrame:HookScript("OnShow", function(self) showhideactionbuttons(0) end)
BonusActionBarFrame:HookScript("OnHide", function(self) showhideactionbuttons(1) end)
if BonusActionBarFrame:IsShown() then
	showhideactionbuttons(0)
end

local function showhideshapeshift(alpha)
	if SettingsDB.myclass == "SHAMAN" then
		for i = 1, 12 do
			local pb = _G["MultiCastActionButton"..i]
			pb:SetAlpha(alpha)
		end
		for i = 1, 4 do
			local pb = _G["MultiCastSlotButton"..i]
			pb:SetAlpha(alpha)
		end
	else
		for i = 1, NUM_SHAPESHIFT_SLOTS do
			local pb = _G["ShapeshiftButton"..i]
			pb:SetAlpha(alpha)
		end
	end
end

local function showhiderightbar(alpha)
	if MultiBarLeft:IsShown() then
		for i = 1, 12 do
			local pb = _G["MultiBarLeftButton"..i]
			pb:SetAlpha(alpha)
		end
	end

	if MultiBarRight:IsShown() then
		for i = 1, 12 do
			local pb = _G["MultiBarRightButton"..i]
			pb:SetAlpha(alpha)
		end
	end

	if MultiBarBottomRight:IsShown() and SettingsCF["actionbar"].rightbars_three == true then
		for i = 1, 12 do
			local pb = _G["MultiBarBottomRightButton"..i]
			pb:SetAlpha(alpha)
		end
	end

	if SettingsCF["actionbar"].petbar_horizontal == false then
		for i = 1, NUM_PET_ACTION_SLOTS do
			local pb = _G["PetActionButton"..i]
			pb:SetAlpha(alpha)
		end
	end
end

local function showhidepetbar(alpha)
	for i = 1, NUM_PET_ACTION_SLOTS do
		local pb = _G["PetActionButton"..i]
		pb:SetAlpha(alpha)
	end
end
  
local function showhidemicro(alpha)
	for _, frame in pairs(MicroButtons) do
		frame:SetAlpha(alpha)
	end
end

local function showhidebags(alpha)
	for _, frame in pairs(BagButtons) do
		frame:SetAlpha(alpha)
	end
end

if SettingsCF["actionbar"].shapeshift_mouseover == true then
	if SettingsDB.myclass == "SHAMAN" then
		fshift:EnableMouse(true)
		fshift:HookScript("OnEnter", function(self) MultiCastSummonSpellButton:SetAlpha(1) MultiCastRecallSpellButton:SetAlpha(1) showhideshapeshift(1) end)
		fshift:HookScript("OnLeave", function(self) MultiCastSummonSpellButton:SetAlpha(0) MultiCastRecallSpellButton:SetAlpha(0) showhideshapeshift(0) end)
		MultiCastSummonSpellButton:SetAlpha(0)
		MultiCastSummonSpellButton:HookScript("OnEnter", function(self) MultiCastSummonSpellButton:SetAlpha(1) MultiCastRecallSpellButton:SetAlpha(1) showhideshapeshift(1) end)
		MultiCastSummonSpellButton:HookScript("OnLeave", function(self) MultiCastSummonSpellButton:SetAlpha(0) MultiCastRecallSpellButton:SetAlpha(0) showhideshapeshift(0) end)
		MultiCastRecallSpellButton:SetAlpha(0)
		MultiCastRecallSpellButton:HookScript("OnEnter", function(self) MultiCastSummonSpellButton:SetAlpha(1) MultiCastRecallSpellButton:SetAlpha(1) showhideshapeshift(1) end)
		MultiCastRecallSpellButton:HookScript("OnLeave", function(self) MultiCastSummonSpellButton:SetAlpha(0) MultiCastRecallSpellButton:SetAlpha(0) showhideshapeshift(0) end)
		MultiCastFlyoutFrameOpenButton:HookScript("OnEnter", function(self) MultiCastSummonSpellButton:SetAlpha(1) MultiCastRecallSpellButton:SetAlpha(1) showhideshapeshift(1) end)
		MultiCastFlyoutFrameOpenButton:HookScript("OnLeave", function(self) MultiCastSummonSpellButton:SetAlpha(0) MultiCastRecallSpellButton:SetAlpha(0) showhideshapeshift(0) end)
		for i = 1, 4 do
			local pb = _G["MultiCastSlotButton"..i]
			pb:SetAlpha(0)
			pb:HookScript("OnEnter", function(self) MultiCastSummonSpellButton:SetAlpha(1) MultiCastRecallSpellButton:SetAlpha(1) showhideshapeshift(1) end)
			pb:HookScript("OnLeave", function(self) MultiCastSummonSpellButton:SetAlpha(0) MultiCastRecallSpellButton:SetAlpha(0) showhideshapeshift(0) end)
		end
		for i = 1, 4 do
			local pb = _G["MultiCastActionButton"..i]
			pb:SetAlpha(0)
			pb:HookScript("OnEnter", function(self) MultiCastSummonSpellButton:SetAlpha(1) MultiCastRecallSpellButton:SetAlpha(1) showhideshapeshift(1) end)
			pb:HookScript("OnLeave", function(self) MultiCastSummonSpellButton:SetAlpha(0) MultiCastRecallSpellButton:SetAlpha(0) showhideshapeshift(0) end)
		end
	else
		fshift:EnableMouse(true)
		fshift:SetScript("OnEnter", function(self) showhideshapeshift(1) end)
		fshift:SetScript("OnLeave", function(self) showhideshapeshift(0) end)  
		for i = 1, NUM_SHAPESHIFT_SLOTS do
			local pb = _G["ShapeshiftButton"..i]
			pb:SetAlpha(0)
			pb:HookScript("OnEnter", function(self) showhideshapeshift(1) end)
			pb:HookScript("OnLeave", function(self) showhideshapeshift(0) end)
		end
	end
end

if SettingsCF["actionbar"].rightbars_mouseover == true then
	fbar45:EnableMouse(true)
	fbar45:SetScript("OnEnter", function(self) showhiderightbar(1) end)
	fbar45:SetScript("OnLeave", function(self) showhiderightbar(0) end)
	if SettingsCF["actionbar"].rightbars_three == true then
		fbar3:EnableMouse(true)
		fbar3:SetScript("OnEnter", function(self) showhiderightbar(1) end)
		fbar3:SetScript("OnLeave", function(self) showhiderightbar(0) end)
		for i = 1, 12 do
			local pb = _G["MultiBarBottomRightButton"..i]
			pb:SetAlpha(0)
			pb:HookScript("OnEnter", function(self) showhiderightbar(1) end)
			pb:HookScript("OnLeave", function(self) showhiderightbar(0) end)
		end
	end
	for i = 1, 12 do
		local pb = _G["MultiBarLeftButton"..i]
		pb:SetAlpha(0)
		pb:HookScript("OnEnter", function(self) showhiderightbar(1) end)
		pb:HookScript("OnLeave", function(self) showhiderightbar(0) end)
		local pb = _G["MultiBarRightButton"..i]
		pb:SetAlpha(0)
		pb:HookScript("OnEnter", function(self) showhiderightbar(1) end)
		pb:HookScript("OnLeave", function(self) showhiderightbar(0) end)
	end
	if SettingsCF["actionbar"].petbar_horizontal == false then
		fpet:EnableMouse(true)
		fpet:SetScript("OnEnter", function(self) showhiderightbar(1) end)
		fpet:SetScript("OnLeave", function(self) showhiderightbar(0) end)  
		for i = 1, NUM_PET_ACTION_SLOTS do
			local pb = _G["PetActionButton"..i]
			pb:SetAlpha(0)
			pb:HookScript("OnEnter", function(self) showhiderightbar(1) end)
			pb:HookScript("OnLeave", function(self) showhiderightbar(0) end)
		end
	end
end

if SettingsCF["actionbar"].petbar_mouseover == true and SettingsCF["actionbar"].petbar_horizontal == true then
	fpet:EnableMouse(true)
	fpet:SetScript("OnEnter", function(self) showhidepetbar(1) end)
	fpet:SetScript("OnLeave", function(self) showhidepetbar(0) end)  
	for i = 1, NUM_PET_ACTION_SLOTS do
		local pb = _G["PetActionButton"..i]
		pb:SetAlpha(0)
		pb:HookScript("OnEnter", function(self) showhidepetbar(1) end)
		pb:HookScript("OnLeave", function(self) showhidepetbar(0) end)
	end
end

if SettingsCF["actionbar"].micromenu_mouseover == true and SettingsCF["actionbar"].micromenu_hide ~= true then
	fmicro:EnableMouse(true)
	fmicro:SetScript("OnEnter", function(self) showhidemicro(1) end)
	fmicro:SetScript("OnLeave", function(self) showhidemicro(0) end)  
	for _, f in pairs(MicroButtons) do
		f:SetAlpha(0)
		f:HookScript("OnEnter", function(self) showhidemicro(1) end)
		f:HookScript("OnLeave", function(self) showhidemicro(0) end)
	end
end

if SettingsCF["actionbar"].bags_mouseover == true and SettingsCF["actionbar"].bags_hide ~= true then
	fbag:EnableMouse(true)
	fbag:SetScript("OnEnter", function(self) showhidebags(1) end)
	fbag:SetScript("OnLeave", function(self) showhidebags(0) end)  
	for _, f in pairs(BagButtons) do
		f:SetAlpha(0)
		f:HookScript("OnEnter", function(self) showhidebags(1) end)
		f:HookScript("OnLeave", function(self) showhidebags(0) end)
	end  
end

local FramesToHide = {
	MainMenuBar,
	VehicleMenuBar,
}  

for _, f in pairs(FramesToHide) do
	f:SetScale(0.001)
	f:SetAlpha(0)
	f:EnableMouse(false)
end

if SettingsCF["actionbar"].bags_hide == true then
	fbag:SetScale(0.001)
	fbag:SetAlpha(0)
end

if SettingsCF["actionbar"].micromenu_hide == true then
	fmicro:SetScale(0.001)
	fmicro:SetAlpha(0)
end

if SettingsCF["actionbar"].shapeshift_hide == true then
	fshift:SetScale(0.001)
	fshift:SetAlpha(0)
end

if SettingsCF["actionbar"].petbar_hide == true then
	fpet:SetScale(0.001)
	fpet:SetAlpha(0)
end

-- Always hide these textures
SlidingActionBarTexture0:SetTexture(nil)
SlidingActionBarTexture1:SetTexture(nil)
ShapeshiftBarLeft:SetTexture(nil)
ShapeshiftBarRight:SetTexture(nil)
ShapeshiftBarMiddle:SetTexture(nil)