local function BindSpecial (desiredActionName, keyCode)
    local layers = GetNumActionLayers()
    for layerIndex=1, layers do
        local layerName, categories = GetActionLayerInfo(layerIndex)
        for categoryIndex=1, categories do
			local categoryName, actions = GetActionLayerCategoryInfo(layerIndex, categoryIndex)
            for actionIndex=1, actions do
                local actionName, isRebindable, isHidden = GetActionInfo(layerIndex, categoryIndex, actionIndex)
                if isRebindable and actionName == desiredActionName then
                    -- LayerIndex,CategoryIndex,ActionIndex,BindIndex(1-4),KeyCode,Modx4
                    CallSecureProtected("BindKeyToAction", layerIndex, categoryIndex, actionIndex, 4, keyCode, 0, 0, 0, 0)
                end
            end
        end
    end
end

function TfcQuickMenuBindDpadRight ()
    BindSpecial("QUICK_MENU",179)
    BindSpecial("QUICK_MENU",126)
end

PetDismiss = {}
PetDismiss.Familiars = { 23304, 30631, 30636, 30641, 23319, 30647, 30652, 30657, 23316, 30664, 30669, 30674 }
PetDismiss.Twilights = { 24613, 30581, 30584, 30587, 24636, 30592, 30595, 30598, 24639, 30618, 30622, 30626 }
PetDismiss.Grizzlys = { 85982, 85983, 85984, 85985, 85986, 85987, 85988, 85989, 85990, 85991, 85992, 85993 }
local function DismissAllPets()
	PetDismiss:DismissPet(PetDismiss.Familiars)
	PetDismiss:DismissPet(PetDismiss.Twilights)
	PetDismiss:DismissPet(PetDismiss.Grizzlys)
end
function PetDismiss:DismissPet(petList)
	local i, k, v
	-- Walk through the player's active buffs
	for i = 1, GetNumBuffs("player") do
		local buffName, timeStarted, timeEnding, buffSlot, stackCount, iconFilename, buffType, effectType, abilityType, statusEffectType, abilityId, canClickOff = GetUnitBuffInfo("player", i)
		-- Compare each buff's abilityID to the list of IDs we were given
		for k, v in pairs(petList) do
			if abilityId == v then
				-- Cancel the buff if we got a match
				CancelBuff(buffSlot)
			end
		end
	end
end

local function GetSpouseName()
    MyName = GetDisplayName()
    if MyName=="@Tommy.C" then return "@Samantha.C" end
    if MyName=="@Samantha.C" then return "@Tommy.C" end
    if MyName=="@Phrosty1" then return "@Jenniami" end
    if MyName=="@Jenniami" then return "@Phrosty1" end
end

local function TravelToSpouse()
    JumpToFriend(GetSpouseName())
end

function TfcQuickMenuExtraActions ()
    QuickMenu.RegisterGamepadMenuEntry("TfcExtension", "ReloadUI", "Reload UI", "esoui/art/menubar/gamepad/gp_playermenu_icon_logout.dds", function() ReloadUI("ingame") end)
    QuickMenu.RegisterGamepadMenuEntry("TfcExtension", "DismissAllPets", "Dismiss All Pets", "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_achievements.dds", DismissAllPets)
    QuickMenu.RegisterGamepadMenuEntry("TfcExtension", "TravelToLeader", "Travel To Group Leader", "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_groups.dds", JumpToGroupLeader)
    QuickMenu.RegisterGamepadMenuEntry("TfcExtension", "TravelToSpouse", "Travel To Spouse", "EsoUI/Art/MenuBar/Gamepad/gp_playerMenu_icon_groups.dds", TravelToSpouse)

end