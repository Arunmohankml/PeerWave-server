------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------MAIN---------------------------------------------------------------------------------

money = 0
bankmoney = 1000
job = "0"
rank = 1
leader = 0
wanted = 0
jailtime = 0
drugs = 0
level = 0
exp = 0
addict = 0
driverlicense = 0
weaponlicense = 0
huntlicense = 0
hunger = 100
thirst = 100
timer = 0
pilotlicense = 0
boatlicense = 0
gender = 0
streamermode = 0
demorgan = 0
VoiceKey = 56
trainlicense = 0
jobexp = 0

--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------CHAT AND CHATBOX---------------------------------------------------------------------------------
Draw3dChat = function(x, y, z, text, radius)
	if(IsPlayerNearCoords(x, y, z, 50)) then
		local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
		local dist = GetDistanceBetweenCoords3d(x, y, z, px, py, pz)
		local model = GetHashKey("cj_can_drink_1")
		if(not DoesObjectExist(tempobj)) then
			RequestModel(model)
			while not HasModelLoaded(model) do
				Wait(0)
			end
			tempobj = CreateObject(model, x, y, z, 1)
			SetObjectVisible(tempobj, false)
		end
		if(dist < radius) then
			SetObjectCoordinates(tempobj, x, y, z)
			if(IsObjectOnScreen(tempobj)) then
				local bv,cx,cy = GetViewportPositionOfCoord(x, y, z, GetGameViewportId())
				local sx,sy = GetScreenResolution()
				if(cx>0 and cx<sx) then
					cx = cx/sx
				else
					cx = 0
				end
				if(cy>0 and cy<sy) then
					cy = cy/sy
				else
					cy = 0
				end
				if(cx>0 and cy>0) then
					local mult = radius - dist
					SetTextScale(0.3500000/radius*mult, 0.4000000/radius*mult)
					SetTextDropshadow(0, 0, 0, 0, 0)
					SetTextEdge(1, 0, 0, 0, 255)
					SetTextFont(6)
					SetTextCentre(1)
					DisplayTextWithLiteralString(cx, cy, "STRING", "" .. text)
				end
			end
		end
	end
end
RegisterNetEvent('SendMessage')
AddEventHandler('SendMessage', function(m1, m2, msgid)
	h,m = GetTimeOfDay()
	if(msgid == 1) then
		TriggerEvent('chat:addMessage', {
			template = '<div class="chat-message twitter"><i class="fab fa-twitter"></i> <b><span style="color: #2aa9e0">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
			args = { m1, m2, h }
		})
	elseif(msgid == 2) then
		TriggerEvent('chat:addMessage', {
			template = '<div class="chat-message ambulance"><i class="fas fa-ambulance"></i> <b><span style="color: #e3a71b">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
			args = { m1, m2, h }
		})
	elseif(msgid == 3) then
		TriggerEvent('chat:addMessage', {
			template = '<div class="chat-message police"><i class="fas fa-bullhorn"></i> <b><span style="color: #4a6cfd">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
			args = { m1, m2, h }
		})
	elseif(msgid == 4) then
		TriggerEvent('chat:addMessage', {
			template = '<div class="chat-message advertisement"><i class="fas fa-ad"></i> <b><span style="color: #81db44">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
			args = { m1, m2, h }
		})
	elseif(msgid == 5) then
		TriggerEvent('chat:addMessage', {
			template = '<div class="chat-message staff"><i class="fas fa-shield-alt"></i> <b><span style="color: #1ebc62">[STAFF] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
			args = { m1, m2, h }
		})
	elseif(msgid == 6) then
		TriggerEvent('chat:addMessage', {
			template = '<div class="chat-message ooc"><i class="fas fa-door-open"></i> <b><span style="color: #7d7d7d">[OOC] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
			args = { m1, m2, h }
		})
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(admin == 0) then
			for i=0,31,1 do
				if(IsNetworkPlayerActive(i)) then
					if(ConvertIntToPlayerindex(i) ~= ConvertIntToPlayerindex(GetPlayerId())) then
						SetDisplayPlayerNameAndIcon(i, false)
					end
				end
			end
		end
    end
end)

RegisterNetEvent('ChatResult')
AddEventHandler('ChatResult', function(msg)
	local playerid = GetPlayerId()
	local x,y,z = GetCharCoordinates(GetPlayerChar(-1))
	TriggerServerEvent('SendChatMessage', playerid, x, y, z, msg)
end)


local cplayerid = -1
local cansee = false
local chattext = ""
RegisterNetEvent('SendChatMessage')
AddEventHandler('SendChatMessage', function(playerid, x, y, z, text)
	if(IsPlayerNearCoords(x, y, z, 15)) then
		cplayerid = playerid
		cansee = true
		chattext = text
	end
end)


