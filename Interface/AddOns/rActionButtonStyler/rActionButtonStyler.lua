local _G = _G

local modSetBorderColor = function(button)
	if not button.bd then return end
	if button.pushed then
		button.bd:SetBackdropBorderColor(1, 1, 1)
	elseif button.hover then
		button.bd:SetBackdropBorderColor(1, 1, 0)
	elseif button.checked then
		button.bd:SetBackdropBorderColor(0, 0.5, 1)
	elseif button.equipped then
		button.bd:SetBackdropBorderColor(0, 0.5, 0)
	else
		button.bd:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
	end
end

local modActionButtonDown = function(id)
	local button
	if BonusActionBarFrame:IsShown() then
		button = _G["BonusActionButton"..id]
	else
		button = _G["ActionButton"..id]
	end
	button.pushed = true
	modSetBorderColor(button)
end
  
local modActionButtonUp = function(id)
	local button
	if BonusActionBarFrame:IsShown() then
		button = _G["BonusActionButton"..id]
	else
		button = _G["ActionButton"..id]
	end
	button.pushed = false
	modSetBorderColor(button)
end

local modMultiActionButtonDown = function(bar, id)
	local button = _G[bar.."Button"..id]
	button.pushed = true
	modSetBorderColor(button)
end
  
local modMultiActionButtonUp = function(bar, id)
	local button = _G[bar.."Button"..id]
	button.pushed = false
	modSetBorderColor(button)
end

local modActionButton_UpdateState = function(button)
	local action = button.action
	if not button.bd then return end
	if IsCurrentAction(action) or IsAutoRepeatAction(action) then
		button.checked = true
	else
		button.checked = false
	end
	modSetBorderColor(button)
end
  
local setStyle = function(bname)
	local button = _G[bname]
	local icon   = _G[bname.."Icon"]
	local flash  = _G[bname.."Flash"]
	if not button.bd then
		button:SetWidth(SettingsCF["actionbar"].button_size)
		button:SetHeight(SettingsCF["actionbar"].button_size)
		local bd = CreateFrame("Frame", nil, button)
		bd:SetPoint("TOPLEFT", 0, 0)
		bd:SetPoint("BOTTOMRIGHT", 0, 0)
		bd:SetFrameStrata("BACKGROUND")
		SettingsDB.CreateTemplate(bd)
		SettingsDB.CreateOverlay(bd)
		button.bd = bd
		button:HookScript("OnEnter", function(self)
			self.hover = true
			modSetBorderColor(self)
		end)
		button:HookScript("OnLeave", function(self)
			self.hover = false
			modSetBorderColor(self)
		end)
	end
	flash:SetTexture("")
	button:SetHighlightTexture("")
	button:SetPushedTexture("")
	button:SetCheckedTexture("")
	button:SetNormalTexture("")
	icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	icon:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
	icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
end

local modActionButton_Update = function(self)
	local action = self.action
	local name = self:GetName()
	local button = self
	local count = _G[name.."Count"]
	local border = _G[name.."Border"]
	local hotkey = _G[name.."HotKey"]
	local macro = _G[name.."Name"]

	border:Hide()
	
	count:ClearAllPoints()
	count:SetPoint("BOTTOMRIGHT", 0, 2)
	count:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].font_style)
	
	macro:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].font_style)
	macro:Hide()
	
	hotkey:ClearAllPoints()
	hotkey:SetPoint("TOPRIGHT", 0, 0)
	hotkey:SetWidth(SettingsCF["actionbar"].button_size)
	hotkey:SetHeight(SettingsCF["media"].pixel_font_size)
	hotkey:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].font_style)
	if SettingsCF["actionbar"].hotkey ~= true then
		hotkey:Hide()
	end

	setStyle(name)
	if IsEquippedAction(action) then
		button.equipped = true
	else
		button.equipped = false
	end
	modSetBorderColor(button)
