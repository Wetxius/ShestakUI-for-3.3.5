----------------------------------------------------------------------------------------
--	Raid planner by Fernir
----------------------------------------------------------------------------------------
if SettingsCF["misc"].raid_planner ~= true or IsAddOnLoaded("RaidComp") then return end
local addonName, ns = ...
local inspectQueque = {}
local iunit = nil
local ourUnit = true
local inspectingUnit = nil

local EventFrame = CreateFrame("frame")
EventFrame:RegisterEvent("RAID_ROSTER_UPDATE")
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:RegisterEvent("INSPECT_TALENT_READY")

local classColStr = function(class)
	if RAID_CLASS_COLORS[class] then
		return string.format("%02x%02x%02x", RAID_CLASS_COLORS[class].r*255, RAID_CLASS_COLORS[class].g*255, RAID_CLASS_COLORS[class].b*255)
	else
		return "ffffff"
	end
end

local classColList = function(class)
	if RAID_CLASS_COLORS[class] then
		return {RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b}
	else
		return {1, 1, 1}
	end
end

local createFs = function(parent, justify, fsize)
	local f = _G[parent:GetName().."_fs_"..parent.name] or parent:CreateFontString(parent:GetName().."_fs_"..parent.name, "OVERLAY")
	f:SetFont(SettingsCF["media"].font, 12)
	if justify then
		f:SetJustifyH(justify)
	else
		f:SetJustifyH("LEFT")
	end
	return f
end

local stylefunc = function(f)
	f:SetBackdrop{ bgFile = "Interface\\Buttons\\WHITE8x8",}
	f:SetBackdropColor(0.1, 0.1, 0.1, 0.3)
end

local main = CreateFrame("frame", "rcomp_main", UIParent)
tinsert(UISpecialFrames, "rcomp_main")
main.name = main:GetName()
local buffs = CreateFrame("frame", "rcomp_buffs", main)
local debuffs = CreateFrame("frame", "rcomp_debuffs", main)
local classes = CreateFrame("frame", "rcomp_classes", main)
local raid = CreateFrame("ScrollFrame", "rcomp_raid", main)
local info = CreateFrame("ScrollFrame", "rcomp_info", main)
local scrollchildinfo = CreateFrame("frame", nil, info)
local infotext = CreateFrame("SimpleHTML", nil, scrollchildinfo)
info:SetScrollChild(scrollchildinfo)
infotext:SetFont(SettingsCF["media"].font, 12)

local scrollchild = CreateFrame("frame", nil, raid)
local raidtext = CreateFrame("SimpleHTML", nil, scrollchild)
raid:SetScrollChild(scrollchild)
raidtext:SetFont(SettingsCF["media"].font, 12)

local status = createFs(main, "LEFT", 12)
status:SetPoint("TOP", main, "BOTTOM", 0, -20)

local title = CreateFrame("frame", "rcomp_title", main)
title.name = title:GetName()

local titleText = title:CreateFontString(nil, "OVERLAY", "GameFontNormal")
titleText:SetPoint("TOP", -40, -6)
titleText:SetText(L_PLANNER_TITLE)

main:Hide()

local classtokens = {
	["DEATHKNIGHT"] = {[L_PLANNER_DEATHKNIGHT_1] = "1", [L_PLANNER_DEATHKNIGHT_2] = "2", [L_PLANNER_DEATHKNIGHT_3] = "3"},
	["DRUID"] = {[L_PLANNER_DRUID_1] = "4", [L_PLANNER_DRUID_2] = "5", [L_PLANNER_DRUID_3] = "6"},
	["HUNTER"] = {[L_PLANNER_HUNTER_1] = "7", [L_PLANNER_HUNTER_2] = "8", [L_PLANNER_HUNTER_3] = "9"},
	["MAGE"] = {[L_PLANNER_MAGE_1] = "a", [L_PLANNER_MAGE_2] = "b", [L_PLANNER_MAGE_3] = "c"},
	["PALADIN"] = {[L_PLANNER_PALADIN_1] = "d", [L_PLANNER_PALADIN_2] = "e", [L_PLANNER_PALADIN_3] = "f"},
	["PRIEST"] = {[L_PLANNER_PRIEST_1] = "g", [L_PLANNER_PRIEST_2] = "h", [L_PLANNER_PRIEST_3] = "i"},
	["ROGUE"] = {[L_PLANNER_ROGUE_1] = "j", [L_PLANNER_ROGUE_2] = "k", [L_PLANNER_ROGUE_3] = "l"},
	["SHAMAN"] = {[L_PLANNER_SHAMAN_1] = "m", [L_PLANNER_SHAMAN_2] = "n", [L_PLANNER_SHAMAN_3] = "o"},
	["WARLOCK"] = {[L_PLANNER_WARLOCK_1] = "p", [L_PLANNER_WARLOCK_2] = "q", [L_PLANNER_WARLOCK_3] = "r"},
	["WARRIOR"] = {[L_PLANNER_WARRIOR_1] = "s", [L_PLANNER_WARRIOR_2] = "t", [L_PLANNER_WARRIOR_3] = "u"},
}

