RSGCore = exports['rsg-core']:GetCoreObject()
PlayerData = {}

-- Functions
local function setupMenu()
	Wait(500)
	PlayerData = RSGCore.Functions.GetPlayerData()
	local resources = lib.callback.await('yh-admin:callback:GetResources', false)
	local commands = lib.callback.await('yh-admin:callback:GetCommands', false)
	GetData()
	SendNUIMessage({
		action = "setupUI",
		data = {
			actions = Config.Actions,
			resources = resources,
			playerData = PlayerData,
			commands = commands
		}
	})
end

-- Event Handlers
AddEventHandler("RSGCore:Client:OnPlayerLoaded", function()
	setupMenu()
end)

AddEventHandler("onResourceStart", function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		setupMenu()
	end
end)

-- NUICallbacks
RegisterNUICallback("hideUI", function()
	ToggleUI(false)
end)

RegisterNUICallback("clickButton", function(data)
	local selectedData = data.selectedData
	local key = data.data
	local data = CheckDataFromKey(key)
	if not data or not CheckPerms(data.perms) then return end

	if data.type == "client" then
		TriggerEvent(data.event, key, selectedData)
	elseif data.type == "server" then
		TriggerServerEvent(data.event, key, selectedData)
	elseif data.type == "command" then
		ExecuteCommand(data.event)
	end

	Log("Action Used",
		PlayerData.name ..
		" (" ..
		PlayerData.citizenid ..
		") - Used: " .. data.label .. (selectedData and (" with args: " .. json.encode(selectedData)) or ""))
end)

-- Open UI Event
RegisterNetEvent('yh-admin:client:OpenUI', function()
	ToggleUI(true)
end)

-- Close UI Event
RegisterNetEvent('yh-admin:client:CloseUI', function()
	ToggleUI(false)
end)

-- Change resource state
RegisterNUICallback("setResourceState", function(data, cb)
	local resources = lib.callback.await('yh-admin:callback:ChangeResourceState', false, data)
	cb(resources)
end)

-- Get players
RegisterNUICallback("getPlayers", function(data, cb)
	local players = lib.callback.await('yh-admin:callback:GetPlayers', false)
	cb(players)
end)
