------------------
--LOAD LIBRARIES--
------------------

--load LibAddonsMenu-2.0
local LAM2 = LibStub:GetLibrary("LibAddonMenu-2.0");

----------------------
--INITIATE VARIABLES--
----------------------

ZO_CreateStringId("SI_BINDING_NAME_QUICK_MENU", "Quick Menu") 

local function triggerAddonLoaded(eventCode, addonName)
  if  (addonName == QuickMenu.name) then
    EVENT_MANAGER:UnregisterForEvent(QuickMenu.name, EVENT_ADD_ON_LOADED);
    QuickMenu.acctSavedVariables = ZO_SavedVars:NewAccountWide('QuickMenuSavedVars', 1.0, nil, QuickMenu.presets12)
	QuickMenu.AddonMenuInit()
  end
end
 
function QuickMenu.ResetToDefaults()
	QuickMenu.acctSavedVariables.slots = QuickMenu.presets12.slots
	QuickMenu.acctSavedVariables.slotsCount = QuickMenu.presets12.slotsCount
end

function QuickMenu:CreateGamepadRadialMenu()
    self.gamepadMenu = ZO_RadialMenu:New(QuickMenu_Gamepad, "ZO_RadialMenuHUDEntryTemplate_Gamepad", "DefaultRadialMenuAnimation", "DefaultRadialMenuEntryAnimation", "RadialMenu")
    self.gamepadMenu:SetOnClearCallback(function() self:StopInteraction() end)
end 

function QuickMenu:CreateKeyboardRadialMenu()
    self.keyboardMenu = ZO_RadialMenu:New(QuickMenu_Keyboard, "ZO_PlayerToPlayerMenuEntryTemplate_Keyboard", "DefaultRadialMenuAnimation", "DefaultRadialMenuEntryAnimation", "RadialMenu")
    self.keyboardMenu:SetOnClearCallback(function() self:StopInteraction() end)
end

function QuickMenu:GetRadialMenu()
    if IsInGamepadPreferredMode() then
        if not self.gamepadMenu then
            self:CreateGamepadRadialMenu()
        end
        return self.gamepadMenu
    else
        if not self.keyboardMenu then
            self:CreateKeyboardRadialMenu()
        end
        return self.keyboardMenu
    end
end