local talenticons = {
	["DEATHKNIGHT"] = {[L_PLANNER_DEATHKNIGHT_1] = "Spell_Shadow_BloodBoil", [L_PLANNER_DEATHKNIGHT_2] = "Spell_Frost_FrostNova", [L_PLANNER_DEATHKNIGHT_3] = "Spell_Shadow_ShadeTrueSight"},
	["DRUID"] = {[L_PLANNER_DRUID_1] = "Spell_Nature_Lightning", [L_PLANNER_DRUID_2] = "Ability_Racial_BearForm", [L_PLANNER_DRUID_3] = "Spell_Nature_HealingTouch"},
	["HUNTER"] = {[L_PLANNER_HUNTER_1] = "Ability_Hunter_BeastTaming", [L_PLANNER_HUNTER_2] = "Ability_Marksmanship", [L_PLANNER_HUNTER_3] = "Ability_Hunter_SwiftStrike"},
	["MAGE"] = {[L_PLANNER_MAGE_1] = "Spell_Holy_MagicalSentry", [L_PLANNER_MAGE_2] = "Spell_Fire_FlameBolt", [L_PLANNER_MAGE_3] = "Spell_Frost_FrostBolt02"},
	["PALADIN"] = {[L_PLANNER_PALADIN_1] = "Spell_Holy_HolyBolt", [L_PLANNER_PALADIN_2] = "Spell_Holy_DevotionAura", [L_PLANNER_PALADIN_3] = "Spell_Holy_AuraOfLight"},
	["PRIEST"] = {[L_PLANNER_PRIEST_1] = "Spell_Holy_WordFortitude", [L_PLANNER_PRIEST_2] = "Spell_Holy_HolyBolt", [L_PLANNER_PRIEST_3] = "Spell_Shadow_ShadowWordPain"},
	["ROGUE"] = {[L_PLANNER_ROGUE_1] = "Ability_Rogue_Eviscerate", [L_PLANNER_ROGUE_2] = "Ability_BackStab", [L_PLANNER_ROGUE_3] = "Ability_Stealth"},
	["SHAMAN"] = {[L_PLANNER_SHAMAN_1] = "Spell_Nature_Lightning", [L_PLANNER_SHAMAN_2] = "Spell_Nature_LightningShield", [L_PLANNER_SHAMAN_3] = "Spell_Nature_MagicImmunity"},
	["WARLOCK"] = {[L_PLANNER_WARLOCK_1] = "Spell_Shadow_DeathCoil", [L_PLANNER_WARLOCK_2] = "Spell_Shadow_Metamorphosis", [L_PLANNER_WARLOCK_3] = "Spell_Shadow_RainOfFire"},
	["WARRIOR"] = {[L_PLANNER_WARRIOR_1] = "Ability_Rogue_Eviscerate", [L_PLANNER_WARRIOR_2] = "Ability_Warrior_InnerRage", [L_PLANNER_WARRIOR_3] = "INV_Shield_06"},
}

local token2role = {
	["1"] = "t", ["2"] = "t", ["3"] = "t", ["4"] = "r", ["5"] = "t",
	["6"] = "h", ["7"] = "r", ["8"] = "r", ["9"] = "r", ["a"] = "r",
	["b"] = "r", ["c"] = "r", ["d"] = "h", ["e"] = "t", ["f"] = "m",
	["g"] = "h", ["h"] = "h", ["i"] = "r", ["j"] = "m", ["k"] = "m",
	["l"] = "m", ["m"] = "r", ["n"] = "m", ["o"] = "h", ["p"] = "r",
	["q"] = "r", ["r"] = "r", ["s"] = "m", ["t"] = "m", ["u"] = "t",
}

