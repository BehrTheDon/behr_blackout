RegisterNetEvent('behr_blackout:requestToggle')
AddEventHandler('behr_blackout:requestToggle', function()
    local src = source
    if not IsPlayerAceAllowed(src, 'command.' .. Config.BlackoutCommand) then
        TriggerClientEvent('ox_lib:notify', src, {
            title       = 'Blackout',
            description = 'You do not have permission.',
            type        = 'error',
            position    = 'top-left'
        })
        debugPrint("Player " .. src .. " attempted to use blackout switch without permission.")
        return
    end
    blackoutActive = not blackoutActive
    TriggerClientEvent('behr_blackout:client:toggleBlackout', -1, blackoutActive)
end)

RegisterCommand(Config.BlackoutCommand, function(source)
    local src = source
    if not IsPlayerAceAllowed(src, 'command.' .. Config.BlackoutCommand) then
        TriggerClientEvent('ox_lib:notify', src, {
            title       = 'Blackout',
            description = 'You do not have permission.',
            type        = 'error',
            position    = 'top-left'
        })
        debugPrint("Player " .. src .. " attempted to use blackout command without permission.")
        return
    end
    blackoutActive = not blackoutActive
    TriggerClientEvent("behr_blackout:client:toggleBlackout", -1, blackoutActive)
end, true)