Config = Config or {}

--Config.Fuel = "ps-fuel"        -- "ps-fuel", "LegacyFuel"
Config.ResourcePerms = 'admin' -- permission to control resource(start stop restart)
Config.ShowCommandsPerms = 'admin' -- permission to show all commands
--Config.RenewedPhone = false    -- if you use qb-phone from renewed. (multijob)

-- Key Bindings
Config.Keybindings = false
Config.AdminKey = 0x446258B6 -- Replace with the hash for PageDown
Config.NoclipKey = 0x3C3DD371 -- Replace with the hash for PageUp
-- Give Car
--Config.DefaultGarage = "Alta Garage"

Config.Actions = {
    --["admin_car"] = {
    --    label = "Admin Car",
    --    type = "client",
    --    event = "yh-admin:client:Admincar",
    --    perms = "mod",
    --},

    ["ban_player"] = {
        label = "Ban",
        perms = "mod",
        dropdown = {
            { label = "Mängija", option = "dropdown", data = "players" },
            { label = "Põhjus", option = "text" },
            {
                label = "Kestvus",
                option = "dropdown",
                data = {
                    { label = "Igavene",  value = "2147483647" },
                    { label = "10 minutit", value = "600" },
                    { label = "30 minutit", value = "1800" },
                    { label = "1 tund",     value = "3600" },
                    { label = "2 tundi",     value = "7200" },
                    { label = "3 tundi",     value = "10800" },
                    { label = "6 tundi",    value = "21600" },
                    { label = "8 tundi",    value = "28800" },
                    { label = "12 tundi",   value = "43200" },
                    { label = "1 päev",      value = "86400" },
                    { label = "3 päev",     value = "259200" },
                    { label = "1 nädal",     value = "604800" },
                    { label = "2 nädalat",     value = "1209600" },
                    { label = "3 nädalat",     value = "1814400" },
                    { label = "1 kuu",     value = "2419200" },
                    { label = "2 kuud",     value = "4838400" },
                    { label = "3 kuud",     value = "7257600" },
                    { label = "6 kuud",     value = "14515200" },
                    { label = "1 aasta",     value = "29030400" },
                },
            },
            { label = "Kinnita", option = "button", type = "server", event = "yh-admin:server:BanPlayer" },
        },
    },

    ["bring_player"] = {
        label = "Too Mängija",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:BringPlayer" },
        },
    },

    ["change_weather"] = {
        label = "Ilm ja Kell",
        perms = "mod",
        dropdown = {
            {
                label = "Ava Menüü",
                option = "button",
                type = "client",
                event = "weathersync:openAdminUi"
            },
        },
    },

   -- ["change_time"] = {
   --     label = "Muuda Kellaaega",
   --     perms = "mod",
   --     dropdown = {
   --         {
   --             label = "Time Events",
   --             option = "dropdown",
   --             data = {
   --                 { label = "Sunrise", value = "06" },
   --                 { label = "Morning", value = "09" },
   --                 { label = "Noon",    value = "12" },
   --                 { label = "Sunset",  value = "21" },
   --                 { label = "Evening", value = "22" },
   --                 { label = "Night",   value = "24" },
   --             },
   --         },
   --         { label = "Kinnita", option = "button", type = "client", event = "yh-admin:client:ChangeTime" },
   --     },
   -- },

   -- ["change_plate"] = {
   --     label = "Change Plate",
   --     perms = "mod",
   --     dropdown = {
   --         { label = "Plate",   option = "text" },
   --         { label = "Confirm", option = "button", type = "client", event = "yh-admin:client:ChangePlate" },
   --     },
   -- },

    ["clear_inventory"] = {
        label = "Tühjenda Inventory",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:ClearInventory" },
        },
    },

    ["clear_inventory_offline"] = {
        label = "Tühjenda Inventory (Offline)",
        perms = "mod",
        dropdown = {
            { label = "CitizenID", option = "text",   data = "players" },
            { label = "Kinnita",    option = "button", type = "server", event = "yh-admin:server:ClearInventoryOffline" },
        },
    },

    ["clothing_menu"] = {
        label = "Anna Riietus",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:ClothingMenu" },
        },
    },

    ["set_ped"] = {
        label = "Määra Ped",
        perms = "mod",
        dropdown = {
            { label = "Player",     option = "dropdown", data = "players" },
            { label = "Ped Models", option = "dropdown", data = "pedlist" },
            { label = "Confirm",    option = "button",   type = "server", event = "yh-admin:server:setPed" },
        },
    },

    ["copy_coords"] = {
        label = "Kopeeri Koordinaadid",
        perms = "mod",
        dropdown = {
            {
                label = "Väljund",
                option = "dropdown",
                data = {
                    { label = "Copy Vector2", value = "vector2" },
                    { label = "Copy Vector3", value = "vector3" },
                    { label = "Copy Vector4",    value = "vector4" },
                    { label = "Copy Heading",  value = "heading" },
                },
            },
            { label = "Kopeeri lõikelauale", option = "button", type = "client", event = "yh-admin:client:copyToClipboard"},
        },
    },

    ["delete_vehicle"] = {
        label = "Kustuta sõiduk",
        type = "command",
        event = "dv",
        perms = "mod",
    },

    ["freeze_player"] = {
        label = "Freeze Mängija",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:FreezePlayer" },
        },
    },

   -- ["drunk_player"] = {
   --     label = "Jooda Purju",
   --     perms = "mod",
   --     dropdown = {
   --         { label = "Mängija",  option = "dropdown", data = "players" },
   --         { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:DrunkPlayer" },
   --     },
   -- },

    ["remove_stress"] = {
        label = "Eemalda Stress",
        perms = "mod",
        dropdown = {
            { label = "Mängija (Valikuline)", option = "dropdown", data = "players" },
            { label = "Kinnita",           option = "button",   type = "server", event = "yh-admin:server:RemoveStress" },
        },
    },

    -- ["set_ammo"] = {
    --     label = "Set Ammo",
    --     perms = "admin",
    --     dropdown = {
    --         { label = "Ammo Ammount", option = "text" },
    --         { label = "Confirm",      option = "button", type = "client", event = "yh-admin:client:SetAmmo" },
    --     },
    -- },

    -- ["nui_focus"] = {
    --     label = "Give NUI Focus",
    --     perms = "mod",
    --     dropdown = {
    --         { label = "Player",  option = "dropdown", data = "players" },
    --         { label = "Confirm", option = "button",   type = "client", event = "" },
    --     },
    -- },

    ["god_mode"] = {
        label = "God Mode",
        type = "client",
        event = "yh-admin:client:ToggleGodmode",
        perms = "mod",
    },

   --["give_car"] = {
   --    label = "Give Car",
   --    perms = "admin",
   --    dropdown = {
   --        { label = "Vehicle",           option = "dropdown", data = "vehicles" },
   --        { label = "Player",            option = "dropdown", data = "players" },
   --        { label = "Plate (Optional)",  option = "text" },
   --        { label = "Garage (Optional)", option = "text" },
   --        { label = "Confirm",           option = "button",   type = "server",  event = "yh-admin:server:givecar" },
   --    }
   --},

    ["invisible"] = {
        label = "Invisibility",
        type = "client",
        event = "yh-admin:client:ToggleInvisible",
        perms = "mod",
    },

   -- ["blackout"] = {
   --     label = "Toggle Blackout",
   --     type = "server",
   --     event = "yh-admin:server:ToggleBlackout",
   --     perms = "mod",
   -- },

    --["toggle_duty"] = {
    --    label = "Toggle Duty",
    --    type = "server",
    --    event = "QBCore:ToggleDuty",
    --    perms = "mod",
    --},
--
    --["toggle_laser"] = {
    --    label = "Toggle Laser",
    --    type = "client",
    --    event = "yh-admin:client:ToggleLaser",
    --    perms = "mod",
    --},

    ["set_perms"] = {
        label = "Määra Õigused",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            {
                label = "Permissions",
                option = "dropdown",
                data = {
                    { label = "Mod",   value = "mod" },
                    { label = "Admin", value = "admin" },
                    { label = "God",   value = "god" },
                },
            },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:SetPerms" },
        },
    },

    ["set_bucket"] = {
        label = "Set Routing Bucket",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Bucket",  option = "text" },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:SetBucket" },
        },
    },

    ["get_bucket"] = {
        label = "Get Routing Bucket",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:GetBucket" },
        },
    },

    ["mute_player"] = {
        label = "Vaigista mängija",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Kinnita", option = "button",   type = "client", event = "yh-admin:client:MutePlayer" },
        },
    },

    ["noclip"] = {
        label = "Noclip",
        type = "client",
        event = "yh-admin:client:ToggleNoClip",
        perms = "mod",
    },

    ["open_inventory"] = {
        label = "Ava Inventory",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Kinnita", option = "button",   type = "client", event = "yh-admin:client:openInventory" },
        },
    },

  --["open_stash"] = {
  --    label = "Open Stash",
  --    perms = "mod",
  --    dropdown = {
  --        { label = "Stash",   option = "text" },
  --        { label = "Confirm", option = "button", type = "client", event = "yh-admin:client:openStash" },
  --    },
  --},

  --["open_trunk"] = {
  --    label = "Open Trunk",
  --    perms = "mod",
  --    dropdown = {
  --        { label = "Plate",   option = "text" },
  --        { label = "Confirm", option = "button", type = "client", event = "yh-admin:client:openTrunk" },
  --    },
  --},

   -- ["change_vehicle_state"] = {
   --     label = "Set Vehicle Garage State",
   --     perms = "mod",
   --     dropdown = {
   --         { label = "Plate",   option = "text" },
   --         {
   --             label = "State",
   --             option = "dropdown",
   --             data = {
   --                 { label = "In",  value = "1" },
   --                 { label = "Out", value = "0" },
   --             },
   --         },
   --         { label = "Confirm", option = "button", type = "server", event = "yh-admin:server:SetVehicleState" },
   --     },
   -- },

    ["revive_all"] = {
        label = "Revive Kõik",
        type = "server",
        event = "yh-admin:server:ReviveAll",
        perms = "mod",
    },

    ["revive_player"] = {
        label = "Revive Mängija",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:Revive" },
        },
    },

    ["revive_radius"] = {
        label = "Revive Raadius",
        type = "server",
        event = "yh-admin:server:ReviveRadius",
        perms = "mod",
    },

  -- ["refuel_vehicle"] = {
  --     label = "Refuel Vehicle",
  --     type = "client",
  --     event = "yh-admin:client:RefuelVehicle",
  --     perms = "mod",
  -- },

    ["set_job"] = {
        label = "Määra Töö",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Töö",     option = "dropdown", data = "jobs" },
            { label = "Aste",   option = "text",     data = "grades" },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:SetJob" },
        },
    },

    ["set_gang"] = {
        label = "Määra Grupeering",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Grupeering",    option = "dropdown", data = "gangs" },
            { label = "Aste",   option = "text",     data = "grades" },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:SetGang" },
        },
    },

    ["give_money"] = {
        label = "Lisa Raha",
        perms = "admin",
        dropdown = {
            { label = "Mängija", option = "dropdown", data = "players" },
            { label = "Summa", option = "text" },
            {
                label = "Tüüp",
                option = "dropdown",
                data = {
                    { label = "Sularaha",   value = "cash" },
                    { label = "Pank",   value = "bank" },
                    { label = "Crypto", value = "crypto" },
                },
            },
            { label = "Kinnita", option = "button", type = "server", event = "yh-admin:server:GiveMoney" },
        },
    },

    ["give_money_all"] = {
        label = "Lisa Raha (Kõik)",
        perms = "admin",
        dropdown = {
            { label = "Summa",  option = "text" },
            {
                label = "Tüüp",
                option = "dropdown",
                data = {
                    { label = "Sularaha",   value = "cash" },
                    { label = "Pank",   value = "bank" },
                    { label = "Crypto", value = "crypto" },
                },
            },
            { label = "Kinnita", option = "button", type = "server", event = "yh-admin:server:GiveMoneyAll" },
        },
    },

    ["remove_money"] = {
        label = "Eemalda Raha",
        perms = "admin",
        dropdown = {
            { label = "Mängija", option = "dropdown", data = "players" },
            { label = "Summa", option = "text" },
            {
                label = "Tüüp",
                option = "dropdown",
                data = {
                    { label = "Sularaha", value = "cash" },
                    { label = "Pank", value = "bank" },
                },
            },
            { label = "Kinnita", option = "button", type = "server", event = "yh-admin:server:TakeMoney" },
        },
    },

    ["give_item"] = {
        label = "Lisa Item",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Item",    option = "dropdown", data = "items" },
            { label = "Kogus",  option = "text" },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:GiveItem" },
        },
    },

    ["give_item_all"] = {
        label = "Lisa Item (Kõik)",
        perms = "mod",
        dropdown = {
            { label = "Item",    option = "dropdown", data = "items" },
            { label = "Kogus",  option = "text" },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:GiveItemAll" },
        },
    },

    ["spawn_vehicle"] = {
        label = "Spawni Sõiduk",
        perms = "mod",
        dropdown = {
            { label = "Sõiduk", option = "dropdown", data = "vehicles" },
            { label = "Kinnita", option = "button",   type = "client",  event = "yh-admin:client:SpawnVehicle" },
        },
    },

    ["fix_vehicle"] = {
        label = "Elusta Hobune",
        type = "command",
        event = "fix",
        perms = "mod",
    },

    ["fix_vehicle_for"] = {
        label = "Elusta Hobune (Mängija)",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:FixVehFor" },
        },
    },

    ["spectate_player"] = {
        label = "Spectate",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:SpectateTarget" },
        },
    },

    ["telport_to_player"] = {
        label = "Teleporteeru (Mängija)",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:TeleportToPlayer" },
        },
    },

    ["telport_to_coords"] = {
        label = "Teleporteeru (Koordinaadid)",
        perms = "mod",
        dropdown = {
            { label = "Koordinaadid",  option = "text" },
            { label = "Kinnita", option = "button", type = "client", event = "yh-admin:client:TeleportToCoords" },
        },
    },

    ["teleport_to_location"] = {
        label = "Teleporteeru (Asukoht)",
        perms = "mod",
        dropdown = {
            { label = "Asukoht", option = "dropdown", data = "locations" },
            { label = "Kinnita",  option = "button",   type = "client",   event = "yh-admin:client:TeleportToLocation" },
        },
    },

    ["teleport_to_marker"] = {
        label = "Teleporteeru (Marker)",
        type = "command",
        event = "tpm",
        perms = "mod",
    },

    ["teleport_back"] = {
        label = "Teleporteeru (Tagasi)",
        type = "client",
        event = "yh-admin:client:TeleportBack",
        perms = "mod",
    },

   -- ["vehicle_dev"] = {
   --     label = "Vehicle Dev Menu",
   --     type = "client",
   --     event = "yh-admin:client:ToggleVehDevMenu",
   --     perms = "mod",
   -- },

    ["toggle_coords"] = {
        label = "Näita Koordinaate",
        type = "client",
        event = "yh-admin:client:ToggleCoords",
        perms = "mod",
    },

    ["toggle_blips"] = {
        label = "Näita Blipe",
        type = "client",
        event = "yh-admin:client:toggleBlips",
        perms = "mod",
    },

    ["toggle_names"] = {
        label = "Näita Nimesid",
        type = "client",
        event = "yh-admin:client:toggleNames",
        perms = "mod",
    },

  -- ["toggle_cuffs"] = {
  --     label = "Pane Rauad",
  --     perms = "mod",
  --     dropdown = {
  --         { label = "Mängija",  option = "dropdown", data = "players" },
  --         { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:CuffPlayer" },
  --     },
  -- },

   --["max_mods"] = {
   --    label = "Max Vehicle Mods",
   --    type = "client",
   --    event = "yh-admin:client:maxmodVehicle",
   --    perms = "mod",
   --},

    ["warn_player"] = {
        label = "Lisa Hoiatus",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Põhjus",  option = "text" },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:WarnPlayer" },
        },
    },

    -- ["infinite_ammo"] = {
    --     label = "Infinite Ammo",
    --     type = "client",
    --     event = "yh-admin:client:setInfiniteAmmo",
    --     perms = "mod",
    -- },

    ["kick_player"] = {
        label = "Kick",
        perms = "mod",
        dropdown = {
            { label = "Mängija",  option = "dropdown", data = "players" },
            { label = "Põhjus",  option = "text" },
            { label = "Kinnita", option = "button",   type = "server", event = "yh-admin:server:KickPlayer" },
        },
    },


    ["play_sound"] = {
        label = "Mängi Heli",
        perms = "mod",
        dropdown = {
            { label = "Mängija",     option = "dropdown", data = "players" },
            {
                label = "Heli",
                option = "dropdown",
                data = {
                    { label = "Alert",      value = "alert" },
                    { label = "Cuff",       value = "cuff" },
                    { label = "Air Wrench", value = "airwrench" },
                },
            },
            { label = "Mängi", option = "button",   type = "client", event = "yh-admin:client:PlaySound" },
        },
    },
}

