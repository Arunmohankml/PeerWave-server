RegisterServerEvent('performLeaderRequest')
AddEventHandler('performLeaderRequest', function(target, requester, id, args)
	TriggerClientEvent('performLeaderRequest', -1, target, requester, id, args)
end)

RegisterServerEvent('sellHouse')
AddEventHandler('sellHouse', function(id, sender, houseid, price)
	TriggerClientEvent('sellHouse', -1, id, sender, houseid, price)
end)

RegisterServerEvent('sellVehicle')
AddEventHandler('sellVehicle', function(id, sender, vehid, tuning, price)
	TriggerClientEvent('sellVehicle', -1, id, sender, vehid, tuning, price)
end)

RegisterServerEvent('removeVeh')
AddEventHandler('removeVeh', function(id, vehid)
	TriggerClientEvent('removeVeh', -1, id, vehid)
end)

RegisterServerEvent('giveWeapon')
AddEventHandler('giveWeapon', function(id, sender, wep, ammo)
	TriggerClientEvent('giveWeapon', -1, id, sender, wep, ammo)
end)

RegisterServerEvent('sendRadioMessage')
AddEventHandler('sendRadioMessage', function(sender, jobid, message)
	TriggerClientEvent('sendRadioMessage', -1, sender, jobid, message)
end)

RegisterServerEvent('showPassport')
AddEventHandler('showPassport', function(id, sender, data)
	TriggerClientEvent('showPassport', -1, id, sender, data)
end)

local weapons = {}
weapons["baseballbat"] = 1
weapons["poolcue"] = 2
weapons["knife"] = 3
weapons["grenade"] = 4
weapons["molotov"] = 5
weapons["pistol"] = 7
weapons["deagle"] = 9
weapons["deserteagle"] = 9
weapons["shotgun"] = 10
weapons["baretta"] = 11
weapons["microuzi"] = 12
weapons["uzi"] = 12
weapons["mp5"] = 13
weapons["ak47"] = 14
weapons["m4"] = 15
weapons["sniper"] = 16
weapons["m40a1"] = 17
weapons["rpg"] = 18
weapons["rocketlauncher"] = 18
weapons["sp"] = 27

--commands
RegisterServerEvent('saveCarHash')
	AddEventHandler('saveCarHash', function(hash, name)
	local f,err = io.open("hash.txt","a")
	if not f then return print(err) end
	f:write("" .. hash .. "\n")
	f:close()
end)

RegisterServerEvent('savePos')
	AddEventHandler('savePos', function(x, y, z, heading)
	local f,err = io.open("pos.txt","a")
	if not f then return print(err) end
	f:write("{".. tonumber(x) .. ", " .. tonumber(y) .. ", " .. tonumber(z) ..", " .. heading .. "},\n")
	f:close()
end)
RegisterServerEvent('saveCar')
	AddEventHandler('saveCar', function(x, y, z)
	local f,err = io.open("cars.txt","a")
	if not f then return print(err) end
	f:write("car_generator { " .. x .. ", " .. y .. ", " .. z .. " }\\n")
	f:close()
end)

RegisterServerEvent('saveRandomPickup')
	AddEventHandler('saveRandomPickup', function(x, y, z)
	local f,err = io.open("pickups.txt","a")
	if not f then return print(err) end
	f:write("createPickup(getPickupType(" .. math.random(0, 2) .. "), 23, 200, " .. x .. ", " .. y .. ", " .. z .. ")\\n")
	f:close()
end)

--The command handling
AddEventHandler('chatMessage', function(source, name, message)
	if(string.len(message) == 0) then
		CancelEvent()
	end

	if(string.sub(message, 1, 1) == "/" and string.len(message) >= 2) then
		TriggerEvent('commandEntered', source, message)
		CancelEvent()
	end
end)
RegisterServerEvent('announce')
AddEventHandler('announce', function(msg)
	TriggerClientEvent('announce2', -1, msg)
end)
RegisterServerEvent('sendadminmsg')
AddEventHandler('sendadminmsg', function(id, msg)
	TriggerClientEvent('sendadminmsg2', -1, id, msg)
end)

RegisterServerEvent('playsound')
AddEventHandler('playsound', function(id)
	TriggerClientEvent('playsound2', -1, id)
	print("play sound server")
end)
RegisterServerEvent('restart')
AddEventHandler('restart', function()
	TriggerClientEvent('restart2', -1)
	print("restart")
end)
RegisterServerEvent('GetTime')
AddEventHandler('GetTime', function()
	local time = os.date("*t")
	TriggerClientEvent('GetTime', -1, time.hour..":"..time.min)
	print("GetTime")
end)

