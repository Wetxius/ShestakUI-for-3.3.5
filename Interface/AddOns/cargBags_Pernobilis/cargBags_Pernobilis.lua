local function dummy() end
oGlow:RegisterPipe("cargBags_Pernobilis", dummy, nil, dummy, [[The cargBags layout Pernobilis.]])
oGlow:RegisterFilterOnPipe("cargBags_Pernobilis", "quality")
oGlow:RegisterFilterOnPipe("cargBags_Pernobilis", "quest")

local UpdateButton = function(self, button, item)
	button.Icon:SetTexture(item.texture)
	SetItemButtonCount(button, item.count)
	SetItemButtonDesaturated(button, item.locked, 0.5, 0.5, 0.5)

	oGlow:CallFilters("cargBags_Pernobilis", button, item.link)
end

local UpdateButtonLock = function(self, button, item)
	SetItemButtonDesaturated(button, item.locked, 0.5, 0.5, 0.5)
end

local UpdateButtonCooldown = function(self, button, item)
	if(button.Cooldown) then
		CooldownFrame_SetTimer(button.Cooldown, item.cdStart, item.cdFinish, item.cdEnable) 
	end
end

-- The function for positioning the item buttons in the bag object
local UpdateButtonPositions = function(self)
	local button
	local col, row = 0, 0
	for i, button in self:IterateButtons() do
		button:ClearAllPoints()

		local xPos = col * 33
		local yPos = -1 * row * 33
		if(self.Caption) then yPos = yPos - 15 end	-- Spacing for the caption

		button:SetPoint("TOPLEFT", self, "TOPLEFT", xPos, yPos)	 
		if(col >= self.Columns-1) then	 
			col = 0	 
			row = row + 1	 
		else	 
			col = col + 1	 
		end
	end

	-- This variable stores the size of the item button container
	self.ContainerHeight = (row + (col>0 and 1 or 0)) * 33

	if(self.UpdateDimensions) then self:UpdateDimensions() end -- Update the bag's height
end

local PostAddButton = function(self, button)
	if(not button.NormalTexture) then return end

	local bagType = cargBags.Bags[button.bagID].bagType
	if(button.bagID == KEYRING_CONTAINER) then
		button.NormalTexture:SetVertexColor(1, 0.7, 0)	-- Key ring
	elseif(bagType and bagType > 0 and bagType < 8) then
		button.NormalTexture:SetVertexColor(1, 1, 0)		-- Ammo bag
	elseif(bagType and bagType > 4) then
		button.NormalTexture:SetVertexColor(0, 1, 0)		-- Profession bags
	else
		button.NormalTexture:SetVertexColor(1, 1, 1)		-- Normal bags
	end
end

-- More slot buttons -> more space!
local UpdateDimensions = function(self)
	local height = 0			-- Normal margin space
	if(self.BagBar and self.BagBar:IsShown()) then
		height = height + 43				-- Bag button space
	end
	if(self.Space or self.Money) then
		height = height + 16	-- additional info display space
	end
	if(self.Caption) then	-- Space for captions
		height = height + 12
	end

	self:SetHeight(self.ContainerHeight + height)
end

local function createSmallButton(name, parent, ...)
	local button = CreateFrame("Button", nil, parent)
	button:SetPoint(...)
	button:SetNormalFontObject(GameFontHighlight)
	button:SetText(name)
	button:SetPoint"CENTER"
	button:SetWidth(13)
	button:SetHeight(13)
	button:SetScript("OnEnter", buttonEnter)
	button:SetScript("OnLeave", buttonLeave)
	button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
	SettingsDB.CreateBlizzard(button)
	return button
end

