oUF.TagEvents["Threat"] = "UNIT_THREAT_LIST_UPDATE"
oUF.Tags["Threat"] = function(unit)
	local tanking, status, percent = UnitDetailedThreatSituation("player", "target")
	if percent and percent > 0 then
		return ("%s%d%%|r"):format(Hex(GetThreatStatusColor(status)), percent)
	end
end

oUF.TagEvents["DiffColor"] = "UNIT_LEVEL"
if (not oUF.Tags["DiffColor"]) then
	oUF.Tags["DiffColor"]  = function(unit)
		local r, g, b
		local level = UnitLevel(unit)
		if (level < 1) then
			r, g, b = 0.69, 0.31, 0.31
		else
			local DiffColor = UnitLevel("target") - UnitLevel("player")
			if (DiffColor >= 5) then
				r, g, b = 0.69, 0.31, 0.31
			elseif (DiffColor >= 3) then
				r, g, b = 0.71, 0.43, 0.27
			elseif (DiffColor >= -2) then
				r, g, b = 0.84, 0.75, 0.65
			elseif (-DiffColor <= GetQuestGreenRange()) then
				r, g, b = 0.33, 0.59, 0.33
			else
				r, g, b = 0.55, 0.57, 0.61
			end
		end
		return string.format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
	end
end

function utf8sub(string, i, dots)
	if not string then return end
	local bytes = string:len()
	if (bytes <= i) then
		return string
	else
		local len, pos = 0, 1
		while(pos <= bytes) do
			len = len + 1
			local c = string:byte(pos)
			if (c > 0 and c <= 127) then
				pos = pos + 1
			elseif (c >= 192 and c <= 223) then
				pos = pos + 2
			elseif (c >= 224 and c <= 239) then
				pos = pos + 3
			elseif (c >= 240 and c <= 247) then
				pos = pos + 4
			end
			if (len == i) then break end
		end

		if (len == i and pos <= bytes) then
			return string:sub(1, pos - 1)..(dots and "..." or "")
		else
			return string
		end
	end
end

local colors = setmetatable({
	happiness = setmetatable({
		[1] = {0.80, 0.15, 0.15},
		[2] = {1, 1, 0},
		[3] = {0.67, 0.83, 0.45},
	}, {__index = oUF.colors.happiness}),
	reaction = setmetatable({
		[1] = {0.85, 0.27, 0.27},	-- Hated
		[2] = {0.85, 0.27, 0.27},	-- Hostile
		[3] = {0.85, 0.27, 0.27},	-- Unfriendly
		[4] = {0.85, 0.77, 0.36},	-- Neutral
		[5] = {0.33, 0.59, 0.33},	-- Friendly
		[6] = {0.33, 0.59, 0.33},	-- Honored
		[7] = {0.33, 0.59, 0.33},	-- Revered
		[8] = {0.33, 0.59, 0.33},	-- Exalted	
	}, {__index = oUF.colors.reaction}),
}, {__index = oUF.colors})

oUF.TagEvents["GetNameColor"] = "UNIT_HAPPINESS"
if (not oUF.Tags["GetNameColor"]) then
	oUF.Tags["GetNameColor"] = function(unit)
		local reaction = UnitReaction(unit, "player")
		if unit == "pet" and GetPetHappiness() then
			local c = colors.happiness[GetPetHappiness()]
			return string.format("|cff%02x%02x%02x", c[1] * 255, c[2] * 255, c[3] * 255)
		elseif UnitIsPlayer(unit) then
			return oUF.Tags["raidcolor"](unit)
		elseif reaction then
			local c = colors.reaction[reaction]
			return string.format("|cff%02x%02x%02x", c[1] * 255, c[2] * 255, c[3] * 255)
		else
			r, g, b = 0.84, 0.75, 0.65
			return string.format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
		end
	end
end

oUF.TagEvents["NameArena"] = "UNIT_NAME_UPDATE"
if (not oUF.Tags["NameArena"]) then
	oUF.Tags["NameArena"] = function(unit)
		local name = UnitName(unit)
		return utf8sub(name, 4, false)
	end
end

oUF.TagEvents["NameShort"] = "UNIT_NAME_UPDATE"
if (not oUF.Tags["NameShort"]) then
	oUF.Tags["NameShort"] = function(unit)
		local name = UnitName(unit)
		return utf8sub(name, 8, false)
	end
end

oUF.TagEvents["NameMedium"] = "UNIT_NAME_UPDATE"
if (not oUF.Tags["NameMedium"]) then
	oUF.Tags["NameMedium"] = function(unit)
		local name = UnitName(unit)
		return utf8sub(name, 11, true)
	end
end

oUF.TagEvents["NameLong"] = "UNIT_NAME_UPDATE"
if (not oUF.Tags["NameLong"]) then
	oUF.Tags["NameLong"] = function(unit)
		local name = UnitName(unit)
		return utf8sub(name, 18, true)
	end
end

