
local RSGCore = exports['rsg-core']:GetCoreObject()
local spectating = {}

RegisterNetEvent('yh-admin:server:SpectateTarget', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local player = selectedData["Player"].value

    local type = "1"
    if player == source then return end --TriggerClientEvent('ox_lib:notify', src, {title = "ADMIN SÜSTEEM", description = "Sa ei saa end spectateda.", type = "error", duration = 5000})
    if spectating[source] then type = "0" end
    TriggerEvent('yh-admin:spectate', player, type == "1", source, data.perms)
    CheckRoutingbucket(source, player)
end)

AddEventHandler('yh-admin:spectate', function(target, on, source, perms)
    local tPed = GetPlayerPed(target)
    local data = {}
    data.perms = perms
    if DoesEntityExist(tPed) then
        if not on then
            TriggerClientEvent('yh-admin:cancelSpectate', source)
            spectating[source] = false
            FreezeEntityPosition(GetPlayerPed(source), false)
            TriggerClientEvent('yh-admin:client:toggleNames', source, data)
        elseif on then
            TriggerClientEvent('yh-admin:requestSpectate', source, NetworkGetNetworkIdFromEntity(tPed), target,
                GetPlayerName(target))
            spectating[source] = true
            TriggerClientEvent('yh-admin:client:toggleNames', source, data)
        end
    end
end)

RegisterNetEvent('yh-admin:spectate:teleport', function(target)
    local source = source
    local ped = GetPlayerPed(target)
    if DoesEntityExist(ped) then
        local targetCoords = GetEntityCoords(ped)
        SetEntityCoords(GetPlayerPed(source), targetCoords.x, targetCoords.y, targetCoords.z - 10)
        FreezeEntityPosition(GetPlayerPed(source), true)
    end
end)
