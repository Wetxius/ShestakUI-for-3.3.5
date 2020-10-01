----------------------------------------------------------------------------------------
--	Localization for deDE client(Thanks to Baine for the translation)
----------------------------------------------------------------------------------------
if GetLocale() == "deDE" then
	L_GUI_BUTTON_RESET = "Standards wiederherstellen"
	-- General options(aSettings)
	L_GUI_GENERAL_UIICON = "UI Symbol an der Minimap"
	L_GUI_GENERAL_AUTOSCALE = "Automatisch UI skalieren"
	L_GUI_GENERAL_MULTISAMPLE = "Multisample Schutz (Saubere 1px Rahmen)"
	L_GUI_GENERAL_UISCALE = "UI Skalierung (falls automatische Skalierung deaktiviert)"
	L_GUI_GENERAL_WELCOME_MESSAGE = "Welcome message in chat"

	-- Miscellaneous options(aSettings)
	L_GUI_MISC_AUTOQUEST = "Quests automatisch annehmen"
	L_GUI_MISC_AUTOGREED = "Aktiviere automatisches Würfeln (Gier) für Gegenstände, falls das höchste Level erreicht wurde."
	L_GUI_MISC_AUTODE = "Entzauberung automatisch bestätigen"
	L_GUI_MISC_AUTODUEL = "Duell automatisch ablehnen"
	L_GUI_MISC_AUTOACCEPT = "Einladungen automatisch annehmen"
	L_GUI_MISC_AUTORESSURECT = "Automatisch im Schlachtfeld wiederbeleben"
	L_GUI_MISC_MARKING = "Ziele markieren wenn *Umschalttaste* gedürckt wird"
	L_GUI_MISC_INVKEYWORD = "Kurzes Schlüsselwort für Einladungen (/ainv)"
	L_GUI_MISC_RAID_PLANNER = "Enable Raid planner (/com)" -- Needs review
	L_GUI_MISC_SPIN_CAMERA = "Spin camera while afk" -- Needs review
	
	-- Tooltip options(aTooltip)
	L_GUI_TOOLTIP = "Tooltip"
	L_GUI_TOOLTIP_SHIFT = "Tooltip anzeigen wenn *Umschalttaste* gedrückt wird"
	L_GUI_TOOLTIP_CURSOR = "Tooltip unter dem Mauszeiger öffnen"
	L_GUI_TOOLTIP_ICON = "Symbol der Gegenstände im Tooltip anzeigen"
	L_GUI_TOOLTIP_HEALTH = "Numerischer Wert der Lebenspunkte"
	L_GUI_TOOLTIP_HIDE = "Tooltips für Aktionsleisten verstecken"
	L_GUI_TOOLTIP_TALENTS = "Zeige die Talente im Tooltip an"
	L_GUI_TOOLTIP_ACHIEVEMENTS = "Verlgeichen von Erfolgen in Tooltips"
	L_GUI_TOOLTIP_TARGET = "Ziel des Spielers im Tooltip anzeigen"
	L_GUI_TOOLTIP_TITLE = "Zeige Titel im Tooltip an"
	L_GUI_TOOLTIP_RANK = "Gildenrank im Tooltip anzeigen"
	L_GUI_TOOLTIP_ARENA_EXPERIENCE = "PVP-Erfahrung des Spielers im Tooltip anzeigen (Arena)"
	
	-- Chat options(idChat)
	L_GUI_CHAT_FONT_SIZE = "Schriftgröße des Chats"
	L_GUI_CHAT_FONT_STYLE = "Schriftart"
	L_GUI_CHAT_TAB_FONT_SIZE = "Schriftgröße der Chattabs"
	L_GUI_CHAT_TAB_FONT_STYLE = "Schriftart der Tabs"
	L_GUI_CHAT_SPAM = "Einigen Chatspam entfernen (*Spieler1* hat *Spieler2* im Duell besiegt)"
	L_GUI_CHAT_WIDTH = "Breite des Chatfensters"
	L_GUI_CHAT_HEIGHT = "Höhe desChatfensters"
	L_GUI_CHAT_BAR = "Kleine Leiste um den Chatchannel zu wechseln"
	L_GUI_CHAT_TIMESTAMP = "Farbe des Zeitstempels"
	L_GUI_CHAT_WHISP = "Geräusch abspielen wenn eine private Nachricht empfangen wird"
	
	-- Bag options(cargBags)
	L_GUI_BAGS = "Taschen"
	L_GUI_BAGS_KEY = "Anzahl der Spalten im Schlüsselring"
	L_GUI_BAGS_BANK = "Anzahl der Spalten in der Bank"
	L_GUI_BAGS_BAG = "Anzahl der Spalten in der Tasche"
	L_GUI_BAGS_HIDE_EMPTY = "Hide empty slots"  -- Needs review
	
	-- Minimap options(aMiniMap)
	L_GUI_MINIMAP_ICON = "Aufspüren-Symbol"
	L_GUI_MINIMAP_SIZE = "Kartengröße"
	L_GUI_MINIMAP_HIDE_COMBAT = "Hide minimap in combat"  -- Needs review
	
	-- Map options(pMap)
	L_GUI_MAP_ICON = "Klassenfarbe für Punkte auf der Karte"
	L_GUI_MAP_SCALE = "Skalierung der Weltkarte"
	L_GUI_MAP_BG_STYLIZATION = "Schlachtfeldkarte Aussehn"
	
	-- Loot options(Butsu)
	L_GUI_LOOT_FONT_SIZE = "Schriftgröße im Beutefenster"
	L_GUI_LOOT_ICON_SIZE = "Symbolgröße"
	L_GUI_LOOT_WIDTH = "Loot frame width"  -- Needs review
	
	-- Nameplate options(caelNamePlates)
	L_GUI_NAMEPLATE_COMBAT = "Namensplaketten automatisch im Kampf anzeigen"
	L_GUI_NAMEPLATE_HEALTH = "Numerischer Wert der Lebenspunkte"
	L_GUI_NAMEPLATE_CASTBAR = "Zeige Zauberleiste an der Namensplakette"
	L_GUI_NAMEPLATE_FONT_SIZE = "Schriftgröße in der Namensplakette"
	L_GUI_NAMEPLATE_HEIGHT = "Höhe der Namensplakette"
	L_GUI_NAMEPLATE_WIDTH = "Breite der Namensplakette"
	L_GUI_NAMEPLATE_CASTBAR_NAME = "Zeige den Namen in der Zauberleiste"
	L_GUI_NAMEPLATE_THREAT = "Falls Tank und sichere Aggro = grün, keine = rot"
	L_GUI_NAMEPLATE_CLASS_ICON = "Zeige Klassensymbole an (PVP)"

	-- Error options(aSettings)
	L_GUI_ERROR = "Fehler"
	L_GUI_ERROR_HIDE = "Zeige Fehler an"
	L_GUI_ERROR_BLACK = "Verstecke Fehler der Schwarzen Liste"
	L_GUI_ERROR_WHITE = "Zeige Fehler der Weißen Liste"
	L_GUI_ERROR_HIDE_COMBAT = "Verstecke Fehler im Kampf"
	
	-- ActionBar options(rActionBarStyler)
	L_GUI_ACTIONBAR_HOTKEY = "Zeige Hotkey-Text an"
	L_GUI_ACTIONBAR_GRID = "Zeige die leeren Knöpfe der Aktionsleisten an"
	L_GUI_ACTIONBAR_ALWAYS = "Zeige alle Aktionsleisten an"
	L_GUI_ACTIONBAR_BUTTON_SIZE = "Knopfgröße"
	L_GUI_ACTIONBAR_RIGHTBARS_THREE = "Drei oder Zwei Leisten auf der rechten Seite *falls deaktiviert, hast du 3 leisten unter den Gruppen/Raidfenstern"
	L_GUI_ACTIONBAR_RIGHTBARS_MOUSEOVER = "Zeige die rechten Leisten nur bei Mouseover"
	L_GUI_ACTIONBAR_PETBAR_MOUSEOVER = "Zeige die Begleiterleiste nur bei Mouseover(nur für horizontale Begleiterleiste)"
	L_GUI_ACTIONBAR_PETBAR_HIDE = "Verstecke Begleiterleiste"
	L_GUI_ACTIONBAR_PETBAR_HORIZONTAL = "Aktiviere horizontale Begleiterleiste"
	L_GUI_ACTIONBAR_SHAPESHIFT_MOUSEOVER = "Zeige Haltungsleiste/Gestaltenleiste/Totems nur bei Mouseover"
	L_GUI_ACTIONBAR_SHAPESHIFT_HIDE = "Gestaltenleiste verstecken"
	L_GUI_ACTIONBAR_MICROMENU_MOUSEOVER = "Mikromenü nur bei Mouseover anzeigen"
	L_GUI_ACTIONBAR_MICROMENU_HIDE = "Mikromenü verstecken"
	L_GUI_ACTIONBAR_BAGS_MOUSEOVER = "Taschenleiste nur bei Mouseover anzeigen"
	L_GUI_ACTIONBAR_BAGS_HIDE = "Taschenleiste verstecken"
	
	-- Unit frame options(oUF_Shestak)
	L_GUI_UF_FONT_SIZE = "Schriftgröße"
	L_GUI_UF_AGGRO_BORDER = "Rahmen bei Bedrohung"
	L_GUI_UF_OWN_COLOR = "Farbe für die Lebensleiste festlegen"
	L_GUI_UF_ENEMY_HEALTH_COLOR = "Enemy target healthbar is red"  -- Needs review
	L_GUI_UF_TOTAL_VALUE = "Zeige Infotext auf Spieler und Ziel mit XXX/Gesamt"
	L_GUI_UF_DEFICIT_HEALTH = "Fehlendes Leben im Raid"
	L_GUI_UF_COLOR_VALUE = "Lebens/Mana Werte einfärben"
	L_GUI_UF_UNIT_CASTBAR = "Zeige Zauberleisten"
	L_GUI_UF_CASTBAR_ICON = "Zeige Symbole der Zauberleisten an"
	L_GUI_UF_CASTBAR_LATENCY = "Latenz in Zauberleiste anzeigen"
	L_GUI_UF_SHOW_BOSS = "Zeige eigenes Fenster für Bosse an"
	L_GUI_UF_SHOW_ARENA = "Zeige Einheitenfenster in der Arena"
	L_GUI_UF_ARENA_RIGHT = "Arena frames on the right"  -- Needs review
	L_GUI_UF_SHOW_RAID = "Show raid frames"
	L_GUI_UF_VERTICAL_HEALTH = "Vertikale Orientierung für Lebensbalken"
	L_GUI_UF_ALPHA_HEALTH = "Alpha of healthbars when 100%hp"  -- Needs review
	L_GUI_UF_SHOW_RANGE = "Raidframes durchsichtig abhängig von der Entfernung"
	L_GUI_UF_RANGE_ALPHA = "Einheitenfenster zu diesem Maß ausblenden wenn außer Reichweite"
	L_GUI_UF_SOLO_MODE = "Spielerfenster immer Anzeigen"
	L_GUI_UF_PLAYER_PARTY = "Spielerfenster in der Gruppe anzeigen"
	L_GUI_UF_SHOW_TANK = "Zeige Raid Tanks an"
	L_GUI_UF_RAID_GROUP = "Anzahl der Gruppen im Raid(nur für oUF_ShestakHeal)"
	L_GUI_UF_AURA_SHOW_SPIRAL = "Spirale auf Buffsymbolen"
	L_GUI_UF_AURA_SHOW_TIMER = "Zeige Abklingzeit für Buffs"
	L_GUI_UF_AURA_PLAYER_AURAS = "Buffs auf dem Spielerfenster"
	L_GUI_UF_AURA_TARGET_AURAS = "Buffs auf dem Zielfenster"
	L_GUI_UF_AURA_FOCUS_DEBUFFS = "Debuffs auf dem Fokusfenster"
	L_GUI_UF_AURA_PET_DEBUFFS = "Debuffs auf dem Begleiterfenster"
	L_GUI_UF_AURA_TOT_DEBUFFS = "Debuffs bei Ziel des Ziels anzeigen"
	L_GUI_UF_AURA_PLAYER_AURA_ONLY = "Nur eigenen Debuffs bei dem Zielfenster anzeigen"
	L_GUI_UF_AURA_DEBUFF_COLOR_TYPE = "Debuffs nach Art einfärben"
	L_GUI_UF_ICONS_PVP = "Zeige PVP Text (keine Symbole) bei Mouseover (Spieler+Ziel)"
	L_GUI_UF_ICONS_LEADER = "Anführer/Assistent/Plündermeister-Symbole an den Fenstern anzeigen"
	L_GUI_UF_ICONS_COMBAT = "Kampfsymbol"
	L_GUI_UF_ICONS_RESTING = "Ausruhensymbol für low-lvl Chars"
	L_GUI_UF_ICONS_LFD_ROLE = "Gruppenanführersymbol an den Fenstern"
	L_GUI_UF_ICONS_RAID_MARK = "Raidsymbole"
	L_GUI_UF_ICONS_COMBO_POINT = "Symbole für Schurke|Druide Kombopunkte"
	L_GUI_UF_ICONS_READY_CHECK = "Bereitschaftschecksymbole"
	L_GUI_UF_PORTRAIT_ENABLE = "Aktiviere Spieler/Ziel Portraits"
	L_GUI_UF_PORTRAIT_CLASSCOLOR_BORDER = "Aktiviere Rahmen in Klassenfarbe"
	L_GUI_UF_PORTRAIT_HEIGHT = "Portraithöhe"
	L_GUI_UF_PORTRAIT_WIDTH = "Portraitbreite"
	L_GUI_UF_PLUGINS_GCD = "Blitz für globalen Cooldown"
	L_GUI_UF_PLUGINS_SWING = "Swingleiste"
	L_GUI_UF_PLUGINS_RUNE_BAR = "Runenleiste"
	L_GUI_UF_PLUGINS_TOTEM_BAR = "Totemleiste"
	L_GUI_UF_PLUGINS_TOTEM_BAR_NAME = "Totemname"
	L_GUI_UF_PLUGINS_REPUTATION_BAR = "Rufleiste"
	L_GUI_UF_PLUGINS_EXPERIENCE_BAR = "Erfahrungsleiste"
	L_GUI_UF_PLUGINS_SMOOTH_BAR = "Weichgezeichnete Leisten"
	L_GUI_UF_PLUGINS_COMBAT_FEEDBACK = "Kampftexts auf Spieler/Zielfenster"
	L_GUI_UF_PLUGINS_DEBUFFHIGHLIGHT_ICON = "Debuff highlight texture + icon"  -- Needs review
	L_GUI_UF_PLUGINS_AURA_WATCH = "*RAID* Buffüberwachung"
	L_GUI_UF_PLUGINS_HEALCOMM = "oUF_HealComm4 für Raidframes"
	L_GUI_UF_PLUGINS_HEALCOMM_BAR = "Leiste für Eingehende Heilung"
	L_GUI_UF_PLUGINS_HEALCOMM_OVER = "Leiste für Overheal"
	L_GUI_UF_PLUGINS_HEALCOMM_TEXT = "Text für eingehende Heilung"
	L_GUI_UF_PLUGINS_HEALCOMM_OTHERS = "Verstecke eigene eingehende Heilung"
	
	-- Panel options(LitePanels/LiteStats)
	L_GUI_TOP_PANEL = "Oberes Panel"
	L_GUI_TOP_PANEL_MOUSE = "Oberes Panel nur bei Mouseover anzeigen"
	L_GUI_TOP_PANEL_WIDTH = "Breite des Panels"
	L_GUI_TOP_PANEL_HEIGHT = "Höhe des Panels"
	L_GUI_TOP_PANEL_FONT_SYZE = "Schriftgröße der Werte"
	L_GUI_TOP_PANEL_BG_SCORE = "BG Score" -- Needs review
	
	-- Buffs reminder options(aSettings)
	L_GUI_REMINDER = "Erinnerungen für Buffs"
	L_GUI_REMINDER_SOLO_ENABLE = "Zeige fehlende Eigenbuffs"
	L_GUI_REMINDER_SOLO_SOUND = "Spiele Warngeräusch ab bei fehlenden Eigenbuffs"
	L_GUI_REMINDER_SOLO_SIZE = "Self buffs icon size"
	L_GUI_REMINDER_RAID_ENABLE = "Zeige fehlende Raidbuffs an"
	L_GUI_REMINDER_RAID_ALWAYS = "Zeige Bufferinnerungen immer an"
	L_GUI_REMINDER_RAID_SIZE = "Symbolgröße für Raidbuffs"
	L_GUI_REMINDER_RAID_ALPHA = "Transparente Symbole wenn der Buff vorhanden ist"
	
	-- Raid/Enemy cooldown options(aCooldowns)
	L_GUI_COOLDOWN = "Abklingzeiten"
	L_GUI_COOLDOWN_RAID_ENABLE = "Abklingzeiten des Raids aktivieren"
	L_GUI_COOLDOWN_RAID_FONT = "Schriftgröße für Raidabklingzeit"
	L_GUI_COOLDOWN_RAID_HEIGHT = "Leistenhöhe für Raidabklingzeiten"
	L_GUI_COOLDOWN_RAID_WIDTH = "Leistenbreite der Raidabklingzeiten(Wenn das Symbol aktiviert ist, Breite+28)"
	L_GUI_COOLDOWN_RAID_SORT = "Leisten für Raidabklingzeiten wachsen nach oben"
	L_GUI_COOLDOWN_RAID_ICONS = "Symbole für Raidabklingzeiten"
	L_GUI_COOLDOWN_RAID_IN_RAID = "Zeige Raidabklingzeiten in Raidgebieten"
	L_GUI_COOLDOWN_RAID_IN_PARTY = "Zeige Raidabklingzeiten in Gruppengebieten"
	L_GUI_COOLDOWN_RAID_IN_ARENA = "Zeige Raidabklingzeiten in der Arena"
	L_GUI_COOLDOWN_ENEMY = "Aktiviere gegnerische Abklingzeiten"
	L_GUI_COOLDOWN_ENEMY_SIZE = "Symbolgröße für gegnerische Abklingzeiten"
	L_GUI_COOLDOWN_ENEMY_EVERYWHERE = "Zeige gegnerische Abklingzeiten überall"
	L_GUI_COOLDOWN_ENEMY_IN_BG = "Zeige gegnerische Abklingzeiten in Schlachtfeldern"
	L_GUI_COOLDOWN_ENEMY_IN_ARENA = "Zeige gegnerische Abklingzeiten in der Arena"
end