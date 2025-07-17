--Client event handler, usually for commands

local hudEnabled = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if(hudEnabled) then
            DisplayAmmo(true)
            DisplayCash(true)
            DisplayHud(true)
            DisplayRadar(true)
            hudoff = 1
        end
    end
end)

RegisterNetEvent('giveWeapon')
AddEventHandler('giveWeapon', function(weapon, ammo)
    Citizen.CreateThread(function()
        if(admin == 1) then
            GiveWeaponToChar(GetPlayerChar(-1), weapon, ammo)
        end
    end)
end)

RegisterNetEvent('sendmedicmsg')
AddEventHandler('sendmedicmsg', function(message)
    Citizen.CreateThread(function()
        h,m = GetTimeOfDay()
        if(IsCharModel(GetPlayerChar(-1), GetHashKey("M_Y_PMEDIC")) or IsCharModel(GetPlayerChar(-1), GetHashKey("f_y_doctor_01")) or IsCharModel(GetPlayerChar(-1), GetHashKey("m_m_doctor_01")) or IsCharModel(GetPlayerChar(-1), GetHashKey("m_m_doc_scrubs_01"))) then
            TriggerServerEvent('SendMessage', "MEDIC", message, h, 2)
        end
    end)
end)

RegisterNetEvent('sendhelpmsg')
AddEventHandler('sendhelpmsg', function(message)
    TriggerServerEvent('sendadminmsg', GetPlayerId(), message)
    TriggerEvent('chatMessage', '[HELP] ' ..GetPlayerName(GetPlayerId()).. ' ' .. GetPlayerId(), {255, 0, 0}, " " ..message)
end)

RegisterNetEvent('playsound')--- fromm server to server
AddEventHandler('playsound', function(id)
    TriggerServerEvent('playsound', id)
    TriggerEvent("noticeme:Info", "playsound1")
end)

RegisterNetEvent('playsound2') -- all players
AddEventHandler('playsound2', function(id)
    local str = all_trim(id)
    TriggerEvent('play_music', str)
    
end)

function all_trim(s)
    return s:match"^%s*(.*)":match"(.-)%s*$"
  end

RegisterNetEvent('restart')--- fromm server to server
AddEventHandler('restart', function()
	if(admin == 1) then
    	TriggerServerEvent('restart')
	end
end)

RegisterNetEvent('restart2')-- all players
AddEventHandler('restart2', function()
    TriggerEvent('play_music', "NSmOWcJpAAU")
    ForceWeatherNow(7)
    TriggerEvent('Announce', {type = 'lspd', text = "Server is going for a quick restart please quit the server 1 minute"})
end)

RegisterNetEvent('sendadminmsg2')
AddEventHandler('sendadminmsg2', function(id, message)
    if(admin > 0) then
        TriggerEvent('chatMessage', '[HELP] ' ..GetPlayerName(id).. ' ' .. id, {255, 0, 0}, " " ..message)
    end
end)
RegisterNetEvent('streamermode')
AddEventHandler('streamermode', function(id, message)
    if(streamermode == 0) then
		streamermode = 1
		SaveStats()
		TriggerEvent('chatMessage', 'Streamer mode on, you wont hear any copyrighted songs anymore.')
	else
		streamermode = 0
		SaveStats()
		TriggerEvent('chatMessage', 'Streamer mode off, you may hear any copyrighted songs.')
	end
end)
RegisterNetEvent('sendpdmsg')
AddEventHandler('sendpdmsg', function(message)
    Citizen.CreateThread(function()
        h,m = GetTimeOfDay()
        if(IsCop(-1)) then
            TriggerServerEvent('SendMessage', "Police Department", message, h, 3)
        end
    end)
end)
RegisterNetEvent('sendadminmsg')
AddEventHandler('sendadminmsg', function(message)
    Citizen.CreateThread(function()
        h,m = GetTimeOfDay()
        if(admin == 1) then
            TriggerServerEvent('SendMessage', "ANNOUNCEMENT", message, h, 5)
        end
    end)
end)
RegisterNetEvent('announce')
AddEventHandler('announce', function(message)
    Citizen.CreateThread(function()
        if(admin == 1) then
            TriggerServerEvent('announce', message)
        end
    end)
end)
RegisterNetEvent('announce2')
AddEventHandler('announce2', function(message)
    Citizen.CreateThread(function()
        TriggerEvent('Announce', {type = 'lspd', text = message})
    end)
end)
RegisterNetEvent('createCheckpoint')
AddEventHandler('createCheckpoint', function()
    local pos = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
    
    CreateCheckpoint(3, pos[1]+6, pos[2], pos[3], pos[1], pos[2]+10, pos[3], 1.0)
    
    Notify("Checkpoint created.")
end)

RegisterNetEvent('hudOff')
AddEventHandler('hudOff', function()
    hudEnabled = false
end)

RegisterNetEvent('hudOn')
AddEventHandler('hudOn', function()
    hudEnabled = true
end)

RegisterNetEvent('playAudioStuff')
AddEventHandler('playAudioStuff', function(audio)
    PlayAudioEvent(audio)
end)

function GetIDFromName(name)
    local players = GetPlayers()

    for _, i in ipairs(players) do
        if(string.lower(GetPlayerName(i)) == string.lower(name)) then
            return i
        end
    end

    return nil
end 
local show = 0
RegisterNetEvent('showScreenMsg')
AddEventHandler('showScreenMsg', function(text, timeout)
    TriggerEvent("announce:Info", "" .. text)
end)

