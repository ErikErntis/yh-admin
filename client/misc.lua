-- Toggles Invincibility
RSGCore = exports['rsg-core']:GetCoreObject()

local visible = true
RegisterNetEvent('yh-admin:client:ToggleInvisible', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    visible = not visible

    SetEntityVisible(cache.ped, visible, 0)
end)

-- God Mode
local godmode = false
RegisterNetEvent('yh-admin:client:ToggleGodmode', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    godmode = not godmode

    if godmode then
        lib.notify({title = "ADMIN SÜSTEEM", description = "God Mode aktiveeritud.", type = "success", duration = 5000})
        while godmode do
            Wait(0)
            SetPlayerInvincible(cache.playerId, true)
        end
        SetPlayerInvincible(cache.playerId, false)
        lib.notify({title = "ADMIN SÜSTEEM", description = "God Mode deaktiveeritud.", type = "error", duration = 5000})
    end
end)

-- Cuff/Uncuff
-- RegisterNetEvent('yh-admin:client:ToggleCuffs', function(player)
--     local target = GetPlayerServerId(player)
--     TriggerEvent("police:client:CuffPlayerSoft", target)
-- end)

-- Copy Coordinates
local function CopyCoords(data)
    local coords = GetEntityCoords(cache.ped)
    local heading = GetEntityHeading(cache.ped)
    local formats = { vector2 = "%.2f, %.2f", vector3 = "%.2f, %.2f, %.2f", vector4 = "%.2f, %.2f, %.2f, %.2f", heading =
    "%.2f" }
    local format = formats[data]

    local clipboardText = ""
    if data == "vector2" then
        clipboardText = string.format(format, coords.x, coords.y)
    elseif data == "vector3" then
        clipboardText = string.format(format, coords.x, coords.y, coords.z)
    elseif data == "vector4" then
        clipboardText = string.format(format, coords.x, coords.y, coords.z, heading)
    elseif data == "heading" then
        clipboardText = string.format(format, heading)
    end

    lib.setClipboard(clipboardText)
end

RegisterCommand("vector2", function()
    if not CheckPerms('mod') then return end
    CopyCoords("vector2")
end, false)

RegisterCommand("vector3", function()
    if not CheckPerms('mod') then return end
    CopyCoords("vector3")
end, false)

RegisterCommand("vector4", function()
    if not CheckPerms('mod') then return end
    CopyCoords("vector4")
end, false)

RegisterCommand("heading", function()
    if not CheckPerms('mod') then return end
    CopyCoords("heading")
end, false)

-- Infinite Ammo
--local InfiniteAmmo = false
--RegisterNetEvent('yh-admin:client:setInfiniteAmmo', function(data)
--    local data = CheckDataFromKey(data)
--    if not data or not CheckPerms(data.perms) then return end
--    InfiniteAmmo = not InfiniteAmmo
--
--    if GetAmmoInPedWeapon(cache.ped, cache.weapon) < 6 then
--        SetAmmoInClip(cache.ped, cache.weapon, 10)
--        Wait(50)
--    end
--
--    while InfiniteAmmo do
--        SetPedInfiniteAmmo(cache.ped, true, cache.weapon)
--        RefillAmmoInstantly(cache.ped) -- SEDA FUNKTSIOONI POLE REDM-S
--        Wait(250)
--    end
--
--    SetPedInfiniteAmmo(cache.ped, false, cache.weapon)
--end)

-- Toggle coords
local showCoords = false
local function showCoordsMenu()
    while showCoords do
        Wait(50)
        local coords = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
        SendNUIMessage({
            action = "showCoordsMenu",
            data = {
                show = showCoords,
                x = RSGCore.Shared.Round(coords.x, 2),
                y = RSGCore.Shared.Round(coords.y, 2),
                z = RSGCore.Shared.Round(coords.z, 2),
                heading = RSGCore.Shared.Round(heading, 2)
            }
        })
    end
end

RegisterNetEvent('yh-admin:client:ToggleCoords', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    showCoords = not showCoords

    if showCoords then
        CreateThread(showCoordsMenu)
    end
end)

-- Set Ammo
RegisterNetEvent('yh-admin:client:SetAmmo', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local ammo = selectedData["Ammo Ammount"].value
    local weapon = GetSelectedPedWeapon(cache.ped)

    if weapon ~= nil then
        SetPedAmmo(cache.ped, weapon, ammo)
        --QBCore.Functions.Notify(locale("set_wepaon_ammo", tostring(ammo)), 'success') NOTIFY
    else
        --QBCore.Functions.Notify(locale("no_weapon"), 'error') NOTIFY
    end
end)

RegisterCommand("setammo", function(source)
    if not CheckPerms('mod') then return end
    local weapon = GetSelectedPedWeapon(cache.ped)
    local ammo = 999
    if weapon ~= nil then
        SetPedAmmo(cache.ped, weapon, ammo)
        --QBCore.Functions.Notify(locale("set_wepaon_ammo", tostring(ammo)), 'success') NOTIFY
    else
        --QBCore.Functions.Notify(locale("no_weapon"), 'error') NOTIFY
    end
end, false)

--Toggle Dev
local ToggleDev = false

RegisterNetEvent('yh-admin:client:ToggleDev', function(dataKey)
    local data = CheckDataFromKey(dataKey)
    if not data or not CheckPerms(data.perms) then return end

    ToggleDev = not ToggleDev

    --TriggerEvent("qb-admin:client:ToggleDevmode")           -- toggle dev mode (ps-hud/qb-hud)
    TriggerEvent('yh-admin:client:ToggleCoords', DataKey)  -- toggle Coords
    TriggerEvent('yh-admin:client:ToggleGodmode', DataKey) -- Godmode

    lib.notify({title = "ADMIN SÜSTEEM", description = "Dev Mode aktiveeritud.", type = "inform", duration = 5000})
end)

-- Key Bindings

RegisterCommand("toggleAdmin", function()
    TriggerEvent('yh-admin:client:ToggleGodmode', {})
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        -- Adjust the control code for RedM
        if IsControlJustReleased(0, Config.AdminKey) then
            TriggerEvent('yh-admin:client:ToggleGodmode', {})
        end
    end
end)

RegisterCommand('nc', function()
    TriggerEvent('yh-admin:client:ToggleNoclip', {})
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        -- Adjust the control code for RedM
        if IsControlJustReleased(0, Config.NoclipKey) then
            TriggerEvent('yh-admin:client:ToggleNoclip', {})
        end
    end
end)

local toogleAdmin = { disable = function() end } 
local toogleNoclip = { disable = function() end } 

if Config.Keybindings then
    toogleAdmin.disable(false)
    toogleNoclip.disable(false)
else
    toogleAdmin.disable(true)
    toogleNoclip.disable(true)
end

-- Set Ped
RegisterNetEvent("yh-admin:client:setPed", function(pedModels)
    lib.requestModel(pedModels, 1500)
    SetPlayerModel(cache.playerId, pedModels)
    SetPedDefaultComponentVariation(cache.ped)
    SetModelAsNoLongerNeeded(pedModels)
end)