local token2categories = {
	["1"] = {25, 7, 19},
	["2"] = {25, 4, 19},
	["3"] = {25, 19, 13},
	["m"] = {25, 42, 4, 11, 10, 14, 14, 18},
	["n"] = {25, 7, 42, 4, 10, 14},
	["o"] = {25, 42, 39, 4, 32, 10, 14},
	["s"] = {6, 27, 1, 22, 9, 21, 19, 3},
	["t"] = {6, 27, 5, 1, 22, 21, 19},
	["u"] = {6, 27, 1, 22, 19},
	["d"] = {6, 39, 23, 38, 35},
	["e"] = {6, 30, 31, 39, 23, 22, 18, 38, 35, 19},
	["f"] = {6, 17, 16, 39, 34, 23, 22, 18, 38, 35},
	["8"] = {7, 2, 9, 21, 20},
	["7"] = {17, 1, 9, 33, 21, 20},
	["g"] = {30, 32, 29, 26},
	["4"] = {16, 11, 24, 2, 20, 13, 15},
	["6"] = {31, 24, 2},
	["p"] = {27, 28, 29, 2, 22, 33, 12, 13},
	["q"] = {27, 28, 14, 29, 2, 22, 33, 13},
	["r"] = {27, 28, 34, 29, 2, 22, 33, 13},
	["a"] = {28, 33, 12},
	["b"] = {28, 12},
	["c"] = {28, 34, 12},
	["5"] = {5, 24, 2, 22, 9, 19},
	["h"] = {32, 29, 26},
	["9"] = {34, 2, 9, 21, 20},
	["i"] = {34, 29, 26, 15},
	["j"] = {1, 33, 18, 21},
	["k"] = {1, 33, 21, 3},
	["l"] = {1, 33, 21},
}

