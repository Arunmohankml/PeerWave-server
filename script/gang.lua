--[[RegisterNetEvent('performGangRequest')
AddEventHandler('performGangRequest', function(target, requester, id, args)
	if(ConvertIntToPlayerindex(target) == ConvertIntToPlayerindex(GetPlayerId())) then
		if(id == "selldrug") then
			if(inventory[34] >= args[2]) then
				DrawWindow("" .. GetPlayerName(requester) .. " offers you a to buy drugs", {"Buy " .. args[1] .. " drugs for ~g~" .. args[2] .. "$"})
				while menuactive do
					Wait(0)
				end
				if(menuresult == 1) then
					drugs = drugs + args[1]
					money = money - args[2]
					SaveStats()
					TriggerServerEvent('performGangRequest', requester, target, "removedrug", {args[1]})
					TriggerServerEvent('sendMoneyToPlayer', requester, target, args[2])
					TriggerServerEvent('sendMessageToPlayer', requester, "" .. GetPlayerName(target) .. " has accepted your offer.")
					SendMessageToNearbyPlayers("" .. GetPlayerName(requester) .. " has sold drugs to " .. GetPlayerName(target) .. ".", 20)
				else
					TriggerServerEvent('sendMessageToPlayer', requester, "" .. GetPlayerName(target) .. " has declined your offer.")
				end
			else
				TriggerServerEvent('sendMessageToPlayer', requester, "This player does not have enough money to pay for a drugs.")
			end
		elseif(id == "removedrug") then
			drugs = drugs - args[1]
			SaveStats()
		end
	end
end)

TriggerServerEvent('registerCommand', "usedrug")
RegisterNetEvent('performCommand')
AddEventHandler('performCommand', function(command, args)
	if(command == "usedrug") then
		if(#args == 1) then
			args[1] = tonumber(args[1])
			if args[1] then
				if(drugs >= args[1]) then
					if(args[1] <= 3) then
						if(GetCharHealth(GetPlayerChar(-1)) < 200) then
							drugs = drugs - args[1]
							addict = addict + args[1]
							SaveStats()
							SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1))+math.floor(25*args[1]))
							Notify("You have used " .. args[1] .. " drugs. " .. drugs .. " drugs left.")
							SendMessageToNearbyPlayers("" .. GetPlayerName(GetPlayerId()) .. " has used drugs.", 20)
						else
							Notify("Currently you cannot use drugs.")
						end
					else
						Notify("You cannot use more than 3 drugs per time.")
					end
				else
					Notify("You do not have this amount of drugs.")
				end
			end
		end
	end
end)]]

local ganginfo = {
{name = "Spanish Lords", blip = {77, 19}, check = {255, 255, 0}, base = {1199.33301, 1695.49939, 17.72684}, skins = {"m_y_glat_lo_02", "f_m_platin_02"}, vehpos = {1204.9469, 1709.08496, 16.6664, 224.78547668457}, vehcolor = 127},
{name = "Yardies", blip = {77, 2}, check = {0, 255, 0}, base = {1189.44751, 1442.5769, 30.28511}, skins = {"m_m_gjam_hi_01", "f_y_pharbron_01"}, vehpos = {1175.97705, 1424.69458, 16.77206, 265.540130615234}, vehcolor = 51},
{name = "Hustlers", blip = {77, 1}, check = {255, 0, 0}, base = {379.02499, 1436.50818, 11.67622}, skins = {"m_y_gafr_hi_02", "f_y_pbronx_01"}, vehpos = {429.51602, 1482.25, 12.80078, 206.669174194336}, vehcolor = 125}
}

local mats = {}
for i=1,#ganginfo,1 do
	mats[i] = 0
end
RegisterNetEvent('updMats')
AddEventHandler('updMats', function(data)
	for i=1,#mats,1 do
		if(data[i] ~= nil) then
			mats[i] = tonumber(data[i])
		end
	end
end)
SaveMats = function()
	local data = {}
	for i=1,#mats,1 do
		data[i] = mats[i]
	end
	TriggerServerEvent('saveMats', data)
