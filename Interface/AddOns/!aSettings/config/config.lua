----------------------------------------------------------------------------------------
--	ShestakUI main configuration file
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Media options
----------------------------------------------------------------------------------------
SettingsCF["media"] = {
	["font"] = [[Interface\AddOns\!aSettings\media\font.ttf]],				-- Main non pixel font
	["pixel_font"] = [[Interface\AddOns\!aSettings\media\pixelfont.ttf]],	-- Main pixel font
	["font_style"] = "OUTLINEMONOCHROME",									-- Font style, select "OUTLINEMONOCHROME" or "OUTLINE"
	["pixel_font_size"] = 8,												-- Font size for those places where it is not specified
	["blank"] = [[Interface\AddOns\!aSettings\media\white]],				-- Bright texture for border, etc
	["texture"] = [[Interface\AddOns\!aSettings\media\gray]],				-- Dull texture for status bars
	["highlight"] = [[Interface\AddOns\!aSettings\media\highlight]],		-- Highlight texture for debuffs
	["whisp_sound"] = [[Interface\AddOns\!aSettings\media\whisper.mp3]],	-- Sound for wispers
	["border_color"] = {0.37, 0.3, 0.3},		-- Color for borders
	["backdrop_color"] = {0, 0, 0},				-- Color for borders backdrop
	["overlay_color"] = {0.1, 0.1, 0.1},		-- Color for action bars overlay
	["uf_color"] = {0.4, 0.4, 0.4},				-- Color for UF if ["own_color"] = true
}

----------------------------------------------------------------------------------------
--	General options(aSettings)
----------------------------------------------------------------------------------------
SettingsCF["general"] = {
	["auto_scale"] = true,						-- Autoscale
	["multisampleprotect"] = true,				-- Disable this if you want multisample > 1
	["uiscale"] = 0.96,							-- Your value(between 0.64 and 1) if "auto_scale" is disable
	["minimap_icon"] = true,					-- UI icon near minimap
	["welcome_message"] = true,					-- Enable welcome message in chat
	--[[Correct UI Scale for resoluitons:
		y-resolution | scale
		768          | 1
		800          | 0.96
		900          | 0.8533333333333333
		1024         | 0.75
		1050         | 0.7314285714285714
		1080         | 0.7111111111111111
		1200         | 0.64
	]]
}

----------------------------------------------------------------------------------------
--	Miscellaneous options(aSettings)
----------------------------------------------------------------------------------------
SettingsCF["misc"] = {
	["auto_quest"] = false,						-- Auto accept quests(if hold shift, auto accept is disable)
	["auto_greed"] = true,						-- Push "greed" button when an item roll
	["auto_confirm_de"] = true,					-- Auto confirm disenchant
	["auto_decline_duel"] = true,				-- Auto decline duel
	["auto_accept_invite"] = false,				-- Auto accept invite
	["auto_resurrection"] = true,				-- Auto resurrection in Battle Ground
	["shift_marking"] = true,					-- Marks target when you push "shift"
	["invite_keyword"] = "invite",				-- Short keyword for invite(for enable - in game type /ainv)
	["raid_planner"] = false,					-- Raid planner
	["afk_spin_camera"] = false,				-- Spin camera while afk
}

----------------------------------------------------------------------------------------
--	Buffs reminder options(aSettings)
----------------------------------------------------------------------------------------
SettingsCF["reminder"] = {
	-- Self buffs
	["solo_buffs_enable"] = true,				-- Enable buff reminder
	["solo_buffs_sound"] = false,				-- Enable warning sound notification for buff reminder
	["solo_buffs_size"] = 45,					-- Icon size
	-- Raid buffs
	["raid_buffs_enable"] = true,				-- Show missing raid buffs
	["raid_buffs_always"] = false,				-- Show frame always
	["raid_buffs_size"] = 15.1,					-- Icon size
	["raid_buffs_alpha"] = 0,					-- Transparent icons when the buff is present
}

