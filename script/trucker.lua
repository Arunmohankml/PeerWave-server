local coords = {
{-1346.93066, -250.74843, 2.92882, 180.054809570313},
{-1490.49744, 1096.14746, 23.33706, 0.880167663097382},
{-473.92484, 1746.47925, 8.70503, 299.694519042969},
{-490.47205, 366.18347, 6.96213, 196.275619506836},
{148.87033, -865.37616, 4.72054, 219.74739074707},
{748.20831, -275.56921, 5.82379, 62.5041847229004},
{2017.23779, 611.00507, 18.01789, 357.092834472656},
{1266.1936, 1484.69885, 16.77278, 266.791534423828}
}

local mainjobblip = nil
local jobblip = nil
local truck = nil
local trailer = nil
local route = 0
local coord = 0
local tempdist = 0
local state = 0
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if(not DoesBlipExist(mainjobblip)) then
			mainjobblip = AddBlipForCoord(-945.29657, 317.75858, 4.50798)
			ChangeBlipSprite(mainjobblip, 36)
			ChangeBlipColour(mainjobblip, 19)
			ChangeBlipNameFromAscii(mainjobblip, "Trucker")
			SetBlipAsShortRange(mainjobblip, true)
			ChangeBlipScale(mainjobblip, 0.7)
		end
		DrawCheckpointWithDist(-945.29657, 317.75858, 4.50798-1, 1.1, 255, 3, 30, 100)
		DrawTextAtCoord(-945.29657, 317.75858, 4.50798, "Trucker", 20)
		if(IsPlayerNearCoords(-945.29657, 317.75858, 4.50798, 1)) then
			if(level >= 3) then
				DrawDescription("Trucker", {
				-----------------------------------------------------------------------------------------------
				"Progress: " .. jobprogress.trucker .. "%",
				"Unlockable items:",
				"Trucks: Flatbed (50%), Phantom (100%)",
				"Trailers: Pipes (30%), Coal (60%), Tanker (90%)"
				})
				if(driverlicense == 1) then
					if(IsCarDead(truck)) then
						PrintText("Press ~y~E ~w~to start trucker job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							if(currjob == "") then
								local vehs = {
								{"Packer", 0, 569305213},
								{"Flatbed", 50, 1353720154},
								{"Phantom", 100, 2157618379}
								}
								local tempitems = {}
								for i=1,#vehs,1 do
									tempitems[i] = vehs[i][1]
								end
								DrawWindow("Select truck", tempitems)
								while menuactive do
									Wait(0)
								end
								if(menuresult > 0) then
									if(jobprogress.trucker >= vehs[menuresult][2]) then
										currjob = "Trucker"
										DeleteCar(truck)
										truck = SpawnCar(vehs[menuresult][3], -933.95203, 313.17361, 4.45451, 180.653274536133)
										for j=1,9,1 do
											TurnOffVehicleExtra(truck, j, true)
										end
										--AllowVeh(truck)
										WarpCharIntoCar(GetPlayerChar(-1), truck)
										local rnd = GenerateRandomIntInRange(1, #coords+1)
										coord = rnd
										jobblip = AddBlipForCoord(coords[rnd][1], coords[rnd][2], coords[rnd][3])
										SetRoute(jobblip, true)
										state = 0
										local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
										tempdist = GetDistanceBetweenCoords3d(px, py, pz, coords[rnd][1], coords[rnd][2], coords[rnd][3])
										Notify('Trucker job has been started.')
									else
										Notify("You must reach " .. vehs[menuresult][2] .. "% progress of this job to get access to this truck.")
									end
								end
							else
								Notify("You are currently working at another job. Finish it before starting this one.")
							end
						end
					else
						PrintText("Press ~y~E ~w~to finish trucker job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							currjob = ""
							RemoveBlip(jobblip)
							DeleteCar(truck)
							Notify('Trucker job has been finished.')
						end
					end
				else
					PrintText("You must have a driver license for this job", 1)
				end
			else
				PrintText("You must reach level 3 to start this job", 1)
			end
		end
		if(DoesVehicleExist(truck)) then
			if(not IsCarDead(truck)) then
				if(state==0 or (state==1 and DoesObjectExist(trailer))) then
					local bp = GetBlipCoords(jobblip)
					DrawCheckpoint(bp.x, bp.y, bp.z-1, 2.1, 255, 3, 30, 100)
					if(IsCharInCar(GetPlayerChar(-1), truck)) then
						if(state==0 or (state==1 and IsObjectAttached(trailer, truck))) then
							if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 3)) then
								if(state == 0) then
									PrintText("Press ~y~E ~w~to select a trailer", 1)
									if(IsGameKeyboardKeyJustPressed(18)) then
										local trailers = {
										{"Goods", 0, 500, GetHashKey("ec_trailer_frdg")},
										{"Pipes", 30, 1000, GetHashKey("ec_trailer_pipe")},
										{"Coal", 60, 2500, GetHashKey("ec_trailer_opntrlr")},
										{"Tanker", 90, 4000, GetHashKey("ec_trailer_ptank1")}
										}
										local tempitems = {}
										for i=1,#trailers,1 do
											tempitems[i] = trailers[i][1] .. " ~g~(" .. trailers[i][3] .. "$)"
										end
										DrawWindow("Select trailer", tempitems)
										while menuactive do
											Wait(0)
										end
										if(menuresult > 0) then
											if(jobprogress.trucker >= trailers[menuresult][2]) then
												if(inventory[34] >= trailers[menuresult][3]) then
													RemoveItem(34, trailers[menuresult][3])
													SaveStats()
													DeleteObject(trailer)
													local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
													trailer = SpawnObject(trailers[menuresult][4], px, py, pz, 0.0)
													if(menuresult == 2) then
														AttachObjectToCar(trailer, truck, 0, 0.0, -7.5, -1.3, 0, 0, 0)
													else
														AttachObjectToCar(trailer, truck, 0, 0.0, -6.0, 0.4, 0, 0, 0)
													end
													local rnd = GenerateRandomIntInRange(1, #coords+1)
													while rnd==coord do
														rnd = GenerateRandomIntInRange(1, #coords+1)
													end
													local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
													tempdist = tempdist + GetDistanceBetweenCoords3d(px, py, pz, coords[rnd][1], coords[rnd][2], coords[rnd][3])
													coord = rnd
													SetBlipCoordinates(jobblip, coords[rnd][1], coords[rnd][2], coords[rnd][3])
													SetRoute(jobblip, true)
													state = 1
												else
													Notify("You do not have enough money.")
												end
											else
												Notify("You must reach " .. trailers[menuresult][2] .. "% progress of this job to get access to this trailer.")
											end
										end
									end
								else
									local trailers = {
									{"Goods", 0, 500, GetHashKey("ec_trailer_frdg")},
									{"Pipes", 30, 1000, GetHashKey("ec_trailer_pipe")},
									{"Coal", 60, 2500, GetHashKey("ec_trailer_opntrlr")},
									{"Tanker", 90, 4000, GetHashKey("ec_trailer_ptank1")}
									}
									local finalcash = 0
									for i=1,#trailers,1 do
										if(GetObjectModel(trailer) == trailers[i][4]) then
											finalcash = finalcash + math.floor(trailers[i][3]*2)
											break
										end
									end
									finalcash = finalcash + math.floor(tempdist/7)
									AddItem(34, finalcash)
							
									SaveStats()
									if(jobprogress.trucker < 100) then
										jobprogress.trucker = jobprogress.trucker + 2
										SaveJobProgress()
									end
									Notify("Delivery completed. You have got " .. finalcash .. "$.")
									DeleteObject(trailer)
									local rnd = GenerateRandomIntInRange(1, #coords+1)
									while rnd==coord do
										rnd = GenerateRandomIntInRange(1, #coords+1)
									end
									coord = rnd
									SetBlipCoordinates(jobblip, coords[rnd][1], coords[rnd][2], coords[rnd][3])
									SetRoute(jobblip, true)
									state = 0
									local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
									tempdist = GetDistanceBetweenCoords3d(px, py, pz, coords[rnd][1], coords[rnd][2], coords[rnd][3])
								end
							end
						else
							PrintText("~r~Attach the trailer", 1)
						end
					end
					if(IsPlayerDead(GetPlayerId())) then
						RemoveBlip(jobblip)
						--DeleteEntity(truck)
					end
				else
					RemoveBlip(jobblip)
				end
			else
				RemoveBlip(jobblip)
				--DeleteEntity(truck)
			end
		end
	end
end)