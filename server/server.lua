if Config.Speed == "km" then
    Config.Speed = 3.6
else
    Config.Speed = 2.237
end

if Config.Command then
    RegisterCommand(Config.CruiseCommand, function(source, args)
        if tonumber(args[1]) then
            local cruiser = math.floor((args[1]) / Config.Speed) + 0.5
            TriggerClientEvent('elite-cc:cruiserCar', source, cruiser, args[1])
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'ПРАВИЛЕН СИНТАКСИС: /cc <50 КМ>', style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
        end
    end)
end


