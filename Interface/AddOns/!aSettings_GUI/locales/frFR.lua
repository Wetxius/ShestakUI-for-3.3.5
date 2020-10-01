----------------------------------------------------------------------------------------
--	Localization for frFR client(Thanks to Cranan for the translation)
----------------------------------------------------------------------------------------
if GetLocale() == "frFR" then
	L_GUI_BUTTON_RESET = "Rйinitialisation totale de l'UI"
	-- General options(aSettings)
	L_GUI_GENERAL_UIICON = "Icone prиs de la minimap"
	L_GUI_GENERAL_AUTOSCALE = "Mise а l'йchelle automatique"
	L_GUI_GENERAL_MULTISAMPLE = "Protection multi йchantillonnage (bordure 1px)"
	L_GUI_GENERAL_UISCALE = "Mettre l'UI а l'йchelle (si 'Mise а l'йchelle automatique' est dйsactivйe)"
	L_GUI_GENERAL_WELCOME_MESSAGE = "Message de bienvenue pour le chat"

	-- Miscellaneous options(aSettings)
	L_GUI_MISC_AUTOQUEST = "Accepter les quкtes automatiquement"
	L_GUI_MISC_AUTOGREED = "Activer dйsenchantement automatique pour les objets verts au niveau maximum"
	L_GUI_MISC_AUTODE = "Confirmation automatique pour le dйsenchantement"
	L_GUI_MISC_AUTODUEL = "Dйcliner les duels automatiquement"
	L_GUI_MISC_AUTOACCEPT = "Accepter automatiquement les invitations"
	L_GUI_MISC_AUTORESSURECT = "Autorйsurrection en champ de bataille"
	L_GUI_MISC_MARKING = "Marque la cible quand vous appuyez sur MAJ"
	L_GUI_MISC_INVKEYWORD = "Mot clй pour inviter (/ainv)"
	L_GUI_MISC_RAID_PLANNER = "Enable Raid planner (/com)" -- Needs review
	L_GUI_MISC_SPIN_CAMERA = "Spin camera while afk" -- Needs review
	
	-- Tooltip options(aTooltip)
	L_GUI_TOOLTIP = "Tooltip"
	L_GUI_TOOLTIP_SHIFT = "Afficher le tooltip quand *MAJ* est appuyйe"
	L_GUI_TOOLTIP_CURSOR = "Tooltip sous le curseur"
	L_GUI_TOOLTIP_ICON = "Icone de l'objet dans le tooltip"
	L_GUI_TOOLTIP_HEALTH = "Valeur de point de vie"
	L_GUI_TOOLTIP_HIDE = "Cacher le tooltip pour les barres d'action"
	L_GUI_TOOLTIP_TALENTS = "Afficher les talents dans le tooltip"
	L_GUI_TOOLTIP_ACHIEVEMENTS = "Afficher Comparer les Hauts Faits dans le tooltip"
	L_GUI_TOOLTIP_TARGET = "Afficher la cible dans le tooltip"
	L_GUI_TOOLTIP_TITLE = "Titre dans le tooltip"
	L_GUI_TOOLTIP_RANK = "Afficher le rang de guilde dans le tooltip"
	L_GUI_TOOLTIP_ARENA_EXPERIENCE = "Expйrience en arиne"
	
	-- Chat options(idChat)
	L_GUI_CHAT_FONT_SIZE = "Taille de police du chat"
	L_GUI_CHAT_FONT_STYLE = "Style de police"
	L_GUI_CHAT_TAB_FONT_SIZE = "Taille de police des onglets du chat"
	L_GUI_CHAT_TAB_FONT_STYLE = "Style de police des onglets"
	L_GUI_CHAT_SPAM = "Retirer certains spams (ex: joueur1 a battu en duel joueur2)"
	L_GUI_CHAT_WIDTH = "Largeur du chat"
	L_GUI_CHAT_HEIGHT = "Hauteur du chat"
	L_GUI_CHAT_BAR = "Bouton pour changer de canal"
	L_GUI_CHAT_TIMESTAMP = "Coloration du temps"
	L_GUI_CHAT_WHISP = "Alerte sonore quand murmure"
	
	-- Bag options(cargBags)
	L_GUI_BAGS = "Sacs"
	L_GUI_BAGS_KEY = "Nombre de colonne pour le porte-clй"
	L_GUI_BAGS_BANK = "Nombre de colonne pour la banque"
	L_GUI_BAGS_BAG = "Nombre de colonne pour les sacs"
	L_GUI_BAGS_HIDE_EMPTY = "Hide empty slots"
	
	-- Minimap options(aMiniMap)
	L_GUI_MINIMAP_ICON = "Icone de pistage"
	L_GUI_MINIMAP_SIZE = "Taille de la minicarte"
	L_GUI_MINIMAP_HIDE_COMBAT = "Hide minimap in combat"  -- Needs review
	
	-- Map options(pMap)
	L_GUI_MAP_ICON = "Icones de raid aux couleurs des classes"
	L_GUI_MAP_SCALE = "Echelle de la carte"
	L_GUI_MAP_BG_STYLIZATION = "Style d'arriиre plan de la carte"
	
	-- Loot options(Butsu)
	L_GUI_LOOT_FONT_SIZE = "Taille de la police de la fenкtre de butin"
	L_GUI_LOOT_ICON_SIZE = "Taille de l'icone"
	L_GUI_LOOT_WIDTH = "Loot frame width"
	
	-- Nameplate options(caelNamePlates)
	L_GUI_NAMEPLATE_COMBAT = "Afficher automatiquement les barres de nom en combat"
	L_GUI_NAMEPLATE_HEALTH = "Valeur de points de vie"
	L_GUI_NAMEPLATE_CASTBAR = "Afficher la barre de sort"
	L_GUI_NAMEPLATE_FONT_SIZE = "Taille de la police des barres de nom"
	L_GUI_NAMEPLATE_HEIGHT = "Hauteur des barres de nom"
	L_GUI_NAMEPLATE_WIDTH = "Largeur des barres de nom"
	L_GUI_NAMEPLATE_CASTBAR_NAME = "Afficher le nom du sort"
	L_GUI_NAMEPLATE_THREAT = "Afficher la menace (vert = aggro, rouge =OK)"
	L_GUI_NAMEPLATE_CLASS_ICON = "Icone de classe en JcJ"

	-- Error options(aSettings)
	L_GUI_ERROR = "Erreurs"
	L_GUI_ERROR_HIDE = "Cacher les erreurs"
	L_GUI_ERROR_BLACK = "Cacher les erreurs de la liste noire"
	L_GUI_ERROR_WHITE = "Afficher les erreurs de la liste blanche"
	L_GUI_ERROR_HIDE_COMBAT = "Cacher les erreurs en combat"
	
	-- ActionBar options(rActionBarStyler)
	L_GUI_ACTIONBAR_HOTKEY = "Afficher le texte des macros"
	L_GUI_ACTIONBAR_GRID = "Afficher les boutons vides"
	L_GUI_ACTIONBAR_ALWAYS = "Afficher toutes les barres d'action"
	L_GUI_ACTIONBAR_BUTTON_SIZE = "Taille des boutons"
	L_GUI_ACTIONBAR_RIGHTBARS_THREE = "3 ou 2 barres а droite *Sinon, Vous aurez 3 barres en dessous de fenкtre de groupe/raid*"
	L_GUI_ACTIONBAR_RIGHTBARS_MOUSEOVER = "Barres de droite en 'mouseover'"
	L_GUI_ACTIONBAR_PETBAR_MOUSEOVER = "Barre du familier en 'mouseover'(uniquement pour la barre horizontale)"
	L_GUI_ACTIONBAR_PETBAR_HIDE = "Cacher la barre du familier"
	L_GUI_ACTIONBAR_PETBAR_HORIZONTAL = "Activer la barre du familier horizontale"
	L_GUI_ACTIONBAR_SHAPESHIFT_MOUSEOVER = "Changeforme/Posture/barre de totems en 'mouseover'"
	L_GUI_ACTIONBAR_SHAPESHIFT_HIDE = "Cacher changeforme"
	L_GUI_ACTIONBAR_MICROMENU_MOUSEOVER = "Micromenu en 'mouseover'"
	L_GUI_ACTIONBAR_MICROMENU_HIDE = "Cacher micromenu"
	L_GUI_ACTIONBAR_BAGS_MOUSEOVER = "Sac en 'mouseover'"
	L_GUI_ACTIONBAR_BAGS_HIDE = "Cacher les sacs"
	
	-- Unit frame options(oUF_Shestak)
	L_GUI_UF_FONT_SIZE = "Taille de la police"
	L_GUI_UF_AGGRO_BORDER = "Aggro signalйe en bordure"
	L_GUI_UF_OWN_COLOR = "Mettre la couleur de classe comme couleur pour la barre de vie"
	L_GUI_UF_ENEMY_HEALTH_COLOR = "Si activйe, la couleur des cibles ennemi est rouge"
	L_GUI_UF_TOTAL_VALUE = "Display of info text on player and target with XXXX/Total" -- don't understand the meaning
	L_GUI_UF_DEFICIT_HEALTH = "Dйficit en vie du raid"
	L_GUI_UF_COLOR_VALUE = "Valeur de vie/mana colorйe"
	L_GUI_UF_UNIT_CASTBAR = "Voir la barre de cast"
	L_GUI_UF_CASTBAR_ICON = "Voir l'icone de la barre de cast"
	L_GUI_UF_CASTBAR_LATENCY = "Voir la latence de la barre de cast"
	L_GUI_UF_SHOW_BOSS = "Afficher les barres du boss"
	L_GUI_UF_SHOW_ARENA = "Afficher les barres d'arиne"
	L_GUI_UF_ARENA_RIGHT = "Arena frames on the right"
	L_GUI_UF_SHOW_RAID = "Show raid frames"
	L_GUI_UF_VERTICAL_HEALTH = "Orientation vertical des barres de vie"
	L_GUI_UF_ALPHA_HEALTH = "Alpha of healthbars when 100%hp"
	L_GUI_UF_SHOW_RANGE = "Changer l'opacitй par rapport а la portйe sur les barres de raid"
	L_GUI_UF_RANGE_ALPHA = "Alpha de la barre quand hors de portйe"
	L_GUI_UF_SOLO_MODE = "Toujours afficher la barre du joueur"
	L_GUI_UF_PLAYER_PARTY = "Afficher la barre du joueur en groupe"
	L_GUI_UF_SHOW_TANK = "Afficher les tanks de raid"
	L_GUI_UF_RAID_GROUP = "Nombre de groupe dans le raid (Seulement pour oUF_ShestakHeal)"
	L_GUI_UF_AURA_SHOW_SPIRAL = "Spiral on aura icons" -- I don't know
	L_GUI_UF_AURA_SHOW_TIMER = "Show cooldown tier on aura icons" -- Idon't know
	L_GUI_UF_AURA_PLAYER_AURAS = "Auras sur la barre du joueur"
	L_GUI_UF_AURA_TARGET_AURAS = "Auras sur la barre de cible"
	L_GUI_UF_AURA_FOCUS_DEBUFFS = "Afficher les debuffs du focus"
	L_GUI_UF_AURA_PET_DEBUFFS = "Afficher les debuffs du pet"
	L_GUI_UF_AURA_TOT_DEBUFFS = "Afficher les debuffs de la cible de la cible"
	L_GUI_UF_AURA_PLAYER_AURA_ONLY = "Afficher seulement ses propres debuffs sur la cible"
	L_GUI_UF_AURA_DEBUFF_COLOR_TYPE = "Coleur de debuff par type"
	L_GUI_UF_ICONS_PVP = "Texte JcJ en Mouseover pour la barre du joueur et celle de la cible"
	L_GUI_UF_ICONS_LEADER = "Icone du Chef de raid, icone de l'assistant, icone du maоtre du butin"
	L_GUI_UF_ICONS_COMBAT = "Icone de combat"
	L_GUI_UF_ICONS_RESTING = "Icone Resting pour les personnage de bas niveau"
	L_GUI_UF_ICONS_LFD_ROLE = "Icone de chef de raid"
	L_GUI_UF_ICONS_RAID_MARK = "Signe de raid"
	L_GUI_UF_ICONS_COMBO_POINT = "Affichage des points de combo pour les Voleurs/druides"
	L_GUI_UF_ICONS_READY_CHECK = "Icone d'appel"
	L_GUI_UF_PORTRAIT_ENABLE = "Activer les portraits du joueur et de la cible"
	L_GUI_UF_PORTRAIT_CLASSCOLOR_BORDER = "Activer la bordure aux couleurs de la classe"
	L_GUI_UF_PORTRAIT_HEIGHT = "Hauteur des portraits"
	L_GUI_UF_PORTRAIT_WIDTH = "Largeur des portraits"
	L_GUI_UF_PLUGINS_GCD = "Scintillement du GCD"
	L_GUI_UF_PLUGINS_SWING = "Barre d'attaque automatique / tir automatique"
	L_GUI_UF_PLUGINS_RUNE_BAR = "Barre de rune"
	L_GUI_UF_PLUGINS_TOTEM_BAR = "Barre de totem"
	L_GUI_UF_PLUGINS_TOTEM_BAR_NAME = "Nom des totems"
	L_GUI_UF_PLUGINS_REPUTATION_BAR = "Barre de rйputation"
	L_GUI_UF_PLUGINS_EXPERIENCE_BAR = "Barre d'expйrience"
	L_GUI_UF_PLUGINS_SMOOTH_BAR = "Barre lisse"
	L_GUI_UF_PLUGINS_COMBAT_FEEDBACK = "Texte de combat sur les barres du joueur et de la cible"
	L_GUI_UF_PLUGINS_DEBUFFHIGHLIGHT_ICON = "Debuff highlight texture + icon"  -- Needs review
	L_GUI_UF_PLUGINS_AURA_WATCH = "Aura/debuff de raid"
	L_GUI_UF_PLUGINS_HEALCOMM = "Afficher oUF_HealComm4 sur les barres de raid"
	L_GUI_UF_PLUGINS_HEALCOMM_BAR = "Barre de soin entrant (incoming)"
	L_GUI_UF_PLUGINS_HEALCOMM_OVER = "Barre d'overheal"
	L_GUI_UF_PLUGINS_HEALCOMM_TEXT = "Texte de soin entrant (incoming)"
	L_GUI_UF_PLUGINS_HEALCOMM_OTHERS = "Cacher votre soin entrant (incoming)"
	
	-- Panel options(LitePanels/LiteStats)
	L_GUI_TOP_PANEL = "Panneau supйrieur"
	L_GUI_TOP_PANEL_MOUSE = "Panneau supйrieur en 'mouseover'"
	L_GUI_TOP_PANEL_WIDTH = "Largeur du panneau"
	L_GUI_TOP_PANEL_HEIGHT = "Hauteur du panneau"
	L_GUI_TOP_PANEL_FONT_SYZE = "Taille de police des stats"
	L_GUI_TOP_PANEL_BG_SCORE = "BG Score" -- Needs review
	
	-- Buffs reminder options(aSettings)
	L_GUI_REMINDER = "Contrфle des buffs"
	L_GUI_REMINDER_SOLO_ENABLE = "Voir les buffs personnels manquants"
	L_GUI_REMINDER_SOLO_SOUND = "Son d'alerte si buff manquant"
	L_GUI_REMINDER_SOLO_SIZE = "Taille de l'icone pour les buffs personnels"
	L_GUI_REMINDER_RAID_ENABLE = "Voir les buffs de raid manquants"
	L_GUI_REMINDER_RAID_ALWAYS = "Toujours voir les buffs manquants"
	L_GUI_REMINDER_RAID_SIZE = "Taille de l'icone pour les buffs de raid"
	L_GUI_REMINDER_RAID_ALPHA = "Icone transparente quand le buff de raid est prйsent"
	
	-- Raid/Enemy cooldown options(aCooldowns)
	L_GUI_COOLDOWN = "CD Raid/Ennemi"
	L_GUI_COOLDOWN_RAID_ENABLE = "Activer les CD de raid"
	L_GUI_COOLDOWN_RAID_FONT = "Taille de la police des CD de raid"
	L_GUI_COOLDOWN_RAID_HEIGHT = "Hauteur de la barre des CD de raid"
	L_GUI_COOLDOWN_RAID_WIDTH = "Largeur de la barre des CD de raid (+28 si l'icone est activй)"
	L_GUI_COOLDOWN_RAID_SORT = "Nouvelle barre au dessus"
	L_GUI_COOLDOWN_RAID_ICONS = "Icones des CD de raid"
	L_GUI_COOLDOWN_RAID_IN_RAID = "Voir les CD alliйs en raid"
	L_GUI_COOLDOWN_RAID_IN_PARTY = "Voir les CD alliйs en groupe"
	L_GUI_COOLDOWN_RAID_IN_ARENA = "Voir les CD alliйs en arиne"
	L_GUI_COOLDOWN_ENEMY = "Activier les CD ennemis"
	L_GUI_COOLDOWN_ENEMY_SIZE = "Taille de l'icone des CD ennemis"
	L_GUI_COOLDOWN_ENEMY_EVERYWHERE = "Voir les CD ennemis partout"
	L_GUI_COOLDOWN_ENEMY_IN_BG = "Voir les CD ennemis dans les champs de bataille"
	L_GUI_COOLDOWN_ENEMY_IN_ARENA = "Voir les CD ennemis en arиne"
end