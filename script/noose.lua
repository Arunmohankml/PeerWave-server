RegisterNetEvent('performNOOSERequest')
AddEventHandler('performNOOSERequest', function(target, requester, id, args)
	if(ConvertIntToPlayerindex(target) == ConvertIntToPlayerindex(GetPlayerId())) then
		
	end
end)

RegisterNetEvent('sendMessageToPolice')
AddEventHandler('sendMessageToPolice', function(message)
	if(CheckFaction("police")) then
		if(leader==1 or rank>=5) then
			Notify("Police: " .. message)
		end
	end
end)

TriggerServerEvent('registerCommand', "topolice")
RegisterNetEvent('performCommand')
AddEventHandler('performCommand', function(command, args)
	if(command == "topolice") then
		if(#args == 1) then
			args[1] = table.concat(args, " ")
			if(CheckFaction("NOOSE")) then
				if(leader==1 or rank>=5) then
					TriggerServerEvent('sendMessageToPolice', args[1])
					Notify("You to Police: " .. args[1])
				else
					Notify("You must be a NOOSE leader or rank 5 soldier to use it.")
				end
			else
				Notify("You are not a NOOSE soldier.")
			end
		else
			Notify("^1Usage: /topolice <message>")
		end
	end
end)

local coords = {
{-882.64642, 1306.45605, 21.97778, 271.504272460938, 0},
{69.65195, 1248.31555, 16.00591, 87.8651351928711, 0},
{93.22361, 673.26471, 14.52513, 40.6614837646484, 0},
{-391.39401, -250.1143, 12.71012, 86.5496826171875, 0},
{1244.97961, 576.39258, 38.50734, 356.486846923828, 0},
{2110.77661, 432.64651, 6.08471, 267.861022949219, 0}
}

local mainjobblip = nil
local jobblip = nil
local armycar = nil
local truck = nil
CreateThread(function()
	while true do
		Wait(0)
		if(not DoesBlipExist(mainjobblip)) then
			mainjobblip = AddBlipForCoord(-1083.08215, -352.15305, 3.41661)
			ChangeBlipSprite(mainjobblip, 7)
			--ChangeBlipColour(mainjobblip, 1)
			ChangeBlipNameFromAscii(mainjobblip, "NOOSE")
			SetBlipAsShortRange(mainjobblip, true)
			ChangeBlipScale(mainjobblip, 0.7)
		end
		DrawCheckpointWithDist(-1083.08215, -352.15305, 3.41661-1, 1.1, 0, 0, 255, 100)
		if(currleader["NOOSE"] == "None") then
			DrawTextAtCoord(-1083.08215, -352.15305, 3.41661, "NOOSE Leader:_None Press_R_to_become_leader", 20)
		else
			DrawTextAtCoord(-1083.08215, -352.15305, 3.41661, "NOOSE Leader:_" .. GetStringWithoutSpaces(currleader["NOOSE"]), 20)
		end
		if(IsPlayerNearCoords(-1083.08215, -352.15305, 3.41661, 1)) then
			if(currleader["NOOSE"] == "None") then
				if(IsGameKeyboardKeyJustPressed(19)) then
					if(job=="0" or job=="NOOSE") then
						if(level>=4 and money>=50000) then
							DrawWindow("Are you sure you want to become a leader?", {"Yes", "No"})
							while menuactive do
								Wait(0)
							end
							if(menuresult == 1) then
								currleader["NOOSE"] = GetPlayerName(GetPlayerId())
								SaveLeaders()
								job = "NOOSE"
								leader = 1
								rank = 5
								RemoveItem(34, 500)
								SaveStats()
							end
						else
							Notify("You need to reach level 4 and have 50000$ to become a leader.")
						end
					else
						Notify("You are already a member of another faction.")
					end
				end
			end
			if(job == "NOOSE") then
				if(not CheckFaction("NOOSE")) then
					PrintText("Press ~y~E ~w~to ~y~start duty", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						local model = 0
						if(gender == 1) then
							model = GetHashKey("M_Y_SWAT")
						else
							model = GetHashKey("M_Y_SWAT")
						end
						SetPlayerSkin(model)
						SetCharComponentVariation(GetPlayerChar(-1), 0, 0, 0)
						Notify('Duty has been started.')
					end
				else
					PrintText("Press ~y~E ~w~to ~y~open NOOSE menu", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						::main::
						local tempitems = {}
						if(not DoesBlipExist(jobblip)) then
							tempitems[#tempitems+1] = "Start convoy"
						else
							tempitems[#tempitems+1] = "Finish convoy"
						end
						tempitems[#tempitems+1] = "Equipment"
						tempitems[#tempitems+1] = "Vehicles"
						tempitems[#tempitems+1] = "Finish duty"
						DrawWindow("NOOSE base", tempitems)
						while menuactive do
							Wait(0)
						end
						if(menuresult > 0) then
							if(tempitems[menuresult] == "Start convoy") then
								DeleteCar(truck)
								truck = SpawnCar(GetHashKey("pstockade"), -1121.02539, -368.36652, 3.13523, 177.51139831543)
								ChangeCarColour(truck, 1, 1)
								--AllowVeh(truck)
								WarpCharIntoCar(GetPlayerChar(-1), truck)
								local rnd = GenerateRandomIntInRange(1, #coords+1)
								jobblip = AddBlipForCoord(coords[rnd][1], coords[rnd][2], coords[rnd][3])
								SetRoute(jobblip, true)
								Notify('Convoy has been started.')
							elseif(tempitems[menuresult] == "Finish convoy") then
								RemoveBlip(jobblip)
								DeleteCar(truck)
								Notify("Convoy has been aborted.")
							elseif(tempitems[menuresult] == "Equipment") then
								::weps::
								local weps = {
								{"Automatic Pistol", 1, 27, 17},
								{"P90", 2, 32, 50},
								{"Combat Shotgun", 3, 11, 10},
								{"M4", 4, 15, 30},
								{"Sniper Rifle", 5, 16, 10}
								}
								local tempitems = {}
								for i=1,#weps,1 do
									tempitems[i] = weps[i][1] .. " (Rank " .. weps[i][2] .. ")"
								end
								tempitems[#tempitems+1] = "Armor vest (Rank 2)"
								DrawWindow("Equipment", tempitems)
								while menuactive do
									Wait(0)
								end
								if(menuresult > 0) then
									if(menuresult <= #weps) then
										if(rank >= weps[menuresult][2]) then
											GiveWeaponToChar(GetPlayerChar(-1), weps[menuresult][3], weps[menuresult][4], 1)
										else
											Notify('Your rank is too low to use it.')
										end
									else
										if(rank >= 2) then
											AddArmourToChar(GetPlayerChar(-1), 100)
										else
											Notify('Your rank is too low to use it.')
										end
									end
									goto weps
								else
									goto main
								end
							elseif(tempitems[menuresult] == "Vehicles") then
								::vehs::
								local vehs = {
								{"Stanier", 1, "noose"},
								{"Patriot", 2, "polpatriot"},
								{"Stockade", 3, "pstockade"},
								{"Buffalo", 4, "fbi"},
								{"APC", 5, "apc"}
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
										DeleteCar(armycar)
										armycar = SpawnCar(GetHashKey(vehs[menuresult][3]), -1121.02539, -368.36652, 3.13523, 177.51139831543)
										--AllowVeh(armycar)
										ChangeCarColour(armycar, 0, 0)
										Notify('Vehicle spawned near the NOOSE base.')
									else
										Notify('Your rank is too low to use it.')
									end
									goto vehs
								else
									goto main
								end
							elseif(tempitems[menuresult] == "Finish duty") then
								SetDefaultSkin()
								Notify('Duty has been finished.')
							end
						end
					end
				end
			else
				PrintText('To join this faction, contact the faction leader or press ~y~E ~w~to join for ~g~15000$', 1)
				if(IsGameKeyboardKeyJustPressed(18)) then
					if(job == "0") then
						if(level >= 3) then
							if(driverlicense == 1) then
								if(weaponlicense == 1) then
									if(inventory[34] >= 15000) then
										RemoveItem(34, 150)
										job = "NOOSE"
										rank = 1
										SaveStats()
									else
										Notify("You do not have enough money.")
									end
								else
									Notify("You must have a weapon license.")
								end
							else
								Notify("You must have a driver license.")
							end
						else
							Notify("You must reach level 3 to do that.")
						end
					else
						Notify("You are already a member of another faction.")
					end
				end
			end
		end
		if(DoesBlipExist(jobblip)) then
			if(not IsCarDead(truck)) then
				local bp = GetBlipCoords(jobblip)
				DrawCheckpoint(bp.x, bp.y, bp.z-1, 1.1, 255, 3, 30, 100)
				if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 3)) then
					if(IsCharInCar(GetPlayerChar(-1), truck)) then
						PrintText("Press ~y~E ~w~to unload the truck", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							RemoveBlip(jobblip)
							armycar = truck
							truck = nil
							ChangeCarColour(armycar, 0, 0)
							AddItem(34, 900)
							--money = money + 500
							SaveStats()
							Notify("Convoy has been finished. You have got 500$.")
						end
					else
						PrintText("~r~You must be in a military truck", 1)
					end
				end
				if(IsPlayerDead(GetPlayerId())) then
					RemoveBlip(jobblip)
					--DeleteEntity(truck)
				end
			else
				RemoveBlip(jobblip)
				--DeleteEntity(truck)
			end
		end
		
		if(job == "NOOSE") then
			if(CheckFaction("NOOSE")) then
				AlterWantedLevel(GetPlayerId(), 0)
				ApplyWantedLevelChangeNow(GetPlayerId())
				if(leader==1 or rank>=5) then
					if(IsGameKeyboardKeyJustPressed(JobKey)) then
						::main::
						local tempitems = {}
						tempitems[#tempitems+1] = "Send message to Police"
						DrawWindow("NOOSE menu", tempitems)
						while menuactive do
							Wait(0)
						end
						if(menuresult > 0) then
							if(tempitems[menuresult] == "Send message to Police") then
								if(leader==1 or rank>=5) then
									local message = ActivateInput("Enter a message")
									if(message ~= "") then
										TriggerServerEvent('sendMessageToPolice', message)
										Notify("You to Police: " .. message)
									end
								else
									Notify("You must be an NOOSE leader or rank 5 soldier to use it.")
									goto main
								end
							end
						end
					end
				end
			end
		end
	end
end)