local categories = {
    ["1"] = {
		stype = "d",
        name = ARMOR.." (Major)",
        spells = {
            {id = 55754, class = "HUNTER"},
            {id = 8647, class = "ROGUE"},
            {id = 58567, class = "WARRIOR"},
        },
    },
    ["2"] = {
		stype = "d",
        name = ARMOR.." (Minor)",
        spells = {
            {id = 50511, class = "WARLOCK", spellimp = 18180},
            {id = 16857, class = "DRUID"},
            {id = 56631, class = "HUNTER"},
        },
    },
    ["3"] = {
		stype = "d",
        name = "Physical Vulnerability",
        spells = {
            {id = 29859, class = "WARRIOR"},
            {id = 58413, class = "ROGUE"},
        },
    },
    ["4"] = {
		stype = "b",
        name = ITEM_MOD_HASTE_MELEE_RATING_SHORT,
        spells = {
            {id = 55610, class = "DEATHKNIGHT"},
            {id = 8512, class = "SHAMAN", spellimp = 29193},
        },
    },
    ["5"] = {
		stype = "b",
        name = ITEM_MOD_CRIT_MELEE_RATING_SHORT,
        spells = {
            {id = 17007, class = "DRUID"},
            {id = 29801, class = "WARRIOR"},
		},
    },
    ["6"] = {
		stype = "b",
        name = ITEM_MOD_MELEE_ATTACK_POWER_SHORT.." (Minor)",
        spells = {
            {id = 47436, class = "WARRIOR", spellimp = 12861},
            {id = 48932, class = "PALADIN", spellimp = 20045},
        },
    },
    ["7"] = {
		stype = "b",
        name = ITEM_MOD_MELEE_ATTACK_POWER_SHORT.." (Major)",
        spells = {
            {id = 53138, class = "DEATHKNIGHT"},
            {id = 19506, class = "HUNTER"},
            {id = 30809, class = "SHAMAN"},
        },
    },
    ["9"] = {
		stype = "d",
        name = "Bleed Damage",
        spells = {
            {id = 48564, class = "DRUID"},
            {id = 57393, class = "HUNTER"},
            {id = 46855, class = "WARRIOR"},
        },
    },
    ["10"] = {
		stype = "b",
        name = ITEM_MOD_HASTE_SPELL_RATING_SHORT,
        spells = {
            {id = 3738, class = "SHAMAN"},
        },
    },
    ["11"] = {
		stype = "b",
        name = ITEM_MOD_CRIT_SPELL_RATING_SHORT,
        spells = {
            {id = 51470, class = "SHAMAN"},
            {id = 24907, class = "DRUID"},
        },
    },
    ["12"] = {
		stype = "d",
        name = ITEM_MOD_CRIT_SPELL_RATING_SHORT,
        spells = {
            {id = 12873, class = "MAGE"},
            {id = 17803, class = "WARLOCK"},
            {id = 28593, class = "MAGE"},
        },
    },
    ["13"] = {
		stype = "d",
        name = "Spell Damage Taken",
        spells = {
            {id = 47865, class = "WARLOCK", spellimp = 32484},
            {id = 48511, class = "DRUID"},
            {id = 51161, class = "DEATHKNIGHT"},
        },
    },
    ["14"] = {
		stype = "b",
        name = ITEM_MOD_SPELL_POWER_SHORT,
        spells = {
            {id = 47240, class = "WARLOCK"},
            {id = 58656, class = "SHAMAN"},
            {id = 57722, class = "SHAMAN"},
        },
    },
    ["15"] = {
		stype = "d",
        name = ITEM_MOD_HIT_SPELL_RATING_SHORT,
        spells = {
            {id = 33602, class = "DRUID"},
            {id = 33193, class = "PRIEST"},
        },
    },
    ["16"] = {
		stype = "b",
        name = "Haste",
        spells = {
            {id = 48396, class = "DRUID"},
            {id = 53648, class = "PALADIN"},
        },
    },
    ["17"] = {
		stype = "b",
        name = ITEM_MOD_SPELL_DAMAGE_DONE_SHORT,
        spells = {
            {id = 31583, class = "HUNTER"},
            {id = 34460, class = "HUNTER"},
            {id = 31869, class = "PALADIN"},
        },
    },
    ["18"] = {
		stype = "d",
        name = ITEM_MOD_CRIT_RATING_SHORT,
        spells = {
            {id = 20337, class = "PALADIN"},
            {id = 58410, class = "ROGUE"},
            {id = 30706, class = "SHAMAN"},
        },
    },
    ["19"] = {
		stype = "d",
        name = ITEM_MOD_HASTE_MELEE_RATING_SHORT,
        spells = {
            {id = 49909, class = "DEATHKNIGHT", spellimp = 51456},
            {id = 48485, class = "DRUID", spellimp = 48485},
            {id = 53696, class = "PALADIN"},
            {id = 47502, class = "WARRIOR", spellimp = 12666},
        },
    },
    ["20"] = {
		stype = "d",
        name = "Melee Hit Chance Reduction",
        spells = {
            {id = 48468, class = "DRUID"},
            {id = 3043, class = "HUNTER"},
        },
    },
    ["21"] = {
		stype = "d",
        name = ITEM_MOD_SPELL_HEALING_DONE_SHORT,
        spells = {
            {id = 49050, class = "HUNTER"},
            {id = 46911, class = "WARRIOR"},
            {id = 47486, class = "WARRIOR"},
            {id = 57978, class = "ROGUE"},
        },
    },
    ["22"] = {
		stype = "d",
        name = ITEM_MOD_ATTACK_POWER_SHORT,
        spells = {
            {id = 50511, class = "WARLOCK", spellimp = 18180},
            {id = 48560, class = "DRUID", spellimp = 16862},
            {id = 47437, class = "WARRIOR", spellimp = 12879},
            {id = 26016, class = "PALADIN"},
        },
    },
    ["23"] = {
		stype = "b",
        name = SPELL_STATALL,
        spells = {
            {id = 20217, class = "PALADIN"},
        },
    },
    ["24"] = {
		stype = "b",
        name = SPELL_STATALL,
        spells = {
            {id = 48469, class = "DRUID", spellimp = 17051},
        },
    },
    ["25"] = {
		stype = "b",
        name = ITEM_MOD_AGILITY_SHORT..", "..ITEM_MOD_STRENGTH_SHORT,
        spells = {
            {id = 57623, class = "DEATHKNIGHT"},
            {id = 58643, class = "SHAMAN", spellimp = 52456 },
        },
    },
    ["26"] = {
		stype = "b",
        name = ITEM_MOD_STAMINA_SHORT,
        spells = {
            {id = 48161, class = "PRIEST", spellimp = 14767},
        },
    },
    ["27"] = {
		stype = "b",
        name = ITEM_MOD_HEALTH_SHORT,
        spells = {
            {id = 47982, class = "WARLOCK", spellimp = 18696},
            {id = 47440, class = "WARRIOR", spellimp = 12861},
        },
    },
    ["28"] = {
		stype = "b",
        name = ITEM_MOD_INTELLECT_SHORT,
        spells = {
            {id = 42995, class = "MAGE"},
            {id = 57567, class = "WARLOCK"},
        },
    },
    ["29"] = {
		stype = "b",
        name = ITEM_MOD_SPIRIT_SHORT,
        spells = {
            {id = 48073, class = "PRIEST"},
            {id = 57567, class = "WARLOCK"},
        },
    },
    ["30"] = {
		stype = "b",
        name = COMBAT_TEXT_SHOW_RESISTANCES_TEXT,
        spells = {
            {id = 20911, class = "PALADIN"},
            {id = 57472, class = "PRIEST"},
        },
    },
    ["31"] = {
		stype = "b",
        name = ITEM_MOD_SPELL_HEALING_DONE_SHORT,
        spells = {
            {id = 20140, class = "PALADIN"},
            {id = 33891, class = "DRUID"},
        },
    },
    ["32"] = {
		stype = "b",
        name = "Physical Damage Reduction",
        spells = {
            {id = 16240, class = "SHAMAN"},
            {id = 15363, class = "PRIEST"},
        },
    },
    ["33"] = {
		stype = "d",
        name = "Cast Speed Slow",
        spells = {
            {id = 11719, class = "WARLOCK"},
            {id = 58611, class = "HUNTER"},
            {id = 5761, class = "ROGUE"},
            {id = 31589, class = "MAGE"},
        },
    },
    ["34"] = {
		stype = "b",
        name = "Replenishment",
        spells = {
            {id = 44561, class = "MAGE"},
            {id = 53292, class = "HUNTER"},
            {id = 54118, class = "WARLOCK"},
            {id = 31878, class = "PALADIN"},
            {id = 48160, class = "PRIEST"},
        },
    },
    ["35"] = {
		stype = "d",
        name = ITEM_MOD_MANA_REGENERATION_SHORT,
        spells = {
            {id = 53408, class = "PALADIN"},
        },
    },
    ["38"] = {
		stype = "d",
        name = ITEM_MOD_HEALTH_REGENERATION_SHORT,
        spells = {
            {id = 20271, class = "PALADIN"},
        },
    },
    ["39"] = {
		stype = "b",
        name = ITEM_MOD_MANA_REGENERATION_SHORT,
        spells = {
            {id = 48936, class = "PALADIN", spellimp = 20245},
            {id = 58774, class = "SHAMAN", spellimp = 16206},
        },
    },
    ["42"] = {
		stype = "b",
        name = "Bloodlust / Heroism",
        spells = {
            {id = 2825, class = "SHAMAN"},
        },
    },
}
for _,v in pairs(categories) do v.exist = false end

