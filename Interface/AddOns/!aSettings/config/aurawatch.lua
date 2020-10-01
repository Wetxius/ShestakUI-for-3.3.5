----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example : Incinerate Flesh from Lord Jaraxxus -> http://www.wowhead.com/?spell=67049
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Enemy cooldown tracker(icons)
----------------------------------------------------------------------------------------
-- aCooldowns [spell ID] = time
if SettingsCF["cooldown"].enemy_enable == true then
	SettingsDB.enemy_spells = {
		[1766] = 10,	-- Kick
		[6554] = 10,	-- Pummel
		[2139] = 24,	-- Counterspell
		[19647] = 24,	-- Spell Lock
		[10890] = 27,	-- Psychic Scream
		[47476] = 120,	-- Strangulate
		[47528] = 10,	-- Mind Freeze
		[29166] = 180,	-- Innervate
		[49039] = 120,	-- Lichborne
		[54428] = 60,	-- Divine Plea
		[10278] = 180,	-- Hand of Protection
		[16190] = 300,	-- Mana Tide Totem
		[51514] = 45,	-- Hex
		[15487] = 45,	-- Silence
		[2094] = 120,	-- Blind
		[72] = 12,		-- Shield Bash
		[33206] = 144,	-- Pain Suppression
		[15487] = 45,	-- Silence
		[34490] = 20,	-- Silencing Shot
		[14311] = 30,	-- Freezing Trap
		[16979] = 15,	-- Feral Charge - Bear
		[49376] = 30,	-- Feral Charge - Cat
		[60503] = 6,	-- Taste for Blood
	}
end

----------------------------------------------------------------------------------------
--	Raid cooldown tracker(bars)
----------------------------------------------------------------------------------------
-- aCooldowns [spell ID] = time
if SettingsCF["cooldown"].raid_enable == true then
	SettingsDB.raid_spells = {
		[48477] = 600,	-- Rebirth
		[6203] = 900,	-- Soulstone
		[6346] = 180,	-- Fear Ward
		[29166] = 180,	-- Innervate
		[32182] = 300,	-- Heroism
		[2825] = 300,	-- Bloodlust
	}
end

----------------------------------------------------------------------------------------
--	Player Buff reminder
----------------------------------------------------------------------------------------
if SettingsCF["reminder"].solo_buffs_enable == true then
	SettingsDB.buffs_reminder = {
		PRIEST = {
			588,	-- Inner Fire
		},
		HUNTER = {
			61846,	-- Aspect of the Dragonhawk
			13163,	-- Aspect of the Monkey
			13165,	-- Aspect of the Hawk
			13161,	-- Aspect of the Beast
			13159,	-- Aspect of the Pack
			20043,	-- Aspect of the Wild
			34074,	-- Aspect of the Viper
		},
		MAGE = {
			168,	-- Frost Armor
			6117,	-- Mage Armor
			7302,	-- Ice Armor
			30482,	-- Molten Armor
		},
		WARLOCK = {
			28176,	-- Fel Armor
			706,	-- Demon Armor
			687,	-- Demon Skin
		},
		PALADIN = {
			21084,	-- Seal of Righteousness
			20375,	-- Seal of Command
			20164,	-- Seal of Justice
			20165,	-- Seal of Light
			20166,	-- Seal of Wisdom
			53736,	-- Seal of Corruption
			31801,	-- Seal of Vengeance
		},
		SHAMAN = {
			52127,	-- Water Shield
			324,	-- Lightning Shield
			974,	-- Earth Shield
		},
		WARRIOR = {
			469,	-- Commanding Shout
			6673,	-- Battle Shout
		},
		DEATHKNIGHT = {
			57330,	-- Horn of Winter
			31634,	-- Shaman Strength of Earth Totem
		},
		DRUID = {
			48469,	-- Mark of the Wild
			48470,	-- Gift of the Wild
		},
	}
end

