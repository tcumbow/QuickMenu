
local LAM = LibStub:GetLibrary("LibAddonMenu-2.0")
local menuChoices = { 
	SI_JOURNAL_MENU_QUESTS,
	SI_JOURNAL_MENU_CADWELLS_ALMANAC,
	SI_JOURNAL_MENU_LORE_LIBRARY,
	SI_JOURNAL_MENU_ACHIEVEMENTS,
	SI_JOURNAL_MENU_LEADERBOARDS,
	SI_MAIN_MENU_CHARACTER,
	SI_MAIN_MENU_SKILLS,
	SI_MAIN_MENU_CHAMPION,
	SI_MAIN_MENU_MARKET,
	SI_MAIN_MENU_INVENTORY, 
	SI_MAIN_MENU_ALLIANCE_WAR,
	SI_MAIN_MENU_MAP,
	SI_WINDOW_TITLE_FRIENDS_LIST,
	SI_IGNORE_LIST_PANEL_TITLE,
	SI_MAIN_MENU_GUILDS,
	SI_MAIN_MENU_MAIL,
	SI_MAIN_MENU_NOTIFICATIONS,
	SI_MAIN_MENU_GROUP,
	SI_MAIN_MENU_COLLECTIONS,
	SI_MAIN_MENU_ACTIVITY_FINDER,
	SI_MAIN_MENU_CROWN_CRATES,
}

local menuChoicesShowNames = {}

function QuickMenu.AddonMenuInit()  
	menuChoicesShowNames = {}
	for k, v in ipairs(menuChoices) do
		table.insert(menuChoicesShowNames, GetString(v))
	end 
	
	local panelData =  {
		type = "panel",
		name = QuickMenu.settingName,
		displayName = QuickMenu.settingDisplayName,
		author = QuickMenu.author,
		version = QuickMenu.version,
		registerForRefresh = true,
		registerForDefaults = true,
		resetFunc = function() 
			QuickMenu.ResetToDefaults() 
		end,
	}
	local slots = {
		[1] = {
			type = "dropdown",
			name = "Slot 1",
			choices = { "Cancel" },
			choicesValues = { 1 },
			getFunc = function() return 1 end,
			setFunc = function(value) end,
			disabled = true,
		}
	}
	--create slots dynamically 
	
	for i=1, #menuChoices do
		local slotdata = {}
		slotdata.type = "dropdown"
		slotdata.name = string.format("Slot %d", i+1)
		slotdata.scrollable = true
		slotdata.choices = menuChoicesShowNames
		slotdata.choicesValues = menuChoices
		slotdata.getFunc = function()
			return QuickMenu.acctSavedVariables.slots[i]
		end
		slotdata.setFunc = function(value)
			QuickMenu.acctSavedVariables.slots[i] = value	
		end
		slotdata.width = "full" 
		slotdata.disabled = function()
			return i > QuickMenu.acctSavedVariables.slotsCount
		end
		table.insert(slots, slotdata)		
	end
	local optionsTable = { 
		{
			type = 'description',
			text = "Slot 1 is Cancel, which is placed in 6 o'clock direction if you use more than 2 slots. Other slots are placed counter clockwise.",
		},	
		{
			type = "submenu",
			name = "Presets",
			controls = {
				{			
					type = "button",
					name = "8 Entries",
					func = function() 
						QuickMenu.acctSavedVariables.slots = QuickMenu.presets8.slots
						QuickMenu.acctSavedVariables.slotsCount = QuickMenu.presets8.slotsCount
					end,
					width = "full",
				},
				{			
					type = "button",
					name = "12 Entries",
					func = function() 
						QuickMenu.acctSavedVariables.slots = QuickMenu.presets12.slots
						QuickMenu.acctSavedVariables.slotsCount = QuickMenu.presets12.slotsCount
					end,
					width = "full",
				},
				{			
					type = "button",
					name = "All Entries",
					func = function() 
						QuickMenu.acctSavedVariables.slots = menuChoices
						QuickMenu.acctSavedVariables.slotsCount = #menuChoices
					end,
					width = "full",
				},
			},
		},
		{
			type = 'slider',
			name = "Menu Items Count",
			min = 2,
			max = #menuChoices + 1,
			getFunc = function()
				return QuickMenu.acctSavedVariables.slotsCount + 1
			end,
			setFunc = function(v)
				QuickMenu.acctSavedVariables.slotsCount = v - 1
			end,
		},
		{
			type = "submenu",
			name = "Slot Setting",
			controls = slots,
		},
			
	}
	
	LAM:RegisterAddonPanel("QUICKMENU_ADDONMENU", panelData)
	LAM:RegisterOptionControls("QUICKMENU_ADDONMENU", optionsTable) 
end