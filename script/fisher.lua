local coords = {

}

local mainjobblip = nil
local jobblip = nil
local jobblip2 = nil
local boat = nil
local FishSale = 0
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if(not DoesBlipExist(mainjobblip)) then
			mainjobblip = AddBlipForCoord(461.75272, 1109.80493, 3.06511)
			ChangeBlipSprite(mainjobblip, 48)
			--ChangeBlipColour(mainjobblip, 1)
			ChangeBlipNameFromAscii(mainjobblip, "Fisher")
			SetBlipAsShortRange(mainjobblip, true)
			ChangeBlipScale(mainjobblip, 0.7)
		end
		DrawCheckpointWithDist(461.75272, 1109.80493, 3.06511-1, 1.1, 255, 3, 30, 100)
		DrawTextAtCoord(461.75272, 1109.80493, 3.06511, "Fisher", 20)
		if(IsPlayerNearCoords(461.75272, 1109.80493, 3.06511, 1)) then
			if(level >= 3) then
				DrawDescription("Fisher", {
				-----------------------------------------------------------------------------------------------
				"Progress: " .. jobprogress.fisher .. "%",
				"Unlockable boats: Dinghy (50%), Floater (100%)",
				})
				if(boatlicense == 1) then
					if(not DoesBlipExist(jobblip)) then
						PrintText("Press ~y~E ~w~to start fisher job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							if(currjob == "") then
								local vehs = {
								{"Reefer", 0, GetHashKey("reefer")},
								{"Dinghy", 50, GetHashKey("dinghy")},
								{"Floater", 100, GetHashKey("floater")}
								}
								local tempitems = {}
								for i=1,#vehs,1 do
									tempitems[i] = vehs[i][1]
								end
								DrawWindow("Select boat", tempitems)
								while menuactive do
									Wait(0)
								end
								if(menuresult > 0) then
									if(jobprogress.fisher >= vehs[menuresult][2]) then
										currjob = "Fisher"
										boat = SpawnCar(vehs[menuresult][3], 432.47635, 1104.87109, -0.49772, 91.9804077148438)
										--AllowVeh(boat)
										WarpCharIntoCar(GetPlayerChar(-1), boat)
										local rx,ry,rz,rh = GetRandomWaterNodeInRadius(100)
										jobblip = AddBlipForCoord(rx, ry, rz)
										ChangeBlipColour(jobblip2, 1)
										Notify('Fisher job has been started.')
									else
										Notify("You must reach " .. vehs[menuresult][2] .. "% progress of this job to get access to this boat.")
									end
								end
							else
								Notify("You are currently working at another job. Finish it before starting this one.")
							end
						end
					else
						PrintText("Press ~y~E ~w~to finish fisher job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							currjob = ""
							RemoveBlip(jobblip)
							DeleteCar(boat)
							Notify('Fisher job has been finished.')
							Notify('Sell your fishes @fish storage.')
						end
					end
				else
					PrintText("You need a boat license for this job. Press ~y~E ~w~to ~y~buy it ~w~for ~g~5000$", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						if(inventory[34] >= 5000) then
							RemoveItem(34, 500)
							boatlicense = 1
							SaveStats()
							Notify("Boat license purchased.")
						else
							Notify("You do not have enough money.")
						end
					end
				end
			else
				PrintText("You must reach level 3 to start this job", 1)
			end
		end
		if(DoesBlipExist(jobblip)) then
			if(not IsCarDead(boat)) then
				local bp = GetBlipCoords(jobblip)
				DrawCheckpoint(bp.x, bp.y, bp.z, 2.1, 255, 3, 30, 100)
				if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 3)) then
					PrintText("Press ~y~E ~w~to catch fish", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						SetCarForwardSpeed(boat, 0.0)
						SetPlayerControl(GetPlayerId(), false)
						PrintText("Catching fish...", 10000)
						Wait(10000)
						SetPlayerControl(GetPlayerId(), true)
						local rnd = GenerateRandomIntInRange(0, 3)
						if(rnd == 1) then
							AddItem(29, 1)
							Notify("1kg Fish caught")
							jobprogress.fisher = jobprogress.fisher + 1
							SaveJobProgress()
						elseif(rnd == 2) then
							AddItem(29, 2)
							Notify("2kg Fish caught")
							jobprogress.fisher = jobprogress.fisher + 2
							SaveJobProgress()
						else
							Notify("Failedto catch. Try again.")
						end
						local rx,ry,rz,rh = GetRandomWaterNodeInRadius(100)
						SetBlipCoordinates(jobblip, rx, ry, rz)
					end
				end
				if(IsPlayerDead(GetPlayerId())) then
					RemoveBlip(jobblip)
				end
			else
				RemoveBlip(jobblip)
			end
		end
		if(inventory[29] > 0) then
			DrawCheckpointWithDist(661.57843, 44.28785, 10.1607-1.5, 2.0, 255, 3, 30, 100)
			if(FishSale == 0) then
				DrawTextAtCoord(661.57843, 44.28785, 10.1607, "Fish_storage Press[E]", 20)
			end

			if(IsPlayerNearCoords(661.57843, 44.28785, 10.1607, 2.0)) then
				if(IsGameKeyboardKeyJustPressed(18)) then
					if(FishSale == 0) then
						FishSale = 1
						Notify("Selling fishes.")
					else
						FishSale = 0
						Notify("Stopped.")
					end
				end
			end

		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if(IsPlayerNearCoords(661.57843, 44.28785, 10.1607, 2.0)) then
			if(FishSale == 1) then
				if(inventory[29] > 0) then
					RemoveItem(29, 1)
					AddItem(34, 220)
					DrawSignalAttached("+220$", 500)
					Wait(1000)
					DrawSignalAttached("fish_-1", 500)
					Wait(1000)
				else
					FishSale = 0
				end
			end
		else
			FishSale = 0
		end
	end
end)