----------------------------------------------------------------------------------------
--	Raid Buff reminder
----------------------------------------------------------------------------------------
if SettingsCF["reminder"].raid_buffs_enable == true then
	SettingsDB.raid_buffs_reminder = {
		Flask = {
			53758,	-- Flask of Stoneblood
			53755,	-- Flask of the Frost Wyrm
			54212,	-- Flask of Pure Mojo
			53760,	-- Flask of Endless Rage
			17627,	-- Flask of Distilled Wisdom
		},
		BattleElixir = {
			33721,	-- Spellpower Elixir
			53746,	-- Wrath Elixir
			28497,	-- Elixir of Mighty Agility
			53748,	-- Elixir of Mighty Strength
			60346,	-- Elixir of Lightning Speed
			60344,	-- Elixir of Expertise
			60341,	-- Elixir of Deadly Strikes
			60345,	-- Elixir of Armor Piercing
			60340,	-- Elixir of Accuracy
			53749,	-- Guru's Elixir
		},
		GuardianElixir = {
			60343,	-- Elixir of Mighty Defense
			53751,	-- Elixir of Mighty Fortitude
			53764,	-- Elixir of Mighty Mageblood
			60347,	-- Elixir of Mighty Thoughts
			53763,	-- Elixir of Protection
			53747,	-- Elixir of Spirit
		},
		Food = {
			57325,	-- 80 AP
			57327,	-- 46 SP
			57329,	-- 40 CS
			57332,	-- 40 Haste
			57334,	-- 20 MP5
			57356,	-- 40 EXP
			57358,	-- 40 ARP
			57360,	-- 40 Hit
			57365,	-- 40 Spirit
			57367,	-- 40 AGI
			57371,	-- 40 STR
			59230,	-- 40 DODGE
			57399,	-- 80AP, 46SP (fish feast)
			57363,	-- Track Humanoids
			57373,	-- Track Beasts
			65247,	-- Pet 40 STR
		},
	}
end