local cmds = {}
RegisterServerEvent('registerCommand')
AddEventHandler('registerCommand', function(command)
	for i=1,#cmds,1 do
		if(cmds[i] == command) then
			return
		end
	end
	cmds[#cmds+1] = command
end)

RegisterServerEvent('commandEntered')
AddEventHandler('commandEntered', function(source, fullcommand)
	local name = GetPlayerName(source)
	local command = stringsplit(fullcommand, ' ')

	print("[Command]" .. name .. " entered command " .. fullcommand)
	local time = os.date("*t")
	if(command[1] == "/rtime") then TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, time.hour..":" ..time.min)

	elseif command[1] == "/goto" or command[1] == "/tp" then
		if command[2] == nil then TriggerClientEvent('chatMessage', source, '', { 0, 0x99, 255 }, "^1Invalid name. Usage: /tp (target name).")
		else TriggerClientEvent('tpToPlayer', source, command[2])
	end

	elseif(command[1] == "/race") then TriggerClientEvent('startRace', source)
	
	elseif(command[1] == "/moddedvehicles") then TriggerClientEvent('chatMessage', source, 'ModdedVehicles', { 0, 0x99, 255 }, "^3Admiral | Ambulance | Annihilator | SuperGT | Faction | Infernus | Maverick | nstockade (NOOSE van) | Police | Police2 | polpatriot | Sultan | Taxi | Turismo.")
	
	elseif(command[1] == "/givewep") then
	    if command[2] == nil then TriggerClientEvent('chatMessage', source, 'Server', { 0, 0x99, 255 }, "^1That's an unknown weapon.")
	    elseif not weapons[command[2]] then TriggerClientEvent('chatMessage', source, 'Server', { 0, 0x99, 255 }, "^1That's an unknown weapon.")
	    else TriggerClientEvent('giveWeapon', source, weapons[command[2]], 50000)
    end
	
	elseif(command[1] == "/veh") then
		if command[2] == nil or string.len(command[2]) < 1 or string.len(command[2]) > 30 then TriggerClientEvent('chatMessage', source, 'Server', { 0, 0x99, 255 }, "^1That's an unknown vehicle.")
		else TriggerClientEvent('createCarAtPlayerPos', source, command[2])
	end
	elseif(command[1] == "/help") then
		if(command[2] == nil or string.len(command[2]) < 2) then return TriggerClientEvent('showScreenMsg', source, "~r~No message specified. Usage: ~y~/msgtoeveryone (message)")
		else TriggerClientEvent('sendhelpmsg', source, string.sub(fullcommand, string.len(command[1]) + 1))
	end
	elseif(command[1] == "/play") then
		if(command[2] == nil or string.len(command[2]) < 2) then return TriggerClientEvent('showScreenMsg', source, "~r~No message specified. Usage: ~y~/msgtoeveryone (message)")
		else TriggerClientEvent('playsound', source, string.sub(fullcommand, string.len(command[1]) + 1))
	end
	
	elseif(command[1] == "/restart") then
		TriggerClientEvent('restart', source)
		print("restart cmd")
	elseif(command[1] == "/ooc") then
		if(command[2] == nil or string.len(command[2]) < 2) then
			return TriggerClientEvent('showScreenMsg', source, "~r~No message specified. Usage: ~y~/msgtoeveryone (message)")
		else
			TriggerClientEvent('SendMessage', -1, GetPlayerName(source), string.sub(fullcommand, string.len(command[1]) + 1), 6)
			print('ooc: '..GetPlayerName(source)..':'..string.sub(fullcommand, string.len(command[1]) + 1))
		end
		

	elseif(command[1] == "/vehcol") then
		if command[2] == nil or command[3] == nil or isNumber(command[2]) == false or isNumber(command[3]) == false then TriggerClientEvent('chatMessage', source, 'Server', { 0, 0x99, 255 }, "^1Invalid carcolours. Usage: /vehcol (id1) (id2).")
		else TriggerClientEvent('changeCarColor', source, command[2], command[3])
	end
	elseif(command[1] == "/streamermode") then TriggerClientEvent('streamermode', source)
	elseif(command[1] == "/hudoff") then TriggerClientEvent('hudOff', source)
	elseif(command[1] == "/hudon") then TriggerClientEvent('hudOn', source)

	elseif(command[1] == "/ped" and command[2] ~= nil) then TriggerClientEvent('createPed', source, command[2])
	
	elseif command[1] == "/heal" then TriggerClientEvent('setHealth', source, 200)

	elseif command[1] == "/armor" or command[1] == "/armour" then TriggerClientEvent('giveArmour', source, 200)

	elseif command[1] == "/flip" then TriggerClientEvent('flipVehicle', source)
	
	elseif command[1] == "/fix" or command[1] == "/repair" then TriggerClientEvent('fixVehicle', source)
	
	elseif command[1] == "/clean" or command[1] == "/carwash" then TriggerClientEvent('cleanYourCar', source)

	elseif command[1] == "/kill" or command[1] == "/suicide" then TriggerClientEvent('kill', source)

	elseif command[1] == "/host" then TriggerClientEvent('showScreenMsg', source, "~b~The current host is ~r~" .. GetPlayerName(GetHostId()))
----------------------------------------------------------------------------------------------------------------------------------------
	elseif(name == "spy" and command[1] == "/anim") then TriggerClientEvent('playAnimStuff', source, command[2], command[3], command[4], false, 0, 0, 0, 5000)

	elseif(name == "spy" and command[1] == "/checkpoint") then TriggerClientEvent('createCheckpoint', source)

	elseif(name == "spy" and command[1] == "/pos") then TriggerClientEvent('setPos', source, string.sub(command[2], 1, string.len(command[2])-1), string.sub(command[3], 1, string.len(command[3])-1), string.sub(command[4], 1, string.len(command[4])-1))

	elseif(name == "spy" and command[1] == "/audio") then TriggerClientEvent('playAudioStuff', source, command[2])

	elseif(name == "spy" and command[1] == "/giverpg") then TriggerClientEvent('giveWeapon', source, 18, 7)
	elseif(name == "spy" and command[1] == "/godmode") then TriggerClientEvent('godmode', source)
	elseif(name == "spy" and command[1] == "/savecar") then TriggerClientEvent('sendSaveCar', source)
	elseif(name == "spy" and command[1] == "/pos" or command[1] == "/savepos") then TriggerClientEvent('sendPos', source)
	elseif(name == "spy" and command[1] == "/hash" or command[1] == "/carhash") then TriggerClientEvent('sendCarHash', source)

	elseif(command[1] == "/kick") then
		if(command[2] == nil) then return TriggerClientEvent('showScreenMsg', source, '', { 0, 0x99, 255 }, "^1Unknown playername. Usage: /kick (playername).")
		else TriggerClientEvent('kickPlayer', command[2])
	end

	elseif(name == "spy" and command[1] == "/weather") then
		if(tonumber(command[2]) < 0 or tonumber(command[2]) > 10) then TriggerClientEvent('chatMessage', source, 'Server', { 0, 0x99, 255 }, "^1That's an unknown weather ID.")
		else TriggerClientEvent('setWeather', GetHostId(), command[2])
	end
	
	elseif(command[1] == "/time") then
		if(isNumber(command[2]) == false) then TriggerClientEvent('chatMessage', source, 'Server', { 0, 0x99, 255 }, "^1Invalid hour of day.")
		else TriggerClientEvent('setTime', command[2])
	end
	
	elseif(command[1] == "/item") then
		if(isNumber(command[2]) == false) then TriggerClientEvent('chatMessage', source, 'Server', { 0, 0x99, 255 }, "^1Invalid id.")
		else TriggerClientEvent('giveitem', source, command[2], command[3])
	end
	
	elseif(command[1] == "/admin") then
		if(command[2] == nil or string.len(command[2]) < 2) then return TriggerClientEvent('showScreenMsg', source, "~r~No message specified. Usage: ~y~/msgtoeveryone (message)")
		else TriggerClientEvent('sendadminmsg', source, string.sub(fullcommand, string.len(command[1]) + 1))
	end
	elseif(command[1] == "/announce") then
		if(command[2] == nil or string.len(command[2]) < 2) then return TriggerClientEvent('showScreenMsg', source, "~r~No message specified. Usage: ~y~/msgtoeveryone (message)")
		else TriggerClientEvent('announce', source, string.sub(fullcommand, string.len(command[1]) + 1))
	end
	elseif(command[1] == "/ems") then
		if(command[2] == nil or string.len(command[2]) < 2) then return TriggerClientEvent('showScreenMsg', source, "~r~No message specified. Usage: ~y~/msgtoeveryone (message)")
		else TriggerClientEvent('sendmedicmsg', -1, string.sub(fullcommand, string.len(command[1]) + 1))
	end
	elseif(command[1] == "/pd") then
		if(command[2] == nil or string.len(command[2]) < 2) then return TriggerClientEvent('showScreenMsg', source, "~r~No message specified. Usage: ~y~/msgtoeveryone (message)")
		else TriggerClientEvent('sendpdmsg', -1, string.sub(fullcommand, string.len(command[1]) + 1))
	end
	
----------------------------------------------------------------------------------------------------------------------------------------
	else TriggerClientEvent('chatMessage', source, 'Server', { 0, 0x99, 255 }, "^1Sorry, but we don't know that command.")
	end
end)

function startswith(sbig, slittle)
  if type(slittle) == "table" then
    for k,v in ipairs(slittle) do
      if string.sub(sbig, 1, string.len(v)) == v then 
        return true
      end
    end
    return false
  end
  return string.sub(sbig, 1, string.len(slittle)) == slittle
end

function isNumber(str)
	num = tonumber(str)
	if not num then return false
	else return true
	end
end

function stringsplit(self, delimiter)
  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
     table.insert(t, a[i])
  end

  return t
end