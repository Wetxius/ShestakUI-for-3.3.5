--[[
    Copyright (C) 2009  Constantin Schomburg

    This file is part of cargBags.

    cargBags is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    cargBags is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with cargBags.  If not, see <http://www.gnu.org/licenses/>.
]]

--[[doc
Plugin: Space

Description:
	a) Creates a fontstring which shows formatted text
	b) Makes a given frame into a space updater

Spawn with:
	:SpawnPlugin("Space", text [, bags]): Create a formatted space display (for bags, see cargBags:ParseBags(bags))
	:SpawnPlugin("Space", frame [, bags]): Make this frame into a space updater (for bags, see cargBags:ParseBags(bags))

Space properties:
	.Text: Holds the formatted text, with tags [free], [used] and [max] (Default: "[free] / [max]")

Space callback functions:
	:UpdateText(free, max): overwrite this for custom functions
doc]]

-- Update the space display
local function updater(self, event)
	if(event == "ITEM_LOCK_CHANGED" or event == "BAG_UPDATE_COOLDOWN"  or event == "PLAYER_MONEY") then return end

	local max = 0
	local free = 0
	local handler = cargBags:GetHandler()
	if(self.Bags) then
		for _, id in pairs(self.Bags) do
			free = free + handler.GetContainerNumFreeSlots(id)
			max = max + handler.GetContainerNumSlots(id)
		end
	elseif(self.Object.Bags) then
		for id, _ in pairs(self.Object.Bags) do
			if(tonumber(id)) then
				free = free + handler.GetContainerNumFreeSlots(id)
				max = max + handler.GetContainerNumSlots(id)
			end
		end
	end

	if(self.UpdateText) then return self:UpdateText(free, max) end
	if(not self.Text) then return end

	local text = self.Text:gsub("%[free%]", free)
	text = text:gsub("%[used%]", max-free)
	text = text:gsub("%[max%]", max)
	self:SetText(text)
end

-- Register the plugin
cargBags:RegisterPlugin("Space", function(self, arg1, bagType)
	local plugin
	if(type(arg1) == "table") then -- Custom frame
		plugin = arg1
	else -- Default frame
		plugin = self:CreateFontString(nil, "OVERLAY")
		plugin:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].font_style)
		plugin.Text = arg1 or "[free] / [max]"
	end
	plugin.Object = self

	local table = cargBags:ParseBags(bagType)
	local bags = {}
	plugin.Bags = bags
	for k, v in pairs(table) do
		bags[k] = v
	end

	cargBags:AddCallback(plugin, updater)
	return plugin
end)