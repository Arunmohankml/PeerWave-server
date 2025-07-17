currtuning = {}
for i=1,#cars,1 do
	currtuning[i] = {}
	for j=1,24,1 do
		currtuning[i][j] = 0
	end
end
rgb = {}
for i=1,3,1 do
	rgb[i] = 0
end

RegisterNetEvent('updTuning')
AddEventHandler('updTuning', function(data)
	for i=1,#data,1 do
		for j=1,#data[i],1 do
			currtuning[i][j] = tonumber(data[i][j])
		end
	end
end)

SaveTuning = function()
	local data = {}
	for i=1,#cars,1 do
		data[i] = {}
		for j=1,#currtuning[i],1 do
			data[i][j] = currtuning[i][j]
		end
	end
	TriggerServerEvent('saveTuning', data)
end

SetVehicleTuning = function(veh)
	SetCarLivery(veh, 0)
	local tempcar = 0
	if(veh == car) then
		for j=1,#carinfo,1 do
			--if(GetCarModel(veh) == carinfo[j][3]) then
			if(IsCarModel(veh, carinfo[j][3])) then
				tempcar = j
			end
		end
	end
	if(tempcar > 0) then
		ChangeCarColour(veh, currtuning[tempcar][1], currtuning[tempcar][2])
		SetExtraCarColours(veh, currtuning[tempcar][3], currtuning[tempcar][4])
		for j=1,9,1 do
			if(currtuning[tempcar][j+4] == 0) then
				TurnOffVehicleExtra(veh, j, true)
			else
				TurnOffVehicleExtra(veh, j, false)
			end
		end
	end
end

