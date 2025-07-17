local coords = {
{
{975.29993, -142.00316, 24.00125, 195.829742431641, 0},
{1246.1001, -81.30313, 27.96511, 355.705993652344, 0},
{1716.63, 501.44901, 28.97431, 318.89404296875, 0},
{1813.52368, 637.93866, 28.69225, 354.067108154297, 0},
{1338.29065, 391.37415, 22.61418, 88.3228073120117, 0},
{1032.07422, 284.53424, 31.44827, 54.4432830810547, 0}
},
{
{953.64038, -564.46783, 14.16018, 88.3717422485352, 0},
{2335.34326, 390.69678, 5.90514, 359.727203369141, 0},
{1762.31677, 566.52167, 29.05188, 134.002548217773, 0},
{1338.29065, 391.37415, 22.61418, 88.3228073120117, 0},
{1032.07422, 284.53424, 31.44827, 54.4432830810547, 0}
}
}

local mainjobblip = nil
local jobblip = nil
local bus = nil
local route = 0
local coord = 0
local tempdist = 0
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if(not DoesBlipExist(mainjobblip)) then
			mainjobblip = AddBlipForCoord(1034.09448, 298.09409, 32.03739)
			ChangeBlipSprite(mainjobblip, 23)
			--ChangeBlipColour(mainjobblip, 1)
			ChangeBlipNameFromAscii(mainjobblip, "Bus driver")
			SetBlipAsShortRange(mainjobblip, true)
			ChangeBlipScale(mainjobblip, 0.7)
		end
		DrawCheckpointWithDist(1034.09448, 298.09409, 32.03739-1, 1.1, 255, 3, 30, 100)
		DrawTextAtCoord(1034.09448, 298.09409, 32.03739, "Bus_driver", 20)
		if(IsPlayerNearCoords(1034.09448, 298.09409, 32.03739, 1)) then
			if(level >= 1) then
				if(driverlicense == 1) then
					if(IsCarDead(bus)) then
						PrintText("Press ~y~E ~w~to start bus driver job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							if(currjob == "") then
								local tempitems = {}
								for i=1,#coords,1 do
									tempitems[i] = "Route " .. i
								end
								DrawWindow("Select route", tempitems)
								while menuactive do
									Wait(0)
								end
								if(menuresult > 0) then
									currjob = "Bus driver"
									DeleteCar(bus)
									bus = SpawnCar(GetHashKey("bus"), 1031.39563, 285.04279, 31.44827, 234.692260742188)
									--AllowVeh(bus)
									WarpCharIntoCar(GetPlayerChar(-1), bus)
									route = menuresult
									jobblip = AddBlipForCoord(coords[route][1][1], coords[route][1][2], coords[route][1][3])
									SetRoute(jobblip, true)
									coord = 1
									local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
									tempdist = GetDistanceBetweenCoords3d(px, py, pz, coords[route][1][1], coords[route][1][2], coords[route][1][3])
									Notify('Bus driver job has been started.')
								end
							else
								Notify("You are currently working at another job. Finish it before starting this one.")
							end
						end
					else
						PrintText("Press ~y~E ~w~to finish bus driver job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							currjob = ""
							RemoveBlip(jobblip)
							DeleteCar(bus)
							Notify('Bus driver job has been finished.')
						end
					end
				else
					PrintText("You must have a driver license for this job", 1)
				end
			else
				PrintText("You must reach level 1 to start this job", 1)
			end
		end
		if(DoesVehicleExist(bus)) then
			if(not IsCarDead(bus)) then
				local bp = GetBlipCoords(jobblip)
				DrawCheckpoint(bp.x, bp.y, bp.z-1, 2.1, 255, 3, 30, 100)
				if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 3)) then
					if(IsCharInCar(GetPlayerChar(-1), bus)) then
						if(coord ~= #coords[route]) then
							SetPlayerControl(GetPlayerId(), false)
							PrintText("Bus stop! Wait...", 10000)
							Wait(10000)
							SetPlayerControl(GetPlayerId(), true)
							coord = coord + 1
							local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
							tempdist = tempdist + GetDistanceBetweenCoords3d(px, py, pz, coords[route][coord][1], coords[route][coord][2], coords[route][coord][3])
							SetBlipCoordinates(jobblip, coords[route][coord][1], coords[route][coord][2], coords[route][coord][3])
							SetRoute(jobblip, true)
						else
							currjob = ""
							coord = 0
							RemoveBlip(jobblip)
							local finalcash = math.floor(tempdist/10)
							
							DeleteCar(bus)
							AddItem(34, finalcash)
							SaveStats()
							Notify("+" .. finalcash .. "$/", 5000)
							Notify('Route has been finished')
						end
					end
				end
				if(IsPlayerDead(GetPlayerId())) then
					RemoveBlip(jobblip)
					--DeleteEntity(bus)
				end
			else
				currjob = ""
				RemoveBlip(jobblip)
				--DeleteEntity(bus)
			end
		end
	end
end)