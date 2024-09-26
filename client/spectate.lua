local RSGCore = exports['rsg-core']:GetCoreObject()


local oldPos = nil
local spectateInfo = {
    toggled = false,
    target = 0,
    targetPed = 0
}

RegisterNetEvent('yh-admin:requestSpectate', function(targetPed, target, name)
    oldPos = GetEntityCoords(cache.ped)
    spectateInfo = {
        toggled = true,
        target = target,
        targetPed = targetPed
    }
end)

RegisterNetEvent('yh-admin:cancelSpectate', function()
    if NetworkIsInSpectatorMode() then
        NetworkSetInSpectatorMode(false, spectateInfo['targetPed'])
    end
    SetEntityVisible(cache.ped, true, 0)
    spectateInfo = { toggled = false, target = 0, targetPed = 0 }
    RequestCollisionAtCoord(oldPos)
    SetEntityCoords(cache.ped, oldPos)
    oldPos = nil;
end)

CreateThread(function()
    while true do
        Wait(0)
        if spectateInfo['toggled'] then
            local targetPed = NetworkGetEntityFromNetworkId(spectateInfo.targetPed)
            if DoesEntityExist(targetPed) then
                SetEntityVisible(cache.ped, false, 0)
                if not NetworkIsInSpectatorMode() then
                    RequestCollisionAtCoord(GetEntityCoords(targetPed))
                    NetworkSetInSpectatorMode(true, targetPed)
                end
            else
                TriggerServerEvent('yh-admin:spectate:teleport', spectateInfo['target'])
                while not DoesEntityExist(NetworkGetEntityFromNetworkId(spectateInfo.targetPed)) do Wait(100) end
            end
        else
            Wait(500)
        end
    end
end)

--Specci cycle


Citizen.CreateThread(function() 
	while true do 
		Citizen.Wait(0)

		if spectateInfo['toggled'] then 
	
			local playerIndex = getPlayerIndex(spectatedUserClientID)
			if playerIndex == nil then 

				if GetPlayersCountButSkipMe() >= 1 then 
					local players = GetPlayersButSkipMyself()
					local player = GetPlayerPed(players[1]) 
					spectatedUserClientID = players[1]
					spectatedUserServerID = GetPlayerServerId(spectatedUserClientID)
					spectatePlayer(GetPlayerPed(spectatedUserClientID))
					print('~b~Spectating ~f~' .. GetPlayerName(spectatedUserClientID))
					sendMsg('^5Spectating ^0' .. GetPlayerName(spectatedUserClientID))
				else
			
					print("~r~Error: Not enough players to spectate")
					spectatePlayer(GetPlayerPed(-1))
					print('^1Error: Not enough players to spectate')
					spectatedUserServerID = nil 
					spectatedUserClientID = nil 
					spectateInfo['toggled'] = false 
				end
			end
			local player = GetPlayerPed(-1)
			local spectatedCoords = GetEntityCoords(GetPlayerPed(spectatedUserClientID))
	
			SetEntityCoords(player, spectatedCoords.x, spectatedCoords.y + 10, spectatedCoords.z)
			local players = GetPlayersButSkipMyself()
			if IsControlJustReleased(0, 0xA65EBAB4) then 
				-- Go backwards, spectatedUserClientID - 1
				local index = getPlayerIndex(spectatedUserClientID, PlayerId());

				index = index - 1;
				if players[index] == nil then 
	
					index = #players 
				end
				local newSpectate = players[index]
				spectatedUserClientID = tonumber(newSpectate) 
				spectatedUserServerID = GetPlayerServerId(newSpectate)
				spectatePlayer(GetPlayerPed(spectatedUserClientID))
				print('~b~Spectating ~f~' .. GetPlayerName(spectatedUserClientID))
				print('^5Spectating ^0' .. GetPlayerName(spectatedUserClientID))
			elseif IsControlJustReleased(0, 0xDEB34313) then 
		
				local index = getPlayerIndex(spectatedUserClientID, PlayerId());
				index = index + 1
				if players[index] == nil then 
	
					index = 1 
				end
				local newSpectate = players[index]
				spectatedUserClientID = tonumber(newSpectate) 
				spectatedUserServerID = GetPlayerServerId(newSpectate)
				spectatePlayer(GetPlayerPed(spectatedUserClientID))
				ShowNotification('~b~Spectating ~f~' .. GetPlayerName(spectatedUserClientID))
				sendMsg('^5Spectating ^0' .. GetPlayerName(spectatedUserClientID))
			end
		end
	end
end)






function GetPlayersCountButSkipMe()
    local count = 0
    for _, i in ipairs(GetActivePlayers()) do
        if NetworkIsPlayerActive(i) then
			if GetPlayerPed(i) ~= GetPlayerPed(-1) then
				count = count + 1
			end
		end
    end
    return count
end
function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(0,1)
end

function GetPlayersButSkipMyself()
    local players = {}
    local ind = 1;
    for _, i in ipairs(GetActivePlayers()) do
        if NetworkIsPlayerActive(i) then
			if i ~= PlayerId() then
				players[ind] = i;
				ind = ind + 1;
			end
		end
    end

    return players
end
function GetPlayersCountButSkipMe()
    local count = 0
    for _, i in ipairs(GetActivePlayers()) do
        if NetworkIsPlayerActive(i) then
			if GetPlayerPed(i) ~= GetPlayerPed(-1) then
				count = count + 1
			end
		end
    end
    return count
end