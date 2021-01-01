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