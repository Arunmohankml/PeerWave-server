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
weapons["fthrower"] = 19
weapons["minigun"] = 20
weapons["camera"] = 45
weapons["stickybomb"] = 22

blacklist = {}
local file = io.open("database/bans/blacklist", "r")
if file then
	io.input(file)
	local lines = io.read()
	local parts = Split(lines, ",")
	for i=1,#parts,1 do
		blacklist[i] = parts[i]
	end
	print("SERVER: Blacklist has been loaded.")
end
io.close(file)

RegisterServerEvent('playerActivated')
 
AddEventHandler('playerActivated', function()
	local playername = GetPlayerName(source)
	
	local file1 = io.open("database/admins/" .. playername .. ".admin", "r")
	if file1 then
		io.input(file1)
		local admin = io.read()
		TriggerClientEvent('updAdmin', source, admin)
		print("SERVER: " .. playername .. ".admin has been loaded.")
	end
	io.close(file1)
	
	local file2 = io.open("database/bans/" .. playername .. ".ban", "r")
	if file2 then
		--io.input(file2)
		--local admin = io.read()
		DropPlayer(source, "Banned")
		--print("SERVER: " .. playername .. ".ban has been loaded.")
	end
	io.close(file2)	

		
	
	local file4 = io.open("database/bans/blacklist", "r")
	if file4 then
		io.input(file4)
		local lines = io.read()
		local parts = Split(lines, ",")
		for i=1,#parts,1 do
			blacklist[i] = parts[i]
		end
		print("SERVER: Blacklist has been loaded.")
	end
	io.close(file4)
	
	local endpoint = GetPlayerEP(source)
	local ip = endpoint:sub(1, #endpoint - 6)
	for i=1,#blacklist,1 do
		if(blacklist[i] == ip) then
			DropPlayer(source, "Banned")
		end
	end
end)

RegisterServerEvent('revall')
AddEventHandler('revall', function()
	TriggerClientEvent('revall', -1)
end)

RegisterServerEvent('requestKick1')
 
AddEventHandler('requestKick1', function(id)
	TriggerClientEvent('requestKick2', -1, id)
end)
RegisterServerEvent('kickPlayer2')
 
AddEventHandler('kickPlayer2', function()
	DropPlayer(source, "Kicked")
end)

RegisterServerEvent('requestBan1')
 
AddEventHandler('requestBan1', function(id)
	TriggerClientEvent('requestBan2', -1, id)
end)
RegisterServerEvent('banPlayer')
 
AddEventHandler('banPlayer', function()
	local playername = GetPlayerName(source)
	
	os.remove("database/bans/" .. playername .. ".ban")
	
	local f,err = io.open("database/bans/" .. playername .. ".ban", "w")
    if not f then return print(err) end
    f:write(1)
    --print("SERVER: " .. playername .. ".ban has been saved.")
    f:close()
	
	DropPlayer(source, "Banned")
end)

RegisterServerEvent('requestBanIP1')
 
AddEventHandler('requestBanIP1', function(id)
	TriggerClientEvent('requestBanIP2', -1, id)
end)
RegisterServerEvent('banPlayerIP')
 
AddEventHandler('banPlayerIP', function()
	local playername = GetPlayerName(source)
	local endpoint = GetPlayerEP(source)
	
	local ip = endpoint:sub(1, #endpoint - 6)
	blacklist[#blacklist+1] = ip
	
	os.remove("database/bans/" .. playername .. ".ip")
	local f,err = io.open("database/bans/" .. playername .. ".ip", "w")
    if not f then return print(err) end
    f:write(ip)
    f:close()
	
	local f,err = io.open("database/bans/blacklist", "w")
    if not f then
		f:write(ip)
	else
		f:write("," .. ip)
	end
    f:close()
	
	DropPlayer(source, "Banned IP")
end)

function Split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end
	return t
end

RegisterServerEvent('performAdminRequest')
 
AddEventHandler('performAdminRequest', function(id, adminid, request)
	TriggerClientEvent('performAdminRequest', -1, id, adminid, request)
end)

RegisterServerEvent('performMsgRequest')
 
AddEventHandler('performMsgRequest', function(id, adminid, request)
	TriggerClientEvent('performMsgRequest', -1, id, adminid, request)
end)

RegisterServerEvent('showPlayerInfo')
 
AddEventHandler('showPlayerInfo', function(id, data)
	TriggerClientEvent('showPlayerInfo', -1, id, data)
end)

