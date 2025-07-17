local followplayer = -1
followedplayer = -1
CreateThread(function()
	while true do
		Wait(0)
		if(followplayer > -1) then
			if(IsNetworkPlayerActive(followplayer)) then
				if(not IsCharDead(GetPlayerChar(followplayer))) then
					local px,py,pz = GetCharCoordinates(GetPlayerChar(followplayer))
					if(not IsPlayerNearCoords(px, py, pz, 2)) then
						SetCharCoordinates(GetPlayerChar(-1), px, py, pz)
					end
				else
					followplayer = -1
				end
			else
				followplayer = -1
			end
		end

		if(followedplayer > -1) then
			if(IsNetworkPlayerActive(followedplayer)) then
				if(not IsCharDead(GetPlayerChar(followedplayer))) then
					local px,py,pz = GetCharCoordinates(GetPlayerChar(followedplayer))
					if(not IsPlayerNearCoords(px, py, pz, 2)) then
						SetCharCoordinates(GetPlayerChar(followedplayer), px+0.5, py+0.5, pz)
					end
				else
					followedplayer = -1
				end
			else
				followedplayer = -1
			end
		end
	end
end)

cuff = false
CreateThread(function()
	while true do
		Wait(0)
		if cuff then
			if(not IsCharDead(GetPlayerChar(-1))) then
				SetCurrentCharWeapon(GetPlayerChar(-1), 0, true)
				SetPlayerControl(GetPlayerId(), false)
			else
				cuff = false
				SetPlayerControl(GetPlayerId(), true)
			end
		end
	end
end)
CreateThread(function()
	while true do
		Wait(0)
		if(jailtime > 0) then
			Wait(1000)
			jailtime = jailtime - 1
			SaveStats()
			if(jailtime <= 0) then
				SetCharCoordinates(GetPlayerChar(-1), 80.39365, 1214.03418, 14.73298) --out of jail
				Notify("You have been freed out of jail.")
			else
				PrintText("You are jailed. Wait for ~y~" .. jailtime .. " seconds", 1000)
			end
		end
	end
end)
AddEventHandler('playerSpawned', function()
	if(jailtime > 0) then
		SetCharCoordinates(GetPlayerChar(-1), 81.62646, 1208.80212, 14.73794) --jail
	end
end)

RegisterNetEvent('sendMessageToEveryonePolice')
AddEventHandler('sendMessageToEveryonePolice', function(message)
	if(CheckFaction("Police")) then
		TriggerServerEvent('SendMessage', "Police Private", message, 5, 3)
	end
end)