-- Style of the bag and its contents
local func = function(settings, self)
	self:EnableMouse(true)

	self.UpdateDimensions = UpdateDimensions
	self.UpdateButtonPositions = UpdateButtonPositions
	self.UpdateButton = UpdateButton
	self.UpdateButtonLock = UpdateButtonLock
	self.UpdateButtonCooldown = UpdateButtonCooldown
	self.PostAddButton = PostAddButton
	
	self:SetFrameStrata("HIGH")
	tinsert(UISpecialFrames, self:GetName()) -- Close on "Esc"

	-- Make main frames movable
	if(self.Name == "cBags_Main" or self.Name == "cBags_Bank") then
		self:SetMovable(true)
		self:RegisterForClicks("LeftButton", "RightButton");
	    self:SetScript("OnMouseDown", function() 
	        if(IsAltKeyDown()) then 
	            self:ClearAllPoints() 
	            self:StartMoving() 
	        end 
	    end)
	    self:SetScript("OnMouseUp",  self.StopMovingOrSizing)
	end

	if(self.Name == "cBags_Keyring") then
		self.Columns = SettingsCF["bag"].key_columns
		local caption = self:CreateFontString(nil, "OVERLAY")
		caption:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].font_style)
		caption:SetShadowOffset(0, 0)
		caption:SetFontObject(GameFontNormalSmall)
		if(caption) then
			local name = KEYRING
			caption:SetText(name)
			caption:SetPoint("TOPLEFT", 0, 0)
			self.Caption = caption
		end
	elseif(self.Name == "cBags_Bank") then
		self.Columns = SettingsCF["bag"].bank_columns
	else
		self.Columns = SettingsCF["bag"].bag_columns
	end

	self.ContainerHeight = 0
	self:UpdateDimensions()
	self:SetWidth(33 * self.Columns)	-- Set the frame's width based on the columns

	if(self.Name == "cBags_Main" or self.Name == "cBags_Bank") then

		-- Caption and close button
		local caption = self:CreateFontString(nil, "OVERLAY")
		caption:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].font_style)
		caption:SetShadowOffset(0, 0)
		caption:SetFontObject(GameFontNormalSmall)
		if(caption) then
			local name = self.Name == "cBags_Bank" and L_BAG_BANK or BACKPACK_TOOLTIP
			caption:SetText(name)
			caption:SetPoint("TOPLEFT", 0, 0)
			self.Caption = caption

			local close = CreateFrame("Button", nil, self, "UIPanelCloseButton")
			close:SetPoint("TOPRIGHT", 5, 8)
			close:SetHeight(24)
			close:SetWidth(24)
			close:SetScript("OnClick", function(self) self:GetParent():Hide() end)
		end

		-- The font string for bag space display
		local bagType
		if(self.Name == "cBags_Main") then
			bagType = "backpack+bags"	-- We want to add all bags to our bag button bar
		else
			bagType = "bankframe+bank"	-- the bank gets bank bags, of course
		end
		-- You can see, it works with tags, - [free], [max], [used] are currently supported
		local space = self:SpawnPlugin("Space", L_BAG_FREE.."[free]"..L_BAG_OUT_OFF.."[max]", bagType)
		if(space) then
			space:SetPoint("BOTTOMLEFT", self, 0, 1)
			space:SetJustifyH"LEFT"
		end

		-- The button for viewing other characters' bags
		if(self.Name == "cBags_Main") then
			local anywhere = self:SpawnPlugin("Anywhere")
			if(anywhere) then
				anywhere:SetPoint("TOPRIGHT", -20, 7)
				anywhere:SetScale(0.74)
			end
		end

		 -- A nice bag bar for changing/toggling bags
		local bagType
		if(self.Name == "cBags_Main") then
			bagType = "bags"	-- We want to add all bags to our bag button bar
		else
			bagType = "bank"	-- the bank gets bank bags, of course
		end
		local bagButtons = self:SpawnPlugin("BagBar", bagType)
		if(bagButtons) then
			bagButtons:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, 17)
			bagButtons:Hide()

			-- main window gets a fake bag button for toggling key ring
			if(self.Name == "cBags_Main") then
				local keytoggle = bagButtons:CreateKeyRingButton()
				keytoggle:SetScript("OnClick", function()
					if(cBags_Keyring:IsShown()) then
						cBags_Keyring:Hide()
						keytoggle:SetChecked(0)
					else
						cBags_Keyring:Show()
						keytoggle:SetChecked(1)
					end
				end)
			end
		end

		-- A little fix that positions the bagToggle between space and money
		local spacer = CreateFrame("Frame", nil, self)
		if(self.Name == "cBags_Main") then
			spacer:SetPoint("BOTTOMLEFT", space, "BOTTOMRIGHT", 0, 0)
			spacer:SetPoint("CENTER", "cBags_Main", "BOTTOM", 0, 5)
		else
			spacer:SetPoint("BOTTOMLEFT", space, "BOTTOMRIGHT", 0, 0)
			spacer:SetPoint("CENTER", "cBags_Bank", "BOTTOM", 0, 5)
		end

		-- We don't need the bag bar every time, so let's create a toggle button for them to show
		local bagToggle = CreateFrame("CheckButton", nil, self)
		bagToggle:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
		bagToggle:SetWidth(40)
		bagToggle:SetHeight(12)
		bagToggle:SetPoint("CENTER", spacer)
		bagToggle:RegisterForClicks("LeftButtonUp")
		bagToggle:SetScript("OnClick", function()
			if(self.BagBar:IsShown()) then
				self.BagBar:Hide()
			else
				self.BagBar:Show()
			end
			self:UpdateDimensions()	-- The bag buttons take space, so let's update the height of the frame
		end)
		local bagToggleText = bagToggle:CreateFontString(nil, "OVERLAY")
		bagToggleText:SetPoint("CENTER", bagToggle)
		bagToggleText:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].font_style)
		bagToggleText:SetFontObject(GameFontNormalSmall)
		bagToggleText:SetShadowOffset(0, 0)
		bagToggleText:SetText(BAGSLOTTEXT)
		
		if select(4,GetAddOnInfo("kRestack"))then
			local restack = createSmallButton("R", self, "TOPRIGHT", self, "TOPRIGHT", -35, 2)
			restack:SetScript("OnClick", function() kRestack(bagType) end)
		end

	end

	-- For purchasing bank slots
	if(self.Name == "cBags_Bank") then
		local purchase = self:SpawnPlugin("Purchase")
		if(purchase) then
			purchase:SetText(BANKSLOTPURCHASE)
			purchase:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -5, 7)
			if(self.BagBar) then purchase:SetParent(self.BagBar) end

			purchase.Cost = self:SpawnPlugin("Money", "static")
			purchase.Cost:SetParent(purchase)
			purchase.Cost:SetPoint("BOTTOMRIGHT", purchase, "TOPRIGHT", 0, 2)
		end
	end

	-- And the frame background!
	local background = CreateFrame("Frame", nil, self)
	SettingsDB.CreateBlizzard(background)
	background:SetFrameStrata("HIGH")
	background:SetFrameLevel(1)
	background:SetPoint("TOPLEFT", -12, 7)
	background:SetPoint("BOTTOMRIGHT", 8, -6)
	return self
