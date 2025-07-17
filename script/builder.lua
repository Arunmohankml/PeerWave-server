local coords = {
{180.15674, -832.45862, 14.13651, 207.783386230469, 0},
{195.77803, -818.41998, 14.13651, 33.8094940185547, 0},
{207.67668, -843.0683, 14.13652, 300.756408691406, 0},
{221.24948, -818.31744, 14.13652, 300.105316162109, 0},
{228.93448, -830.79877, 14.13651, 299.095153808594, 0},
{189.09956, -850.09875, 14.13652, 35.4101867675781, 0}
}

local mainjobblip = nil
local jobblip = nil
local jobblip2 = nil
local brick = nil
local amount = 0
local coord = 0
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if(not DoesBlipExist(mainjobblip)) then
			mainjobblip = AddBlipForCoord(123.9094, -857.36517, 5.25695)
			ChangeBlipSprite(mainjobblip, 43)
			ChangeBlipScale(mainjobblip, 0.7)
			ChangeBlipNameFromAscii(mainjobblip, "Builder")
			SetBlipAsShortRange(mainjobblip, true)
		end
		DrawCheckpointWithDist(123.9094, -857.36517, 5.25695-1, 1.1, 255, 3, 30, 100)
		DrawTextAtCoord(123.9094, -857.36517, 5.25695, "Builder", 20)
		if(IsPlayerNearCoords(123.9094, -857.36517, 5.25695, 1)) then
			if(jobprogress.builder < 100) then
				DrawDescription("Builder", {
				-----------------------------------------------------------------------------------------------
				"Progress: " .. jobprogress.builder .. "%",
				"Job to unlock: Supplier"
				})
			else
				DrawDescription("Builder", {
				-----------------------------------------------------------------------------------------------
				"Progress: " .. jobprogress.builder .. "%",
				"Job unlocked: Supplier"
				})
			end
			if(not DoesBlipExist(jobblip)) then
				PrintText("Press ~y~E ~w~to start builder job", 1)
				if(IsGameKeyboardKeyJustPressed(18)) then
					if(currjob == "") then
						currjob = "Builder"
						jobblip2 = AddBlipForCoord(coords[1][1], coords[1][2], coords[1][3])
						ChangeBlipColour(jobblip2, 1)
						brick = SpawnObject(GetHashKey("cj_proc_brick"), coords[1][1], coords[1][2], coords[1][3]-1, coords[1][4])
						FreezeObjectPosition(brick, true)
						local rnd = GenerateRandomIntInRange(2, #coords+1)
						coord = rnd
						jobblip = AddBlipForCoord(coords[rnd][1], coords[rnd][2], coords[rnd][3])
						amount = 0
						Notify('Builder job has been started.')
					else
						Notify("You are currently working at another job. Finish it before starting this one.")
					end
				end
			else
				PrintText("Press ~y~E ~w~to finish builder job", 1)
				if(IsGameKeyboardKeyJustPressed(18)) then
					currjob = ""
					RemoveBlip(jobblip)
					RemoveBlip(jobblip2)
					DeleteObject(brick)
					Notify('Builder job has been finished.')
				end
			end
		end
		if(DoesBlipExist(jobblip)) then
			local bp = GetBlipCoords(jobblip)
			local bp2 = GetBlipCoords(jobblip2)
			DrawCheckpoint(bp.x, bp.y, bp.z-1, 1.1, 255, 3, 30, 100)
			DrawCheckpoint(bp2.x, bp2.y, bp2.z-1, 1.1, 255, 0, 0, 100)
			if(not IsObjectAttached(brick)) then
				if(IsPlayerNearCoords(bp2.x, bp2.y, bp2.z, 1)) then
					PrintText("Press ~y~E ~w~to pick up a brick", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						PlayAnim("pickup_object", "pickup_low")
						--AttachEntityToEntity(brick,GetPlayerChar(-1)Id(),GetPedBoneIndex(GetPlayerChar(-1)Id(), 0xDEAD),0.1,0,-0.05,0,0,0,0, false, false, false, 1, true)
						AttachObjectToPed(brick,GetPlayerChar(-1),1232,0.08, 0.09, -0.01, 1.44862327915529, -1.57079632679489, 0,0)
					end
				end
			else
				DrawCheckpoint(bp.x, bp.y, bp.z-1, 1.1, 255, 3, 30, 100)
				if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 1)) then
					PrintText("Press ~y~E ~w~to put the brick", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						PlayAnim("pickup_object", "pickup_low")
						DetachObject(brick)
						SetObjectCoordinates(brick, coords[1][1], coords[1][2], coords[1][3]-1)
						SetObjectHeading(brick, coords[1][4])
						amount = amount + 1
						if(amount == 5) then
							amount = 0
							local rnd = GenerateRandomIntInRange(2, #coords+1)
							while rnd==coord do
								rnd = GenerateRandomIntInRange(2, #coords+1)
							end
							coord = rnd
							SetBlipCoordinates(jobblip, coords[rnd][1], coords[rnd][2], coords[rnd][3])
							AddItem(34, 270)
							
							SaveStats()
							Notify("+270$")
							if(jobprogress.builder < 100) then
								jobprogress.builder = jobprogress.builder + 5
								SaveJobProgress()
							end
						end
					end
				end
			end
			if(IsPlayerDead(GetPlayerId())) then
				currjob = ""
				RemoveBlip(jobblip)
				RemoveBlip(jobblip2)
				DeleteObject(brick)
			end
		end
	end
end)