Config.PlayerActions = {
    ["teleportToPlayer"] = {
        label = "Mine",
        type = "server",
        event = "yh-admin:server:TeleportToPlayer",
        perms = "mod",
    },
    ["bringPlayer"] = {
        label = "Too",
        type = "server",
        event = "yh-admin:server:BringPlayer",
        perms = "mod",
    },
    ["revivePlayer"] = {
        label = "Revive",
        event = "yh-admin:server:Revive",
        perms = "mod",
        type = "server"
    },
    ["spawnPersonalVehicle"] = {
        label = "Spawn Personal Vehicle",
        event = "yh-admin:server:SpawnPersonalVehicle",
        perms = "mod",
        type = "client"
    },
    ["banPlayer"] = {
        label = "Ban",
        event = "yh-admin:server:BanPlayer",
        perms = "mod",
        type = "server"
    },
    ["kickPlayer"] = {
        label = "Kick",
        event = "yh-admin:server:KickPlayer",
        perms = "mod",
        type = "server"
    }
}

Config.OtherActions = {
    ["toggleDevmode"] = {
        type = "client",
        event = "yh-admin:client:ToggleDev",
        perms = "admin",
        label = "Toggle Devmode"
    }
}

AddEventHandler("onResourceStart", function()
    Wait(100)
    if GetResourceState('ox_inventory') == 'started' then
        Config.Inventory = 'ox_inventory'
    elseif GetResourceState('ps-inventory') == 'started' then
        Config.Inventory = 'ps-inventory'
    elseif GetResourceState('lj-inventory') == 'started' then
        Config.Inventory = 'lj-inventory'
    elseif GetResourceState('yh-inventory') == 'started' then
        Config.Inventory = 'yh-inventory'
    end
end)
