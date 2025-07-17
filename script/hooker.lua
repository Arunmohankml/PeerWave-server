local coords = {
{
{-1583.41125, 7.99244, 10.01534, 89.3606109619141, -1634702078},
{
{-1573.43567, 9.85617, 11.10434, 126.318428039551, -1634702078},
{-1573.4342, 11.49421, 11.10434, 81.9876327514648, -1634702078},
{-1570.48181, 10.79513, 11.10434, 355.430053710938, -1634702078},
{-1562.91687, 10.71698, 11.10434, 269.338195800781, -1634702078},
{-1560.12671, 11.46024, 11.10434, 305.618011474609, -1634702078},
{-1560.09021, 9.95708, 11.10434, 221.092559814453, -1634702078}
}
},
{
{1169.06433, 1667.76196, 17.75512, 139.153030395508, -2096494209},
{
{1175.50293, 1680.42371, 17.72698, 125.350357055664, -2096494209},
{1177.97424, 1682.73816, 17.72698, 329.225952148438, -2096494209},
{1175.79785, 1683.02185, 17.72698, 29.3537292480469, -2096494209},
{1175.11475, 1690.84302, 17.7265, 215.043746948242, -2096494209},
{1175.14246, 1693.33899, 17.7265, 331.074157714844, -2096494209},
{1172.21008, 1693.08923, 17.7265, 56.0128135681152, -2096494209}
}
}
}
local coord = 0

local orders = {}
RegisterNetEvent('addHookerOrder')
AddEventHandler('addHookerOrder', function(id, x, y, z)
	for i=1,#orders,1 do
		if(orders[i][1] == id) then
			orders[i] = {id, x, y, z}
			goto skip
		end
	end
	orders[#orders+1] = {id, x, y, z}
	::skip::
	if(currjob == "Hooker") then
		Notify('New order has been added to the list.')
	end
end)
RegisterNetEvent('removeHookerOrder')
AddEventHandler('removeHookerOrder', function(id)
	for i=1,#orders,1 do
		if(orders[i][1] == id) then
			orders = RemoveFromTable(orders, i)
			break
		end
	end
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		Notify('Your hooker request has been accepted. Please wait...')
	end
end)

local mainjobblip = {}
local jobblip = nil
local jobblip2 = nil
local jobid = 0
CreateThread(function()
	while true do
		Wait(0)
		for i=1,#orders,1 do
			if(not IsNetworkPlayerActive(orders[i][1])) then
				orders = RemoveFromTable(orders, i)
				break
			end
		end
		for i=1,#coords,1 do
			if(gender == 2) then
				if(not DoesBlipExist(mainjobblip[i])) then
					mainjobblip[i] = AddBlipForCoord(coords[i][1][1], coords[i][1][2], coords[i][1][3])
					ChangeBlipSprite(mainjobblip[i], 66)
					--ChangeBlipColour(mainjobblip[i], 1)
					--ChangeBlipScale(mainjobblip[i], 0.7)
					ChangeBlipNameFromAscii(mainjobblip[i], "Hooker")
					SetBlipAsShortRange(mainjobblip[i], true)
				end
			end
			DrawCheckpointWithDist(coords[i][1][1], coords[i][1][2], coords[i][1][3]-1, 1.1, 255, 3, 30, 100)
			DrawTextAtCoord(coords[i][1][1], coords[i][1][2], coords[i][1][3], "Hooker", 20)
			if(IsPlayerNearCoords(coords[i][1][1], coords[i][1][2], coords[i][1][3], 1)) then
				if(gender == 2) then
					if(currjob ~= "Hooker") then
						PrintText("Press ~y~E ~w~to start hooker job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							if(currjob == "") then
								currjob = "Hooker"
								local rnd = GenerateRandomIntInRange(1, #coords[i][2]+1)
								jobblip = AddBlipForCoord(coords[i][2][rnd][1], coords[i][2][rnd][2], coords[i][2][rnd][3])
								SetBlipAsShortRange(jobblip, true)
								coord = rnd
								jobid = i
								Notify('Hooker job has been started. Follow checkpoints on the stage or press X button to open hooker menu and select a client.')
							else
								Notify("You are currently working at another job. Finish it before starting this one.")
							end
						end
					else
						PrintText("Press ~y~E ~w~to finish hooker job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							currjob = ""
							RemoveBlip(jobblip)
							RemoveBlip(jobblip2)
							Notify('Hooker job has been finished.')
						end
					end
				else
					PrintText("This job is available only for females.", 1)
				end
			end
		end
		if(DoesBlipExist(jobblip)) then
			local bp = GetBlipCoords(jobblip)
			DrawCheckpoint(bp.x, bp.y, bp.z-1, 0.5, 255, 3, 30, 100)
			if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 1)) then
				PrintText("Press ~y~E ~w~to dance", 1)
				if(IsGameKeyboardKeyJustPressed(18)) then
					SetPlayerControl(GetPlayerId(), false)
					PlayAnim("amb@dance_femidl_b", "loop_b")
					SetPlayerControl(GetPlayerId(), true)
					AddItem(34, 60)
							--money = money + 5
					SaveStats()
					Notify("+60$")
					local rnd = GenerateRandomIntInRange(1, #coords[jobid][2]+1)
					while rnd==coord do
						rnd = GenerateRandomIntInRange(1, #coords[jobid][2]+1)
					end
					coord = rnd
					SetBlipCoordinates(jobblip, coords[jobid][2][rnd][1], coords[jobid][2][rnd][2], coords[jobid][2][rnd][3])
				end
			end
			if(IsPlayerDead(GetPlayerId())) then
				RemoveBlip(jobblip)
			end
		end
		if(currjob == "Hooker") then
			if(IsGameKeyboardKeyJustPressed(JobKey)) then
				if(not DoesBlipExist(jobblip2)) then
					local tempitems = {}
					for i=1,#orders,1 do
						local streetname = GetStreetAtCoord(orders[i][2], orders[i][3], orders[i][4])
						local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
						local dist = GetDistanceBetweenCoords3d(px, py, pz, orders[i][2], orders[i][3], orders[i][4])
						tempitems[i] = streetname .. " (" .. math.floor(dist) .. "m)"
					end
					DrawWindow("Order list", tempitems)
					while menuactive do
						Wait(0)
					end
					if(menuresult > 0) then
						local order = orders[menuresult]
						jobblip2 = AddBlipForCoord(orders[menuresult][2], orders[menuresult][3], orders[menuresult][4])
						SetRoute(jobblip2, true)
						TriggerServerEvent('removeHookerOrder', orders[menuresult][1])
					end
				else
					DrawWindow("Order list", {"Cancel current order"})
					while menuactive do
						Wait(0)
					end
					if(menuresult == 1) then
						RemoveBlip(jobblip2)
						DeleteChar(client)
					end
				end
			end
			if(DoesBlipExist(jobblip2)) then
				local bp = GetBlipCoords(jobblip2)
				DrawCheckpoint(bp.x, bp.y, bp.z-1, 1.1, 255, 3, 30, 100)
				if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 10)) then
					RemoveBlip(jobblip2)
				end
			end
			if(IsPlayerDead(GetPlayerId())) then
				RemoveBlip(jobblip2)
			end
		end
	end
end)

local stuffchecker = false
RegisterNetEvent('sendStuffOffer')
AddEventHandler('sendStuffOffer', function(id, sender, type, price)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		if(gender == 1) then
			CreateThread(function()
				local opts = {"Handjob", "Blowjob", "Sex"}
				DrawWindow(GetPlayerName(sender) .. " offers you a " .. opts[type], {"Accept offer for ~g~" .. price .. "$"})
				while menuactive do
					Wait(0)
				end
				if(menuresult > 0) then
					local ped = GetPlayerChar(-1)
					local veh = GetCarCharIsUsing(ped)
					local manims = {"m_handjob_loop", "m_blowjob_loop", "m_sex_loop"}
					local fanims = {"f_handjob_loop", "f_blowjob_loop", "f_sex_loop"}
					--ClearCharTasksImmediately(GetPlayerChar(-1))
					RequestAnims("misscar_sex")
					while not HaveAnimsLoaded("misscar_sex") do
						Wait(0)
					end
					stuffchecker = false
					Settimerc(0)
					TriggerServerEvent('acceptStuffOffer', sender, id, type, price)
					while not stuffchecker do
						Wait(0)
						if(Timerc() >= 10000) then
							goto out
						end
					end
					if(GetDriverOfCar(veh)==ped or GetCharInCarPassengerSeat(veh, 1)==ped) then
						TaskPlayAnimWithFlags(ped, manims[type], "misscar_sex", 8.0, 30000, 0)
					elseif(GetCharInCarPassengerSeat(veh, 0)==ped or GetCharInCarPassengerSeat(veh, 2)==ped) then
						--SetScriptedAnimSeatOffset(ped, 0.80900000)
						TaskPlayAnimWithFlags(ped, fanims[type], "misscar_sex", 8.0, 30000, 0)
					end
					if(GetCharHealth(GetPlayerChar(-1)) < 200) then
						if(type == 1) then
							SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1))+30)
						elseif(type == 2) then
							SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1))+60)
						elseif(type == 3) then
							SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1))+100)
						end
					end
					RemoveItem(34, price)
					SaveStats()
					::out::
				else
					TriggerServerEvent('sendMessageToPlayer', sender, "Your offer has been declined.")
				end
			end)
		else
			TriggerServerEvent('sendMessageToPlayer', sender, "You can do that only with males.")
		end
	end
