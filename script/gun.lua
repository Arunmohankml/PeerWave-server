
local guncoords = {
{1067.31335, 87.11202, 34.25125, 178.692932128906},
{82.20334, -342.00589, 11.18179, 178.316635131836},
{-1333.16357, 318.77249, 14.62244, 276.131530761719}
}
local gunblip = {}
guns = {
{"Knife", 3, 500, 1},
{"Glock 17", 7, 5000, 17},
{"Micro Uzi", 12, 30000, 50},
{"MP5", 13, 40000, 30},
{"AK-47", 14, 50000, 30},
{"M4", 15, 70000, 30},
}

CompareTables = function(t1, t2)
	if(#t1 == #t2) then
		for i=1,#t1,1 do
			if(type(t1[i])=="table" and type(t2[i])=="table") then
				if(not CompareTables(t1[i], t2[i])) then
					return false
				end
			else
				if(t1[i] ~= t2[i]) then
					return false
				end
			end
		end
		return true
	else
		return false
	end
end

CreateThread(function()
	while true do
		Wait(0)
		for i=1,#guncoords,1 do
			if(not DoesBlipExist(gunblip[i])) then
				gunblip[i] = AddBlipForCoord(guncoords[i][1], guncoords[i][2], guncoords[i][3], _i)
				ChangeBlipSprite(gunblip[i], 59)
				ChangeBlipScale(gunblip[i], 0.7)
				ChangeBlipNameFromAscii(gunblip[i], "Gun shop")
				SetBlipAsShortRange(gunblip[i], true)
			end
			DrawCheckpointWithDist(guncoords[i][1], guncoords[i][2], guncoords[i][3]-1, 1.1, 255, 3, 30, 100)
			if(IsPlayerNearCoords(guncoords[i][1], guncoords[i][2], guncoords[i][3], 1)) then
				if(weaponlicense == 0) then
					PrintText("You do not have a weapon license. Press ~y~E ~w~to ~y~buy it ~w~for ~g~5000$", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						if(inventory[34] >= 5000) then
							RemoveItem(34, 500)
							weaponlicense = 1
							SaveStats()
							Notify("Weapon license purchased.")
						else
							Notify("You do not have enough money.")
						end
					end
				else
					PrintText("Press ~y~E ~w~to ~y~open gun shop menu", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						::again::
						local tempitems = {}
						tempitems[#tempitems+1] = "Medkit ~g~(300$)"
						tempitems[#tempitems+1] = "Weapon Clip ~g~(500$)"
						for i=1,#guns,1 do
							tempitems[#tempitems+1] = "" .. guns[i][1] .. " ~g~(" .. guns[i][3] .. "$)"
						end
						DrawWindow("Gun_shop", tempitems)
						while menuactive do
							Wait(0)
						end
						if(menuresult > 0) then
							if(tempitems[menuresult] == "Medkit ~g~(300$)") then
								if(inventory[34] >= 300) then
									AddItem(25, 1)
									RemoveItem(34, 300)
									SaveStats()
								else
									Notify('You do not have enough money.')
								end
							elseif(tempitems[menuresult] == "Weapon Clip ~g~(500$)") then
								if(inventory[34] >= 500) then
									AddItem(31, 1)
									RemoveItem(34, 500)
									SaveStats()
								else
									Notify('You do not have enough money.')
								end
							else
								for i=1,#guns,1 do
									if(tempitems[menuresult] == "" .. guns[i][1] .. " ~g~(" .. guns[i][3] .. "$)") then
										if(inventory[34] >= guns[i][3]) then
											RemoveItem(34, guns[i][3])
											SaveStats()
											GiveWeaponToChar(GetPlayerChar(-1), guns[i][2], guns[i][4], 1)
										else
											Notify('You do not have enough money.')
										end
									end
								end
							end
							goto again
						end
					end
				end
			end
		end
	end
end)


illegals = {
	{"Micro Uzi", 12, 15000, 50},
	{"Special Carbine", 13, 30000, 30},
	{"AK-47", 14, 20000, 30},
	{"Carbine Rifile", 15, 25000, 30},
}

CreateThread(function()
	while true do
		Wait(0)
		if(IsCop(-1) == false and IsEms(-1) == false) then
			if(not DoesBlipExist(illegalblip)) then
				illegalblip = AddBlipForCoord(-1260.72534, 1885.58142, 12.00682)
				ChangeBlipSprite(illegalblip, 59)
				ChangeBlipScale(illegalblip, 0.7)
				ChangeBlipNameFromAscii(illegalblip, "Illegal shop")
				SetBlipAsShortRange(illegalblip, true)
			end
			DrawCheckpointWithDist(-1260.72534, 1885.58142, 12.00682-1, 1.1, 255, 3, 30, 100)
			
			if(IsPlayerNearCoords(-1260.72534, 1885.58142, 12.00682, 1)) then
				PrintText("Press ~y~E ~w~to ~y~open illegal shop menu", 1)
				if(IsGameKeyboardKeyJustPressed(18)) then
					::again::
					local tempitems = {}
					tempitems[#tempitems+1] = "Cocaine ~g~(1000$)"
					tempitems[#tempitems+1] = "Weed ~g~(1000$)"
					for i=1,#illegals,1 do
						tempitems[#tempitems+1] = "" .. illegals[i][1] .. " ~g~(" .. illegals[i][3] .. "$)"
					end
					DrawWindow("Gun_shop", tempitems)
					while menuactive do
						Wait(0)
					end
					if(menuresult > 0) then
						if(tempitems[menuresult] == "Cocaine ~g~(1000$)") then
							if(inventory[34] >= 1000) then
								AddItem(33, 1)
								RemoveItem(34, 1000)
								SaveStats()
							else
								Notify('You do not have enough money.')
							end
						elseif(tempitems[menuresult] == "Weed ~g~(1000$)") then
							if(inventory[34] >= 1000) then
								AddItem(32, 1)
								RemoveItem(34, 1000)
								SaveStats()
							else
								Notify('You do not have enough money.')
							end
						else
							for i=1,#illegals,1 do
								if(tempitems[menuresult] == "" .. illegals[i][1] .. " ~g~(" .. illegals[i][3] .. "$)") then
									if(inventory[34] >= illegals[i][3]) then
										RemoveItem(34, illegals[i][3])
										SaveStats()
										GiveWeaponToChar(GetPlayerChar(-1), illegals[i][2], illegals[i][4], 1)
									else
										Notify('You do not have enough money.')
									end
								end
							end
						end
						goto again
					end
				end
			end
		else
			if(DoesBlipExist(illegalblip)) then
				RemoveBlip(illegalblip)
			end
		end
	end
end)