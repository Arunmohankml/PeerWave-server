local invX = 0.35
local invY = 0.3
local slotwidth = 0.06
local slotheight = 0.12
local numwidth = 5
local numheight = 3

local inventory = 0
local inv = {}
for i=1,numwidth,1 do
	inv[i] = {}
	for j=1,numheight,1 do
		inv[i][j] = "None"
	end
end

RegisterNetEvent('updInv')
AddEventHandler('updInv', function(data)
	inv = data
end)
SaveInv = function()
	TriggerServerEvent('saveInv', inv)
end

DisplaySpriteLeftTopCenter = function(txd, texture, x, y, sx, sy, rot, r, g, b, a)
	DisplaySprite(txd, texture, x+sx/2, y+sy/2, sx, sy, rot, r, g, b, a)
end

AddItemToInv = function(item)
	for j=1,numheight,1 do
		for i=1,numwidth,1 do
			if(inv[i][j] == "None") then
				inv[i][j] = item
				SaveInv()
				return true
			end
		end
	end
	Notify("Inventory is full.")
	return false
end

RegisterNetEvent('giveItemToPlayer')
AddEventHandler('giveItemToPlayer', function(id, sender, item, x, y)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		if(AddItemToInv(item)) then
			SendMessageToNearbyPlayers("" .. GetPlayerName(sender) .. " has given an item to " .. GetPlayerName(id) .. ".", 20)
			Notify("You have received " .. item .. " from " .. GetPlayerName(sender) .. ".")
			TriggerServerEvent('removeItemFromPlayer', sender, x, y)
		else
			TriggerServerEvent('sendMessageToPlayer', sender, "Inventory of this player is full.")
		end
	end
end)
RegisterNetEvent('removeItemFromPlayer')
AddEventHandler('removeItemFromPlayer', function(id, x, y)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		inv[x][y] = "None"
		SaveInv()
	end
end)

