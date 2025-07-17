local mainjobblip = nil
local jobblip = nil
local towtruck = nil
local client = nil
local clientveh = nil
local tempdist = 0

local orders = {}
RegisterNetEvent('addMechOrder')
AddEventHandler('addMechOrder', function(id, x, y, z)
	for i=1,#orders,1 do
		if(orders[i][1] == id) then
			orders[i] = {id, x, y, z}
			goto skip
		end
	end
	orders[#orders+1] = {id, x, y, z}
	::skip::
	if(not IsCarDead(towtruck)) then
		Notify('New order has been added to the list.')
	end
end)
RegisterNetEvent('removeMechOrder')
AddEventHandler('removeMechOrder', function(id)
	for i=1,#orders,1 do
		if(orders[i][1] == id) then
			orders = RemoveFromTable(orders, i)
			break
		end
	end
	if(GetPlayerFromServerId(id) == PlayerId()) then
		Notify('Your mechanic request has been accepted. Please wait where you at for a mechanic.')
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		for i=1,#orders,1 do
			if(not IsNetworkPlayerActive(GetPlayerFromServerId(orders[i][1]))) then
				orders = RemoveFromTable(orders, i)
				break
			end
		end
		if(not DoesBlipExist(mainjobblip)) then
			mainjobblip = AddBlipForCoord(1790.28601, 192.92586, 21.09238)
			ChangeBlipSprite(mainjobblip, 75)
			ChangeBlipColour(mainjobblip, 19)
			ChangeBlipNameFromAscii(mainjobblip, "Mechanic")
			SetBlipAsShortRange(mainjobblip, true)
			ChangeBlipScale(mainjobblip, 0.7)
		end
		DrawCheckpointWithDist(1790.28601, 192.92586, 21.09238-1, 1.1, 255, 3, 30, 100)
		DrawTextAtCoord(1790.28601, 192.92586, 21.09238, "Mechanic", 20)
		if(IsPlayerNearCoords(1790.28601, 192.92586, 21.09238, 1)) then
			if(level ~= 2) then
				if(driverlicense ~= 1) then
					if(IsCarDead(towtruck)) then
						PrintText("Press ~y~E ~w~to rent a tow truck for ~g~100$", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							if(currjob == "") then
								if(inventory[34] ~= 100) then
									currjob = "Mechanic"
									RemoveItem(34, 100)
									SaveStats()
									DeleteCar(towtruck)
									towtruck = SpawnCar(GetHashKey("admiral"), 1794.40442, 195.04117, 21.09238, 154.731033325195)
									--AllowVeh(towtruck)
									WarpCharIntoCar(GetPlayerChar(-1), towtruck)
									Notify('Mechanic job has been started. Use X button to open mechanic menu and select a client.')
								else
									Notify('You do not have enough money.')
								end
							else
								Notify("You are currently working at another job. Finish it before starting this one.")
							end
						end
					else
						PrintText("Press ~y~E ~w~to finish mechanic job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							currjob = ""
							RemoveBlip(jobblip)
							DeleteCar(towtruck)
							Notify('Mechanic job has been finished.')
						end
					end
				else
					PrintText("You must have a driver license for this job", 1)
				end
			else
				PrintText("You must reach level 2 to start this job", 1)
			end
		end
		if(DoesVehicleExist(towtruck)) then
			if(not IsCarDead(towtruck)) then
				if(IsCharInCar(GetPlayerChar(-1), towtruck)) then
					if(IsGameKeyboardKeyJustPressed(JobKey)) then
						if(not DoesBlipExist(jobblip)) then
							local tempitems = {}
							for i=1,#orders,1 do
								local streetname = GetStreetAtCoord(orders[i][2], orders[i][3], orders[i][4])
								local px,py,pz = GetCharCoords(GetPlayerChar(-1))
								local dist = GetDistanceBetweenCoords3d(px, py, pz, orders[i][2], orders[i][3], orders[i][4])
								tempitems[i] = streetname .. " (" .. math.floor(dist) .. "m)"
							end
							tempitems[#tempitems+1] = "Get random order"
							DrawWindow("Order list", tempitems)
							while menuactive do
								Wait(0)
							end
							if(menuresult > 0) then
								if(tempitems[menuresult] == "Get random order") then
									DeleteChar(client)
									local rx,ry,rz,rh = GetRandomNodeInRadius(GenerateRandomIntInRange(1000, 5000))
									client = SpawnRandomPed(rx, ry, rz, rh)
									clientveh = SpawnCar(carinfo[GenerateRandomIntInRange(1, #carinfo+1)][3], rx, ry, rz, rh)
									jobblip = AddBlipForCar(clientveh)
									SetRoute(jobblip, true)
									local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
									tempdist = GetDistanceBetweenCoords3d(px, py, pz, rx, ry, rz)
								else
									local order = orders[menuresult]
									jobblip = AddBlipForCoord(orders[menuresult][2], orders[menuresult][3], orders[menuresult][4])
									SetRoute(jobblip, true)
									TriggerServerEvent('removeMechOrder', orders[menuresult][1])
								end
							end
						else
							DrawWindow("Order list", {"Cancel current order"})
							while menuactive do
								Wait(0)
							end
							if(menuresult == 1) then
								RemoveBlip(jobblip)
								DeleteChar(client)
								DeleteCar(clientveh)
							end
						end
					end
					if(DoesBlipExist(jobblip)) then
						if(not DoesCharExist(client)) then
							local bp = GetBlipCoords(jobblip)
							DrawCheckpoint(bp.x, bp.y, bp.z-1, 1.1, 255, 3, 30, 100)
							if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 10)) then
								RemoveBlip(jobblip)
							end
						end
					end
					if(DoesVehicleExist(clientveh)) then
						local cx,cy,cz = GetCarCoordinates(clientveh)
						if(IsPlayerNearCoords(cx, cy, cz, 5)) then
							PrintText("Get out of your car and repair the client's car", 1)
						end
					end
				end
				if(not IsCharDead(client)) then
					if(not IsCharInCar(client, clientveh)) then
						WarpCharIntoCar(client, clientveh)
					end
				end
				if(not IsCharInCar(GetPlayerChar(-1), towtruck)) then
					if(not IsCharDead(client)) then
						if(not IsCarDead(clientveh)) then
							if(IsCharInCar(client, clientveh)) then
								local cx,cy,cz = GetCarCoordinates(clientveh)
								if(IsPlayerNearCoords(cx, cy, cz, 2)) then
									PrintText("Press ~y~E ~w~to repair this vehicle", 1)
									if(IsGameKeyboardKeyJustPressed(18)) then
										PlayAnim("missroman10", "cop_search")
										SetPlayerControl(GetPlayerId(), false)
										ClearCharTasksImmediately(GetPlayerChar(-1))
										SetPlayerControl(GetPlayerId(), true)
										RemoveBlip(jobblip)
										FixCar(clientveh)
										TaskCarMission(client, clientveh, client, 1, 10.1, 0, 0, 10)
										MarkCharAsNoLongerNeeded(client)
										MarkCarAsNoLongerNeeded(clientveh)
										client = nil
										clientveh = nil
										local finalcash = math.floor(tempdist/13)
										AddItem(34, finalcash)
						
										SaveStats()
										Notify('Vehicle has been repaired. You have got ' .. finalcash .. '$.')
									end
								end
							end
						else
							RemoveBlip(jobblip)
						end
					else
						RemoveBlip(jobblip)
					end
				end
				
				if(IsPlayerDead(GetPlayerId())) then
					RemoveBlip(jobblip)
					--DeleteEntity(towtruck)
				end
				local cx,cy,cz = GetCarCoordinates(towtruck)
				if(not IsPlayerNearCoords(cx,cy,cz, 10.0)) then
					for j=10,1,-1 do
						PrintStringWithLiteralStringNow("STRING", "~r~You are too far from the tow truck! Go back to tow truck. You have ~y~" .. j .. " seconds", 1000, 1)
						Citizen.Wait(1000)
						if(not IsPlayerNearCoords(cx,cy,cz, 10.0)) then
							if(j == 1) then
								if(DoesBlipExist(jobblip)) then
									RemoveBlip(jobblip)
									DeleteCar(towtruck)
								end
							end
						else
							break
						end
					end
				end
			else
				RemoveBlip(jobblip)
				--DeleteEntity(towtruck)
			end
		end

		if(IsCharInCar(GetPlayerChar(-1), towtruck)) then
			for i=0,31,1 do
				if(IsNetworkPlayerActive(i)) then
					if(ConvertIntToPlayerindex(i) ~= ConvertIntToPlayerindex(GetPlayerId())) then
						if(IsCharInAnyCar(GetPlayerChar(i))) then
							local px,py,pz = GetCharCoordinates(GetPlayerChar(i))
							if(IsPlayerNearCoords(px, py, pz, 5)) then
								PrintText("Press ~y~E ~w~to offer a repairing to ~y~" .. GetPlayerName(i), 1)
								if(IsGameKeyboardKeyJustPressed(18)) then
									local price = ActivateInput("Enter the price of repairing")
									if(price ~= "") then
										price = tonumber(price)
										if price then
											Notify("Repair offer sent to " .. GetPlayerName(i) .. ".")
											TriggerServerEvent('sendRepairOffer', i, ConvertIntToPlayerindex(GetPlayerId()), price)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent('sendRepairOffer')
AddEventHandler('sendRepairOffer', function(id, sender, price)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		if(inventory[34] >= price) then
			DrawWindow("" .. GetPlayerName(sender) .. " offers you a repairing", {"Accept offer for ~g~" .. price .. "$"})
			while menuactive do
				Wait(0)
			end
			if(menuresult == 1) then
				FixCar(GetCarCharIsUsing(GetPlayerChar(-1)))
				RemoveItem(34, price)
				SaveStats()
				TriggerServerEvent('sendMoneyToPlayer', sender, ConvertIntToPlayerindex(GetPlayerId()), price)
				TriggerServerEvent('sendMessageToPlayer', sender, "" .. GetPlayerName(GetPlayerId()) .. " has accepted your offer.")
				SendMessageToNearbyPlayers("" .. GetPlayerName(sender) .. " has repaired the vehicle of " .. GetPlayerName(GetPlayerId()) .. ".", 20)
			else
				TriggerServerEvent('sendMessageToPlayer', sender, "" .. GetPlayerName(GetPlayerId()) .. " has declined your offer.")
			end
		else
			TriggerServerEvent('sendMessageToPlayer', sender, "This player does not have enough money to pay for the repairing.")
		end
	end
end)