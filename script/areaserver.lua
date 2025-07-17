RegisterServerEvent('playerActivated')
AddEventHandler('playerActivated', function()
	local data = GetDataFromFile("database/area.info", ",")
	if data then
		TriggerClientEvent('updAreas', source, data)
		print("SERVER: area.info has been loaded.")
	end
end)

RegisterServerEvent('saveAreas')
AddEventHandler('saveAreas', function(data)
	SaveDataToFile("database/area.info", data, ",")
	TriggerClientEvent('updAreas', -1, data)
end)

RegisterServerEvent('startCapture')
AddEventHandler('startCapture', function(attacker, target, area)
	TriggerClientEvent('startCapture', -1, attacker, target, area)
end)

RegisterServerEvent('finishCapture')
AddEventHandler('finishCapture', function(capturer, protector, win)
	TriggerClientEvent('finishCapture', -1, capturer, protector, win)
end)

RegisterServerEvent('updCaptureInfo')
AddEventHandler('updCaptureInfo', function(timer, attacker, target, area, attackerkills, targetkills)
	TriggerClientEvent('updCaptureInfo', -1, timer, attacker, target, area, attackerkills, targetkills)
end)