---dad
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(cansee == true) then
			local dx,dy,dz = GetCharCoordinates(GetPlayerChar(cplayerid))
			Draw3dChat(dx,dy,dz+1, chattext, 20)
		end
	end
end)

--[[
Camactive2 = 0
local c1 = nil
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if(IsGameKeyboardKeyJustPressed(18)) then
			Camactive2 = 1
		end
		if(Camactive2 == 1) then
			local p1,p2,p3 = GetCharCoordinates(GetPlayerChar(-1))
			if(not DoesCamExist(c1)) then
				c1 = CreateCam(14)
				
			end
			if(DoesCamExist(c1)) then
				SetCamPropagate(c1, 1)
				SetCamPos(c1, p1, p2, p3+20)
				SetCamActive(c1, true)
				ActivateScriptedCams(1, 1)
				PointCamAtCoord(c1, p1, p2, p3)
			end
		end
	end
end)]]
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(cansee == true) then
			Citizen.Wait(10000)
			cplayerid = -1
			cansee = false
			chattext = ""
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------DATABASE THINGS------------------------------------------------------------------------------------------

RegisterNetEvent('updStats')
AddEventHandler('updStats', function(data)
	for i=1,100,1 do
		if(data[i] == nil) then
			if(i == 2) then
				data[i] = "0"
			elseif(i == 3) then
				data[i] = 1
			elseif(i == 14) then
				data[i] = 100
			else
				data[i] = 0
			end
		end
	end
	bankmoney = tonumber(data[1])
	job = tostring(data[2])
	rank = tonumber(data[3])
	--leader = tonumber(data[4])
	wanted = tonumber(data[5])
	jailtime = tonumber(data[6])
	drugs = tonumber(data[7])
	level = tonumber(data[8])
	exp = tonumber(data[9])
	addict = tonumber(data[10])
	driverlicense = tonumber(data[11])
	weaponlicense = tonumber(data[12])
	huntlicense = tonumber(data[13])
	thirst = tonumber(data[14])
	hunger = tonumber(data[15])
	timer = tonumber(data[16])
	pilotlicense = tonumber(data[17])
	boatlicense = tonumber(data[18])
	gender = tonumber(data[19])
	streamermode = tonumber(data[20])
	demorgan = tonumber(data[21])
	VoiceKey = tonumber(data[22])
	trainlicense = tonumber(data[23])
	jobexp = tonumber(data[24])
end)
local savechanged = 0
SaveStats = function()
	if(IsScreenFadedIn()) then
		savechanged = 1
		local data = {}
		data[1] = bankmoney
		data[2] = job
		data[3] = rank
		data[4] = leader
		data[5] = wanted
		data[6] = jailtime
		data[7] = drugs
		data[8] = level
		data[9] = exp
		data[10] = addict
		data[11] = driverlicense
		data[12] = weaponlicense
		data[13] = huntlicense
		data[14] = hunger
		data[15] = thirst
		data[16] = timer
		data[17] = pilotlicense
		data[18] = boatlicense
		data[19] = gender
		data[20] = streamermode
		data[21] = demorgan
		data[22] = VoiceKey
		data[23] = trainlicense
		data[24] = jobexp
		
		TriggerServerEvent('saveStats', data)
	end
end
CreateThread(function()
	while true do
		Wait(0)
		if(loginform == 0) then
			local tk = GenerateRandomIntInRange(1000, 10000)
			local te = exp + tk
			local tl = level + tk
			Wait(1000)
			if(savechanged == 0) then
				exp = te - tk
				level = tl - tk
			else
				savechanged = 0
			end
		end
	end
end)


function GetMcd()
	return MerryCooldown
end
function GetAcd()
	return AtmCooldown
end


RobCooldown = 0
MerryCooldown = 0
BankCooldown = 0
CarRobbery = 0
BrugerStock = 0
MilkStock = 0
BurgerShot = 0
AtmCooldown = 0
SaveServerInfo = function()
	local data = {}
	data[1] = RobCooldown
	data[2] = MerryCooldown
	data[3] = BankCooldown
	data[4] = CarRobbery
	data[5] = BrugerStock
	data[6] = MilkStock
	data[7] = BurgerShot
	data[8] = AtmCooldown 
	TriggerServerEvent('saveServerInfo', data)
end

RegisterNetEvent('StartCoolDown')
AddEventHandler('StartCoolDown', function(rob)
	if rob == 1 then
		MerryCooldown = 1200
		SaveServerInfo()
	elseif rob == 2 then
		AtmCooldown = 1800
		SaveServerInfo()
	end
end)

