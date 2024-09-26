local RSGCore = exports['rsg-core']:GetCoreObject()

lib.addCommand('admin', {
    help = 'Ava',
    restricted = 'group.admin'
}, function(source)
    TriggerClientEvent('yh-admin:client:OpenUI', source)
end)
-- Callbacks