end)
RegisterNetEvent('acceptStuffOffer')
AddEventHandler('acceptStuffOffer', function(id, sender, type, price)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		CreateThread(function()
			local ped = GetPlayerChar(-1)
			local veh = GetCarCharIsUsing(ped)
			local manims = {"m_handjob_loop", "m_blowjob_loop", "m_sex_loop"}
			local fanims = {"f_handjob_loop", "f_blowjob_loop", "f_sex_loop"}
			--ClearCharTasksImmediately(GetPlayerChar(-1))
			RequestAnims("misscar_sex")
			while not HaveAnimsLoaded("misscar_sex") do
				Wait(0)
			end
			TriggerServerEvent('acceptStuffOffer2', sender)
			if(GetDriverOfCar(veh)==ped or GetCharInCarPassengerSeat(veh, 1)==ped) then
				TaskPlayAnimWithFlags(ped, manims[type], "misscar_sex", 8.0, 30000, 0)
			elseif(GetCharInCarPassengerSeat(veh, 0)==ped or GetCharInCarPassengerSeat(veh, 2)==ped) then
				--SetScriptedAnimSeatOffset(ped, 0.80900000)
				TaskPlayAnimWithFlags(ped, fanims[type], "misscar_sex", 8.0, 30000, 0)
			end
			AddItem(34, price)
							--money = money + price
			SaveStats()
		end)
	end
end)
RegisterNetEvent('acceptStuffOffer2')
AddEventHandler('acceptStuffOffer2', function(id)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		stuffchecker = true
	end
end)