----------------------------------------------------------------------------------------
--	Raid/Enemy cooldown options(aCooldowns)
----------------------------------------------------------------------------------------
SettingsCF["cooldown"] = {
	-- Raid cooldowns
	["raid_enable"] = true,						-- Enable raid cooldowns
	["raid_font_size"] = 8,						-- Font size
	["raid_height"] = 15,						-- Bars height
	["raid_width"] = 186,						-- Bars width(if show_icon = false, bar width+28)
	["raid_upwards"] = false,					-- Sort upwards bars
	["raid_show_icon"] = true,					-- Show icons
	["raid_show_inraid"] = true,				-- Show in raid zone
	["raid_show_inparty"] = true,				-- Show in party zone
	["raid_show_inarena"] = true,				-- Show in arena zone
	-- Enemy cooldowns
	["enemy_enable"] = true,					-- Enable enemy cooldowns
	["enemy_size"] = 30,						-- Icon size
	["enemy_show_always"] = false,				-- Show everywhere
	["enemy_show_inpvp"] = false,				-- Show in bg zone
	["enemy_show_inarena"] = true,				-- Show in arena zone
}

----------------------------------------------------------------------------------------
--	Tooltip options(aTooltip)
----------------------------------------------------------------------------------------
SettingsCF["tooltip"] = {
	["shift_modifer"] = false,					-- Show tooltip when "shift" is pushed
	["cursor"] = false,							-- ToolTip under cursor
	["item_icon"] = false,						-- Item icon in tooltip
	["health_value"] = false,					-- Numeral health value
	["hidebuttons"] = false,					-- Hide tooltips for actions bars
	-- Plugins
	["talents"] = false,						-- Show tooltip talents
	["achievements"] = true,					-- Comparing achievements in tooltip
	["target"] = true,							-- Target player in tooltip
	["title"] = false,							-- Player title in tooltip
	["rank"] = true,							-- Player guild-rank in tooltip
	["arena_experience"] = false,				-- Player PVP experience in arena
}

