ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('rdk:karting')
AddEventHandler('rdk:karting', function(Item, Prix)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    print(("%s %s"):format(Item, Prix))
    if xPlayer.getMoney() >= Prix then
        xPlayer.removeMoney(Prix)
        xPlayer.addInventoryItem(Item, 1)
        TriggerClientEvent('esx:showNotification', _src, "~g~Achats~w~ effectué !")
    else
        TriggerClientEvent('esx:showNotification', _src, "Vous n'avez assez ~r~d'argent")
    end
end)