local getTalents = function()
	local maxpoints = 0
	local retname, rettexture = "", ""
	for tab = 1, 3 do
		local name, iconTexture, pointsSpent, background, previewPointsSpent = GetTalentTabInfo(tab, true)
		if name ~= nil then
			if maxpoints < pointsSpent then
				maxpoints = pointsSpent
				retname, rettexture = name, iconTexture
			end
		end
	end
	return retname, iconTexture
end

local makeGUI = function()
	classes:SetWidth(main:GetWidth() / 3)
	classes:SetHeight(main:GetHeight() + 10)
	classes:SetPoint("TOPLEFT", 0, -5)

	raid:SetWidth(main:GetWidth() / 3)
	raid:SetHeight(main:GetHeight() / 1.5)
	raid:SetPoint("TOPLEFT", classes, "TOPRIGHT", 10, 0)

	info:SetWidth(main:GetWidth() / 3)
	info:SetHeight(main:GetHeight() - raid:GetHeight())
	info:SetPoint("TOPLEFT", raid, "BOTTOMLEFT", 0, -10)

	buffs:SetWidth(main:GetWidth() / 3)
	buffs:SetHeight(main:GetHeight() / 1.6)
	buffs:SetPoint("TOPLEFT", raid, "TOPRIGHT", 10, 0)
	buffs.name = buffs:GetName()

	debuffs:SetWidth(main:GetWidth() / 3)
	debuffs:SetHeight(main:GetHeight() - buffs:GetHeight())
	debuffs:SetPoint("TOPLEFT", buffs, "BOTTOMLEFT", 0, -10)
	debuffs.name = debuffs:GetName()

	scrollchildinfo:SetWidth(30)
	scrollchildinfo:SetHeight(30)
	infotext:SetAllPoints(scrollchildinfo)

	scrollchild:SetWidth(30)
	scrollchild:SetHeight(30)
	raidtext:SetAllPoints(scrollchild)

	title:SetPoint("BOTTOMLEFT", main, "TOPLEFT", 80, 3)
	title:SetPoint("TOPRIGHT", main, "TOPRIGHT", 20, 27)

	local index, barheight = 0, classes:GetHeight()/40
	for i,v in pairs(classtokens) do
        local bar = _G[classes:GetName().."_"..i] or CreateFrame("frame", classes:GetName().."_"..i, classes)
        bar:SetHeight(barheight-3)
        bar:SetWidth(classes:GetWidth()-4)
        bar:SetPoint("TOPLEFT", 2, -index*barheight-2)
        bar.name = i
        stylefunc(bar)

        local tex = _G[classes:GetName().."_tex_"..i] or bar:CreateTexture(classes:GetName().."_tex_"..i, "OVERLAY")
        tex:SetWidth(bar:GetHeight()-2)
        tex:SetHeight(tex:GetWidth())
        tex:SetPoint("TOPLEFT", 2, -2)
        tex:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
        tex:SetTexCoord(unpack(CLASS_ICON_TCOORDS[i]))

        local fs = createFs(bar, "LEFT", bar:GetHeight()-4)
        fs:SetPoint("TOPLEFT", tex, "TOPRIGHT", 2, -2)
        fs:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", -2, 2)
        
        fs:SetText("|cff"..classColStr(i)..LOCALIZED_CLASS_NAMES_MALE[i].."|r")

        bar:EnableMouse(true)
        
        local iconindex = 0
        for o, k in pairs(v) do
            index = index + 1
            iconindex = iconindex + 1

            local bar2 = _G[classes:GetName().."_bar2_"..o..i] or CreateFrame("frame", classes:GetName().."_bar2_"..o..i, classes)
            bar2:SetHeight(barheight-3)
            bar2:SetWidth(classes:GetWidth()-4-20)
            bar2:SetPoint("TOPLEFT", 2+20, -index*barheight-2)
            bar2.name = o
            stylefunc(bar2)

            local tex2 = _G[classes:GetName().."_tex2_"..o..i] or bar2:CreateTexture(classes:GetName().."_tex2_"..o..i, "OVERLAY")
            tex2:SetWidth(bar2:GetHeight()-2)
            tex2:SetHeight(tex2:GetWidth())
            tex2:SetPoint("TOPLEFT", 2, -2)
            tex2:SetTexture("Interface\\Icons\\"..talenticons[i][o])
        
            local fs2 = createFs(bar2, "LEFT", bar2:GetHeight()-4)
            fs2:SetPoint("TOPLEFT", tex2, "TOPRIGHT", 2, -2)
            fs2:SetPoint("BOTTOMRIGHT", bar2, "BOTTOMRIGHT", -2, 2)
            
            fs2:SetText(o)

            bar2:EnableMouse(true)
            bar2:SetScript("OnEnter", function(self) 
                for e,q in pairs(token2categories[classtokens[i][self.name]]) do
                    local cbar = _G["rcomp_buffs_"..q]
                    if cbar then
                        cbar:SetBackdropColor(0,1,0,.2)
                    else
                        cbar = _G["rcomp_debuffs_"..q]
                        cbar:SetBackdropColor(1,0,0,.2)
                    end
                end
                self:SetBackdropColor(1,1,1,.2) 
            end)
            bar2:SetScript("OnLeave", function(self)
                for i,v in pairs(categories) do
                    local cbar = _G["rcomp_buffs_"..i]
                    if cbar then
                        stylefunc(cbar)
                    else
                        cbar = _G["rcomp_debuffs_"..i]
                        stylefunc(cbar)
                    end
                end
                stylefunc(self) 
            end)
        end
        index = index + 1
    end

    local makeBars = function(parent, stype, caption)
        local index, barheight = 0, 0
        for i,v in pairs(categories) do if v.stype==stype then index = index + 1 end  end
        barheight = parent:GetHeight() / (index+1)

        index = 0
        local fs1 = createFs(parent, "LEFT", barheight-4)
        fs1:SetPoint("TOPLEFT", 2, 0)
        fs1:SetText(caption)

        for i,v in pairs(categories) do
            if v.stype == stype then
                local bar = _G[parent:GetName().."_"..i] or CreateFrame("frame", parent:GetName().."_"..i, parent)
                bar:SetHeight(barheight-2)
                bar:SetWidth(parent:GetWidth()-4)
                bar:SetPoint("TOPLEFT", 2, -index*barheight-barheight)
                bar.ready = "Interface\\RAIDFRAME\\ReadyCheck-Ready"
                bar.notready = "Interface\\RAIDFRAME\\ReadyCheck-NotReady"
                bar.name = v.name
                stylefunc(bar)

                local tex = _G[parent:GetName().."_tex_"..i] or  bar:CreateTexture(parent:GetName().."_tex_"..i, "OVERLAY")
                tex:SetWidth(bar:GetHeight()-4)
                tex:SetHeight(tex:GetWidth())
                tex:SetPoint("TOPLEFT", 2, -2)
                if v.exist then
                    tex:SetTexture(bar.ready)
                else
                    tex:SetTexture(bar.notready)
                end

                local fs = createFs(bar, "LEFT", bar:GetHeight()-4)
                fs:SetPoint("TOPLEFT", tex, "TOPRIGHT", 2, 0)
                fs:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", -2, 2)
                fs:SetText(v.name)

                bar:EnableMouse(true)
                bar:SetScript("OnMouseUp", function(self)
                    local txt = self.name.."|n|n"
                    for j,k in pairs(v.spells) do
                        local name, _, icon = GetSpellInfo(k.id)
                        local spec = ""
                        for f, u in pairs(token2categories) do
                            for s, n in pairs(u) do
                                if tostring(n) == tostring(i) then
                                    for t,q in pairs(classtokens[k.class]) do
                                        if q==f then
                                            spec = t
                                            break
                                        end
                                    end
                                end
                            end
                        end
                        local spellimp = ""
                        if k.spellimp then spellimp = " "..L_PLANNER_IMP_TALENT end
                        local ccol = classColList(k.class)
                        txt = txt.."|cff"..classColStr(k.class)..LOCALIZED_CLASS_NAMES_MALE[k.class].." - "..spec.."|r|n      ".."|T"..icon..":0:0:0:-1|t ".."|cff71d5ff|Hspell:"..k.id.."|h["..name.."]|h|r |cffffffff"..spellimp.."|r|n"
                    end
                    infotext:SetText(txt)
                    infotext:SetScript("OnHyperlinkEnter", function(self, link, text, button)
                        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
                        GameTooltip:SetHyperlink(link)
                        GameTooltip:Show()
                    end)
                    infotext:SetScript("OnHyperlinkLeave", function(self, ...)
                        GameTooltip:Hide()
                    end)
                    
                end)
                
                bar:SetScript("OnEnter", function(self)
                    GameTooltip:ClearLines()
                    GameTooltip:SetOwner(self, ANCHOR_TOPRIGHT)
                    GameTooltip:AddLine(self.name)
                    for j,k in pairs(v.spells) do
                        local name, _, icon = GetSpellInfo(k.id)
                        local spec = ""
                        for f, u in pairs(token2categories) do
                            for s, n in pairs(u) do
                                if tostring(n) == tostring(i) then
                                    for t,q in pairs(classtokens[k.class]) do
                                        if q==f then
                                            spec = t
                                            break
                                        end
                                    end
                                end
                            end
                        end
                        self:SetBackdropColor(0,1,0,.2)
                        local spellimp = ""
                        if k.spellimp then spellimp = " ["..L_PLANNER_IMP_TALENT.."]" end
                        local ccol = classColList(k.class)
                        GameTooltip:AddDoubleLine(LOCALIZED_CLASS_NAMES_MALE[k.class], spec, ccol[1],ccol[2],ccol[3], ccol[1],ccol[2],ccol[3])
                        GameTooltip:AddDoubleLine(" ", "|T"..icon..":0:0:0:-1|t "..name.."|cffffffff"..spellimp.."|r")
                        --local cbar = _G["rcomp_classes_"..k.class]
                        --cbar:SetBackdropColor(0,1,0,.2)
                        local cbar2 = _G["rcomp_classes_bar2_"..spec..k.class]
                        cbar2:SetBackdropColor(0,1,0,.2)
                        GameTooltip:Show()
                    end
                end)
                bar:SetScript("OnLeave", function(self)
                    GameTooltip:ClearLines()
                    GameTooltip:Hide()
                    stylefunc(self)
                    for n,m in pairs(classtokens) do
                        local cbar = _G["rcomp_classes_"..n]
                        stylefunc(cbar)
                        for nn, mm in pairs(m) do
                            local cbar2 = _G["rcomp_classes_bar2_"..nn..n]
                            stylefunc(cbar2)
                        end
                    end
                end)
                index = index + 1
            end
        end
    end

	makeBars(buffs, "b", "|cff00AA00"..SHOW_BUFFS.."|r")
	makeBars(debuffs, "d", "|cffAA0000"..SHOW_DEBUFFS.."|r")