-- Talents spec(by Fernir)
local spells =  {
  -- WARRIOR
  [GetSpellInfo(47486)]	= L_PLANNER_WARRIOR_1,		-- Mortal Strike
  [GetSpellInfo(46924)]	= L_PLANNER_WARRIOR_1,		-- Bladestorm
  [GetSpellInfo(23881)]	= L_PLANNER_WARRIOR_2,		-- Bloodthirst
  [GetSpellInfo(12809)]	= L_PLANNER_WARRIOR_3,		-- Concussion Blow
  [GetSpellInfo(47498)]	= L_PLANNER_WARRIOR_3,		-- Devastate
  -- PALADIN
  [GetSpellInfo(48827)]	= L_PLANNER_PALADIN_2,		-- Avenger's Shield
  [GetSpellInfo(48825)]	= L_PLANNER_PALADIN_1,		-- Holy Shock
  [GetSpellInfo(35395)]	= L_PLANNER_PALADIN_3,		-- Crusader Strike
  [GetSpellInfo(53385)]	= L_PLANNER_PALADIN_3,		-- Divine Storm
  [GetSpellInfo(20066)]	= L_PLANNER_PALADIN_3,		-- Repentance
  -- ROGUE
  [GetSpellInfo(48666)]	= L_PLANNER_ROGUE_1,		-- Mutilate
  [GetSpellInfo(51690)]	= L_PLANNER_ROGUE_2,		-- Killing Spree
  [GetSpellInfo(13877)]	= L_PLANNER_ROGUE_2,		-- Blade Flurry
  [GetSpellInfo(13750)]	= L_PLANNER_ROGUE_2,		-- Adrenaline Rush
  [GetSpellInfo(48660)]	= L_PLANNER_ROGUE_3,		-- Hemorrhage
  -- PRIEST
  [GetSpellInfo(53007)]	= L_PLANNER_PRIEST_1,		-- Penance
  [GetSpellInfo(10060)]	= L_PLANNER_PRIEST_1,		-- Power Infusion
  [GetSpellInfo(33206)]	= L_PLANNER_PRIEST_1,		-- Pain Suppression
  [GetSpellInfo(34861)]	= L_PLANNER_PRIEST_2,		-- Circle of Healing
  [GetSpellInfo(15487)]	= L_PLANNER_PRIEST_3,		-- Silence
  [GetSpellInfo(48160)]	= L_PLANNER_PRIEST_3,		-- Vampiric Touch
  -- DEATHKNIGHT
  [GetSpellInfo(55262)]	= L_PLANNER_DEATHKNIGHT_1,	-- Heart Strike
  [GetSpellInfo(49203)]	= L_PLANNER_DEATHKNIGHT_2,	-- Hungering Cold
  [GetSpellInfo(55268)]	= L_PLANNER_DEATHKNIGHT_2,	-- Frost Strike
  [GetSpellInfo(51411)]	= L_PLANNER_DEATHKNIGHT_2,	-- Howling Blast
  [GetSpellInfo(55271)]	= L_PLANNER_DEATHKNIGHT_3,	-- Scourge Strike
  -- MAGE
  [GetSpellInfo(44781)]	= L_PLANNER_MAGE_1,			-- Arcane Barrage
  [GetSpellInfo(55360)]	= L_PLANNER_MAGE_2,			-- Living Bomb
  [GetSpellInfo(42950)]	= L_PLANNER_MAGE_2,			-- Dragon's Breath
  [GetSpellInfo(42945)]	= L_PLANNER_MAGE_2,			-- Blast Wave
  [GetSpellInfo(44572)]	= L_PLANNER_MAGE_3,			-- Deep Freeze
  -- WARLOCK
  [GetSpellInfo(59164)]	= L_PLANNER_WARLOCK_1,		-- Haunt
  [GetSpellInfo(47843)]	= L_PLANNER_WARLOCK_1,		-- Unstable Affliction
  [GetSpellInfo(59672)]	= L_PLANNER_WARLOCK_2,		-- Metamorphosis
  [GetSpellInfo(59172)]	= L_PLANNER_WARLOCK_3,		-- Chaos Bolt
  [GetSpellInfo(47847)]	= L_PLANNER_WARLOCK_3,		-- Shadowfury
  -- SHAMAN
  [GetSpellInfo(59159)]	= L_PLANNER_SHAMAN_1,		-- Thunderstorm
  [GetSpellInfo(16166)]	= L_PLANNER_SHAMAN_1,		-- Elemental Mastery
  [GetSpellInfo(51533)]	= L_PLANNER_SHAMAN_2,		-- Feral Spirit
  [GetSpellInfo(30823)]	= L_PLANNER_SHAMAN_2,		-- Shamanistic Rage
  [GetSpellInfo(17364)]	= L_PLANNER_SHAMAN_2,		-- Stormstrike
  [GetSpellInfo(61301)]	= L_PLANNER_SHAMAN_3,		-- Riptide
  [GetSpellInfo(51886)]	= L_PLANNER_SHAMAN_3,		-- Cleanse Spirit
  -- HUNTER
  [GetSpellInfo(19577)]	= L_PLANNER_HUNTER_1,		-- Intimidation
  [GetSpellInfo(34490)]	= L_PLANNER_HUNTER_2,		-- Silencing Shot
  [GetSpellInfo(53209)]	= L_PLANNER_HUNTER_2,		-- Chimera Shot
  [GetSpellInfo(60053)]	= L_PLANNER_HUNTER_3,		-- Explosive Shot
  [GetSpellInfo(49012)]	= L_PLANNER_HUNTER_3,		-- Wyvern Sting
  -- DRUID
  [GetSpellInfo(53201)]	= L_PLANNER_DRUID_1,		-- Starfall
  [GetSpellInfo(61384)]	= L_PLANNER_DRUID_1,		-- Typhoon
  [GetSpellInfo(48566)]	= L_PLANNER_DRUID_2,		-- Mangle (Cat)
  [GetSpellInfo(48564)]	= L_PLANNER_DRUID_2,		-- Mangle (Bear)
  [GetSpellInfo(18562)]	= L_PLANNER_DRUID_3,		-- Swiftmend
}

