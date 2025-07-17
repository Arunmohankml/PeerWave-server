RegisterServerEvent('playerActivated')
AddEventHandler('playerActivated', function()
	local playername = GetPlayerName(source)
	
	local data = GetDataFromFile("database/pos/" .. playername .. ".pos", ",")
	if data then
		TriggerClientEvent('updLastPos', source, data)
		print("SERVER: " .. playername .. ".pos has been loaded.")
	end
	
	local data = GetDataFromFile("database/hp/" .. playername .. ".hp", ",")
	if data then
		TriggerClientEvent('updHealth', source, data)
		print("SERVER: " .. playername .. ".hp has been loaded.")
	end
end)



RegisterServerEvent('saveLastPos')
AddEventHandler('saveLastPos', function(x, y, z)
	local playername = GetPlayerName(source)
	SaveDataToFile("database/pos/" .. playername .. ".pos", {x, y, z}, ",")
end)

RegisterServerEvent('saveHealth')
AddEventHandler('saveHealth', function(h, a)
	local playername = GetPlayerName(source)
	SaveDataToFile("database/hp/" .. playername .. ".hp", {h, a}, ",")
end)