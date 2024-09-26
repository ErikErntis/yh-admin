-- Ban Player
local RSGCore = exports['rsg-core']:GetCoreObject()

function GetSteamID(source)
	local sid = GetPlayerIdentifiers(source)[1] or false

	if (sid == false or sid:sub(1,5) ~= "steam") then
		return false
	end

	return sid

end



RegisterNetEvent('yh-admin:server:BanPlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local player = selectedData["Mängija"].value
    local reason = selectedData["Põhjus"].value or ""
    local time = selectedData["Kestvus"].value

    local banTime = tonumber(os.time() + time)
    local timeTable = os.date('*t', banTime)

    MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)',
        { GetPlayerName(player), RSGCore.Functions.GetIdentifier(player, 'license'), RSGCore.Functions.GetIdentifier(
            player, 'discord'), RSGCore.Functions.GetIdentifier(player, 'ip'), reason, banTime, GetPlayerName(source) })

    if time == 2147483647 then
        DropPlayer(player, locale("banned") .. '\n' .. locale("reason") .. reason .. locale("ban_perm"))
    else
        DropPlayer(player,
            locale("banned") ..
            '\n' ..
            locale("reason") ..
            reason ..
            '\n' ..
            locale("ban_expires") ..
            timeTable['day'] ..
            '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'])
    end

    TriggerClientEvent('ox_lib:notify', source, {title = "ADMIN SÜSTEEM", description = "Edukalt keelustatud mängija " ..player.. ". Lisainfo saamiseks suundu UCP-sse.", type = "inform", duration = 10000})
end)

-- Warn Player
RegisterNetEvent('yh-admin:server:WarnPlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local targetId = selectedData["Mängija"].value
    local target = RSGCore.Functions.GetPlayer(targetId)
    local reason = selectedData["Põhjus"].value
    local sender = RSGCore.Functions.GetPlayer(source)
    local warnId = 'WARN-' .. math.random(1111, 9999)
    local time = os.date(Config.DateFormat)
    if target ~= nil then
        TriggerClientEvent('ox_lib:alertDialog', targetId, {header = "**HOIATUS**", content = "Administraator määras sulle hoiatuse.\n\n**Põhjus:** " ..reason.. "\n\n**Lisa:** Kasutaja hoiatused salvestatakse automaatselt ning need ei aegu.", centered = true, cancel = false, size = "md", overflow = true})
        TriggerClientEvent('ox_lib:notify', source, {title = "ADMIN SÜSTEEM", description = "Hoiatus lisatud kasutajale " .. GetPlayerName(target.PlayerData.source) .. ".\n\nPõhjus: " ..reason, type = "inform", duration = 10000})
        MySQL.insert('INSERT INTO player_warns (senderIdentifier, targetIdentifier, reason, warnId) VALUES (?, ?, ?, ?)',
            {
                sender.PlayerData.license,
                target.PlayerData.license,
                reason,
                warnId
            })
    else
        TriggerClientEvent('ox_lib:notify', source, {title = "ADMIN SÜSTEEM", description = "Kasutajat ei leitud.", type = "error", duration = 5000})
    end
end)

RegisterNetEvent('yh-admin:server:KickPlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local src = source
    local target = RSGCore.Functions.GetPlayer(selectedData["Mängija"].value)
    local reason = selectedData["Põhjus"].value

    if not target then
        TriggerClientEvent('ox_lib:notify', source, {title = "ADMIN SÜSTEEM", description = "Kasutajat ei leitud.", type = "error", duration = 5000})
        return
    end

    DropPlayer(target.PlayerData.source, locale("kicked") .. '\n' .. locale("reason") .. reason)
end)

-- Revive Player
RegisterNetEvent('yh-admin:server:Revive', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local player = selectedData["Mängija"].value

    TriggerClientEvent('rsg-medic:client:adminRevive', player)
    TriggerClientEvent('ox_lib:notify', player, {title = "Sind raviti administraatori poolt."})
end)

-- Revive All
RegisterNetEvent('yh-admin:server:ReviveAll', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    TriggerClientEvent('rsg-medic:client:adminRevive', -1)
    TriggerClientEvent('ox_lib:notify', -1, {title = "Sind raviti administraatori poolt."})
end)

-- Revive Radius
RegisterNetEvent('yh-admin:server:ReviveRadius', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local ped = GetPlayerPed(src)
    local pos = GetEntityCoords(ped)
    local players = RSGCore.Functions.GetPlayers()

    for k, v in pairs(players) do
        local target = GetPlayerPed(v)
        local targetPos = GetEntityCoords(target)
        local dist = #(pos - targetPos)

        if dist < 15.0 then
            TriggerClientEvent('rsg-medic:client:adminRevive', v)
            TriggerClientEvent('ox_lib:notify', v, {title = "Sind raviti administraatori poolt."})
        end
    end
end)

