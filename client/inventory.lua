-- Open Inventory
RegisterNetEvent('yh-admin:client:openInventory', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local player = selectedData["Mängija"].value
    local targetplayer = GetPlayerFromServerId(targetPed)

    if Config.Inventory == 'ox_inventory' then
        --TriggerServerEvent("yh-admin:server:OpenInv", player)
    else
    TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", targetPed)
        lib.notify({title = "ADMIN SÜSTEEM", description = "Avasid edukalt teise mängija inventory.", type = "inform", duration = 5000})
    end
end)

-- Open Stash
--RegisterNetEvent('yh-admin:client:openStash', function(data, selectedData)
--    local data = CheckDataFromKey(data)
--    if not data or not CheckPerms(data.perms) then return end
--    local stash = selectedData["Stash"].value
--
--    if Config.Inventory == 'ox_inventory' then
--        TriggerServerEvent("yh-admin:server:OpenStash", stash)
--    else
--        TriggerServerEvent("inventory:server:OpenInventory", "stash", tostring(stash))
--        TriggerEvent("inventory:client:SetCurrentStash", tostring(stash))
--    end
--end)
--
---- Open Trunk
--RegisterNetEvent('yh-admin:client:openTrunk', function(data, selectedData)
--    local data = CheckDataFromKey(data)
--    if not data or not CheckPerms(data.perms) then return end
--    local vehiclePlate = selectedData["Plate"].value
--
--    if Config.Inventory == 'ox_inventory' then
--        TriggerServerEvent("yh-admin:server:OpenTrunk", vehiclePlate)
--    else
--        TriggerServerEvent("inventory:server:OpenInventory", "trunk", tostring(vehiclePlate))
--        TriggerEvent("inventory:client:SetCurrentStash", tostring(vehiclePlate))
--    end
--end)
