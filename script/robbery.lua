
robcoords = {
	{-172.42084, 291.50201, 14.86639, 278.983764648438},
	{-122.07593, 71.51707, 14.80806, 106.943794250488},
	{-235.78763, 52.43921, 15.71312, 91.2408752441406},
	{22.31282, 797.11499, 14.76678, 180.50993347168},
	{54.58933, 798.75574, 15.16315, 319.06005859375},
	--{75.0607, -677.62225, 14.7738, 177.434234619141},
	{-428.24542, 1197.6405, 13.05203, 267.084991455078},
	{-1009.49304, 1626.15442, 24.31901, 359.677886962891},
	{-1090.47241, 1474.23364, 24.79183, 271.593383789063},
	{-1499.18506, 1118.91211, 23.21375, 274.082672119141},
	{968.11127, -167.56174, 24.19873, 195.993103027344},
	{-1572.93005, 21.88715, 10.01533, 63.7966003417969},
	{-1578.47522, 458.15839, 25.44883, 332.119873046875},
	{15.46471, 978.93658, 15.65396, 187.088623046875},
	{1112.57715, 1588.5448, 16.96132, 232.432281494141},
	{1189.85303, 1703.45667, 17.72699, 314.760040283203},
	{869.28809, -116.87454, 6.0054, 198.192626953125},
	{-161.80794, 591.51953, 14.71254, 191.149566650391},
	{-121.88103, 774.33148, 26.00478, 183.197570800781},
	{1135.86328, 327.12988, 29.79164, 265.688629150391},
	{-281.33087, 1365.49316, 25.63732, 199.448867797852},
	{754.77216, 191.23289, 6.19825, 279.141723632813},
	{1466.45947, 57.28556, 25.19058, 177.861633300781},
	{1201.10181, 198.82947, 33.55367, 269.903106689453},
	{765.96722, -64.7201, 5.85797, 103.67951965332},
	{849.46667, -384.2803, 13.8839, 270.404479980469},
	{888.88715, -446.77679, 15.84871, 58.0400886535645},
	{938.07275, -492.12204, 15.48972, 0.0370317287743092},
	{1201.92212, -654.71216, 16.84986, 188.712692260742},
	{-438.35364, 450.87454, 10.39999, 116.016616821289}
}
local robbiz = nil

robtimer = 0

local RobBlip = {}
local TriggeredShop = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		for i=1,#robcoords,1 do
			if(not DoesBlipExist(RobBlip[i])) then
				RobBlip[i] = AddBlipForCoord(robcoords[i][1], robcoords[i][2], robcoords[i][3])
				ChangeBlipSprite(RobBlip[i], 9)
				ChangeBlipNameFromAscii(RobBlip[i], "Robbery")
				SetBlipAsShortRange(RobBlip[i], true)
				ChangeBlipScale(RobBlip[i], 0.3)
			end
			if(IsPlayerNearCoords(robcoords[i][1], robcoords[i][2], robcoords[i][3], 50)) then
				if(TriggeredShop == false) then
					if(RobCooldown == 0) then
						DrawTextAtCoord(robcoords[i][1], robcoords[i][2], robcoords[i][3], "Press_[E]_to_start_shop_robbery", 3.0)
						if robtimer == 0 then
							DrawCheckpointWithAlpha(robcoords[i][1], robcoords[i][2], robcoords[i][3]-1, 0.3, 255, 0, 0, 100)
							if(IsPlayerNearCoords(robcoords[i][1], robcoords[i][2], robcoords[i][3], 0.5)) then
								if(coponline >= 2) then
									if(IsGameKeyboardKeyJustPressed(18)) then
										exports.minigame:StartMinigame({
											maxFails = 3,
											maxSquares = 5,
											rows = 7,
											shop = i,
										})
									end
								else
									PrintText('No cops online to start robbery!. Min 2 cops are needed',100)
								end
							end
						else
							if(IsPlayerNearCoords(robcoords[robbiz][1], robcoords[robbiz][2], robcoords[robbiz][3], 15)) then
								DrawCheckpointWithAlpha(robcoords[robbiz][1], robcoords[robbiz][2], robcoords[robbiz][3]-1, 30.1, 255, 0, 0, 100)
								PrintText("Robbery in progress. Wait for ~y~" .. robtimer .. " seconds ~w~to finish", 1000)
							end
							if(robtimer > 0) then
								if(IsPlayerDead(GetPlayerId())) then
									robtimer = 0
									RobCooldown = RobCooldown + 600
									SaveServerInfo()
									TriggerEvent("noticeme:Info", 'Robbery failed!')
									TriggerServerEvent('TriggeredRobbery', false, "shop")
								end
								if(IsPlayerNearCoords(robcoords[robbiz][1], robcoords[robbiz][2], robcoords[robbiz][3], 15)) then
									
									if(robtimer == 1) then
										local tempmoney = GenerateRandomIntInRange(6000, 8000)
										inventory[28] = inventory[28] + tempmoney
										SaveInventory()
										AddExp(5)
										SaveStats()
										DeleteObject(bag)
										TriggerEvent("noticeme:Info", 'Robbery has been finished and you got ' .. tempmoney .. '.Rs!')
										Print(' has got '..tempmoney.." frm shop robbery")
										RobCooldown = RobCooldown + 600
										SaveServerInfo()
										TriggerServerEvent('TriggeredRobbery', false, "shop")
									end
								else
									for j=10,1,-1 do
										PrintText("~r~You are too far from the business! Go back to continue robbery. You have ~y~" .. j .. " seconds", 1000, 1)
										Citizen.Wait(1000)
										if(not IsPlayerNearCoords(robcoords[robbiz][1], robcoords[robbiz][2], robcoords[robbiz][3], 15)) then
											if(j == 1) then
												robtimer = 0
												TriggerEvent("noticeme:Info", 'Robbery failed!')
												RobCooldown = RobCooldown + 600
												SaveServerInfo()
												TriggerServerEvent('TriggeredRobbery', false, "shop")
											end
										else
											break
										end
									end
								end
							end
						end
					else
						DrawTextAtCoord(robcoords[i][1], robcoords[i][2], robcoords[i][3], "Cool_down " .. RobCooldown, 3.0)
					end
				else
					DrawTextAtCoord(robcoords[i][1], robcoords[i][2], robcoords[i][3], "Robbery Ongoing", 3.0)
				end
			end
		end
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(robtimer > 0) then
			robtimer = robtimer - 1
		end
		Citizen.Wait(1000)
	end
end)

RegisterNetEvent('minigameresult')
AddEventHandler('minigameresult', function(id, result)
    if result then
        robbiz = id
		
        -- Use the global 'robtimer' variable
        robtimer = 200
        TriggerEvent("noticeme:Info", 'Robbery Started! cops are coming ' .. id ..' ' .. robtimer)
        local px, py, pz = GetCharCoordinates(GetPlayerChar(-1))
        TriggerServerEvent('addRobbery', "shop", px, py, pz)
        Print("Business robbery triggered: " .. id)

        bag = SpawnObject(GetHashKey("cj_mk_drug_bag"), px, py, pz, 0.0)
        AttachObjectToPed(bag, GetPlayerChar(-1), 0x4B2, 0.3, 0, 0, 0, -math.pi/2, math.pi, 0)
        TriggerServerEvent('TriggeredRobbery', true, "shop")
		
    end
end)