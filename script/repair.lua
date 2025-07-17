local repaircoords = {
{1131.1084, 272.03482, 30.0131},
{-1149.05432, 1187.7428, 16.99879},
{-474.8555, 188.3725, 9.43135},
{-1449.42114, -347.49982, 2.49706},
{793.79102, 214.45442, 6.06472},
}
local repairblip = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for i=1,#repaircoords,1 do
			if(not DoesBlipExist(repairblip[i])) then
				repairblip[i] = AddBlipForCoord(repaircoords[i][1], repaircoords[i][2], repaircoords[i][3])
				ChangeBlipSprite(repairblip[i], 53)
				ChangeBlipNameFromAscii(repairblip[i], "Vehicle Repair")
				ChangeBlipScale(repairblip[i], 0.6)
				SetBlipAsShortRange(repairblip[i], true)
			end
			Draw3dMark("repair",repaircoords[i][1], repaircoords[i][2], repaircoords[i][3], 10)
			if(IsPlayerNearCoords(repaircoords[i][1],  repaircoords[i][2],  repaircoords[i][3], 5.0)) then
				if(IsCharInAnyCar(GetPlayerChar(-1))) then
					if(IsGameKeyboardKeyJustPressed(18)) then
						if(inventory[34] >= 8000) then
							SetPlayerControl(GetPlayerId(), false)
							Citizen.Wait(8000)
							TriggerEvent("noticeme:Info", "Vehicle repaired")
							FixCar(GetCarCharIsUsing(GetPlayerChar(-1)))
							SetPlayerControl(GetPlayerId(), true)
							RemoveItem(34, 200)
						else
							TriggerEvent("noticeme:Info", "You dont have enough money")
						end
					end
				end
			end
		end
	end
end)