----------------------------------------------------------------------------------------
--	AuraWatch
----------------------------------------------------------------------------------------
-- Healer Layout {spell ID, position, {r, g, b, a}, anyUnit}
if SettingsCF["unitframe"].plugins_aura_watch == true then
	-- Classbuffs
	SettingsDB.buffids = {
		PRIEST = {
			{6788, "TOPRIGHT", {1, 0, 0}, true},			-- Weakened Soul
			{48113, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},		-- Prayer of Mending
			{48068, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, 		-- Renew
			{48066, "TOPLEFT", {0.81, 0.85, 0.1}, true},	-- Power Word: Shield
			{10060, "RIGHT", {0.89, 0.1, 0.1}},				-- Power Infusion
		},
		DRUID = {
			{48440, "TOPRIGHT", {0.8, 0.4, 0.8}},			-- Rejuvenation
			{48443, "BOTTOMLEFT", {0.2, 0.8, 0.2}},			-- Regrowth
			{48450, "TOPLEFT", {0.4, 0.8, 0.2}},			-- Lifebloom
			{53249, "BOTTOMRIGHT", {0.8, 0.4, 0}},			-- Wild Growth
		},
		PALADIN = {
			{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},			-- Beacon of Light
			{53601, "TOPLEFT", {0.4, 0.7, 0.2}},			-- Sacred Shield
			{10278, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},	-- Hand of Protection
			{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},	-- Hand of Freedom
			{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},	-- Hand of Sacrafice
			{1038, "BOTTOMRIGHT", {0.93, 0.75, 0}, true},	-- Hand of Salvation
		},
		SHAMAN = {
			{61301, "TOPRIGHT", {0.7, 0.3, 0.7}},			-- Riptide 
			{49284, "BOTTOMLEFT", {0.2, 0.7, 0.2}},			-- Earth Shield
			{16237, "TOPLEFT", {0.4, 0.7, 0.2}},			-- Ancestral Fortitude
			{52000, "BOTTOMRIGHT", {0.7, 0.4, 0}},			-- Earthliving
		},
		ROGUE = {
			{57933, "TOPRIGHT", {0.89, 0.1, 0.1}},			-- Tricks of the Trade
		},
		DEATHKNIGHT = {
			{49016, "TOPRIGHT", {0.89, 0.89, 0.1}},			-- Hysteria
		},
		MAGE = {
			{54646, "TOPRIGHT", {0.2, 0.2, 1}},				-- Focus Magic
		},
		WARRIOR = {
			{59665, "TOPLEFT", {0.2, 0.2, 1}},				-- Vigilance
			{3411, "TOPRIGHT", {0.89, 0.1, 0.1}},			-- Intervene
		},
		ALL = {
			{2893, "RIGHT", {0, 1, 0}, true}, 				-- Abolish Poison
			{23333, "LEFT", {1, 0, 0}, true}, 				-- Warsong flag
			{34976, "LEFT", {1, 0, 0}, true}, 				-- Netherstorm Flag
			{64413, "RIGHT", {0.8, 0.2, 0}, true},			-- Protection of Ancient Kings
		},
	}
	
	-- Raid debuffs
	SettingsDB.debuffids = {
	-- Vault of Archavon
		-- Koralon
			67332,	-- Flaming Cinder (10)
			66684,	-- Flaming Cinder (25)
	-- Naxxramas
		-- Kel'Thuzad
			27808,	-- Frost Blast
			28408,	-- Chains of Kel'Thuzad
		-- Uncategorized
			32407,	-- Strange Aura
	-- Ulduar
		-- Ignis the Furnace Master
			62717,	-- Slag Pot
		-- XT-002 Deconstructor
			63018,	-- Searing Light
			63024,	-- Gravity Bomb
		-- The Iron Council
			61912,	-- Static Disruption
		-- Yogg-Saron
			63134,	-- Sara's Blessing
		-- Algalon
			64412,	-- Phase Punch
		-- Uncategorized
			66313,	-- Fire Bomb
	-- Trial of the Crusader
		-- Gormok the Impaler
			66331,	-- Impale
			67475,	-- Fire Bomb
			66406,	-- Snowbolled!
		-- Jormungar Behemoth
			67618,	-- Paralytic Toxin
			66869,	-- Burning Bile
		-- Icehowl
			67654,	-- Ferocious Butt
			66689,	-- Arctic Breathe
			66683,	-- Massive Crash
		-- Lord Jaraxxus
			66532,	-- Fel Fireball
			66237,	-- Incinerate Flesh
			66242,	-- Burning Inferno
			66197,	-- Legion Flame
			66283,	-- Spinning Pain Spike
			66209,	-- Touch of Jaraxxus (H)
			66211,	-- Curse of the Nether (H)
			67906,	-- Mistress's Kiss (10H)
		-- Faction Champions
			65960,	-- Blind
			65801,	-- Polymorph
			65543,	-- Psychic Scream
			66054,	-- Hex
		-- The Twin Val'kyr
			67283,	-- Dark Touch
			67298,	-- Ligth Touch
			67309,	-- Twin Spike
		-- Anub'arak
			67574,	-- Pursued by Anub'arak
			66013,	-- Penetrating Cold (10?)
			--67847,	-- Expose Weakness
			66012,	-- Freezing Slash
			67863,	-- Acid-Drenched Mandibles (25H)
	-- Icecrown Citadel
		-- Trash 
			70980, -- Web Wrap
			69969, -- Curse of Doom
			71089,71090, -- Bubbling Pus
			69483, -- Dark Reckoning
			71163, -- Devour Humanoid
			71127, -- Mortal Wound
			70435,71154, -- Rend Flesh
			71103, -- Combobulating Spray	
			70645, -- Chains of Shadow
			70671, -- Leeching Rot
			70432, -- Blood Sap	
			71252, -- Volley
			71327, -- Web
			36922, -- Bellowing Roar	
		-- Lord Marrowgar
			69065, -- Impaled
		-- Lady Deathwhisper
			43265, 72109, 72108, 61603, 60953, 56359, 54143, 60160, -- Death and Decay
			53721, 39658, 37788, 61112, 52212, 72110, 71001, -- Death and Decay
			71289, -- Dominate Mind
			71204, -- Touch of Insignificance
			67934, -- Frost Fever
			71237, -- Curse of Torpor
			71951,72490,72491,72492, -- Necrotic Strike
		-- Gunship Battle
			69651,72571,72570,72569, -- Wounding Strike
		-- Deathbringer Saurfang
			72293, -- Mark of the Fallen Champion
			72442,72385,50207,38027,72443,72441, -- Boiling Blood
			72449,72447,72409,72448,72410,72408, -- Rune of Blood
		-- Rotface
			69674,71224,73022,73023, -- Mutated Infection
			30494,69774,69776,69778,71208, -- Sticky Ooze
		-- Festergut
			69248,72274, -- Vile Gas
			71218,72272,72273,73020,73019,69240, -- Vile Gas
			72219,72551,72552,72553, -- Gastric Bloat
			69278,69279,71221, -- Gas Spore
		-- Professor Putricide
			70672,72455,72832,72833, -- Gaseous Bloat
			72549,70852,72550,72548,72297,72296,74281,72295, -- Malleable Goo
			72874,72458,72615,70853,74280,72873, -- Malleable Goo
			72454,72464,72747,72745,72746,72671,72748,72507,72506,72463,72451,72672, -- Mutated Plague
			70341, -- Slime Puddle (Spray)
			70342,70346,72869,72868, -- Slime Puddle
			70911,72854,72855,72856, -- Unbound Plague
			69774,72836,72837,72838,70447, -- Volatile Ooze Adhesive
		-- Blood Princes
			71807,72796,72797,72798, -- Glittering Sparks
			71911,71822, -- Shadow Resonance
			72999, -- Shadow Prison
		-- Blood-Queen Lana'thel
			71623,71624,71625,71626,72264,72265,72266,72267, -- Delirious Slash
			70949, --Essence of the Blood Queen
			70867,70871,70872,70879,70950,71473,71525,71530,71531,71532,71533, -- Essence of the Blood Queen
			72151,72648,72650,72649, -- Frenzied Bloodthirst
			71474,70877, -- Frenzied Bloodthirst
			71340,71341, -- Pact of the Darkfallen
			72985, -- Swarming Shadows
			71267,71268,72635,72636,72637, -- Swarming Shadows
			71264,71265,71266,71277,72638,72639,72640,72890, -- Swarming Shadows
			70923,70924,73015, -- Uncontrollable Frenzy
			70838,71510,70837,70451,70450,70445,70821, -- Blood Mirror
		-- Valithria Dreamwalker
			70873, -- Emerald Vigor
			71941, 71940, -- Twisted Nightmares
			70744,71733,72017,72018, -- Acid Burst
			70751,71738,72021,72022, -- Corrosion
			70633,71283,72025,72026, -- Gut Spray
		-- Sindragosa
			69762, -- Unchained Magic
			70126, -- Frost Beacon
			71665, -- Asphyxiation
			70157, -- Ice Tomb
		-- The Lich King
			70541,73779,73780,73781, -- Infest
			70337,70338,73785,73786,73787,73912,73913,73914, -- Necrotic Plague
			72133,73788,73789,73790, -- Pain and Suffering
			69242,73802,73800,73801, -- Soul Shriek
			73799,69409,69410,73798,73797, -- Soul Reaper
			74326,74325,68984,68985,74327,68986,68980,74296,74295,74297,73823,73654, -- Harvest Soul
	-- Ruby Sanctum
		-- Baltharus the Warborn
			74502,	-- Enervating Brand
		-- General Zarithrian
			74367,	-- Cleave Armor
		-- Saviana Ragefire
			74452,	-- Conflagration
		-- Halion
			74562,	-- Fiery Combustion
			74567,	-- Mark of Combustion (Fire)
			74792,	-- Soul Consumption
			74795,	-- Mark Of Consumption (Soul)
		-- 
			75887,	-- Blazing Aura
			74453,	-- Flame Beacon
	-- Other debuff
			6215,	-- Fear
			19753,	-- Divine Intervention
			--1243,	-- Power Word: Fortitude (Test)
			--6788,	-- Weakened Soul (Test)
			--58667,	-- Ley Curse (Test)
	}
end