local KEYBOARD_INTERACT_ICONS =
{
    [SI_JOURNAL_MENU_QUESTS] =
    {
        scenegroup = "journalSceneGroup",
		descriptor = "questJournal",
		enabledNormal = "EsoUI/Art/Journal/journal_tabIcon_quest_up.dds", 
		enabledSelected = "EsoUI/Art/Journal/journal_tabIcon_quest_up.dds",
    },  
	[SI_JOURNAL_MENU_CADWELLS_ALMANAC] =
    {
        scenegroup = "journalSceneGroup",
		descriptor = "cadwellsAlmanac",
		enabledNormal = "EsoUI/Art/Journal/journal_tabIcon_cadwell_up.dds", 
		enabledSelected = "EsoUI/Art/Journal/journal_tabIcon_cadwell_up.dds",
	},
	[SI_JOURNAL_MENU_LORE_LIBRARY] =
    {
        scenegroup = "journalSceneGroup",
		descriptor = "loreLibrary",
        enabledNormal = "EsoUI/Art/Journal/journal_tabIcon_loreLibrary_up.dds",
        enabledSelected = "EsoUI/Art/Journal/journal_tabIcon_loreLibrary_up.dds", 
    }, 
	[SI_JOURNAL_MENU_ACHIEVEMENTS] =
    {
        scenegroup = "journalSceneGroup",
		descriptor = "achievements",
        enabledNormal = "EsoUI/Art/Journal/journal_tabIcon_achievements_up.dds",
        enabledSelected = "EsoUI/Art/Journal/journal_tabIcon_achievements_up.dds", 
    }, 
	[SI_JOURNAL_MENU_LEADERBOARDS] =
    {
        scenegroup = "journalSceneGroup",
		descriptor = "leaderboards",
        enabledNormal = "EsoUI/Art/Journal/journal_tabIcon_leaderboard_up.dds",
        enabledSelected = "EsoUI/Art/Journal/journal_tabIcon_leaderboard_up.dds", 
    }, 
	[SI_MAIN_MENU_CHARACTER] =
    {
        scene = "stats",
        enabledNormal = "EsoUI/Art/MainMenu/menuBar_character_up.dds",
        enabledSelected = "EsoUI/Art/MainMenu/menuBar_character_up.dds", 
	}, 
	[SI_MAIN_MENU_SKILLS] =
    {
        scene = "skills",
        enabledNormal = "EsoUI/Art/MainMenu/menuBar_skills_up.dds",
        enabledSelected = "EsoUI/Art/MainMenu/menuBar_skills_up.dds", 
    }, 
	[SI_MAIN_MENU_CHAMPION] =
    {
        scene = "championPerks",
        enabledNormal = "EsoUI/Art/MainMenu/menuBar_champion_up.dds",
        enabledSelected = "EsoUI/Art/MainMenu/menuBar_champion_up.dds", 
    }, 
	[SI_MAIN_MENU_MARKET] =
    {
        scene = "market",
        enabledNormal = "EsoUI/Art/MainMenu/menuBar_market_up.dds",
        enabledSelected = "EsoUI/Art/MainMenu/menuBar_market_up.dds", 
    }, 
	[SI_MAIN_MENU_INVENTORY] =
    {
        scene = "inventory",
        enabledNormal = "EsoUI/Art/MainMenu/menuBar_inventory_up.dds",
        enabledSelected = "EsoUI/Art/MainMenu/menuBar_inventory_up.dds", 
    }, 
	[SI_MAIN_MENU_ALLIANCE_WAR] =
    {
        scenegroup = "allianceWarSceneGroup",
		descriptor = "campaignOverview",
        enabledNormal = "EsoUI/Art/MainMenu/menuBar_ava_up.dds",
        enabledSelected = "EsoUI/Art/MainMenu/menuBar_ava_up.dds", 
    }, 
	[SI_MAIN_MENU_MAP] =
    {
        scene = "worldMap",
        enabledNormal = "EsoUI/Art/MainMenu/menuBar_map_up.dds",
        enabledSelected = "EsoUI/Art/MainMenu/menuBar_map_up.dds", 
    }, 
	[SI_WINDOW_TITLE_FRIENDS_LIST] =
    {
        scenegroup = "contactsSceneGroup",
		descriptor = "friendsList",
        enabledNormal = "EsoUI/Art/Contacts/tabIcon_friends_up.dds",
        enabledSelected = "EsoUI/Art/Contacts/tabIcon_friends_up.dds", 
    }, 
	[SI_IGNORE_LIST_PANEL_TITLE] =
    {
        scenegroup = "contactsSceneGroup",
		descriptor = "ignoreList",
        enabledNormal = "EsoUI/Art/Contacts/tabIcon_ignored_up.dds",
        enabledSelected = "EsoUI/Art/Contacts/tabIcon_ignored_up.dds", 
    }, 
	[SI_MAIN_MENU_GUILDS] =
    {
        scenegroup = "guildsSceneGroup",
		descriptor = "guildHome",
        enabledNormal = "EsoUI/Art/MainMenu/menuBar_guilds_up.dds",
        enabledSelected = "EsoUI/Art/MainMenu/menuBar_guilds_up.dds", 
    }, 
	[SI_MAIN_MENU_MAIL] =
    {
        scene = "mailInbox",
        enabledNormal = "EsoUI/Art/MainMenu/menuBar_mail_up.dds",
        enabledSelected = "EsoUI/Art/MainMenu/menuBar_mail_up.dds", 
    }, 
	[SI_MAIN_MENU_NOTIFICATIONS] =
    {
        scene = "notifications",
        enabledNormal = "EsoUI/Art/MainMenu/menuBar_notifications_up.dds",
        enabledSelected = "EsoUI/Art/MainMenu/menuBar_notifications_up.dds", 
    }, 
	[SI_MAIN_MENU_GROUP] =
    {
        scene = "groupMenuKeyboard",
        enabledNormal = "EsoUI/Art/MainMenu/menuBar_group_up.dds",
        enabledSelected = "EsoUI/Art/MainMenu/menuBar_group_up.dds", 
    }, 
	[SI_MAIN_MENU_COLLECTIONS] =
    {
        scene = "collectionsBook",
        enabledNormal = "EsoUI/Art/MainMenu/menuBar_collections_up.dds",
        enabledSelected = "EsoUI/Art/MainMenu/menuBar_collections_up.dds", 
    }, 
	[SI_MAIN_MENU_ACTIVITY_FINDER] =
    {
        scene = "groupMenuKeyboard",
        enabledNormal = "EsoUI/Art/MainMenu/menuBar_group_up.dds",
        enabledSelected = "EsoUI/Art/MainMenu/menuBar_group_up.dds", 
    }, 
	[SI_MAIN_MENU_CROWN_CRATES] =
    {
        scene = "crownCrateKeyboard",
        enabledNormal = "EsoUI/Art/MainMenu/menuBar_crownCrates_up.dds",
        enabledSelected = "EsoUI/Art/MainMenu/menuBar_crownCrates_up.dds", 
    },  
	[SI_RADIAL_MENU_CANCEL_BUTTON] =
    {
        enabledNormal = "EsoUI/Art/HUD/radialIcon_cancel_up.dds",
        enabledSelected = "EsoUI/Art/HUD/radialIcon_cancel_up.dds",
    }, 
	[SI_QUICKSLOTS_EMPTY] =
    {
        enabledNormal = "EsoUI/Art/Quickslots/quickslot_emptySlot.dds",
        enabledSelected = "EsoUI/Art/Quickslots/quickslot_emptySlot.dds", 
    }, 
}


