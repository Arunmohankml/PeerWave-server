local coords = {
{795.92883, -188.35652, 6.11556, 333.728576660156, 0},
{770.83191, -213.93889, 5.83749, 242.690734863281, 0},
{751.55908, -252.2092, 5.82309, 244.223663330078, 0},
{754.54132, -270.02249, 5.82349, 155.430282592773, 0},
{743.25793, -289.60214, 5.82397, 332.973114013672, 0},
{722.02606, -317.62448, 5.8247, 243.111267089844, 0},
{727.64374, -332.06186, 5.8247, 154.796310424805, 0},
{736.89423, -305.47968, 5.8247, 242.4794921875, 0},
{764.70551, -252.22568, 5.82334, 65.2241592407227, 0}
}

local mainjobblip = nil
local jobblip = nil
local forklift = nil
local crate = nil
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if(not DoesBlipExist(mainjobblip)) then
			mainjobblip = AddBlipForCoord(709.78094, -361.49918, 6.33745)
			ChangeBlipSprite(mainjobblip, 38)
			ChangeBlipColour(mainjobblip, 19)
			ChangeBlipNameFromAscii(mainjobblip, "Forklift loader")
			SetBlipAsShortRange(mainjobblip, true)
			ChangeBlipScale(mainjobblip, 0.7)
		end
		DrawCheckpointWithDist(709.78094, -361.49918, 6.33745-1, 1.1, 255, 3, 30, 100)
		DrawTextAtCoord(709.78094, -361.49918, 6.33745, "Forklift_loader", 20)
		if(IsPlayerNearCoords(709.78094, -361.49918, 6.33745, 1)) then
			if(jobprogress.loader >= 100) then
				if(driverlicense == 1) then
					if(not DoesBlipExist(jobblip)) then
						PrintText("Press ~y~E ~w~to start forklift loader job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							if(currjob == "") then
								currjob = "Forklift loader"
								forklift = SpawnCar(GetHashKey("forklift"), 713.81927, -342.97366, 5.82552, 65.1091232299805)
								--AllowVeh(forklift)
								WarpCharIntoCar(GetPlayerChar(-1), forklift)
								local rnd = GenerateRandomIntInRange(2, #coords+1)
								jobblip = AddBlipForCoord(coords[rnd][1], coords[rnd][2], coords[rnd][3])
								crate = SpawnObject(GetHashKey("cj_ind_box_pile_1c"), coords[rnd][1], coords[rnd][2], coords[rnd][3]-1, coords[rnd][4])
								FreezeObjectPosition(crate, true)
								Notify('Forklift loader job has been started.')
							else
								Notify("You are currently working at another job. Finish it before starting this one.")
							end
						end
					else
						PrintText("Press ~y~E ~w~to finish forklift loader job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							currjob = ""
							RemoveBlip(jobblip)
							DeleteObject(crate)
							DeleteCar(forklift)
							Notify('Forklift loader job has been finished.')
						end
					end
				else
					PrintText("You must have a driver license for this job", 1)
				end
			else
				PrintText("Fill the progress bar of loader job to get access to this job", 1)
			end
		end
		if(DoesBlipExist(jobblip)) then
			if(not IsObjectAttached(crate)) then
				if(IsVehicleTouchingObject(forklift, crate)) then
					AttachObjectToCar(crate,forklift,0,0.0,2.0,-0.2,0.0,0.0,math.pi/2)
					SetBlipCoordinates(jobblip, coords[1][1], coords[1][2], coords[1][3])
				end
			else
				local bp = GetBlipCoords(jobblip)
				DrawCheckpoint(bp.x, bp.y, bp.z-1, 1.1, 255, 3, 30, 100)
				if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 3)) then
					PrintText("Press ~y~E ~w~to put the crate", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						local rnd = GenerateRandomIntInRange(2, #coords+1)
						SetBlipCoordinates(jobblip, coords[rnd][1], coords[rnd][2], coords[rnd][3])
						DetachObject(crate)
						SetObjectCoordinates(crate, coords[rnd][1], coords[rnd][2], coords[rnd][3]-1)
						SetObjectHeading(crate, coords[rnd][4])
						AddItem(34, 150)
							--money = money + 20
						SaveStats()
						Notify("+150$")
					end
				end
			end
			if(IsPlayerDead(GetPlayerId())) then
				RemoveBlip(jobblip)
				DeleteObject(crate)
			end
		end
	end
end)