end
  
local modPetActionBar_Update = function()
	for i = 1, NUM_PET_ACTION_SLOTS do
		local name = "PetActionButton"..i
		local button  = _G[name]

		setStyle(name)
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i)
		if isActive then
			button.checked = true
		else
			button.checked = false
		end
		modSetBorderColor(button)
		
		local autocast = _G["PetActionButton"..i.."AutoCastable"]
		autocast:SetWidth(SettingsCF["actionbar"].button_size + 25)
		autocast:SetHeight(SettingsCF["actionbar"].button_size + 25)
		autocast:ClearAllPoints()
		autocast:SetPoint("CENTER", button, 0, 0)
		
		local cd = _G["PetActionButton"..i.."Cooldown"]
		cd:ClearAllPoints()
		cd:SetPoint("TOPLEFT", button, 2, -2)
		cd:SetPoint("BOTTOMRIGHT", button, -2, 2)
	end  
end
  
local modShapeshiftBar_UpdateState = function()    
	for i = 1, NUM_SHAPESHIFT_SLOTS do
		local name = "ShapeshiftButton"..i
		local button  = _G[name]
  
		setStyle(name)
		local texture, name, isActive, isCastable = GetShapeshiftFormInfo(i)
		if isActive then
			button.checked = true
		else
			button.checked = false
		end
		modSetBorderColor(button)
	end    
end

local modActionButton_UpdateHotkeys = function(self, actionButtonType)
	if (not actionButtonType) then
		actionButtonType = "ACTIONBUTTON"
	end
	local hotkey = _G[self:GetName().."HotKey"]
	local key = GetBindingKey(actionButtonType..self:GetID()) or GetBindingKey("CLICK "..self:GetName()..":LeftButton")
	local text = GetBindingText(key, "KEY_", 1)
	hotkey:SetText(text)
	
	if SettingsCF["actionbar"].hotkey == true then
		hotkey:ClearAllPoints()
		hotkey:SetPoint("TOPRIGHT", 0, 0)
		hotkey:SetWidth(SettingsCF["actionbar"].button_size)
		hotkey:SetHeight(SettingsCF["media"].pixel_font_size)
	else
		hotkey:Hide()
	end
end


hooksecurefunc("ActionButton_Update", modActionButton_Update)
hooksecurefunc("ActionButton_UpdateState", modActionButton_UpdateState)
hooksecurefunc("ActionButtonDown", modActionButtonDown)
hooksecurefunc("ActionButtonUp", modActionButtonUp)
hooksecurefunc("MultiActionButtonDown", modMultiActionButtonDown)
hooksecurefunc("MultiActionButtonUp", modMultiActionButtonUp)

hooksecurefunc("ShapeshiftBar_OnLoad", modShapeshiftBar_UpdateState)
hooksecurefunc("ShapeshiftBar_Update", modShapeshiftBar_UpdateState)
hooksecurefunc("ShapeshiftBar_UpdateState", modShapeshiftBar_UpdateState)
hooksecurefunc("PetActionBar_Update", modPetActionBar_Update)
hooksecurefunc("ActionButton_UpdateHotkeys", modActionButton_UpdateHotkeys)

-- Rescale cooldown spiral to fix texture
local buttonNames = {
	"ActionButton",
	"BonusActionButton",
	"MultiBarBottomLeftButton",
	"MultiBarBottomRightButton",
	"MultiBarLeftButton",
	"MultiBarRightButton",
	"ShapeshiftButton",
	"MultiCastActionButton",
}
for _, name in ipairs( buttonNames ) do
	for index = 1, 20 do
		local buttonName = name .. tostring(index)
		local button = _G[buttonName]
		local cooldown = _G[buttonName .. "Cooldown"]		
 
		if ( button == nil or cooldown == nil ) then
			break;
		end
 
		cooldown:ClearAllPoints()
		cooldown:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
		cooldown:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	end
end