end

local gangblip = {}
local jobblip = nil
local jobblip2 = nil
local jobblip3 = {}
local jobblip4 = nil
local gangcar = nil
local gangblip2 = nil
local crate = nil
local crateamount = 0
local gangblip3 = nil
local neededcar = nil
local coords = {
{-240.54962, 178.41364, 14.72077, 0.00997207593172789},
{15.51096, -712.09052, 9.40292, 0.996797740459442},
{-1597.84607, -358.18616, 2.56068, 267.993988037109},
{-1472.36938, 695.5827, 19.59766, 327.502044677734},
{-1042.61011, 1639.30029, 35.45897, 87.7922973632813},
{908.5426, 1722.71875, 16.79771, 312.091156005859},
{1196.71875, 809.58325, 35.97434, 132.887084960938},
{1762.4873, 493.53668, 28.91337, 311.545806884766},
{1039.07605, -513.0072, 14.81829, 359.177917480469},
{-510.95981, 1763.35742, 8.60495, 192.207885742188}
}
local tempdist = 0
local wantedblocker = 0
local coords2 = {
{54.85107, 1280.30542, 25.05073, 267.494140625, 1088301881},
{-422.62695, 1403.53345, 20.46341, 358.096649169922, 1088301881},
{1464.05713, 31.68451, 29.46904, 48.086742401123, 202844931},
{-984.20734, 1221.43018, 28.42288, 45.3691177368164, -1439643044},
{-1027.78772, 1310.49695, 28.79823, 123.620758056641, -1439643044}
}
local tv = nil
CreateThread(function()
	while true do
		Wait(0)
		for i=1,#ganginfo,1 do
			--[[if(not DoesBlipExist(gangblip[i])) then
				gangblip[i] = AddBlipForCoord(ganginfo[i].base[1], ganginfo[i].base[2], ganginfo[i].base[3])
				ChangeBlipSprite(gangblip[i], ganginfo[i].blip[1])
				ChangeBlipColour(gangblip[i], ganginfo[i].blip[2])
				ChangeBlipNameFromAscii(gangblip[i], ganginfo[i].name)
				SetBlipAsShortRange(gangblip[i], true)
			end]]
			--DrawCheckpointWithDist(ganginfo[i].base[1], ganginfo[i].base[2], ganginfo[i].base[3]-1, 1.1, ganginfo[i].check[1], ganginfo[i].check[2], ganginfo[i].check[3], 100)
			if(currleader[ganginfo[i].name] == "None") then
				--DrawTextAtCoord(ganginfo[i].base[1], ganginfo[i].base[2], ganginfo[i].base[3], "" .. GetStringWithoutSpaces(ganginfo[i].name) .. " Leader:_None Press_R_to_become_leader", 20)
			else
				--DrawTextAtCoord(ganginfo[i].base[1], ganginfo[i].base[2], ganginfo[i].base[3], "" .. GetStringWithoutSpaces(ganginfo[i].name) .. " Leader:_" .. GetStringWithoutSpaces(currleader[ganginfo[i].name]), 20)
			end
			if(IsPlayerNearCoords(ganginfo[i].base[1], ganginfo[i].base[2], ganginfo[i].base[3], 1)) then
				if(currleader[ganginfo[i].name] == "None") then
					if(IsGameKeyboardKeyJustPressed(19)) then
						--[[if(job=="0" or job==ganginfo[i].name) then
							if(level>=3 and money>=30000) then
								DrawWindow("Are you sure you want to become a leader?", {"Yes", "No"})
								while menuactive do
									Wait(0)
								end
								if(menuresult == 1) then
									currleader[ganginfo[i].name] = GetPlayerName(GetPlayerId())
									SaveLeaders()
									job = ganginfo[i].name
									leader = 1
									rank = 5
									RemoveItem(34, 30000)
									SaveStats()
								end
							else
								Notify("You need to reach level 3 and have 30000$ to become a leader.")
							end
						else
							Notify("You are already a member of another faction.")
						end]]
					end
				end
				if(job == ganginfo[i].name) then
					if(not CheckFaction(ganginfo[i].name)) then
						PrintText("Press ~y~E ~w~to ~y~join the gang", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							local model = 0
							if(gender == 1) then
								model = GetHashKey(ganginfo[i].skins[1])
							else
								model = GetHashKey(ganginfo[i].skins[2])
							end
							SetPlayerSkin(model)
							Notify('You have joined the gang.')
						end
					else
						PrintText("Press ~y~E ~w~to ~y~open gang menu", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							::main::
							local tempitems = {}
							tempitems[#tempitems+1] = "Craft guns"
							tempitems[#tempitems+1] = "Vehicles"
							tempitems[#tempitems+1] = "Jobs"
							tempitems[#tempitems+1] = "Leave gang"
							DrawWindow(ganginfo[i].name, tempitems)
							while menuactive do
								Wait(0)
							end
							if(menuresult > 0) then
								if(tempitems[menuresult] == "Craft guns") then
									::weps::
									local weps = {
									{"Baseball Bat", 1, 1, 1, 0},
									{"Glock 17", 1, 7, 17, 5},
									{"Deagle", 2, 9, 9, 5},
									{"Micro Uzi", 3, 12, 50, 15},
									{"AK-47", 4, 14, 30, 15}
									}
									local tempitems = {}
									for j=1,#weps,1 do
										tempitems[j] = weps[j][1] .. " (Rank " .. weps[j][2] .. ") - ~y~" .. weps[j][5]
									end
									DrawWindow("Gun workshop (" .. mats[i] .. " materials)", tempitems)
									while menuactive do
										Wait(0)
									end
									if(menuresult > 0) then
										if(rank >= weps[menuresult][2]) then
											if(mats[i] >= weps[menuresult][5]) then
												mats[i] = mats[i] - weps[menuresult][5]
												SaveMats()
												GiveWeaponToChar(GetPlayerChar(-1), weps[menuresult][3], weps[menuresult][4], 1)
											else
												Notify("Storage of your gang does not contain enough materials.")
											end
										else
											Notify('Your rank is too low to use it.')
										end
										goto weps
									else
										goto main
									end
								elseif(tempitems[menuresult] == "Vehicles") then
									::vehs::
									local vehs = {
									{"Burrito", 1, "burrito"},
									{"Manana", 2, "manana"}, --81
									{"Buccaneer", 3, "buccaneer"}, --87
									{"Primo", 4, "primo"}, --87
									{"Oracle", 5, "oracle"} --89
									}
									local tempitems = {}
									for j=1,#vehs,1 do
										tempitems[j] = vehs[j][1] .. " (Rank " .. vehs[j][2] .. ")"
									end
									DrawWindow("Vehicles", tempitems)
									while menuactive do
										Wait(0)
									end
									if(menuresult > 0) then
										if(rank >= vehs[menuresult][2]) then
											crateamount = 0
											DeleteCar(gangcar)
											gangcar = SpawnCar(GetHashKey(vehs[menuresult][3]), ganginfo[i].vehpos[1], ganginfo[i].vehpos[2], ganginfo[i].vehpos[3], ganginfo[i].vehpos[4])
											ChangeCarColour(gangcar, ganginfo[i].vehcolor, ganginfo[i].vehcolor)
											--AllowVeh(gangcar)
											Notify('Vehicle spawned near the gang base.')
										else
											Notify('Your rank is too low to use it.')
										end
										goto vehs
									else
										goto main
									end
								elseif(tempitems[menuresult] == "Jobs") then
									local tempitems = {}
									tempitems[#tempitems+1] = "Car theft"
									tempitems[#tempitems+1] = "Stealing"
									DrawWindow("Jobs", tempitems)
									while menuactive do
										Wait(0)
									end
									if(menuresult > 0) then
										if(tempitems[menuresult] == "Car theft") then
											DeleteCar(neededcar)
											for i=1,#jobblip3,1 do
												if(DoesBlipExist(jobblip3[i])) then
													RemoveBlip(jobblip3[i])
												end
											end
											local carcoords = {}
											jobblip3 = {}
											carcoords[1] = GenerateRandomIntInRange(1, #coords+1, _i)
											jobblip3[1] = AddBlipForCoord(coords[carcoords[1]][1], coords[carcoords[1]][2], coords[carcoords[1]][3])
											::retry::
											carcoords[2] = GenerateRandomIntInRange(1, #coords+1, _i)
											if(carcoords[2] == carcoords[1]) then
												goto retry
											end
											jobblip3[2] = AddBlipForCoord(coords[carcoords[2]][1], coords[carcoords[2]][2], coords[carcoords[2]][3])
											::retry2::
											carcoords[3] = GenerateRandomIntInRange(1, #coords+1, _i)
											if(carcoords[3]==carcoords[1] or carcoords[3]==carcoords[2]) then
												goto retry2
											end
											jobblip3[3] = AddBlipForCoord(coords[carcoords[3]][1], coords[carcoords[3]][2], coords[carcoords[3]][3])
											local finalcoord = carcoords[GenerateRandomIntInRange(1, 4)]
											jobblip3[4] = AddBlipForCoord(935.7099, 1556.32336, 16.80302)
											ChangeBlipColour(jobblip3[4], 1)
											DeleteCar(neededcar)
											local model = carinfo[GenerateRandomIntInRange(1, #carinfo+1)][3]
											neededcar = SpawnCar(model, coords[finalcoord][1], coords[finalcoord][2], coords[finalcoord][3], coords[finalcoord][4])
											--AllowVeh(neededcar)
											local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
											tempdist = GetDistanceBetweenCoords3d(px, py, pz, coords[finalcoord][1], coords[finalcoord][2], coords[finalcoord][3])
											wantedblocker = 0
											Notify("Find the needed vehicle on one of three marked points and bring it to the point.")
										elseif(tempitems[menuresult] == "Stealing") then
											local rnd = GenerateRandomIntInRange(1, #coords2+1)
											DeleteObject(tv)
											tv = SpawnObject(GetHashKey("cj_tv_3"), coords[rnd][1], coords[rnd][2], coords[rnd][3]-1, coords[rnd][4], coords[rnd][5])
											FreezeObjectPosition(tv, true)
											jobblip4 = AddBlipForCoord(coords[rnd][1], coords[rnd][2], coords[rnd][3])
											SetRoute(jobblip4, true)
											local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
											tempdist = GetDistanceBetweenCoords3d(px, py, pz, coords[rnd][1], coords[rnd][2], coords[rnd][3])
											Notify('Steal a TV and bring it to the drop-off. Use a van to do that.')
										end
									else
										goto main
									end
								elseif(tempitems[menuresult] == "Leave gang") then
									RemoveBlip(jobblip)
									RemoveBlip(jobblip2)
									for i=1,#jobblip3,1 do
										RemoveBlip(jobblip3[i])
									end
									RemoveBlip(jobblip4)
									RemoveBlip(gangblip2)
									RemoveBlip(gangblip3)
									SetDefaultSkin()
									Notify('You have left the gang.')
								end
							end
						end
					end
				else
					PrintText('To join this faction, contact the faction leader or press ~y~E ~w~to join for ~g~10000$', 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						if(job == "0") then
							if(level >= 2) then
								if(inventory[34] >= 10000) then
									RemoveItem(34, 100)
									job = ganginfo[i].name
									rank = 1
									SaveStats()
								else
									Notify("You do not have enough money.")
								end
							else
								Notify("You must reach level 2 to do that.")
							end
						else
							Notify("You are already a member of another faction.")
						end
					end
				end
			end
		end
		
		if(DoesBlipExist(jobblip3[4])) then
			if(not IsCarDead(neededcar)) then
				if(IsCharInCar(GetPlayerChar(-1), neededcar)) then
					if(wantedblocker == 0) then
						AlterWantedLevel(GetPlayerId(), StoreWantedLevel(GetPlayerId())+2)
						ApplyWantedLevelChangeNow(GetPlayerId())
						if(wanted < 6) then
							wanted = wanted + 1
							SaveStats()
						end
						wantedblocker = 1
						TriggerServerEvent('sendMessageToEveryonePolice', "^1" .. GetPlayerName(GetPlayerId()) .. " is being wanted for car theft.")
					end
					local bp = GetBlipCoords(jobblip3[4])
					DrawCheckpoint(bp.x, bp.y, bp.z-1, 1.1, 255, 3, 30, 100)
					if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 3)) then
						DeleteCar(neededcar)
						for i=1,#jobblip3,1 do
							RemoveBlip(jobblip3[i])
						end
						local finalcash = 350 + math.floor(tempdist/4)
						AddItem(34, finalcash)
							
						SaveStats()
						Notify("Needed vehicle has been delivered. You have got " .. finalcash .. "$.")
					end
				end
			else
				for i=1,#jobblip3,1 do
					RemoveBlip(jobblip3[i])
				end
				Notify("^1Needed vehicle got destroyed.")
			end
			if(IsPlayerDead(GetPlayerId())) then
				for i=1,#jobblip3,1 do
					RemoveBlip(jobblip3[i])
				end
			end
		end
		
		if(DoesBlipExist(jobblip4)) then
			if(not IsCarDead(gangcar)) then
				if(IsCarModel(gangcar, GetHashKey("burrito"))) then
					if(DoesObjectExist(tv)) then
						if(not IsObjectAttached(tv)) then
							local ox,oy,oz = GetObjectCoordinates(tv)
							if(IsPlayerNearCoords(ox, oy, oz, 2)) then
								PrintText("Press ~y~E ~w~to pick up a TV", 1)
								if(IsGameKeyboardKeyJustPressed(18)) then
									PlayAnim("pickup_object", "pickup_low")
									AttachObjectToPed(tv,GetPlayerChar(-1),1232,0.3,0.3,-0.02,0.04,-0.6,0.5,0)
								end
							end
						else
							if(IsCharTouchingVehicle(GetPlayerChar(-1), gangcar)) then
								PrintText("Press ~y~E ~w~to put into van", 1)
								if(IsGameKeyboardKeyJustPressed(18)) then
									AlterWantedLevel(GetPlayerId(), StoreWantedLevel(GetPlayerId())+2)
									ApplyWantedLevelChangeNow(GetPlayerId())
									if(wanted < 6) then
										wanted = wanted + 1
										SaveStats()
									end
									TriggerServerEvent('sendMessageToEveryonePolice', "^1" .. GetPlayerName(GetPlayerId()) .. " is being wanted for stealing.")
									PlayAnim("pickup_object", "putdown_med")
									DeleteObject(tv)
									SetBlipCoordinates(jobblip4, 689.65216, 1432.44653, 14.52102)
									SetRoute(jobblip4, true)
								end
							end
						end
					else
						local bp = GetBlipCoords(jobblip4)
						DrawCheckpoint(bp.x, bp.y, bp.z-1, 1.1, 255, 3, 30, 100)
						if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 3)) then
							RemoveBlip(jobblip4)
							local finalcash = math.floor(tempdist/10)
							AddItem(34, finalcash)
							
							SaveStats()
							Notify("Item sold. You have got " .. finalcash .. "$.")
						end
					end
				else
					if(DoesObjectExist(tv)) then
						PrintText("~r~You need a van")
					else
						RemoveBlip(jobblip4)
					end
				end
			else
				if(DoesObjectExist(tv)) then
					PrintText("~r~You need a van")
				else
					RemoveBlip(jobblip4)
				end
			end
			if(IsPlayerDead(GetPlayerId())) then
				RemoveBlip(jobblip4)
				DeleteObject(tv)
			end
		end
		
		if(CheckFaction("Spanish Lords") or CheckFaction("Yardies") or CheckFaction("Hustlers")) then
			if(not DoesBlipExist(gangblip2)) then
				gangblip2 = AddBlipForCoord(-1135.28723, -404.23608, 3.18385)
				ChangeBlipSprite(gangblip2, 76)
				ChangeBlipColour(gangblip2, 1)
				ChangeBlipNameFromAscii(gangblip2, "NOOSE storage")
				SetBlipAsShortRange(gangblip2, true)
			end
			DrawCheckpointWithDist(-1135.28723, -404.23608, 3.18385-1, 1.1, 255, 0, 0, 100)
			DrawTextAtCoord(-1135.28723, -404.23608, 3.18385, "NOOSE storage", 20)
			if(IsPlayerNearCoords(-1135.28723, -404.23608, 3.18385, 1)) then
				if(not IsCarDead(gangcar)) then
					if(IsCarModel(gangcar, GetHashKey("burrito"))) then
						local px,py,pz = GetCarCoordinates(gangcar)
						if(IsPlayerNearCoords(px, py, pz, 20)) then
							PrintText("Press ~y~E ~w~to steal a crate", 1)
							if(IsGameKeyboardKeyJustPressed(18)) then
								if(not IsObjectAttached(crate)) then
									PlayAnim("pickup_object", "pickup_low")
									local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
									crate = SpawnObject(2736900820, px, py, pz-1, 0.0)
									AttachObjectToPed(crate,GetPlayerChar(-1),1232,0.21, -0.07, -0.01, 1.64060949687466, -1.54461638801498, 0,0)
								else
									Notify("You are already carrying a crate.")
								end
							end
						else
							PrintText("There must be your van near this point to be able to steal a crate", 1)
						end
					else
						PrintText("There must be your van near this point to be able to steal a crate", 1)
					end
				else
					PrintText("There must be your van near this point to be able to steal a crate", 1)
				end
			end
			if(not IsCarDead(gangcar)) then
				if(IsCarModel(gangcar, GetHashKey("burrito"))) then
					if(IsObjectAttached(crate)) then
						if(IsCharTouchingVehicle(GetPlayerChar(-1), gangcar)) then
							PrintText("Press ~y~E ~w~to put the crate", 1)
							if(IsGameKeyboardKeyJustPressed(18)) then
								PlayAnim("pickup_object", "putdown_med")
								DeleteObject(crate)
								if(crateamount < 20) then
									crateamount = crateamount + 1
								else
									Notify("This van is overloaded.")
								end
							end
						end
					end
					if(IsCharInCar(GetPlayerChar(-1), gangcar)) then
						if(crateamount > 0) then
							local c = {}
							if(job == "Spanish Lords") then
								c = ganginfo[1].vehpos
							elseif(job == "Yardies") then
								c = ganginfo[2].vehpos
							elseif(job == "Hustlers") then
								c = ganginfo[3].vehpos
							end
							if(not DoesBlipExist(jobblip)) then
								jobblip = AddBlipForCoord(c[1], c[2], c[3])
								ChangeBlipColour(jobblip, 1)
								ChangeBlipNameFromAscii(jobblip, "Gang storage")
							end
							DrawCheckpointWithDist(c[1], c[2], c[3]-1, 3.1, 255, 0, 0, 100)
							if(IsPlayerNearCoords(c[1], c[2], c[3], 5)) then
								PrintText("Press ~y~E ~w~to unload the van", 1)
								if(IsGameKeyboardKeyJustPressed(18)) then
									local gangid = 0
									if(job == "Spanish Lords") then
										gangid = 1
									elseif(job == "Yardies") then
										gangid = 2
									elseif(job == "Hustlers") then
										gangid = 3
									end
									mats[gangid] = mats[gangid] + 10*crateamount
									SaveMats()
									Notify("" .. 10*crateamount .. " materials have been added to the gang storage.")
									crateamount = 0
								end
							end
						else
							if(DoesBlipExist(jobblip)) then
								RemoveBlip(jobblip)
							end
						end
					else
						if(DoesBlipExist(jobblip)) then
							RemoveBlip(jobblip)
						end
					end
				end
			else
				crateamount = 0
			end
			
			if(not DoesBlipExist(gangblip3)) then
				gangblip3 = AddBlipForCoord(713.66882, 1453.5415, 14.85285)
				ChangeBlipSprite(gangblip3, 72)
				ChangeBlipNameFromAscii(gangblip3, "Drug storage")
				SetBlipAsShortRange(gangblip3, true)
			end
			DrawCheckpointWithDist(713.66882, 1453.5415, 14.85285-1, 3.1, 255, 0, 0, 100)
			DrawTextAtCoord(713.66882, 1453.5415, 14.85285, "Drug_storage ~y~1_drug_costs_200$", 20)
			if(IsPlayerNearCoords(713.66882, 1453.5415, 14.85285, 3)) then
				PrintText("Press ~y~E ~w~to buy drug", 1)
				if(IsGameKeyboardKeyJustPressed(18)) then
					--[[local amount = ActivateInput("Enter amount of drugs")
					if(amount ~= "") then
						amount = tonumber(amount)
						if amount then
							amount = math.floor(amount)
							if(amount > 0) then
								if(inventory[34] >= 250*amount) then
									money = money - 250*amount
									drugs = drugs + amount
									SaveStats()
									Notify("You have bought " .. amount .. " drugs. You have " .. drugs .. " drugs.")
									SendMessageToNearbyPlayers("" .. GetPlayerName(GetPlayerId()) .. " has purchased drugs.", 20)
								else
									Notify("You do not have enough money.")
								end
							end
						end
					end]]
					if(inventory[34] >= 200) then
						
						AddItem(32, 1)
						RemoveItem(34, 200)
						SaveStats()
						SendMessageToNearbyPlayers("" .. GetPlayerName(GetPlayerId()) .. " has purchased drugs.", 20)
						
					end
				end
			end
			
			if(IsCharInAnyCar(GetPlayerChar(-1))) then
				if(IsCarModel(GetCarCharIsUsing(GetPlayerChar(-1)), GetHashKey("pstockade"))) then
					local c1,c2 = GetCarColours(GetCarCharIsUsing(GetPlayerChar(-1)))
					if(c1 == 1) then
						local c = {}
						if(job == "Spanish Lords") then
							c = ganginfo[1].vehpos
						elseif(job == "Yardies") then
							c = ganginfo[2].vehpos
						elseif(job == "Hustlers") then
							c = ganginfo[3].vehpos
						end
						if(not DoesBlipExist(jobblip2)) then
							jobblip2 = AddBlipForCoord(c[1], c[2], c[3])
							ChangeBlipColour(jobblip2, 1)
							ChangeBlipNameFromAscii(jobblip2, "Gang storage")
						end
						DrawCheckpointWithDist(c[1], c[2], c[3]-1, 3.1, 255, 0, 0, 100)
						if(IsPlayerNearCoords(c[1], c[2], c[3], 5)) then
							PrintText("Press ~y~E ~w~to unload the truck", 1)
							if(IsGameKeyboardKeyJustPressed(18)) then
								local gangid = 0
								if(job == "Spanish Lords") then
									gangid = 1
								elseif(job == "Yardies") then
									gangid = 2
								elseif(job == "Hustlers") then
									gangid = 3
								end
								mats[gangid] = mats[gangid] + 300
								SaveMats()
								Notify("300 materials have been added to the gang storage.")
								DeleteCar(GetCarCharIsUsing(GetPlayerChar(-1)))
							end
						end
					else
						if(DoesBlipExist(jobblip2)) then
							RemoveBlip(jobblip2)
						end
					end
				else
					if(DoesBlipExist(jobblip2)) then
						RemoveBlip(jobblip2)
					end
				end
			else
				if(DoesBlipExist(jobblip2)) then
					RemoveBlip(jobblip2)
				end
			end
		end
	end
end)