end

-- Register the style with cargBags
cargBags:RegisterStyle("Pernobilis", setmetatable({}, {__call = func}))

-- Filter functions
--   As you can see, these functions get the same item-table seen at the top in UpdateButton(self, button, item)
--   Just check the properties you want to have and return true/false if the item belongs in this bag object
local INVERTED = -1 -- with inverted filters (using -1), everything goes into this bag when the filter returns false

local onlyBags = function(item) return item.bagID >= 0 and item.bagID <= 4 end
local onlyKeyring = function(item) return item.bagID == -2 end
local onlyBank = function(item) return item.bagID == -1 or item.bagID >= 5 and item.bagID <= 11 end
-- local onlyRareEpics = function(item) return item.rarity and item.rarity > 3 end
local onlyEpics = function(item) return item.rarity and item.rarity > 3 end
local hideJunk = function(item) return not item.rarity or item.rarity > 0 end
local hideEmpty = function(item) return item.texture ~= nil end

-- Now we add the containers
--  cargBags:Spawn( name , parentFrame ) spawns the container with that name
--  object:SetFilter ( filterFunc, enabled ) adds a filter or disables one

-- Bagpack and bags
local main 	= cargBags:Spawn("cBags_Main")
main:SetFilter(onlyBags, true)
main:SetFilter(hideEmpty, SettingsCF["bag"].hide_empty)
main:SetPoint("RIGHT", SettingsCF["actionbar"].rightbars_three == true and -113 or -90, 18)

-- Keyring
local key = cargBags:Spawn("cBags_Keyring", main)
key:SetFilter(onlyKeyring, true)
key:SetFilter(hideEmpty, true)
key:SetPoint("TOPRIGHT", main, "TOPLEFT", -25, 0)

-- Bank frame and bank bags
local bank = cargBags:Spawn("cBags_Bank")
bank:SetFilter(onlyBank, true)
bank:SetFilter(hideEmpty, SettingsCF["bag"].hide_empty)
bank:SetPoint("LEFT", 20, 18)


-- Opening / Closing Functions
function OpenCargBags()
	main:Show()
end

function CloseCargBags()
	main:Hide()
	bank:Hide()
end

function ToggleCargBags(forceopen)
	if(main:IsShown() and not forceopen) then CloseCargBags() else OpenCargBags() end
end

-- To toggle containers when entering / leaving a bank
local bankToggle = CreateFrame"Frame"
bankToggle:RegisterEvent"BANKFRAME_OPENED"
bankToggle:RegisterEvent"BANKFRAME_CLOSED"
bankToggle:SetScript("OnEvent", function(self, event)
	if(event == "BANKFRAME_OPENED") then
		bank:Show()
	else
		bank:Hide()
	end
end)

-- Close real bank frame when our bank frame is hidden
bank:SetScript("OnHide", CloseBankFrame)

-- Hide the original bank frame
BankFrame:UnregisterAllEvents()

-- Blizzard Replacement Functions
ToggleBackpack = ToggleCargBags
ToggleBag = function() ToggleCargBags() end
OpenAllBags = ToggleBag
CloseAllBags = CloseCargBags
OpenBackpack = OpenCargBags
CloseBackpack = CloseCargBags

-- Set cargBags_Anywhere as default handler when used
if(cargBags.Handler["Anywhere"]) then
	cargBags:SetActiveHandler("Anywhere")
end