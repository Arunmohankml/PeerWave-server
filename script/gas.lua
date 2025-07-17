carsfuel = {}
fuelcar = 10
local tempcar = 0
CreateThread(function()
	while true do
		Wait(0)
		if(not IsCarDead(car)) then
			for j=1,#carinfo,1 do
				--if(GetCarModel(car, _i) == carmodels[j]) then
				if(IsCarModel(car, carinfo[j][3])) then
					tempcar = j
				end
			end
		end
	end
end)

fuel = {}
for i=1,#carinfo,1 do
	fuel[i] = 100
end

RegisterNetEvent('updFuel')
AddEventHandler('updFuel', function(data)
	for i=1,#carinfo,1 do
		if(data[i] == nil) then
			data[i] = 100
		end
		fuel[i] = tonumber(data[i])
	end
end)

SaveFuel = function()
	local data = {}
	for i=1,#fuel,1 do
		data[i] = fuel[i]
	end
	TriggerServerEvent('saveFuel', data)
end

RegisterNetEvent('baseevents:enteredVehicle')
AddEventHandler('baseevents:enteredVehicle', function(veh, vehseat, vehname)
	if(veh ~= car) then
		if(vehseat == -1) then
			if carsfuel[veh] then
				fuelcar = carsfuel[veh]
			else
				fuelcar = 100 --GenerateRandomIntInRange(0, 101)
			end
		end
	else
		for i=1,#carinfo,1 do
			--if(GetCarModel(veh) == carinfo[i][3]) then
			if(IsCarModel(veh, carinfo[i][3])) then
				tempcar = i
				break
			end
		end
	end
end)
RegisterNetEvent('baseevents:leftVehicle')
AddEventHandler('baseevents:leftVehicle', function(veh, vehseat, vehname)
	if(veh ~= car) then
		if(vehseat == -1) then
			carsfuel[veh] = fuelcar
		end
	else
		carsfuel[veh] = fuel[tempcar]
		tempcar = 0
	end
end)



local showmenu2 = 0