-- Set RoutingBucket
RegisterNetEvent('yh-admin:server:SetBucket', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local player = selectedData["Mängija"].value
    local bucket = selectedData["Bucket"].value
    local currentBucket = GetPlayerRoutingBucket(player)

    if bucket == currentBucket then
        return TriggerClientEvent('ox_lib:notify', src, {title = "ADMIN SÜSTEEM", description = "Mängija on juba valitud bucketis.", type = "inform", duration = 5000})
    end

    SetPlayerRoutingBucket(player, bucket)
    TriggerClientEvent('ox_lib:notify', src, {title = "ADMIN SÜSTEEM", description = "Määratud bucket " ..bucket.. " mängijale (ID: " ..player.. ").", type = "inform", duration = 5000})
end)

-- Get RoutingBucket
RegisterNetEvent('yh-admin:server:GetBucket', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local player = selectedData["Mängija"].value
    local currentBucket = GetPlayerRoutingBucket(player)

    TriggerClientEvent('ox_lib:notify', src, {title = "ADMIN SÜSTEEM", description = "Mängija (ID: " ..player.. ") asub bucketis: " ..currentBucket..".", type = "inform", duration = 15000})
end)

-- Give Money
RegisterNetEvent('yh-admin:server:GiveMoney', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local target, amount, moneyType = selectedData["Mängija"].value, selectedData["Summa"].value,
        selectedData["Tüüp"].value
    local Player = RSGCore.Functions.GetPlayer(tonumber(target))

    if Player == nil then
        return TriggerClientEvent('ox_lib:notify', src, {title = "ADMIN SÜSTEEM", description = "Kasutajat ei leitud.", type = "inform", duration = 5000})
    end

    Player.Functions.AddMoney(tostring(moneyType), tonumber(amount))
    RSGCore.Functions.Notify(src,
        locale((moneyType == "crypto" and "give_money_crypto" or "give_money"), tonumber(amount),
            Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname), "success")
end)

-- Give Money to all
RegisterNetEvent('yh-admin:server:GiveMoneyAll', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local amount, moneyType = selectedData["Summa"].value, selectedData["Tüüp"].value
    local players = RSGCore.Functions.GetPlayers()

    for _, v in pairs(players) do
        local Player = RSGCore.Functions.GetPlayer(tonumber(v))
        Player.Functions.AddMoney(tostring(moneyType), tonumber(amount))
        RSGCore.Functions.Notify(src,
            locale((moneyType == "crypto" and "give_money_all_crypto" or "give_money_all"), tonumber(amount)), "success")
    end
end)

-- Take Money
RegisterNetEvent('yh-admin:server:TakeMoney', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local target, amount, moneyType = selectedData["Mängija"].value, selectedData["Summa"].value,
        selectedData["Tüüp"].value
    local Player = RSGCore.Functions.GetPlayer(tonumber(target))

    if Player == nil then
        return TriggerClientEvent('ox_lib:notify', src, {title = "ADMIN SÜSTEEM", description = "Kasutajat ei leitud.", type = "inform", duration = 5000})
    end

    if Player.PlayerData.money[moneyType] >= tonumber(amount) then
        Player.Functions.RemoveMoney(moneyType, tonumber(amount), "state-fees")
    else
        RSGCore.Functions.Notify(src, locale("not_enough_money"), "primary")
    end

    RSGCore.Functions.Notify(src,
        locale((moneyType == "crypto" and "take_money_crypto" or "take_money"), tonumber(amount) .. "$",
            Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname), "success")
end)

-- Toggle Cuffs
-- RegisterNetEvent('yh-admin:server:CuffPlayer', function(data, selectedData)
--     local data = CheckDataFromKey(data)
--     if not data or not CheckPerms(data.perms) then return end
-- 
--     local target = selectedData["Mängija"].value
-- 
--     TriggerClientEvent('yh-admin:client:ToggleCuffs', target)
--     RSGCore.Functions.Notify(source, locale("toggled_cuffs"), 'success')
-- end)

-- Give Clothing Menu
RegisterNetEvent('yh-admin:server:ClothingMenu', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local target = tonumber(selectedData["Mängija"].value)
    local _clothes = nil

    if target == nil then
        return TriggerClientEvent('ox_lib:notify', src, {title = "ADMIN SÜSTEEM", description = "Kasutajat ei leitud.", type = "inform", duration = 5000})
    end

    if target == src then
        TriggerClientEvent("yh-admin:client:CloseUI", src)
    end

    TriggerClientEvent("rsg-clothes:OpenClothingMenu", target, _clothes)
end)

-- Set Ped
--RegisterNetEvent("yh-admin:server:setPed", function(data, selectedData)
--    local src = source
--    local data = CheckDataFromKey(data)
--    if not data or not CheckPerms(data.perms) then
--        RSGCore.Functions.Notify(src, locale("no_perms"), "error", 5000)
--        return
--    end
--
--    local ped = selectedData["Ped Models"].label
--    local tsrc = selectedData["Mängija"].value
--    local Player = RSGCore.Functions.GetPlayer(tsrc)
--
--    if not Player then
--        RSGCore.Functions.Notify(locale("not_online"), "error", 5000)
--        return
--    end
--
--    TriggerClientEvent("yh-admin:client:setPed", Player.PlayerData.source, ped)
--end)
