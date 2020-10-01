----------------------------------------------------------------------------------------
--	ShestakUI variables
----------------------------------------------------------------------------------------
SettingsCF = { }
SettingsDB = { }
SavedOptions = { }

SettingsDB.dummy = function() return end
SettingsDB.myname, _ = UnitName("player")
_, SettingsDB.myclass = UnitClass("player")
SettingsDB.client = GetLocale()
SettingsDB.mylevel = UnitLevel("player")
SettingsDB.resolution = GetCurrentResolution()
SettingsDB.getscreenresolution = select(SettingsDB.resolution, GetScreenResolutions())
SettingsDB.version = GetAddOnMetadata("!aSettings", "Version")
SettingsDB.incombat = UnitAffectingCombat("player")
SettingsDB.patch = GetBuildInfo()

----------------------------------------------------------------------------------------
--	Blizzard Global variables
----------------------------------------------------------------------------------------