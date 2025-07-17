injured = false

RegisterNetEvent('performMedicRequest')
AddEventHandler('performMedicRequest', function(target, requester, id, args)
	if(ConvertIntToPlayerindex(target) == ConvertIntToPlayerindex(GetPlayerId())) then
		if(id == "heal") then
			if(inventory[34] >= args[1]) then
				DrawWindow("" .. GetPlayerName(requester) .. " offers you a healing", {"Accept offer for ~g~" .. args[1] .. "$"})
				while menuactive do
					Wait(0)
				end
				if(menuresult == 1) then
					SetCharHealth(GetPlayerChar(-1), 200)
					injured = false
					RemoveItem(34,  args[1])
					SaveStats()
					TriggerServerEvent('sendMoneyToPlayer', requester, target, args[1])
					TriggerServerEvent('sendMessageToPlayer', requester, "" .. GetPlayerName(target) .. " has accepted your offer.")
					SendMessageToNearbyPlayers("" .. GetPlayerName(requester) .. " has healed " .. GetPlayerName(target) .. ".", 20)
				else
					TriggerServerEvent('sendMessageToPlayer', requester, "" .. GetPlayerName(target) .. " has declined your offer.")
				end
			else
				TriggerServerEvent('sendMessageToPlayer', requester, "This player does not have enough money to pay for the healing.")
			end
		elseif(id == "Revive") then
			if(IsPlayerDead(GetPlayerId())) then
				FadeScreen()
				local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
				local ph = GetCharHeading(GetPlayerChar(-1))
				ResurrectNetworkPlayer(GetPlayerId(), px, py, pz, ph)
				SetCharHealth(GetPlayerChar(-1), 200)
				TriggerEvent("noticeme:Info", "You have been revived by a medic")
				TriggerServerEvent('sendMessageToPlayer', GetPlayerName(medicid, _s), "[Medic]", "You have successfully revived a citizen (+100$).")
				TriggerEvent("deathoff")
				thirst = 30
				hunger = 30
				SaveStats()
			else
				TriggerServerEvent('sendMessageToPlayer', GetPlayerName(medicid, _s), "[Medic]", "This player is alive!")
			end
		end
	end
end)

