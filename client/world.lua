-- Changes the time
RegisterNetEvent('yh-admin:client:ChangeTime', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local time = selectedData["Time Events"].value

    if not time then return end

    TriggerServerEvent('weathersync:changeTime', time, 00)
end)

-- Changes the weather
RegisterNetEvent('yh-admin:client:ChangeWeather', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    --local weather = selectedData["Weather"].value

    TriggerServerEvent('weathersync:openAdminUi', source)
end)

RegisterNetEvent('yh-admin:client:copyToClipboard', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local dropdown = selectedData["Väljund"].value
    local ped = PlayerPedId()
    local string = nil
    if dropdown == 'vector2' then
        local coords = GetEntityCoords(ped)
        local x = RSGCore.Shared.Round(coords.x, 2)
        local y = RSGCore.Shared.Round(coords.y, 2)
        string = "vector2(".. x ..", ".. y ..")"
    RSGCore.Functions.Notify(locale("copy_vector2"), 'success')
    elseif dropdown == 'vector3' then
        local coords = GetEntityCoords(ped)
        local x = RSGCore.Shared.Round(coords.x, 2)
        local y = RSGCore.Shared.Round(coords.y, 2)
        local z = RSGCore.Shared.Round(coords.z, 2)
        string = "vector3(".. x ..", ".. y ..", ".. z ..")"
        RSGCore.Functions.Notify(locale("copy_vector3"), 'success') 
    elseif dropdown == 'vector4' then
        local coords = GetEntityCoords(ped)
        local x = RSGCore.Shared.Round(coords.x, 2)
        local y = RSGCore.Shared.Round(coords.y, 2)
        local z = RSGCore.Shared.Round(coords.z, 2)
        local heading = GetEntityHeading(ped)
        local h = RSGCore.Shared.Round(heading, 2)
        string = "vector4(".. x ..", ".. y ..", ".. z ..", ".. h ..")"
        RSGCore.Functions.Notify(locale("copy_vector4"), 'success') 
    elseif dropdown == 'heading' then
        local heading = GetEntityHeading(ped)
        local h = RSGCore.Shared.Round(heading, 2)
        string = h
        RSGCore.Functions.Notify(locale("copy_heading"), 'success') 
    elseif string == nil then 
    RSGCore.Functions.Notify(locale("empty_input"), 'error') 
    end

    lib.setClipboard(string)

end)