----------------------------------------------------------------------------------------
--	Slash commands
----------------------------------------------------------------------------------------
SlashCmdList["RELOADUI"] = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"
SLASH_RELOADUI2 = "/кд"

SlashCmdList["RCSLASH"] = function() DoReadyCheck() end
SLASH_RCSLASH1 = "/rc"
SLASH_RCSLASH2 = "/кс"

SlashCmdList["TICKET"] = function() ToggleHelpFrame() end
SLASH_TICKET1 = "/gm"
SLASH_TICKET2 = "/гм"

SlashCmdList["DISABLE_ADDON"] = function(s) DisableAddOn(s) end
SLASH_DISABLE_ADDON1 = "/dis"

SlashCmdList["ENABLE_ADDON"] = function(s) EnableAddOn(s) end
SLASH_ENABLE_ADDON1 = "/en"

----------------------------------------------------------------------------------------
--	Disband party or raid(by Monolit)
----------------------------------------------------------------------------------------
SlashCmdList["GROUPDISBAND"] = function()
	local pName = UnitName("player")
	SendChatMessage(L_INFO_DISBAND, "RAID" or "PARTY")
	if UnitInRaid("player") then
		for i = 1, GetNumRaidMembers() do
			local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
			if online and name ~= pName then
				UninviteUnit(name)
			end
		end
	else
		for i = MAX_PARTY_MEMBERS, 1, -1 do
			if GetPartyMember(i) then
				UninviteUnit(UnitName("party"..i))
			end
		end
	end
	LeaveParty()
end
SLASH_GROUPDISBAND1 = "/rd"

----------------------------------------------------------------------------------------
--	Spec switching(by Monolit)
----------------------------------------------------------------------------------------
SlashCmdList["SPEC"] = function() 
	local spec = GetActiveTalentGroup()
	if spec == 1 then SetActiveTalentGroup(2) elseif spec == 2 then SetActiveTalentGroup(1) end
end
SLASH_SPEC1 = "/ss"
SLASH_SPEC2 = "/spec"

----------------------------------------------------------------------------------------
--	Fix combatlog after a crash (2.4 and 3.3.2 bug)
----------------------------------------------------------------------------------------
SlashCmdList["CLFIX"] = function() CombatLogClearEntries() end
SLASH_CLFIX1 = "/clfix"

----------------------------------------------------------------------------------------
--	Demo mode for DBM
----------------------------------------------------------------------------------------
SlashCmdList["DBMTEST"] = function() DBM:DemoMode() end
SLASH_DBMTEST1 = "/dbmtest"

----------------------------------------------------------------------------------------
--	Switch to heal layout
----------------------------------------------------------------------------------------
SlashCmdList["HEAL"] = function()
	DisableAddOn("oUF_ShestakDPS")
	EnableAddOn("oUF_ShestakHeal")
	ReloadUI()
end
SLASH_HEAL1 = "/heal"

----------------------------------------------------------------------------------------
--	Switch to dps layout
----------------------------------------------------------------------------------------
SlashCmdList["DPS"] = function()
	DisableAddOn("oUF_ShestakHeal")
	EnableAddOn("oUF_ShestakDPS")
	ReloadUI()
end
SLASH_DPS1 = "/dps"