RegisterNetEvent('updServerInfo')
AddEventHandler('updServerInfo', function(data)
	for i=1,20,1 do
		if(data[i] == nil) then
			data[i] = 0
		end
	end
	RobCooldown = tonumber(data[1])
	MerryCooldown = tonumber(data[2])
	BankCooldown = tonumber(data[3])
	CarRobbery = tonumber(data[4])
	BrugerStock = tonumber(data[5])
	MilkStock = tonumber(data[6])
	BurgerShot = tonumber(data[7])
	AtmCooldown = tonumber(data[8])
end)

TriggeredMerry = false
TriggeredBank = false
TriggeredAtm = false
TriggeredShop = false
RegisterNetEvent('TriggeredRobbery')
AddEventHandler('TriggeredRobbery', function(state, rob)
    if rob == "merry" then
        TriggeredMerry = state
    elseif rob == "bank" then
        TriggeredBank = state
    elseif rob == "atm" then
        TriggeredAtm = state
    elseif rob == "shop" then
        TriggeredShop = state
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------EXPORTS AND EVENTS-----------------------------------------------------------------------------------


GetThirst = function()
	return thirst
end
GetHunger = function()
	return hunger
end
StreamerMode = function()
	return streamermode
end

GetPlayerLevel = function()
	return level
end
GetPlayerJob2 = function()
	return job
end
speedometerHUD = 2
function GetSpeedo()
	return speedometerHUD
end

function HandMoney()
	return inventory[34]
end



function BankMoney()
	return bankmoney
end

function GetJobKey()
	return JobKey
end

function GetFuel()
	if(GetCarCharIsUsing(GetPlayerChar(-1)) ~= car) then
		return carsfuel[GetCarCharIsUsing(GetPlayerChar(-1))]
	else
		local tempcar = 0
		for j=1,#carinfo,1 do
			if(IsCarModel(car, carinfo[j][3])) then
				tempcar = j
			end
		end
		return fuel[tempcar]
	end
end

RegisterNetEvent("AddMoney")
AddEventHandler("AddMoney", function(amount)
	inventory[34] = inventory[34] + amount
	SaveInventory()
end)
RegisterNetEvent("RemoveMoney")
AddEventHandler("RemoveMoney", function(amount)
	inventory[34] = inventory[34] - amount
	SaveInventory()
end)
RegisterNetEvent("withdrawm")
AddEventHandler("withdrawm", function(amount)
	if(bankmoney >= tonumber(amount)) then
		inventory[34] = inventory[34] + tonumber(amount)
		SaveInventory()

		bankmoney = bankmoney - tonumber(amount)
		SaveStats()
		TriggerEvent("noticeme:Info", "You have withdrawed " .. tonumber(amount) .. ".Rs from your bank")
	else
		TriggerEvent("noticeme:Info", "You dont have enough money in your bank")
	end
end)

RegisterNetEvent("depositm")
AddEventHandler("depositm", function(amount)
	if(inventory[34] >= amount) then
		bankmoney = bankmoney + amount
		SaveStats()
		inventory[34] = inventory[34] - amount
		SaveInventory()
		TriggerEvent("noticeme:Info", "You have Deposited " .. amount .. ".Rs to your bank")
	else
		TriggerEvent("noticeme:Info", "You dont have enough money")
	end
end)

GetPlayerServerIdFromName = function(name)
	for i=0,31,1 do
		if(IsNetworkPlayerActive(i)) then
			if(GetPlayerName(i, _s) == name) then
				return i
			end
		end
	end
end

------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------GANG AND FACTIOPN-----------------------------------------------------------------------------------------


currleader = {
["Police"] = "None",
["Medic"] = "None",
["Spanish Lords"] = "None",
["Yardies"] = "None",
["Hustlers"] = "None",
["NOOSE"] = "None"
}
RegisterNetEvent('updLeaders')
AddEventHandler('updLeaders', function(data)
	currleader["Police"] = data[1] or "None"
	currleader["Medic"] = data[2] or "None"
	currleader["Spanish Lords"] = data[3] or "None"
	currleader["Yardies"] = data[4] or "None"
	currleader["Hustlers"] = data[5] or "None"
	currleader["NOOSE"] = data[6] or "None"
	for i in pairs(currleader) do
		if(currleader[i] == GetPlayerName(GetPlayerId())) then
			leader = 1
		end
	end
end)
SaveLeaders = function()
	local data = {}
	data[1] = currleader["Police"]
	data[2] = currleader["Medic"]
	data[3] = currleader["Spanish Lords"]
	data[4] = currleader["Yardies"]
	data[5] = currleader["Hustlers"]
	data[6] = currleader["NOOSE"]
	TriggerServerEvent('saveLeaders', data)
end

------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------SOME DB THINGS----------------------------------------------------------------------------------

jobprogress = {
loader = 0,
builder = 0,
trucker = 0,
fisher = 0,
}
RegisterNetEvent('updJobProgress')
AddEventHandler('updJobProgress', function(data)
	jobprogress.loader = tonumber(data[1]) or 0
	jobprogress.builder = tonumber(data[2]) or 0
	jobprogress.trucker = tonumber(data[3]) or 0
	jobprogress.fisher = tonumber(data[4]) or 0
end)

SaveJobProgress = function()
	if(IsScreenFadedIn()) then
		local data = {}
		data[1] = jobprogress.loader
		data[2] = jobprogress.builder
		data[3] = jobprogress.trucker
		data[4] = jobprogress.fisher
		
		TriggerServerEvent('saveJobProgress', data)
	end
end


hp,ap = 200,0
RegisterNetEvent('updHealth')
AddEventHandler('updHealth', function(data)
	if not data then
		data = {200,0}
	end
	hp = tonumber(data[1])
	if not hp then
		hp = 200
	elseif(hp <= 100) then
		hp = 200
	end
	ap = tonumber(data[2])
	if not ap then
		ap = 0
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------SOME FUNCS AND EVENTS--------------------------------------------------------------------------------------


RegisterNetEvent('sendMoney')
AddEventHandler('sendMoney', function(receiver, sender, amount)
	if(GetPlayerChar(-1) == GetPlayerChar(receiver)) then
		TriggerEvent('chatMessage', '[Money]', {0, 255, 0}, 'You have recived ' .. amount .. '.Rs from ' .. GetPlayerName(sender, _s) .. '.')
		inventory[34] = inventory[34] + amount
		SaveInventory()
		Print(' recived' .. amount .. '.Rs from'  .. GetPlayerName(sender))
	end
end)

Print = function(text)
	TriggerServerEvent('Print', GetPlayerName(GetPlayerId()), text)
end

AddExp = function(amount)
	exp = exp + amount
	jobexp = jobexp + 1
	if(exp >= 4*(level+1)) then
		level = level + 1
		exp = 0
		Notify("Level " .. level .. " has been reached!")
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(RobCooldown > 0) then
			RobCooldown = RobCooldown - 1
			SaveServerInfo()
			Citizen.Wait(1000)
		end
		if(AtmCooldown > 0) then
			AtmCooldown = AtmCooldown - 1
			SaveServerInfo()
			Citizen.Wait(1000)
		end
		if(MerryCooldown > 0) then
			MerryCooldown = MerryCooldown - 1
			SaveServerInfo()
			Citizen.Wait(1000)
		end
		if(BankCooldown > 0) then
			BankCooldown = BBankCooldown - 1
			SaveServerInfo()
			Citizen.Wait(1000)
		end
		if(CarRobbery > 0) then
			CarRobbery = CarRobbery - 1
			SaveServerInfo()
			Citizen.Wait(1000)
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------PAYCHECK---------------------------------------------------------------------------

RegisterNetEvent('payday')
AddEventHandler('payday', function()
	if(wanted > 0) then
		wanted = wanted - 1
	end
	exp = exp + 1
	jobexp = jobexp + 1
	if(exp >= 4*(level+1)) then
		level = level + 1
		exp = 0
		Notify("Level " .. level .. " has been reached!")
	end
	if(addict > 0) then
		addict = addict - 1
		Notify("-1 drug addiction")
	end
	if(job == "Police") then
		AddItem(34, 1700*rank)
							--money = money + 1000*rank
		Notify("Salary " .. 1700*rank .. "$.")
	elseif(job == "Medic") then
		AddItem(34, 1500*rank)
							--money = money + 800*rank
		Notify("Salary " .. 1500*rank .. "$.")
	elseif(job=="Spanish Lords" or job=="Yardies" or job=="Hustlers") then
		local amount = 0
		for i=1,#areaowners,1 do
			if(areaowners[i] == job) then
				amount = amount + 1
			end
		end
		AddItem(34, 500*amount)
							--money = money + 500*amount
		Notify("Your gang controls " .. amount .. " territories. You have got " .. 500*amount .. "$.")
	elseif(job == "NOOSE") then
		AddItem(34, 1200*rank)
							--money = money + 1200*rank
		Notify("Salary " .. 1200*rank .. "$.")
	end
	SaveStats()
	for i=1,#houseinfo,1 do
		if(houses[i] == GetPlayerName(GetPlayerId())) then
			if(housecash[i] > 0) then
				Notify("House #" .. i .. " service payment: " .. math.floor(houseinfo[i][1]/100*housecash[i]) .. "$.")
			end
		end
	end
	for i=1,#bizinfo,1 do
		if(biz[i] == GetPlayerName(GetPlayerId())) then
			if(bizcash[i] > 0) then
				Notify("" .. bizinfo[i][3] .. " business service payment: " .. bizinfo[i][1]/100*bizcash[i] .. "$.")
			end
			if(bizmis[i] > 0) then
				bizincome[i] = bizincome[i] + math.floor(bizinfo[i][1]/20)
				SaveBizIncome()
				Notify("" .. bizinfo[i][3] .. " business income has been increased to " .. bizincome[i] .. "$. You can collect it at the business or at the nearest ATM.")
			else
				Notify("" .. bizinfo[i][3] .. " business has received no income due to lack of supplies. Please visit this business and complete a supply mission.")
			end
		end
	end
end)


------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------HUDS AND SETINGS-----------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------PED/TRAFFIC MANAGE--------------------------------------------------------------------------------------
RegisterNetEvent('StartEngine')
AddEventHandler('StartEngine', function()
	engine = true
end)

local hold = 0
local deathtimer = 900
respawnTimer = 30
local sent = 0
coponline, emsonline = 0, 0
local handsup = false
local plock = 0
local engine = true
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(IsCharInAnyCar(GetPlayerChar(-1))) then
			local ped = GetPlayerChar(-1)
			local usingcar = GetCarCharIsUsing(ped)
			local speed = GetCarSpeed(GetCarCharIsUsing(GetPlayerChar(-1)))
			local ppx,ppy, ppz = GetCharCoordinates(GetPlayerChar(-1))

			if(DoesVehicleExist(usingcar)) then
				if(GetDriverOfCar(usingcar) == GetPlayerChar(-1)) then
					if(engine == true) then
						SetCarEngineOn(usingcar, 1, 1)
					else
						SetCarEngineOn(usingcar, 0, 0)
					end
					local petrol = GetPetrolTankHealth(usingcar)
					if(petrol <= 999) then
						SetPetrolTankHealth(usingcar, 1000)
						SetCarHealth(usingcar, 0)
						SetEngineHealth(usingcar, 0)
						engine = false
					end
				end
				if(GetDriverOfCar(usingcar) == GetPlayerChar(-1)) then
					if(IsPlayerControlOn(GetPlayerId())) then
						if (IsGameKeyboardKeyPressed(57) or IsGameKeyboardKeyPressed(31)) then --s
							local gear = GetVehicleGear(GetCarCharIsUsing(GetPlayerChar(-1)))
							if(type(gear) == "number") then
								if(gear == 0) then
									revs = true
								else
									revs = false
								end
							elseif(type(gear) == "boolean") then
								if(gear == true) then
									revs = false
								else
									revs = true
								end
							end
							if(revs == false) then
								if(GetCarSpeed(usingcar) > 0) then
									if(IsVehicleOnAllWheels(usingcar)) then
										local tempspeed = GetCarSpeed(usingcar, _f)
										ApplyForceToCar(usingcar ,1,0,-0.2,0,0,0,0,1,1,1,1)
									end
								end
							end
						end
					end
				end
			end
		end

		

		if(loginform == 0) then
			AllowLockonToFriendlyPlayers(ConvertIntToPlayerindex(GetPlayerId()), true)
			SetCharDropsWeaponsWhenDead(GetPlayerChar(-1), true)
			AllowNetworkPopulationGroupCycling(true)
			SetDeadPedsDropWeapons(false)
			if(not IsGameKeyboardKeyPressed(42)) then
				SetNetworkWalkModeEnabled(false)
			else
				SetNetworkWalkModeEnabled(true)
			end
			SetNoResprays(1)
		end

		AlterWantedLevel(GetPlayerId(), 0)
		AlterWantedLevelNoDrop(GetPlayerId(), 0)
		---- NPCS -----------
		SetCarDensityMultiplier(0.0)
		SetPedDensityMultiplier(0.0)
		SetRandomCarDensityMultiplier(0.0)
		SetParkedCarDensityMultiplier(0.0)
		SetScenarioPedDensityMultiplier(0.0, 0.0)
		
		pos = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
		RemoveCarsFromGeneratorsInArea(pos[1] - 500.0, pos[2] - 500.0, pos[3] - 500.0, pos[1] + 500.0, pos[2] + 500.0, pos[3] + 500.0);
		
		
		-- These natives do not have to be called everyframe.
		SwitchGarbageTrucks(0)
		SwitchRandomBoats(0)



		if(speedometerHUD == 1) then
			RequestStreamedTxd("speedometer")
			while not HasStreamedTxdLoaded("speedometer") do
				Citizen.Wait(0)
			end
			local speedometer = GetTextureFromStreamedTxd("speedometer", "speedometer")
			local arrow = GetTextureFromStreamedTxd("speedometer", "arrow")
			local indicator = GetTextureFromStreamedTxd("speedometer", "indicator")
			if(IsCharInAnyCar(GetPlayerChar(-1))) then
				local speedinmeters = GetCarSpeed(GetCarCharIsUsing(GetPlayerChar(-1)))
				SetTextScale(0.500000,  0.7000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextFont(6)
				SetTextColour(255, 255, 255, 255)
				SetTextCentre(1)
				SetTextWrap(0.0, 0.8)
				DisplayTextWithLiteralString(0.5, 0.96, "STRING", "       " ..math.ceil(speedinmeters * 3.6).. "")
				if(GetDriverOfCar(GetCarCharIsUsing(GetPlayerChar(-1))) == GetPlayerChar(-1)) then
					DrawSprite(speedometer, 0.5, 0.91, 0.09, 0.18, 0.0, 255, 255, 255, 255)
					local speedinmeters = GetCharSpeed(GetPlayerChar(-1))
					local speed = math.floor(speedinmeters*3600/1000)
					DrawSpriteWithFixedRotation(arrow, 0.5, 0.95, 0.13, 0.26, -10.1+((190.0/320)*speed), 255, 255, 255, 255)
					local gear = GetVehicleGear(GetCarCharIsUsing(GetPlayerChar(-1)))
					if(type(gear) == "number") then
						SetTextScale(0.200000,  0.4000000)
						SetTextDropshadow(0, 0, 0, 0, 0)
						SetTextFont(6)
						SetTextColour(255, 255, 255, 255)
						SetTextCentre(1)
						SetTextWrap(0.0, 0.8)
						DisplayTextWithLiteralString(0.5, 0.9, "STRING", "" .. gear)
					elseif(type(gear) == "boolean") then
						if(gear == true) then
							SetTextScale(0.200000,  0.4000000)
							SetTextDropshadow(0, 0, 0, 0, 0)
							SetTextFont(6)
							SetTextColour(255, 255, 255, 255)
							SetTextCentre(1)
							SetTextWrap(0.0, 0.8)
							DisplayTextWithLiteralString(0.5, 0.9, "STRING", "N")
						else
							SetTextScale(0.200000,  0.4000000)
							SetTextDropshadow(0, 0, 0, 0, 0)
							SetTextFont(6)
							SetTextColour(255, 255, 255, 255)
							SetTextCentre(1)
							SetTextWrap(0.0, 0.8)
							DisplayTextWithLiteralString(0.5, 0.9, "STRING", "R")
						end
					end
					revs = GetVehicleEngineRevs(GetCarCharIsUsing(GetPlayerChar(-1)))
					if(type(revs) == "number") then
						revs = Floor((revs - 1045220557)/10000)--+5000
					else
						revs = 0
					end
				end
			end
		end



		local ped = GetPlayerChar(-1)
        local px, py, pz = GetCharCoordinates(ped)
        local closestcar = GetClosestCar(px, py, pz, 10.0, false, 70)
		if(IsCop(-1)) then
			if(DoesVehicleExist(closestcar)) then
				if(IsGameKeyboardKeyJustPressed(22)) then ---- U
					if(IsCarModel(closestcar, GetHashKey("POLICE")) or IsCarModel(closestcar, GetHashKey("POLICE2")) or IsCarModel(closestcar, GetHashKey("POLPATRIOT"))) then
						if(DoesVehicleExist(closestcar)) then
							if(plock == 0) then
								plock = 1
								TriggerEvent("noticeme:Info", "Locked")
								LockCarDoors(closestcar, 3)
								Print(' locked their car ')
							else
								plock = 0
								TriggerEvent("noticeme:Info", "Unlocked")
								LockCarDoors(closestcar, 0)
								Print(' unlocked their car ')
							end
						end
					end
				end
			end
		end


		local ped = GetPlayerChar(-1)
        local px, py, pz = GetCharCoordinates(ped)
        local closestcar = GetClosestCar(px, py, pz, 10.0, false, 70)
		if(IsGameKeyboardKeyJustPressed(22)) then ---- U
			if(closestcar == car) then
				if(DoesVehicleExist(closestcar)) then
					if(lock == 0) then
						lock = 1
						TriggerEvent("noticeme:Info", "Locked")
						LockCarDoors(closestcar, 3)
						Print(' locked their car ')
					else
						lock = 0
						TriggerEvent("noticeme:Info", "Unlocked")
						LockCarDoors(closestcar, 0)
						Print(' unlocked their car ')
					end
				end
            end
        end

        if not cuff and not IsCharInAnyCar(GetPlayerChar(-1)) and not IsPlayerDead(GetPlayerId()) then
            if IsGameKeyboardKeyJustPressed(HandsUpKey) then
				local x,y,z = GetCharCoordinates(GetPlayerChar(-1))
				local zz = GetGroundZFor3dCoord(x,y,z)
				if(z <= zz+2) then
					ToggleHandsUpAnimation()
				end
            end
        end




		local numCops, numEMS = 0, 0
        for i = 0, 31 do
            if IsNetworkPlayerActive(i) then
                if IsCop(i) then
                    numCops = numCops + 1
				end
				if (IsEms(i)) then
                    numEMS = numEMS + 1
                end
            end
        end
        coponline, emsonline = numCops, numEMS

		

		if(cantmove == 1) then
			SetPlayerControl(GetPlayerId(), false)
		end
		--if(not IsPlayerInSafezone(-608.92096, -861.88177, 4.84285, 100.0)) then
			if(IsPlayerDead(GetPlayerId())) then
				local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
				
				if(IsGameKeyboardKeyJustPressed(34)) then --g
					if(sent == 0) then
						TriggerServerEvent('addMedicOrder', ConvertIntToPlayerindex(GetPlayerId()), px, py, pz)
						sent = 1
					end
					ResurrectNetworkPlayer(GetPlayerId(), px, py, pz, 90.0)
					SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1))- 200)
					SetCharCoordinates(GetPlayerChar(-1), px, py, pz-1.2)
				end
			else
				sent = 0
			end
		--end



		if(IsPlayerDead(GetPlayerId())) then
			if(respawnTimer <= 0) then
				if(hold == 80) then
					respawnPlayer()
					hold = 0
				end
				if(IsGameKeyboardKeyPressed(18)) then
					hold = hold + 1
				end
			end
		end



		if(loginform == 0) then
			--if(not IsPlayerInSafezone(-608.92096, -861.88177, 4.84285, 100.0)) then
				if(IsPlayerDead(GetPlayerId())) then
					if(respawnTimer <= 0) then
						SetTextFont(6)
						SetTextScale(0.15, 0.35)
						SetTextColour(255, 255, 255, 255)
						SetTextDropshadow(0, 0, 0, 0, 255)
						SetTextEdge(1, 0, 0, 0, 255)
						SetTextCentre(1)
						SetTextWrap(0.0, 0.5)
						ClearTimecycleModifier()
						DisplayTextWithLiteralString(0.5, 0.8, "STRING", "You_are_dead_you_will_be_bleeded_out_in_~b~"..deathtimer.."_Seconds ~w~Hold_[E]_to_respawn or_wait_for_ems")
					end
				end
			--end
		end


		
				
		if(IsPlayerDead(GetPlayerId())) then
			if(deathtimer <= 0) then
				respawnPlayer()
				ResetTimer()
			end
		end

		if(IsPlayerDead(GetPlayerId())) then
			if(respawnTimer > 0) then
				SetTextFont(6)
				SetTextScale(0.15, 0.35)
				SetTextColour(255, 255, 255, 255)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextCentre(1)
				DisplayTextWithLiteralString(0.5, 0.8, "STRING", "Respawn_Available_in_~b~"..respawnTimer.."_Seconds")
			end
		end


		

	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if(hunger < 10 or thirst < 10) then
			SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1))-2.0)
			Citizen.Wait(5000)
		end
	end
