--[[-------------------------------------------------------------
tabDB v 2.0a2 2009-12-20 - Created by Aaron Mast

Do not redistribute without consent, you may find this add-on at

		-----------------------
		www.curse.com
		www.wowinterface.com
		-----------------------

If you found it anywhere else then please let me know!
]]---------------------------------------------------------------

tabDB_tabFrames	= {		LFDParentFrame = {
												Frame = "LFDParentFrame",
												Texture = "Interface\\LFGFrame\\UI-LFG-PORTRAIT",
												ToolTip = LOOKING_FOR_DUNGEON,
												order = 1,
												group = 1,
												offsetX = -1,
												offsetY = 0 },
						LFRParentFrame = {
												Frame = "LFRParentFrame",
												Texture = "Interface\\LFGFrame\\UI-LFR-PORTRAIT",
												ToolTip = LOOKING_FOR_RAID,
												order = 2,
												group = 1,
												offsetX = 0,
												offsetY = 0 },
						PVPParentFrame = {
												Frame = "PVPParentFrame",
												Texture = "Interface\\BattlefieldFrame\\UI-Battlefield-Icon",
												ToolTip = BATTLEGROUNDS,
												order = 3,
												offsetX = -31,
												offsetY = 0,
												OnClickFunction =	function()
																		PVPFrame:Hide()
																		PVPBattlegroundFrame:Show()
																		PanelTemplates_Tab_OnClick(PVPParentFrameTab2, PVPParentFrame)
																		PVPBattlegroundFrameGroupJoinButton:SetFrameLevel(PVPParentFrameTab2:GetFrameLevel() + 1)
																	end,
												OnShowFunction =	function(caller)
																		caller.OnClickFunction = nil
																		caller.OnShowFunction = nil
																	end }
};

libTab:initialize("TabDBtabs", tabDB_tabFrames)

--
-- Override OnClick in 'Social Raid' tab to make it behave as we want
--
tabDB_RaidFrameButtonOnClick = RaidFrameNotInRaidRaidBrowserButton:GetScript("OnClick")

RaidFrameNotInRaidRaidBrowserButton:SetScript("OnClick", function(...)
	libTab:tabSetGroupFrame("TabDBtabs", "LFRParentFrame")
	if ( tabDB_RaidFrameButtonOnClick ) then
		tabDB_RaidFrameButtonOnClick(...)
	end
end);