local coords = {
{758.828, -231.52516, 5.82376, 246.590454101563, 0},
{744.01154, -185.74016, 14.73803, 70.5762100219727, 0},
{729.7218, -235.62393, 9.88628, 245.133850097656, 0},
{716.11829, -273.45239, 9.87977, 238.198425292969, -425833340},
{678.90021, -328.31696, 9.87758, 335.385864257813, -1003789974},
{682.81818, -295.64868, 9.87722, 154.139114379883, -1003789974},
{695.68536, -266.48166, 9.88023, 168.083465576172, -425833340},
{711.18042, -239.38232, 9.87662, 255.577880859375, -425833340},
{720.32159, -215.69363, 9.89721, 243.186248779297, 0}
}

local mainjobblip = nil
local jobblip = nil
local crate = nil
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if(not DoesBlipExist(mainjobblip)) then
			mainjobblip = AddBlipForCoord(785.62482, -175.39842, 6.09623)
			ChangeBlipSprite(mainjobblip, 39)
			--ChangeBlipColour(mainjobblip, 1)
			ChangeBlipNameFromAscii(mainjobblip, "Loader")
			SetBlipAsShortRange(mainjobblip, true)
			ChangeBlipScale(mainjobblip, 0.7)
		end
		
		DrawTextAtCoord(785.62482, -175.39842, 6.09623, "Loader", 20)
		if(IsPlayerNearCoords(785.62482, -175.39842, 6.09623, 1)) then
			if(jobprogress.loader < 100) then
				DrawDescription("Loader", {
				-----------------------------------------------------------------------------------------------
				"Progress: " .. jobprogress.loader .. "%",
				"Job to unlock: Forklift loader"
				})
			else
				DrawDescription("Loader", {
				-----------------------------------------------------------------------------------------------
				"Progress: " .. jobprogress.loader .. "%",
				"Job unlocked: Forklift loader"
				})
			end
			if(not DoesBlipExist(jobblip)) then
				PrintText("Press ~y~E ~w~to start loader job", 1)
				if(IsGameKeyboardKeyJustPressed(18)) then
					if(currjob == "") then
						currjob = "Loader"
						local rnd = GenerateRandomIntInRange(2, #coords+1)
						jobblip = AddBlipForCoord(coords[rnd][1], coords[rnd][2], coords[rnd][3])
						crate = SpawnObject(2736900820, coords[rnd][1], coords[rnd][2], coords[rnd][3]-0.8, coords[rnd][4])
						FreezeObjectPosition(crate, true)
						Notify('Loader job has been started.')
					else
						Notify("You are currently working at another job. Finish it before starting this one.")
					end
				end
			else
				PrintText("Press ~y~E ~w~to finish loader job", 1)
				if(IsGameKeyboardKeyJustPressed(18)) then
					currjob = ""
					RemoveBlip(jobblip)
					DeleteObject(crate)
					Notify('Loader job has been finished.')
				end
			end
		end
		if(DoesBlipExist(jobblip)) then
			local bp = GetBlipCoords(jobblip)
			if(not IsObjectAttached(crate)) then
				--DrawCheckpoint(bp.x, bp.y, bp.z-1, 0.5, 255, 3, 30, 100)
				if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 1)) then
					PrintText("Press ~y~E ~w~to pick up a crate", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						PlayAnim("pickup_object", "pickup_low")
						AttachObjectToPed(crate,GetPlayerChar(-1),1232,0.21, -0.07, -0.01, 1.64060949687466, -1.54461638801498, 0,0)
						SetBlipCoordinates(jobblip, coords[1][1], coords[1][2], coords[1][3])
					end
				end
			else
				DrawCheckpoint(bp.x, bp.y, bp.z-1, 1.1, 255, 3, 30, 100)
				if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 1)) then
					PrintText("Press ~y~E ~w~to put the crate", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						PlayAnim("pickup_object", "pickup_low")
						local rnd = GenerateRandomIntInRange(2, #coords+1)
						SetBlipCoordinates(jobblip, coords[rnd][1], coords[rnd][2], coords[rnd][3])
						DetachObject(crate)
						SetObjectCoordinates(crate, coords[rnd][1], coords[rnd][2], coords[rnd][3]-0.8)
						SetObjectHeading(crate, coords[rnd][4])
						AddItem(34, 80)
							--money = money + 10
						SaveStats()
						Notify("+80$")
						if(jobprogress.loader < 100) then
							jobprogress.loader = jobprogress.loader + 1
							SaveJobProgress()
						end
					end
				end
			end
			if(IsPlayerDead(GetPlayerId())) then
				currjob = ""
				RemoveBlip(jobblip)
				DeleteObject(crate)
			end
		end
	end
end)