local GAMEPAD_INTERACT_ICONS =
{
    [SI_JOURNAL_MENU_QUESTS] =
    {
        scene = "gamepad_quest_journal",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_quests.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_quests.dds", 
    },
	[SI_JOURNAL_MENU_CADWELLS_ALMANAC] =
    {
        scene = "cadwellGamepad",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_cadwell.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_cadwell.dds", 
    }, 
	[SI_JOURNAL_MENU_LORE_LIBRARY] =
    {
        scene = "loreLibraryGamepad",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_loreLibrary.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_loreLibrary.dds", 
    }, 
	[SI_JOURNAL_MENU_ACHIEVEMENTS] =
    {
        scene = "achievementsGamepad",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_achievements.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_achievements.dds", 
    }, 
	[SI_JOURNAL_MENU_LEADERBOARDS] =
    {
        scene = "gamepad_leaderboards",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_leaderBoards.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_leaderBoards.dds", 
    }, 
	
	[SI_MAIN_MENU_CHARACTER] =
    {
        scene = "gamepad_stats_root",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_character.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_character.dds", 
    }, 
	[SI_MAIN_MENU_SKILLS] =
    {
        scene = "gamepad_skills_root",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_skills.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_skills.dds", 
		disabledNormal = "esoui/art/mainmenu/menubar_skills_disabled.dds",
		disabledSelected = "esoui/art/mainmenu/menubar_skills_disabled.dds",
    }, 
	[SI_MAIN_MENU_CHAMPION] =
    {
        scene = "gamepad_championPerks_root",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_champion.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_champion.dds", 
    }, 
	[SI_MAIN_MENU_MARKET] =
    {
        scene = "gamepad_market_pre_scene",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_PlayerMenu_icon_store.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_PlayerMenu_icon_store.dds", 
    }, 
	[SI_MAIN_MENU_INVENTORY] =
    {
        scene = "gamepad_inventory_root",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_inventory.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_inventory.dds", 
    }, 
	[SI_MAIN_MENU_ALLIANCE_WAR] =
    {
        scene = "gamepad_campaign_root",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_allianceWar.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_allianceWar.dds", 
    }, 
	[SI_MAIN_MENU_MAP] =
    {
        scene = "gamepad_worldMap",
        enabledNormal = "EsoUI/Art/MainMenu/menuBar_map_up.dds",
        enabledSelected = "EsoUI/Art/MainMenu/menuBar_map_up.dds", 
    }, 
	[SI_WINDOW_TITLE_FRIENDS_LIST] =
    {
        scene = "gamepad_friends",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_contacts.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_contacts.dds", 
    }, 
	[SI_IGNORE_LIST_PANEL_TITLE] =
    {
        scene = "gamepad_ignored",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_contacts.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_contacts.dds", 
    }, 
	[SI_MAIN_MENU_GUILDS] =
    {
        scene = "gamepad_guild_hub",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_guilds.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_guilds.dds", 
    }, 
	[SI_MAIN_MENU_MAIL] =
    {
        scene = "mailManagerGamepad",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_mail.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_mail.dds", 
    }, 
	[SI_MAIN_MENU_NOTIFICATIONS] =
    {
        scene = "gamepad_notifications_root",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_notifications.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_notifications.dds", 
    }, 
	[SI_MAIN_MENU_GROUP] =
    {
        scene = "gamepad_groupList",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_groups.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_groups.dds", 
    }, 
	[SI_MAIN_MENU_COLLECTIONS] =
    {
        scene = "gamepadCollectionsBook",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_collections.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_collections.dds", 
    }, 
	[SI_MAIN_MENU_ACTIVITY_FINDER] =
    {
        scene = "gamepad_activity_finder_root",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_activityFinder.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_activityFinder.dds", 
    }, 
	[SI_MAIN_MENU_CROWN_CRATES] =
    {
        scene = "crownCrateGamepad",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_crownCrates.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_crownCrates.dds", 
    },  
	[SI_RADIAL_MENU_CANCEL_BUTTON] =
    {
        enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_cancel_down.dds",
        enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_cancel_down.dds", 
    }, 
	[SI_QUICKSLOTS_EMPTY] =
    {
        enabledNormal = "EsoUI/Art/Quickslots/quickslot_emptySlot.dds",
        enabledSelected = "EsoUI/Art/Quickslots/quickslot_emptySlot.dds", 
    }, 
}