CreateThread(function()
	while true do
		Wait(0)
		local playerx, playery, playerz = GetCharCoordinates(GetPlayerChar(-1))
		local closestcar = GetClosestCar(playerx, playery, playerz, 3.0, false, 70)
		if(DoesVehicleExist(closestcar)) then
			if(inventory[5] > 0) then
				if IsPedHoldingAnObject(GetPlayerChar(-1)) then
					if(IsGameKeyboardKeyPressed(IntractionKey2)) then
						showmenu2 = 1
						cursor = 1
						SetCamActive(GetGameCam(), false)
						SetPlayerControl(GetPlayerId(),false)
						FreezeCharPosition(GetPlayerChar(-1), true)
					else
						if(showmenu2 == 1) then
							cursor = 0
							showmenu2 = 0
							SetCamActive(GetGameCam(), true)
							SetPlayerControl(GetPlayerId(), true)
							FreezeCharPosition(GetPlayerChar(-1), false)
						end
					end
				end

				if(showmenu2 == 1) then
					cursor = 1
					if(IsCursorInArea(0.5, 0.52, 0.05,  0.05)) then
						if(IsMouseButtonJustPressed(1)) then
							
							cursor = 0
							showmenu2 = 0
							if(closestcar ~= car) then
								RequestAnims("mini_golf")
								while not HaveAnimsLoaded("mini_golf") do Citizen.Wait(0) end
								TaskPlayAnimNonInterruptable(GetPlayerChar(-1), "putt_limber", "mini_golf", 9.9, 1, 0, 0, 0, -1)

								SetPlayerControl(GetPlayerId(), false)
								FreezeCarPosition(closestcar, true)
								PrintStringWithLiteralStringNow("STRING", "Refilling", 5000, 1)
								Wait(5000)
								FreezeCarPosition(closestcar, false)
								SetPlayerControl(GetPlayerId(), true)
								SetCamActive(GetGameCam(), true)
								ClearCharTasksImmediately(GetPlayerChar(-1))
								FreezeCharPosition(GetPlayerChar(-1), false)
								RemoveItem(5, 1)
								carsfuel[closestcar] = carsfuel[closestcar] + 100-carsfuel[closestcar]
								TriggerEvent("noticeme:Info", "Petrol tank has been filled.")
							else
								RequestAnims("mini_golf")
								while not HaveAnimsLoaded("mini_golf") do Citizen.Wait(0) end
								TaskPlayAnimNonInterruptable(GetPlayerChar(-1), "putt_limber", "mini_golf", 9.9, 1, 0, 0, 0, -1)

								SetPlayerControl(GetPlayerId(), false)
								FreezeCarPosition(closestcar, true)
								PrintStringWithLiteralStringNow("STRING", "Refilling", 20000, 1)
								Wait(20000)
								SetCamActive(GetGameCam(), true)
								SetPlayerControl(GetPlayerId(), true)
								FreezeCarPosition(closestcar, false)
								FreezeCharPosition(GetPlayerChar(-1), false)
								ClearCharTasksImmediately(GetPlayerChar(-1))
								RemoveItem(5,1)
								local tempcar = 0
								for j=1,#carinfo,1 do
									if(IsCarModel(car, carinfo[j][3])) then
										tempcar = j
									end
								end
								fuel[tempcar] = fuel[tempcar] + 100-fuel[tempcar]
								SaveFuel()
								TriggerEvent("noticeme:Info", "Petrol tank has been filled.")
									
							end
						end
						SetTextScale(0.15,  0.25)
						SetTextDropshadow(0, 0, 0, 0, 0)
						SetTextFont(6)
						SetTextCentre(1)
						SetTextColour(20, 167, 245, 255)
						DisplayTextWithLiteralString(0.5, 0.52, "STRING", "Refill vehicle")	
					else
						SetTextScale(0.15,  0.25)
						SetTextDropshadow(0, 0, 0, 0, 0)
						SetTextFont(6)
						SetTextCentre(1)
						DisplayTextWithLiteralString(0.5, 0.52, "STRING", "Refill vehicle")	
					end
					RequestStreamedTxd("rpg")
					while not HasStreamedTxdLoaded("rpg") do
						Citizen.Wait(0)
					end
					local eye = GetTextureFromStreamedTxd("rpg", "eye")
					DrawSprite(eye, 0.5, 0.5, 0.040-0.020, 0.070-0.033, 0.0, 255, 255, 255, 255)
				
				end
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if(IsCharInAnyCar(GetPlayerChar(-1))) then
			local veh = GetCarCharIsUsing(GetPlayerChar(-1))
			if(GetDriverOfCar(veh) == GetPlayerChar(-1)) then
				local revs = GetVehicleEngineRevs(veh)
				if(veh ~= car) then
					if(IsPedInAnyLandVehicle(GetPlayerChar(-1))) then
						if(fuelcar > 0) then
							SetCarEngineOn(veh, 1, 1)
							if(revs > 0) then
								Wait(20000)
								if(IsPedInAnyLandVehicle(GetPlayerChar(-1))) then
									fuelcar = fuelcar - 2
								end
							end
						else
							SetCarEngineOn(veh, 0, 0)
						end
					end
				else
					if(tempcar > 0) then
						if(fuel[tempcar] > 0) then
							SetCarEngineOn(veh, 1, 1)
							if(revs > 0) then
								Wait(20000)
								if(IsCharInCar(GetPlayerChar(-1), car)) then
									fuel[tempcar] = fuel[tempcar] - 2
									SaveFuel()
								end
							end
						else
							SetCarEngineOn(veh, 0, 0)
						end
					end
				end
			end
		end
	end
end)

local bcoords = {
	{-1312.11328, 1730.78918, 27.82466, 97.0201721191406, 0},
	{-1390.94519, 29.40539, 6.96513, 53.3830032348633, 0},
	{-479.81433, -209.56621, 7.74891, 358.612426757813, 0},
	{-434.97906, -19.2604, 9.86399, 356.993377685547, 0},
	{108.74281, 1136.07043, 14.55841, 357.800384521484, 0},
	{777.59363, 196.44286, 6.02478, 198.003829956055, 0},
	{1453.87488, 1715.87488, 16.69322, 90.9029846191406, 0},
	{1775.6377, 836.24701, 16.43755, 343.682891845703, 0},
	{1123.9126, 329.35464, 29.81937, 345.518463134766, 0},
	{1129.27161, -359.4668, 19.03772, 355.755126953125, 0}
}

