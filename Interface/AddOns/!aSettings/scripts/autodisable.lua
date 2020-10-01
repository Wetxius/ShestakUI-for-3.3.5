----------------------------------------------------------------------------------------
--	Auto-overwrite script config is X mod is found
----------------------------------------------------------------------------------------
if (IsAddOnLoaded("Stuf") or IsAddOnLoaded("PitBull4") or IsAddOnLoaded("ShadowedUnitFrames") or IsAddOnLoaded("ag_UnitFrames")) then
	DisableAddOn("oUF")
	DisableAddOn("oUF_Shestak")
	DisableAddOn("oUF_ShestakDPS")
	DisableAddOn("oUF_ShestakHeal")
end

if (IsAddOnLoaded("TidyPlates") or IsAddOnLoaded("Aloft")) then
	DisableAddOn("caelNamePlates")
end

if (IsAddOnLoaded("Dominos") or IsAddOnLoaded("Bartender4") or IsAddOnLoaded("Macaroon")) then
	DisableAddOn("rActionBarStyler")
	DisableAddOn("rActionButtonStyler")
	SettingsCF["actionbar"].always_enable = false
	SettingsCF["actionbar"].show_grid = false
end

if (IsAddOnLoaded("Mapster")) then
	DisableAddOn("pMap")
end

if (IsAddOnLoaded("Prat") or IsAddOnLoaded("Chatter")) then
	DisableAddOn("idChat")
end

if (IsAddOnLoaded("Quartz") or IsAddOnLoaded("AzCastBar") or IsAddOnLoaded("eCastingBar")) then
	SettingsCF["unitframe"].unit_castbar = false
end

if (IsAddOnLoaded("Afflicted3") or IsAddOnLoaded("InterruptBar")) then
	DisableAddOn("aCooldowns")
end

if not (IsAddOnLoaded("cargBags")) then
	local MoveBags = function()
		ContainerFrame1:ClearAllPoints()
		ContainerFrame1:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -15, 15)
		ContainerFrame3:ClearAllPoints()
		ContainerFrame3:SetPoint("BOTTOMRIGHT", ContainerFrame1, "BOTTOMLEFT", 0, 2)
		ContainerFrame5:ClearAllPoints()
		ContainerFrame5:SetPoint("BOTTOMRIGHT", ContainerFrame3, "BOTTOMLEFT", 0, 0)
	end
	hooksecurefunc("updateContainerFrameAnchors", MoveBags)
	return
end