RegisterNetEvent('performPoliceRequest')
AddEventHandler('performPoliceRequest', function(target, requester, id, args)
	if(ConvertIntToPlayerindex(target) == ConvertIntToPlayerindex(GetPlayerId())) then
		if(id == "cuff") then
			if not cuff then
				ClearCharTasksImmediately(GetPlayerChar(-1))
				SetPlayerControl(GetPlayerId(), false)
				cuff = true
				SetCurrentCharWeapon(GetPlayerChar(-1), 0, true)
				SendMessageToNearbyPlayers("" .. GetPlayerName(requester) .. " has put handcuffs on " .. GetPlayerName(target) .. ".", 20)
			else
				cuff = false
				SetPlayerControl(GetPlayerId(), true)
				SendMessageToNearbyPlayers("" .. GetPlayerName(requester) .. " has removed handcuffs from " .. GetPlayerName(target) .. ".", 20)
			end
		elseif(id == "grab") then
			if(followplayer == -1) then
				if cuff then
					followplayer = requester
					SendMessageToNearbyPlayers("" .. GetPlayerName(requester) .. " has grabbed " .. GetPlayerName(target) .. ".", 20)
				else
					TriggerServerEvent('sendMessageToPlayer', requester, "This player is not handcuffed.")
				end
			elseif(followplayer == requester) then
				followplayer = -1
				SendMessageToNearbyPlayers("" .. GetPlayerName(requester) .. " has left " .. GetPlayerName(target) .. ".", 20)
			else
				TriggerServerEvent('sendMessageToPlayer', requester, "This player is not grabbed by you.")
			end
		elseif(id == "push") then
			if cuff then
				WarpCharIntoCarAsPassenger(GetPlayerChar(-1), GetCarCharIsUsing(GetPlayerChar(requester)), GetFreePassengerSeat(GetCarCharIsUsing(GetPlayerChar(requester))))
				SendMessageToNearbyPlayers("" .. GetPlayerName(requester) .. " has pushed " .. GetPlayerName(target) .. " into their vehicle.", 20)
			else
				TriggerServerEvent('sendMessageToPlayer', requester, "This player is not handcuffed.")
			end
		elseif(id == "eject") then
			if not cuff then
				TaskLeaveCar(GetPlayerChar(-1), GetCarCharIsUsing(GetPlayerChar(-1)))
				SendMessageToNearbyPlayers("" .. GetPlayerName(requester) .. " has pushed " .. GetPlayerName(target) .. " out of their vehicle.", 20)
			else
				CreateThread(function()
					cuff = false
					SetPlayerControl(GetPlayerId(), true)
					TaskLeaveCar(GetPlayerChar(-1), GetCarCharIsUsing(GetPlayerChar(-1)))
					SendMessageToNearbyPlayers("" .. GetPlayerName(requester) .. " has pushed " .. GetPlayerName(target) .. " out of their vehicle.", 20)
					while IsCharInAnyCar(GetPlayerChar(-1)) do
						Wait(0)
					end
					SetPlayerControl(GetPlayerId(), false)
					cuff = true
					--TriggerServerEvent('sendMessageToPlayer', requester, "This player is handcuffed.")
				end)
			end
		elseif(id == "search") then
			SendMessageToNearbyPlayers("" .. GetPlayerName(requester) .. " has searched " .. GetPlayerName(target) .. ".", 20)
			local temptext = {}
			if(driverlicense == 1) then
				temptext[#temptext+1] = "Driver license"
			end
			if(weaponlicense == 1) then
				temptext[#temptext+1] = "Weapon license"
			end
			if(huntlicense == 1) then
				temptext[#temptext+1] = "Hunting license"
			end
			if(drugs > 0) then
				temptext[#temptext+1] = "Drugs (" .. drugs .. ")"
			end
			if(#temptext > 0) then
				local finaltext = ""
				for i=1,#temptext,1 do
					if(i ~= #temptext) then
						finaltext = finaltext .. temptext[i] .. ", "
					else
						finaltext = finaltext .. temptext[i] .. "."
					end
				end
				TriggerServerEvent('sendMessageToPlayer', requester, "You have found: " .. finaltext)
			else
				TriggerServerEvent('sendMessageToPlayer', requester, "You have found nothing.")
			end
		elseif(id == "arrest") then
			if cuff then
				if(wanted > 0) then
					SetDefaultSkin()
					RemoveAllCharWeapons(GetPlayerChar(-1))
					SetPlayerControl(GetPlayerId(), true)
					SetCharCoordinates(GetPlayerChar(-1), 81.62646, 1208.80212, 14.73794) --jail
					jailtime = 300*wanted
					TriggerServerEvent('addMoneyToPlayer', requester, 300*wanted)
					wanted = 0
					SaveStats()
					cuff = false
					followplayer = -1
					--SendMessageToNearbyPlayers("" .. GetPlayerName(requester) .. " has imprisoned " .. GetPlayerName(target) .. ".", 20)
					TriggerServerEvent('sendMessageToEveryone', "" .. GetPlayerName(requester) .. " has imprisoned " .. GetPlayerName(target) .. " for " .. jailtime .. " seconds.")
				else
					TriggerServerEvent('sendMessageToPlayer', requester, "This player is not wanted.")
				end
			else
				TriggerServerEvent('sendMessageToPlayer', requester, "This player is not handcuffed.")
			end
		elseif(id == "removedriver") then
			if cuff then
				if(driverlicense == 1) then
					driverlicense = 0
					SaveStats()
					Notify("Your driver license has been removed by " .. GetPlayerName(requester) .. ".")
					TriggerServerEvent('sendMessageToPlayer', requester, "You have removed the driver license of " .. GetPlayerName(target) .. ".")
				else
					TriggerServerEvent('sendMessageToPlayer', requester, "This player does not have a driver license.")
				end
			else
				TriggerServerEvent('sendMessageToPlayer', requester, "This player is not handcuffed.")
			end
		elseif(id == "removeweapon") then
			if cuff then
				if(weaponlicense == 1) then
					weaponlicense = 0
					SaveStats()
					Notify("Your weapon license has been removed by " .. GetPlayerName(requester) .. ".")
					TriggerServerEvent('sendMessageToPlayer', requester, "You have removed the weapon license of " .. GetPlayerName(target) .. ".")
				else
					TriggerServerEvent('sendMessageToPlayer', requester, "This player does not have a weapon license.")
				end
			else
				TriggerServerEvent('sendMessageToPlayer', requester, "This player is not handcuffed.")
			end
		elseif(id == "addwanted") then
			if(wanted < 6) then
				wanted = wanted + 1
				SaveStats()
				TriggerServerEvent('sendMessageToPlayer', requester, "You have increased wanted level of " .. GetPlayerName(target) .. ".")
				TriggerServerEvent('sendMessageToEveryonePolice', "^1" .. GetPlayerName(requester) .. " has increased wanted level of " .. GetPlayerName(target) .. ". Reason: " .. args[1])
			end
			Notify("Your wanted level has been increased by " .. GetPlayerName(requester) .. ". Reason: " .. args[1])
		elseif(id == "removewanted") then
			if(wanted > 0) then
				wanted = wanted - 1
				SaveStats()
				TriggerServerEvent('sendMessageToPlayer', requester, "You have decreased wanted level of " .. GetPlayerName(target) .. ".")
				TriggerServerEvent('sendMessageToEveryonePolice', "" .. GetPlayerName(requester) .. " has decreased wanted level of " .. GetPlayerName(target) .. ".")
			end
			Notify("Your wanted level has been decreased by " .. GetPlayerName(requester) .. ".")
		end
	end
end)

RegisterNetEvent('sendMessageToNOOSE')
AddEventHandler('sendMessageToNOOSE', function(message)
	if(CheckFaction("NOOSE")) then
		if(leader==1 or rank>=5) then
			Notify("Police: " .. message)
		end
	end
end)

TriggerServerEvent('registerCommand', "tonoose")
RegisterNetEvent('performCommand')
AddEventHandler('performCommand', function(command, args)
	if(command == "tonoose") then
		if(#args > 0) then
			if(CheckFaction("Police")) then
				if(leader==1 or rank>=5) then
					TriggerServerEvent('sendMessageToNOOSE', table.concat(args, " "))
					Notify("You to NOOSE: " .. table.concat(args, " "))
				else
					Notify("You must be a police leader or rank 5 policeman to use it.")
				end
			else
				Notify("You are not a policeman.")
			end
		else
			Notify("^1Usage: /tonoose <message>")
		end
	end
end)

local coords = {
{42.36866, 1245.04187, 20.19133, 358.636749267578, 0},
{-47.29959, 1622.55969, 13.11776, 27.3034706115723, 0},
{-373.18671, 1760.43982, 10.21416, 89.747200012207, 0},
{-552.28497, 1406.33313, 15.4772, 177.698486328125, 0},
{-550.53387, 794.50122, 8.59435, 179.550308227539, 0},
{-456.50928, 731.54053, 9.9572, 178.05744934082, 0},
{-441.79065, 255.40254, 9.95192, 268.847534179688, 0},
{98.64592, 249.74232, 18.94509, 269.143341064453, 0},
{956.15979, 241.6693, 46.66864, 241.025177001953, 0},
{1104.13135, 308.1593, 31.19018, 356.120880126953, 0},
{1407.69043, 924.89752, 14.03946, 317.31396484375, 0},
{2020.22144, 747.58264, 11.24132, 200.570541381836, 0},
{2058.00195, 412.26901, 20.90113, 161.766387939453, 0},
{1622.72302, 301.526, 9.23282, 72.2150802612305, 0},
{1230.93591, 301.58624, 32.37741, 78.0350189208984, 0},
{1092.07385, 213.87386, 31.29708, 178.356399536133, 0},
{1076.03149, -74.16289, 36.30001, 191.117568969727, 0},
{1104.75427, -268.38385, 20.71227, 88.0823593139648, 0},
{996.23041, -282.12341, 21.61863, 183.851028442383, 0},
{1006.46539, -370.88983, 20.20606, 104.742340087891, 0},
{137.35814, -426.53775, 14.74566, 176.835296630859, 0},
{124.00893, -703.76666, 5.01467, 118.868347167969, 0},
{-211.99611, -768.79498, 4.81597, 357.950134277344, 0},
{-392.22549, -324.6528, 4.96612, 56.4650611877441, 0},
{-538.48004, 278.45178, 6.7131, 11.1783075332642, 0},
{-636.50964, 1161.38135, 19.48216, 268.932983398438, 0},
{126.26241, 1185.60815, 14.7078, 357.783111572266, 0},
{86.38477, 1240.37561, 15.92305, 193.429626464844, 0}
}

local orders = {}
RegisterNetEvent('addPoliceOrder')
AddEventHandler('addPoliceOrder', function(id, x, y, z)
	for i=1,#orders,1 do
		if(orders[i][1] == id) then
			orders[i] = {id, x, y, z}
			goto skip
		end
	end
	orders[#orders+1] = {id, x, y, z}
	::skip::
	if(CheckFaction("Police")) then
		Notify('New police request has been added to the list.')
	end
end)
RegisterNetEvent('removePoliceOrder')
AddEventHandler('removePoliceOrder', function(id)
	for i=1,#orders,1 do
		if(orders[i][1] == id) then
			orders = RemoveFromTable(orders, i)
			break
		end
	end
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		Notify('Your police request has been accepted. Please wait...')
	end
end)

local roblist = {}
RegisterNetEvent('addRobbery')
AddEventHandler('addRobbery', function(shop, x, y, z)
	for i=1,#roblist,1 do
		if(roblist[i][1] == shop) then
			roblist[i] = {shop, x, y, z}
			goto skip
		end
	end
	roblist[#roblist+1] = {shop, x, y, z}
	::skip::
	if(CheckFaction("Police")) then
		Notify('[Emergency] Robbery ongoing.')
	end
end)
RegisterNetEvent('removeRobbery')
AddEventHandler('removeRobbery', function(shop)
	for i=1,#roblist,1 do
		if(roblist[i][1] == shop) then
			roblist = RemoveFromTable(roblist, i)
			break
		end
	end
end)

local mainjobblip = nil
local jailwall = nil
local invwall = nil
local jobblip = nil
local jobblip2 = nil
local polcar = nil
local coord = 0
local barr = {}
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
			mainjobblip = AddBlipForCoord(93.60903, 1211.40063, 14.73794)
			ChangeBlipSprite(mainjobblip, 60)
			--ChangeBlipColour(mainjobblip, 1)
			ChangeBlipNameFromAscii(mainjobblip, "Police")
			SetBlipAsShortRange(mainjobblip, true)
			ChangeBlipScale(mainjobblip, 0.7)
		end
		if(not DoesObjectExist(jailwall)) then
			jailwall = SpawnObject(GetHashKey("cj_gate_dock"), 83.1801681518555, 1210.69030761719, 15.4912242889404, 180.598510742188)
			SetObjectStopCloning(jailwall, true)
		end
		if(not DoesObjectExist(invwall)) then
			invwall = SpawnObject(GetHashKey("cj_gate_dock"), 80.1874923706055, 1207.630859375, 15.4912271499634, 89.7197494506836)
			SetObjectStopCloning(invwall, true)
			SetObjectVisible(invwall, false)
		end
		DrawTextAtCoord(78.93857, 1216.22412, 19.09158, "Police_Press[E]", 10)
		admin =1
		if(IsPlayerNearCoords(78.93857, 1216.22412, 19.09158, 1)) then
				PrintText('locker_Press[E]',1000)
			if(job == "Police") then
				if(not CheckFaction("Police")) then
					
					if(IsGameKeyboardKeyJustPressed(18)) then
						local model = 0
						if(gender == 1) then
							model = GetHashKey("M_Y_COP")
						else
							model = GetHashKey("M_Y_COP")
						end
						SetPlayerSkin(model)
						Notify('Duty has been started. Use X button to open police menu.')
					end
				else
					PrintText('locker_Press[E]',1000)
					if(IsGameKeyboardKeyJustPressed(18)) then
						::main::
						local tempitems = {}
						tempitems[#tempitems+1] = "Start patrol"
						tempitems[#tempitems+1] = "Equipment"
						tempitems[#tempitems+1] = "Vehicles"
						tempitems[#tempitems+1] = "Finish duty"
						DrawWindow("Police station", tempitems)
						while menuactive do
							Wait(0)
						end
						if(menuresult > 0) then
							if(tempitems[menuresult] == "Start patrol") then
								jobblip = AddBlipForCoord(coords[1][1], coords[1][2], coords[1][3])
								SetRoute(jobblip, true)
								coord = 1
								Notify('Patrol has been started.')
							elseif(tempitems[menuresult] == "Equipment") then
								::weps::
								local weps = {
								{"Armor vest", 1, 15, 13, 100},
								{"Ammo", 1, 15, 13, 100},
								{"Glock 17", 2, 7, 6, 500},
								{"Special", 4, 13, 11, 50000},
								{"Carbine", 5, 15, 13, 30000},
								{"Stun Gun", 1, 29, 7, 500},
								}
								local tempitems = {}
								for i=1,#weps,1 do
									tempitems[i] = weps[i][1] .. " (Rank " .. weps[i][2] .. ")"
								end
								DrawWindow("Equipment", tempitems)
								while menuactive do
									Wait(0)
								end
								if(menuresult > 0) then
									if(rank >= weps[menuresult][2]) then
										if(inventory[34] >= weps[menuresult][5]) then
											if(menuresult == 1) then
												AddArmourToChar(GetPlayerChar(-1), 100)
												RemoveItem(34, weps[menuresult][5])
											elseif(menuresult == 2) then
												AddItem(31, 1)
												RemoveItem(34, weps[menuresult][5])
											else
												GiveWeaponToChar(GetPlayerChar(-1), weps[menuresult][3], 30, 1)
												AddItem(weps[menuresult][4], 1)
												RemoveItem(34, weps[menuresult][5])
											end
										else
											Notify('Not enough money.')	
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
								{"Stanier", 1, "police"},
								{"Merit", 2, "police2"},
								{"Buffalo", 3, "police3"},
								{"Police Bike", 4, "policeb"},
								{"Stinger", 5, "police4"}
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
										DeleteCar(polcar)
										polcar = SpawnCar(GetHashKey(vehs[menuresult][3]), 69.85719, 1247.5957, 16.00591, 271.920379638672)
										--AllowVeh(polcar)
										Notify('Vehicle spawned near the police station.')
									else
										Notify('Your rank is too low to use it.')
									end
									goto vehs
								else
									goto main
								end
							elseif(tempitems[menuresult] == "Finish duty") then
								RemoveBlip(jobblip)
								RemoveBlip(jobblip2)
								SetDefaultSkin()
								Notify('Duty has been finished.')
							end
						end
					end
				end
			end
		end
		if(DoesBlipExist(jobblip)) then
			local bp = GetBlipCoords(jobblip)
			DrawCheckpoint(bp.x, bp.y, bp.z-1, 1.1, 255, 3, 30, 100)
			if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 3)) then
				if(coord ~= #coords) then
					coord = coord + 1
					SetBlipCoordinates(jobblip, coords[coord][1], coords[coord][2], coords[coord][3])
					SetRoute(jobblip, true)
				else
					coord = 0
					RemoveBlip(jobblip)
					AddItem(34, 700)
							--money = money + 500
					SaveStats()
					Notify("+700$", 5000)
					Notify("Patrol has been finished. You have got 600$")
				end
			end
		end
		
		if(job == "Police") then
			if(CheckFaction("Police")) then
				AlterWantedLevel(GetPlayerId(), 0)
				ApplyWantedLevelChangeNow(GetPlayerId())
				if(IsGameKeyboardKeyJustPressed(JobKey)) then
					::main::
					local tempitems = {}
					tempitems[#tempitems+1] = "Requests"
					tempitems[#tempitems+1] = "Robberies"
					tempitems[#tempitems+1] = "Increase wanted level"
					tempitems[#tempitems+1] = "Decrease wanted level"
					tempitems[#tempitems+1] = "Send message to NOOSE"
					if(not IsCharInAnyCar(GetPlayerChar(-1))) then
						tempitems[#tempitems+1] = "Place barricade"
						for i=1,#barr,1 do
							if(DoesObjectExist(barr[i])) then
								local ox,oy,oz = GetObjectCoordinates(barr[i])
								if(IsPlayerNearCoords(ox, oy, oz, 3)) then
									tempitems[#tempitems+1] = "Remove barricade"
									break
								end
							end
						end
					end
					DrawWindow("Police menu", tempitems)
					while menuactive do
						Wait(0)
					end
					if(menuresult > 0) then
						if(tempitems[menuresult] == "Requests") then
							if(not DoesBlipExist(jobblip2)) then
								local tempitems = {}
								for i=1,#orders,1 do
									local streetname = GetStreetAtCoord(orders[i][2], orders[i][3], orders[i][4])
									local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
									local dist = GetDistanceBetweenCoords(px, py, pz, orders[i][2], orders[i][3], orders[i][4])
									tempitems[i] = streetname .. " (" .. math.floor(dist) .. "m)"
								end
								DrawWindow("Request list", tempitems)
								while menuactive do
									Wait(0)
								end
								if(menuresult > 0) then
									local order = orders[menuresult]
									jobblip2 = AddBlipForCoord(orders[menuresult][2], orders[menuresult][3], orders[menuresult][4])
									SetRoute(jobblip2, true)
									TriggerServerEvent('removePoliceOrder', orders[menuresult][1])
								else
									goto main
								end
							else
								DrawWindow("Request list", {"Cancel current request"})
								while menuactive do
									Wait(0)
								end
								if(menuresult == 1) then
									RemoveBlip(jobblip2)
								end
							end
						elseif(tempitems[menuresult] == "Robberies") then
								if(not DoesBlipExist(jobblip5)) then
									local tempitems = {}
									for i=1,#roblist,1 do
										local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
										local dist = GetDistanceBetweenCoords(px, py, pz, roblist[i][2], roblist[i][3], roblist[i][4])
										tempitems[i] = "A "..shop.." robbery is happening at " ..streetname .. " (" .. math.floor(dist) .. "m)"
									end
									DrawWindow("Robbery list", tempitems)
									while menuactive do
										Wait(0)
									end
									if(menuresult > 0) then
										local order = roblist[menuresult]
										jobblip5 = AddBlipForCoord(roblist[menuresult][2], roblist[menuresult][3], roblist[menuresult][4])
										SetRoute(jobblip5, true)
										TriggerServerEvent('removePoliceOrder', roblist[menuresult][1])
									else
										goto main
									end
								else
									DrawWindow("Robbery list", {"Cancel current request"})
									while menuactive do
										Wait(0)
									end
									if(menuresult == 1) then
										RemoveBlip(jobblip5)
									end
								end
						elseif(tempitems[menuresult] == "Increase wanted level") then
							local tempitems = {}
							local tempids = {}
							for j=0,31,1 do
								if(IsNetworkPlayerActive(j)) then
									if(ConvertIntToPlayerindex(j) ~= ConvertIntToPlayerindex(GetPlayerId())) then
										tempitems[#tempitems+1] = GetPlayerName(j) .. "(" .. j .. ")"
										tempids[#tempids+1] = j
									end
								end
							end
							DrawWindow("Select player", tempitems)
							while menuactive do
								Wait(0)
							end
							if(menuresult > 0) then
								local reason = ActivateInput("Enter a reason")
								if(reason ~= "") then
									TriggerServerEvent('performPoliceRequest', tempids[menuresult], ConvertIntToPlayerindex(GetPlayerId()), "addwanted", {reason})
								end
							else
								goto main
							end
						elseif(tempitems[menuresult] == "Decrease wanted level") then
							local tempitems = {}
							local tempids = {}
							for j=0,31,1 do
								if(IsNetworkPlayerActive(j)) then
									if(ConvertIntToPlayerindex(j) ~= ConvertIntToPlayerindex(GetPlayerId())) then
										tempitems[#tempitems+1] = GetPlayerName(j) .. "(" .. j .. ")"
										tempids[#tempids+1] = j
									end
								end
							end
							DrawWindow("Select player", tempitems)
							while menuactive do
								Wait(0)
							end
							if(menuresult > 0) then
								TriggerServerEvent('performPoliceRequest', tempids[menuresult], ConvertIntToPlayerindex(GetPlayerId()), "removewanted")
							else
								goto main
							end
						elseif(tempitems[menuresult] == "Send message to NOOSE") then
							if(leader==1 or rank>=5) then
								local message = ActivateInput("Enter a message")
								if(message ~= "") then
									TriggerServerEvent('sendMessageToNOOSE', message)
									Notify("You to NOOSE: " .. message)
								end
							else
								Notify("You must be a police leader or rank 5 policeman to use it.")
								goto main
							end
						elseif(tempitems[menuresult] == "Place barricade") then
							if(#barr < 3) then
								local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
								local ph = GetCharHeading(GetPlayerChar(-1))
								barr[#barr+1] = SpawnObject(GetHashKey("cj_barrier_7"), px+2*math.cos((ph+90)*math.pi/180), py+2*math.sin((ph+90)*math.pi/180), pz-1, ph)
								FreezeObjectPosition(barr[#barr], true)
								CreateThread(function()
									local tempobj = barr[#barr]
									local tempid = #barr
									Wait(600000)
									if(DoesObjectExist(tempobj)) then
										DeleteObject(tempobj)
										barr[tempid] = nil
									end
								end)
							else
								Notify("Maximum amount of barricades reached.")
								goto main
							end
						elseif(tempitems[menuresult] == "Remove barricade") then
							for i=1,#barr,1 do
								if(DoesObjectExist(barr[i])) then
									local ox,oy,oz = GetObjectCoordinates(barr[i])
									if(IsPlayerNearCoords(ox, oy, oz, 3)) then
										DeleteObject(barr[i])
										barr[i] = nil
										break
									end
								end
							end
						end
					end
				end
			end
		end
		if(DoesBlipExist(jobblip2)) then
			local bp = GetBlipCoords(jobblip2)
			DrawCheckpoint(bp.x, bp.y, bp.z-1, 1.1, 255, 3, 30, 100)
			if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 10)) then
				RemoveBlip(jobblip2)
			end
		end
		if(IsPlayerDead(GetPlayerId())) then
			RemoveBlip(jobblip)
			RemoveBlip(jobblip2)
			--DeleteEntity(polcar)
		end
	end
end)

RegisterNetEvent('stunPlayer')
AddEventHandler('stunPlayer', function(id)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		if(IsPlayerDead(GetPlayerId())) then
			local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
			local ph = GetCharHeading(GetPlayerChar(-1))
			ResurrectNetworkPlayer(GetPlayerId(), px, py, pz, ph)
			SetCharHealth(GetPlayerChar(-1), hp)
			ClearCharLastDamageEntity(GetPlayerChar(-1))
		end
		--SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1))+damage)
		SetCharHealth(GetPlayerChar(-1), hp)
		--AddArmourToChar(GetPlayerChar(-1), ap)
		SwitchPedToRagdoll(GetPlayerChar(-1), 60000, 10000, 2, 1, 1, 0)
		--[[PlayAnim("amb@wasted_b", "idle_a", 1)
		CreateThread(function()
			SetPlayerControl(GetPlayerId(), false)
			Wait(10000)
			SetPlayerControl(GetPlayerId(), true)
			if not cuff then
				ClearCharTasksImmediately(GetPlayerChar(-1))
			end
		end)]]
	end
end)
--[[local damage = {}
for i=0,31,1 do
	damage[i] = {}
	for j=0,20,1 do
		damage[i][j] = 0
	end
end]]
CreateThread(function()
	while true do
		Wait(0)
		if(CheckFaction("Police")) then
			for i=0,31,1 do
				if(IsNetworkPlayerActive(i)) then
					--for j=0,20,1 do
						if(not IsPlayerDead(i)) then
							--local tempdamage = GetDamageToPedBodyPart(GetPlayerChar(i), j)
							--if(tempdamage > damage[i][j]) then
								if(HasCharBeenDamagedByChar(GetPlayerChar(i), GetPlayerChar(-1), false)) then
									--local finaldamage = tempdamage - damage[i][j]
									local gw,cw = GetCurrentCharWeapon(GetPlayerChar(-1))
									if(cw == 29) then
										TriggerServerEvent('stunPlayer', i)
									end
									ClearCharLastDamageEntity(GetPlayerChar(i))
								end
							--	damage[i][j] = tempdamage
							--end
						--else
						--	damage[i][j] = 0
						end
					--end
				end
			end
		else
			if(HasCharGotWeapon(GetPlayerChar(-1), 29)) then
				RemoveWeaponFromChar(GetPlayerChar(-1), 29)
			end
		end
	end
end)

local killblocker = {}
for i=0,31,1 do
	killblocker[i] = 0
end
CreateThread(function()
	while true do
		Wait(0)
		if(not CheckFaction("Police") and not CheckFaction("NOOSE")) then
			for i=0,31,1 do
				if(IsNetworkPlayerActive(i)) then
					if(IsPlayerDead(i)) then
						if(ConvertIntToPlayerindex(i) ~= ConvertIntToPlayerindex(GetPlayerId())) then
							if(killblocker[i] == 0) then
								if(FindNetworkKillerOfPlayer(i) == GetPlayerId()) then
									local checker = 0
									if(CheckFaction("Spanish Lords") or CheckFaction("Yardies") or CheckFaction("Hustlers")) then
										if(CheckFaction("Spanish Lords", i) or CheckFaction("Yardies", i) or CheckFaction("Hustlers", i)) then
											checker = 1
										end
									end
									if(checker == 0) then
										if(wanted < 6) then
											wanted = wanted + 1
											SaveStats()
										end
									end
								end
								killblocker[i] = 1
							end
						end
					else
						killblocker[i] = 0
					end
				end
			end
		end
	end
end)