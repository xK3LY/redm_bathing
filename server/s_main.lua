BathingSessions = {}

Citizen.CreateThread(function() --// link own callback system
    --[[RegisterServerCallback("rdr-bathing:canEnterBath", function(source, cb, town)
        local player = GetPlayerFromId(source)
        
        if not BathingSessions[town] then
            if player.getAccountMoney("money") >= Globals.Price then
                player.removeAccountMoney("money", Globals.Price)

                BathingSessions[town] = source

                cb(true)
                return
            else
                player.postToastNotification("bath_house", "Nie stać cię panoćku na kąpiel w naszej łaźni!", "")
            end
        else 
            player.postToastNotification("bath_house", "Łaźnia jest zajęta!", "Wróć za jakiś czas.")
        end

        cb(false)
    end)

    RegisterServerCallback("rdr-bathing:canBuyDeluxeBath", function(source, cb, town)
        if BathingSessions[town] == source then
            local player = GetPlayerFromId(source)

            if player.getAccountMoney("money") >= Globals.Deluxe then
                player.removeAccountMoney("money", Globals.Deluxe)

                cb(true)
                return
            else
                player.postToastNotification("bath_house", "Nie stać cię panoćku na luksusową kąpiel!", "")
            end
        end

        cb(false)
    end)]]

    RegisterServerEvent("rdr-bathing:setBathAsFree")
    AddEventHandler("rdr-bathing:setBathAsFree", function(town)
        if BathingSessions[town] == source then
            BathingSessions[town] = nil
        end
    end)

    AddEventHandler('playerDropped', function()
        for town,player in pairs(BathingSessions) do
            if player == source then
                BathingSessions[town] = nil
            end
        end	 
    end)    
end)

