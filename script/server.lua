SetGameType("Roleplay")

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

function GetDataFromFile(path, sep)
	local file = io.open(path, "r")
	if file then
		io.input(file)
		local lines = io.read()
		local parts = Split(lines, sep)
		io.close(file)
		return parts
	else
		return nil
	end
end

function SaveDataToFile(path, data, sep)
	os.remove(path)
	local tempstring = ""
	for i=1,#data,1 do
		if(i ~= #data) then
			tempstring = tempstring .. data[i] .. sep
		else
			tempstring = tempstring .. data[i]
		end
	end
	local f,err = io.open(path, "w")
    if not f then return print(err) end
    f:write(tempstring)
    f:close()
end

local day = 0
local tmp = GetDataFromFile("database/day.info", ",")
if tmp then
	day = tmp[1]
	print("SERVER: day.info has been loaded.")
end

RegisterServerEvent('SendChatMessage')
AddEventHandler('SendChatMessage', function(name, x, y, z, text)
	if(string.sub(text, 1, 1) == "/" and string.len(text) >= 2) then
		TriggerEvent('chatMessage', source, name, text)
	else
		TriggerClientEvent('SendChatMessage', -1, name, x, y, z, text)
	end
end)

RegisterServerEvent('SendMessage')
AddEventHandler('SendMessage', function(m1, m2, time, msgid)
	TriggerClientEvent('SendMessage', source, m1, m2, time, msgid)
end)

RegisterServerEvent('Print')
AddEventHandler('Print', function(name, text)
	print("Player " .. name .. " : " .. text)
end)

RegisterServerEvent('playerActivated')
AddEventHandler('playerActivated', function()
	local playername = GetPlayerName(source)
	local data = nil
	
	data = GetDataFromFile("database/leader/leaders.info", ",")
	if data then
		if(data[i] ~= "None") then
			data2 = GetDataFromFile("database/leader/" .. data[i] .. ".leaderdate", ",")
			if data2 then
				local ref = os.time{day=data2[1], month=data2[2], year=data2[3]}
				local span = os.difftime(os.time(), ref)/(24*60*60)
				local days = math.floor(span)
				if(days > 7) then
					print("SERVER: " .. data[i] .. " has been removed from leaders.")
					data[i] = "None"
				else
					if(data[i] == playername) then
						local arr = os.date("*t")
						SaveDataToFile("Kdatabase/leader/" .. playername .. ".leaderdate", {arr.day, arr.month, arr.year}, ",")
					end
				end
			end
		end
		SaveDataToFile("database/leader/leaders.info", data, ",")
		TriggerClientEvent('updLeaders', -1, data)
		print("SERVER: leaders.info has been loaded.")
	end
	
	data = GetDataFromFile("database/stats/" .. playername .. ".stats", ",")
	if data then
		TriggerClientEvent('updStats', source, data)
		print("SERVER: " .. playername .. ".stats has been loaded.")
	end
	
	local file6 = io.open("database/inv/" .. playername .. ".inv", "r")
	if file6 then
		io.input(file6)
		local lines = io.read()
		local parts = Split(lines, ",")
		TriggerClientEvent('updInv', source, parts)
		print("SERVER: " .. playername .. ".inv has been loaded.")
	end
	io.close(file6)
	
	
	data = GetDataFromFile("database/jobprogress/" .. playername .. ".jobprogress", ",")
	if data then
		TriggerClientEvent('updJobProgress', source, data)
		print("SERVER: " .. playername .. ".jobprogress has been loaded.")
	end
	
	data = GetDataFromFile("database/parts/" .. playername .. ".parts", ",")
	if data then
		TriggerClientEvent('updParts', source, data)
		print("SERVER: " .. playername .. ".parts has been loaded.")
	end
	
	data = GetDataFromFile("database/mats.info", ",")
	if data then
		TriggerClientEvent('updMats', source, data)
		print("SERVER: mats.info has been loaded.")
	end
	
	data = GetDataFromFile("database/animalinv/" .. playername .. ".animalinv", ",")
	if data then
		TriggerClientEvent('updAnimalInv', source, data)
		print("SERVER: " .. playername .. ".animalinv has been loaded.")
	end
	
	data = GetDataFromFile("database/cars/" .. playername .. ".cars", ",")
	if data then
		TriggerClientEvent('updCars', source, data)
		print("SERVER: " .. playername .. ".cars has been loaded.")
	end
	
	local temptune = {}
	for i=1,300,1 do
		data = GetDataFromFile("database/tuning/" .. playername .. ".tuning" .. i, ",")
		if data then
			temptune[i] = data
		end
	end
	if(#temptune > 0) then
		TriggerClientEvent('updTuning', source, temptune)
		print("SERVER: " .. playername .. ".tuning has been loaded.")
	end
	
	------
	data = GetDataFromFile("database/houses.info", ",")
	if data then
		TriggerClientEvent('updHouses', source, data)
		print("SERVER: houses.info has been loaded.")
	end
	
	data = GetDataFromFile("database/housecash.info", ",")
	if data then
		TriggerClientEvent('updHouseCash2', source, data)
		print("SERVER: housecash.info has been loaded.")
	end
	
	local file17 = io.open("database/outfits/" .. playername .. ".outfits", "r")
	if file17 then
		io.input(file17)
		local lines = io.read()
		local parts = Split(lines, "|")
		local parts2 = {}
		for i=1,#parts,1 do
			parts2[i] = Split(parts[i], ",")
		end
		TriggerClientEvent('updOutfits', source, parts2)
		print("SERVER: " .. playername .. ".outfits has been loaded.")
	end
	io.close(file17)
	------
	data = GetDataFromFile("database/biz.info", ",")
	if data then
		TriggerClientEvent('updBiz', source, data)
		print("SERVER: biz.info has been loaded.")
	end

	data = GetDataFromFile("database/main.info", ",")
	if data then
		TriggerClientEvent('updServerInfo', source, data)
		print("SERVER: main.info has been loaded.")
	end

	data = GetDataFromFile("database/bizcash.info", ",")
	if data then
		TriggerClientEvent('updBizCash2', source, data)
		print("SERVER: bizcash.info has been loaded.")
	end
	
	data = GetDataFromFile("database/bizincome.info", ",")
	if data then
		TriggerClientEvent('updBizIncome2', source, data)
		print("SERVER: bizincome.info has been loaded.")
	end
	
	data = GetDataFromFile("database/bizmis.info", ",")
	if data then
		TriggerClientEvent('updBizMission', source, data)
		print("SERVER: bizmis.info has been loaded.")
	end
	
	data = GetDataFromFile("database/bizstats/bizincome.info", ",")
	if data then
		TriggerClientEvent('updBizStats', source, data)
		print("SERVER: bizstats/bizincome.info has been loaded.")
	end
	------
	
	data = GetDataFromFile("database/fuel/" .. playername .. ".fuel", ",")
	if data then
		TriggerClientEvent('updFuel', source, data)
		print("SERVER: " .. playername .. ".fuel has been loaded.")
	end
end)

RegisterServerEvent('dailyStuff')
AddEventHandler('dailyStuff', function()
	local arr = os.date("*t")
	if(arr.day ~= day) then
		local data = GetDataFromFile("database/houses.info", ",")
		if data then
			local data2 = GetDataFromFile("database/housecash.info", ",")
			if not data2 then
				data2 = {}
				for i=1,#data,1 do
					data2[i] = 0
				end
			else
				for i=1,#data,1 do
					if(data2[i] == nil) then
						data2[i] = 0
					end
				end
			end
			for i=1,#data,1 do
				if(data[i] ~= "0") then
					data2[i] = data2[i] + 1
					TriggerClientEvent('updHouseCash', -1, data[i], i, data2[i])
					if(data2[i] > 3) then
						data[i] = "0"
						data2[i] = 0
					end
				end
			end
			--Wait(1000)
			TriggerEvent('saveHouses', data)
			TriggerEvent('saveHouseCash', data2)
		end
		data = GetDataFromFile("database/biz.info", ",")
		if data then
			local data2 = GetDataFromFile("database/bizcash.info", ",")
			if not data2 then
				data2 = {}
				for i=1,#data,1 do
					data2[i] = 0
				end
			else
				for i=1,#data,1 do
					if(data2[i] == nil) then
						data2[i] = 0
					end
				end
			end
			for i=1,#data,1 do
				if(data[i] ~= "0") then
					data2[i] = data2[i] + 1
					TriggerClientEvent('updBizCash', -1, data[i], i, data2[i])
					if(data2[i] > 3) then
						data[i] = "0"
						data2[i] = 0
					end
				end
			end
			--Wait(1000)
			TriggerEvent('saveBiz', data)
			TriggerEvent('saveBizCash', data2)
		end
		local data = GetDataFromFile("database/biz.info", ",")
		if data then
			local data2 = {}
			for i=1,#data,1 do
				data2[i] = 0
			end
			TriggerEvent('saveBizMission', data2)
		end
		day = arr.day
		SaveDataToFile("database/day.info", {day}, ",")
	end
end)

RegisterServerEvent('saveServerInfo')
AddEventHandler('saveServerInfo', function(data)
	SaveDataToFile("database/main.info", data, ",")
	TriggerClientEvent('updServerInfo', -1, data)
end)

RegisterServerEvent('saveLeaders')
AddEventHandler('saveLeaders', function(data)
	local playername = GetPlayerName(source)
	local arr = os.date("*t")
	SaveDataToFile("database/leader/" .. playername .. ".leaderdate", {arr.day, arr.month, arr.year}, ",")
	SaveDataToFile("database/leader/leaders.info", data, ",")
	TriggerClientEvent('updLeaders', -1, data)
end)

RegisterServerEvent('saveStats')
AddEventHandler('saveStats', function(data)
	local playername = GetPlayerName(source)
	SaveDataToFile("database/stats/" .. playername .. ".stats", data, ",")
end)

RegisterServerEvent('requestItemSending')
AddEventHandler('requestItemSending', function(receiver, sender, item, amount)
	TriggerClientEvent('sendItem', -1, receiver, sender, item, amount)
	print('serverilke vannu')
end)

RegisterServerEvent('saveInv')
AddEventHandler('saveInv', function(data)
	local playername = GetPlayerName(source)
	
	os.remove("database/inv/" .. playername .. ".inv")
	
	local tempstring = ""
	for i=1,#data,1 do
		if(i ~= #data) then
			tempstring = tempstring .. data[i] .. ","
		else
			tempstring = tempstring .. data[i]
		end
	end
	
	local f,err = io.open("database/inv/" .. playername .. ".inv", "w")
    if not f then return print(err) end
    f:write(tempstring)
    f:close()
end)

RegisterServerEvent('giveItemToPlayer')
AddEventHandler('giveItemToPlayer', function(id, sender, item, x, y)
	TriggerClientEvent('giveItemToPlayer', -1, id, sender, item, x, y)
end)
RegisterServerEvent('removeItemFromPlayer')
AddEventHandler('removeItemFromPlayer', function(id, x, y)
	TriggerClientEvent('removeItemFromPlayer', -1, id, x, y)
end)

RegisterServerEvent('saveJobProgress')
AddEventHandler('saveJobProgress', function(data)
	local playername = GetPlayerName(source)
	SaveDataToFile("database/jobprogress/" .. playername .. ".jobprogress", data, ",")
end)

RegisterServerEvent('saveParts')
AddEventHandler('saveParts', function(data)
	local playername = GetPlayerName(source)
	SaveDataToFile("database/parts/" .. playername .. ".parts", data, ",")
end)

RegisterServerEvent('saveAnimalInv')
AddEventHandler('saveAnimalInv', function(data)
	local playername = GetPlayerName(source)
	SaveDataToFile("database/animalinv/" .. playername .. ".animalinv", data, ",")
end)

RegisterServerEvent('saveCars')
AddEventHandler('saveCars', function(data)
	local playername = GetPlayerName(source)
	SaveDataToFile("database/cars/" .. playername .. ".cars", data, ",")
end)

RegisterServerEvent('saveTuning')
AddEventHandler('saveTuning', function(data)
	local playername = GetPlayerName(source)
	for i=1,#data,1 do
		SaveDataToFile("database/tuning/" .. playername .. ".tuning" .. i, data[i], ",")
	end
end)

RegisterServerEvent('saveHouses')
AddEventHandler('saveHouses', function(data)
	SaveDataToFile("database/houses.info", data, ",")
	TriggerClientEvent('updHouses', -1, data)
end)
RegisterServerEvent('saveHouseCash')
AddEventHandler('saveHouseCash', function(data)
	SaveDataToFile("database/housecash.info", data, ",")
	TriggerClientEvent('updHouseCash2', -1, data)
end)
RegisterServerEvent('askToEnter')
AddEventHandler('askToEnter', function(target, requester, hid)
	TriggerClientEvent('askToEnter', -1, target, requester, hid)
end)

RegisterServerEvent('saveBiz')
AddEventHandler('saveBiz', function(data)
	SaveDataToFile("database/biz.info", data, ",")
	TriggerClientEvent('updBiz', -1, data)
end)
RegisterServerEvent('saveBizCash')
AddEventHandler('saveBizCash', function(data)
	SaveDataToFile("database/bizcash.info", data, ",")
	TriggerClientEvent('updBizCash2', -1, data)
end)
RegisterServerEvent('saveBizIncome')
AddEventHandler('saveBizIncome', function(data)
	SaveDataToFile("database/bizincome.info", data, ",")
	TriggerClientEvent('updBizIncome2', -1, data)
end)
RegisterServerEvent('saveBizMission')
AddEventHandler('saveBizMission', function(data)
	SaveDataToFile("database/bizmis.info", data, ",")
	TriggerClientEvent('updBizMission', -1, data)
end)
RegisterServerEvent('saveBizStats')
AddEventHandler('saveBizStats', function(data, names)
	SaveDataToFile("database/bizstats/bizincome.info", data, ",")
	local temptext = {}
	for i=1,#names,1 do
		temptext[i] = "" .. names[i] .. " - " .. data[i]
	end
	SaveDataToFile("database/bizstats/biztable.info", temptext, "\n")
	TriggerClientEvent('updBizStats', -1, data)
end)

RegisterServerEvent('saveFuel')
AddEventHandler('saveFuel', function(data)
	local playername = GetPlayerName(source)
	SaveDataToFile("database/fuel/" .. playername .. ".fuel", data, ",")
end)
--------------------------------------------

RegisterServerEvent('addTaxiOrder')
AddEventHandler('addTaxiOrder', function(id, x, y, z)
	TriggerClientEvent('addTaxiOrder', -1, id, x, y, z)
end)
RegisterServerEvent('removeTaxiOrder')
AddEventHandler('removeTaxiOrder', function(id)
	TriggerClientEvent('removeTaxiOrder', -1, id)
end)

RegisterServerEvent('addMechOrder')
AddEventHandler('addMechOrder', function(id, x, y, z)
	TriggerClientEvent('addMechOrder', -1, id, x, y, z)
end)
RegisterServerEvent('removeMechOrder')
AddEventHandler('removeMechOrder', function(id)
	TriggerClientEvent('removeMechOrder', -1, id)
end)
RegisterServerEvent('sendRepairOffer')
AddEventHandler('sendRepairOffer', function(id, sender, price)
	TriggerClientEvent('sendRepairOffer', -1, id, sender, price)
end)

RegisterServerEvent('freeJail')
AddEventHandler('freeJail', function(id, sender, price)
	TriggerClientEvent('freeJail', -1, id, sender, price)
end)

RegisterServerEvent('addPoliceOrder')
AddEventHandler('addPoliceOrder', function(id, x, y, z)
	TriggerClientEvent('addPoliceOrder', -1, id, x, y, z)
end)
RegisterServerEvent('removePoliceOrder')
AddEventHandler('removePoliceOrder', function(id)
	TriggerClientEvent('removePoliceOrder', -1, id)
end)

RegisterServerEvent('addRobbery')
AddEventHandler('addRobbery', function(shop, x, y, z)
	TriggerClientEvent('addRobbery', -1, shop, x, y, z)
end)
RegisterServerEvent('removeRobbery')
AddEventHandler('removeRobbery', function(shop)
	TriggerClientEvent('removeRobbery', -1, shop)
end)

RegisterServerEvent('performPoliceRequest')
AddEventHandler('performPoliceRequest', function(target, requester, id, args)
	TriggerClientEvent('performPoliceRequest', -1, target, requester, id, args)
end)
RegisterServerEvent('sendMessageToNOOSE')
AddEventHandler('sendMessageToNOOSE', function(message)
	TriggerClientEvent('sendMessageToNOOSE', -1, message)
end)

RegisterServerEvent('addMedicOrder')
AddEventHandler('addMedicOrder', function(id, x, y, z)
	TriggerClientEvent('addMedicOrder', -1, id, x, y, z)
end)
RegisterServerEvent('removeMedicOrder')
AddEventHandler('removeMedicOrder', function(id)
	TriggerClientEvent('removeMedicOrder', -1, id)
end)
RegisterServerEvent('performMedicRequest')
AddEventHandler('performMedicRequest', function(target, requester, id, args)
	TriggerClientEvent('performMedicRequest', -1, target, requester, id, args)
end)

RegisterServerEvent('performGangRequest')
AddEventHandler('performGangRequest', function(target, requester, id, args)
	TriggerClientEvent('performGangRequest', -1, target, requester, id, args)
end)
RegisterServerEvent('saveMats')
AddEventHandler('saveMats', function(data)
	SaveDataToFile("database/mats.info", data, ",")
	TriggerClientEvent('updMats', -1, data)
end)

RegisterServerEvent('performNOOSERequest')
AddEventHandler('performNOOSERequest', function(target, requester, id, args)
	TriggerClientEvent('performNOOSERequest', -1, target, requester, id, args)
end)
RegisterServerEvent('sendMessageToPolice')
AddEventHandler('sendMessageToPolice', function(message)
	TriggerClientEvent('sendMessageToPolice', -1, message)
end)

------------------------------------------

RegisterServerEvent('setPlayerPos')
AddEventHandler('setPlayerPos', function(id, x, y, z, h)
	TriggerClientEvent('setPlayerPos', -1, id, x, y, z, h)
end)
RegisterServerEvent('TriggeredRobbery')
AddEventHandler('TriggeredRobbery', function(state, rob)
	TriggerClientEvent('TriggeredRobbery', -1, state, rob)
end)
RegisterServerEvent('sendMessageToPlayer')
AddEventHandler('sendMessageToPlayer', function(id, message)
	TriggerClientEvent('sendMessageToPlayer', -1, id, message)
end)
RegisterServerEvent('sendMessageToEveryone')
AddEventHandler('sendMessageToEveryone', function(message)
	TriggerClientEvent('sendMessageToEveryone', -1, message)
end)
RegisterServerEvent('sendMessageToEveryonePolice')
AddEventHandler('sendMessageToEveryonePolice', function(message)
	TriggerClientEvent('sendMessageToEveryonePolice', -1, message)
end)
RegisterServerEvent('stunPlayer')
AddEventHandler('stunPlayer', function(id)
	TriggerClientEvent('stunPlayer', -1, id)
end)

RegisterServerEvent('sendMoneyToPlayer')
AddEventHandler('sendMoneyToPlayer', function(id, sender, amount)
	TriggerClientEvent('sendMoneyToPlayer', -1, id, sender, amount)
end)
RegisterServerEvent('sendMoneyToPlayer2')
AddEventHandler('sendMoneyToPlayer2', function(id, sender, amount)
	TriggerClientEvent('sendMoneyToPlayer2', -1, id, sender, amount)
end)
RegisterServerEvent('addMoneyToPlayer')
AddEventHandler('addMoneyToPlayer', function(id, amount)
	TriggerClientEvent('addMoneyToPlayer', -1, id, amount)
end)

RegisterServerEvent('requestPaymentForFlight')
AddEventHandler('requestPaymentForFlight', function(id, requester)
	TriggerClientEvent('requestPaymentForFlight', -1, id, requester)
end)
RegisterServerEvent('sendPaymentForFlight')
AddEventHandler('sendPaymentForFlight', function(id, requester)
	TriggerClientEvent('sendPaymentForFlight', -1, id, requester)
end)

RegisterServerEvent('updatePauseStatus')
AddEventHandler('updatePauseStatus', function(id, status)
	TriggerClientEvent('updatePauseStatus', -1, id, status)
end)
RegisterServerEvent('updateTalkStatus')
AddEventHandler('updateTalkStatus', function(id, status)
	TriggerClientEvent('updateTalkStatus', -1, id, status)
end)
RegisterServerEvent('updateTypeStatus')
AddEventHandler('updateTypeStatus', function(id, status)
	TriggerClientEvent('updateTypeStatus', -1, id, status)
end)

RegisterServerEvent('requestNeon')
AddEventHandler('requestNeon', function(target)
	TriggerClientEvent('requestNeon', -1, target)
end)
RegisterServerEvent('sendNeon')
AddEventHandler('sendNeon', function(target, r, g, b)
	TriggerClientEvent('sendNeon', -1, target, r, g, b)
end)

RegisterServerEvent('ping')
AddEventHandler('ping', function()
	TriggerClientEvent('ping', source, GetPlayerPing(source))
end)

RegisterServerEvent('restartScript')
AddEventHandler('restartScript', function(script)
	TriggerClientEvent('restartScript', source, script)
end)

RegisterServerEvent('saveOutfits')
AddEventHandler('saveOutfits', function(data)
	local playername = GetPlayerName(source)
	
	os.remove("database/outfits/" .. playername .. ".outfits")
	
	local tempstring = ""
	for i=1,#data,1 do
		for j=1,#data[i],1 do
			if(j ~= #data[i]) then
				tempstring = tempstring .. data[i][j] .. ","
			else
				if(i ~= #data) then
					tempstring = tempstring .. data[i][j] .. "|"
				else
					tempstring = tempstring .. data[i][j]
				end
			end
		end
	end
	
	local f,err = io.open("database/outfits/" .. playername .. ".outfits", "w")
    if not f then return print(err) end
    f:write(tempstring)
    f:close()
end)

RegisterServerEvent('startRace')
AddEventHandler('startRace', function(rid, id)
	TriggerClientEvent('startRace', -1, rid, id)
end)
RegisterServerEvent('finishRace')
AddEventHandler('finishRace', function(rid, winner)
	TriggerClientEvent('finishRace', -1, rid, winner)
end)
RegisterServerEvent('sendReward')
AddEventHandler('sendReward', function(id, amount, sender)
	TriggerClientEvent('sendReward', -1, id, amount, sender)
end)

RegisterServerEvent('addHookerOrder')
AddEventHandler('addHookerOrder', function(id, x, y, z)
	TriggerClientEvent('addHookerOrder', -1, id, x, y, z)
end)
RegisterServerEvent('removeHookerOrder')
AddEventHandler('removeHookerOrder', function(id)
	TriggerClientEvent('removeHookerOrder', -1, id)
end)
RegisterServerEvent('sendStuffOffer')
AddEventHandler('sendStuffOffer', function(id, sender, type, price)
	TriggerClientEvent('sendStuffOffer', -1, id, sender, type, price)
end)
RegisterServerEvent('acceptStuffOffer')
AddEventHandler('acceptStuffOffer', function(id, sender, type, price)
	TriggerClientEvent('acceptStuffOffer', -1, id, sender, type, price)
end)
RegisterServerEvent('acceptStuffOffer2')
AddEventHandler('acceptStuffOffer2', function(id)
	TriggerClientEvent('acceptStuffOffer2', -1, id)
end)

RegisterServerEvent('playerActivated')
AddEventHandler('playerActivated', function()
	local playername = GetPlayerName(source)
	local file = io.open("database/whitelists/" .. playername .. ".txt", "r")
	if file then
	else
		DropPlayer(source, "You are not whitelisted, take whitelist from our discord.")
	end
	io.close(file)	
end)