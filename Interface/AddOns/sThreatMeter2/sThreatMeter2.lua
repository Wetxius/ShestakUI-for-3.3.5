local threatguid, threatunit, threatlist, threatbars = "", "target", {}, {};

local function comma_value(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

local function short_value(value)
	local strLen = strlen(value);
	local retString = value;
	if ( strLen > 6 ) then
		retString = string.sub(value, 1, -7)..SECOND_NUMBER_CAP;
	elseif ( strLen > 3 ) then
		retString = string.sub(value, 1, -4)..FIRST_NUMBER_CAP;
	end
	return retString;
end

local function ColorGradient(perc, ...)
	if perc >= 1 then
		local r, g, b = select(select('#', ...) - 2, ...)
		return r, g, b
	elseif perc <= 0 then
		local r, g, b = ...
		return r, g, b
	end

	local num = select('#', ...) / 3

	local segment, relperc = math.modf(perc*(num-1))
	local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)

	return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
end

local function GetThreat(unit, pet)
	if ( UnitName(pet or unit) == UNKNOWN or not UnitIsVisible(pet or unit) ) then
		return;
	end
	
	local tperc, _, tvalue = select(3, UnitDetailedThreatSituation(pet or unit, threatunit));
	local name = pet and UnitName(unit) .. ": " .. UnitName(pet) or UnitName(unit);
	
	for index, value in ipairs(threatlist) do
		if ( value.name == name ) then
			tremove(threatlist, index);
			break;
		end
	end
	if tvalue and tvalue < 0 then
		tvalue = tvalue + 410065408;
	end
	table.insert(threatlist, {
		name = name,
		class = select(2, UnitClass(unit)),
		tperc = tperc or 0,
		tvalue = tvalue or 0,
	});
end

local function AddThreat(unit, pet)
	if ( UnitExists(pet) ) then
		GetThreat(unit);
		GetThreat(unit, pet);
	else
		if ( GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 ) then
			GetThreat(unit);
		end
	end
end

local function SortThreat(a, b)
	return a.tperc > b.tperc;
end

local function OnUpdateBar(self, elpased)
	if ( self.moveTo == self.value ) then
		self:SetScript("OnUpdate", nil);
	else
		if ( self.moveTo > self.value ) then
			self.value = self.value+1;
		elseif ( self.moveTo < self.value ) then
			self.value = self.value-1;
		end
		self:SetValue(self.value);
	end
end

local function UpdateThreatBars()
	for index, value in ipairs(threatbars) do
		value:Hide();
	end
	table.sort(threatlist, SortThreat);
	local bar, class, r, g, b, text;
	for index, value in ipairs(threatlist) do
		if ( index > 7 ) then
			return;
		end
		bar = threatbars[index];
		if ( not bar ) then
			bar = CreateFrame("StatusBar", "sThreatMeterBar"..index, UIParent);
			bar:SetWidth(217);
			bar:SetHeight(12);
			bar:SetStatusBarTexture(SettingsCF["media"].texture);
			bar:SetMinMaxValues(0, 100);
			bar:SetValue(0);
			if ( index == 1 ) then
				bar:SetPoint("TOP", sThreatMeter);
			else
				bar:SetPoint("TOP", threatbars[index-1], "BOTTOM", 0, -7);
			end
			
			bar.background = bar:CreateTexture("$parentBackground", "BACKGROUND");
			bar.background:SetAllPoints();
			bar.background:SetTexture(SettingsCF["media"].texture);
			
			bar.backgdrop = CreateFrame("Frame", nil, bar)
			SettingsDB.CreateTemplate(bar.backgdrop)
			bar.backgdrop:SetFrameStrata("BACKGROUND")
			bar.backgdrop:SetPoint("TOPLEFT", -2, 2)
			bar.backgdrop:SetPoint("BOTTOMRIGHT", 2, -2)
			
			bar.textright = bar:CreateFontString("$parentTextRight", "ARTWORK");
			bar.textright:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].font_style);
			bar.textright:SetJustifyH("RIGHT");
			bar.textright:SetPoint("RIGHT", -1, 1);
			
			bar.textleft = bar:CreateFontString("$parentTextLeft", "ARTWORK");
			bar.textleft:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].font_style);
			bar.textleft:SetJustifyH("LEFT");
			bar.textleft:SetPoint("LEFT", 2, 1);
			bar.textleft:SetPoint("RIGHT", bar.textright, "LEFT", -1, 1);
			
			tinsert(threatbars, bar);
		end
		
		bar:SetValue(tonumber(format("%d", value.tperc)));
		
		class = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[value.class] and CUSTOM_CLASS_COLORS[value.class] or RAID_CLASS_COLORS[value.class];
		if ( value.name == UnitName("player") ) then
			bar:SetStatusBarColor(1, 0, 0, 1);
		else
			bar:SetStatusBarColor(class.r, class.g, class.b, 1);
		end
		bar.textright:SetTextColor(1, 1, 1, 1);
		bar.textleft:SetTextColor(1, 1, 1, 1);
		bar.background:SetVertexColor(class.r, class.g, class.b, 0.25);
		
		r, g, b = ColorGradient(((value.tperc > 100 and 100 or value.tperc)/100), 0, 1, 0, 1, 1, 0, 1, 0, 0);
		text = string.gsub("$value [$perc%]", "$value", comma_value(tonumber(format("%d", value.tvalue/100))));
		text = string.gsub(text, "$shortvalue", short_value(tonumber(format("%d", value.tvalue/100))));
		text = string.gsub(text, "$perc", string.format("|cff%02x%02x%02x%d|r", r*255, g*255, b*255, value.tperc));
		text = string.gsub(text, "$name", value.name);
		bar.textright:SetText(text);
		
		text = string.gsub("$name", "$value", comma_value(tonumber(format("%d", value.tvalue/100))));
		text = string.gsub(text, "$shortvalue", short_value(tonumber(format("%d", value.tvalue/100))));
		text = string.gsub(text, "$perc", string.format("|cff%02x%02x%02x%d|r", r*255, g*255, b*255, value.tperc));
		text = string.gsub(text, "$name", value.name);
		bar.textleft:SetText(text);
		
		bar:Show();
	end
