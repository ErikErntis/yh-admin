
local RSGCore = exports['rsg-core']:GetCoreObject()

local function getVehicles(cid)
    local result = MySQL.query.await(
    'SELECT horseid, name, horse, horsexp, wild FROM player_horses WHERE citizenid = ?', { cid })
    local vehicles = {}

    for k, v in pairs(result) do
        local vehicleData = RSGCore.Shared.Vehicles[v.vehicle]

        if vehicleData then
            vehicles[#vehicles + 1] = {
                id = k,
                cid = cid,
                label = vehicleData.name,
                brand = vehicleData.brand,
                model = vehicleData.model,
                plate = v.horseid,
                fuel = v.name,
                engine = v.horsexp,
                body = v.wild
            }
        end
    end

    return vehicles
end


local function getPlayers()
    local players = {}
    local GetPlayers = RSGCore.Functions.GetRSGPlayers()
   
    for k, v in pairs(GetPlayers) do
    local playerData = v.PlayerData
    local vehicles = getVehicles(playerData.citizenid)

        players[#players + 1] = {
        
        id = k,
        name = playerData.charinfo.firstname .. ' ' .. playerData.charinfo.lastname,
        cid = playerData.citizenid,
        license = RSGCore.Functions.GetIdentifier(k, 'license'),
        discord = RSGCore.Functions.GetIdentifier(k, 'discord'),
        steam = RSGCore.Functions.GetIdentifier(k, 'steam'),
        job = playerData.job.label,
        grade = playerData.job.grade.level,
        dob = playerData.charinfo.birthdate,
        cash = playerData.money.cash,
        bank = playerData.money.bank,
        phone = playerData.citizenid,
        vehicles = vehicles
        }
    end


    table.sort(players, function(a, b) return a.id < b.id end)

    return players
end

lib.callback.register('yh-admin:callback:GetPlayers', function(source)
    return getPlayers()
end)

-- Set Job
RegisterNetEvent('yh-admin:server:SetJob', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local src = source
    local playerId, Job, Grade = selectedData["Mängija"].value, selectedData["Töö"].value, selectedData["Aste"].value
    local Player = RSGCore.Functions.GetPlayer(playerId)
    local name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local jobInfo = RSGCore.Shared.Jobs[Job]
    local grade = jobInfo["grades"][selectedData["Aste"].value]

    if not jobInfo then
        TriggerClientEvent('ox_lib:notify', source, {title = "ADMIN SÜSTEEM", description = "Ei ole kehtiv töö.", type = "inform"})
        return
    end

    if not grade then
        TriggerClientEvent('ox_lib:notify', source, {title = "ADMIN SÜSTEEM", description = "Ei ole kehtiv aste.", type = "inform"})
        return
    end

    Player.Functions.SetJob(tostring(Job), tonumber(Grade))
    TriggerClientEvent('ox_lib:notify', source, {title = "ADMIN SÜSTEEM", description = "Karakterile " ..name.. " edukalt lisatud töö " ..Job.. " astmega " ..Grade.. ".", type = "inform", duration = 15000})
end)

-- Set Gang
RegisterNetEvent('yh-admin:server:SetGang', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local src = source
    local playerId, Gang, Grade = selectedData["Mängija"].value, selectedData["Grupeering"].value, selectedData["Aste"].value
    local Player = RSGCore.Functions.GetPlayer(playerId)
    local name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local GangInfo = RSGCore.Shared.Gangs[Gang]
    local grade = GangInfo["grades"][selectedData["Aste"].value]

    if not GangInfo then
        TriggerClientEvent('ox_lib:notify', source, {title = "ADMIN SÜSTEEM", description = "Ei ole kehtiv grupeering.", type = "inform"})
        return
    end

    if not grade then
        TriggerClientEvent('ox_lib:notify', source, {title = "ADMIN SÜSTEEM", description = "Ei ole kehtiv aste.", type = "inform"})
        return
    end

    Player.Functions.SetGang(tostring(Gang), tonumber(Grade))
    TriggerClientEvent('ox_lib:notify', source, {title = "ADMIN SÜSTEEM", description = "Karakterile " ..name.. " edukalt lisatud grupeering " ..Gang.. " astmega " ..Grade.. ".", type = "inform", duration = 15000})
end)

-- Set Perms
RegisterNetEvent("yh-admin:server:SetPerms", function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local src = source
    local rank = selectedData["Permissions"].value
    local targetId = selectedData["Player"].value
    local tPlayer = RSGCore.Functions.GetPlayer(tonumber(targetId))

    if not tPlayer then
        TriggerClientEvent('ox_lib:notify', source, {title = "ADMIN SÜSTEEM", description = "Kasutajat ei leitud.", type = "error", duration = 5000})
        return
    end

    local name = tPlayer.PlayerData.charinfo.firstname .. ' ' .. tPlayer.PlayerData.charinfo.lastname

    RSGCore.Functions.AddPermission(tPlayer.PlayerData.source, tostring(rank))
    RSGCore.Functions.Notify(tPlayer.PlayerData.source, locale("player_perms", name, rank), 'success', 5000)
end)

-- Remove Stress
RegisterNetEvent("yh-admin:server:RemoveStress", function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local src = source
    local targetId = selectedData['Mängija (Valikuline)'] and tonumber(selectedData['Mängija (Valikuline)'].value) or src
    local tPlayer = RSGCore.Functions.GetPlayer(tonumber(targetId))

    if not tPlayer then
        TriggerClientEvent('ox_lib:notify', source, {title = "ADMIN SÜSTEEM", description = "Kasutajat ei leitud.", type = "error", duration = 5000})
        return
    end

    TriggerClientEvent('yh-admin:client:removeStress', targetId)

    TriggerClientEvent('ox_lib:notify', source, {title = "ADMIN SÜSTEEM", description = "Kasutajalt (ID: " ..targetId.. ") eemaldatud stress.", type = "inform", duration = 5000})
end)