----------------------------------------------------------------------------------------
--	Chat options(idChat)
----------------------------------------------------------------------------------------
SettingsCF["chat"] = {
	["font_size"] = 11,							-- Chat font size
	["font_style"] = "",						-- Font style("OUTLINE", "OUTLINEMONOCHROME", "THICKOUTLINE" or "")
	["tab_font_size"] = 8,						-- Chat tab font size
	["tab_font_style"] = "OUTLINEMONOCHROME",	-- Tab font style("OUTLINE", "OUTLINEMONOCHROME", "THICKOUTLINE" or "")
	["filter"] = true,							-- Removing some chat spam("Player1" won duel "Player2")
	["width"] = 350,							-- Chat width
	["height"] = 112,							-- Chat height
	["chat_bar"] = false,						-- Lite Button Bar for switch chat channel
	["time_color"] = "FFD700",					-- Timestamp coloring(http://www.december.com/html/spec/colorcodes.html)
	["whisp_sound"] = true,						-- Sound when whisper
}

----------------------------------------------------------------------------------------
--	Bag options(cargBags)
----------------------------------------------------------------------------------------
SettingsCF["bag"] = {
	["key_columns"] = 3,						-- Horizontal number of columns in key-bag
	["bank_columns"] = 17,						-- Horizontal number of columns in bank
	["bag_columns"] = 10,						-- Horizontal number of columns in main bag
	["hide_empty"] = false,						-- Hide empty slots
}

----------------------------------------------------------------------------------------
--	Minimap options(aMiniMap)
----------------------------------------------------------------------------------------
SettingsCF["minimap"] = {
	["tracking_icon"] = false,					-- Tracking icon
	["size"] = 126,								-- Map size
	["hide_combat"] = false,					-- Hide minimap in combat
}

----------------------------------------------------------------------------------------
--	Map options(pMap)
----------------------------------------------------------------------------------------
SettingsCF["map"] = {
	["group_icons"] = true,						-- Closscolor raid icons
	["scale"] = 0.8,							-- World map scale
	["bg_map_stylization"] = true,				-- BG map stylization
}

----------------------------------------------------------------------------------------
--	Loot options(Butsu)
----------------------------------------------------------------------------------------
SettingsCF["loot"] = {
	["font_size"] = 8,							-- Loot frame font size
	["icon_size"] = 22,							-- Icon size
	["width"] = 221,							-- Loot window width
}

----------------------------------------------------------------------------------------
--	Nameplate options(caelNamePlates)
----------------------------------------------------------------------------------------
SettingsCF["nameplate"] = {
	["font_size"] = 8,							-- Nameplate font size
	["height"] = 9,								-- Nameplate height
	["width"] = 120,							-- Nameplate width
	["combat"] = false,							-- Automatically show nameplate in combat
	["health_value"] = false,					-- Numeral health value
	--["show_castbar"] = false,					-- Show nameplate castbar(Does not work)
	["show_castbar_name"] = false,				-- Show castbar name
	["enhance_threat"] = true,					-- If tank good aggro = green, bad = red
	["class_icons"] = false,					-- Icons by class in pvp
}

----------------------------------------------------------------------------------------
--	Error options(aSettings)
----------------------------------------------------------------------------------------
SettingsCF["error"] = {							-- http://www.wowwiki.com/WoW_Constants/Errors
	["hide"] = true,							-- Enable hide combat errors
	["black"] = false,							-- Hide errors from black list
	["white"] = true,							-- Show errors from white list
	["combat"] = false,							-- Hide errors in combat
	white_list = {								-- White list errors, that will not be hidden
		[ERR_INV_FULL] = true,
		[ERR_QUEST_LOG_FULL] = true,
		[ERR_ITEM_MAX_COUNT] = true,
		[ERR_NOT_ENOUGH_MONEY] = true,
	},
	black_list = {								-- Black list errors, that will be hidden 
		[SPELL_FAILED_NO_COMBO_POINTS] = true,
		[SPELL_FAILED_TARGETS_DEAD] = true,
		[SPELL_FAILED_SPELL_IN_PROGRESS] = true,
		[SPELL_FAILED_TARGET_AURASTATE] = true,
		[SPELL_FAILED_CASTER_AURASTATE] = true,
		[SPELL_FAILED_NO_ENDURANCE] = true,
		[SPELL_FAILED_BAD_TARGETS] = true,
		[SPELL_FAILED_NOT_MOUNTED] = true,
		[SPELL_FAILED_NOT_ON_TAXI] = true,
		[SPELL_FAILED_NOT_INFRONT] = true,
		[SPELL_FAILED_NOT_IN_CONTROL] = true,
		[SPELL_FAILED_MOVING] = true,
		[ERR_ATTACK_FLEEING] = true,
		[ERR_ITEM_COOLDOWN] = true,
		[ERR_GENERIC_NO_TARGET] = true,
		[ERR_ABILITY_COOLDOWN] = true,
		[ERR_OUT_OF_ENERGY] = true,
		[ERR_NO_ATTACK_TARGET] = true,
		[ERR_SPELL_COOLDOWN] = true,
		[ERR_OUT_OF_RAGE] = true,
		[ERR_INVALID_ATTACK_TARGET] = true,
		[ERR_NOEMOTEWHILERUNNING] = true,
		[OUT_OF_ENERGY] = true,
	},
}

----------------------------------------------------------------------------------------
--	ActionBar options(rActionBarStyler)
----------------------------------------------------------------------------------------
SettingsCF["actionbar"] = {
	-- Main
	["hotkey"] = true,							-- Show text on you hotkey
	["show_grid"] = true,						-- Show empty action bar buttons
	["always_enable"] = true,					-- Show all action bars
	["button_size"] = 25,						-- Buttons size
	-- Right bars
	["rightbars_three"] = true,					-- Three or two panels on the right side *if false, you will have 3 panels under party/raid frames*
	["rightbars_mouseover"] = true,				-- Right bars on mouseover
	-- Pet bar
	["petbar_mouseover"] = false,				-- Petbar on mouseover(only for horizontal petbar)
	["petbar_hide"] = false,					-- Hide pet bar
	["petbar_horizontal"] = false,				-- Enable horizontal pet bar
	-- Shapeshift/Stance/Totem bars
	["shapeshift_mouseover"] = true,			-- Shapeshift/Stance/Totem bars on mouseover
	["shapeshift_hide"] = false,				-- Hide shapeshift
	-- Micromenu 
	["micromenu_mouseover"] = true,				-- Micromenu on mouseover
	["micromenu_hide"] = true,					-- Hide micromenu
	-- Bagsmenu
	["bags_mouseover"] = true,					-- Bag on mouseover
	["bags_hide"] = true,						-- Hide bag
}

----------------------------------------------------------------------------------------
--	UnitFrame options(oUF_Shestak/oUF_ShestakDPS/oUF_ShestakHeal)
----------------------------------------------------------------------------------------
SettingsCF["unitframe"] = {
	-- Main
	["font_size"] = 8,							-- Font size
	["aggro_border"] = true,					-- Aggro border
	["own_color"] = false,						-- Set your color for health bars
	["enemy_health_color"] = true,				-- If enable, enemy target color is red
	["show_total_value"] = false,				-- Display of info text on player and target with XXXX/Total
	["deficit_health"] = false,					-- Raid deficit health
	["color_value"] = false,					-- Health/mana value is colored
	["unit_castbar"] = true,					-- Show castbars
	["castbar_icon"] = false,					-- Show castbar icons
	["castbar_latency"] = true,					-- Castbar latency
	["show_boss"] = true,						-- Show boss frames
	["show_arena"] = true,						-- Show arena frames
	["arena_on_right"] = true,					-- Set true for oUF_ShestakDPS
	-- Raid
	["show_raid"] = true,						-- Show raid frames
	["vertical_health"] = false,				-- Vertical orientation of health
	["alpha_health"] = false,					-- Alpha of healthbars when 100%hp
	["show_range"] = true,						-- Show range opacity for raidframes
	["range_alpha"] = 0.5,						-- Alpha of unitframes when unit is out of range
	["solo_mode"] = false,						-- Show player frame always
	["player_in_party"] = true,					-- Show player frame in party
	["raid_tanks"] = true,						-- Show raid tanks
	["raid_groups"] = "1,2,3,4,5",				-- Number of groups in raid(Only for oUF_ShestakHeal)
	-- Auras/Buffs/Debuffs
	["aura_show_spiral"] = false,				-- Spiral on aura icons
	["aura_show_timer"] = true,					-- Show cooldown tier on aura icons
	["aura_player_auras"] = true,				-- Auras on player frame
	["aura_target_auras"] = true,				-- Auras on target frame
	["aura_focus_debuffs"] = false,				-- DeBuffs on focus frame
	["aura_pet_debuffs"] = false,				-- DeBuffs on pet frame
	["aura_tot_debuffs"] = false,				-- DeBuffs on targettarget frame
	["aura_player_aura_only"] = false,			-- Only your debuff on target frame
	["aura_debuff_color_type"] = true,			-- Color debuff by type
	-- Icons
	["icons_pvp"] = false,						-- Mouseover pvp text(not icons) on player and target frames
	["icons_leader"] = true,					-- Leader icon, assistant icon, master loot icon on frames
	["icons_combat"] = true,					-- Combat icon
	["icons_resting"] = true,					-- Resting icon for low lvl chars
	["icons_lfd_role"] = false,					-- Party leader icon on frames
	["icons_raid_mark"] = true,					-- Raid marks
	["icons_combo_point"] = true,				-- Rogue|Druid combo point icons
	["icons_ready_check"] = true,				-- Ready check icons
	-- Portraits
	["portrait_enable"] = false,				-- Enable player/target portraits
	["portrait_classcolor_border"] = false,		-- Enable classcolor border
	["portrait_height"] = 94,					-- Portrait height
	["portrait_width"] = 67,					-- Portrait width
	-- oUF Plugins
	["plugins_gcd"] = false,					-- Global cooldown spark
	["plugins_swing"] = false,					-- Swing bar
	["plugins_rune_bar"] = true,				-- Rune bar
	["plugins_totem_bar"] = true,				-- Totem bar
	["plugins_totem_bar_name"] = false,			-- Totem name
	["plugins_reputation_bar"] = false,			-- Reputation bar
	["plugins_experience_bar"] = false,			-- Experience bar
	["plugins_smooth_bar"] = false,				-- Smooth bar
	["plugins_combat_feedback"] = false,		-- Combat text on player/target frame
	["plugins_debuffhighlight_icon"] = false,	-- Debuff highlight texture + icon
	["plugins_aura_watch"] = true,				-- *RAID* Auras watch
	["plugins_healcomm"] = false,				-- oUF_HealComm4 on raid frame
	["plugins_healcomm_bar"] = false,			-- Bar incoming heal
	["plugins_healcomm_over"] = false,			-- Overheal bar
	["plugins_healcomm_text"] = true,			-- Text incoming heal
	["plugins_healcomm_others"] = true,			-- Hide your incoming heal
}

----------------------------------------------------------------------------------------
--	Panel options(LitePanels/LiteStats)
----------------------------------------------------------------------------------------
SettingsCF["toppanel"] = {
	["font_size"] = 8,							-- Stats font size
	["mouseover"] = true,						-- Top panel on mouseover
	["height"] = 55,							-- Panel height
	["width"] = 320,							-- Panel width
	["bg_stats"] = true,						-- BG Score
}

----------------------------------------------------------------------------------------
--	Addons group(aSettings)
----------------------------------------------------------------------------------------
SettingsCF["addon"] = {							-- Group AddOns for fast selection
	raid = {									-- Type /addons raid
		"DBM-Core",
		"DXE",
		"PallyPower",
		"alDamageMeter",
		"Skada",
		"Recount",
		"Omen",
		"sThreatMeter2",
	},
	party = {									-- Type /addons party
		"DBM-Core",
		"DXE",
		"PallyPower",
		"alDamageMeter",
		"Skada",
		"Recount",
		"Omen",
		"sThreatMeter2",
	},
	pvp = {										-- Type /addons pvp
		"ArenaHistorian",
		"ncSpellalert",
	},
	quest = {									-- Type /addons quest
		"QuestHelper",
	},
	trade = {									-- Type /addons trade
		"Auctionator", 
	},
}

----------------------------------------------------------------------------------------
--	Position options
----------------------------------------------------------------------------------------
SettingsCF["position"] = {
	-- Miscellaneous positions
	["minimap"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -23, 26},		-- aMiniMap
	["map"] = {"CENTER", UIParent, "CENTER", 0, 70},						-- pMap
	["chat"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 23, 23},				-- idChat
	["bn_popup"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 21, 20},			-- aTooltip
	["tooltip"] = {"BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 5},				-- aTooltip
	["ticket"] = {"TOPLEFT", UIParent, "TOPLEFT", 20, -20},					-- !aSettings
	["attempt"] = {"BOTTOM", UIParent, "TOP", -85, -20},					-- !aSettings
	["capture_bar"] = {"TOP", UIParent, "TOP", 0, 0},						-- !aSettings
	["vehicle"] = {"BOTTOM", Minimap, "TOP", 0, 30},						-- !aSettings
	["uierror"] = {"TOP", UIParent, "TOP", 0, -30},							-- !aSettings
	["quest"] = {"TOPLEFT", UIParent, "TOPLEFT", 25, -10},					-- !aSettings
	["loot"] = {"TOPLEFT", UIParent, "TOPLEFT", 220, -220},					-- Butsu
	["group_loot"] = {"BOTTOM", UIParent, "BOTTOM", -210, 500},				-- teksLoot
	["threat_meter"] = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, -123},	-- sThreatMeter2
	["raid_cooldown"] = {"TOPLEFT", UIParent, "TOPLEFT", 51, -28},			-- aCooldowns
	["enemy_cooldown"] = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 63, 62},	-- aCooldowns
	["bg_score"] = {"BOTTOMLEFT", UIParent, "BOTTOM", 176, 6},				-- !aSettings
	-- ActionBar positions(rActionBarStyler)
	actionbars = {
		["bar1"] = {"BOTTOM", UIParent, "BOTTOM", 2, 8},					-- Bottom bar 1
		["bar2"] = {"BOTTOM", "Bar1Holder", "TOP", 0, 1},					-- Bottom bar 2
		["bar3_bottom"] = {"BOTTOM", "Bar2Holder", "TOP", 0, 1},			-- Bottom bar 3
		["bar45"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 320},		-- Right bars
		["stance"] = {"TOPLEFT", "oUF_Player", "BOTTOMLEFT", -2, -42},		-- Stance/Shift/Totem bars
		["pet_vertical"] = {"RIGHT", "Bar45Holder", "LEFT", -3, 0},			-- Vertical pet bar
		["pet_horizontal"] = {"BOTTOM", "Bar2Holder", "TOP", 0, 1},			-- Horizontal pet bar
		["bags"] = {"TOPLEFT", UIParent, "TOPLEFT", 270, 0},				-- Bags bar
		["menu"] = {"TOPLEFT", UIParent, "TOPLEFT", 0, 0},					-- Micro-menu bar
		["vehicle"] = {"BOTTOMRIGHT", "Bar1Holder", "BOTTOMLEFT", -3, 0},	-- Vehicle button
	},
	-- UnitFrame positions(oUF_Shestak/oUF_ShestakDPS/oUF_ShestakHeal)
	unitframes = {
		["player"] = {"BOTTOM", UIParent, "BOTTOM", -284, 236},						-- Player frame
		["target"] = {"BOTTOM", UIParent, "BOTTOM", 284, 236},						-- Target frame
		["target_target"] = {"BOTTOMRIGHT", "oUF_Target", "TOPRIGHT", 0, -54},		-- ToT frame
		["pet"] = {"BOTTOMLEFT", "oUF_Player", "TOPLEFT", 0, -54},					-- Pet frame
		["focus"] = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 0, -54},				-- Focus frame
		["focus_target"] = {"BOTTOMLEFT", "oUF_Target", "TOPLEFT", 0, -54},			-- Focus target frame
		["party_heal"] = {"TOPLEFT", "oUF_Player", "BOTTOMRIGHT", 13, -12},			-- Heal layout Party frames
		["raid_heal"] = {"TOPLEFT", "oUF_Player", "BOTTOMRIGHT", 13, -12},			-- Heal layout Raid frames
		["party_dps"] = {"BOTTOMLEFT", UIParent, "LEFT", 22, -70},					-- DPS layout Party frames
		["raid_dps"] = {"TOPLEFT", UIParent, "TOPLEFT", 22, -22},					-- DPS layout Raid frames
		["arena"] = {"BOTTOMRIGHT", UIParent, "RIGHT", -20, -70},					-- Arena frames
		["boss"] = {"BOTTOMRIGHT", UIParent, "RIGHT", -20, -70},					-- Boss frames
		["tank"] = {"BOTTOMLEFT", UIParent, "BOTTOM", 176, 26},						-- Tank frames
		["player_portrait"] = {"TOPRIGHT", "oUF_Player", "TOPLEFT", -10.5, 28},		-- Player Portrait
		["target_portrait"] = {"TOPLEFT", "oUF_Target", "TOPRIGHT", 11.5, 28},		-- Target Portrait
		["player_castbar"] = {"BOTTOMLEFT", "oUF_Player", "BOTTOMRIGHT", 58, 0},	-- Player Castbar
		["target_castbar"] = {"CENTER", "oUF_Player_Castbar", "CENTER", -23, 35},	-- Target Castbar
		["focus_castbar"] = {"CENTER", UIParent, "CENTER", 0, 0},					-- Focus Castbar icon
	},
}