end

local function OnEvent(self, event, ...)
	local unit = ...;
	if ( event == "ADDON_LOADED" and unit == "sThreatMeter2" ) then
		self:SetPoint(unpack(SettingsCF["position"].threat_meter));
		self:SetWidth(217);
		self:SetHeight(12);
		self:UnregisterEvent(event);
	elseif ( event == "UNIT_THREAT_LIST_UPDATE" ) then
		if ( unit and UnitExists(unit) and UnitGUID(unit) == threatguid and UnitCanAttack("player", threatunit) ) then
			if ( GetNumRaidMembers() > 0 ) then
				for i=1, GetNumRaidMembers(), 1 do
					AddThreat("raid"..i, "raid"..i.."pet");
				end
			elseif ( GetNumPartyMembers() > 0 ) then
				AddThreat("player", "pet");
				for i=1, GetNumPartyMembers(), 1 do
					AddThreat("party"..i, "party"..i.."pet");
				end
			else
				AddThreat("player", "pet");
			end
			UpdateThreatBars();
		end
	elseif ( event == "PLAYER_TARGET_CHANGED" ) then
		if ( UnitExists("target") and not UnitIsDead("target") and not UnitIsPlayer("target") ) then
			threatguid = UnitGUID("target");
		else
			threatguid = "";
		end
		wipe(threatlist);
		UpdateThreatBars();
	elseif ( event == "PLAYER_REGEN_ENABLED" ) then
		wipe(threatlist);
		UpdateThreatBars();
	end
end

local frame = CreateFrame("Frame", "sThreatMeter", UIParent);
frame:SetClampedToScreen(true);
frame:RegisterEvent("UNIT_THREAT_LIST_UPDATE");
frame:RegisterEvent("PLAYER_TARGET_CHANGED");
frame:RegisterEvent("PLAYER_REGEN_ENABLED");
frame:RegisterEvent("ADDON_LOADED");
frame:SetScript("OnEvent", OnEvent);

--[[
table.insert(threatlist, { name = "Гребешок", class = "WARRIOR", tperc = 100, tvalue = 100*1000*1000 });
table.insert(threatlist, { name = "Лапушок", class = "ROGUE", tperc = 90, tvalue = 90*1000*1000 });
table.insert(threatlist, { name = "Ремешок", class = "HUNTER", tperc = 80, tvalue = 80*1000*1000 });
table.insert(threatlist, { name = "Кулешок", class = "PRIEST", tperc = 70, tvalue = 70*1000*1000 });
table.insert(threatlist, { name = "Черешок", class = "DRUID", tperc = 60, tvalue = 60*1000*1000 });
table.insert(threatlist, { name = "Обушок", class = "WARLOCK", tperc = 50, tvalue = 50*1000*1000 });
table.insert(threatlist, { name = "Вершок", class = "MAGE", tperc = 40, tvalue = 40*1000*1000 });
UpdateThreatBars();]]