end)
RegisterNetEvent('ChangeSpeedoMeter')
AddEventHandler('ChangeSpeedoMeter', function()
	if(speedometerHUD == 2) then
		speedometerHUD = 1
	else
		speedometerHUD = 2
	end
end)


IsCop = function(id)					
	if(IsCharModel(GetPlayerChar(id), GetHashKey("M_Y_COP"))) then
		return true
	else
		return false
	end
end
IsEms = function(id)
	if(IsCharModel(GetPlayerChar(id), GetHashKey("M_Y_PMEDIC")) 
	or IsCharModel(GetPlayerChar(id), GetHashKey("f_y_doctor_01")) 
	or IsCharModel(GetPlayerChar(id), GetHashKey("m_m_doctor_01")) 
	or IsCharModel(GetPlayerChar(id), GetHashKey("m_m_doc_scrubs_01"))) then
		return true
	else
		return false
	end
end


function ToggleHandsUpAnimation()
    if not handsup then
        PlayAnim("cop", "armsup_loop", 4, true)
		handsup = true
    else
        ClearCharTasksImmediately(GetPlayerChar(-1))
		handsup = false
    end
end

CreateThread(function()
	while true do
		Wait(60000)
		if(IsNetworkPlayerActive(GetPlayerId())) then
			if(loginform == 0) then
				timer = timer + 1
				if(timer >= 60) then
					TriggerEvent('payday')
					timer = 0
				end
				if not injured then
					if(hunger > 0) then
						if(hunger >= 50) then
							if(GetCharHealth(GetPlayerChar(-1)) < 200) then
								SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1))+10)
							end
						end
						hunger = hunger - 1
					end
					if(thirst > 0) then
						if(thirst >= 50) then
							if(GetCharHealth(GetPlayerChar(-1)) < 200) then
								SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1))+5)
							end
						end
						thirst = thirst - 0.5
					end
				end
				SaveStats()
				TriggerServerEvent('dailyStuff')
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(10000)
		local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
		TriggerServerEvent('saveHealth', GetCharHealth(GetPlayerChar(-1)), GetCharArmour(GetPlayerChar(-1)))
		TriggerServerEvent('saveLastPos', px, py, pz)
	end