RegisterNetEvent('giveitem')
AddEventHandler('giveitem', function(id, amount)
	if(admin == 1) then
   	 	Notify('dsadsa ' .. lootnames[tonumber(id)].. ' ' .. amount)
	 	AddItem(tonumber(id), tonumber(amount))
	end
end)
RegisterNetEvent('tpToPlayer')
AddEventHandler('tpToPlayer', function(nameorid)
    if(admin == 1) then
    local target = 255

    if(isNumber(nameorid) and GetPlayerFromServerId(tonumber(nameorid)) ~= -1) then target = GetPlayerFromServerId(tonumber(nameorid))
    elseif(GetIDFromName(nameorid) ~= nil) then target = GetIDFromName(nameorid)
    end

    if(target == 255) then
        return Notify("~r~Invalid player name/ID.")
    end

    if(GetPlayerName(target) == GetPlayerName(playerid)) then
        return Notify("~r~You can't teleport to yourself.")
    end

    if(IsCharInAnyCar(GetPlayerChar(target))) then
        if(IsCharInAnyCar(GetPlayerChar(-1)) and GetCarCharIsUsing(GetPlayerChar(target)) == GetCarCharIsUsing(GetPlayerChar(-1))) then
            return Notify("~r~You can't teleport to yourself.")
        end

        if(GetMaximumNumberOfPassengers(GetCarCharIsUsing(GetPlayerChar(target))) == GetNumberOfPassengers(GetCarCharIsUsing(GetPlayerChar(target)))) then
            Notify("~r~There's no more free seats in " .. GetPlayerName(target) .. "'s vehicle! ~g~Warping to the vehicle.")
            return TeleportToChar(GetPlayerChar(target))
        end

        WarpCharIntoCarAsPassenger(GetPlayerChar(-1), GetCarCharIsUsing(GetPlayerChar(target)))

        return Notify("~g~You've successfully teleported into ~y~" .. GetPlayerName(target) .. "~g~'s vehicle.")
    end

    TeleportToChar(GetPlayerChar(target))
    Notify("~g~You've successfully teleported to ~y~" .. GetPlayerName(target) .. "~g~.")
end
end)

function TeleportToChar(char)
    local pos = table.pack(GetCharCoordinates(char))
    table.insert(pos, GetCharHeading(char))

    if(IsCharInAnyCar(GetPlayerChar(-1))) then
        WarpCharFromCarToCoord(GetPlayerChar(-1), pos[1], pos[2], pos[3])
    end

    SetCharCoordinatesNoOffset(GetPlayerChar(-1), pos[1], pos[2], pos[3])
    SetCharHeading(GetPlayerChar(-1), pos[4])
end

function round(num, idp)
    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

RegisterNetEvent('sendPos')
AddEventHandler('sendPos', function()
    local pos = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
    table.insert(pos, GetCharHeading(GetPlayerChar(-1)))

    TriggerServerEvent('savePos', round(pos[1], 5), round(pos[2], 5), round(pos[3], 5), pos[4])
    TriggerEvent('createBlip', 63, 2)
end)

RegisterNetEvent('sendPosH')
AddEventHandler('sendPosH', function()
    local pos = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
    table.insert(pos, GetCharHeading(GetPlayerChar(-1)))

    TriggerServerEvent('savePosH', round(pos[1], 5), round(pos[2], 5), round(pos[3], 5), pos[4])
    TriggerEvent('createBlip', 63, 2)
end)

RegisterNetEvent('sendPosG')
AddEventHandler('sendPosG', function()
    local pos = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
    table.insert(pos, GetCharHeading(GetPlayerChar(-1)))

    TriggerServerEvent('savePosG', round(pos[1], 5), round(pos[2], 5), round(pos[3], 5), pos[4])
    TriggerEvent('createBlip', 63, 2)
end)


RegisterNetEvent('sendCarHash')
AddEventHandler('sendCarHash', function()
    local hash = GetCarModel(GetCarCharIsUsing(GetPlayerChar(-1)))
    local name = GetDisplayNameFromVehicleModel(hash)
    TriggerServerEvent('saveCarHash', hash, name)
end)

RegisterNetEvent('sendSaveCar')
AddEventHandler('sendSaveCar', function()
    if(admin == 1) then
    local pos = table.pack(GetCarCoordinates(GetCarCharIsUsing(GetPlayerChar(-1))))

    TriggerServerEvent('saveCar', round(pos[1], 5), round(pos[2], 5), round(pos[3], 5))
    end
end)

RegisterNetEvent('createBlip')
AddEventHandler('createBlip', function(sprite, color)
    if(admin == 1) then
    local pos = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
    if(not DoesBlipExist(blip)) then
    local blip = AddBlipForCoord(pos[1], pos[2], pos[3])

    			ChangeBlipSprite(blip, tonumber(sprite))
    ChangeBlipColour(blip, tonumber(color))
    end

    Notify("~g~Blip created.")
    end
end)

RegisterNetEvent('changeCarColor')
AddEventHandler('changeCarColor', function(col1, col2)
    if(admin == 1) then
	if(not IsCharInAnyCar(GetPlayerChar(-1))) then
        return Notify("~r~You are not in any vehicle!")
	end

	ChangeCarColour(GetCarCharIsUsing(GetPlayerChar(-1)), tonumber(col1), tonumber(col2))
	Notify("~g~You have set your vehicles' colour.")
end
end)

RegisterNetEvent('setWeather')
AddEventHandler('setWeather', function(weatherid)
    if(admin == 1) then
        ForceWeatherNow(tonumber(weatherid))
    end
end)

RegisterNetEvent('setTime')
AddEventHandler('setTime', function(hour)
    if(admin == 1) then
        SetTimeOfDay(tonumber(hour))
    end
end)

RegisterNetEvent('setPos')
AddEventHandler('setPos', function(x, y, z)
    if(admin == 1) then
    Notify("~g~Warping to server sent coordinates ~y~" .. x .. " " .. y .. " " .. z .. " ~g~.")
    SetCharCoordinatesNoOffset(GetPlayerChar(-1), x, y, z)
    end
end)

RegisterNetEvent('setHealth')
AddEventHandler('setHealth', function(amount)
    if(admin == 1) then
    SetCharHealth(GetPlayerChar(-1), tonumber(amount))
    end
end)

RegisterNetEvent('giveArmour')
AddEventHandler('giveArmour', function(amount)
    if(admin == 1) then
    AddArmourToChar(GetPlayerChar(-1), tonumber(amount))
    end
end)

RegisterNetEvent('fixVehicle')
AddEventHandler('fixVehicle', function()
    if(admin == 1) then
	if(not IsCharInAnyCar(GetPlayerChar(-1))) then 
        return Notify("~r~You are not in any vehicle!")
	end

	FixCar(GetCarCharIsUsing(GetPlayerChar(-1)))
    Notify("~g~You have fixed your vehicle.")
end
end)