function QuickMenu:AddMenuEntry(text, icons, enabled, selectedFunction, errorReason)
    local normalIcon = enabled and icons.enabledNormal or icons.disabledNormal
    local selectedIcon = enabled and icons.enabledSelected or icons.disabledSelected 
	if not enabled then
		selectedFunction = nil 
	end
    self:GetRadialMenu():AddEntry(text, normalIcon, selectedIcon, selectedFunction, errorReason)
end 

function QuickMenu:StartInteraction()
    if not SCENE_MANAGER:IsInUIMode() then
        if not self.isInteracting then 
			
			--add entries
			local platformIcons = IsInGamepadPreferredMode() and GAMEPAD_INTERACT_ICONS or KEYBOARD_INTERACT_ICONS
			  
			local function AddMenuEntry(menuEntryId)

				local function SelectEntry(entryId)  
					
					local function CallbackSelectEntry()
						local entry = platformIcons[entryId]
						if entry then
							if entry.scene then  
								SCENE_MANAGER:Push(entry.scene)
							elseif entry.scenegroup and entry.descriptor then
								MAIN_MENU_KEYBOARD:ShowSceneGroup(entry.scenegroup, entry.descriptor)
							end
						end
					end 
					return CallbackSelectEntry
				end 
				
				local enabled = true
				local name = GetString(menuEntryId)
				if menuEntryId == SI_MAIN_MENU_SKILLS and IsInGamepadPreferredMode() then
					if not GAMEPAD_SKILLS.categoryKeybindStripDescriptor then
						--not initialized yet, make it disabled
						enabled = false
						name = string.format("%s\n(Need Open Manually First)", name)
					end
				end
				if platformIcons[menuEntryId] then
					self:AddMenuEntry(name, platformIcons[menuEntryId], enabled, SelectEntry(menuEntryId) )
				else
					self:AddMenuEntry(GetString(SI_QUICKSLOTS_EMPTY), platformIcons[SI_QUICKSLOTS_EMPTY], true, nil )
				end
			end
			for i = 1, QuickMenu.acctSavedVariables.slotsCount do
				AddMenuEntry(QuickMenu.acctSavedVariables.slots[i])
			end
			AddMenuEntry(SI_RADIAL_MENU_CANCEL_BUTTON) 
			--[[
			AddMenuEntry(SI_JOURNAL_MENU_QUESTS)
			AddMenuEntry(SI_JOURNAL_MENU_CADWELLS_ALMANAC)
			AddMenuEntry(SI_JOURNAL_MENU_LORE_LIBRARY)
			AddMenuEntry(SI_JOURNAL_MENU_ACHIEVEMENTS)
			AddMenuEntry(SI_JOURNAL_MENU_LEADERBOARDS)
			AddMenuEntry(SI_MAIN_MENU_CHARACTER)
			AddMenuEntry(SI_MAIN_MENU_SKILLS) 
			AddMenuEntry(SI_MAIN_MENU_CHAMPION) 
			AddMenuEntry(SI_MAIN_MENU_MARKET) 
			AddMenuEntry(SI_MAIN_MENU_INVENTORY)
			AddMenuEntry(SI_MAIN_MENU_ALLIANCE_WAR) 
			AddMenuEntry(SI_MAIN_MENU_MAP)  
			AddMenuEntry(SI_WINDOW_TITLE_FRIENDS_LIST) 
			AddMenuEntry(SI_IGNORE_LIST_PANEL_TITLE) 
			AddMenuEntry(SI_MAIN_MENU_GUILDS)
			AddMenuEntry(SI_MAIN_MENU_MAIL)
			AddMenuEntry(SI_MAIN_MENU_NOTIFICATIONS)
			AddMenuEntry(SI_MAIN_MENU_GROUP)
			AddMenuEntry(SI_MAIN_MENU_COLLECTIONS)
			AddMenuEntry(SI_MAIN_MENU_ACTIVITY_FINDER) 
			AddMenuEntry(SI_MAIN_MENU_CROWN_CRATES)
			AddMenuEntry(SI_RADIAL_MENU_CANCEL_BUTTON)
			]]--
			
			local menu = self:GetRadialMenu()
			menu:Show()
			
			
			LockCameraRotation(true)
			RETICLE:RequestHidden(true)
			self.isInteracting = true 
			
        end
    end
