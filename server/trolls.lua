-- Freeze Player
local RSGCore = exports['rsg-core']:GetCoreObject()
local frozen = false
RegisterNetEvent('yh-admin:server:FreezePlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local src = source

    local target = selectedData["Mängija"].value

    local ped = GetPlayerPed(target)
    local Player = RSGCore.Functions.GetPlayer(target)

    if not frozen then
       local frozen = true
       FreezeEntityPosition(ped, true)
       TriggerClientEvent('ox_lib:notify', src, {title = "ADMIN SÜSTEEM", description = "Freezesid edukalt karakteri " ..Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname.. ".", type = "inform", duration = 5000})
    else
       local frozen = false
        FreezeEntityPosition(ped, false)
        TriggerClientEvent('ox_lib:notify', src, {title = "ADMIN SÜSTEEM", description = "Eemaldasid edukalt freezi karakterilt " ..Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname.. ".", type = "inform", duration = 5000})
    end
    if Player == nil then return end
end)

-- Drunk Player
RegisterNetEvent('yh-admin:server:DrunkPlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local target = selectedData["Mängija"].value
    local targetPed = GetPlayerPed(target)
    local Player = RSGCore.Functions.GetPlayer(target)

    if not Player then
        return RSGCore.Functions.Notify(src, locale("not_online"), 'error', 7500)
    end

    TriggerClientEvent('yh-admin:client:InitiateDrunkEffect', target)
    RSGCore.Functions.Notify(src,
        locale("playerdrunk",
            Player.PlayerData.charinfo.firstname ..
            " " .. Player.PlayerData.charinfo.lastname .. " | " .. Player.PlayerData.citizenid), 'Success', 7500)
end)
