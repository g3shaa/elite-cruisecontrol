local cruiseEnabled = false

if Config.Speed  == "km" then
    speed = 3.6
else
    speed = 2.237
end

if Config.Command then
    RegisterNetEvent('elite-cc:cruiserCar')
    AddEventHandler('elite-cc:cruiserCar', function(cruiserSpeed, cruiserNotification)
        local ped = PlayerPedId() -- Ped
        local inVehicle = IsPedSittingInAnyVehicle(ped) -- Get if ped is in any vehicle
        local vehicle = GetVehiclePedIsIn(ped, false) -- Get Vehicle In

        Wait(250)

        if not inVehicle then
            return exports['mythic_notify']:DoLongHudText('error', 'Трябва да бъдеш в ППС!')
        end

        if not (GetPedInVehicleSeat(vehicle, -1) == ped ) then
            return exports['mythic_notify']:DoLongHudText('error', 'Трябва да бъдеш шофьор!')
        end

        SetEntityMaxSpeed(vehicle, cruiserSpeed)
        cruiseEnabled = true
        exports['mythic_notify']:DoLongHudText('inform', 'Ограничителят е стартиран!')
     
    end)

    RegisterCommand(Config.OffCruiseCommand, function()
        local ped = PlayerPedId() -- Ped
        local inVehicle = IsPedSittingInAnyVehicle(ped) -- Get if ped is in any vehicle
        local vehicle = GetVehiclePedIsIn(ped, false) -- Get Vehicle In
        local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel") -- Get max speed to reset

        Wait(250)

        if not inVehicle then
            return exports['mythic_notify']:DoLongHudText('error', 'Трябва да бъдеш в ППС!')
        end

        if not (GetPedInVehicleSeat(vehicle, -1) == ped ) then
            return exports['mythic_notify']:DoLongHudText('error', 'Трябва да бъдеш шофьор!')
        end
        
        SetEntityMaxSpeed(vehicle, maxSpeed)
        cruiseEnabled = false
        exports['mythic_notify']:DoLongHudText('inform', 'Ограничителят е спрян!')
    end)
end
RegisterKeyMapping(Config.OffCruiseCommand, 'Deactivate cruiser', 'keyboard', Config.KeyBindOff)

if Config.KeyMap then

    RegisterCommand("+activatecruiser", function()
        local ped = PlayerPedId() -- Ped
        local inVehicle = IsPedSittingInAnyVehicle(ped) -- Get if ped is in any vehicle
        local vehicle = GetVehiclePedIsIn(ped, false) -- Get Vehicle In
        local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel") -- Get max speed to reset
        local cruiserSpeed = GetEntitySpeed(vehicle) -- Get the current speed

        Wait(250)

        if not inVehicle then
            return
        end

        if not (GetPedInVehicleSeat(vehicle, -1) == ped ) then
            return
        end

        if not cruiseEnabled then
            SetEntityMaxSpeed(vehicle, cruiserSpeed)
            cruiserNotification = math.floor(cruiserSpeed * speed + 0.5)
            cruiseEnabled = true
            exports['mythic_notify']:DoLongHudText('inform', 'Ограничителят е стартиран!')
        else
            SetEntityMaxSpeed(vehicle, maxSpeed)
            cruiseEnabled = false
            exports['mythic_notify']:DoLongHudText('inform', 'Ограничителят е спрян!')
        end
    end)

    RegisterKeyMapping('+activatecruiser', 'Activate cruiser', 'keyboard', Config.KeyBind)

end

RegisterNetEvent('elite-cc:Notify')
AddEventHandler('elite-cc:Notify', function(msg)
    SetTextFont(0)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringPlayerName(msg)
    DrawNotification(false, true)
end)