end

local StartCheckRaid = function()
    local count, gtype = 0, ""
    iunit = nil
    inspectQueque = {}
    raidtext:SetText("")
    for _,v in pairs(categories) do v.exist = false end
    
    if UnitInParty("player") then count = GetNumPartyMembers() gtype = "party" end
    if UnitInRaid("player") then count = GetNumRaidMembers() gtype = "raid" end
    
    if count then
        for i=1, count do
            local unit = gtype..i
            local class = select(2, UnitClass(unit))
            inspectQueque[unit] = { ["unit"] = unit, ["class"] = class, ["inspected"] = false, ["talents"] = "", }
        end
        
        if inspectQueque[gtype.."1"] ~= nil then
            iunit = inspectQueque[gtype.."1"].unit
            inspectingUnit = iunit
            NotifyInspect(inspectQueque[gtype.."1"].unit)
        end
    end
end

local inspectButton = CreateFrame("Button", nil, main, "UIPanelButtonTemplate")
inspectButton:SetText(INSPECT)
inspectButton:SetPoint("BOTTOMLEFT", main, "TOPLEFT", 0, 3)
inspectButton:SetWidth(70)
inspectButton:SetHeight(24)
inspectButton:SetNormalTexture("")
inspectButton:SetHighlightTexture("")
inspectButton:SetPushedTexture("")
inspectButton:SetDisabledTexture("")
SettingsDB.CreateBlizzard(inspectButton)
inspectButton:SetScript("OnClick", function()
    StartCheckRaid()
end)

EventFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" then
		if arg1 == addonName then
			SettingsDB.CreateBlizzard(buffs)
			SettingsDB.CreateBlizzard(debuffs)
			SettingsDB.CreateBlizzard(classes)
			SettingsDB.CreateBlizzard(raid)
			SettingsDB.CreateBlizzard(title)
            SettingsDB.CreateBlizzard(info)

			main:SetPoint("CENTER")
			main:SetWidth(800)
			main:SetHeight(600)
			main:SetMovable(true)
			main:EnableMouse(true)
			main:SetClampedToScreen(true)
			main:SetFrameStrata("HIGH")
			main:RegisterForDrag("LeftButton")   

			CloseButton = CreateFrame("button", nil, main, "UIPanelCloseButton")
			CloseButton:SetPoint("TOPRIGHT", title, "TOPRIGHT", 3, 4)
			CloseButton:SetScript("OnClick", function() main:Hide() end)

			makeGUI()
			EventFrame:UnregisterEvent("ADDON_LOADED")
        end
	elseif event == "INSPECT_TALENT_READY" then
		if not ourUnit then 
			for g, f in pairs(inspectQueque) do
				if f.inspected == false then
					if CheckInteractDistance(f.unit, 1) and UnitIsVisible(f.unit) and CanInspect(f.unit, false) then
						iunit = f.unit
						inspectingUnit = iunit
						NotifyInspect(f.unit)
						return
					end
				end
			end
		end

		if not UnitInParty("player") or not UnitInRaid("player") then return end
		if not iunit then return end

		if CheckInteractDistance(iunit, 1) and UnitIsVisible(iunit) and CanInspect(iunit, false) then
			inspectQueque[iunit].talents = select(1, getTalents())
			inspectQueque[iunit].inspected = true
			status:SetText(L_PLANNER_INSPECT.." "..UnitName(iunit))
        end
        
		local txt = ""
		for g, f in pairs(inspectQueque) do
			if f.inspected == false then
				txt = txt.."|cffff0000"..UnitName(f.unit).."|r|n"
			else
				txt = txt.."|cff"..classColStr(f.class)..UnitName(f.unit).."|r "..f.talents.."|n"
			end
		end
		raidtext:SetText(txt)
        
        for vv, cc in pairs(classtokens[inspectQueque[iunit].class]) do
            if vv == inspectQueque[iunit].talents then
                local token = cc
                local cat = token2categories[token]
                
                for j=1, #cat do
                    for k, v in pairs(categories) do
                        if tonumber(k) == tonumber(cat[j]) then
                            categories[k].exist = true
                            makeGUI()
                            break
                        end
                    end
                end
                break
            end
        end
        
        for g, f in pairs(inspectQueque) do
            if f.inspected == false then
                if CheckInteractDistance(f.unit, 1) and UnitIsVisible(f.unit) and CanInspect(f.unit, false) then
                    iunit = f.unit
                    inspectingUnit = iunit
                    NotifyInspect(f.unit)
                    return
                end
            end
        end
    elseif event == "RAID_ROSTER_UPDATE" then
        local count, gtype = 0, ""
        iunit = nil
        inspectQueque = {}
        
        for _,v in pairs(categories) do v.exist = false end
        
        if UnitInParty("player") then count = GetNumPartyMembers() gtype = "party" end
        if UnitInRaid("player") then count = GetNumRaidMembers() gtype = "raid" end

        for i=1, count do
            local unit = gtype..i
            local class = select(2, UnitClass(unit))
            inspectQueque[unit] = { ["unit"] = unit, ["class"] = class, ["inspected"] = false, ["talents"] = "", }
        end

        if inspectQueque[gtype.."1"] ~= nil then
            iunit = inspectQueque[gtype.."1"].unit
            inspectingUnit = inspectQueque[gtype.."1"].unit
            NotifyInspect(inspectQueque[gtype.."1"].unit)
        end
    end
end)

hooksecurefunc("NotifyInspect", function(unit)
	if unit == inspectingUnit then
		ourUnit = true
	else
		ourUnit = false
	end
end)

main:SetScript("OnDragStart", function(self, ...) self:StartMoving() end)
main:SetScript("OnDragStop", function(self, ...) self:StopMovingOrSizing() end)

-- Slash command
SLASH_RAIDCOMP1 = "/raidcomp";
SLASH_RAIDCOMP2 = "/com";
SLASH_RAIDCOMP3 = "/план";
SlashCmdList["RAIDCOMP"] = function(msg)
	main:Show()
end