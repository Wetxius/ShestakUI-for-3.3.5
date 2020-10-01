﻿----------------------------------------------------------------------------------------
--	Localization for ruRU client
----------------------------------------------------------------------------------------
if GetLocale() == "ruRU" then
	L_GUI_BUTTON_RESET = "Полный сброс настроек"
	-- General options(aSettings)
	L_GUI_GENERAL_UIICON = "Иконка интерфейса у мини-карты"
	L_GUI_GENERAL_AUTOSCALE = "Автоматически масштабировать интерфейс"
	L_GUI_GENERAL_MULTISAMPLE = "1-разр. сглаживание (ровные края шириной 1 пиксель)"
	L_GUI_GENERAL_UISCALE = "Масштаб интерфейса (если автомасштабирование отключено)"
	L_GUI_GENERAL_WELCOME_MESSAGE = "Приветственное сообщение в чате"

	-- Miscellaneous options(aSettings)
	L_GUI_MISC_AUTOQUEST = "Автопринятие заданий"
	L_GUI_MISC_AUTOGREED = "Автоматически нажимать *не откажусь* для зеленых предметов на 80 уровне"
	L_GUI_MISC_AUTODE = "Автоматическое подтверждение распыления предмета"
	L_GUI_MISC_AUTODUEL = "Автоотмена дуэлей от игроков"
	L_GUI_MISC_AUTOACCEPT = "Автопринятие приглашений от друзей и гильдии"
	L_GUI_MISC_AUTORESSURECT = "Автоматическое воскрешение на Полях Сражений"
	L_GUI_MISC_MARKING = "Меню с метками при нажатие *shift*"
	L_GUI_MISC_INVKEYWORD = "Ключевое слово для автоматического приглашения (/ainv)"
	L_GUI_MISC_RAID_PLANNER = "Включить планировщик рейда (/com)"
	L_GUI_MISC_SPIN_CAMERA = "Прокручивать камеру во время афк"
	
	-- Tooltip options(aTooltip)
	L_GUI_TOOLTIP = "Подсказки"
	L_GUI_TOOLTIP_SHIFT = "Показывать подсказку при зажатой кнопке *shift*"
	L_GUI_TOOLTIP_CURSOR = "Подсказка над указателем мыши"
	L_GUI_TOOLTIP_ICON = "Иконка предмета в подсказке"
	L_GUI_TOOLTIP_HEALTH = "Цифровое значение здоровья в подсказке"
	L_GUI_TOOLTIP_HIDE = "Прятать подсказку для кнопок панели действий"
	L_GUI_TOOLTIP_TALENTS = "Дерево талантов цели в подсказке"
	L_GUI_TOOLTIP_ACHIEVEMENTS = "Сравнение достижений в подсказке с вашими"
	L_GUI_TOOLTIP_TARGET = "Цель цели в подсказке"
	L_GUI_TOOLTIP_TITLE = "Звание или имя сервера в подсказке"
	L_GUI_TOOLTIP_RANK = "Ранг в гильдии цели в подсказке"
	L_GUI_TOOLTIP_ARENA_EXPERIENCE = "PvP достижения цели в подсказке"
	
	-- Chat options(idChat)
	L_GUI_CHAT_FONT_SIZE = "Размер шрифта в чате"
	L_GUI_CHAT_FONT_STYLE = "Обводка шрифта в чате"
	L_GUI_CHAT_TAB_FONT_SIZE = "Размер шрифта закладок чата"
	L_GUI_CHAT_TAB_FONT_STYLE = "Обводка шрифта закладок"
	L_GUI_CHAT_SPAM = "Удаление спама в чате(*Игрок1* выиграл дуэль у *Игрока2*)"
	L_GUI_CHAT_WIDTH = "Ширина чата"
	L_GUI_CHAT_HEIGHT = "Высота чата"
	L_GUI_CHAT_BAR = "Панель кнопок каналов"
	L_GUI_CHAT_TIMESTAMP = "Цвет времени чата"
	L_GUI_CHAT_WHISP = "Звуковое оповещение во время шепота"
	
	-- Bag options(cargBags)
	L_GUI_BAGS = "Сумки"
	L_GUI_BAGS_KEY = "Горизонтальное кол-во ячеек ключницы"
	L_GUI_BAGS_BANK = "Горизонтальное кол-во ячеек банка"
	L_GUI_BAGS_BAG = "Горизонтальное кол-во ячеек сумки"
	L_GUI_BAGS_HIDE_EMPTY = "Скрыть пустые ячейки"
	
	-- Minimap options(aMiniMap)
	L_GUI_MINIMAP_ICON = "Иконка слежения объекта"
	L_GUI_MINIMAP_SIZE = "Размер мини-карты"
	L_GUI_MINIMAP_HIDE_COMBAT = "Скрыть мини-карту в бою"
	
	-- Map options(pMap)
	L_GUI_MAP_ICON = "Иконки рейда по цвету класса"
	L_GUI_MAP_SCALE = "Масштаб карты"
	L_GUI_MAP_BG_STYLIZATION = "Стилизация карты Полей Сражения"
	
	-- Loot options(Butsu)
	L_GUI_LOOT_FONT_SIZE = "Размер шрифта"
	L_GUI_LOOT_ICON_SIZE = "Размер иконки"
	L_GUI_LOOT_WIDTH = "Ширина окна добычи"
	
	-- Nameplate options(caelNamePlates)
	L_GUI_NAMEPLATE_COMBAT = "Автоматически показывать индикаторы во время боя"
	L_GUI_NAMEPLATE_HEALTH = "Цифровое значение здоровья"
	L_GUI_NAMEPLATE_CASTBAR = "Индикатор заклинания"
	L_GUI_NAMEPLATE_FONT_SIZE = "Размер шрифта"
	L_GUI_NAMEPLATE_HEIGHT = "Высота индикатора"
	L_GUI_NAMEPLATE_WIDTH = "Ширина индикатора"
	L_GUI_NAMEPLATE_CASTBAR_NAME = "Имя заклинания"
	L_GUI_NAMEPLATE_THREAT = "Для танка хорошая угроза = зеленый, плохая угроза = красный"
	L_GUI_NAMEPLATE_CLASS_ICON = "Иконки классов"

	-- Error options(aSettings)
	L_GUI_ERROR = "Ошибки боя"
	L_GUI_ERROR_HIDE = "Спрятать все ошибки"
	L_GUI_ERROR_BLACK = "Спрятать ошибки из *черного* списка"
	L_GUI_ERROR_WHITE = "Показывать ошибки из *белого* списка"
	L_GUI_ERROR_HIDE_COMBAT = "Спрятать ошибки во время боя(Необходимо выбрать *список*)"
	
	-- ActionBar options(rActionBarStyler)
	L_GUI_ACTIONBAR_HOTKEY = "Отображать назначения клавиш"
	L_GUI_ACTIONBAR_GRID = "Отображать пустые кнопки панелей команд"
	L_GUI_ACTIONBAR_ALWAYS = "Отображать все панели команд"
	L_GUI_ACTIONBAR_BUTTON_SIZE = "Размер кнопок панелей команд"
	L_GUI_ACTIONBAR_RIGHTBARS_THREE = "Отображать три панели команд справа"
	L_GUI_ACTIONBAR_RIGHTBARS_MOUSEOVER = "Правые панели команд по наведению курсора"
	L_GUI_ACTIONBAR_PETBAR_MOUSEOVER = "Горизонтальная панель питомца по наведению курсора"
	L_GUI_ACTIONBAR_PETBAR_HIDE = "Скрыть панель питомца"
	L_GUI_ACTIONBAR_PETBAR_HORIZONTAL = "Переключиться на горизонтальную панель питомца"
	L_GUI_ACTIONBAR_SHAPESHIFT_MOUSEOVER = "Панель стоек и тотемов по наведению курсора"
	L_GUI_ACTIONBAR_SHAPESHIFT_HIDE = "Скрыть панель стоек"
	L_GUI_ACTIONBAR_MICROMENU_MOUSEOVER = "Микро-меню по наведению курсора"
	L_GUI_ACTIONBAR_MICROMENU_HIDE = "Скрыть микро-меню"
	L_GUI_ACTIONBAR_BAGS_MOUSEOVER = "Сумки по наведению курсора"
	L_GUI_ACTIONBAR_BAGS_HIDE = "Скрыть сумки"
	
	-- Unit frame options(oUF_Shestak)
	L_GUI_UF_FONT_SIZE = "Размер шрифта"
	L_GUI_UF_AGGRO_BORDER = "Включить отображение угрозы на рамках группы/рейда"
	L_GUI_UF_OWN_COLOR = "Установить свой цвет для полос рамок"
	L_GUI_UF_ENEMY_HEALTH_COLOR = "Окрашивать полосу здоровья врага по враждебности"
	L_GUI_UF_TOTAL_VALUE = "Отображать общее здоровье/энергию"
	L_GUI_UF_DEFICIT_HEALTH = "Значение здоровя по дефициту для рамок группы/рейда"
	L_GUI_UF_COLOR_VALUE = "Цветное значение здоровья/энергии"
	L_GUI_UF_UNIT_CASTBAR = "Индикатор заклинания"
	L_GUI_UF_CASTBAR_ICON = "Иконка индикатора заклинания"
	L_GUI_UF_CASTBAR_LATENCY = "Задержка заклинания на индикаторе"
	L_GUI_UF_SHOW_BOSS = "Отображать рамки боссов"
	L_GUI_UF_SHOW_ARENA = "Отображать рамки арены"
	L_GUI_UF_ARENA_RIGHT = "Рамки арены справа"
	L_GUI_UF_SHOW_RAID = "Отображать рамки рейда"
	L_GUI_UF_VERTICAL_HEALTH = "Вертикальное направление полосы здоровья"
	L_GUI_UF_ALPHA_HEALTH = "Прозрачность полосы здоровья если 100%"
	L_GUI_UF_SHOW_RANGE = "Прозрачность рамок группы/рейда вне зоны досягаемости"
	L_GUI_UF_RANGE_ALPHA = "Значение для прозрачности рамок группы/рейда вне зоны досягаемости"
	L_GUI_UF_SOLO_MODE = "Отображать рамку игрока всегда"
	L_GUI_UF_PLAYER_PARTY = "Отображать рамку игрока в группе"
	L_GUI_UF_SHOW_TANK = "Отображать рамки танков рейда"
	L_GUI_UF_RAID_GROUP = "Количество групп в рейде(Только для *Heal* раскладки)"
	L_GUI_UF_AURA_SHOW_SPIRAL = "Спираль перезарядки на аурах"
	L_GUI_UF_AURA_SHOW_TIMER = "Отображать таймер перезарядки аур"
	L_GUI_UF_AURA_PLAYER_AURAS = "Ауры игрока"
	L_GUI_UF_AURA_TARGET_AURAS = "Ауры цели"
	L_GUI_UF_AURA_FOCUS_DEBUFFS = "Отрицательные эффекты фокуса"
	L_GUI_UF_AURA_PET_DEBUFFS = "Отрицательные эффекты питомца"
	L_GUI_UF_AURA_TOT_DEBUFFS = "Отрицательные эффекты цели цели"
	L_GUI_UF_AURA_PLAYER_AURA_ONLY = "Только ваши отрицательные эффекты на цели"
	L_GUI_UF_AURA_DEBUFF_COLOR_TYPE = "Цвет бордюра отрицательных эффектов по их типу"
	L_GUI_UF_ICONS_PVP = "Отображать PvP статус на рамках игрока и цели по наведению курсора"
	L_GUI_UF_ICONS_LEADER = "Отображать иконки лидера, помощника и ответственного за добычу"
	L_GUI_UF_ICONS_COMBAT = "Отображать иконку боя на рамке игрока"
	L_GUI_UF_ICONS_RESTING = "Отображать иконку отдыха на рамке игрока"
	L_GUI_UF_ICONS_LFD_ROLE = "Отображать иконку роли в подземелье на рамках группы"
	L_GUI_UF_ICONS_RAID_MARK = "Отображать иконки меток на рамках группы"
	L_GUI_UF_ICONS_COMBO_POINT = "Включить индикатор серии приемов"
	L_GUI_UF_ICONS_READY_CHECK = "Отображать иконки готовности на рамках группы и рейда"
	L_GUI_UF_PORTRAIT_ENABLE = "Отображать портреты игрока и цели"
	L_GUI_UF_PORTRAIT_CLASSCOLOR_BORDER = "Окрашивать бордюр портретов по цвету класса"
	L_GUI_UF_PORTRAIT_HEIGHT = "Высота портретов"
	L_GUI_UF_PORTRAIT_WIDTH = "Ширина портретов"
	L_GUI_UF_PLUGINS_GCD = "Отображать полосу глобальной перезарядки на рамке игрока"
	L_GUI_UF_PLUGINS_SWING = "Отображать индикатор автоматической атаки"
	L_GUI_UF_PLUGINS_RUNE_BAR = "Включить индикатор рун"
	L_GUI_UF_PLUGINS_TOTEM_BAR = "Включить индикатор тотемов"
	L_GUI_UF_PLUGINS_TOTEM_BAR_NAME = "Отображать имена тотемов на индикаторе тотемов"
	L_GUI_UF_PLUGINS_REPUTATION_BAR = "Включить индикатор репутации"
	L_GUI_UF_PLUGINS_EXPERIENCE_BAR = "Включить индикатор опыта"
	L_GUI_UF_PLUGINS_SMOOTH_BAR = "Плавное изменение полос"
	L_GUI_UF_PLUGINS_COMBAT_FEEDBACK = "Текст боя на рамках игрока и цели"
	L_GUI_UF_PLUGINS_DEBUFFHIGHLIGHT_ICON = "Иконка + текстура снимаемых отрицательных эффектов"
	L_GUI_UF_PLUGINS_AURA_WATCH = "Отображать отрицательные эффекты на рамках группы/рейда"
	L_GUI_UF_PLUGINS_HEALCOMM = "Отображать поступающее лечение на рамках группы/рейда"
	L_GUI_UF_PLUGINS_HEALCOMM_BAR = "Полоса поступающего лечения на рамках группы/рейда"
	L_GUI_UF_PLUGINS_HEALCOMM_OVER = "Отображать избыточное лечение в виде текстуры"
	L_GUI_UF_PLUGINS_HEALCOMM_TEXT = "Текстовое значение поступающего лечения на рамках группы/рейда"
	L_GUI_UF_PLUGINS_HEALCOMM_OTHERS = "Скрыть ваше поступающее лечение на рамках группы/рейда"
	
	-- Panel options(LitePanels/LiteStats)
	L_GUI_TOP_PANEL = "Верхняя панель"
	L_GUI_TOP_PANEL_MOUSE = "Панель по наведению курсора"
	L_GUI_TOP_PANEL_WIDTH = "Высота панели"
	L_GUI_TOP_PANEL_HEIGHT = "Ширина панели"
	L_GUI_TOP_PANEL_FONT_SYZE = "Размер шрифта статистики"
	L_GUI_TOP_PANEL_BG_SCORE = "Статистика Полей Сражения"
	
	-- Buffs reminder options(aSettings)
	L_GUI_REMINDER = "Напоминания"
	L_GUI_REMINDER_SOLO_ENABLE = "Включить предупреждение об отсутствие аур игрока"
	L_GUI_REMINDER_SOLO_SOUND = "Добавить звуковое предупреждение для отсутствия аур игрока"
	L_GUI_REMINDER_SOLO_SIZE = "Размер иконки отсутствующей ауры игрока"
	L_GUI_REMINDER_RAID_ENABLE = "Включить предупреждение об отсутствие рейдовых аур"
	L_GUI_REMINDER_RAID_ALWAYS = "Всегда отображать отсутствующие рейдовые ауры"
	L_GUI_REMINDER_RAID_SIZE = "Размер иконок отсутствующих рейдовых аур"
	L_GUI_REMINDER_RAID_ALPHA = "Прозрачность иконок отсутствующих рейдовых аур"
	
	-- Raid/Enemy cooldown options(aCooldowns)
	L_GUI_COOLDOWN = "Перезарядки"
	L_GUI_COOLDOWN_RAID_ENABLE = "Включить рейдовые перезарядки"
	L_GUI_COOLDOWN_RAID_FONT = "Размер шрифта рейдовых перезарядок"
	L_GUI_COOLDOWN_RAID_HEIGHT = "Высота индикаторов рейдовых перезарядок"
	L_GUI_COOLDOWN_RAID_WIDTH = "Ширина индикаторов рейдовых перезарядок"
	L_GUI_COOLDOWN_RAID_SORT = "Выровнять индикаторы рейдовых перезарядок по верху"
	L_GUI_COOLDOWN_RAID_ICONS = "Отображать иконки рейдовых перезарядок"
	L_GUI_COOLDOWN_RAID_IN_RAID = "Отображать рейдовые перезарядки в raid zone"
	L_GUI_COOLDOWN_RAID_IN_PARTY = "Отображать рейдовые перезарядки в party zone"
	L_GUI_COOLDOWN_RAID_IN_ARENA = "Отображать рейдовые перезарядки на арене"
	L_GUI_COOLDOWN_ENEMY = "Включить вражеские перезарядки"
	L_GUI_COOLDOWN_ENEMY_SIZE = "Размер иконок вражеских перезарядок"
	L_GUI_COOLDOWN_ENEMY_EVERYWHERE = "Отображать вражеские перезарядки везде"
	L_GUI_COOLDOWN_ENEMY_IN_BG = "Отображать вражеские перезарядки на полях сражений"
	L_GUI_COOLDOWN_ENEMY_IN_ARENA = "Отображать вражеские перезарядки на арене"
end