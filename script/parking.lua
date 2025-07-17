local scootercoords = {
{{2367.60767, 352.75275, 6.08523, 350.128845214844, 0}, {2359.28027, 349.09106, 6.08523, 80.2682418823242, 0}},
{{724.46753, 7.94102, 6.03774, 14.0054225921631, 0}, {727.96002, -2.42726, 5.92648, 285.13134765625, 0}},
{{-349.26151, -628.40253, 4.94041, 300.574890136719, 0}, {-360.9812, -625.45862, 4.79059, 207.627029418945, 0}}
}
local scooterblip = {}
local scooter = nil
CreateThread(function()
	while true do
		Wait(0)
		for i=1,#scootercoords,1 do
			if(not DoesBlipExist(scooterblip[i])) then
				scooterblip[i] = AddBlipForCoord(scootercoords[i][1][1], scootercoords[i][1][2], scootercoords[i][1][3])
				ChangeBlipSprite(scooterblip[i], 79)
				ChangeBlipColour(scooterblip[i], 2)
				ChangeBlipNameFromAscii(scooterblip[i], "Scooter rent")
				SetBlipAsShortRange(scooterblip[i], true)
			end
			DrawCheckpointWithDist(scootercoords[i][1][1], scootercoords[i][1][2], scootercoords[i][1][3]-1, 1.1, 255, 3, 30, 100)
			DrawTextAtCoord(scootercoords[i][1][1], scootercoords[i][1][2], scootercoords[i][1][3], "Scooter_rent", 20)
			if(IsPlayerNearCoords(scootercoords[i][1][1], scootercoords[i][1][2], scootercoords[i][1][3], 1)) then
				PrintText("Press ~y~E ~w~to ~y~rent a scooter ~w~for ~g~30$", 1)
				if(IsGameKeyboardKeyJustPressed(18)) then
					if(inventory[34] >= 30) then
						RemoveItem(34, 30)
						SaveStats()
						DeleteCar(scooter)
						scooter = SpawnCar(GetHashKey("faggio"), scootercoords[i][2][1], scootercoords[i][2][2], scootercoords[i][2][3], scootercoords[i][2][4])
						--AllowVeh(scooter)
						WarpCharIntoCar(GetPlayerChar(-1), scooter)
						Notify("Scooter rented.")
					else
						Notify("You do not have enough money.")
					end
				end
			end
		end
	end
end)

local parkcoords = {
{77.81879, 1136.23767, 2.91673, 180.148788452148, 0},
{-674.51215, 471.7453, 21.6383, 178.994079589844, 0},
{-987.90167, 1405.23193, 25.68967, 359.592956542969, 0},
{2255.20044, 377.797, 7.49959, 269.999328613281, 0},
{1139.75403, 138.98798, 32.93008, 89.5817260742188, 0},
{1135.30762, 566.11456, 32.45714, 271.084716796875, 0},
{1760.18433, 405.69009, 25.41919, 89.9305038452148, 0},
{460.47888, 1738.85339, 15.80869, 233.583480834961, 0},
{1.39831, -191.8354, 14.53183, 0.116277135908604, 0},
{-533.2251, 1127.85449, 9.98309, 358.571685791016, 0},
{-594.87897, -97.80893, 6.43994, 177.629516601563, 0},
{185.79355, 175.86176, 14.76956, 179.677947998047, 0},
{-1424.78125, 621.49609, 19.57296, 106.875793457031, 0},
{-1865.62903, 158.94798, 15.01166, 277.306518554688, 0}
}
local selectedCarModel = nil
local spawnedCars = {}
local parkblip = {}

CreateThread(function()
    while true do
        Wait(0)
        for i = 1, #parkcoords, 1 do
            if (not DoesBlipExist(parkblip[i])) then
                parkblip[i] = AddBlipForCoord(parkcoords[i][1], parkcoords[i][2], parkcoords[i][3])
                ChangeBlipSprite(parkblip[i], 79)
                ChangeBlipScale(parkblip[i], 0.7)
                ChangeBlipNameFromAscii(parkblip[i], "Garage")
                SetBlipAsShortRange(parkblip[i], true)
            end

            DrawCheckpointWithDist(parkcoords[i][1], parkcoords[i][2], parkcoords[i][3] - 1.5, 1.5, 255, 3, 30, 100)
            Draw3dMark("garage", parkcoords[i][1], parkcoords[i][2], parkcoords[i][3], 4.0)

            if (not IsCharInAnyCar(GetPlayerChar(-1))) then
                if (IsPlayerNearCoords(parkcoords[i][1], parkcoords[i][2], parkcoords[i][3], 1)) then
                    if (IsGameKeyboardKeyJustPressed(18)) then
                        if (inventory[34] >= 10) then
                            local tempitems = {}
                            local tempids = {}

                            for j = 1, #carinfo, 1 do
                                if (cars[j] == 1) then
                                    tempitems[#tempitems + 1] = carinfo[j][1]
                                    tempids[#tempids + 1] = j
                                end
                            end

                            DrawWindow("Parking", tempitems)

                            while menuactive do
                                Wait(0)
                            end

                            if (menuresult > 0) then
                                local tempcarid = 0
                                for j = 1, #carinfo, 1 do
                                    if (carinfo[j][1] == tempitems[menuresult]) then
                                        tempcarid = j
                                    end
                                end
                                if selectedCarModel == nil or selectedCarModel ~= carinfo[tempcarid][3] then
                                    -- Check if the car has already been spawned
                                    carAlreadySpawned = false
                                    for k, spawnedCar in ipairs(spawnedCars) do
                                        if spawnedCar == carinfo[tempcarid][3] then
                                            carAlreadySpawned = true
                                            break
                                        end
                                    end
    
                                    if not carAlreadySpawned then
                                        if (not DoesVehicleExist(carinfo[tempcarid][3])) then
                                           
                                            RemoveItem(34, 10)
                                            SaveStats()
                                            car = SpawnCar(carinfo[tempcarid][3], parkcoords[i][1], parkcoords[i][2], parkcoords[i][3], parkcoords[i][4])
                                            SetVehicleTuning(car)
                                            
                                            WarpCharIntoCar(GetPlayerChar(-1), car)
                                            Notify("You have paid for parking service.")

                                            selectedCarModel = carinfo[tempcarid][3]

                                            -- Add the spawned car to the list
                                            table.insert(spawnedCars, selectedCarModel)
                                        end
                                    else
                                        TriggerEvent("noticeme:Info", "This car is already spawned.")
                                    end
                                else
                                    TriggerEvent("noticeme:Info", "This car is already spawned.")
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

function CarAlreadySpawned(carModel)
    for _, spawnedCar in ipairs(spawnedCars) do
        if spawnedCar == carModel then
            return true
        end
    end
    return false
end
