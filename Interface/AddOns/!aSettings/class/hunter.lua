if SettingsDB.myclass ~= "HUNTER" then return end
 
local PetHappiness = CreateFrame("Frame")
PetHappiness.happiness = GetPetHappiness()

local OnEvent = function(self, event, unit)
	local happiness = GetPetHappiness()
	local hunterPet = select(2, HasPetUI())
	
	if (event == "UNIT_HAPPINESS" and happiness and hunterPet and self.happiness ~= happiness) then
		self.happiness = happiness
		if (happiness == 1) then
			DEFAULT_CHAT_FRAME:AddMessage(L_CLASS_HUNTER_UNHAPPY, 1, 0, 0)
		elseif (happiness == 2) then
			DEFAULT_CHAT_FRAME:AddMessage(L_CLASS_HUNTER_CONTENT, 1, 1, 0)
		elseif (happiness == 3) then
			DEFAULT_CHAT_FRAME:AddMessage(L_CLASS_HUNTER_HAPPY, 0, 1, 0)
		end
	elseif (event == "UNIT_PET") then
		self.happiness = happiness
		if (happiness == 1) then
			DEFAULT_CHAT_FRAME:AddMessage(L_CLASS_HUNTER_UNHAPPY, 1, 0, 0)
		end
	end
end
PetHappiness:RegisterEvent("UNIT_HAPPINESS")
PetHappiness:RegisterEvent("UNIT_PET")
PetHappiness:SetScript("OnEvent", OnEvent)