local resourceName = GetCurrentResourceName()
local currentVersion = GetResourceMetadata(resourceName, "version", 0)
local versionURL = "https://raw.githubusercontent.com/BehrTheDon/behr_blackout/main/fxmanifest.lua"

if Config.VersionCheckEnabled then
    Citizen.CreateThread(function()
        PerformHttpRequest(versionURL, function(code, data, headers)
            if code == 200 then
                local latestVersion = data:match("[\r\n]version%s+['\"](.-)['\"]")

                if latestVersion then
                    if latestVersion ~= currentVersion then
                        print("^6----------------------------------------------------------------")
                        print("^1[" .. resourceName .. "]^0 Update available!")
                        print("^1Current: ^0" .. currentVersion .. " | ^2Latest: ^0" .. latestVersion)
                        print("^5Get the latest version at: ^0https://github.com/BehrTheDon/behr_blackout")
                        print("^6----------------------------------------------------------------")
                    else
                        print("^2[" .. resourceName .. "]^0 is up to date! (v" .. currentVersion .. ") Thank you for using Behr Development Scripts!")
                    end
                else
                    print("^1[" .. resourceName .. "]^0 Couldn't parse latest version.")
                end
            else
                print("^1[" .. resourceName .. "]^0 Failed to fetch version info. HTTP Code: " .. code)
            end
        end, "GET", "", {})
    end)
end

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