end)


currjob = ""
local moneychange = 0
local changetimer = 0
CreateThread(function()
	while true do
		Wait(0)
		if(changetimer > 0) then
			Wait(1000)
			changetimer = changetimer - 1
			if(changetimer == 0) then
				moneychange = 0
			end
		end
	end
end)
CreateThread(function()
	while true do
		Wait(0)
		if(loginform == 0) then
			local oldmoney = money
			Wait(100)
			if(oldmoney ~= money) then
				moneychange = money - oldmoney
				changetimer = 5
			end
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------ANIMATIONS----------------------------------------------------------------------------------------
RegisterNetEvent('OpenAnimationMenu')
AddEventHandler('OpenAnimationMenu', function()
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
					PlayAnim(anims[menuresult][2], anims[menuresult][3], anims[menuresult][4], true)
				else
					ClearCharTasksImmediately(GetPlayerChar(-1))
				end
			end
		end
	end
end)


-------------------------------------------------------------DEATH SYSTEM-----------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		--if(not IsPlayerInSafezone(-608.92096, -861.88177, 4.84285, 100.0)) then
			if(IsPlayerDead(GetPlayerId())) then
				if(IsGameKeyboardKeyJustPressed(34)) then
					if(emsonline == 1) then
						TriggerEvent("noticeme:Info", "BOT EMS WILL ARIVE HERE IN 5MIN! DONT RESPAWN IF YOU ARE NOT BURNED!")
						Citizen.Wait(60000*5)
						if(IsPlayerDead(GetPlayerId())) then
							FadeScreen()
							SetCamActive(GetGameCam(), true)
							local deadpos = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
							SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1))+100)
							ResurrectNetworkPlayer(GetPlayerId(), deadpos[1], deadpos[2], deadpos[3], 90.0)
							Print('got revived by a bot')
							ResetTimer()
						end
					else
						TriggerEvent("noticeme:Info", "BOT EMS WILL ARIVE HERE IN 2MIN DONT RESPAWN IF YOU ARE NOT BURNED!")
						Citizen.Wait(60000*2)
						if(IsPlayerDead(GetPlayerId())) then
							FadeScreen()
							SetCamActive(GetGameCam(), true)
							local posrr = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
							SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1))+100)
							ResurrectNetworkPlayer(GetPlayerId(), posrr[1], posrr[2], posrr[3], 90.0)
							Print('got revived by a bot')
							ResetTimer()
						end
					end
				end
			end
		--end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(loginform == 0) then
			--if(not IsPlayerInSafezone(-608.92096, -861.88177, 4.84285, 100.0)) then
				if(IsPlayerDead(GetPlayerId())) then
					if(respawnTimer > 0) then
						respawnTimer = respawnTimer - 1
						Citizen.Wait(1000)
					end
				end
			--end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(loginform == 0) then
			--if(not IsPlayerInSafezone(-608.92096, -861.88177, 4.84285, 100.0)) then
				if(IsPlayerDead(GetPlayerId())) then
					if(respawnTimer <= 0) then
						if(deathtimer > 0) then
							deathtimer = deathtimer - 1
							Citizen.Wait(1000)
						end
					end
				end
			--end
		end
	end
