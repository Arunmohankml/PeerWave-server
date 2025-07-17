local adminjail = 0
local revive = 0
local no = 1
local videditor = 0 
local freezecam = 0
local visible = 0
local speccamon = 0

helper = 0
admin = 0
RegisterNetEvent('updAdmin')
AddEventHandler('updAdmin', function(padmin)
	admin = tonumber(padmin)
end)


adm = {
"Kick",
"spec",
"Ban account",
"Ban IP",
"Set faction",
"Bug fix",
"Set leader",
"Remove leader",
"Display player info",
"Display/Hide Names",
"Give community Work",
"Get Money",
"Make Player Admin",
"Drag Player",
"Drag Everyone",
"WEAPONS",
"ADMIN JAIL",
"REVIVE",
"REVIVE All",
"videditor",
"Turfwar" 
}
hlp = {
	"Drag Player",
	"Display player info",
	"REVIVE",
	"videditor"
}
function IsPlayerNearCoords(x, y, z, radius)
    local pos = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
    local dist = GetDistanceBetweenCoords3d(x, y, z, pos[1], pos[2], pos[3])
    if(dist < radius) then return true
    else return false
    end
end

RegisterNetEvent('requestKick2')
AddEventHandler('requestKick2', function(id)
	if(GetPlayerChar(-1) == GetPlayerChar(id)) then
		TriggerServerEvent('kickPlayer2')
	end
end)
RegisterNetEvent('requestBan2')
AddEventHandler('requestBan2', function(id)
	if(GetPlayerChar(-1) == GetPlayerChar(id)) then
		TriggerServerEvent('banPlayer')
	end
end)
RegisterNetEvent('requestBanIP2')
AddEventHandler('requestBanIP2', function(id)
	if(GetPlayerChar(-1) == GetPlayerChar(id)) then
		TriggerServerEvent('banPlayerIP')
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(GetPlayerName(GetPlayerId()) == "Helper") then
			DisplayPlayerNames(true)
			helper = 1
		end
	end
end)

local playerblips = {}
CreateThread(function()
	while true do
		Wait(0)
		if(admin == 1) then
			if(displayNames == true) then
				for i=0,31,1 do
					if(IsNetworkPlayerActive(i)) then
						if(GetPlayerChar(i, _i) ~= GetPlayerChar(GetPlayerId(), _i)) then
							if(not DoesBlipExist(playerblips[i])) then
								playerblips[i] = AddBlipForChar(GetPlayerChar(i, _i), _i)
								ChangeBlipSprite(playerblips[i], 6)
								ChangeBlipNameFromAscii(playerblips[i], "" .. GetPlayerName(i, _s))
								ChangeBlipColour(playerblips[i], 0)
								SetBlipAsShortRange(playerblips[i], true)
								ChangeBlipScale(playerblips[i], 0.7)
							else
								if(not IsPauseMenuActive()) then
									local rx,ry,rz = GetCamRot(GetGameCam(), _f, _f, _f)
									ChangeBlipRotation(playerblips[i], math.floor(GetCharHeading(GetPlayerChar(i, _i), _f) + 90 - rz))
								else
									ChangeBlipRotation(playerblips[i], math.floor(GetCharHeading(GetPlayerChar(i, _i), _f) + 90))
								end
							end
						end
					else
						if(DoesBlipExist(playerblips[i])) then
							RemoveBlip(playerblips[i])
						end
					end
				end
			end
		end
	end
end)