local context = nil
local holder = nil
CreateThread(function()
	while true do
		Wait(0)
		if(loginform == 0) then
			if(not IsPedRagdoll(GetPlayerChar(-1))) then
				if(IsPlayerControlOn(GetPlayerId())) then
					if(IsGameKeyboardKeyJustPressed(Inventorykey)) then
						if(inventory == 0) then
							inventory = 1
							cursor = 1
						else
							inventory = 0
							cursor = 0
						end
					end
				else
					if(inventory == 1) then
						inventory = 0
						cursor = 0
					end
				end
				if(inventory == 1) then
					if(IsPedRagdoll(GetPlayerChar(-1))) then
						inventory = 0
						context = nil
						holder = nil
					end
					SetCamBehindPed(GetPlayerChar(-1))
					SetGameCameraControlsActive(false)
					SetTextScale(0.300000,  0.5000000)
					SetTextDropshadow(0, 0, 0, 0, 0)
					SetTextFont(6)
					SetTextEdge(1, 0, 0, 0, 255)
					--SetTextWrap(0.0, 0.8)
					SetTextCentre(1)
					DisplayTextWithLiteralString(0.5, 0.2, "STRING", "Inventory")
					SetTextScale(0.1500000,  0.3000000)
					SetTextDropshadow(0, 0, 0, 0, 0)
					SetTextFont(6)
					SetTextEdge(1, 0, 0, 0, 255)
					--SetTextWrap(0.0, 0.8)
					SetTextCentre(1)
					DisplayTextWithLiteralString(0.5, 0.7, "STRING", "LMB_-_Move_item_/_RMB_-_Interact")
					--DrawRect(invX-(slotwidth/2)+(slotwidth*7/2), invY-(slotheight/2)+(slotheight*4/2), slotwidth*7, slotheight*4, 96, 96, 96, 255)
					for i=1,numwidth,1 do
						for j=1,numheight,1 do
							DrawRect(invX+slotwidth/2+slotwidth*(i-1), invY+slotheight/2+slotheight*(j-1), slotwidth-slotwidth/15, slotheight-slotheight/15, 96, 96, 96, 200)
							if(inv[i][j] ~= "None") then
								if(not IsCursorInArea(invX+slotwidth/2+slotwidth*(i-1), invY+slotheight/2+slotheight*(j-1), slotwidth-slotwidth/10, slotheight-slotheight/10)) then
									DisplaySprite("inv", inv[i][j], invX+slotwidth/2+slotwidth*(i-1), invY+slotheight/2+slotheight*(j-1), slotwidth-slotwidth/10, slotheight-slotheight/10, 0.0, 255, 255, 255, 255)
								else
									DisplaySprite("inv", inv[i][j], invX+slotwidth/2+slotwidth*(i-1), invY+slotheight/2+slotheight*(j-1), slotwidth-slotwidth/10, slotheight-slotheight/10, 0.0, 191, 0, 255, 255)
									if not context and not holder then
										local mx,my = GetMousePosition()
										SetTextScale(0.1500000,  0.3000000)
										SetTextDropshadow(0, 0, 0, 0, 0)
										--SetTextFont(6)
										SetTextEdge(1, 0, 0, 0, 255)
										DisplayTextWithLiteralString(mx, my, "STRING", inv[i][j])
									end
									if(IsMouseButtonPressed(1)) then
										if not holder then
											holder = {inv[i][j], i, j}
										end
									end
									if(IsMouseButtonJustPressed(2)) then
										--if not context then
											local mx,my = GetMousePosition()
											context = {mx, my, {"Use", "Give"}, inv[i][j], {i, j}}
										--end
									end
								end
							end
						end
					end
					if context then
						if(IsMouseButtonJustPressed(1)) then
							local checker = 0
							for i=1,#context[3],1 do
								if(IsCursorInAreaLeftTopCenter(context[1], context[2]+0.025*(i-1), 0.05, 0.025)) then
									checker = 1
								end
							end
							if(checker == 0) then
								context = nil
								goto finish
							end
						end
						DrawRectLeftTopCenter(context[1], context[2], 0.05, 0.025*#context[3], 255, 0, 0, 100)
						for i=1,#context[3],1 do
							SetTextScale(0.1500000,  0.3000000)
							SetTextDropshadow(0, 0, 0, 0, 0)
							--SetTextFont(6)
							--SetTextEdge(1, 0, 0, 0, 255)
							DisplayTextWithLiteralString(context[1]+0.005, context[2]+0.025*(i-1)+0.005, "STRING", "" .. context[3][i])
							if(IsCursorInAreaLeftTopCenter(context[1], context[2]+0.025*(i-1), 0.05, 0.025)) then
								DrawRectLeftTopCenter(context[1], context[2]+0.025*(i-1), 0.05, 0.025, 191, 0, 255, 255)
								if(IsMouseButtonJustPressed(1)) then
									if(context[3][i] == "Use") then
										if(context[4] == "Medkit") then
											if(GetCharHealth(GetPlayerChar(-1)) < 200) then
												SetCharHealth(GetPlayerChar(-1), 200)
												inv[context[5][1]][context[5][2]] = "None"
												SaveInv()
												SendMessageToNearbyPlayers("" .. GetPlayerName(GetPlayerId()) .. " has used a medkit.", 20)
											else
												Notify("You do not need a healing.")
											end
										elseif(context[4] == "Armor vest") then
											if(GetCharArmour(GetPlayerChar(-1)) < 100) then
												AddArmourToChar(GetPlayerChar(-1), 100)
												inv[context[5][1]][context[5][2]] = "None"
												SaveInv()
												SendMessageToNearbyPlayers("" .. GetPlayerName(GetPlayerId()) .. " has worn an armor vest.", 20)
											else
												Notify("Maximum armor reached.")
											end
										elseif(context[4] == "Ammo box") then
											local gw,cw = GetCurrentCharWeapon(GetPlayerChar(-1))
											if(cw >= 7) then
												local clip = GetMaxAmmoInClip(GetPlayerChar(-1), cw)
												AddAmmoToChar(GetPlayerChar(-1), cw, clip*3)
												inv[context[5][1]][context[5][2]] = "None"
												SaveInv()
												SendMessageToNearbyPlayers("" .. GetPlayerName(GetPlayerId()) .. " has grabbed some ammo from an ammo box.", 20)
											else
												Notify('You must hold a gun in your hand.')
											end
										elseif(context[4] == "Fuel canister") then
											if(not IsCharInAnyCar(GetPlayerChar(-1))) then
												local veh = GetVehiclePlayerWouldEnter(GetPlayerId())
												if(DoesVehicleExist(veh)) then
													if(not IsCarDead(veh)) then
														if carsfuel[veh] then
															if(carsfuel[veh] < 100) then
																--if(IsCharTouchingVehicle(GetPlayerChar(-1), veh)) then
																	if(veh ~= car) then
																		if(carsfuel[veh] < 100) then
																			PlayAnim("pickup_object", "putdown_med")
																			carsfuel[veh] = 100
																			inv[context[5][1]][context[5][2]] = "None"
																			SaveInv()
																			SendMessageToNearbyPlayers("" .. GetPlayerName(GetPlayerId()) .. " has refilled a vehicle.", 20)
																		else
																			Notify("This vehicle does not require refilling.")
																		end
																	else
																		local tempcar = 0
																		for j=1,#carinfo,1 do
																			if(IsCarModel(car, carinfo[j][3])) then
																				tempcar = j
																			end
																		end
																		if(fuel[tempcar] < 100) then
																			PlayAnim("pickup_object", "putdown_med")
																			fuel[tempcar] = 100
																			SaveFuel()
																			inv[context[5][1]][context[5][2]] = "None"
																			SaveInv()
																			SendMessageToNearbyPlayers("" .. GetPlayerName(GetPlayerId()) .. " has refilled a vehicle.", 20)
																		else
																			Notify("This vehicle does not require refilling.")
																		end
																	end
																--end
															else
																Notify("This vehicle does not require refilling.")
															end
														else
															Notify("No vehicle to refill.")
														end
													else
														Notify("No vehicle to refill.")
													end
												else
													Notify("No vehicle to refill.")
												end
											else
												Notify("Leave the vehicle to use it.")
											end
										elseif(context[4] == "Drug") then
											if(GetCharHealth(GetPlayerChar(-1)) < 200) then
												SetCharHealth(GetPlayerChar(-1), 200)
												addict = addict + 1
												SaveStats()
												inv[context[5][1]][context[5][2]] = "None"
												SaveInv()
												SendMessageToNearbyPlayers("" .. GetPlayerName(GetPlayerId()) .. " has used a drug.", 20)
											else
												Notify("You cannot take that much.")
											end
										else
											local food = {
											{"eCola", 4, 20, "amb@bottle_create", "stand_create", "has drunk a bottle of eCola."},
											{"EgoChaser", 6, 30, "amb@burger_create", "create_walk", "has eaten an EgoChaser bar."},
											{"Meteorite", 10, 40, "amb@burger_create", "create_walk", "has eaten a Meteorite bar."},
											{"P's & Q's", 2, 10, "amb@burger_create", "create_walk", "has eaten a pack of P's & Q's."},
											{"Sprunk", 4, 20, "amb@bottle_create", "stand_create", "has drunk a can of Sprunk."}
											}
											for j=1,#food,1 do
												if(food[j][1] == context[4]) then
													PlayAnim(food[j][4], food[j][5])
													hunger = hunger + food[j][3]
													if(hunger > 100) then
														hunger = 100
													end
													SaveStats()
													inv[context[5][1]][context[5][2]] = "None"
													SaveInv()
													SendMessageToNearbyPlayers("" .. GetPlayerName(GetPlayerId()) .. " " .. food[j][6], 20)
													break
												end
											end
											
											local drinks = {
											{"Pisswasser", 10, 20, 30, "has drunk a bottle of Pisswasser."},
											{"Cherenkov", 20, 30, 60, "has drunk a bottle of Cherenkov."},
											{"Macbeth", 50, 50, 100, "has drunk a bottle of Macbeth."}
											}
											for j=1,#drinks,1 do
												if(drinks[j][1] == context[4]) then
													AddArmourToChar(GetPlayerChar(-1), drinks[j][3])
													drunk = drunk + drinks[j][4]
													if(drunk >= 100) then
														inventory = 0
														cursor = 0
														SetPedIsDrunk(GetPlayerChar(-1), 1)
														SetDrunkCam(GetPlayerChar(-1), 0.9, 50000)
														SwitchPedToRagdoll(GetPlayerChar(-1), 60000, 55000, 2, 1, 1, 0)
														GivePlayerRagdollControl(GetPlayerId(), 1)
														drunk = 70
													else
														PlayAnim("amb@bottle_create", "stand_create")
													end
													inv[context[5][1]][context[5][2]] = "None"
													SaveInv()
													SendMessageToNearbyPlayers("" .. GetPlayerName(GetPlayerId()) .. " " .. drinks[j][5], 20)
													break
												end
											end
										end
									elseif(context[3][i] == "Give") then
										local tempplayers = {}
										local tempids = {}
										for j=0,31,1 do
											if(IsNetworkPlayerActive(j)) then
												if(ConvertIntToPlayerindex(j) ~= ConvertIntToPlayerindex(GetPlayerId())) then
													if(not IsPlayerDead(j)) then
														tempplayers[#tempplayers+1] = GetPlayerName(j)
														tempids[#tempids+1] = j
													end
												end
											end
										end
										if(#tempplayers == 1) then
											TriggerServerEvent('giveItemToPlayer', tempids[1], ConvertIntToPlayerindex(GetPlayerId()), context[4], context[5][1], context[5][2])
										elseif(#tempplayers > 1) then
											DrawWindow("Select player", tempplayers)
											while menuactive do
												Wait(0)
											end
											if(menuresult > 0) then
												TriggerServerEvent('giveItemToPlayer', tempids[menuresult], ConvertIntToPlayerindex(GetPlayerId()), context[4], context[5][1], context[5][2])
											end
										else
											Notify("There is nobody near you.")
										end
									end
									context = nil
									holder = nil
									break
								end
							end
						end
						::finish::
					end
					if holder then
						if(IsMouseButtonPressed(1)) then
							local mx,my = GetMousePosition()
							DisplaySprite("inv", holder[1], mx, my, slotwidth-slotwidth/10, slotheight-slotheight/10, 0.0, 255, 255, 255, 100)
						else
							for i=1,numwidth,1 do
								for j=1,numheight,1 do
									if(IsCursorInArea(invX+slotwidth/2+slotwidth*(i-1), invY+slotheight/2+slotheight*(j-1), slotwidth-slotwidth/10, slotheight-slotheight/10)) then
										inv[holder[2]][holder[3]] = inv[i][j]
										inv[i][j] = holder[1]
										SaveInv()
										break
									end
								end
							end
							holder = nil
						end
					end
				end
			end
		end
	end
end)