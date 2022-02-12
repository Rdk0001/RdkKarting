ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-------------- Position ----------------- 

ConfHs0              = {}
ConfHs0.DrawDistance = 100
ConfHs0.Size         = {x = 1.0, y = 1.0, z = 1.0}
ConfHs0.Color        = {r = 255, g = 255, b = 255}
ConfHs0.Type         = 29

local position = {
        {x = -146.65,   y = -961.43,  z = 269.14 },       
}  

------------------ Menu --------------------

RMenu.Add('rkarting', 'main', RageUI.CreateMenu("karting", "Menu Course"))
RMenu.Add('rkarting', 'vehicule', RageUI.CreateSubMenu(RMenu:Get('rkarting', 'main'), "Karting", "Menu Karting"))
RMenu.Add('rkarting', 'rvehicule', RageUI.CreateSubMenu(RMenu:Get('rkarting', 'main'), "Karting", "Menu Karting"))
RMenu:Get('rkarting', 'main'):SetRectangleBanner(0,0,0,0)

Citizen.CreateThread(function()
    while true do 

        RageUI.IsVisible(RMenu:Get('rkarting', 'main'), true, true, true, function()

            RageUI.Button("~r~Menu Karting", nil, {RightLabel = "---"},true, function() 
            end, RMenu:Get('rkarting', 'vehicule'))

        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('rkarting', 'vehicule'), true, true, true, function()

        RageUI.Button("KartJunior", nil, {RightLabel = "1500$"},true, function(Hovered, Active, Selected)
            if (Selected) then
                TriggerServerEvent('rdk:karting', 1500)
                SpawnCar('kart')
                RageUI.CloseAll()
            end
        end)

        RageUI.Button("KartAdulte", nil, {RightLabel = "2500$"},true, function(Hovered, Active, Selected)
            if (Selected) then
                TriggerServerEvent('rdk:karting', 2500)
                SpawnCar('kart3')
                RageUI.CloseAll()
            end
        end)


    end, function()
    end)

        Citizen.Wait(0)
    end
end) 



------------------------ Sous Menu --------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accÃ©der Ã  la location de karting.")
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('rkarting', 'main'), not RageUI.Visible(RMenu:Get('rkarting', 'main')))
                end   
            end
        end
    end
end)



SpawnCar = function(Value)
    local model = GetHashKey(Value)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(10)
    end
    local pos = GetEntityCoords(PlayerPedId())
    local vehicle = CreateVehicle(model, pos, 0.0, true, true)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
end