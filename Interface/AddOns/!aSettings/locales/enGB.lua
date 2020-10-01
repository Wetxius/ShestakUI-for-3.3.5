----------------------------------------------------------------------------------------
--	Localization for enUS and enGB client
----------------------------------------------------------------------------------------
if SettingsDB.client == "enUS" or SettingsDB.client == "enGB" then
	-- aTooltip
	L_TOOLTIP_NO_TALENT = "No Talents"
	L_TOOLTIP_LOADING = "Loading..."
	L_TOOLTIP_ACH_STATUS = "Your Status:"
	L_TOOLTIP_ACH_COMPLETE = "Your Status: Completed on "
	L_TOOLTIP_ACH_INCOMPLETE = "Your Status: Incomplete"

	-- aSettings(Mount macro)
	L_ZONE_DALARAN = "Dalaran"
    L_ZONE_UNDERBELLY = "The Underbelly"
    L_ZONE_KRASUS = "Krasus' Landing"
    L_ZONE_WINTERGRASP = "Wintergrasp"
    L_ZONE_VC = "The Violet Citadel"
	
	-- aSettings(Check Flask)
	L_FLASK_STR = "Gained Flask of the North - Strength"
	L_FLASK_SPD = "Gained Flask of the North - Spell Power"
	L_FLASK_AP = "Gained Flask of the North - Attack Power"
	
	-- oUF_Shestak
	L_UF_GHOST = "Ghost"
	L_UF_DEAD = "Dead"
	L_UF_OFFLINE = "Offline"
	L_UF_DRAGON = "Dragonhawk"
	L_UF_VIPER = "Viper"
	L_UF_MANA = "Low mana"
	L_UF_TRINKET_READY = "Trinket ready: "
	L_UF_TRINKET_USED = "Trinket used: "
	L_UF_WOTF_USED = "WotF used: "
	
	-- pMap
	L_MAP_CURSOR = "Cursor: "
	L_MAP_BOUNDS = "Out of bounds!"

	-- aMiniMap
	L_MINIMAP_CALENDAR = "Calendar"
	
	-- aLoad
	L_ALOAD_RL = "Reload UI"
	L_ALOAD_TRADE = "Trade"
	L_ALOAD_SOLO = "Solo"
	
	-- aSettings(GUI)
	L_GUI_MINIMAP_ICON_LM = "Left Click - Enter to GUI"
	L_GUI_MINIMAP_ICON_RM = "Right Click - Dropdown menu"
	L_GUI_MINIMAP_ICON_SD = "Shift + Drag - Move Button"
	L_GUI_MINIMAP_ICON_SRM = "Shift + Right Click - ReloadUI"
	L_GUI_MINIMAP_ICON_SLASH = "Slash commands"
	L_GUI_MINIMAP_ICON_SPEC = "Spec switching"
	L_GUI_MINIMAP_ICON_CL = "Fix combatlog"
	L_GUI_MINIMAP_ICON_DBM = "DBM test mode"
	L_GUI_MINIMAP_ICON_HEAL = "Switch to heal layout"
	L_GUI_MINIMAP_ICON_DPS = "Switch to dps layout"

	-- idChat
	L_CHAT_URL = "Copy URL"
	L_CHAT_GUILD = "G"
	L_CHAT_PARTY = "P"
	L_CHAT_PARTY_LEADER = "PL"
	L_CHAT_RAID	= "R"
	L_CHAT_RAID_LEADER = "RL"
	L_CHAT_RAID_WARNING	= "RW"
	L_CHAT_BATTLEGROUND	= "BG"
	L_CHAT_BATTLEGROUND_LEADER = "BGL"
	L_CHAT_OFFICER = "O"
	L_CHAT_COME_ONLINE = "has come online."
	L_CHAT_GONE_OFFLINE = "has gone offline."
	L_CHAT_COME_ONLINE_COLOR = "is now |cff298F00online|r !"
	L_CHAT_GONE_OFFLINE_COLOR = "is now |cffff0000offline|r !"

	-- BaudErrorFrame
	L_ERRORFRAME_L = "Click to view errors."
	
	-- cargBags
	L_BAG_FREE = "Space: "
	L_BAG_OUT_OFF = " / "
	L_BAG_BANK = "Bank"

	-- aSettings(NeedTheOrb)
	L_LOOT_FROZEN_ORB = "Frozen Orb"
	
	-- aSettings(Grab mail)
	L_MAIL_STOPPED = "Stopped, inventory is full."
	L_MAIL_COMPLETE = "All done."
	L_MAIL_NEED = "Need a mailbox."
	L_MAIL_MESSAGES =  "messages"
	
	-- Butsu
	L_LOOT_RANDOM = "Random Player"
	L_LOOT_SELF = "Self Loot"
	L_LOOT_UNKNOWN = "Unknown"
	L_LOOT_FISH = "Fishing loot"
	L_LOOT_MONSTER = ">> Loot from "
	L_LOOT_CHEST = ">> Loot from chest"
	L_LOOT_ANNOUNCE = "Announce to"
	L_LOOT_TO_RAID = "  raid"
	L_LOOT_TO_PARTY = "  party"
	L_LOOT_TO_GUILD = "  guild"
	L_LOOT_TO_SAY = "  say"
	L_LOOT_CANNOT = "Cannot roll"

	-- LitePanels AFK module
	L_PANELS_AFK = "You are AFK!"
	L_PANELS_AFK_RCLICK = "Right-Click to hide."
	L_PANELS_AFK_LCLICK = "Left-Click to go back."

	-- aCooldowns
	L_COOLDOWNS = "CD: "
	
	-- aSettings
	L_INVITE_ENABLE_T = "Autoinvite ON: invite"
	L_INVITE_ENABLE = "Autoinvite ON: "
	L_INVITE_DISABLE = "Autoinvite OFF"
	
	-- aSettings(Bind key)
	L_BIND_COMBAT = "You can't bind keys in combat."
	L_BIND_SAVED = "All keybindings have been saved."
	L_BIND_DISCARD = "All newly set keybindings have been discarded."
	L_BIND_INSTRUCT = "Hover your mouse over any actionbutton to bind it. Press the escape key or right click to clear the current actionbutton's keybinding."
	L_BIND_CLEARED = "All keybindings cleared for"
	L_BIND_BINDING = "Binding"
	L_BIND_KEY = "Key"
	L_BIND_NO_SET = "No bindings set"
	
	-- aSettings(Raid Planner)
	L_PLANNER_TITLE = "Raid Planner"
	L_PLANNER_IMP_TALENT = "Improved talent"
	L_PLANNER_INSPECT = "Inspecting"
	L_PLANNER_DEATHKNIGHT_1 = "Blood"
	L_PLANNER_DEATHKNIGHT_2 = "Frost"
	L_PLANNER_DEATHKNIGHT_3 = "Unholy"
	L_PLANNER_WARRIOR_1 = "Arms"
	L_PLANNER_WARRIOR_2 = "Fury"
	L_PLANNER_WARRIOR_3 = "Protection"
	L_PLANNER_ROGUE_1 = "Assassination"
	L_PLANNER_ROGUE_2 = "Combat"
	L_PLANNER_ROGUE_3 = "Subtlety"
	L_PLANNER_MAGE_1 = "Arcane"
	L_PLANNER_MAGE_2 = "Fire"
	L_PLANNER_MAGE_3 = "Frost"
	L_PLANNER_PRIEST_1 = "Discipline"
	L_PLANNER_PRIEST_2 = "Holy"
	L_PLANNER_PRIEST_3 = "Shadow"
	L_PLANNER_WARLOCK_1 = "Affliction"
	L_PLANNER_WARLOCK_2 = "Demonology"
	L_PLANNER_WARLOCK_3 = "Destruction"
	L_PLANNER_HUNTER_1 = "Beast Mastery"
	L_PLANNER_HUNTER_2 = "Marksmanship"
	L_PLANNER_HUNTER_3 = "Survival"
	L_PLANNER_DRUID_1 = "Balance"
	L_PLANNER_DRUID_2 = "Feral Combat"
	L_PLANNER_DRUID_3 = "Restoration"
	L_PLANNER_SHAMAN_1 = "Elemental"
	L_PLANNER_SHAMAN_2 = "Enhancement"
	L_PLANNER_SHAMAN_3 = "Restoration"
	L_PLANNER_PALADIN_1 = "Holy"
	L_PLANNER_PALADIN_2 = "Protection"
	L_PLANNER_PALADIN_3 = "Retribution"
	
	-- aSettings(bg score)
	L_DATATEXT_ARATHI = "Arathi Basin"
	L_DATATEXT_WARSONG = "Warsong Gulch"
	L_DATATEXT_EYE = "Eye of the Storm"
	L_DATATEXT_ALTERAC = "Alterac Valley"
	L_DATATEXT_ANCIENTS = "Strand of the Ancients"
	L_DATATEXT_ISLE = "Isle of Conquest"
	L_DATATEXT_BASESASSAULTED = "Bases Assaulted:"
	L_DATATEXT_BASESDEFENDED = "Bases Defended:"
	L_DATATEXT_TOWERSASSAULTED = "Towers Assaulted:"
	L_DATATEXT_TOWERSDEFENDED = "Towers Defended:"
	L_DATATEXT_FLAGSCAPTURED = "Flags Captured:"
	L_DATATEXT_FLAGSRETURNED = "Flags Returned:"
	L_DATATEXT_GRAVEYARDSASSAULTED = "Graveyards Assaulted:"
	L_DATATEXT_GRAVEYARDSDEFENDED = "Graveyards Defended:"
	L_DATATEXT_DEMOLISHERSDESTROYED = "Demolishers Destroyed:"
	L_DATATEXT_GATESDESTROYED = "Gates Destroyed:"
	
	-- aSettings(class scripts)
	L_CLASS_HUNTER_UNHAPPY = "Your pet is unhappy!"
	L_CLASS_HUNTER_CONTENT = "Your pet is content!"
	L_CLASS_HUNTER_HAPPY = "Your pet is happy!"
	
	-- aSettings
	L_INFO_ERRORS = "No error yet."
	L_INFO_INVITE = "Accepted invite from: "
	L_INFO_DUEL = "Declined duel request from: "
	L_INFO_DISBAND = "Disbanding group..."
	L_INFO_ADDON_SETS1 = "Type /addons <solo/party/raid/pvp/trade/quest>, to load the preinstalled set of modifications."
	L_INFO_ADDON_SETS2 = "You can add, delete or change lists of modifications, modifying wtf.lua in `scripts` folder."
	L_INFO_SETTINGS_DBM = "Type /settings dbm, to apply the settings DBM."
	L_INFO_SETTINGS_MSBT = "Type /settings msbt, to apply the settings MSBT."
	L_INFO_SETTINGS_SKADA = "Type /settings skada, to apply the settings Skada."
	L_INFO_SETTINGS_RECOUNT = "Type /settings recount, to apply the settings Recount. Then in Recount options select *Default* profile."
	L_INFO_SETTINGS_DXE = "Type /settings dxe, to apply the settings DXE. Then in DXE options select *Default* profile."
	L_INFO_SETTINGS_ALL = "Type /settings all, to apply the settings for all modifications."
	
	-- aSettings(Popups)
	L_POPUP_INSTALLUI = "First time on ShestakUI with this Character. You must reload UI to configure it."
	L_POPUP_RESETUI = "Are you sure you want to reset ShestakUI?"
	L_POPUP_SWITCH_RAID = "2 raid layouts are active, please select a layout."
	L_POPUP_DISABLEUI = "ShestakUI doesn't work for this resolution, do you want to disable ShestakUI? (Cancel if you want to try another resolution)"
	L_POPUP_SETTINGS_ALL = "Apply settings for all modifications? (DBM/DXE, Skada/Recount and MSBT)"
	
	-- aSettings(Welcome mesage)
	L_WELCOME_LINE_1 = "Welcome to ShestakUI "
	L_WELCOME_LINE_2_1 = "Type /cfg to config interface, or visit http://shestak.org"
	L_WELCOME_LINE_2_2 = "for more informations."
end