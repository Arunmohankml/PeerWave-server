local subways = {
--{subway, train, reward}
{{1023.68921, -547.24896, 24.69202, 88.7039489746094}, {1038.26733, -568.25, 23.69375, 90}, {2000, 300}}
}
local route = 0

local coords = {
{
{-17.15595, 3.16409, -2.86192, 177.945175170898},
{102.0356, -263.39508, -4.47422, 178.169906616211},
{106.41796, -722.94513, -13.79984, 118.281982421875},
{-331.19073, -388.35007, -13.74339, 28.0520420074463},
{-519.51294, -25.66109, -8.85653, 357.303436279297},
{-483.02707, 505.94583, -8.85099, 358.043518066406},
{-536.9129, 918.52734, -3.91336, 12.3013601303101},
{-511.17084, 1298.40515, -13.22763, 343.446655273438},
{-118.49465, 1413.24023, 0.46323, 268.758544921875},
{112.33252, 942.86334, -2.98795, 176.887771606445},
{111.02824, 558.76947, -4.40499, 178.162933349609},
{1412.16919, 392.2211, 32.34906, 267.876922607422},
{1640.74194, 392.21494, 37.18567, 267.103729248047},
{2291.87573, 452.6163, 20.71582, 358.29931640625},
{1424.22034, 380.34442, 39.3811, 177.662841796875},
{1317.698, -68.04778, 38.38899, 177.305419921875},
{1045.79395, -568.30969, 23.61086, 90.4201431274414}
}
}
local mainjobblip = nil
local jobblip = nil
local train = nil
local coord = 0
local tempdist = 0