local coords = {
	{-438.78421, -24.59453, 10.19909}, 
	{-438.78455, -13.58287, 10.21095}, 
	{-430.89029, -13.92258, 10.1797}, 
	{-430.88379, -24.57177, 10.19181}, 
	{-474.66205, -204.97464, 8.09233}, 
	{-474.65695, -214.00304, 8.04981}, 
	{-483.75958, -205.08025, 7.98433}, 
	{-483.76282, -213.92229, 7.98448}, 
	{-1397.22205, 28.10535, 7.11378}, 
	{-1388.99231, 22.96265, 7.1133}, 
	{-1384.93506, 29.85995, 7.10142}, 
	{-1392.97607, 34.8861, 7.10916}, 
	{-1314.93311, 1735.86658, 27.92624}, 
	{-1310.54639, 1735.86267, 27.92621}, 
	{104.68605, 1130.80225, 14.88685}, 
	{104.67955, 1141.47119, 14.87056}, 
	{112.54059, 1141.65491, 14.79432}, 
	{112.54043, 1130.82922, 14.80882}, 
	{1447.16711, 1719.24316, 16.90047}, 
	{1460.93323, 1719.29553, 16.90046}, 
	{1460.8949, 1712.36926, 16.86871}, 
	{1447.32031, 1712.36902, 16.90041}, 
	{1447.50256, 1703.93079, 16.89677}, 
	{1460.90588, 1703.93091, 16.89481}, 
	{1778.13147, 828.36316, 16.66709}, 
	{1781.92493, 841.16992, 16.64834}, 
	{1773.96118, 843.42334, 16.66098}, 
	{1770.19678, 830.71454, 16.66164}, 
	{1762.13586, 833.07214, 16.64448}, 
	{1765.93628, 845.90741, 16.64445}, 
	{1119.48682, 323.94992, 30.37441}, 
	{1121.78406, 336.50452, 29.85818}, 
	{1128.28101, 335.02072, 29.84543}, 
	{1126.2063, 322.34705, 29.85474}, 
	{773.98584, 193.54935, 6.17952}, 
	{773.10657, 196.91325, 6.18213}, 
	{1132.93835, -353.05405, 19.14395}, 
	{1125.69495, -352.90115, 19.00204}, 
	{1125.69568, -366.47354, 19.15306}, 
	{1132.93958, -366.72894, 19.32098}
}

