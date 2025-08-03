local blackoutActive = false

if Config.Debug then
    function debugPrint(msg)
        print("[Behr_Blackout] " .. msg)
    end
end

local function ShowHelpNotification(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

Citizen.CreateThread(function()
    -- Your chat suggestion
    TriggerEvent('chat:addSuggestion', '/' .. Config.BlackoutCommand, 'Toggles City-Wide Blackout (Admin-Only)', {})
end)

function blackoutNotify(state)
    if state then
        if Config.Notify == "chat" then
            TriggerEvent('chat:addMessage', { args = { '^1Blackout Activated!' } })
        elseif Config.Notify == "oxlib" then
            lib.notify({
                title = 'Blackout Activated!',
                description = 'A city-wide blackout has been activated.',
                position = 'top',
                type = 'success'
            })
            debugPrint("Activation notification sent.")
        elseif Config.Notify == "custom" then
            -- Assuming you have a custom notification system
        else
            debugPrint("Unknown notification method: " .. Config.Notify)
        end
    else
        if Config.Notify == "chat" then
            TriggerEvent('chat:addMessage', { args = { '^2Blackout Deactivated!' } })
        elseif Config.Notify == "oxlib" then
            lib.notify({
                title = 'Blackout Deactivated!',
                description = 'The city-wide blackout has been deactivated.',
                position = 'top',
                type = 'error'
            })
            debugPrint("Deactivation notification sent.")
        elseif Config.Notify == "custom" then
            -- Assuming you have a custom notification system
        else
            debugPrint("Unknown notification method: " .. Config.Notify)
        end
    end
end

RegisterNetEvent('behr_blackout:client:toggleBlackout')
AddEventHandler("behr_blackout:client:toggleBlackout", function(state)
    SetArtificialLightsState(state)
    blackoutNotify(state)

    debugPrint("Blackout state changed to: " .. tostring(state))
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist = #(pos - Config.PowerSwitchLocation)

        if dist < 20.0 then
            -- draw a red cylinder marker
            DrawMarker(1,
                Config.PowerSwitchLocation.x, Config.PowerSwitchLocation.y, Config.PowerSwitchLocation.z - 1.0,
                0, 0, 0, 0, 0, 0,
                1.5, 1.5, 0.5,
                255, 0, 0, 100,
                false, false, 2, false, nil, nil, false
            )

            if dist < 1.5 then
                ShowHelpNotification("Press ~INPUT_CONTEXT~ to toggle blackout")
                if IsControlJustReleased(0, 38) then  -- E key
                    TriggerServerEvent('behr_blackout:requestToggle')
                end
            end
        end
    end
end)
