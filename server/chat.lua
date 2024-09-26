local RSGCore = exports['rsg-core']:GetCoreObject()
local messages = {}

-- Staff Chat
RegisterNetEvent('yh-admin:server:sendMessageServer', function(message, citizenid, fullname)
    if not CheckPerms('mod') then return end
    local time = os.time() * 1000
    local players = RSGCore.Functions.GetPlayers()

    for i = 1, #players, 1 do
        local player = players[i]
            if RSGCore.Functions.IsOptin(player) then
                --TriggerClientEvent('ox_lib:notify', source, {title = "Uus chat.", type = "inform", duration = 3000})
            end
        end

    messages[#messages + 1] = { message = message, citizenid = citizenid, fullname = fullname, time = time }
end)


lib.callback.register('yh-admin:callback:GetMessages', function()
    if not CheckPerms('mod') then return {} end
    return messages
end)