local trainspeed = 0.0
CreateThread(function()
	while true do
		Wait(0)
		for i=1,#subways,1 do
			if(not DoesBlipExist(mainjobblip)) then
				mainjobblip = AddBlipForCoord(subways[i][1][1], subways[i][1][2], subways[i][1][3], _i)
				ChangeBlipSprite(mainjobblip, 58)
				ChangeBlipColour(mainjobblip, 3)
				--ChangeBlipScale(mainjobblip, 0.7)
				ChangeBlipNameFromAscii(mainjobblip, "Subway driver")
				SetBlipAsShortRange(mainjobblip, true)
				ChangeBlipScale(mainjobblip, 0.7)
			end
			DrawTextAtCoord(subways[i][1][1], subways[i][1][2], subways[i][1][3], "Subway_driver", 20)
			DrawCheckpointWithDist(subways[i][1][1], subways[i][1][2], subways[i][1][3]-1, 1.1, 255, 3, 30, 100)
			if(IsPlayerNearCoords(subways[i][1][1], subways[i][1][2], subways[i][1][3], 0.5)) then
				if(level >= 2) then
					if(trainlicense == 1) then
						if(IsCarDead(train)) then
							PrintText("Press ~y~E ~w~to start subway driver job", 1)
							if(IsGameKeyboardKeyJustPressed(18)) then
								if(currjob == "") then
									currjob = "Subway driver"
									traincam = CreateCam(14, _i)
									DeleteCar(train)
									train = SpawnCar(GetHashKey("SUBWAY_HI"), subways[i][2][1], subways[i][2][2], subways[i][2][3], subways[i][2][4])
									LockCarDoors(train, 4)
									WarpCharIntoCar(GetPlayerChar(-1), train)
									coord = 1
									route = i
									jobblip = AddBlipForCoord(coords[route][coord][1], coords[route][coord][2], coords[route][coord][3])
									trainspeed = 0.0
									local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
									tempdist = GetDistanceBetweenCoords3d(px, py, pz, coords[route][coord][1], coords[route][coord][2], coords[route][coord][3])
									Notify('Subway driver job has been started.')
								else
									Notify("You are currently working at another job. Finish it before starting this one.")
								end
							end
						else
							PrintText("Press ~y~E ~w~to finish subway driver trucker job", 1)
							if(IsGameKeyboardKeyJustPressed(18)) then
								currjob = ""
								DeleteCar(train)
								RemoveBlip(jobblip)
								Notify('Subway driver job has been finished.')
							end
						end
					else
						PrintText("You need a train license for this job. Press ~y~E ~w~to ~y~buy it ~w~for ~g~2000$", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							if(inventory[34] >= 2000) then
								RemoveItem(34, 200)
								trainlicense = 1
								SaveStats()
								Notify("Train license purchased.")
							else
								Notify("You do not have enough money.")
							end
						end
					end
				else
					PrintText("You must reach level 2 to start this job", 1)
				end
			end
		end
		if(DoesBlipExist(jobblip)) then
			if(not IsCarDead(train)) then
				DrawCheckpointWithAlpha(coords[route][coord][1], coords[route][coord][2], coords[route][coord][3]-1, 10.1, 255, 3, 30, 100)
				if(IsPlayerNearCoords(coords[route][coord][1], coords[route][coord][2], coords[route][coord][3], 10.1)) then
					if(IsCharInCar(GetPlayerChar(-1), train)) then
						if(coord ~= #coords[route]) then
							if(math.abs(trainspeed) < 1) then
								Settimera(0)
								while Timera()<10000 do
									Wait(0)
									PrintText("Wait for ~y~" .. 10 - math.floor(Timera()/1000) .. " seconds", 1)
									if(not IsPlayerNearCoords(coords[route][coord][1], coords[route][coord][2], coords[route][coord][3], 10.1)) then
										goto out
									end
								end
								coord = coord + 1
								local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
								tempdist = tempdist + GetDistanceBetweenCoords3d(px, py, pz, coords[route][coord][1], coords[route][coord][2], coords[route][coord][3])
								SetBlipCoordinates(jobblip, coords[route][coord][1], coords[route][coord][2], coords[route][coord][3])
								::out::
							else
								PrintText("Stop at the station", 1)
							end
						else
							currjob = ""
							DeleteCar(train)
							RemoveBlip(jobblip)
							local finalcash = math.floor(tempdist/10)
							AddItem(34, finalcash)
							
							SaveStats()
							Notify('Route has been finished. You have got ' .. finalcash .. '$.')
						end
					end
				end
				if(IsPlayerDead(GetPlayerId())) then
					RemoveBlip(jobblip)
					DeleteCar(train)
				end
			else
				RemoveBlip(jobblip)
				DeleteCar(train)
			end
		end
	end
end)
CreateThread(function()
	while true do
		Wait(0)
		if(not IsCarDead(train)) then
			if(IsCharInCar(GetPlayerChar(-1), train)) then
				SetCamPropagate(traincam, 1)
				SetCamActive(traincam, true)
				ActivateScriptedCams(1, 1)
				local cx,cy,cz = GetCarCoordinates(train)
				local ch = GetCarHeading(train)
				local dir = FindTrainDirection(train)
				if(dir == 1) then
					SetCamPos(traincam, cx-10*math.cos((ch+90)*math.pi/180), cy-10*math.sin((ch+90)*math.pi/180), cz+2.8)
				else
					SetCamPos(traincam, cx+10*math.cos((ch+90)*math.pi/180), cy+10*math.sin((ch+90)*math.pi/180), cz+2.8)
				end
				PointCamAtVehicle(traincam, train)
				
				if(dir == 1) then
					SetTrainSpeed(train, trainspeed)
				else
					SetTrainSpeed(train, -trainspeed)
				end
				if(IsGameKeyboardKeyPressed(17)) then --w
					if(trainspeed < 50) then
						trainspeed = trainspeed + 0.2
					end
				end
				if(IsGameKeyboardKeyPressed(31)) then --s
					if(trainspeed > -10) then
						trainspeed = trainspeed - 0.2
					end
				end
			else
				SetCamActive(traincam, false)
				SetCamPropagate(traincam, 0)
				SetCamPropagate(GetGameCam(), 1)
				ActivateScriptedCams(0, 0)
			end
		else
			SetCamActive(traincam, false)
			SetCamPropagate(traincam, 0)
			SetCamPropagate(GetGameCam(), 1)
			ActivateScriptedCams(0, 0)
		end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if(not IsPlayerDead(GetPlayerId())) then
			if(not IsCharInAnyTrain(GetPlayerChar(-1))) then
				local veh = GetVehiclePlayerWouldEnter(GetPlayerId())
				if(not IsCarDead(veh)) then
					if(IsThisModelATrain(GetCarModel(veh))) then
						--if(IsCharTouchingVehicle(GetPlayerChar(-1), veh)) then
							if(IsControlPressed(0, 3)) then
								if(GetMaximumNumberOfPassengers(veh) > 0) then
									for i=0,GetMaximumNumberOfPassengers(veh)-1,1 do
										if(IsCarPassengerSeatFree(veh, i)) then
											WarpCharIntoCarAsPassenger(GetPlayerChar(-1), veh, i)
											break
										end
									end
								end
							end
						--end
					end
				end
			else
				if(GetCarCharIsUsing(GetPlayerChar(-1)) ~= train) then
					if(IsControlPressed(0, 3)) then
						local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
						WarpCharFromCarToCoord(GetPlayerChar(-1), px, py, pz)
					end
				end
			end
		end
	end
end)