------------------
--LOAD LIBRARIES--
------------------

--load LibAddonsMenu-2.0
local LAM2 = LibStub:GetLibrary("LibAddonMenu-2.0");

----------------------
--INITIATE VARIABLES--
----------------------

--create Addon UI table
QuickMenuData = {};
--define name of addon
QuickMenuData.name = "QuickMenu";
--define addon version number
QuickMenuData.version = 1.00; 
 
QuickMenu = {} 
ZO_CreateStringId("SI_BINDING_NAME_QUICK_MENU", "Quick Menu") 

local function triggerAddonLoaded(eventCode, addonName)
  if  (addonName == QuickMenuData.name) then
    EVENT_MANAGER:UnregisterForEvent(QuickMenuData.name, EVENT_ADD_ON_LOADED);
    
	
  end
end

function QuickMenu:Initialize()
	
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
    [SI_MAIN_MENU_INVENTORY] =
    {
        scene = "inventory",
        enabledNormal = "EsoUI/Art/MainMenu/menuBar_inventory_up.dds",
        enabledSelected = "EsoUI/Art/MainMenu/menuBar_inventory_down.dds", 
    }, 
	[SI_RADIAL_MENU_CANCEL_BUTTON] =
    {
        enabledNormal = "EsoUI/Art/HUD/radialIcon_cancel_up.dds",
        enabledSelected = "EsoUI/Art/HUD/radialIcon_cancel_over.dds",
    }, 
}


local GAMEPAD_INTERACT_ICONS =
{
    [SI_MAIN_MENU_INVENTORY] =
    {
        scene = "gamepad_inventory_root",
        enabledNormal = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_inventory.dds",
        enabledSelected = "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_inventory.dds", 
    }, 
	[SI_RADIAL_MENU_CANCEL_BUTTON] =
    {
        enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_cancel_down.dds",
        enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_cancel_down.dds", 
    }, 
}

function QuickMenu:AddMenuEntry(text, icons, enabled, selectedFunction, errorReason)
    local normalIcon = enabled and icons.enabledNormal or icons.disabledNormal
    local selectedIcon = enabled and icons.enabledSelected or icons.disabledSelected 
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
						if entry and entry.scene then
							SCENE_MANAGER:Push(entry.scene)
						end
					end 
					return CallbackSelectEntry
				end 
				
				self:AddMenuEntry(GetString(menuEntryId), platformIcons[menuEntryId], true, SelectEntry(menuEntryId) )
			end
			
			AddMenuEntry(SI_MAIN_MENU_INVENTORY)
			AddMenuEntry(SI_RADIAL_MENU_CANCEL_BUTTON) 
			
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
 
SLASH_COMMANDS["/qm"] = commandExec
EVENT_MANAGER:RegisterForEvent(QuickMenuData.name, EVENT_ADD_ON_LOADED, triggerAddonLoaded);  