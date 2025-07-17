local coords = {
{-268.66986, -411.92975, 8.7362, 214.640441894531},
{-398.98618, 216.0955, 13.83315, 196.889556884766},
{9.78403, 951.82117, 14.54633, 175.939865112305},
{-233.43568, 1507.82629, 19.9291, 271.642120361328},
{92.62018, 1062.75452, 14.56583, 88.4726028442383},
{542.10175, 1366.65796, 10.88941, 357.961700439453},
{744.29675, 1801.29163, 39.35607, 321.275512695313},
{1064.97729, 1640.8551, 14.7738, 134.876052856445},
{1342.41638, 917.21722, 13.68428, 107.645606994629},
{1074.74792, 747.79993, 33.96524, 249.725219726563},
{1873.14636, 598.104, 28.90936, 226.512954711914},
{1740.42139, 228.67261, 25.79242, 306.677581787109},
{1381.57458, 59.72301, 25.91077, 253.321975708008},
{1154.71204, -475.08459, 13.91663, 183.561492919922},
{780.08337, -487.01825, 7.50078, 297.765411376953},
{703.29736, 132.36282, 6.00239, 195.448181152344},
{-1238.10254, 230.71167, 4.4375, 81.0042495727539},
{-1356.17651, -244.75221, 2.92949, 202.85319519043},
{-1914.68262, -420.58801, 3.21411, 156.991653442383},
{-1953.5625, 114.51664, 7.57477, 346.830444335938},
{-1754.75806, 352.61554, 25.44915, 112.657135009766},
{-1628.43311, 728.44348, 28.31625, 57.95458984375},
{-1265.20752, 1367.46667, 21.92922, 191.254669189453},
{-836.62152, 1093.19641, 13.90846, 225.931732177734},
{-944.83716, 713.68317, 4.0794, 215.043319702148}
}

local mainjobblip = nil
local jobblip = nil
local garbagetruck = nil
local garbage = nil
local coord = 0
local tempdist = 0
CreateThread(function()
	while true do
		Wait(0)
		if(not DoesBlipExist(mainjobblip)) then
			mainjobblip = AddBlipForCoord(359.98627, -360.16705, 5.87929, _i)
			ChangeBlipSprite(mainjobblip, 58)
			ChangeBlipColour(mainjobblip, 2)
			--ChangeBlipScale(mainjobblip, 0.7)
			ChangeBlipScale(mainjobblip, 0.7)
			ChangeBlipNameFromAscii(mainjobblip, "Garbage trucker")
			SetBlipAsShortRange(mainjobblip, true)
		end
		DrawTextAtCoord(359.98627, -360.16705, 5.87929, "Garbage_trucker", 20)
		DrawCheckpointWithDist(359.98627, -360.16705, 5.87929-1, 1.1, 255, 3, 30, 100)
		if(IsPlayerNearCoords(359.98627, -360.16705, 5.87929, 0.5)) then
			if(level >= 1) then
				if(driverlicense == 1) then
					if(IsCarDead(garbagetruck)) then
						PrintText("Press ~y~E ~w~to start garbage trucker job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							if(currjob == "") then
								currjob = "Garbage trucker"
								DeleteCar(garbagetruck)
								garbagetruck = SpawnCar(1917016601, 361.71579, -371.71503, 4.67504, 179.423446655273) --trashmaster
								--AllowVeh(garbagetruck)
								WarpCharIntoCar(GetPlayerChar(-1), garbagetruck)
								coord = GenerateRandomIntInRange(1, #coords+1)
								DeleteObject(garbage)
								garbage = SpawnObject(91692745, coords[coord][1], coords[coord][2], coords[coord][3]-1, coords[coord][4]) --garbage
								jobblip = AddBlipForObject(garbage)
								SetRoute(jobblip)
								FreezeObjectPosition(garbage, true)
								local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
								tempdist = GetDistanceBetweenCoords3d(px, py, pz, coords[coord][1], coords[coord][2], coords[coord][3])
								Notify('Garbage trucker job has been started.')
							else
								Notify("You are currently working at another job. Finish it before starting this one.")
							end
						end
					else
						PrintText("Press ~y~E ~w~to finish garbage trucker job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							currjob = ""
							DeleteCar(garbagetruck)
							DeleteObject(garbage)
							RemoveBlip(jobblip)
							Notify('Garbage trucker job has been finished.')
						end
					end
				else
					PrintText("You must have a driver license for this job", 1)
				end
			else
				PrintText("You must reach level 1 to start this job", 1)
			end
		end
		if(DoesBlipExist(jobblip)) then
			if(not IsCarDead(garbagetruck)) then
				local ox,oy,oz = GetObjectCoordinates(garbage)
				if(not IsObjectAttached(garbage)) then
					if(IsPlayerNearCoords(ox, oy, oz, 2)) then
						PrintText("Press ~y~E ~w~to grab the garbage", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							PlayAnim("pickup_object", "pickup_low")
							AttachObjectToPed(garbage,GetPlayerChar(-1),1232,0.3,0.3,-0.02,0.04,-0.6,0.5,0)
						end
					end
				else
					if(IsCharTouchingVehicle(GetPlayerChar(-1), garbagetruck)) then
						PrintText("Press ~y~E ~w~to put garbage into the truck", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							PlayAnim("pickup_object", "putdown_med")
							local rnd = GenerateRandomIntInRange(1, #coords+1)
							while rnd==coord do
								rnd = GenerateRandomIntInRange(1, #coords+1)
							end
							coord = rnd
							DetachObject(garbage)
							SetObjectCoordinates(garbage, coords[coord][1], coords[coord][2], coords[coord][3]-1)
							SetObjectHeading(garbage, coords[coord][4])
							SetRoute(jobblip)
							local finalcash = math.floor(tempdist/10)
							AddItem(34, finalcash)
							
							SaveStats()
							Notify("+" .. finalcash .. "$", 3000)
							local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
							tempdist = GetDistanceBetweenCoords3d(px, py, pz, coords[coord][1], coords[coord][2], coords[coord][3])
						end
					end
				end
				if(IsPlayerDead(GetPlayerId())) then
					RemoveBlip(jobblip)
					--DeleteEntity(bus)
				end
			else
				RemoveBlip(jobblip)
				--DeleteEntity(bus)
			end
		end
	end
end)