local gasblip = {}
local biznames = {
"Ron #1",
"Globe Oil #1",
"Globe Oil #2",
"Ron #2",
"Terroil",
"Ron #3",
"Ron #4",
"Ron #5",
"Ron #6",
"Ron #7"
}
local showmenu = 0
CreateThread(function()
	while true do
		Wait(0)
		for i=1,#coords,1 do
			for i=1,#bcoords,1 do
				if(not DoesBlipExist(gasblip[i])) then
					gasblip[i] = AddBlipForCoord(bcoords[i][1], bcoords[i][2], bcoords[i][3])
					ChangeBlipSprite(gasblip[i], 61)
					ChangeBlipScale(gasblip[i], 0.7)
					--ChangeBlipColour(gasblip[i], 1)
					ChangeBlipNameFromAscii(gasblip[i], biznames[i])
					SetBlipAsShortRange(gasblip[i], true)
				end
			end
			local playerx, playery, playerz = GetCharCoordinates(GetPlayerChar(-1))
			local closestcar = GetClosestCar(playerx, playery, playerz, 5.0, false, 70)
			if(DoesVehicleExist(closestcar)) then
				if(IsPlayerNearCoords(coords[i][1], coords[i][2], coords[i][3], 3)) then
					DrawTextAtCoord(coords[i][1], coords[i][2], coords[i][3], "Hold~g~[Tab]", 5.0)
					if(not IsCharInAnyCar(GetPlayerChar(-1))) then

						if(IsGameKeyboardKeyPressed(IntractionKey2)) then
							showmenu = 1
							cursor = 1
							SetCamActive(GetGameCam(), false)
							SetPlayerControl(GetPlayerId(),false)
							FreezeCharPosition(GetPlayerChar(-1), true)
						else
							
							if(showmenu == 1) then
								cursor = 0
								showmenu = 0
								SetCamActive(GetGameCam(), true)
								SetPlayerControl(GetPlayerId(), true)
								FreezeCharPosition(GetPlayerChar(-1), false)
							end
						end
					end

					if(showmenu == 1) then
						cursor = 1
						if(IsCursorInArea(0.5, 0.53, 0.05,  0.05)) then
							SetTextScale(0.15+0.04,  0.25+0.04)
							--SetTextDropshadow(0, 0, 0, 0, 0)
							SetTextFont(6)
							SetTextCentre(1)
							SetTextColour(20, 167, 245, 255)
							DisplayTextWithLiteralString(0.5, 0.53, "STRING", "Refill vehicle")	
							
							if(IsMouseButtonJustPressed(1)) then
								cursor = 0
								showmenu = 0
								if(closestcar ~= car) then
									local fuelcash = 100
									if(fuelcash > 0) then
										if(inventory[34]>= fuelcash) then
		
											RequestAnims("mini_golf")
											while not HaveAnimsLoaded("mini_golf") do Citizen.Wait(0) end
											TaskPlayAnimNonInterruptable(GetPlayerChar(-1), "putt_limber", "mini_golf", 9.9, 1, 0, 0, 0, -1)
		
											SetPlayerControl(GetPlayerId(), false)
											--FreezeCarPosition(closestcar, true)
											PrintStringWithLiteralStringNow("STRING", "Refilling", 10000, 1)
											Wait(10000)
											--FreezeCarPosition(closestcar, false)	
											SetPlayerControl(GetPlayerId(), true)
											SetCamActive(GetGameCam(), true)
											ClearCharTasksImmediately(GetPlayerChar(-1))
											RemoveItem(34, fuelcash)
											FreezeCharPosition(GetPlayerChar(-1), false)
											carsfuel[closestcar] = 100
											TriggerEvent("noticeme:Info", "Petrol tank has been filled.")
										else
											TriggerEvent("noticeme:Info", "You dont have enough money to refuel")
										end
									else
										TriggerEvent("noticeme:Info", "The tank is full")
									end
								else
									local fuelcash = 100
									if(fuelcash > 0) then
										if(inventory[34]>= fuelcash) then
		
											RequestAnims("mini_golf")
											while not HaveAnimsLoaded("mini_golf") do Citizen.Wait(0) end
											TaskPlayAnimNonInterruptable(GetPlayerChar(-1), "putt_limber", "mini_golf", 9.9, 1, 0, 0, 0, -1)
		
											SetPlayerControl(GetPlayerId(), false)
											--FreezeCarPosition(GetCarCharIsUsing(GetPlayerChar(-1)), true)
											PrintStringWithLiteralStringNow("STRING", "Refilling", 10000, 1)
											Wait(10000)
											SetCamActive(GetGameCam(), true)
											FreezeCharPosition(GetPlayerChar(-1), false)
											SetPlayerControl(GetPlayerId(), true)
											--FreezeCarPosition(GetCarCharIsUsing(GetPlayerChar(-1)), false)
											ClearCharTasksImmediately(GetPlayerChar(-1))
											RemoveItem(34,fuelcash)
											--AddIncomeToBiz(biznames[i], fuelcash)
											local tempcar = 0
											for j=1,#carinfo,1 do
												if(IsCarModel(car, carinfo[j][3])) then
													tempcar = j
												end
											end
											fuel[tempcar] = 100
											SaveFuel()
											TriggerEvent("noticeme:Info", "Petrol tank has been filled.")
										else
											TriggerEvent("noticeme:Info", "You dont have enough money to refuel")
										end
									else
										TriggerEvent("noticeme:Info", "The tank is full")
									end
								end
							end

						elseif(IsCursorInArea(0.5, 0.57, 0.05,  0.05)) then
							SetTextScale(0.15+0.05,  0.25+0.05)
							--SetTextDropshadow(0, 0, 0, 0, 0)
							SetTextFont(6)
							SetTextCentre(1)
							SetTextColour(20, 167, 245, 255)
							DisplayTextWithLiteralString(0.5, 0.57, "STRING", "Buy fuel can")
							if(IsMouseButtonJustPressed(1)) then
								cursor = 0
								showmenu = 0
								if(inventory[34]>= 5000) then
									RemoveItem(34,5000)	
									inventory[5] = inventory[5] + 1
									TriggerEvent("noticeme:Info", "You brought a fuel can")
								else
									TriggerEvent("noticeme:Info", "You need 5000rs to buy a fuel can")
								end
							end
						end
						SetTextScale(0.15+0.04,  0.25+0.04)
						SetTextDropshadow(0, 0, 0, 0, 0)
						SetTextFont(6)
						SetTextCentre(1)
						DisplayTextWithLiteralString(0.5, 0.53, "STRING", "Refill vehicle")	

						SetTextScale(0.15+0.05,  0.25+0.05)
						SetTextDropshadow(0, 0, 0, 0, 0)
						SetTextFont(6)
						SetTextCentre(1)
						DisplayTextWithLiteralString(0.5, 0.57, "STRING", "Buy fuel can")	
						
						RequestStreamedTxd("rpg")
						while not HasStreamedTxdLoaded("rpg") do
							Citizen.Wait(0)
						end
						local eye = GetTextureFromStreamedTxd("rpg", "eye")
						DrawSprite(eye, 0.5, 0.5, 0.040-0.020, 0.070-0.033, 0.0, 255, 255, 255, 255)
					
					end
				end
			end
		end
	end
end)