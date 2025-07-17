local coords = {
{3.60705, -851.91779, 4.814, 117.035774230957, 0},
{-37.6107, -900.79462, 4.81375, 29.3220901489258, 0},
{-6.58278, -922.21545, 4.86548, 23.9421482086182, 0},
{32.91369, -807.35236, 5.03029, 122.281181335449, 0},
{56.32971, -880.04858, 5.00554, 136.628631591797, 0}
}

local mainjobblip = nil
local jobblip = nil
local truck = nil
local pile = nil
local state = 0
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if(not DoesBlipExist(mainjobblip)) then
			mainjobblip = AddBlipForCoord(-59.09336, -922.64478, 5.49466)
			ChangeBlipSprite(mainjobblip, 40)
			--ChangeBlipColour(mainjobblip, 1)
			ChangeBlipNameFromAscii(mainjobblip, "Supplier")
			SetBlipAsShortRange(mainjobblip, true)
			ChangeBlipScale(mainjobblip, 0.7)
			
		end
		DrawCheckpointWithDist(-59.09336, -922.64478, 5.49466-1, 1.1, 255, 3, 30, 100)
		DrawTextAtCoord(-59.09336, -922.64478, 5.49466, "Supplier", 20)
		if(IsPlayerNearCoords(-59.09336, -922.64478, 5.49466, 1)) then
			if(jobprogress.builder >= 100) then
				if(driverlicense == 1) then	
					if(not DoesBlipExist(jobblip)) then
						PrintText("Press ~y~E ~w~to start supplier job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							if(currjob == "") then
								currjob = "Supplier"
								truck = SpawnCar(GetHashKey("biff"), -53.72892, -944.70148, 4.89422, 2.97140526771545)
								
								for j=1,9,1 do
									TurnOffVehicleExtra(truck, j, false)
								end
								ChangeCarColour(truck, 2, 2)
								--AllowVeh(truck)
								WarpCharIntoCar(GetPlayerChar(-1), truck)
								local rnd = GenerateRandomIntInRange(2, #coords+1)
								jobblip = AddBlipForCoord(coords[rnd][1], coords[rnd][2], coords[rnd][3])
								--SetRoute(jobblip, true)
								pile = SpawnObject(GetHashKey("et_dirtpileship"), coords[rnd][1], coords[rnd][2], coords[rnd][3]-1, coords[rnd][4])
								FreezeObjectPosition(pile, true)
								Notify('Supplier job has been started.')
								state = 0
							else
								Notify("You are currently working at another job. Finish it before starting this one.")
							end
						end
					else
						PrintText("Press ~y~E ~w~to finish supplier job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							currjob = ""
							RemoveBlip(jobblip)
							DeleteObject(pile)
							DeleteCar(truck)
							Notify('Supplier job has been finished.')
						end
					end
				else
					PrintText("You must have a driver license for this job", 1)
				end
			else
				PrintText("Fill the progress bar of builder job to get access to this job", 1)
			end
		end
		if(DoesBlipExist(jobblip)) then
			--if(not IsObjectAttached(pile)) then
			if(state == 0) then
				--if(IsVehicleTouchingObject(truck, pile)) then
					local ox,oy,oz = GetObjectCoordinates(pile)
					if(IsPlayerNearCoords(ox, oy, oz, 5)) then
						--AttachObjectToCar(pile,forklift,0,0.0,-2.0,0.5,0.0,0.0,0.0)
						SetObjectVisible(pile, false)
						SetBlipCoordinates(jobblip, coords[1][1], coords[1][2], coords[1][3])
						--SetRoute(jobblip, true)
						state = 1
					end
				--end
			else
				local bp = GetBlipCoords(jobblip)
				DrawCheckpoint(bp.x, bp.y, bp.z-1, 1.1, 255, 3, 30, 100)
				if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 3)) then
					PrintText("Press ~y~E ~w~to unload the truck", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						local rnd = GenerateRandomIntInRange(2, #coords+1)
						SetBlipCoordinates(jobblip, coords[rnd][1], coords[rnd][2], coords[rnd][3])
						--SetRoute(jobblip, true)
						--DetachObject(pile, 1, 1)
						SetObjectCoordinates(pile, coords[rnd][1], coords[rnd][2], coords[rnd][3]-1)
						SetObjectHeading(pile, coords[rnd][4])
						SetObjectVisible(pile, true)
						AddItem(34, 270)
							
						SaveStats()
						Notify("+270$", 3000)
						state = 0
					end
				end
			end
			if(IsPlayerDead(GetPlayerId())) then
				RemoveBlip(jobblip)
				DeleteObject(pile)
			end
			if(not IsCharInAnyCar(GetPlayerChar(-1))) then
				RemoveBlip(jobblip)
				DeleteObject(pile)
				DeleteCar(truck)
				currjob = ""
				Notify('Supplier job has been stopped, dont exit the vehicle.')
			end
		end
	end
end)