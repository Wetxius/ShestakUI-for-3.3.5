------------------------------------------------------------------------------------------	Clear UIErrors frame(ncError by Nightcracker)----------------------------------------------------------------------------------------if SettingsCF["error"].hide == true then	local db, f, o = SettingsCF["error"], CreateFrame("Frame"), L_INFO_ERRORS	f:SetScript("OnEvent", function(self, event, error)		if SettingsCF["error"].white == true and SettingsCF["error"].black == false then			if db.white_list[error] then				UIErrorsFrame:AddMessage(error, 1, 0 ,0)			else				o = error			end		elseif SettingsCF["error"].black == true and SettingsCF["error"].white == false then			if db.black_list[error] then				o = error			else				UIErrorsFrame:AddMessage(error, 1, 0 ,0)			end		end	end)	SLASH_ERROR1 = "/error"	function SlashCmdList.ERROR() UIErrorsFrame:AddMessage(o, 1, 0, 0) end	UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")	f:RegisterEvent("UI_ERROR_MESSAGE")end------------------------------------------------------------------------------------------	Clear UIErrors frame in combat(Warrning: "SettingsCF["error"].hide" be false)----------------------------------------------------------------------------------------if SettingsCF["error"].combat == true and SettingsCF["error"].hide == false then 	local neic = CreateFrame("Frame")	local OnEvent = function(self, event, ...) self[event](self, event, ...) end	neic:SetScript("OnEvent", OnEvent)	local function PLAYER_REGEN_DISABLED()		UIErrorsFrame:Hide()	end	local function PLAYER_REGEN_ENABLED()		UIErrorsFrame:Show()	end	neic:RegisterEvent("PLAYER_REGEN_DISABLED")	neic["PLAYER_REGEN_DISABLED"] = PLAYER_REGEN_DISABLED	neic:RegisterEvent("PLAYER_REGEN_ENABLED")	neic["PLAYER_REGEN_ENABLED"] = PLAYER_REGEN_ENABLEDend