
CreateThread(function()
	while true do
		Wait(0)
		
		if(not DoesBlipExist(bankblip)) then
			bankblip = AddBlipForCoord(-11.60025, -465.58319, 15.41224)
			ChangeBlipSprite(bankblip, 28)
			--ChangeBlipColour(atmblip[i], 1)
			ChangeBlipNameFromAscii(bankblip, "Main Bank")
			SetBlipAsShortRange(bankblip, true)
		end
		DrawCheckpointWithDist(-11.60025, -465.58319, 15.41224-1, 1.1, 255, 3, 30, 100)
		DrawTextAtCoord(-11.60025, -465.58319, 15.41224, "Bank", 20)
		if(IsPlayerNearCoords(-11.60025, -465.58319, 15.41224, 1)) then
			PrintText("Press ~y~E ~w~to use BANK", 1)
			if(IsGameKeyboardKeyJustPressed(18)) then
				::main::
				local tempitems = {}
				tempitems[#tempitems+1] = "Send money to player"
				tempitems[#tempitems+1] = "House service payment"
				tempitems[#tempitems+1] = "Business service payment"
				tempitems[#tempitems+1] = "Collect business income"
				DrawWindow("ATM", tempitems)
				while menuactive do
					Wait(0)
				end
				if(menuresult > 0) then
					if(tempitems[menuresult] == "Send money to player") then
						local tempitems = {}
						local tempids = {}
						for j=0,31,1 do
							if(IsNetworkPlayerActive(j)) then
								if(ConvertIntToPlayerindex(j) ~= ConvertIntToPlayerindex(GetPlayerId())) then
									tempitems[#tempitems+1] = GetPlayerName(j) .. "(" .. j .. ")"
									tempids[#tempids+1] = j
								end
							end
						end
						DrawWindow("Select player", tempitems)
						while menuactive do
							Wait(0)
						end
						if(menuresult > 0) then
							local amount = ActivateInput("Enter amount of cash")
							if(amount ~= "") then
								amount = tonumber(amount)
								if amount then
									if(amount > 0) then
										if(inventory[34] >= amount) then
											RemoveItem(34, amount)
											SaveStats()
											TriggerServerEvent('sendMoneyToPlayer2', tempids[menuresult], ConvertIntToPlayerindex(GetPlayerId()), amount)
										else
											Notify("You do not have this amount of money.")
										end
									end
								end
							end
						else
							goto main
						end
					elseif(tempitems[menuresult] == "House service payment") then
						::houseservice::
						local tempitems = {}
						local tempids = {}
						for j=1,#houseinfo,1 do
							if(houses[j] == GetPlayerName(GetPlayerId())) then
								tempitems[#tempitems+1] = "House #" .. j .. " - ~g~" .. houseinfo[j][1]/100*housecash[j]
								tempids[#tempids+1] = j
							end
						end
						DrawWindow("House service payment", tempitems)
						while menuactive do
							Wait(0)
						end
						if(menuresult > 0) then
							local tempcash = math.floor(houseinfo[tempids[menuresult]][1]/100*housecash[tempids[menuresult]])
							if(inventory[34] >= tempcash) then
								RemoveItem(34, tempcash)
								SaveStats()
								housecash[tempids[menuresult]] = 0
								SaveHouseCash()
								Notify("House #" .. tempids[menuresult] .. " service paid.")
							else
								Notify("You do not have enough money.")
							end
							goto houseservice
						else
							goto main
						end
					elseif(tempitems[menuresult] == "Business service payment") then
						::bizservice::
						local tempitems = {}
						local tempids = {}
						for j=1,#bizinfo,1 do
							if(biz[j] == GetPlayerName(GetPlayerId())) then
								tempitems[#tempitems+1] = "" .. bizinfo[j][3] .. " - ~g~" .. bizinfo[j][1]/100*bizcash[j] .. "$"
								tempids[#tempids+1] = j
							end
						end
						DrawWindow("Business service payment", tempitems)
						while menuactive do
							Wait(0)
						end
						if(menuresult > 0) then
							local tempcash = math.floor(bizinfo[tempids[menuresult]][1]/100*bizcash[tempids[menuresult]])
							if(inventory[34] >= tempcash) then
								RemoveItem(34, tempcash)
								SaveStats()
								bizcash[tempids[menuresult]] = 0
								SaveBizCash()
								Notify("" .. tempids[menuresult] .. " business service paid.")
							else
								Notify("You do not have enough money.")
							end
							goto bizservice
						else
							goto main
						end
					elseif(tempitems[menuresult] == "Collect business income") then
						::bizincome::
						local tempitems = {}
						local tempids = {}
						for j=1,#bizinfo,1 do
							if(biz[j] == GetPlayerName(GetPlayerId())) then
								tempitems[#tempitems+1] = "" .. bizinfo[j][3] .. " ~g~(" .. bizincome[j] .. "$)"
								tempids[#tempids+1] = j
							end
						end
						DrawWindow("Business income", tempitems)
						while menuactive do
							Wait(0)
						end
						if(menuresult > 0) then
							AddItem(34, bizincome[tempids[menuresult]])
							SaveStats()
							bizincome[tempids[menuresult]] = 0
							SaveBizIncome()
							Notify("Income collected.")
							goto bizincome
						else
							goto main
						end
					end
				end
			end
		end
	end
end)