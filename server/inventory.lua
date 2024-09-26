-- Clear Inventory
local RSGCore = exports['rsg-core']:GetCoreObject()
RegisterNetEvent('yh-admin:server:ClearInventory', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local player = selectedData["Mängija"].value
    local Player = RSGCore.Functions.GetPlayer(player)

    if not Player then
        return TriggerClientEvent('ox_lib:notify', src, {title = "ADMIN SÜSTEEM", description = "Kasutajat ei leitud.", type = "error", duration = 5000})
    end

    if Config.Inventory == 'ox_inventory' then
        exports.ox_inventory:ClearInventory(player)
    else
        exports[Config.Inventory]:ClearInventory(player, nil)
        TriggerClientEvent('ox_lib:notify', src, {title = "ADMIN SÜSTEEM", description = "Kasutaja (ID: " .. player .. ") inventory tühjendatud.", type = "inform", duration = 5000})
    end
end)

-- Clear Inventory Offline
RegisterNetEvent('yh-admin:server:ClearInventoryOffline', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local citizenId = selectedData["CitizenID"].value
    local Player = RSGCore.Functions.GetPlayerByCitizenId(citizenId)

    if Player then
        if Config.Inventory == 'ox_inventory' then
            exports.ox_inventory:ClearInventory(Player.PlayerData.source)
        else
            exports[Config.Inventory]:ClearInventory(Player.PlayerData.source, nil)
        end
        TriggerClientEvent('ox_lib:notify', src, {title = "ADMIN SÜSTEEM", description = "Kasutaja (CID: " ..citizenId.. ") inventory tühjendatud.", type = "inform", duration = 10000})
    else
        MySQL.Async.fetchAll("SELECT * FROM players WHERE citizenid = @citizenid", { ['@citizenid'] = citizenId },
            function(result)
                if result and result[1] then
                    MySQL.Async.execute("UPDATE players SET inventory = '{}' WHERE citizenid = @citizenid",
                        { ['@citizenid'] = citizenId })
                    TriggerClientEvent('ox_lib:notify', src, {title = "ADMIN SÜSTEEM", description = "Kasutaja (CID: " ..citizenId.. ") inventory tühjendatud.", type = "inform", duration = 10000})
                else
                    TriggerClientEvent('ox_lib:notify', src, {title = "ADMIN SÜSTEEM", description = "Kasutajat ei leitud.", type = "error", duration = 5000})
                end
            end)
    end
end)

-- Open Inv [ox side]
RegisterNetEvent('yh-admin:server:OpenInv', function(data)
    exports.ox_inventory:forceOpenInventory(source, 'player', data)
end)

-- Open Stash [ox side]
RegisterNetEvent('yh-admin:server:OpenStash', function(data)
    exports.ox_inventory:forceOpenInventory(source, 'stash', data)
end)

-- Open Trunk [ox side]
RegisterNetEvent('yh-admin:server:OpenTrunk', function(data)
    exports.ox_inventory:forceOpenInventory(source, 'trunk', data)
end)

-- Give Item
RegisterNetEvent('yh-admin:server:GiveItem', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local target = selectedData["Mängija"].value
    local item = selectedData["Item"].value
    local amount = selectedData["Kogus"].value
    local Player = RSGCore.Functions.GetPlayer(target)

    if not item or not amount then return end
    if not Player then
        return TriggerClientEvent('ox_lib:notify', src, {title = "ADMIN SÜSTEEM", description = "Kasutajat ei leitud.", type = "error", duration = 5000})
    end

    Player.Functions.AddItem(item, amount)
    TriggerClientEvent('ox_lib:notify', source, {title = "ADMIN SÜSTEEM", description = "Edukalt lisatud kasutajale " .. amount .. "x " .. item .. ".", type = "inform", duration = 6000})
end)

-- Give Item to All
RegisterNetEvent('yh-admin:server:GiveItemAll', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local item = selectedData["Item"].value
    local amount = selectedData["Kogus"].value
    local players = RSGCore.Functions.GetPlayers()

    if not item or not amount then return end

    for _, id in pairs(players) do
        local Player = RSGCore.Functions.GetPlayer(id)
        Player.Functions.AddItem(item, amount)
        TriggerClientEvent('ox_lib:notify', source, {title = "ADMIN SÜSTEEM", description = "Edukalt lisatud igale mängijale " .. amount .. "x " .. item .. ".", type = "inform", duration = 6000})
    end
end)
