----------------------------------------------------------------------------------------
--	ShestakUI personal configuration file
--	BACKUP THIS FILE BEFORE UPDATING!
--	ATTENTION: When saving changes to a file encoded file should be in UTF8
----------------------------------------------------------------------------------------
--	Configuration example:
----------------------------------------------------------------------------------------
-- if SettingsDB.myname == "MegaChar" then
--		SettingsCF["chat"].width = 100500
-- 		SettingsCF["tooltip"].cursor = false	
--		SettingsCF["unitframe"].plugins_totem_bar = false
--		SettingsCF["addon"].pvp = {ADDON1, ADDON2, ADDON3, ETC}
--		SettingsCF["addon"].raid = {ADDON1, ADDON2, ADDON3, ETC}
--		SettingsCF["position"].tooltip = {"BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 5}
--		SettingsCF["position"].actionbars.bar1 = {"BOTTOM", UIParent, "BOTTOM", 2, 8}
-- end
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Font replace for zhTW and zhCN client
----------------------------------------------------------------------------------------
if SettingsDB.client == "zhTW" then
	SettingsCF["media"].font = [[Fonts\bLEI00D.ttf]]
	SettingsCF["media"].pixel_font = [[Fonts\bLEI00D.ttf]]
	SettingsCF["media"].font_style = "OUTLINE"
elseif SettingsDB.client == "zhCN" then
	SettingsCF["media"].font = [[Fonts\ZYKai_T.ttf]]
	SettingsCF["media"].pixel_font = [[Fonts\ZYKai_T.ttf]]
	SettingsCF["media"].font_style = "OUTLINE"
end

----------------------------------------------------------------------------------------
--	Per Class Config (overwrite general)
--	Class need to be UPPERCASE
----------------------------------------------------------------------------------------
if SettingsDB.myclass == "DRUID" then

end

----------------------------------------------------------------------------------------
--	Per Character Name Config (overwrite general and class)
--	Name need to be case sensitive
----------------------------------------------------------------------------------------
if SettingsDB.myname == "Черешок" 
	or SettingsDB.myname == "Вершок"
	or SettingsDB.myname == "Вещмешок" 
	or SettingsDB.myname == "Гребешок" 
	or SettingsDB.myname == "Кулешок" 
	or SettingsDB.myname == "Лапушок" 
	or SettingsDB.myname == "Обушок" 
	or SettingsDB.myname == "Ремешок"
	or SettingsDB.myname == "Шестак" then
	SettingsCF["general"].minimap_icon = false
	SettingsCF["general"].welcome_message = false
	SettingsCF["misc"].auto_quest = true
	SettingsCF["tooltip"].shift_modifer = true
	SettingsCF["tooltip"].cursor = true
	SettingsCF["tooltip"].talents = true
	SettingsCF["tooltip"].title = true
	SettingsCF["unitframe"].arena_on_right = false
	SettingsCF["unitframe"].plugins_aura_watch = true
end