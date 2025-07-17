local show = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(IsPlayerNearCoords(-1327.85864, 1264.8678, 23.37515, 3.5)) then
			if(show == 0) then
				TriggerEvent("noticeme:Info", "Press E to to heal for 500.Rs")
				show = 1
			end
			if(IsGameKeyboardKeyJustPressed(18)) then --m
				if(inventory[34] > 5000) then
					SetPlayerControl(GetPlayerId(), false)
					SetCharCoordinatesNoOffset(GetPlayerChar(-1), -1348.79199, 1263.12439, 24.3005)
					SetCharHeading(32.6602478027344)
					RequestAnims("amb@wasted_b")
					while not HaveAnimsLoaded("amb@wasted_b") do Citizen.Wait(0) end
					TaskPlayAnimNonInterruptable(GetPlayerChar(-1), "idle_a", "amb@wasted_b", 9.9, 1, 0, 0, 0, -1)
					Citizen.Wait(10000)
					SetCharHealth(GetPlayerChar(-1), 300)
					SetPlayerControl(GetPlayerId(), true)
					ClearCharTasksImmediately(GetPlayerChar(-1))
					inventory[34] = inventory[34] - 5000
					SaveInventory()
					TriggerEvent("noticeme:Info", "-2000.Rs")
				else
					TriggerEvent("noticeme:Info", "You dont have enough money")
				end
			end
		else
			show = 0
		end
	end
end)

local burgershotcoords = {
	{-1007.28687, 1625.54504, 24.319, 0.0141445221379399, -1455049321},
	{-429.26251, 1195.4093, 13.05202, 271.072387695313, -1455049321},
	{-173.48801, 288.77267, 14.82508, 268.388519287109, -1455049321},
	{-616.34607, 135.0834, 4.81617, 180.562149047852, -1455049321},
	{-123.68917, 69.92794, 14.80807, 284.135955810547, -111107426},
	{1184.99438, 362.21744, 25.1083, 181.052612304688, -111107426},
	{1640.53381, 224.86064, 25.21699, 89.3413696289063, -1455049321},
	{884.86017, -485.32562, 15.88777, 181.32063293457, 1015898343},
	{449.71948, 1506.03284, 16.32071, 208.291732788086, -1455049321},
	{1110.00525, 1587.34778, 16.91251, 224.666229248047, -1455049321}
}

local shopamount = ""
local inputtext = 0
shopon = 0
local BurgershotBlips = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for i=1,#burgershotcoords,1 do
			if(not DoesBlipExist(BurgershotBlips[i])) then
				BurgershotBlips[i] = AddBlipForCoord(burgershotcoords[i][1], burgershotcoords[i][2], burgershotcoords[i][3])
				ChangeBlipSprite(BurgershotBlips[i], 21)
				ChangeBlipNameFromAscii(BurgershotBlips[i], "Burger Shot")
				SetBlipAsShortRange(BurgershotBlips[i], true)
				ChangeBlipScale(BurgershotBlips[i], 0.8)
			end
			Draw3dMark("blip", burgershotcoords[i][1], burgershotcoords[i][2], burgershotcoords[i][3], 4.0)
			if(IsPlayerNearCoords(burgershotcoords[i][1], burgershotcoords[i][2], burgershotcoords[i][3], 2.5)) then
				if(IsGameKeyboardKeyJustPressed(18)) then --m
					exports.store:Open()
				end
			end
		end
	end
end)

