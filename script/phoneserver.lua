RegisterServerEvent('playerActivated')
AddEventHandler('playerActivated', function()
	local playername = GetPlayerName(source)
	local data = nil
	
	data = GetDataFromFile("database/phone/" .. playername .. ".msgtitles", ",")
	if data then
		TriggerClientEvent('updPhoneMessagesTitles', source, data)
		print("SERVER: " .. playername .. ".msgtitles has been loaded.")
	end
	
	data = GetDataFromFile("database/phone/" .. playername .. ".msgs", ",")
	if data then
		TriggerClientEvent('updPhoneMessages', source, data)
		print("SERVER: " .. playername .. ".msgs has been loaded.")
	end
	
	data = GetDataFromFile("database/phone/" .. playername .. ".back", ",")
	if data then
		TriggerClientEvent('updPhoneBack', source, data[1])
		print("SERVER: " .. playername .. ".back has been loaded.")
	end
	
	data = GetDataFromFile("database/phone/" .. playername .. ".ring", ",")
	if data then
		TriggerClientEvent('updPhoneRing', source, data[1])
		print("SERVER: " .. playername .. ".ring has been loaded.")
	end
end)

RegisterServerEvent('savePhoneMessages')
AddEventHandler('savePhoneMessages', function(data)
	local playername = GetPlayerName(source)
	local titles = {}
	local msgs = {}
	for i=1,#data,1 do
		titles[i] = data[i][1]
		msgs[i] = data[i][2]
	end
	SaveDataToFile("database/phone/" .. playername .. ".msgtitles", titles, ",")
	SaveDataToFile("database/phone/" .. playername .. ".msgs", msgs, "|")
end)

RegisterServerEvent('sendPhoneMessage')
AddEventHandler('sendPhoneMessage', function(id, title, msg)
	TriggerClientEvent('sendPhoneMessage', -1, id, title, msg)
end)

RegisterServerEvent('saveBack')
AddEventHandler('saveBack', function(bid)
	local playername = GetPlayerName(source)
	
	os.remove("database/phone/" .. playername .. ".back")
	
	local f,err = io.open("database/phone/" .. playername .. ".back", "w")
    if not f then return print(err) end
    f:write(bid)
    f:close()
end)

RegisterServerEvent('saveRing')
AddEventHandler('saveRing', function(bid)
	local playername = GetPlayerName(source)
	
	os.remove("database/phone/" .. playername .. ".ring")
	
	local f,err = io.open("database/phone/" .. playername .. ".ring", "w")
    if not f then return print(err) end
    f:write(bid)
    f:close()
end)
---------------------
RegisterServerEvent('callPlayer')
AddEventHandler('callPlayer', function(target, caller)
	TriggerClientEvent('callPlayer', -1, target, caller)
end)

RegisterServerEvent('cancelCall')
AddEventHandler('cancelCall', function(target)
	TriggerClientEvent('cancelCall', -1, target)
end)

RegisterServerEvent('finishCall')
AddEventHandler('finishCall', function(target)
	TriggerClientEvent('finishCall', -1, target)
end)

RegisterServerEvent('returnCallResult')
AddEventHandler('returnCallResult', function(target, result)
	TriggerClientEvent('returnCallResult', -1, target, result)
end)

RegisterServerEvent('updateCall')
AddEventHandler('updateCall', function(id, state)
	TriggerClientEvent('updateCall', -1, id, state)
end)

RegisterServerEvent('sendMSG')
--RegisterNetEvent('myEvent')
AddEventHandler('sendMSG', function(receiver, sender, msg)
	TriggerClientEvent('sendMSG', -1, receiver, sender, msg)
end)


RegisterServerEvent('playerActivated')
AddEventHandler('playerActivated', function()
	local playername = GetPlayerName(source)
	
	local filepass = io.open("database/phone/" .. playername .. ".back", "r")
	if filepass then
		io.input(filepass)
		local back = io.read()
		TriggerClientEvent('updback', source, back)
		print("SERVER: " .. playername .. ".back has been loaded.")
	end
	io.close(filepass)
end)

RegisterServerEvent('saveback')
AddEventHandler('saveback', function(back)
	local playername = GetPlayerName(source)
	
	os.remove("database/phone/" .. playername .. ".back")
	
	local f,err = io.open("database/phone/" .. playername .. ".back", "w")
    if not f then return print(err) end
    f:write(back)
    print("SERVER: " .. playername .. ".back has been saved.")
    f:close()
end)


RegisterServerEvent('playerActivated')
AddEventHandler('playerActivated', function()
	local playername = GetPlayerName(source)
	
	local filepass = io.open("database/phone/" .. playername .. ".cover", "r")
	if filepass then
		io.input(filepass)
		local cover = io.read()
		TriggerClientEvent('updcover', source, cover)
		print("SERVER: " .. playername .. ".cover has been loaded.")
	end
	io.close(filepass)
end)

RegisterServerEvent('playerActivated')
AddEventHandler('playerActivated', function()
	local playername = GetPlayerName(source)
	
	local filepass = io.open("database/phone/" .. playername .. ".number", "r")
	if filepass then
		io.input(filepass)
		local number = io.read()
		TriggerClientEvent('updnumber', source, number)
		print("SERVER: " .. playername .. ".number has been loaded.")
	end
	io.close(filepass)
end)

RegisterServerEvent('savecover')
AddEventHandler('savecover', function(cover)
	local playername = GetPlayerName(source)
	
	os.remove("database/phone/" .. playername .. ".cover")
	
	local f,err = io.open("database/phone/" .. playername .. ".cover", "w")
    if not f then return print(err) end
    f:write(cover)
    print("SERVER: " .. playername .. ".cover has been saved.")
    f:close()
end)

RegisterServerEvent('savenumber')
AddEventHandler('savenumber', function(number)
	local playername = GetPlayerName(source)
	
	os.remove("database/phone/" .. playername .. ".number")
	
	local f,err = io.open("database/phone/" .. playername .. ".number", "w")
    if not f then return print(err) end
    f:write(number)
    print("SERVER: " .. playername .. ".number has been saved.")
    f:close()
end)
