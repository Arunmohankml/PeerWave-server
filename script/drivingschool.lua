local coords = {
{-537.97522, 275.73636, 6.71428, 14.5115060806274, 0},
{-513.02435, 480.03448, 6.66162, 359.683685302734, 0},
{-451.06464, 555.46429, 9.85812, 352.314605712891, 0},
{-465.81317, 746.4942, 9.94996, 87.1821670532227, 0},
{-544.57703, 824.32831, 9.6206, 358.882415771484, 0},
{-604.16718, 1014.30255, 9.94528, 88.5279693603516, 0},
{-642.48254, 1065.50293, 9.68207, 357.388427734375, 0},
{-597.81219, 1349.67419, 17.11755, 85.1071319580078, 0},
{-621.15204, 1214.86426, 6.04047, 269.022308349609, 0},
{-579.7251, 1205.27283, 10.30804, 173.643783569336, 0},
{-557.33606, 930.43085, 9.92318, 270.114562988281, 0},
{-46.07603, 946.6048, 14.76762, 358.069976806641, 0},
{-29.64537, 1164.62549, 14.82442, 268.163787841797, 0},
{120.39999, 1149.65149, 14.69641, 179.166595458984, 0},
{111.32926, 666.42023, 14.56905, 90.0235214233398, 0},
{37.05995, 660.41742, 14.64424, 177.808029174805, 0},
{27.55852, 624.21973, 14.65887, 88.5790100097656, 0},
{-52.51078, 608.84418, 14.7135, 179.843139648438, 0},
{-67.36914, 387.59854, 14.74588, 90.1599197387695, 0},
{-200.06967, 372.05173, 14.87345, 179.768676757813, 0},
{-222.73062, 270.11841, 14.81042, 88.7136306762695, 0},
{-407.14236, 273.55737, 12.91187, 91.0522537231445, 0}
}

local mainjobblip = nil
local jobblip = nil
local examcar = nil
local coord = 0
local speed = 0
CreateThread(function()
	while true do
		Wait(0)
		if(not DoesBlipExist(mainjobblip)) then
			mainjobblip = AddBlipForCoord(-406.60873, 282.16464, 13.24742)
			ChangeBlipSprite(mainjobblip, 79)
			--ChangeBlipScale(mainjobblip, 0.7)
			ChangeBlipColour(mainjobblip, 19)
			ChangeBlipNameFromAscii(mainjobblip, "Driving school")
			SetBlipAsShortRange(mainjobblip, true)
			ChangeBlipScale(mainjobblip, 0.7)
		end
		DrawCheckpointWithDist(-406.60873, 282.16464, 13.24742-1, 1.1, 255, 3, 30, 100)
		DrawTextAtCoord(-406.60873, 282.16464, 13.24742, "Driving_school", 20)
		if(IsPlayerNearCoords(-406.60873, 282.16464, 13.24742, 1)) then
			if(driverlicense == 0) then
				if(IsCarDead(examcar)) then
					PrintText("Press ~y~E ~w~to pass the driving exam for ~g~500$", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						if(inventory[34] >= 500) then
							DeleteCar(examcar)
							examcar = SpawnCar(GetHashKey("schafter"), -407.15509, 273.59308, 12.91035, 89.6531600952148)
							--AllowVeh(examcar)
							jobblip = AddBlipForCoord(coords[1][1], coords[1][2], coords[1][3])
							SetRoute(jobblip, true)
							coord = 1
							speed = 0
							Notify("Exam has been started. Get into an exam vehicle and follow the route.")
						else
							Notify("You do not have enough money.")
						end
					end
				end
			else
				PrintText("You already have a driver license", 1)
			end
		end
		if(DoesBlipExist(jobblip)) then
			if(DoesVehicleExist(examcar)) then
				if(not IsCarDead(examcar)) then
					local bp = GetBlipCoords(jobblip)
					DrawCheckpoint(bp.x, bp.y, bp.z-1, 2.1, 255, 3, 30, 100)
					if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 3)) then
						if(IsCharInCar(GetPlayerChar(-1), examcar)) then
							if(coord ~= #coords) then
								coord = coord + 1
								SetBlipCoordinates(jobblip, coords[coord][1], coords[coord][2], coords[coord][3])
								SetRoute(jobblip, true)
							else
								coord = 0
								RemoveBlip(jobblip)
								RemoveItem(34, 500)
								local damage = 1000-GetCarHealth(examcar)
								if(speed<100 and damage<100) then
									driverlicense = 1
									Notify("^2Driving exam has been passed successfully. Driver license acquired.")
								else
									Notify("^1Driving exam failed. Good luck next time.")
								end
								SaveStats()
								DeleteCar(examcar)
							end
						end
					end
					if(IsPlayerDead(GetPlayerId())) then
						RemoveBlip(jobblip)
						--DeleteEntity(examcar)
					end
				else
					RemoveBlip(jobblip)
					RemoveItem(34, 500)
					SaveStats()
					Notify("Exam vehicle destroyed. Driving exam failed.")
					DeleteCar(examcar)
				end
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if(IsCharInCar(GetPlayerChar(-1), examcar)) then
			if(GetCarSpeed(examcar)*3.6 > 90) then
				speed = speed + 1
				Wait(100)
			end
		end
	end
end)
CreateThread(function()
	while true do
		Wait(0)
		if(IsCharInCar(GetPlayerChar(-1), examcar)) then
			DrawRectLeftTopCenter(0.9, 0.85, 0.08, 0.04, 0, 0, 0, 100)
			if(speed < 100) then
				DrawRectLeftTopCenter(0.9, 0.85, 0.08/100*speed, 0.04, 255, 255, 0, 255)
			else
				DrawRectLeftTopCenter(0.9, 0.85, 0.08, 0.04, 191, 0, 255, 255)
			end
			SetTextScale(0.300000,  0.6000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			--SetTextFont(6)
			SetTextEdge(1, 0, 0, 0, 255)
			--SetTextWrap(0.0, 0.3)
			--SetTextCentre(1)
			SetTextRightJustify(1)
			SetTextWrap(0.0, 0.89)
			DisplayTextWithLiteralString(0.89, 0.85, "STRING", "Speeding")
			
			local damage = 1000-GetCarHealth(examcar)
			DrawRectLeftTopCenter(0.9, 0.9, 0.08, 0.04, 0, 0, 0, 100)
			if(damage < 100) then
				DrawRectLeftTopCenter(0.9, 0.9, 0.08/100*damage, 0.04, 255, 255, 0, 255)
			else
				DrawRectLeftTopCenter(0.9, 0.9, 0.08, 0.04, 191, 0, 255, 255)
			end
			SetTextScale(0.300000,  0.6000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			--SetTextFont(6)
			SetTextEdge(1, 0, 0, 0, 255)
			--SetTextWrap(0.0, 0.3)
			--SetTextCentre(1)
			SetTextRightJustify(1)
			SetTextWrap(0.0, 0.89)
			DisplayTextWithLiteralString(0.89, 0.9, "STRING", "Damage")
		end
	end
end)