local supersp = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
			if(IsGameKeyboardKeyJustPressed(87)) then --f11
				if(helper == 1) then
					DrawWindow("Helper Panel!", hlp)
					while menuactive do
						Citizen.Wait(0)
					end
					if(menuresult > 0) then
						if(hlp[menuresult] == "Drag Player") then
							local tempitems = {}
							for i=0,31,1 do
								if(IsNetworkPlayerActive(i)) then
									tempitems[#tempitems+1] = GetPlayerName(i, _s)
								end
							end
							DrawWindow("Select player to drag", tempitems)
							while menuactive do
								Citizen.Wait(0)
							end
							if(menuresult > 0) then
								TriggerServerEvent('performAdminRequest', GetPlayerServerIdFromName(tempitems[menuresult]), GetPlayerServerId(), 20)
								Print(' dragged ' .. tempitems[menuresult])
							end
							
						elseif(hlp[menuresult] == "Display/Hide Names") then
							if(displayNames == false) then
								displayNames = true
								TriggerEvent("noticeme:Info", "Displayed Names. ")
							else
								displayNames = false
								TriggerEvent("noticeme:Info", "Hided Names. ")
							end
						elseif(hlp[menuresult] == "REVIVE") then
							local tempitems = {}
							for i=0,31,1 do
								if(IsNetworkPlayerActive(i)) then
									--if(GetPlayerChar(-1) ~= GetPlayerChar(i)) then
									tempitems[#tempitems+1] = GetPlayerName(i, _s)
									--end
								end
							end
							DrawWindow("SELECT ANYONE TO REVIVE", tempitems)
							while menuactive do
								Citizen.Wait(0)
							end
							if(menuresult > 0) then
								Print(' admin revived ' .. tempitems[menuresult])
								TriggerServerEvent('performAdminRequest', GetPlayerServerIdFromName(tempitems[menuresult]), GetPlayerServerId(), 13)
							end
						elseif(hlp[menuresult] == "Display player info") then
							local tempitems = {}
							for i=0,31,1 do
								if(IsNetworkPlayerActive(i)) then
									tempitems[#tempitems+1] = GetPlayerName(i, _s)
								end
							end
							DrawWindow("Select player to display information", tempitems)
							while menuactive do
								Citizen.Wait(0)
							end
							if(menuresult > 0) then
								TriggerServerEvent('performAdminRequest', GetPlayerServerIdFromName(tempitems[menuresult]), GetPlayerServerId(), 8)
							end
						elseif(hlp[menuresult] == "videditor") then
							videditor = 1
							DisplayRadar(false)
							TriggerEvent('chatMessage', '[Admin]', {255, 0, 0}, 'camera activated')
						end
					end
				end
				if(admin >= 1) then
					DrawWindow("ADMIN PANNEL!", adm)
					while menuactive do
						Citizen.Wait(0)
					end
					if(menuresult > 0) then
						if(adm[menuresult] == "Kick") then
							local tempitems = {}
							for i=0,31,1 do
								if(IsNetworkPlayerActive(i)) then
									if(GetPlayerChar(-1) ~= GetPlayerChar(i)) then
										tempitems[#tempitems+1] = GetPlayerName(i, _s)
									end
								end
							end
							DrawWindow("Select a player to kick", tempitems)
							while menuactive do
								Citizen.Wait(0)
							end
							if(menuresult > 0) then
								if(admin <= 2) then
									TriggerServerEvent('requestKick1', GetPlayerServerIdFromName(tempitems[menuresult]))
									TriggerServerEvent('sendMessageToEveryone', "[Admin]", "Player " .. tempitems[menuresult] .. " was kicked by " .. GetPlayerName(GetPlayerId(), _s))
								end
							end
						elseif(adm[menuresult] == "Drag Player") then
							local tempitems = {}
							for i=0,31,1 do
								if(IsNetworkPlayerActive(i)) then
									tempitems[#tempitems+1] = GetPlayerName(i, _s)
								end
							end
							DrawWindow("Select player to drag", tempitems)
							while menuactive do
								Citizen.Wait(0)
							end
							if(menuresult > 0) then
								TriggerServerEvent('performAdminRequest', GetPlayerServerIdFromName(tempitems[menuresult]), GetPlayerServerId(), 20)
								Print(' dragged ' .. tempitems[menuresult])
							end
						elseif(adm[menuresult] == "Drag Everyone") then
							TriggerServerEvent('performAdminRequest', 1, GetPlayerServerId(), 21)
						elseif(adm[menuresult] == "Bug fix") then
							local tempitems = {}
							for i=0,31,1 do
								if(IsNetworkPlayerActive(i)) then
									tempitems[#tempitems+1] = GetPlayerName(i, _s)
								end
							end
							DrawWindow("Select player to fix", tempitems)
							while menuactive do
								Citizen.Wait(0)
							end
							if(menuresult > 0) then
								TriggerServerEvent('performAdminRequest', GetPlayerServerIdFromName(tempitems[menuresult]), GetPlayerServerId(), 14)
								Print(' Bug fixed ' .. tempitems[menuresult])
							end
						elseif(adm[menuresult] == "Ban account") then
								local tempitems = {}
								for i=0,31,1 do
									if(IsNetworkPlayerActive(i)) then
										if(GetPlayerChar(-1) ~= GetPlayerChar(i)) then
											tempitems[#tempitems+1] = GetPlayerName(i, _s)
										end
									end
								end
								DrawWindow("Select player to ban", tempitems)
								while menuactive do
									Citizen.Wait(0)
								end
								if(menuresult > 0) then
									TriggerServerEvent('requestBan1', GetPlayerServerIdFromName(tempitems[menuresult]))
									TriggerServerEvent('sendMessageToEveryone', "[Admin]", "Player " .. tempitems[menuresult] .. " was banned by " .. GetPlayerName(GetPlayerId(), _s))
								end
						elseif(adm[menuresult] == "Ban IP") then
	
								local tempitems = {}
								for i=0,31,1 do
									if(IsNetworkPlayerActive(i)) then
										if(GetPlayerChar(-1) ~= GetPlayerChar(i)) then
											tempitems[#tempitems+1] = GetPlayerName(i, _s)
										end
									end
								end
								DrawWindow("Select player to ban", tempitems)
								while menuactive do
									Citizen.Wait(0)
								end
								if(menuresult > 0) then
									TriggerServerEvent('requestBanIP1', GetPlayerServerIdFromName(tempitems[menuresult]))
									TriggerServerEvent('sendMessageToEveryone', "[Admin]", "Player " .. tempitems[menuresult] .. " was IP banned by " .. GetPlayerName(GetPlayerId(), _s))
								end
	
						elseif(adm[menuresult] == "Set faction") then
							local tempitems = {}
							for i=0,31,1 do
								if(IsNetworkPlayerActive(i)) then
									--if(GetPlayerChar(-1) ~= GetPlayerChar(i)) then
										tempitems[#tempitems+1] = GetPlayerName(i, _s)
									--end
								end
							end
							DrawWindow("Select player to choose faction", tempitems)
							while menuactive do
								Citizen.Wait(0)
							end
							if(menuresult > 0) then
								local tempid = menuresult
								DrawWindow("Select", {"Police", "EMS", "TVA", "Remove"})
								while menuactive do
									Citizen.Wait(0)
								end
								if(menuresult > 0) then
									if(menuresult == 1) then
										TriggerServerEvent('performAdminRequest', GetPlayerServerIdFromName(tempitems[tempid]), GetPlayerServerId(), 1)
										Print(' set faction of ' .. tempitems[tempid] .. ' to police')
									elseif(menuresult == 2) then
										TriggerServerEvent('performAdminRequest', GetPlayerServerIdFromName(tempitems[tempid]), GetPlayerServerId(), 2)
										Print(' set faction of ' .. tempitems[tempid] .. ' to ems')
									elseif(menuresult == 3) then
										TriggerServerEvent('performAdminRequest', GetPlayerServerIdFromName(tempitems[tempid]), GetPlayerServerId(), 4)
										Print(' set faction of ' .. tempitems[tempid] .. ' to tva')
									elseif(menuresult == 4) then
										TriggerServerEvent('performAdminRequest', GetPlayerServerIdFromName(tempitems[menuresult]), GetPlayerServerId(), 5)
										Print(' removed faction of ' .. tempitems[menuresult])
									end
								end
							end	
						elseif(adm[menuresult] == "Set leader") then
							local tempitems = {}
							for i=0,31,1 do
								if(IsNetworkPlayerActive(i)) then
									--if(GetPlayerChar(-1) ~= GetPlayerChar(i)) then
										tempitems[#tempitems+1] = GetPlayerName(i, _s)
									--end
								end
							end
							DrawWindow("Select the player to set the leader", tempitems)
							while menuactive do
								Citizen.Wait(0)
							end
							if(menuresult > 0) then
								TriggerServerEvent('performAdminRequest', GetPlayerServerIdFromName(tempitems[menuresult]), GetPlayerServerId(), 6)
								Print(' set ' .. tempitems[menuresult] .. ' as  leader')
							end
						elseif(adm[menuresult] == "Remove leader") then
						
								local tempitems = {}
								for i=0,31,1 do
									if(IsNetworkPlayerActive(i)) then
										tempitems[#tempitems+1] = GetPlayerName(i, _s)
									end
								end
								DrawWindow("Select the player to remove the leader", tempitems)
								while menuactive do
									Citizen.Wait(0)
								end
								
								if(menuresult > 0) then
									Print(' removed ' .. tempitems[menuresult] .. ' as leader')
									TriggerServerEvent('performAdminRequest', GetPlayerServerIdFromName(tempitems[menuresult]), GetPlayerServerId(), 7)
								end
						elseif(adm[menuresult] == "Display player info") then
							local tempitems = {}
							for i=0,31,1 do
								if(IsNetworkPlayerActive(i)) then
									tempitems[#tempitems+1] = GetPlayerName(i, _s)
								end
							end
							DrawWindow("Select player to display information", tempitems)
							while menuactive do
								Citizen.Wait(0)
							end
							if(menuresult > 0) then
								TriggerServerEvent('performAdminRequest', GetPlayerServerIdFromName(tempitems[menuresult]), GetPlayerServerId(), 8)
							end
						elseif(adm[menuresult] == "Display/Hide Names") then
							if(displayNames == false) then
								displayNames = true
								TriggerEvent("noticeme:Info", "Displayed Names.")
							else
								displayNames = false
								TriggerEvent("noticeme:Info", "Hided Names.")
							end
						elseif(adm[menuresult] == "Make Player Admin") then
							if(admin >= 1) then
								local tempitems = {}
								for i=0,31,1 do
									if(IsNetworkPlayerActive(i)) then
										--if(GetPlayerChar(-1) ~= GetPlayerChar(i)) then
										tempitems[#tempitems+1] = GetPlayerName(i, _s)
										--end
									end
								end
								DrawWindow("SELECT ANYONE TO Make Admin", tempitems)
								while menuactive do
									Citizen.Wait(0)
								end
								if(menuresult > 0) then
									Print(' set ' .. tempitems[menuresult] .. ' to admin')
									TriggerServerEvent('performAdminRequest', GetPlayerServerIdFromName(tempitems[menuresult]), GetPlayerServerId(), 9)
								end
							end
						elseif(adm[menuresult] == "videditor") then
							videditor = 1
							DisplayRadar(false)
							TriggerEvent('chatMessage', '[Admin]', {255, 0, 0}, 'camera activated')
						elseif(adm[menuresult] == "Get Money") then
							if(admin == 1) then
								adminmoney = 1
							end
						elseif(adm[menuresult] == "WEAPONS") then
							
							DrawWindow("weapons", {"M4", "UZI", "SHOTGUN", "PISTOL", "MOLOTOV", "AK47", "MP5", "SNIPER", "BASEBALL BAT","C4","Tazer",})
							while menuactive do
								Citizen.Wait(0)
							end
	
							if(menuresult == 1) then
								GiveWeaponToChar(GetPlayerChar(-1), 15, 500)
								AddItem(13, 1)
								Print(' took weapon frm admin pannel')
							elseif(menuresult == 2) then
								GiveWeaponToChar(GetPlayerChar(-1), 12, 500)
								AddItem(10, 1)
								Print(' took weapon frm admin pannel')
							elseif(menuresult == 3) then
								GiveWeaponToChar(GetPlayerChar(-1), 10, 500)
								AddItem(8, 1)
								Print(' took weapon frm admin pannel')
							elseif(menuresult == 4) then
								GiveWeaponToChar(GetPlayerChar(-1), 7, 500)
								AddItem(6, 1)
								Print(' took weapon frm admin pannel')
							elseif(menuresult == 5) then
								GiveWeaponToChar(GetPlayerChar(-1), 5, 500)
								AddItem(5, 1)
								Print(' took weapon frm admin pannel')
							elseif(menuresult == 6) then
								GiveWeaponToChar(GetPlayerChar(-1), 14, 500)
								AddItem(12, 1)
								Print(' took weapon frm admin pannel')
							elseif(menuresult == 7) then
								GiveWeaponToChar(GetPlayerChar(-1), 13, 500)
								AddItem(11, 1)
								Print(' took weapon frm admin pannel')
							elseif(menuresult == 8) then
								GiveWeaponToChar(GetPlayerChar(-1), 16, 500)
								AddItem(13, 1)
								Print(' took weapon frm admin pannel')
							elseif(menuresult == 9) then
								GiveWeaponToChar(GetPlayerChar(-1), 1, 500)
								AddItem(13, 1)
								Print(' took weapon frm admin pannel')
							elseif(menuresult == 10) then
								GiveWeaponToChar(GetPlayerChar(-1), 22, 500)
								AddItem(13, 1)
								Print(' took weapon frm admin pannel')
							elseif(menuresult == 11) then
								GiveWeaponToChar(GetPlayerChar(-1), 29, 500)
								AddItem(29, 1)
								Print(' took weapon frm admin pannel')
							end
						elseif(adm[menuresult] == "ADMIN JAIL") then
							if(admin >= 1) then
								local tempitems = {}
								for i=0,31,1 do
									if(IsNetworkPlayerActive(i)) then
										--if(GetPlayerChar(-1) ~= GetPlayerChar(i)) then
										tempitems[#tempitems+1] = GetPlayerName(i, _s)
										--end
									end
								end
								DrawWindow("SELECT ANYONE TO PUT IN ADMIN JAIL", tempitems)
								while menuactive do
									Citizen.Wait(0)
								end
								if(menuresult > 0) then
									TriggerServerEvent('performAdminRequest', GetPlayerServerIdFromName(tempitems[menuresult]), GetPlayerServerId(), 11)
									Print(' admin jailled ' .. tempitems[menuresult])
								end
							end
						elseif(adm[menuresult] == "REVIVE All") then
							if(admin >= 1) then
								TriggerServerEvent('revall')
								Print(' reved all')
							end
						elseif(adm[menuresult] == "REVIVE") then
							local tempitems = {}
							for i=0,31,1 do
								if(IsNetworkPlayerActive(i)) then
									--if(GetPlayerChar(-1) ~= GetPlayerChar(i)) then
									tempitems[#tempitems+1] = GetPlayerName(i, _s)
									--end
								end
							end
							DrawWindow("SELECT ANYONE TO REVIVE", tempitems)
							while menuactive do
								Citizen.Wait(0)
							end
							if(menuresult > 0) then
								Print(' admin revived ' .. tempitems[menuresult])
								TriggerServerEvent('performAdminRequest', GetPlayerServerIdFromName(tempitems[menuresult]), GetPlayerServerId(), 13)
							end
						end
					end
				end
		end
	end
end)




RegisterNetEvent('revall')
AddEventHandler('revall', function()
	if(IsPlayerDead(GetPlayerId())) then
		ClearCharTasksImmediately(GetPlayerChar(-1))
		local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
		ResurrectNetworkPlayer(GetPlayerId(), px, py, pz, 90.0)
		SetCharCoordinates(GetPlayerChar(-1), px, py, pz-1)
		thirst = 30
		hunger = 30
		SaveStats()
	end
	TriggerEvent("noticeme:Info", "God resurrected everyone. ")
	TriggerEvent("deathoff")
end)

RegisterNetEvent('performAdminRequest')
AddEventHandler('performAdminRequest', function(id, adminid, request)
	if(request == 21) then
		local ax, ay, az = GetCharCoordinates(GetPlayerChar(adminid))
		SetCharCoordinates(GetPlayerChar(-1), ax, ay, az)
		ClearCharTasksImmediately(GetPlayerChar(-1))
		SetPlayerControl(GetPlayerId(), true)
	end
	if(GetPlayerChar(-1) == GetPlayerChar(id)) then
		if(request == 1) then
			job = "Police"
			SaveStats()
			TriggerEvent('chatMessage', '[Admin]', {255, 0, 0}, 'Your faction has been changed to Police by ' .. GetPlayerName(adminid, _s))
			TriggerServerEvent('sendMessageToPlayer', GetPlayerName(adminid, _s), "[Admin]", "You have successfully changed the faction of this player.")
		elseif(request == 2) then
			job = "Medic"
			SaveStats()
			TriggerEvent('chatMessage', '[Admin]', {255, 0, 0}, 'Your faction has been changed to Medic by ' .. GetPlayerName(adminid, _s))
			TriggerServerEvent('sendMessageToPlayer', GetPlayerName(adminid, _s), "[Admin]", "You have successfully changed the faction of this player.")
		elseif(request == 3) then

		elseif(request == 4) then
			
		elseif(request == 5) then
			if(job ~= "") then
				job = ""
				--gang = 0
				SaveStats()
				TriggerEvent('chatMessage', '[Admin]', {255, 0, 0}, 'You have been removed from the faction by ' .. GetPlayerName(adminid, _s))
				TriggerServerEvent('sendMessageToPlayer', GetPlayerName(adminid, _s), "[Admin]", "You have successfully removed this player from faction.")
			else
				TriggerServerEvent('sendMessageToPlayer', GetPlayerName(adminid, _s), "[Admin]", "This player is not a member of any faction!")
			end
		elseif(request == 6) then
			if(leader == 0) then
				if(job ~= "") then
					leader = 1
					SaveStats()
					TriggerEvent('chatMessage', '[Admin]', {255, 0, 0}, 'You have been set as a faction leader by ' .. GetPlayerName(adminid, _s))
					TriggerServerEvent('sendMessageToPlayer', GetPlayerName(adminid, _s), "[Admin]", "You have successfully set a leader role for this player.")
				else
					TriggerServerEvent('sendMessageToPlayer', GetPlayerName(adminid, _s), "[Admin]", "This player is not a member of any faction!")
				end
			else
				TriggerServerEvent('sendMessageToPlayer', GetPlayerName(adminid, _s), "[Admin]", "This player is already a leader!")
			end
		elseif(request == 7) then
			if(leader == 1) then
				leader = 0
				SaveStats()
				TriggerEvent('chatMessage', '[Admin]', {255, 0, 0}, 'Your leader role has been removed by ' .. GetPlayerName(adminid, _s))
				TriggerServerEvent('sendMessageToPlayer', GetPlayerName(adminid, _s), "[Admin]", "You have successfully removed a leader role from this player.")
			else
				TriggerServerEvent('sendMessageToPlayer', GetPlayerName(adminid, _s), "[Admin]", "This player is not a leader!")
			end
		elseif(request == 8) then
			local data = {}
			data[0] = "Name: " .. GetPlayerName(id)
			data[1] = "Money: " .. inventory[34]
			data[2] = "hunger: " .. hunger
			data[3] = "Skin: "
			data[4] = "Faction: " .. job
			data[5] = "Rank: " .. rank
			data[6] = "Leader: " .. leader
			data[7] = "Driver license: " .. driverlicense
			data[8] = "Weapon license: " .. weaponlicense
			data[9] = "Business: " 
			data[10] = "Income: "
			data[11] = "Army score: "
			data[12] = "Wanted level: " 
			data[13] = "Age: " 
			data[14] = "House: "
			data[15] = "Prison time: " .. jailtime
			data[16] = "Boat license: " .. boatlicense
			data[17] = "Military ticket: " 
			data[18] = "level : " .. level
			data[19] = "exp : " .. exp
			data[20] = "health : " .. health
			TriggerServerEvent('showPlayerInfo', adminid, data)
		elseif(request == 9) then
			admin = 1
			TriggerEvent('chatMessage', '[Admin]', {255, 0, 0}, ' ' .. GetPlayerName(adminid, _s) .. 'set you as an admin')
			TriggerServerEvent('sendMessageToPlayer', GetPlayerName(adminid, _s), "[Admin]", "You set a citizen as admin.")
		elseif(request == 11) then
			if(no == 1) then
				adminjail = 1
				SaveStats()
				TriggerEvent('chatMessage', '[Admin]', {255, 0, 0}, 'You are in jail' .. GetPlayerName(adminid, _s))
				TriggerServerEvent('sendMessageToPlayer', GetPlayerName(adminid, _s), "[Admin]", "You put a citizen in jail.")
				if(adminjail == 1) then
					SetCharCoordinatesNoOffset(GetPlayerChar(-1), -1074.15576, -461.97998, 2.30111)
				end
			end
		elseif(request == 13) then
			revive = 1
			
			SaveStats()
			TriggerEvent('chatMessage', '[Admin]', {255, 0, 0}, 'You are revived by an admin' .. GetPlayerName(adminid, _s))
			TriggerServerEvent('sendMessageToPlayer', GetPlayerName(adminid, _s), "[Admin]", "You revived a citizen.")
			FadeScreen()
			local posrr = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
			SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1))+100)
			ResurrectNetworkPlayer(GetPlayerId(), posrr[1], posrr[2], posrr[3], 90.0)
			SetCamActive(GetGameCam(), true)
			TriggerEvent("deathoff")
			thirst = 30
			hunger = 30
			SaveStats()
		elseif(request == 14) then
			local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
			if(not DoesVehicleExist(bugcar)) then
				bugcar = SpawnCar(GetHashKey("admiral"), px,py,pz+100, 0,0)
				WarpCharIntoCar(GetPlayerChar(-1), bugcar)
			end

			WarpCharFromCarToCoord(GetPlayerChar(-1), px,py,pz)
			SetCharHealth(GetPlayerChar(-1), 200)
			thirst = 30
			hunger = 30
			SaveStats()
			ResurrectNetworkPlayer(GetPlayerId(), px,py,pz, 90.0)
			ClearCharTasksImmediately(GetPlayerChar(-1))
			SetPlayerControl(GetPlayerId(), true)
			FreezeCharPosition(GetPlayerChar(-1), false)
			cursor = 0
			Notify('You have been fixed by an admin')
			DeleteCar(bugcar)
		elseif(request == 15) then
			
		elseif(request == 16) then
			
		elseif(request == 20) then
			local ax, ay, az = GetCharCoordinates(GetPlayerChar(adminid))
			SetCharCoordinates(GetPlayerChar(-1), ax, ay, az)
			ClearCharTasksImmediately(GetPlayerChar(-1))
			SetPlayerControl(GetPlayerId(), true)
			TriggerEvent('chatMessage', '[Admin]', {255, 0, 0}, 'You were dragged by an admin' .. GetPlayerName(adminid, _s))
		end
	end
end)

RegisterNetEvent('onDialogResponse')
AddEventHandler('onDialogResponse', function(dialogID, dialogResponse, dialogListitem, dialogInputtext)
	   if(dialogID == "DIALOG_ANNOUNCE") then
		   if(dialogResponse == 0) then
			   SetUIFocus(false)
			   SetPlayerControl(GetPlayerId(),true)
			elseif(dialogResponse == 1) then
				Citizen.CreateThread(function()
					displaytext(0.5, 0.5," ANNOUNCEMENT :     ".. dialogInputtext ..'',  3, 161, 252, 255)
				end)
		end
	end
end)



function ShowPanell()
	TriggerEvent('showDialog', "DIALOG_ANNOUNCE", "DIALOG_STYLE_INPUT", "ANNOUNCE", "enter your message", "Announce", "Exit","", true)
end



local displaypass = false
RegisterNetEvent('showPlayerInfo')
AddEventHandler('showPlayerInfo', function(id, data)
	if(GetPlayerChar(-1) == GetPlayerChar(id)) then
		SetCamActive(GetGameCam(), false)
		SetPlayerControl(GetPlayerId(), false)
		displaypass = true
		Citizen.CreateThread(function()
			while displaypass do
				Citizen.Wait(0)
				SetTextScale(0.1500000,  0.3000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextFont(6)
				SetTextEdge(1, 0, 0, 0, 255)
				--SetTextWrap(0.0, 0.3)
				SetTextCentre(1)
				DisplayTextWithLiteralString(0.5, 0.39, "STRING", "Player info")
				
				--DrawCurvedWindow(0.4, 0.38, 0.2, 0.22, 100)
				DrawRectLeftTopCenter(0.41, 0.42, 0.20, 0.50, 90, 90, 90, 100)
				
				for i=0,#data,1 do
					SetTextScale(0.1500000,  0.3000000/#data*20)
					SetTextDropshadow(0, 0, 0, 0, 0)
					SetTextEdge(1, 0, 0, 0, 255)
					DisplayTextWithLiteralString(0.42, 0.4+0.06/(#data+1)*8*(i+1), "STRING", data[i])
				end
				
				SetTextScale(0.1500000,  0.3000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextFont(6)
				SetTextEdge(1, 0, 0, 0, 255)
				--SetTextWrap(0.0, 0.3)
				SetTextCentre(1)
				DisplayTextWithLiteralString(0.5, 0.95, "STRING", "Press ~y~E ~w~to close")
				if(IsGameKeyboardKeyJustPressed(18)) then
					displaypass = false
				end
			end
			SetCamActive(GetGameCam(), true)
			SetPlayerControl(GetPlayerId(), true)
		end)
	end
end)

--money UI

adminmoney = 0
tempid = 0
local adminstring = ""

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(adminmoney == 1) then
			if(IsGameKeyboardKeyJustPressed(22)) then --u
				adminmoney = 0
				adminstring = ""
			end
		end
		
		if(adminmoney == 1) then
			DrawRect(0.5, 0.5, 0.3, 0.05, 255, 0, 0, 255)
			DrawRect(0.5, 0.5, 0.28, 0.03, 90, 90, 90, 255)
			
			if(adminstring ~= "") then
				SetTextScale(0.200000,  0.5000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextFont(6)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextCentre(1)
				DisplayTextWithLiteralString(0.5, 0.485, "STRING", "" .. adminstring)
			else
				SetTextScale(0.200000,  0.5000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextFont(6)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextCentre(1)
				DisplayTextWithLiteralString(0.5, 0.485, "STRING", "0")
			end
			
			for i=1,10,1 do --numbers
				if(IsGameKeyboardKeyJustPressed(i+1)) then
					if(i ~= 10) then
						adminstring = "" .. adminstring .. "" .. i
					else
						adminstring = "" .. adminstring .. "0"
					end
				end
			end
			if(IsGameKeyboardKeyJustPressed(14)) then --backspace
				adminstring = adminstring:sub(1, #adminstring - 1)
			end
			if(IsGameKeyboardKeyJustPressed(28)) then --enter
				if(adminstring ~= "") then
					adminmoney = 0
					inventory[34] = inventory[34] + tonumber(adminstring)
					SaveInventory()
					Print(' took ' .. tonumber(adminstring) .. 'rs from admin pannel')
				end
			end
			
			SetTextScale(0.300000,  0.5000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			SetTextFont(6)
			SetTextEdge(1, 0, 0, 0, 255)
			--SetTextWrap(0.0, 0.8)
			SetTextCentre(1)
			DisplayTextWithLiteralString(0.5, 0.3, "STRING", "ADMIN_MONEY")
			
			SetTextScale(0.300000,  0.5000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			SetTextFont(6)
			SetTextEdge(1, 0, 0, 0, 255)
			--SetTextWrap(0.0, 0.8)
			SetTextCentre(1)
			DisplayTextWithLiteralString(0.5, 0.7, "STRING", "Enter_amount_of_money")
			
			SetTextScale(0.200000,  0.3000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			SetTextFont(6)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextWrap(0.0, 0.5)
			SetTextCentre(1)
			DisplayTextWithLiteralString(0.5, 0.9, "STRING", "Enter_-_Send U_-_Close")
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(videditor == 1) then
			if(IsGameKeyboardKeyJustPressed(22)) then --u
				if(visible == 1) then
					TriggerEvent('chatMessage', '[Admin]', {255, 0, 0}, 'visible activated')
					invisiblechar = 1
					visible = 0
				else
					TriggerEvent('chatMessage', '[Admin]', {255, 0, 0}, 'visible disactivated')
					invisiblechar = 0
					visible = 1
					SetCharVisible(GetPlayerChar(-1), true)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(invisiblechar == 1) then
			SetCharVisible(GetPlayerChar(-1), false)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(videditor == 1) then
			if(IsGameKeyboardKeyJustPressed(36)) then --j
				if(freezecam == 1) then
					SetCamActive(GetGameCam(), true)
					TriggerEvent('chatMessage', '[Admin]', {255, 0, 0}, 'freezecamera activated')
					freezecam = 0
				else
					SetCamActive(GetGameCam(), false)
					TriggerEvent('chatMessage', '[Admin]', {255, 0, 0}, 'freezecamera disactivated')
					freezecam = 1
				end
			end
		end
	end
end)





function ShowText(text, timeout)
    if(timeout == nil) then PrintStringWithLiteralStringNow("STRING", text, 2000, 1)
    else PrintStringWithLiteralStringNow("STRING", text, timeout, 1)
    end
end

