----------------------------------------------------------------------------------------
--	Localization for esES client(Thanks to Seal for the translation)
----------------------------------------------------------------------------------------
if SettingsDB.client == "esES" then
	-- aTooltip
	L_TOOLTIP_NO_TALENT = "No tienes talentos"
	L_TOOLTIP_LOADING = "Cargando..."
	L_TOOLTIP_ACH_STATUS = "Estado:"
	L_TOOLTIP_ACH_COMPLETE = "Estado: Completado "
	L_TOOLTIP_ACH_INCOMPLETE = "Estado: Incompleto"

	-- aSettings(Mount macro)
	L_ZONE_DALARAN = "Dalaran"
    L_ZONE_UNDERBELLY = "Cloacas"
    L_ZONE_KRASUS = "Zona de vuelo"
    L_ZONE_WINTERGRASP = "Conquista del Invierno"
    L_ZONE_VC = "La Ciudadela Violeta"
	
	-- aSettings(Check Flask)
	L_FLASK_STR = "Frasco del Norte - Fuerza"
	L_FLASK_SPD = "Frasco del Norte - Daño Magico"
	L_FLASK_AP = "Frasco del Norte - Poder de Ataque"
	
	-- oUF_Shestak
	L_UF_GHOST = "Fantasma"
	L_UF_DEAD = "Muerto"
	L_UF_OFFLINE = "Desconectado"
	L_UF_DRAGON = "Dracohalcon"
	L_UF_VIPER = "Vibora"
	L_UF_MANA = "Mana bajo"
	L_UF_TRINKET_READY = "Trinket ready: "  -- Needs review
	L_UF_TRINKET_USED = "Trinket used: "  -- Needs review
	L_UF_WOTF_USED = "WotF used: "  -- Needs review
	
	-- pMap
	L_MAP_CURSOR = "Cursor: "
	L_MAP_BOUNDS = "Fuera de los limites!"

	-- aMiniMap
	L_MINIMAP_CALENDAR = "Calendario"
	
	-- aLoad
	L_ALOAD_RL = "Reload UI"  -- Needs review
	L_ALOAD_TRADE = "Trade"  -- Needs review
	L_ALOAD_SOLO = "Solo"  -- Needs review
	
	-- aSettings(GUI)
	L_GUI_MINIMAP_ICON_LM = "Left Click - Enter to GUI"  -- Needs review
	L_GUI_MINIMAP_ICON_RM = "Right Click - Dropdown menu"  -- Needs review
	L_GUI_MINIMAP_ICON_SD = "Shift + Drag - Move Button"  -- Needs review
	L_GUI_MINIMAP_ICON_SRM = "Shift + Right Click - ReloadUI"  -- Needs review
	L_GUI_MINIMAP_ICON_SLASH = "Slash commands"  -- Needs review
	L_GUI_MINIMAP_ICON_SPEC = "Spec switching"  -- Needs review
	L_GUI_MINIMAP_ICON_CL = "Fix combatlog"  -- Needs review
	L_GUI_MINIMAP_ICON_DBM = "DBM test mode"  -- Needs review
	L_GUI_MINIMAP_ICON_HEAL = "Switch to heal layout"  -- Needs review
	L_GUI_MINIMAP_ICON_DPS = "Switch to dps layout"  -- Needs review

	-- idChat
	L_CHAT_URL = "Copiar direccion"
	L_CHAT_GUILD = "H"
	L_CHAT_PARTY = "G"
	L_CHAT_PARTY_LEADER = "GL"
	L_CHAT_RAID	= "B"
	L_CHAT_RAID_LEADER = "BL"
	L_CHAT_RAID_WARNING	= "BW"
	L_CHAT_BATTLEGROUND	= "CB"
	L_CHAT_BATTLEGROUND_LEADER = "CBL"
	L_CHAT_OFFICER = "O"
	L_CHAT_COME_ONLINE = "has come online."  -- Needs review(The exact text that is written in the chat)
	L_CHAT_GONE_OFFLINE = "has gone offline."  -- Needs review(The exact text that is written in the chat)
	L_CHAT_COME_ONLINE_COLOR = "is now |cff298F00online|r !"  -- Needs review(The exact text that is written in the chat)
	L_CHAT_GONE_OFFLINE_COLOR = "is now |cffff0000offline|r !"  -- Needs review(The exact text that is written in the chat)

	-- BaudErrorFrame
	L_ERRORFRAME_L = "Click para ver errores."
	
	-- cargBags
	L_BAG_FREE = "Espacio: "
	L_BAG_OUT_OFF = " / "
	L_BAG_BANK = "Banco"

	-- aSettings(NeedTheOrb)
	L_LOOT_FROZEN_ORB = "Orbe congelado"
	
	-- aSettings(Grab mail)
	L_MAIL_STOPPED = "Sin espacio, inventario lleno."
	L_MAIL_COMPLETE = "Todo enviado."
	L_MAIL_NEED = "Necesitas un buzon."
	L_MAIL_MESSAGES =  "messages"  -- Needs review
	
	-- Butsu
	L_LOOT_RANDOM = "Jugador aleatorio"
	L_LOOT_SELF = "Despojar automaticamente"
	L_LOOT_UNKNOWN = "Unknown"
	L_LOOT_FISH = "Despojar pescado"
	L_LOOT_MONSTER = ">> Botin de "
	L_LOOT_CHEST = ">> Botin del cofre"
	L_LOOT_ANNOUNCE = "Anunciar a"
	L_LOOT_TO_RAID = "  banda"
	L_LOOT_TO_PARTY = "  grupo"
	L_LOOT_TO_GUILD = "  hermandad"
	L_LOOT_TO_SAY = "  decir"
	L_LOOT_CANNOT = "No puedes rolear"

	-- LitePanels AFK module
	L_PANELS_AFK = "Estas ausente!"
	L_PANELS_AFK_RCLICK = "Boton derecho para ocultar."
	L_PANELS_AFK_LCLICK = "Boton izquierdo para retroceder."

	-- aCooldowns
	L_COOLDOWNS = "CD: "  -- Needs review
	
	-- aSettings
	L_INVITE_ENABLE_T = "Auto Invitar ON: invite"
	L_INVITE_ENABLE = "Auto Invitar ON: "
	L_INVITE_DISABLE = "Auto Invitar OFF"
	
	-- aSettings(Bind key)
	L_BIND_COMBAT = "No puedes asignar teclas en combate."
	L_BIND_SAVED = "La configuración de las teclas ha sido guardada."
	L_BIND_DISCARD = "Se han descartado los cambios en la configuración de las teclas."
	L_BIND_INSTRUCT = "Coloca el cursor encima de cualquier botón para asignar una tecla. Presiona la tecla ESC o el botón derecho del ratón para quitar la asignación actual."
	L_BIND_CLEARED = "All keybindings cleared for"  -- Needs review
	L_BIND_BINDING = "Binding"  -- Needs review
	L_BIND_KEY = "Key"  -- Needs review
	L_BIND_NO_SET = "No bindings set"  -- Needs review
	
	-- aSettings(Raid Planner)
	L_PLANNER_TITLE = "Raid Planner"  -- Needs review
	L_PLANNER_IMP_TALENT = "Improved talent"  -- Needs review
	L_PLANNER_INSPECT = "Inspecting"  -- Needs review
	L_PLANNER_DEATHKNIGHT_1 = "Sangre"
	L_PLANNER_DEATHKNIGHT_2 = "Escarcha"
	L_PLANNER_DEATHKNIGHT_3 = "Profana"
	L_PLANNER_WARRIOR_1 = "Armas"
	L_PLANNER_WARRIOR_2 = "Furia"
	L_PLANNER_WARRIOR_3 = "Protección"
	L_PLANNER_ROGUE_1 = "Asesinato"
	L_PLANNER_ROGUE_2 = "Combate"
	L_PLANNER_ROGUE_3 = "Sutileza"
	L_PLANNER_MAGE_1 = "Arcano"
	L_PLANNER_MAGE_2 = "Fuego"
	L_PLANNER_MAGE_3 = "Escarcha"
	L_PLANNER_PRIEST_1 = "Disciplina"
	L_PLANNER_PRIEST_2 = "Sagrado"
	L_PLANNER_PRIEST_3 = "Sombras"
	L_PLANNER_WARLOCK_1 = "Aflicción"
	L_PLANNER_WARLOCK_2 = "Demonología"
	L_PLANNER_WARLOCK_3 = "Destrucción"
	L_PLANNER_HUNTER_1 = "Dominio de bestias"
	L_PLANNER_HUNTER_2 = "Puntería"
	L_PLANNER_HUNTER_3 = "Supervivencia"
	L_PLANNER_DRUID_1 = "Equilibrio"
	L_PLANNER_DRUID_2 = "Combate feral"
	L_PLANNER_DRUID_3 = "Restauración"
	L_PLANNER_SHAMAN_1 = "Elemental"
	L_PLANNER_SHAMAN_2 = "Mejora"
	L_PLANNER_SHAMAN_3 = "Restauración"
	L_PLANNER_PALADIN_1 = "Sagrado"
	L_PLANNER_PALADIN_2 = "Protección"
	L_PLANNER_PALADIN_3 = "Reprensión"
	
	-- aSettings(bg score)
	L_DATATEXT_ARATHI = "Cuenca de Arathi"
	L_DATATEXT_WARSONG = "Garganta Grito de Guerra"
	L_DATATEXT_EYE = "Cuenca de Arathi"
	L_DATATEXT_ALTERAC = "Valle de Alterac"
	L_DATATEXT_ANCIENTS = "Playa de los Ancestros"
	L_DATATEXT_ISLE = "Isla de la Conquista"
	L_DATATEXT_BASESASSAULTED = "Bases Asaltadas:"
	L_DATATEXT_BASESDEFENDED = "Bases Defendidas:"
	L_DATATEXT_TOWERSASSAULTED = "Torres Asaltadas:"
	L_DATATEXT_TOWERSDEFENDED = "Torres Defendidas:"
	L_DATATEXT_FLAGSCAPTURED = "Banderas Capturadas:"
	L_DATATEXT_FLAGSRETURNED = "Banderas Devueltas:"
	L_DATATEXT_GRAVEYARDSASSAULTED = "Cementerios Asaltados:"
	L_DATATEXT_GRAVEYARDSDEFENDED = "Cementerios Defendidos:"
	L_DATATEXT_DEMOLISHERSDESTROYED = "Catapultas Destruidas:"
	L_DATATEXT_GATESDESTROYED = "Puertas Destruidas:"
	
	-- aSettings(class scripts)
	L_CLASS_HUNTER_UNHAPPY = "Tu mascota está descontenta!"
	L_CLASS_HUNTER_CONTENT = "Tu mascota está contenta!"
	L_CLASS_HUNTER_HAPPY = "Tu mascota está feliz!"
	
	-- aSettings
	L_INFO_ERRORS = "Ningun error aun."
	L_INFO_INVITE = "Invitacion aceptada de: "
	L_INFO_DUEL = "Duelo rechazado de: "
	L_INFO_DISBAND = "Deshaciendo banda..."
	L_INFO_ADDON_SETS1 = "Escribe /addons <solitario/grupo/banda/pvp/comercio/misiones>, para cargar las moficiaciones preinstaladas."
	L_INFO_ADDON_SETS2 = "Puedes añadir, borrar o cambiar la lista de las modificaciones, modificando wtf.lua en la carpeta `scripts`."
	L_INFO_SETTINGS_DBM = "Escribe /settings dbm, para aplicar las preferencias del DBM."
	L_INFO_SETTINGS_MSBT = "Escribe /settings msbt, para aplicar las preferencias del MSBT."
	L_INFO_SETTINGS_SKADA = "Escribe /settings skada, para aplicar las preferencias del Skada."
	L_INFO_SETTINGS_RECOUNT = "Type /settings recount, to apply the settings Recount. Then in Recount options select *Default* profile."  -- Needs review
	L_INFO_SETTINGS_DXE = "Type /settings dxe, to apply the settings DXE. Then in DXE options select *Default* profile."  -- Needs review
	L_INFO_SETTINGS_ALL = "Escribe /settings all, para aplicar todas las modificaciones."
	
	-- aSettings(Popups)
	L_POPUP_INSTALLUI = "Es la primera vez que usas ShestakUI con este personaje. Usted debe volver a cargar la interfaz de usuario para configurarlo."
	L_POPUP_RESETUI = "¿Estás seguro de que desea restablecer ShestakUI?"
	L_POPUP_SWITCH_RAID = "Hay activos 2 estilos para banda, por favor selecciona uno."
	L_POPUP_DISABLEUI = "ShestakUI no funciona con esta resolución, ¿Quieres desactivar ShestakUI? (Pulsa cancelar si quieres probar otra resolución)"
	L_POPUP_SETTINGS_ALL = "Apply settings for all modifications? (DBM/DXE, Skada/Recount and MSBT)"  -- Needs review
	
	-- aSettings(Welcome mesage)
	L_WELCOME_LINE_1 = "Welcome to ShestakUI "  -- Needs review
	L_WELCOME_LINE_2_1 = "Type /cfg to config interface, or visit http://shestak.org"  -- Needs review
	L_WELCOME_LINE_2_2 = "for more informations."  -- Needs review
end