local buffs = { -- credits Proditor, Rinu
  -- WARRIOR
  [GetSpellInfo(56638)]	= L_PLANNER_WARRIOR_1,		-- Taste for Blood
  [GetSpellInfo(64976)]	= L_PLANNER_WARRIOR_1,		-- Juggernaut
  [GetSpellInfo(29801)]	= L_PLANNER_WARRIOR_2,		-- Rampage
  [GetSpellInfo(50227)]	= L_PLANNER_WARRIOR_3,		-- Sword and Board
  -- PALADIN
  [GetSpellInfo(20375)]	= L_PLANNER_PALADIN_3,		-- If you are using Seal of Command, I hate you so much
  [GetSpellInfo(31836)]	= L_PLANNER_PALADIN_1,		-- Light's Grace
  -- ROGUE
  [GetSpellInfo(36554)]	= L_PLANNER_ROGUE_3,		-- Shadowstep
  [GetSpellInfo(31223)]	= L_PLANNER_ROGUE_3,		-- Master of Subtlety
  -- PRIEST
  [GetSpellInfo(47788)]	= L_PLANNER_PRIEST_2,		-- Guardian Spirit
  [GetSpellInfo(52800)]	= L_PLANNER_PRIEST_1,		-- Borrowed Time
  [GetSpellInfo(15473)]	= L_PLANNER_PRIEST_3,		-- Shadowform
  [GetSpellInfo(15286)]	= L_PLANNER_PRIEST_3,		-- Vampiric Embrace
  -- DEATHKNIGHT
  [GetSpellInfo(49222)]	= L_PLANNER_DEATHKNIGHT_3,	-- Bone Shield
  [GetSpellInfo(49016)]	= L_PLANNER_DEATHKNIGHT_1,	-- Hysteria
  [GetSpellInfo(53138)]	= L_PLANNER_DEATHKNIGHT_1,	-- Abomination's Might
  [GetSpellInfo(55610)]	= L_PLANNER_DEATHKNIGHT_2,	-- Imp. Icy Talons
  -- MAGE
  [GetSpellInfo(43039)]	= L_PLANNER_MAGE_3,			-- Ice Barrier
  [GetSpellInfo(11129)]	= L_PLANNER_MAGE_2,			-- Combustion
  [GetSpellInfo(31583)]	= L_PLANNER_MAGE_1,			-- Arcane Empowerment
  -- WARLOCK
  [GetSpellInfo(30302)]	= L_PLANNER_WARLOCK_3,		-- Nether Protection
  -- SHAMAN
  [GetSpellInfo(57663)]	= L_PLANNER_SHAMAN_1,		-- Totem of Wrath
  [GetSpellInfo(49284)]	= L_PLANNER_SHAMAN_3,		-- Earth Shield
  [GetSpellInfo(51470)]	= L_PLANNER_SHAMAN_1,		-- Elemental Oath
  [GetSpellInfo(30809)]	= L_PLANNER_SHAMAN_2,		-- Unleashed Rage
  -- HUNTER
  [GetSpellInfo(20895)]	= L_PLANNER_HUNTER_1,		-- Spirit Bond
  [GetSpellInfo(19506)]	= L_PLANNER_HUNTER_2,		-- Trueshot Aura
  -- DRUID
  [GetSpellInfo(24932)]	= L_PLANNER_DRUID_2,		-- Leader of the Pack
  [GetSpellInfo(34123)]	= L_PLANNER_DRUID_3,		-- Tree of Life
  [GetSpellInfo(24907)]	= L_PLANNER_DRUID_1,		-- Moonkin Aura
  [GetSpellInfo(53251)]	= L_PLANNER_DRUID_3,		-- Wild Growth
}

oUF.TagEvents["Talents"] = "UNIT_AURA UNIT_SPELLCAST_START"
if (not oUF.Tags["Talents"]) then
    oUF.Tags["Talents"] = function(unit, ...)
        for index = 1, 40 do
          local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, index, "HELPFUL")
          if name ~= nil and unitCaster == unit then
             if buffs[name] then
                return "|cffff0000"..buffs[name].."|r"
             end
          end
        end
        
        local spell = select(1, UnitCastingInfo(unit))
        if spell then
            if spells[spell] then
                return "|cffff0000"..spells[spell].."|r"
            end
        end
    end
end