local orders = {}
RegisterNetEvent('addMedicOrder')
AddEventHandler('addMedicOrder', function(id, x, y, z)
	for i=1,#orders,1 do
		if(orders[i][1] == id) then
			orders[i] = {id, x, y, z}
			goto skip
		end
	end
	orders[#orders+1] = {id, x, y, z}
	::skip::
	if(CheckFaction("Medic")) then
		Notify('New medic request has been added to the list.')
	end
end)
RegisterNetEvent('removeMedicOrder')
AddEventHandler('removeMedicOrder', function(id)
	for i=1,#orders,1 do
		if(orders[i][1] == id) then
			orders = RemoveFromTable(orders, i)
			break
		end
	end
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		Notify('Your medic request has been accepted. Please wait...')
	end
end)

local mainjobblip = nil
local jobblip = nil
local ambulance = nil
local client = nil
local group = nil
local state = 0
local tempdist = 0
CreateThread(function()
	while true do
		Wait(0)
		for i=1,#orders,1 do
			if(not IsNetworkPlayerActive(orders[i][1])) then
				orders = RemoveFromTable(orders, i)
				break
			end
		end
		if(not DoesBlipExist(mainjobblip)) then
			mainjobblip = AddBlipForCoord(1206.43445, 187.60365, 33.55356)
			ChangeBlipSprite(mainjobblip, 62)
			--ChangeBlipColour(mainjobblip, 1)
			ChangeBlipNameFromAscii(mainjobblip, "Medic")
			SetBlipAsShortRange(mainjobblip, true)
			ChangeBlipScale(mainjobblip, 0.7)
		end
		DrawCheckpointWithDist(1206.43445, 187.60365, 33.55356-1, 1.1, 0, 0, 255, 100)
		if(IsPlayerNearCoords(1206.43445, 187.60365, 33.55356, 1)) then
			if(job == "Medic") then
				if(not CheckFaction("Medic")) then
					PrintText("Press ~y~E ~w~to ~y~start duty", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						local model = 0
						if(gender == 1) then
							model = GetHashKey("M_Y_PMEDIC")
						else
							model = GetHashKey("F_Y_NURSE")
						end
						SetPlayerSkin(model)
						Notify('Duty has been started. Use X button to see the list of current medic requests.')
					end
				else
					PrintText("Press ~y~E ~w~to ~y~open medic menu", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						::main::
						local tempitems = {}
						tempitems[#tempitems+1] = "Vehicles"
						tempitems[#tempitems+1] = "Finish duty"
						DrawWindow("Medic station", tempitems)
						while menuactive do
							Wait(0)
						end
						if(menuresult > 0) then
							if(tempitems[menuresult] == "Vehicles") then
								::vehs::
								local vehs = {
								{"Ambulance", 2, "ambulance"},
								{"Patriot", 4, "polpatriot"}
								}
								local tempitems = {}
								for i=1,#vehs,1 do
									tempitems[i] = vehs[i][1] .. " (Rank " .. vehs[i][2] .. ")"
								end
								DrawWindow("Vehicles", tempitems)
								while menuactive do
									Wait(0)
								end
								if(menuresult > 0) then
									if(rank >= vehs[menuresult][2]) then
										DeleteCar(ambulance)
										ambulance = SpawnCar(GetHashKey(vehs[menuresult][3]), 1187.60205, 195.02211, 32.46328, 179.410705566406)
										if(vehs[menuresult][1] == "Patriot") then
											ChangeCarColour(ambulance, 27, 27)
										end
										--AllowVeh(ambulance)
										Notify('Vehicle spawned near the hospital.')
									else
										Notify('Your rank is too low to use it.')
									end
									goto vehs
								else
									goto main
								end
							elseif(tempitems[menuresult] == "Finish duty") then
								RemoveBlip(jobblip)
								SetDefaultSkin()
								Notify('Duty has been finished.')
							end
						end
					end
				end
			end
		end
		
		if(job == "Medic") then
			if(CheckFaction("Medic")) then
				if(IsGameKeyboardKeyJustPressed(JobKey)) then
					if(not DoesBlipExist(jobblip)) then
						local tempitems = {}
						for i=1,#orders,1 do
							local streetname = GetStreetAtCoord(orders[i][2], orders[i][3], orders[i][4])
							local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
							local dist = GetDistanceBetweenCoords3d(px, py, pz, orders[i][2], orders[i][3], orders[i][4])
							tempitems[i] = streetname .. " (" .. math.floor(dist) .. "m)"
						end
						tempitems[#tempitems+1] = "Get random request"
						DrawWindow("Request list", tempitems)
						while menuactive do
							Wait(0)
						end
						if(menuresult > 0) then
							if(tempitems[menuresult] == "Get random request") then
								RemoveGroup(group)
								group = nil
								DeleteChar(client)
								local rx,ry,rz,rh = GetRandomNodeInRadius(GenerateRandomIntInRange(1000, 5000))
								--TriggerServerEvent('restartScript', "cleanup")
								--Wait(1000)
								client = SpawnRandomPed(rx, ry, rz, rh)
								jobblip = AddBlipForChar(client)
								SetRoute(jobblip, true)
								state = 0
								local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
								tempdist = GetDistanceBetweenCoords3d(px, py, pz, rx, ry, rz)
							else
								local order = orders[menuresult]
								jobblip = AddBlipForCoord(orders[menuresult][2], orders[menuresult][3], orders[menuresult][4])
								SetRoute(jobblip, true)
								TriggerServerEvent('removeMedicOrder', orders[menuresult][1])
							end
						end
					else
						DrawWindow("Request list", {"Cancel current request"})
						while menuactive do
							Wait(0)
						end
						if(menuresult == 1) then
							RemoveBlip(jobblip)
							DeleteChar(client)
						end
					end
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
					if(not IsCharInCar(client, ambulance)) then
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
							jobblip = AddBlipForCoord(1187.43335, 196.08456, 32.46124)
							SetRoute(jobblip, true)
							local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
							tempdist = tempdist + GetDistanceBetweenCoords3d(px, py, pz, 1187.43335, 196.08456, 32.46124)
						end
						RemoveCharFromGroup(client)
						RemoveGroup(group)
						group = nil
					end
					if(state == 1) then
						local bp = GetBlipCoords(jobblip)
						DrawCheckpoint(bp.x, bp.y, bp.z-1, 1.1, 255, 3, 30, 100)
						if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 3)) then
							if(GetCarSpeed(ambulance) == 0) then
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
		if(IsCharDead(GetPlayerChar(-1))) then
			RemoveBlip(jobblip)
			--DeleteEntity(ambulance)
		end
	end
end)

local spawned = false
RegisterNetEvent('playerSpawned')
AddEventHandler('playerSpawned', function()
	CreateThread(function()
		if spawned then
			while not IsDefaultSkin() do
				Wait(0)
			end
			Wait(100)
			if(jailtime<=0 and demorgan<=0) then
				if(job=="Spanish Lords" or job=="Yardies" or job=="Hustlers") then
					local jobpos = {
					["Spanish Lords"] = {1199.33301, 1695.49939, 17.72684},
					["Yardies"] = {1189.44751, 1442.5769, 30.28511},
					["Hustlers"] = {402.94717, 1473.53015, 11.83429}
					}
					SetCharCoordinates(GetPlayerChar(-1), jobpos[job][1], jobpos[job][2], jobpos[job][3])
					SetCharHealth(GetPlayerChar(-1), 200)
				elseif(job == "Medic") then
					SetCharCoordinates(GetPlayerChar(-1), 1206.43445, 187.60365, 33.55356)
					SetCharHealth(GetPlayerChar(-1), 200)
				else
					SetCharCoordinates(GetPlayerChar(-1), 1232.73767, 185.45033, 33.55338) --hospital
					SetCharHealth(GetPlayerChar(-1), 110)
					injured = true
				end
			else
				SetCharHealth(GetPlayerChar(-1), 200)
			end
			TriggerServerEvent('saveHealth', GetCharHealth(GetPlayerChar(-1)), GetCharArmour(GetPlayerChar(-1)))
		else
			while not IsDefaultSkin() do
				Wait(0)
			end
			SetCharHealth(GetPlayerChar(-1), 200)
			spawned = true
		end
	end)
end)
CreateThread(function()
	while true do
		Wait(0)
		if injured then
			Wait(20000)
			if injured then
				SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1))+5)
				if(GetCharHealth(GetPlayerChar(-1)) >= 200) then
					injured = false
					Notify("You have been discharged from the hospital.")
				end
			end
		end
	end
end)
CreateThread(function()
	while true do
		Wait(0)
		if injured then
			if(GetCharHealth(GetPlayerChar(-1)) >= 200) then
				injured = false
				Notify("You have been discharged from the hospital.")
			end
		end
	end
end)
local door = nil
CreateThread(function()
	while true do
		Wait(0)
		if(not DoesObjectExist(door)) then
			door = SpawnObject(GetHashKey("cj_gate_dock"), 1212.37353515625, 183.369689941406, 33.7566833496094, 359.550323486328, -869201005)
			SetObjectVisible(door, false)
			SetObjectStopCloning(door, true)
		else
			if injured then
				SetObjectCollision(door, true)
				if(IsCharTouchingObject(GetPlayerChar(-1), door)) then
					--Notify("Please complete your treatment before leaving the hospital.")
					--Wait(1000)
					PrintText("Please complete your treatment before leaving the hospital", 1000)
				end
			else
				SetObjectCollision(door, false)
			end
		end
	end
end)