RegisterNetEvent('flipVehicle')
AddEventHandler('flipVehicle', function()
    if(admin == 1) then
    if(not IsCharInAnyCar(GetPlayerChar(-1))) then 
        return Notify("~r~You are not in any vehicle!")
    end

    FlipVehicle(GetCarCharIsUsing(GetPlayerChar(-1)))
    Notify("~g~You have flipped your vehicle.")
end
end)

function FlipVehicle(vehicle)
    local pos = table.pack(GetCarCoordinates(vehicle))
    table.insert(pos, GetCarHeading(vehicle))

    SetCarCoordinates(vehicle, pos[1], pos[2], pos[3])
    SetCarHeading(vehicle, pos[4])
end

RegisterNetEvent('giveHealth')
AddEventHandler('giveHealth', function(amount)
    if(admin == 1) then
    SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1)) + tonumber(amount))
    end
end)

RegisterNetEvent('takeHealth')
AddEventHandler('takeHealth', function(amount)
    if(admin == 1) then
    SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1)) - tonumber(amount))
    end
end)

RegisterNetEvent('cleanYourCar')
AddEventHandler('cleanYourCar', function()
    if(admin == 1) then
    if(not IsCharInAnyCar(GetPlayerChar(-1))) then 
        return Notify("~r~You are not in any vehicle!")
    end

    SetVehicleDirtLevel(GetCarCharIsUsing(GetPlayerChar(-1)), 0.0)
    WashVehicleTextures(GetCarCharIsUsing(GetPlayerChar(-1)), 255)

    Notify("~g~You've successfully cleaned your vehicle.")
end
end)

RegisterNetEvent('kill')
AddEventHandler('kill', function()
    if(admin == 1) then
        SetCharHealth(GetPlayerChar(-1), 0)
        Notify("You have committed suicide.")
    end
end)

RegisterNetEvent('godmode')
AddEventHandler('godmode', function()
    if(admin == 1) then
        SetCharInvincible(GetPlayerChar(-1), true)
        Notify("~y~Godmode on.")
    end
end)

RegisterNetEvent('createCarAtPlayerPos')
AddEventHandler('createCarAtPlayerPos', function(modelname)
	if(admin >= 1) then
		if(IsModelInCdimage(GetHashKey(modelname))) then
			local pos = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
			table.insert(pos, GetCharHeading(GetPlayerChar(-1)))
	
			CreateNewCar(pos[1], pos[2], pos[3], pos[4], GetHashKey(modelname), true)
			Notify("~g~You've spawned the ~y~" .. modelname .. "~g~.")
		else
			TriggerEvent('chatMessage', '', { 0, 0x99, 255 }, "^1That's an unknown vehicle. Usage: /veh (vehicle name).")
		end
	end
end)

function CreateNewCar(x, y, z, heading, model, throwin)
    Citizen.CreateThread(function()
        RequestModel(model)

        while not HasModelLoaded(model) do 
            Citizen.Wait(0) 
        end

        local car = CreateCar(model, x, y, z, true)
        SetCarHeading(car, heading)
        SetCarOnGroundProperly(car)
        SetVehicleDirtLevel(car, 0.0)
        WashVehicleTextures(car, 255)

        if(throwin == true) then
            WarpCharIntoCar(GetPlayerChar(-1), car)
        end

        MarkModelAsNoLongerNeeded(model)
        MarkCarAsNoLongerNeeded(car)
    end)
end

function IsPlayerNearCoords(x, y, z, radius)
	local pos = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
	local dist = GetDistanceBetweenCoords3d(x, y, z, pos[1], pos[2], pos[3])

	if(dist < radius) then
        return true
	else
        return false
	end
end

function IsPlayerNearChar(char, radius)
	local pos = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
	local pos2 = table.pack(GetCharCoordinates(char))
	local dist = GetDistanceBetweenCoords3d(pos2[1], pos2[2], pos2[3], pos[1], pos[2], pos[3])

	if(dist <= radius) then
        return true
	else
        return false
	end
end

function isNumber(str)
    local num = tonumber(str)

    if not num then
        return false
    else
        return true
    end
end

RegisterNetEvent('performLeaderRequest')
AddEventHandler('performLeaderRequest', function(target, requester, id, args)
	if(ConvertIntToPlayerindex(target) == ConvertIntToPlayerindex(GetPlayerId())) then
		if(id == "invite") then
			if(job == "0") then
				if(args[1] == "Police") then
					if(level < 3) then
						Notify("Level of this player is too low to join your faction.")
						return
					elseif(driverlicense == 0) then
						Notify("This player does not have a driver license.")
						return
					elseif(weaponlicense == 0) then
						Notify("This player does not have a weapon license.")
						return
					end
				elseif(args[1] == "Medic") then
					if(level < 2) then
						Notify("Level of this player is too low to join your faction.")
						return
					elseif(driverlicense == 0) then
						Notify("This player does not have a driver license.")
						return
					end
				elseif(args[1]=="Spanish Lords" or args[1]=="Yardies" or args[1]=="Hustlers") then
					if(level < 2) then
						Notify("Level of this player is too low to join your faction.")
						return
					end
				elseif(args[1] == "NOOSE") then
					if(level < 3) then
						Notify("Level of this player is too low to join your faction.")
						return
					elseif(driverlicense == 0) then
						Notify("This player does not have a driver license.")
						return
					elseif(weaponlicense == 0) then
						Notify("This player does not have a weapon license.")
						return
					end
				end
				DrawWindow("" .. GetPlayerName(requester) .. " invites you to faction", {"Join " .. args[1]})
				while menuactive do
					Wait(0)
				end
				if(menuresult == 1) then
					job = args[1]
					rank = 1
					jobexp = 0
					SaveStats()
					TriggerServerEvent('sendMessageToPlayer', requester, "" .. GetPlayerName(target) .. " has accepted your offer.")
					Notify("You have joined " .. args[1] .. ".")
				else
					TriggerServerEvent('sendMessageToPlayer', requester, "" .. GetPlayerName(target) .. " has declined your offer.")
				end
			else
				TriggerServerEvent('sendMessageToPlayer', requester, "This player is already in a member of faction.")
			end
		elseif(id == "remove") then
			if(job == args[1]) then
				job = "0"
				rank = 1
				SaveStats()
				SetDefaultSkin()
				TriggerServerEvent('sendMessageToPlayer', requester, "" .. GetPlayerName(target) .. " has been removed from your faction.")
				Notify("You have been removed from " .. args[1] .. ".")
			else
				TriggerServerEvent('sendMessageToPlayer', requester, "This player is not a member of your faction.")
			end
		elseif(id == "promote") then
			if(job == args[1]) then
				if(rank < 5) then
					if(jobexp >= (2+rank)) then
						rank = rank + 1
						jobexp = 0
						SaveStats()
						TriggerServerEvent('sendMessageToPlayer', requester, "" .. GetPlayerName(target) .. " has been promoted.")
						Notify("You have been promoted.")
					else
						TriggerServerEvent('sendMessageToPlayer', requester, "This player's faction experience on the current rank is not enough for promotion.")
					end
				else
					TriggerServerEvent('sendMessageToPlayer', requester, "Rank of this player is already the highest.")
				end
			else
				TriggerServerEvent('sendMessageToPlayer', requester, "This player is not a member of your faction.")
			end
		elseif(id == "demote") then
			if(job == args[1]) then
				if(rank < 5) then
					rank = rank + 1
					SaveStats()
					TriggerServerEvent('sendMessageToPlayer', requester, "" .. GetPlayerName(target) .. " has been demoted.")
					Notify("You have been demoted.")
				else
					TriggerServerEvent('sendMessageToPlayer', requester, "Rank of this player is already the lowest.")
				end
			else
				TriggerServerEvent('sendMessageToPlayer', requester, "This player is not a member of your faction.")
			end
		end
	end
end)