end)

function toint(n)
    local s = tostring(n)
    local i, j = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end

ResetTimer = function()
	respawnTimer = 60
	deathtimer = 900
end

RegisterNetEvent('DeathEvent')
AddEventHandler('DeathEvent', function(state)
	if(state == "respawn") then
		respawnPlayer()
		TriggerEvent("deathoff")
	elseif(state == "bot") then
		FadeScreen()
		SetCamActive(GetGameCam(), true)
		local posrr = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
		SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1))+100)
		ResurrectNetworkPlayer(GetPlayerId(), posrr[1], posrr[2], posrr[3], 90.0)
		thirst = 30
		hunger = 30
		SaveStats()
		Print('got revived by a bot')
		TriggerEvent("deathoff")
	end
end)

respawnPlayer = function()
	FadeScreen()
	ClearCharTasksImmediately(GetPlayerChar(-1))
	SetCharCoordinates(GetPlayerChar(-1), -223.96559, 432.8945, 14.81632)
	SetCharHealth(GetPlayerChar(-1), 200)
    ResurrectNetworkPlayer(GetPlayerId(), -223.96559, 432.8945, 14.81632, 90.0)
    SetCharInvincible(GetPlayerChar(-1), false)
	thirst = 30
	hunger = 30
	SaveStats()
end

FadeScreen = function()
	if(not IsScreenFadedOut()) then
		DoScreenFadeOut(500)

		while IsScreenFadingOut() do
			Citizen.Wait(0)
			DoScreenFadeIn(500)
		end
	end

end