end
 
function QuickMenu:StopInteraction()     
    if self.isInteracting then
        self.isInteracting = false
        RETICLE:RequestHidden(false)
        LockCameraRotation(false)
        self:GetRadialMenu():SelectCurrentEntry()
        self:GetRadialMenu():Clear()
    end 
end

function QuickMenu:ShowMenu() 
	self:StartInteraction()
end

function QuickMenu:HideMenu() 
	self:StopInteraction()
end
 
local function commandExec()
end
 
--== Slash command ==--
function QuickMenu.cmd( text )
	if text == nil then text = true end
    LAM2:OpenToPanel(QUICKMENU_ADDONMENU) 
	local addons = LAM2.addonList:GetChild(1)
	if addons:GetNumChildren() ~= 0 then
		for a=1,addons:GetNumChildren(),1 do 
			if addons:GetChild(a):GetText() == QuickMenu.settingName then
				addons:GetChild(a):SetSelected(true)
				break
			end	
		end
	end	
	--Second time's the charm
	if text then
		zo_callLater(function()QuickMenu.cmd(false)end,500)
	end
end
SLASH_COMMANDS["/qm"] = QuickMenu.cmd
EVENT_MANAGER:RegisterForEvent(QuickMenu.name, EVENT_ADD_ON_LOADED, triggerAddonLoaded);  