TriggerServerEvent('registerCommand', "s")
TriggerServerEvent('registerCommand', "me")
TriggerServerEvent('registerCommand', "do")
TriggerServerEvent('registerCommand', "try")
TriggerServerEvent('registerCommand', "r")
TriggerServerEvent('registerCommand', "ad")
TriggerServerEvent('registerCommand', "g")
TriggerServerEvent('registerCommand', "b")
TriggerServerEvent('registerCommand', "anims")
TriggerServerEvent('registerCommand', "leavefaction")
TriggerServerEvent('registerCommand', "removefaction")
RegisterNetEvent('performCommand')
AddEventHandler('performCommand', function(command, args)
	if(command == "s") then
		if(#args > 0) then
			for i=0,31,1 do
				if(IsNetworkPlayerActive(i)) then
					local px,py,pz = GetCharCoordinates(GetPlayerChar(i))
					if(IsPlayerNearCoords(px, py, pz, 50)) then
						TriggerServerEvent('sendMessageToPlayer', i, "" .. GetPlayerName(GetPlayerId()) .. " screams: " .. table.concat(args, " "))
					end
				end
			end
		else	
			Notify("^1Usage: /s <message>")
		end
	elseif(command == "me") then
		if(#args > 0) then
			for i=0,31,1 do
				if(IsNetworkPlayerActive(i)) then
					local px,py,pz = GetCharCoordinates(GetPlayerChar(i))
					if(IsPlayerNearCoords(px, py, pz, 20)) then
						TriggerServerEvent('sendMessageToPlayer', i, "^3" .. GetPlayerName(GetPlayerId()) .. " " .. table.concat(args, " ") .. ".")
					end
				end
			end
		else
			Notify("^1Usage: /me <action>")
		end
	elseif(command == "do") then
		if(#args > 0) then
			for i=0,31,1 do
				if(IsNetworkPlayerActive(i)) then
					local px,py,pz = GetCharCoordinates(GetPlayerChar(i))
					if(IsPlayerNearCoords(px, py, pz, 20)) then
						TriggerServerEvent('sendMessageToPlayer', i, "^5" .. table.concat(args, " ") .. " (" .. GetPlayerName(GetPlayerId()) .. ")")
					end
				end
			end
		else
			Notify("^1Usage: /do <text>")
		end
	elseif(command == "try") then
		if(#args > 0) then
			local rnd = GenerateRandomIntInRange(0, 2)
			local result = ""
			if(rnd == 0) then
				result = "Fail"
			else
				result = "Success"
			end
			for i=0,31,1 do
				if(IsNetworkPlayerActive(i)) then
					local px,py,pz = GetCharCoordinates(GetPlayerChar(i))
					if(IsPlayerNearCoords(px, py, pz, 20)) then
						TriggerServerEvent('sendMessageToPlayer', i, "^3" .. GetPlayerName(GetPlayerId()) .. " " .. table.concat(args, " ") .. " (" .. result .. ")")
					end
				end
			end
		else
			Notify("^1Usage: /try <action>")
		end
	elseif(command == "r") then
		if(#args > 0) then
			if(job ~= "0") then
				TriggerServerEvent('sendRadioMessage', ConvertIntToPlayerindex(GetPlayerId()), job, table.concat(args, " "))
			else
				Notify("You must be a member of a faction to use it.")
			end
		else
			Notify("^1Usage: /r <message>")
		end
	elseif(command == "ad") then
		if(#args > 0) then
			TriggerServerEvent('sendMessageToEveryone', "^8[Advertisement] " .. table.concat(args, " ") .. " - Sender: " .. GetPlayerName(GetPlayerId()))
		else
			Notify("^1Usage: /ad <text>")
		end
	elseif(command == "g") then
		if(#args > 0) then
			TriggerServerEvent('sendMessageToEveryone', "" .. GetPlayerName(GetPlayerId()) .. ": " .. table.concat(args, " "))
		else
			Notify("^1Usage: /g <message>")
		end
	elseif(command == "b") then
		if(#args > 0) then
			for i=0,31,1 do
				if(IsNetworkPlayerActive(i)) then
					local px,py,pz = GetCharCoordinates(GetPlayerChar(i))
					if(IsPlayerNearCoords(px, py, pz, 20)) then
						TriggerServerEvent('sendMessageToPlayer', i, "^9((" .. GetPlayerName(GetPlayerId()) .. ": " .. table.concat(args, " ") .. "))")
					end
				end
			end
		else
			Notify("^1Usage: /b <message>")
		end
	elseif(command == "anims") then
		if(IsPlayerControlOn(GetPlayerId())) then
			if(not IsCharInAnyCar(GetPlayerChar(-1))) then
				local anims = {
				{"Hands up", "cop", "armsup_loop", 3},
				{"Sit down", "amb_sit_chair_m", "sit_down_front_b", 2},
				{"Lie", "amb@wasted_b", "idle_a", 1},
				{"Wave", "gestures@mp_male", "wave", 0},
				{"Middle finger", "gestures@mp_male", "finger", 0},
				{"Smoke", "amb@smoking", "stand_smoke", 1},
				{"Dance 1", "amb@dance_femidl_a", "loop_a", 1},
				{"Dance 2", "amb@dance_femidl_b", "loop_b", 1},
				{"Dance 3", "amb@dance_femidl_c", "loop_c", 1},
				{"Dance 4", "amb@dance_maleidl_a", "loop_a", 1},
				{"Dance 5", "amb@dance_maleidl_b", "loop_b", 1},
				{"Dance 6", "amb@dance_maleidl_c", "loop_c", 1},
				{"Dance 7", "amb@dance_maleidl_d", "loop_d", 1},
				{"Piss", "missttkill", "piss_loop", 1},
				{"Crossarms", "amb@bouncer_idles_b", "lookaround_a", 1},
				{"Lean", "amb@lean_idles", "lean_idle_a", 1}
				}
				local tempitems = {}
				for i=1,#anims,1 do
					tempitems[i] = anims[i][1]
				end
				tempitems[#tempitems+1] = "Stop animation"
				DrawWindow("Animations", tempitems)
				while menuactive do
					Wait(0)
				end
				if(menuresult > 0) then
					if(menuresult ~= #tempitems) then
						PlayAnim(anims[menuresult][2], anims[menuresult][3], anims[menuresult][4])
					else
						ClearCharTasksImmediately(GetPlayerChar(-1))
					end
				end
			end
		end
	elseif(command == "leavefaction") then
		if(job ~= "0") then
			if(currleader[job] == GetPlayerName(GetPlayerId())) then
				currleader[job] = "None"
				SaveLeaders()
			end
			leader = 0
			job = "0"
			rank = 1
			SaveStats()
			SetDefaultSkin()
		else
			Notify("You are not a member of any faction.")
		end
	elseif(command == "removefaction") then
		if(job~="0" and currleader[job]==GetPlayerName(GetPlayerId())) then
			local templist = {}
			local tempids = {}
			for i=0,31,1 do
				if(IsNetworkPlayerActive(i)) then
					if(ConvertIntToPlayerindex(i) ~= ConvertIntToPlayerindex(GetPlayerId())) then
						if(CheckFaction(job, i)) then
							templist[#templist+1] = GetPlayerName(i)
							tempids[#tempids+1] = i
						end
					end
				end
			end
			if(#templist > 0) then
				DrawWindow("Select player to remove", templist)
				while menuactive do
					Wait(0)
				end
				if(menuresult > 0) then
					TriggerServerEvent('performLeaderRequest', tempids[menuresult], ConvertIntToPlayerindex(GetPlayerId()), "remove", {job})
				end
			else
				Notify("There are no members of this faction online.")
			end
		else
			Notify("You must be a leader to use this command.")
		end
	end
end)

RegisterNetEvent('sendRadioMessage')
AddEventHandler('sendRadioMessage', function(sender, jobid, message)
	if(job == jobid) then
		Notify("^6[Radio] " .. GetPlayerName(sender) .. ": " .. message)
	end
end)

RegisterNetEvent('showPassport')
AddEventHandler('showPassport', function(id, sender, data)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		SendMessageToNearbyPlayers("" .. GetPlayerName(sender) .. " has shown passport to " .. GetPlayerName(GetPlayerId()) .. ".", 20)
		CreateThread(function()
			while true do
				Wait(0)
				SetTextScale(0.200000,  0.4000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextFont(6)
				--SetTextEdge(1, 0, 0, 0, 255)
				--SetTextWrap(0.0, 0.85)
				SetTextCentre(1)
				DisplayTextWithLiteralString(0.5, 0.365, "STRING", "Passport")
				DrawRectLeftTopCenter(0.4, 0.35, 0.2, 0.05, 0, 0, 100, 255)
				
				for i=1,#data,1 do
					DrawRectLeftTopCenter(0.4, 0.4+0.3/10*(i-1), 0.2, 0.3/10, 0, 0, 0, 100)
					SetTextScale(0.1500000,  0.3000000)
					SetTextDropshadow(0, 0, 0, 0, 0)
					--SetTextFont(6)
					--SetTextEdge(1, 0, 0, 0, 255)
					--SetTextWrap(0.0, 0.3)
					--SetTextCentre(1)
					DisplayTextWithLiteralString(0.4+0.005, 0.4+0.3/10*(i-1)+0.005, "STRING", "" .. data[i][1] .. ":")
					SetTextScale(0.1500000,  0.3000000)
					SetTextDropshadow(0, 0, 0, 0, 0)
					--SetTextFont(6)
					--SetTextEdge(1, 0, 0, 0, 255)
					SetTextWrap(0.0, 0.6-0.005)
					SetTextRightJustify(1)
					--SetTextCentre(1)
					DisplayTextWithLiteralString(0.6-0.005, 0.4+0.3/10*(i-1)+0.005, "STRING", "" .. data[i][2])
				end
				
				PrintText("Press ~y~E ~w~to close", 1)
				if(IsGameKeyboardKeyJustPressed(18)) then
					break
				end
			end
		end)
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if(IsPlayerControlOn(GetPlayerId())) then
			if not cuff then
				if not IsCharDead(GetPlayerChar(-1)) then
					for i=0,31,1 do
						if(IsNetworkPlayerActive(i)) then
							if(ConvertIntToPlayerindex(i) ~= ConvertIntToPlayerindex(GetPlayerId())) then
								local bp = GetPedBonePosition(GetPlayerChar(i), 0, 0, 0, 0)
								if(IsPlayerNearCoords(bp.x, bp.y, bp.z+0.5, 3)) then
									local bv,cx,cy = WorldToScreen(bp.x, bp.y, bp.z+0.5)
									if bv then
										if(cx>0.45 and cx<0.55 and cy>0.4 and cy<0.6) then
											--DrawTextAtCoord(bp.x, bp.y, bp.z+0.5, "G", 5)
											if(IsGameKeyboardKeyJustPressed(IntractionKey)) then
												local tempitems = {}
												tempitems[#tempitems+1] = "Show passport"
												tempitems[#tempitems+1] = "Give money"
												if(currjob == "Lawyer") then
													tempitems[#tempitems+1] = "Free out of jail"
												end
												if(IsCharInAnyCar(GetPlayerChar(-1))) then
													if(GetDriverOfCar(GetCarCharIsUsing(GetPlayerChar(-1))) == GetPlayerChar(-1)) then
														if(IsCharInCar(GetPlayerChar(i), GetCarCharIsUsing(GetPlayerChar(-1)))) then
															tempitems[#tempitems+1] = "Push out of vehicle"
														end
													end
												else
													if(CheckFaction("Police")) then
														if(IsCharInAnyCar(GetPlayerChar(i))) then
															tempitems[#tempitems+1] = "Push out of vehicle"
														end
													end
													if(CheckFaction("Police")) then
														if(IsCharInAnyCar(GetPlayerChar(i))) then
															tempitems[#tempitems+1] = "Push out of vehicle"
														end
													end
												end
												for j=1,#houses,1 do
													if(houses[j] == GetPlayerName(GetPlayerId())) then
														tempitems[#tempitems+1] = "Sell house"
														break
													end
												end
												for j=1,#cars,1 do
													if(cars[j] == 1) then
														tempitems[#tempitems+1] = "Sell vehicle"
														break
													end
												end
												local gw,cw = GetCurrentCharWeapon(GetPlayerChar(-1))
												if(cw ~= 0) then
													tempitems[#tempitems+1] = "Give weapon"
												end
												if(job ~= "0") then
													if(CheckFaction("Police")) then
														tempitems[#tempitems+1] = "Put/remove handcuffs"
														tempitems[#tempitems+1] = "Grab/ungrab"
														if(IsCharInAnyCar(GetPlayerChar(-1))) then
															if(not IsCharInAnyCar(GetPlayerChar(i))) then
																tempitems[#tempitems+1] = "Push into vehicle"
															end
														end
														tempitems[#tempitems+1] = "Search"
														tempitems[#tempitems+1] = "Arrest"
														tempitems[#tempitems+1] = "Remove driver license"
														tempitems[#tempitems+1] = "Remove weapon license"
													end
													if(CheckFaction("Medic")) then
														tempitems[#tempitems+1] = "Heal"
														tempitems[#tempitems+1] = "Revive"
														if(rank >= 3) then
															tempitems[#tempitems+1] = "Remove addiction"
														end
													end
													if(CheckFaction("Spanish Lords") or CheckFaction("Yardies") or CheckFaction("Hustlers")) then
														--tempitems[#tempitems+1] = "Sell drug"
													end
													if(leader == 1) then
														tempitems[#tempitems+1] = "Invite to faction"
														tempitems[#tempitems+1] = "Remove from faction"
														tempitems[#tempitems+1] = "Promote"
														tempitems[#tempitems+1] = "Demote"
													end
												end
												if(currjob == "Hooker") then
													local ped = GetPlayerChar(-1)
													local veh = GetCarCharIsUsing(ped)
													local ped2 = nil
													if(IsCharInAnyCar(GetPlayerChar(-1))) then
														local blacklist = {
														"akuma",
														"angel",
														"bati",
														"bati2",
														"daemon",
														"diabolus",
														"double",
														"double2",
														"faggio",
														"faggio2",
														"bobber",
														"hakuchou",
														"hakuchou2",
														"hellfury",
														"hexer",
														"lycan",
														"nightblade",
														"nrg900",
														"pcj",
														"revenant",
														"sanchez",
														"vader",
														"wayfarer",
														"wolfsbane",
														"zombieb"
														}
														local checker = 0
														for i=1,#blacklist,1 do
															if(IsCarModel(veh, GetHashKey(blacklist[i]))) then
																checker = 1
															end
														end
														if(checker == 0) then
															if(GetCharInCarPassengerSeat(veh, 0) == ped) then
																if(GetDriverOfCar(veh) == GetPlayerChar(i)) then
																	tempitems[#tempitems+1] = "Offer sexual service"
																end
															elseif(GetCharInCarPassengerSeat(veh, 2) == ped) then
																if(not IsCarPassengerSeatFree(veh, 1)) then
																	if(GetCharInCarPassengerSeat(veh, 1) == GetPlayerChar(i)) then
																		tempitems[#tempitems+1] = "Offer sexual service"
																	end
																end
															end
														end
													end
												end
												DrawWindow("Interaction with " .. GetPlayerName(i), tempitems)
												while menuactive do
													Wait(0)
												end
												if(menuresult > 0) then
													if(tempitems[menuresult] == "Show passport") then
														local data = {
														{"Name", GetPlayerName(GetPlayerId())},
														{"Years in the state", level},
														{"Faction", job},
														{"Rank", rank},
														{"Wanted level", wanted},
														{"Drug addiction", addict}
														}
														TriggerServerEvent('showPassport', i, ConvertIntToPlayerindex(GetPlayerId()), data)
													elseif(tempitems[menuresult] == "Give money") then
														local amount = ActivateInput("Enter amount of cash")
														if(amount ~= "") then
															amount = tonumber(amount)
															if amount then
																if(amount > 0) then
																	if(inventory[34] >= amount) then
																		RemoveItem(34, amount)
																		SaveStats()
																		TriggerServerEvent('sendMoneyToPlayer', i, ConvertIntToPlayerindex(GetPlayerId()), amount)
																	else
																		Notify("You do not have this amount of money.")
																	end
																end
															end
														end
													elseif(tempitems[menuresult] == "Free out of jail") then
														local price = ActivateInput("Enter a price")
														if(price ~= "") then
															price = tonumber(price)
															if price then
																if(price >= 1000) then
																	TriggerServerEvent('freeJail', i, ConvertIntToPlayerindex(GetPlayerId()), price)
																else
																	Notify("Price cannot be lower than 1000$.")
																end
															end
														end
													elseif(tempitems[menuresult] == "Push out of vehicle") then
														TriggerServerEvent('performPoliceRequest', i, ConvertIntToPlayerindex(GetPlayerId()), "eject", {})
													elseif(tempitems[menuresult] == "Put/remove handcuffs") then
														TriggerServerEvent('performPoliceRequest', i, ConvertIntToPlayerindex(GetPlayerId()), "cuff", {})
													elseif(tempitems[menuresult] == "Grab/ungrab") then
														if(followedplayer == -1) then
															followedplayer = i
														else
															followedplayer = -1
														end
														TriggerServerEvent('performPoliceRequest', i, ConvertIntToPlayerindex(GetPlayerId()), "grab", {})
													elseif(tempitems[menuresult] == "Push into vehicle") then
														TriggerServerEvent('performPoliceRequest', i, ConvertIntToPlayerindex(GetPlayerId()), "push", {})
													elseif(tempitems[menuresult] == "Search") then
														TriggerServerEvent('performPoliceRequest', i, ConvertIntToPlayerindex(GetPlayerId()), "search", {})
													elseif(tempitems[menuresult] == "Arrest") then
														if(IsPlayerNearCoords(93.60903, 1211.40063, 14.73794, 20)) then --police station
															TriggerServerEvent('performPoliceRequest', i, ConvertIntToPlayerindex(GetPlayerId()), "arrest", {})
														else
															Notify("You must be near a police station to do that.")
														end
													elseif(tempitems[menuresult] == "Remove driver license") then
														if(IsPlayerNearCoords(93.60903, 1211.40063, 14.73794, 20)) then --police station
															TriggerServerEvent('performPoliceRequest', i, ConvertIntToPlayerindex(GetPlayerId()), "removedriver", {})
														else
															Notify("You must be near a police station to do that.")
														end
													elseif(tempitems[menuresult] == "Remove weapon license") then
														if(IsPlayerNearCoords(93.60903, 1211.40063, 14.73794, 20)) then --police station
															TriggerServerEvent('performPoliceRequest', i, ConvertIntToPlayerindex(GetPlayerId()), "removeweapon", {})
														else
															Notify("You must be near a police station to do that.")
														end
													elseif(tempitems[menuresult] == "Heal") then
														local price = ActivateInput("Enter the price of healing")
														if(price ~= "") then
															price = tonumber(price)
															if price then
																if(price >= 100) then
																	TriggerServerEvent('performMedicRequest', i, ConvertIntToPlayerindex(GetPlayerId()), "heal", {price})
																	Notify("Healing offer has been sent to " .. GetPlayerName(i) .. ".")
																else
																	Notify("Price for healing cannot be lower than 100$.")
																end
															end
														end
													elseif(tempitems[menuresult] == "Revive") then
														if(IsPlayerDead(i)) then
															RequestAnims("medic")
															while not HaveAnimsLoaded("medic") do Citizen.Wait(0) end
															TaskPlayAnimWithFlags(GetPlayerChar(-1), "medic_cpr_loop", "medic", 8.0, 0, 0)
															Citizen.Wait(7000)
															TriggerServerEvent('performMedicRequest', i, ConvertIntToPlayerindex(GetPlayerId()), "Revive", 100)
															Print('revived ' .. GetPlayerName(i))
															AddItem(34, 600)
															Notify("+600$.")
														else
															Notify("This player is not dead.")
														end
													elseif(tempitems[menuresult] == "Remove addiction") then
														local price = ActivateInput("Enter the price")
														if(price ~= "") then
															price = tonumber(price)
															if price then
																if(price >= 1000) then
																	TriggerServerEvent('performMedicRequest', i, ConvertIntToPlayerindex(GetPlayerId()), "removeaddict", {price})
																	Notify("Offer has been sent to " .. GetPlayerName(i) .. ".")
																else
																	Notify("Price cannot be lower than 5000$.")
																end
															end
														end
													elseif(tempitems[menuresult] == "Sell drug") then
														local amount = ActivateInput("Enter amount of drugs")
														if(amount ~= "") then
															amount = tonumber(amount)
															if amount then
																if(amount > 0) then
																	if(drugs >= amount) then
																		local price = ActivateInput("Enter the price of drugs")
																		if(price ~= "") then
																			price = tonumber(price)
																			if price then
																				if(price > 0) then
																					TriggerServerEvent('performGangRequest', i, ConvertIntToPlayerindex(GetPlayerId()), "selldrug", {amount, price})
																					Notify("Drug selling offer has been sent to " .. GetPlayerName(i) .. ".")
																				end
																			end
																		end
																	else
																		Notify("You do not have this amount of drugs.")
																	end
																end
															end
														end
													elseif(tempitems[menuresult] == "Sell house") then
														local temphouses = {}
														local tempstreets = {}
														local tempitems = {}
														for j=1,#houses,1 do
															if(houses[j] == GetPlayerName(GetPlayerId())) then
																local streetname = GetStreetAtCoord(houseinfo[j][2][1], houseinfo[j][2][2], houseinfo[j][2][3])
																tempstreets[#tempstreets+1] = streetname
																tempitems[#tempitems+1] = "House #" .. j .. " (" .. streetname .. ")"
																temphouses[#temphouses+1] = j
															end
														end
														DrawWindow("Select house", tempitems)
														while menuactive do
															Wait(0)
														end
														if(menuresult > 0) then
															for j=1,#temphouses,1 do
																local temptext = "House #" .. temphouses[j] .. " (" .. tempstreets[j] .. ")"
																if(tempitems[menuresult] == temptext) then
																	local price = ActivateInput("Enter the price of house")
																	if(price ~= "") then
																		price = tonumber(price)
																		if price then
																			if(price > 0) then
																				TriggerServerEvent('sellHouse', i, ConvertIntToPlayerindex(GetPlayerId()), temphouses[j], price)
																				Notify(Translate("House selling offer has been sent to") .. " " .. GetPlayerName(i) .. ".")
																			end
																		end
																	end
																end
															end
														end
													elseif(tempitems[menuresult] == "Sell vehicle") then
														local tempvehs = {}
														local tempitems = {}
														for j=1,#cars,1 do
															if(cars[j] == 1) then
																tempitems[#tempitems+1] = carinfo[j][1]
																tempvehs[#tempvehs+1] = j
															end
														end
														DrawWindow("Select vehicle", tempitems)
														while menuactive do
															Wait(0)
														end
														if(menuresult > 0) then
															local price = ActivateInput("Enter the price of vehicle")
															if(price ~= "") then
																price = tonumber(price)
																if price then
																	if(price > 0) then
																		TriggerServerEvent('sellVehicle', i, ConvertIntToPlayerindex(GetPlayerId()), tempvehs[menuresult], currtuning[tempvehs[menuresult]], price)
																		Notify("Vehicle selling offer has been sent to " .. GetPlayerName(i) ..".")
																	end
																end
															end
														end
													elseif(tempitems[menuresult] == "Give weapon") then
														::again::
														local amount = ActivateInput("Enter amount")
														if(amount ~= "") then
															amount = tonumber(amount)
															if amount then
																local ammo = GetAmmoInCharWeapon(GetPlayerChar(-1), cw)
																if(ammo >= amount) then
																	TriggerServerEvent('giveWeapon', i, ConvertIntToPlayerindex(GetPlayerId()), cw, amount)
																	ammo = ammo - amount
																	SetCharAmmo(GetPlayerChar(-1), cw, ammo)
																else
																	Notify("You do not have this amount of ammo.")
																	goto again
																end
															end
														end
													elseif(tempitems[menuresult] == "Invite to faction") then
														TriggerServerEvent('performLeaderRequest', i, ConvertIntToPlayerindex(GetPlayerId()), "invite", {job})
														Notify("Offer sent to " .. GetPlayerName(i) .. ".")
													elseif(tempitems[menuresult] == "Remove from faction") then
														TriggerServerEvent('performLeaderRequest', i, ConvertIntToPlayerindex(GetPlayerId()), "remove", {job})
													elseif(tempitems[menuresult] == "Promote") then
														TriggerServerEvent('performLeaderRequest', i, ConvertIntToPlayerindex(GetPlayerId()), "promote", {job})
													elseif(tempitems[menuresult] == "Demote") then
														TriggerServerEvent('performLeaderRequest', i, ConvertIntToPlayerindex(GetPlayerId()), "demote", {job})
													elseif(tempitems[menuresult] == "Offer sexual service") then
														DrawWindow("Select service", {"Handjob", "Blowjob", "Sex"})
														while menuactive do
															Wait(0)
														end
														if(menuresult > 0) then
															local price = ActivateInput("Enter a price of service")
															if(price ~= "") then
																price = tonumber(price)
																if price then
																	if(price > 0) then
																		TriggerServerEvent('sendStuffOffer', i, ConvertIntToPlayerindex(GetPlayerId()), menuresult, price)
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
							end
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent('sellHouse')
AddEventHandler('sellHouse', function(id, sender, houseid, price)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		if(inventory[34] >= price) then
			DrawWindow("" .. GetPlayerName(sender) .. " offers you to purchase House #" .. houseid, {"Accept offer for ~g~" .. price .. "$"})
			while menuactive do
				Wait(0)
			end
			if(menuresult == 1) then
				RemoveItem(34, price)
				SaveStats()
				houses[houseid] = GetPlayerName(GetPlayerId())
				SaveHouses()
				TriggerServerEvent('sendMoneyToPlayer', sender, id, price)
				TriggerServerEvent('sendMessageToPlayer', sender, "" .. GetPlayerName(id) .. " has accepted your offer.")
				SendMessageToNearbyPlayers("" .. GetPlayerName(sender) .. " has sold house to " .. GetPlayerName(id) .. ".", 20)
			else
				TriggerServerEvent('sendMessageToPlayer', sender, "" .. GetPlayerName(id) .. " has declined your offer.")
			end
		else
			TriggerServerEvent('sendMessageToPlayer', sender, "This player does not have enough money.")
		end
	end
end)

RegisterNetEvent('sellVehicle')
AddEventHandler('sellVehicle', function(id, sender, vehid, tuning, price)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		if(inventory[34] >= price) then
			DrawWindow("" .. GetPlayerName(sender) .. " offers you to purchase " .. carinfo[vehid][1], {"Accept offer for ~g~" .. price .. "$"})
			while menuactive do
				Wait(0)
			end
			if(menuresult == 1) then
				RemoveItem(34, price)
				SaveStats()
				cars[vehid] = 1
				SaveCars()
				currtuning[vehid] = tuning
				SaveTuning()
				TriggerServerEvent('sendMoneyToPlayer', sender, id, price)
				TriggerServerEvent('removeVeh', sender, vehid)
				TriggerServerEvent('sendMessageToPlayer', sender, "" .. GetPlayerName(id) .. " has accepted your offer.")
				SendMessageToNearbyPlayers("" .. GetPlayerName(sender) .. " has sold vehicle to " .. GetPlayerName(id) .. ".", 20)
			else
				TriggerServerEvent('sendMessageToPlayer', sender, "" .. GetPlayerName(id) .. " has declined your offer.")
			end
		else
			TriggerServerEvent('sendMessageToPlayer', sender, "This player does not have enough money.")
		end
	end
end)

RegisterNetEvent('removeVeh')
AddEventHandler('removeVeh', function(id, vehid)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		cars[vehid] = 0
		SaveCars()
	end
end)

RegisterNetEvent('giveWeapon')
AddEventHandler('giveWeapon', function(id, sender, wep, ammo)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		GiveWeaponToChar(GetPlayerChar(-1), wep, ammo, 1)
		Notify("You have received an item from " .. GetPlayerName(sender) .. ".")
		SendMessageToNearbyPlayers("" .. GetPlayerName(sender) .. " has given an item to " .. GetPlayerName(id) .. ".", 20)
	end
end)