
local LAM = LibStub:GetLibrary("LibAddonMenu-2.0")
local menuChoices = { 
	SI_MAIN_MENU_JOURNAL,
	SI_MAIN_MENU_CHARACTER,
	SI_MAIN_MENU_SKILLS,
	SI_MAIN_MENU_CHAMPION,
	SI_MAIN_MENU_MARKET,
	SI_MAIN_MENU_INVENTORY,
	SI_MAIN_MENU_SOCIAL,
	SI_MAIN_MENU_ALLIANCE_WAR,
	SI_MAIN_MENU_MAP,
	SI_MAIN_MENU_CONTACTS,
	SI_MAIN_MENU_GUILDS,
	SI_MAIN_MENU_MAIL,
	SI_MAIN_MENU_NOTIFICATIONS,
	SI_MAIN_MENU_HELP,
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
	
	local optionsTable = { 
		{
			type = "submenu",
		    name = "Menu Setting", -- or string id or function returning a string 
		    controls = {
				{		
					type = "dropdown",
					name = "Slot 1",
					scrollable = true, 
					choices = menuChoices, 
					choicesValues = menuChoicesShowNames,
					
					getFunc = function()  
						return QuickMenu.acctSavedVariables.slots[1]
					end,
					setFunc = function(value) 	
						QuickMenu.acctSavedVariables.slots[1] = value
					end, 
					width = "full", 
				},
				{		
					type = "dropdown",
					name = "Slot 2",
					scrollable = true, 
					choices = menuChoices, 
					choicesValues = menuChoicesShowNames,
					
					getFunc = function()  
						return QuickMenu.acctSavedVariables.slots[2]
					end,
					setFunc = function(value) 	
						QuickMenu.acctSavedVariables.slots[2] = value
					end, 
					width = "full", 
				},
				{		
					type = "dropdown",
					name = "Slot 3",
					scrollable = true, 
					choices = menuChoices, 
					choicesValues = menuChoicesShowNames,
					
					getFunc = function()  
						return QuickMenu.acctSavedVariables.slots[3]
					end,
					setFunc = function(value) 	
						QuickMenu.acctSavedVariables.slots[3] = value
					end, 
					width = "full", 
				},
				{		
					type = "dropdown",
					name = "Slot 4",
					scrollable = true, 
					choices = menuChoices, 
					choicesValues = menuChoicesShowNames,
					
					getFunc = function()  
						return QuickMenu.acctSavedVariables.slots[4]
					end,
					setFunc = function(value) 	
						QuickMenu.acctSavedVariables.slots[4] = value
					end, 
					width = "full", 
				},
				{		
					type = "dropdown",
					name = "Slot 5",
					scrollable = true, 
					choices = menuChoices, 
					choicesValues = menuChoicesShowNames,
					
					getFunc = function()  
						return QuickMenu.acctSavedVariables.slots[5]
					end,
					setFunc = function(value) 	
						QuickMenu.acctSavedVariables.slots[5] = value
					end, 
					width = "full", 
				},
				{		
					type = "dropdown",
					name = "Slot 6",
					scrollable = true, 
					choices = menuChoices, 
					choicesValues = menuChoicesShowNames,
					
					getFunc = function()  
						return QuickMenu.acctSavedVariables.slots[6]
					end,
					setFunc = function(value) 	
						QuickMenu.acctSavedVariables.slots[6] = value
					end, 
					width = "full", 
				},
				{		
					type = "dropdown",
					name = "Slot 7",
					scrollable = true, 
					choices = menuChoices, 
					choicesValues = menuChoicesShowNames,
					
					getFunc = function()  
						return QuickMenu.acctSavedVariables.slots[7]
					end,
					setFunc = function(value) 	
						QuickMenu.acctSavedVariables.slots[7] = value
					end, 
					width = "full", 
				},
				
			},
		},
	}
	LAM:RegisterAddonPanel("QUICKMENU_ADDONMENU", panelData)
	LAM:RegisterOptionControls("QUICKMENU_ADDONMENU", optionsTable) 
end