local tuningcoords = {
{876.49695, -115.73891, 6.02284, 154.089828491211, -2012314136},
{711.28668, 1506.01782, 14.84259, 179.616546630859, 0}
}
local tuningblip = {}
local biznames = {
"Brucie's Executive Lifestyle Autos",
"Muscle Mary's"
}
CreateThread(function()
	while true do
		Wait(0)
		for i=1,#tuningcoords,1 do
			if(not DoesBlipExist(tuningblip[i])) then
				tuningblip[i] = AddBlipForCoord(tuningcoords[i][1], tuningcoords[i][2], tuningcoords[i][3])
				ChangeBlipSprite(tuningblip[i], 75)
				ChangeBlipScale(tuningblip[i], 0.7)
				ChangeBlipNameFromAscii(tuningblip[i], "Tuning shop")
				--ChangeBlipColour(tuningblip[i], 19)
				SetBlipAsShortRange(tuningblip[i], true)
			end
			DrawTextAtCoord(tuningcoords[i][1], tuningcoords[i][2], tuningcoords[i][3], "Tuning_shop", 20)
			DrawCheckpointWithDist(tuningcoords[i][1], tuningcoords[i][2], tuningcoords[i][3]-1, 1.1, 255, 3, 30, 100)
			if(IsPlayerNearCoords(tuningcoords[i][1], tuningcoords[i][2], tuningcoords[i][3], 10)) then
				if(IsCharInAnyCar(GetPlayerChar(-1))) then
					if(GetDriverOfCar(GetCarCharIsUsing(GetPlayerChar(-1), _i), _i) == GetPlayerChar(-1)) then
						PrintStringWithLiteralStringNow("STRING", "Press ~y~E ~w~to ~y~enter repair shop", 1000, 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							SetPlayerControl(GetPlayerId(), false)
							local veh = GetCarCharIsUsing(GetPlayerChar(-1))
							--AttachCarToCarPhysically(GetCarCharIsUsing(GetPlayerChar(-1), _i), GetCarCharIsUsing(GetPlayerChar(-1), _i), true, 1, 0, 0, 0, 0, 0, 0, 0, 0)
							SetCarCoordinates(veh, tuningcoords[i][1], tuningcoords[i][2], tuningcoords[i][3]-1)
							SetCarHeading(veh, tuningcoords[i][4])
							SetCarOnGroundProperly(veh)
							FreezeCarPosition(veh, true)
							::main::
							local tempitems = {}
							local cleanprice = math.floor(GetVehicleDirtLevel(veh))
							tempitems[#tempitems+1] = "Clean ~g~(" .. cleanprice .. "$)"
							local repairprice = math.floor((1000-GetCarHealth(veh))/10)
							tempitems[#tempitems+1] = "Repair ~g~(" .. repairprice .. "$)"
							tempitems[#tempitems+1] = "Customize"
							tempitems[#tempitems+1] = "Upgrade"
							DrawWindow("Tuning shop", tempitems)
							while menuactive do
								Wait(0)
								if(IsMouseButtonPressed(1)) then
									SetCamActive(GetGameCam(), true)
								else
									SetCamActive(GetGameCam(), false)
								end
							end
							if(menuresult > 0) then
								if(tempitems[menuresult] == "Clean ~g~(" .. cleanprice .. "$)") then
									if(cleanprice > 0) then
										if(inventory[34] >= cleanprice) then
											RemoveItem(34, cleanprice)
											SaveStats()
											SetVehicleDirtLevel(veh, 0.0)
											Notify('Vehicle cleaned.')
											AddIncomeToBiz(biznames[i], cleanprice)
										else
											Notify('You do not have enough money.')
										end
									else
										Notify("This vehicle does not require cleaning.")
									end
									goto main
								elseif(tempitems[menuresult] == "Repair ~g~(" .. repairprice .. "$)") then
									if(repairprice > 0) then
										if(inventory[34] >= repairprice) then
											RemoveItem(34, repairprice)
											SaveStats()
											FixCar(GetCarCharIsUsing(GetPlayerChar(-1), _i))
											Notify("Vehicle repaired.")
											AddIncomeToBiz(biznames[i], repairprice)
										else
											Notify("You do not have enough money.")
										end
									else
										Notify("This vehicle does not require repairing.")
									end
									goto main
								elseif(tempitems[menuresult] == "Customize") then
									if(veh == car) then
										local tempcar = 0
										for j=1,#carinfo,1 do
											--if(GetCarModel(car, _i) == carmodels[j]) then
											if(IsCarModel(car, carinfo[j][3])) then
												tempcar = j
											end
										end
										c = {}
										for j=1,4,1 do
											c[j] = currtuning[tempcar][j]
										end
										for j=1,3,1 do
											rgb[j] = currtuning[tempcar][13+j]
										end
										::customize::
										local amount = 0
										for j=1,4,1 do
											if(currtuning[tempcar][j] ~= c[j]) then
												amount = amount + 500
											end
										end
										for j=1,9,1 do
											if(IsVehicleExtraTurnedOn(GetCarCharIsUsing(GetPlayerChar(-1), _i), j)) then
												if(currtuning[tempcar][j+4] ~= 1) then
													amount = amount + 1000
												end
											else
												if(currtuning[tempcar][j+4] ~= 0) then
													amount = amount + 1000
												end
											end
										end
										for j=1,3,1 do
											if(currtuning[tempcar][13+j] ~= rgb[j]) then
												amount = amount + 300
											end
										end
										local finalprice = amount
										local tempitems = {}
										tempitems[#tempitems+1] = "Purchase ~g~(" .. finalprice .. "$)"
										tempitems[#tempitems+1] = "Color"
										tempitems[#tempitems+1] = "Extras"
										tempitems[#tempitems+1] = "Neon"
										DrawWindow("Customize", tempitems)
										while menuactive do
											Wait(0)
											if(IsMouseButtonPressed(1)) then
												SetCamActive(GetGameCam(), true)
											else
												SetCamActive(GetGameCam(), false)
											end
										end
										if(menuresult > 0) then
											if(tempitems[menuresult] == "Purchase ~g~(" .. finalprice .. "$)") then
												if(inventory[34] >= finalprice) then
													RemoveItem(34, finalprice)
													SaveStats()
													
													for j=1,4,1 do
														currtuning[tempcar][j] = c[j]
													end
													for j=1,9,1 do
														if(IsVehicleExtraTurnedOn(GetCarCharIsUsing(GetPlayerChar(-1), _i), j)) then
															currtuning[tempcar][j+4] = 1
														else
															currtuning[tempcar][j+4] = 0
														end
													end
													for j=1,3,1 do
														currtuning[tempcar][13+j] = rgb[j]
													end
													SaveTuning()
														
													Notify("Purchase is successful.")
													AddIncomeToBiz(biznames[i], finalprice)
												else
													Notify("You do not have enough money.")
												end
												goto customize
											elseif(tempitems[menuresult] == "Color") then
												::color::
												local tempitems = {}
												tempitems[#tempitems+1] = "Color 1"
												tempitems[#tempitems+1] = "Color 2"
												tempitems[#tempitems+1] = "Color 3"
												tempitems[#tempitems+1] = "Color 4"
												DrawWindow("Customize", tempitems)
												while menuactive do
													Wait(0)
													if(IsMouseButtonPressed(1)) then
														SetCamActive(GetGameCam(), true)
													else
														SetCamActive(GetGameCam(), false)
													end
												end
												if(menuresult > 0) then
													for j=1,4,1 do
														if(tempitems[menuresult] == "Color " .. j) then
															::colorswitch::
															local colors = {
															{10, 10, 10}, --0
															{37, 37, 37}, --1
															{101, 106, 121}, --2
															{88, 89, 90}, --3
															{156, 161, 163}, --4
															{150, 145, 140}, --5
															{81, 84, 89}, --6
															{63, 62, 69}, --7
															{165, 169, 167}, --8
															{151, 149, 146}, --9
															{118, 123, 124}, --10
															{90, 87, 82}, --11
															{173, 176, 176}, --12
															{132, 137, 136}, --13
															{148, 157, 159}, --14
															{164, 167, 165}, --15
															{88, 88, 83}, --16
															{164, 160, 150}, --17
															{175, 177, 177}, --18
															{109, 108, 110}, --19
															{100, 104, 106}, --20
															{82, 86, 97}, --21
															{140, 146, 154}, --22
															{91, 93, 94}, --23
															{189, 190, 198}, --24
															{182, 182, 182}, --25
															{100, 100, 100}, --26
															{226, 6, 6}, --27
															{150, 8, 0}, --28
															{107, 0, 0}, --29
															{97, 16, 9}, --30
															{74, 10, 10}, --31
															{115, 11, 11}, --32
															{87, 7, 7}, --33
															{38, 3, 6}, --34
															{158, 0, 0}, --35
															{20, 0, 2}, --36
															{15, 4, 4}, --37
															{15, 8, 10}, --38
															{57, 25, 29}, --39
															{85, 39, 37}, --40
															{76, 41, 41}, --41
															{116, 29, 40}, --42
															{109, 40, 55}, --43
															{115, 10, 39}, --44
															{100, 13, 27}, --45
															{98, 11, 28}, --46
															{115, 24, 39}, --47
															{171, 152, 143}, --48
															{32, 32, 44}, --49
															{68, 98, 79}, --50
															{46, 91, 32}, --51
															{30, 46, 50}, --52
															{48, 79, 69}, --53
															{77, 98, 104}, --54
															{94, 112, 114}, --55
															{25, 56, 38}, --56
															{45, 58, 53}, --57
															{51, 95, 63}, --58
															{71, 120, 60}, --59
															{147, 163, 150}, --60
															{154, 167, 144}, --61
															{38, 55, 57}, --62
															{76, 117, 183}, --63
															{70, 89, 122}, --64
															{93, 126, 141}, --65
															{59, 78, 120}, --66
															{61, 74, 104}, --67
															{109, 122, 136}, --68
															{22, 34, 72}, --69
															{39, 47, 75}, --70
															{78, 104, 129}, --71
															{106, 122, 140}, --72
															{111, 130, 151}, --73
															{14, 49, 109}, --74
															{57, 90, 131}, --75
															{32, 75, 107}, --76
															{43, 62, 87}, --77
															{54, 65, 85}, --78
															{108, 132, 149}, --79
															{77, 93, 96}, --80
															{64, 108, 143}, --81
															{19, 69, 115}, --82
															{16, 80, 130}, --83
															{56, 86, 148}, --84
															{0, 28, 50}, --85
															{89, 110, 135}, --86
															{34, 52, 87}, --87
															{32, 32, 44}, --88
															{245, 137, 15}, --89
															{145, 115, 71}, --90
															{142, 140, 70}, --91
															{170, 173, 142}, --92
															{174, 155, 127}, --93
															{150, 129, 108}, --94
															{122, 117, 96}, --95
															{157, 152, 114}, --96
															{152, 149, 134}, --97
															{156, 141, 113}, --98
															{105, 30, 59}, --99
															{114, 42, 63}, --100
															{124, 27, 68}, --101
															{34, 25, 24}, --102
															{127, 105, 86}, --103
															{71, 53, 50}, --104
															{105, 88, 83}, --105
															{98, 68, 40}, --106
															{125, 98, 86}, --107
															{170, 157, 132}, --108
															{123, 113, 94}, --109
															{171, 146, 118}, --110
															{99, 82, 90}, --111
															{201, 201, 201}, --112
															{214, 218, 214}, --113
															{159, 157, 148}, --114
															{147, 163, 150}, --115
															{156, 156, 152}, --116
															{167, 162, 143}, --117
															{15, 106, 137}, --118
															{161, 153, 131}, --119
															{163, 173, 198}, --120
															{155, 139, 128}, --121
															{132, 148, 171}, --122
															{158, 164, 171}, --123
															{134, 68, 110}, --124
															{226, 6, 6}, --125
															{71, 120, 60}, --126
															{215, 142, 16}, --127
															{42, 119, 161}, --128
															{66, 31, 33}, --129
															{111, 103, 95}, --130
															{252, 38, 0}, --131
															{252, 109, 0}, --132
															{255, 255, 255} --133
															}
															local tempitems = {}
															for k=0,133,1 do
																tempitems[#tempitems+1] = k
															end
															DrawWindow("Color_" .. j, tempitems, colors)
															while menuactive do
																Wait(0)
																if(IsMouseButtonPressed(1)) then
																	SetCamActive(GetGameCam(), true)
																else
																	SetCamActive(GetGameCam(), false)
																end
															end
															if(menuresult > 0) then
																c[j] = menuresult-1
																ChangeCarColour(GetCarCharIsUsing(GetPlayerChar(-1), _i), c[1], c[2])
																SetExtraCarColours(GetCarCharIsUsing(GetPlayerChar(-1), _i), c[3], c[4])
																goto colorswitch
															else
																goto color
															end
														end
													end
												else
													goto customize
												end
											elseif(tempitems[menuresult] == "Extras") then
												::extras::
												local tempitems = {}
												for j=1,9,1 do
													if(IsVehicleExtraTurnedOn(GetCarCharIsUsing(GetPlayerChar(-1), _i), j)) then
														tempitems[#tempitems+1] = "Extra_" .. j .. ":_1"
													else
														tempitems[#tempitems+1] = "Extra_" .. j .. ":_0"
													end
												end
												DrawWindow("Extras", tempitems)
												while menuactive do
													Wait(0)
													if(IsMouseButtonPressed(1)) then
														SetCamActive(GetGameCam(), true)
													else
														SetCamActive(GetGameCam(), false)
													end
												end
												if(menuresult > 0) then
													for j=1,9,1 do
														if(tempitems[menuresult] == "Extra_" .. j .. ":_1") then
															TurnOffVehicleExtra(GetCarCharIsUsing(GetPlayerChar(-1), _i), j, true)
														elseif(tempitems[menuresult] == "Extra_" .. j .. ":_0") then
															TurnOffVehicleExtra(GetCarCharIsUsing(GetPlayerChar(-1), _i), j, false)
														end
													end
													goto extras
												else
													goto customize
												end
											elseif(tempitems[menuresult] == "Neon") then
												::neon::
												local tempitems = {}
												tempitems[#tempitems+1] = "Red"
												tempitems[#tempitems+1] = "Green"
												tempitems[#tempitems+1] = "Blue"
												DrawWindow("Neon", tempitems)
												while menuactive do
													Wait(0)
													if(IsMouseButtonPressed(1)) then
														SetCamActive(GetGameCam(), true)
													else
														SetCamActive(GetGameCam(), false)
													end
													local cx,cy,cz = GetCarCoordinates(GetCarCharIsUsing(GetPlayerChar(-1), _i), _f, _f, _f)
													DrawLightWithRange(cx, cy, cz, rgb[1], rgb[2], rgb[3], 9.9, 10.1)
												end
												if(menuresult > 0) then
													local tempitem = {menuresult, tempitems[menuresult]}
													::neonswitch::
													local tempitems = {}
													for j=0,255,1 do
														tempitems[#tempitems+1] = j
													end
													DrawWindow("" .. tempitem[2], tempitems)
													while menuactive do
														Wait(0)
														if(IsMouseButtonPressed(1)) then
															SetCamActive(GetGameCam(), true)
														else
															SetCamActive(GetGameCam(), false)
														end
														local cx,cy,cz = GetCarCoordinates(GetCarCharIsUsing(GetPlayerChar(-1), _i), _f, _f, _f)
														DrawLightWithRange(cx, cy, cz, rgb[1], rgb[2], rgb[3], 9.9, 10.1)
													end
													if(menuresult > 0) then
														rgb[tempitem[1]] = menuresult-1
														goto neonswitch
													else
														goto neon
													end
												else
													goto customize
												end
											end
										else
											goto main
										end
									else
										Notify("This is not your vehicle.")
										goto main
									end
								elseif(tempitems[menuresult] == "Upgrade") then
									if(GetCarCharIsUsing(GetPlayerChar(-1), _i) == car) then
										local tempcar = 0
										for j=1,#carinfo,1 do
											--if(GetCarModel(car, _i) == carmodels[j]) then
											if(IsCarModel(car, carinfo[j][3])) then
												tempcar = j
											end
										end
										local tempprices = {
										{5000, 7000, 10000},
										{6000, 10000, 13000},
										{3000, 5000, 7000},
										10000,
										--20000,
										--15000,
										--10000,
										{4000, 8000, 11000}
										}
										if(biz[3]==1 and biz[4]==1) then
											for j=1,#tempprices,1 do
												if(type(tempprices[j]) == "table") then
													for k=1,3,1 do
														tempprices[j][k] = math.floor(tempprices[j][k]*0.75)
													end
												else
													tempprices[j] = math.floor(tempprices[j]*0.75)
												end
											end
										end
										::upgrades::
										local tempupg = {}
										for j=1,#tempprices,1 do
											if(type(tempprices[j]) == "table") then
											--if(j <= 3) then
												if(currtuning[tempcar][16+j] ~= 3) then
													tempupg[j] = "" .. currtuning[tempcar][16+j] .. " -> " .. currtuning[tempcar][16+j]+1 .. " ~g~(" .. tempprices[j][currtuning[tempcar][16+j]+1] .. "$)"
												else
													tempupg[j] = "3 (MAX)"
												end
											else
												if(currtuning[tempcar][16+j] == 0) then
													tempupg[j] = "~g~" .. tempprices[j] .. "$"
												else
													tempupg[j] = "OK"
												end
											end
										end
										local tempitems = {}
										tempitems[#tempitems+1] = "Engine: " .. tempupg[1]
										tempitems[#tempitems+1] = "Nitro: " .. tempupg[2]
										tempitems[#tempitems+1] = "Brakes: " .. tempupg[3]
										tempitems[#tempitems+1] = "Hydraulics: " .. tempupg[4]
										--tempitems[#tempitems+1] = "Armor: " .. tempupg[5]
										--tempitems[#tempitems+1] = "Bullet-proof tires: " .. tempupg[6]
										--tempitems[#tempitems+1] = "Fire protection: " .. tempupg[7]
										tempitems[#tempitems+1] = "Downforce: " .. tempupg[5]
										DrawWindow("Upgrade", tempitems)
										while menuactive do
											Wait(0)
											if(IsMouseButtonPressed(1)) then
												SetCamActive(GetGameCam(), true)
											else
												SetCamActive(GetGameCam(), false)
											end
										end
										if(menuresult > 0) then
											if(menuresult <= 3 or menuresult==5) then
												if(currtuning[tempcar][16+menuresult] < 3) then
													if(inventory[34] >= tempprices[menuresult][currtuning[tempcar][16+menuresult]+1]) then
														RemoveItem(34, tempprices[menuresult][currtuning[tempcar][16+menuresult]+1])
														SaveStats()
														currtuning[tempcar][16+menuresult] = currtuning[tempcar][16+menuresult] + 1
														SaveTuning()
														Notify('Upgrade installed.')
													else
														Notify('You do not have enough money.')
													end
												else
													Notify('Max level reached.')
												end
											else
												if(currtuning[tempcar][16+menuresult] == 0) then
													if(inventory[34] >= tempprices[menuresult]) then
														RemoveItem(34, tempprices[menuresult])
														SaveStats()
														currtuning[tempcar][16+menuresult] = 1
														SaveTuning()
														Notify('Upgrade installed.')
													else
														Notify('You do not have enough money.')
													end
												else
													Notify('Already installed.')
												end
											end
											goto upgrades
										else
											goto main
										end
									else
										Notify("This is not your vehicle.")
										goto main
									end
								elseif(tempitems[menuresult] == "Buy repair kit ~g~(200$)") then
									if(inv[7] < 10) then
										if(inventory[34] >= 200) then
											RemoveItem(34, 200)
											SaveStats()
											inv[7] = inv[7] + 1
											SaveInv()
											TriggerEvent('Notify', '[Repair shop]', {0, 255, 0}, 'Repair kit purchased')
										else
											TriggerEvent('Notify', '[Repair shop]', {255, 0, 0}, 'You do not have enough money!')
										end
									else
										TriggerEvent('Notify', '[Repair shop]', {255, 0, 0}, 'Maximum amount reached!')
									end
									goto main
								end
							else
								if(IsCharInAnyCar(GetPlayerChar(-1))) then
									SetVehicleTuning(veh)
									--DetachCar(GetCarCharIsUsing(GetPlayerChar(-1), _i))
									FreezeCarPosition(veh, false)
									SetPlayerControl(GetPlayerId(), true)
									SetCamActive(GetGameCam(), true)
								end
							end
						end
					end
				end
			end
		end
	end
end)

local tempcar = 0
CreateThread(function()
	while true do
		Wait(0)
		if(not IsCarDead(car)) then
			for j=1,#carinfo,1 do
				--if(GetCarModel(car, _i) == carmodels[j]) then
				if(IsCarModel(car, carinfo[j][3])) then
					tempcar = j
				end
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if(not IsCarDead(car)) then
			if(tempcar > 0) then
				if(tuning==nil or tuning==0) then
					local cx,cy,cz = GetCarCoordinates(car)
					if(IsPlayerNearCoords(cx, cy, cz, 50)) then
						if(currtuning[tempcar][14]~=0 or currtuning[tempcar][15]~=0 or currtuning[tempcar][16]~=0) then
							DrawLightWithRange(cx, cy, cz, currtuning[tempcar][14], currtuning[tempcar][15], currtuning[tempcar][16], 9.9, 10.1)
						end
					end
				end
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if(tempcar > 0) then
			if(not IsPlayerDead(GetPlayerId())) then
				if(IsCharInAnyCar(GetPlayerChar(-1))) then
					if(GetCarCharIsUsing(GetPlayerChar(-1), _i) == car) then
						--if(GetCarModel(GetCarCharIsUsing(GetPlayerChar(-1), _i), _i) == carmodels[tempcar]) then
							if(currtuning[tempcar][17] > 0) then
								if(IsGameKeyboardKeyPressed(17)) then --w
									local tempspeed = GetCarSpeed(GetCarCharIsUsing(GetPlayerChar(-1), _i), _f)
									ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,(tempspeed/1000)*(1.0+0.01*currtuning[tempcar][17]),0,0,0,0,1,1,1,1)
								end
							end
							if(currtuning[tempcar][24] > 0) then
								if(GetCarSpeed(car) > 5) then
									if(IsCarInAirProper(car)) then
										ApplyForceToCar(car,1,0,0,-0.1*currtuning[tempcar][24],0,0,0,1,1,1,1)
									end
								end
							end
						--end
					end
				end
			end
		end
	end
end)

local nitrobar = 0
CreateThread(function()
	while true do
		Wait(0)
		if(tempcar > 0) then
			if(not IsPlayerDead(GetPlayerId())) then
				if(IsCharInAnyCar(GetPlayerChar(-1))) then
					if(GetCarCharIsUsing(GetPlayerChar(-1), _i) == car) then
						if(GetDriverOfCar(GetCarCharIsUsing(GetPlayerChar(-1))) == GetPlayerChar(-1)) then
							--if(GetCarModel(GetCarCharIsUsing(GetPlayerChar(-1), _i), _i) == carmodels[tempcar]) then
								if(currtuning[tempcar][18] > 0) then
									if(IsPlayerControlOn(GetPlayerId())) then
										if(nitrobar < 30*currtuning[tempcar][18]) then
											Wait(100)
											nitrobar = nitrobar + 1
										else
											if(IsGameKeyboardKeyJustPressed(42)) then --left shift
												for i=30*currtuning[tempcar][18],0,-1 do
													nitrobar = nitrobar - 1
													ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0.3,0,0,0,0,1,1,1,1)
													PlaySoundFromVehicle(-1, "VEHICLES_EXTRAS_RIG_HAND_BRAKE", GetCarCharIsUsing(GetPlayerChar(-1), _i))
													Wait(1)
												end
											end
										end
									end
								end
							--end
						end
					end
				end
			end
		end
	end
end)
CreateThread(function()
	while true do
		Wait(0)
		if(tempcar > 0) then
			if(not IsPlayerDead(GetPlayerId())) then
				if(IsCharInAnyCar(GetPlayerChar(-1))) then
					if(GetCarCharIsUsing(GetPlayerChar(-1), _i) == car) then
						if(GetDriverOfCar(GetCarCharIsUsing(GetPlayerChar(-1))) == GetPlayerChar(-1)) then
							--if(GetCarModel(GetCarCharIsUsing(GetPlayerChar(-1), _i), _i) == carmodels[tempcar]) then
								if(currtuning[tempcar][18] > 0) then
									if(IsPlayerControlOn(GetPlayerId())) then
										SetTextScale(0.1500000,  0.3000000)
										SetTextDropshadow(0, 0, 0, 0, 0)
										SetTextFont(6)
										SetTextEdge(1, 0, 0, 0, 255)
										SetTextWrap(0.0, 0.3)
										SetTextCentre(1)
										DisplayTextWithLiteralString(0.3, 0.97, "STRING", "Nitro_(Shift)")
										
										DrawRect(0.35+0.13/2, 0.98, 0.13, 0.01, 90, 90, 90, 100)
										DrawRect(0.35+(((0.13/(30*currtuning[tempcar][18]))*nitrobar)/2), 0.98, (0.13/(30*currtuning[tempcar][18]))*nitrobar, 0.01, 255, 255, 0, 255)
									end
								end
							--end
						end
					end
				end
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if(tempcar > 0) then
			if(not IsPlayerDead(GetPlayerId())) then
				if(IsCharInAnyCar(GetPlayerChar(-1))) then
					if(GetCarCharIsUsing(GetPlayerChar(-1), _i) == car) then
						if(GetDriverOfCar(GetCarCharIsUsing(GetPlayerChar(-1))) == GetPlayerChar(-1)) then
							--if(GetCarModel(GetCarCharIsUsing(GetPlayerChar(-1), _i), _i) == carmodels[tempcar]) then
								if(currtuning[tempcar][19] > 0) then
									if(IsPlayerControlOn(GetPlayerId())) then
										if(not IsGameKeyboardKeyPressed(17)) then --w
											if(IsGameKeyboardKeyPressed(31)) then --s
												--if(type(GetVehicleGear(GetCarCharIsUsing(GetPlayerChar(-1), _i))) ~= "boolean") then
													if(GetVehicleGear(GetCarCharIsUsing(GetPlayerChar(-1), _i)) > 0) then
														if(IsVehicleOnAllWheels(GetCarCharIsUsing(GetPlayerChar(-1), _i))) then
															local tempspeed = GetCarSpeed(GetCarCharIsUsing(GetPlayerChar(-1), _i), _f)
															ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,-(0.2*currtuning[tempcar][19]),0,0,0,0,1,1,1,1)
														end
													end
												--end
											end
										end
									end
								end
							--end
						end
					end
				end
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if(tempcar > 0) then
			if(not IsPlayerDead(GetPlayerId())) then
				if(IsCharInAnyCar(GetPlayerChar(-1))) then
					if(GetCarCharIsUsing(GetPlayerChar(-1), _i) == car) then
						if(GetDriverOfCar(GetCarCharIsUsing(GetPlayerChar(-1))) == GetPlayerChar(-1)) then
							--if(GetCarModel(GetCarCharIsUsing(GetPlayerChar(-1), _i), _i) == carmodels[tempcar]) then
								if(currtuning[tempcar][20] > 0) then
									if(IsPlayerControlOn(GetPlayerId())) then
										if(IsVehicleOnAllWheels(GetCarCharIsUsing(GetPlayerChar(-1), _i))) then
											--local ch = GetCharHeading(GetPlayerChar(-1), _f) --GetCarHeading(GetCarCharIsUsing(GetPlayerChar(-1), _i), _f)
											local ch = 0
											if(IsGameKeyboardKeyJustPressed(76)) then --num5
											ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0,0.5,1*math.cos(math.rad(ch+90))+0.5*math.cos(math.rad(ch+0)), 1*math.sin(math.rad(ch+90))+0.5*math.sin(math.rad(ch+0)),0,1,1,1,1) --front right
												ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0,0.5,1*math.cos(math.rad(ch-90))+0.5*math.cos(math.rad(ch+180)), 1*math.sin(math.rad(ch-90))+0.5*math.sin(math.rad(ch+180)),0,1,1,1,1) --back left
													ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0,0.5,1*math.cos(math.rad(ch+90))+0.5*math.cos(math.rad(ch+180)), 1*math.sin(math.rad(ch+90))+0.5*math.sin(math.rad(ch+180)),0,1,1,1,1) --front left
												ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0,0.5,1*math.cos(math.rad(ch-90))+0.5*math.cos(math.rad(ch+0)), 1*math.sin(math.rad(ch-90))+0.5*math.sin(math.rad(ch+0)),0,1,1,1,1) --back right
											end
											if(IsGameKeyboardKeyJustPressed(75)) then --num4
												ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0,0.5,1*math.cos(math.rad(ch+90))+0.5*math.cos(math.rad(ch+180)), 1*math.sin(math.rad(ch+90))+0.5*math.sin(math.rad(ch+180)),0,1,1,1,1) --front left
												ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0,0.5,1*math.cos(math.rad(ch-90))+0.5*math.cos(math.rad(ch+180)), 1*math.sin(math.rad(ch-90))+0.5*math.sin(math.rad(ch+180)),0,1,1,1,1) --back left
											end
											if(IsGameKeyboardKeyJustPressed(77)) then --num6
												ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0,0.5,1*math.cos(math.rad(ch+90))+0.5*math.cos(math.rad(ch+0)), 1*math.sin(math.rad(ch+90))+0.5*math.sin(math.rad(ch+0)),0,1,1,1,1) --front right
												ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0,0.5,1*math.cos(math.rad(ch-90))+0.5*math.cos(math.rad(ch+0)), 1*math.sin(math.rad(ch-90))+0.5*math.sin(math.rad(ch+0)),0,1,1,1,1) --back right
											end
											if(IsGameKeyboardKeyJustPressed(72)) then --num8
												ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0,0.5,1*math.cos(math.rad(ch+90))+0.5*math.cos(math.rad(ch+180)), 1*math.sin(math.rad(ch+90))+0.5*math.sin(math.rad(ch+180)),0,1,1,1,1) --front left
												ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0,0.5,1*math.cos(math.rad(ch+90))+0.5*math.cos(math.rad(ch+0)), 1*math.sin(math.rad(ch+90))+0.5*math.sin(math.rad(ch+0)),0,1,1,1,1) --front right
											end
											if(IsGameKeyboardKeyJustPressed(80)) then --num2
												ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0,0.5,1*math.cos(math.rad(ch-90))+0.5*math.cos(math.rad(ch+180)), 1*math.sin(math.rad(ch-90))+0.5*math.sin(math.rad(ch+180)),0,1,1,1,1) --back left
												ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0,0.5,1*math.cos(math.rad(ch-90))+0.5*math.cos(math.rad(ch+0)), 1*math.sin(math.rad(ch-90))+0.5*math.sin(math.rad(ch+0)),0,1,1,1,1) --back right
											end
											if(IsGameKeyboardKeyJustPressed(71)) then --num7
												ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0,0.5,1*math.cos(math.rad(ch+90))+0.5*math.cos(math.rad(ch+180)), 1*math.sin(math.rad(ch+90))+0.5*math.sin(math.rad(ch+180)),0,1,1,1,1) --front left
											end
											if(IsGameKeyboardKeyJustPressed(73)) then --num9
												ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0,0.5,1*math.cos(math.rad(ch+90))+0.5*math.cos(math.rad(ch+0)), 1*math.sin(math.rad(ch+90))+0.5*math.sin(math.rad(ch+0)),0,1,1,1,1) --front right
											end
											if(IsGameKeyboardKeyJustPressed(79)) then --num1
												ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0,0.5,1*math.cos(math.rad(ch-90))+0.5*math.cos(math.rad(ch+180)), 1*math.sin(math.rad(ch-90))+0.5*math.sin(math.rad(ch+180)),0,1,1,1,1) --back left
											end
											if(IsGameKeyboardKeyJustPressed(81)) then --num3
												ApplyForceToCar(GetCarCharIsUsing(GetPlayerChar(-1), _i),1,0,0,0.5,1*math.cos(math.rad(ch-90))+0.5*math.cos(math.rad(ch+0)), 1*math.sin(math.rad(ch-90))+0.5*math.sin(math.rad(ch+0)),0,1,1,1,1) --back right
											end
										end
									end
								end
							--end
						end
					end
				end
			end
		end
	end
end)

local neons = {}
RegisterNetEvent('requestNeon')
AddEventHandler('requestNeon', function(target)
	if(IsNetworkPlayerActive(GetPlayerId())) then
		if(ConvertIntToPlayerindex(target) == ConvertIntToPlayerindex(GetPlayerId())) then
			if(IsCharInCar(GetPlayerChar(-1), car)) then
				TriggerServerEvent('sendNeon', target, currtuning[tempcar][14], currtuning[tempcar][15], currtuning[tempcar][16])
			else
				TriggerServerEvent('sendNeon', target, 0, 0, 0)
			end
		end
	end
end)
RegisterNetEvent('sendNeon')
AddEventHandler('sendNeon', function(target, r, g, b)
	--if(ConvertIntToPlayerindex(requester) == ConvertIntToPlayerindex(GetPlayerId())) then
		neons[target] = {r, g, b}
	--end
end)
CreateThread(function()
	while true do
		Wait(0)
		if(IsNetworkPlayerActive(GetPlayerId())) then
			if(ConvertIntToPlayerindex(GetPlayerId()) == ConvertIntToPlayerindex(GetHostId())) then
				Wait(10000)
				for i=0,31,1 do
					if(IsNetworkPlayerActive(i)) then
						--if(ConvertIntToPlayerindex(i) ~= ConvertIntToPlayerindex(GetPlayerId())) then
						--	local px,py,pz = GetCharCoordinates(GetPlayerChar(i))
						--	if(IsPlayerNearCoords(px, py, pz, 50)) then
								TriggerServerEvent('requestNeon', i)
						--		Wait(2000)
						--	end
						--end
					end
				end
			end
		end
	end
end)
CreateThread(function()
	while true do
		Wait(0)
		for i=0,31,1 do
			if(IsNetworkPlayerActive(i)) then
				if(ConvertIntToPlayerindex(i) ~= ConvertIntToPlayerindex(GetPlayerId())) then
					if(IsCharInAnyCar(GetPlayerChar(i))) then
						if(neons[i] ~= nil) then
							local px,py,pz = GetCharCoordinates(GetPlayerChar(i))
							if(IsPlayerNearCoords(px, py, pz, 50)) then
								local cx,cy,cz = GetCarCoordinates(GetCarCharIsUsing(GetPlayerChar(i), _i), _f, _f, _f)
								DrawLightWithRange(cx, cy, cz, neons[i][1], neons[i][2], neons[i][3], 9.9, 10.1)
							end
						end
					end
				end
			end
		end
	end
end)