----------------------------------------------------------------------------------------
--	Command to show frame you currently have mouseovered
----------------------------------------------------------------------------------------
SlashCmdList["FRAME"] = function(arg)
	if arg ~= "" then
		arg = _G[arg]
	else
		arg = GetMouseFocus()
	end
	if arg ~= nil and arg:GetName() ~= nil then
		local point, relativeTo, relativePoint, xOfs, yOfs = arg:GetPoint()
		ChatFrame1:AddMessage("|cffCC0000~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
		ChatFrame1:AddMessage("Name: |cffFFD100"..arg:GetName())
		if arg:GetParent() then
			ChatFrame1:AddMessage("Parent: |cffFFD100"..arg:GetParent():GetName())
		end
 
		ChatFrame1:AddMessage("Width: |cffFFD100"..format("%.2f",arg:GetWidth()))
		ChatFrame1:AddMessage("Height: |cffFFD100"..format("%.2f",arg:GetHeight()))
 
		if relativeTo then
			ChatFrame1:AddMessage("Point: |cffFFD100"..point.."|r anchored to "..relativeTo:GetName().."'s |cffFFD100"..relativePoint)
		end
		if xOfs then
			ChatFrame1:AddMessage("X: |cffFFD100"..format("%.2f",xOfs))
		end
		if yOfs then
			ChatFrame1:AddMessage("Y: |cffFFD100"..format("%.2f",yOfs))
		end
		ChatFrame1:AddMessage("|cffCC0000~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
	elseif arg == nil then
		ChatFrame1:AddMessage("Invalid frame name")
	else
		ChatFrame1:AddMessage("Could not find frame info")
	end
end
SLASH_FRAME1 = "/frame"

----------------------------------------------------------------------------------------
--	Addons group
----------------------------------------------------------------------------------------
SlashCmdList["CHANGEADDONS"] = function(s)
	if(s and s == "raid") then
		for i in pairs(SettingsCF["addon"].raid) do
			EnableAddOn(SettingsCF["addon"].raid[i])
		end
		for i in pairs(SettingsCF["addon"].party) do
			DisableAddOn(SettingsCF["addon"].party[i])
		end
		for i in pairs(SettingsCF["addon"].pvp) do
			DisableAddOn(SettingsCF["addon"].pvp[i])
		end
		for i in pairs(SettingsCF["addon"].quest) do
			DisableAddOn(SettingsCF["addon"].quest[i])
        end
		for i in pairs(SettingsCF["addon"].trade) do
			DisableAddOn(SettingsCF["addon"].trade[i])
		end
		ReloadUI()
	elseif(s and s == "party") then
		for i in pairs(SettingsCF["addon"].raid) do
			DisableAddOn(SettingsCF["addon"].raid[i])
		end
		for i in pairs(SettingsCF["addon"].party) do
			EnableAddOn(SettingsCF["addon"].party[i])
		end
		for i in pairs(SettingsCF["addon"].pvp) do
			DisableAddOn(SettingsCF["addon"].pvp[i])
		end
		for i in pairs(SettingsCF["addon"].quest) do
			DisableAddOn(SettingsCF["addon"].quest[i])
		end
		for i in pairs(SettingsCF["addon"].trade) do
			DisableAddOn(SettingsCF["addon"].trade[i])
        end
        ReloadUI()
    elseif(s and s == "pvp") then
        for i in pairs(SettingsCF["addon"].raid) do
            DisableAddOn(SettingsCF["addon"].raid[i])
        end
		for i in pairs(SettingsCF["addon"].party) do
			DisableAddOn(SettingsCF["addon"].party[i])
        end
		for i in pairs(SettingsCF["addon"].pvp) do
            EnableAddOn(SettingsCF["addon"].pvp[i])
        end
		for i in pairs(SettingsCF["addon"].quest) do
			DisableAddOn(SettingsCF["addon"].quest[i])
        end
		for i in pairs(SettingsCF["addon"].trade) do
			DisableAddOn(SettingsCF["addon"].trade[i])
        end
        ReloadUI()
	elseif(s and s == "quest") then
        for i in pairs(SettingsCF["addon"].raid) do
            DisableAddOn(SettingsCF["addon"].raid[i])
        end
		for i in pairs(SettingsCF["addon"].party) do
			DisableAddOn(SettingsCF["addon"].party[i])
        end
		for i in pairs(SettingsCF["addon"].pvp) do
			DisableAddOn(SettingsCF["addon"].pvp[i])
        end
        for i in pairs(SettingsCF["addon"].quest) do
            EnableAddOn(SettingsCF["addon"].quest[i])
        end
		for i in pairs(SettingsCF["addon"].trade) do
			DisableAddOn(SettingsCF["addon"].trade[i])
        end
        ReloadUI()
	elseif(s and s == "trade") then
        for i in pairs(SettingsCF["addon"].raid) do
            DisableAddOn(SettingsCF["addon"].raid[i])
        end
		for i in pairs(SettingsCF["addon"].party) do
			DisableAddOn(SettingsCF["addon"].party[i])
        end
		for i in pairs(SettingsCF["addon"].pvp) do
            DisableAddOn(SettingsCF["addon"].pvp[i])
        end
		for i in pairs(SettingsCF["addon"].quest) do
			DisableAddOn(SettingsCF["addon"].quest[i])
        end
		for i in pairs(SettingsCF["addon"].trade) do
			EnableAddOn(SettingsCF["addon"].trade[i])
        end
        ReloadUI()
    elseif(s and s == "solo") then
        for i in pairs(SettingsCF["addon"].raid) do
            DisableAddOn(SettingsCF["addon"].raid[i])
        end
		for i in pairs(SettingsCF["addon"].party) do
			DisableAddOn(SettingsCF["addon"].party[i])
        end
		for i in pairs(SettingsCF["addon"].pvp) do
            DisableAddOn(SettingsCF["addon"].pvp[i])
        end
		for i in pairs(SettingsCF["addon"].quest) do
            DisableAddOn(SettingsCF["addon"].quest[i])
        end
		for i in pairs(SettingsCF["addon"].trade) do
			DisableAddOn(SettingsCF["addon"].trade[i])
        end
        ReloadUI()
    else
        print("|cffffff00"..L_INFO_ADDON_SETS1.."|r")
        print("|cffffff00"..L_INFO_ADDON_SETS2.."|r")
    end
end
SLASH_CHANGEADDONS1 = "/addons"