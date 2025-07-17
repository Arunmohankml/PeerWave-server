local mainjobblip = nil
local jobblip = nil
local taxi = nil
local client = nil
local group = nil
local state = 0
local tempdist = 0

local orders = {}
RegisterNetEvent('addTaxiOrder')
AddEventHandler('addTaxiOrder', function(id, x, y, z)
	for i=1,#orders,1 do
		if(orders[i][1] == id) then
			orders[i] = {id, x, y, z}
			goto skip
		end
	end
	orders[#orders+1] = {id, x, y, z}
	::skip::
	if(not IsCarDead(taxi)) then
		Notify('New order has been added to the list.')
	end
end)
RegisterNetEvent('removeTaxiOrder')
AddEventHandler('removeTaxiOrder', function(id)
	for i=1,#orders,1 do
		if(orders[i][1] == id) then
			orders = RemoveFromTable(orders, i)
			break
		end
	end
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		Notify('Your taxi request has been accepted. Please wait where you at for a driver.')
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		for i=1,#orders,1 do
			if(not IsNetworkPlayerActive(orders[i][1])) then
				orders = RemoveFromTable(orders, i)
				break
			end
		end
		if(not DoesBlipExist(mainjobblip)) then
			mainjobblip = AddBlipForCoord(820.24219, -265.84424, 15.34273)
			ChangeBlipSprite(mainjobblip, 30)
			--ChangeBlipColour(mainjobblip, 1)
			ChangeBlipNameFromAscii(mainjobblip, "Taxi")
			SetBlipAsShortRange(mainjobblip, true)
			ChangeBlipScale(mainjobblip, 0.7)
		end
		DrawCheckpointWithDist(820.24219, -265.84424, 15.34273-1, 1.1, 255, 3, 30, 100)
		DrawTextAtCoord(820.24219, -265.84424, 15.34273, "Taxi", 20)
		if(IsPlayerNearCoords(820.24219, -265.84424, 15.34273, 1)) then
			if(level >= 2) then
				if(driverlicense == 1) then
					if(IsCarDead(taxi)) then
						PrintText("Press ~y~E ~w~to rent a taxi for ~g~100$", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							if(currjob == "") then
								if(inventory[34] >= 100) then
									currjob = "Taxi"
									RemoveItem(34, 100)
									SaveStats()
									DeleteCar(taxi)
									taxi = SpawnCar(GetHashKey("taxi"), 806.98706, -273.95477, 15.34273, 300.296813964844)
									--AllowVeh(taxi)
									WarpCharIntoCar(GetPlayerChar(-1), taxi)
									Notify('Taxi job has been started. Use X button to open taxi menu and select a client.')
								else
									Notify('You do not have enough money.')
								end
							else
								Notify("You are currently working at another job. Finish it before starting this one.")
							end
						end
					else
						PrintText("Press ~y~E ~w~to finish taxi job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							currjob = ""
							RemoveBlip(jobblip)
							DeleteCar(taxi)
							Notify('Taxi job has been finished.')
						end
					end
				else
					PrintText("You must have a driver license for this job", 1)
				end
			else
				PrintText("You must reach level 2 to start this job", 1)
			end
		end
		if(DoesVehicleExist(taxi)) then
			if(not IsCarDead(taxi)) then
				if(IsCharInCar(GetPlayerChar(-1), taxi)) then
					if(IsGameKeyboardKeyJustPressed(JobKey)) then
						if(not DoesBlipExist(jobblip)) then
							local tempitems = {}
							for i=1,#orders,1 do
								local streetname = GetStreetAtCoord(orders[i][2], orders[i][3], orders[i][4])
								local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
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
									RemoveGroup(group)
									group = nil
									DeleteChar(client)
									local rx,ry,rz,rh = GetRandomNodeInRadius(1000)
									--TriggerServerEvent('restartScript', "cleanup")
									--Wait(1000)
									client = SpawnRandomPed(rx, ry, rz, rh)
									jobblip = AddBlipForChar(client)
									SetRoute(jobblip, true)
									state = 0
								else
									local order = orders[menuresult]
									jobblip = AddBlipForCoord(orders[menuresult][2], orders[menuresult][3], orders[menuresult][4])
									SetRoute(jobblip, true)
									TriggerServerEvent('removeTaxiOrder', orders[menuresult][1])
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
						else
							if(not IsCharDead(client)) then
								if(not IsCharInCar(client, taxi)) then
									local px,py,pz = GetCharCoordinates(client)
									if(IsPlayerNearCoords(px, py, pz, 5)) then
										if(not DoesGroupExist(group)) then
											group = CreateGroup(false, true)
											SetGroupLeader(group, GetPlayerChar(-1))
											SetGroupMember(group, client)
											SetCharNeverLeavesGroup(client, true)
										end
									end
								else
									if(state == 0) then
										state = 1
										RemoveBlip(jobblip)
										local rx,ry,rz,rh = GetRandomNodeInRadius(GenerateRandomIntInRange(1000, 5000))
										jobblip = AddBlipForCoord(rx, ry, rz)
										SetRoute(jobblip, true)
										local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
										tempdist = GetDistanceBetweenCoords3d(px, py, pz, rx, ry, rz)
									end
									RemoveCharFromGroup(client)
									RemoveGroup(group)
									group = nil
								end
								if(state == 1) then
									local bp = GetBlipCoords(jobblip)
									DrawCheckpoint(bp.x, bp.y, bp.z, 1.1, 255, 3, 30, 100)
									if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 3)) then
										if(GetCarSpeed(taxi) == 0) then
											RemoveBlip(jobblip)
											TaskLeaveAnyCar(client)
											MarkCharAsNoLongerNeeded(client)
											client = nil
											local finalcash = math.floor(tempdist/16)
											AddItem(34, finalcash)
							
											SaveStats()
											Notify("+" .. finalcash .. "$", 5000)
											Notify('Client has reached the destination. You have got ' .. finalcash .. '$.')
										end
									end
								end
							else
								RemoveBlip(jobblip)
							end
						end
					end
				end
				if(IsPlayerDead(GetPlayerId())) then
					RemoveBlip(jobblip)
					--DeleteEntity(taxi)
				end
			else
				RemoveBlip(jobblip)
				--DeleteEntity(taxi)
			end
		end
	end
end)