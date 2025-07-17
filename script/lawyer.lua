local mainjobblip = nil
local jobblip = nil
local animals = {}
CreateThread(function()
	while true do
		Wait(0)
		if(not DoesBlipExist(mainjobblip)) then
			mainjobblip = AddBlipForCoord(77.17374, -708.09344, 5.00153)
			ChangeBlipSprite(mainjobblip, 80)
			--ChangeBlipColour(mainjobblip, 1)
			ChangeBlipNameFromAscii(mainjobblip, "Lawyer")
			SetBlipAsShortRange(mainjobblip, true)
			ChangeBlipScale(mainjobblip, 0.7)
		end
		DrawCheckpointWithDist(77.17374, -708.09344, 5.00153-1, 1.1, 255, 3, 30, 100)
		DrawTextAtCoord(77.17374, -708.09344, 5.00153, "Lawyer", 20)
		if(IsPlayerNearCoords(77.17374, -708.09344, 5.00153, 1)) then
			if(level >= 3) then
				if(lawyerlicense == 1) then
					if(currjob ~= "Lawyer") then
						PrintText("Press ~y~E ~w~to start lawyer job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							if(currjob == "") then
								currjob = "Lawyer"
								Notify('Lawyer job has been started. Now you can free people out of jail for payment.')
							else
								Notify("You are currently working at another job. Finish it before starting this one.")
							end
						end
					else
						PrintText("Press ~y~E ~w~to finish lawyer job", 1)
						if(IsGameKeyboardKeyJustPressed(18)) then
							currjob = ""
							Notify('Lawyer job has been finished.')
						end
					end
				else
					PrintText("You need a lawyer license for this job. Press ~y~E ~w~to ~y~buy it ~w~for ~g~20000$", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						if(inventory[34] >= 20000) then
							RemoveItem(34, 200)
							lawyerlicense = 1
							SaveStats()
							Notify("Lawyer license purchased.")
						else
							Notify("You do not have enough money.")
						end
					end
				end
			else
				PrintText("You must reach level 3 to start this job", 1)
			end
		end
	end
end)

RegisterNetEvent('freeJail')
AddEventHandler('freeJail', function(target, requester, price)
	if(ConvertIntToPlayerindex(target) == ConvertIntToPlayerindex(GetPlayerId())) then
		if(jailtime > 0) then
			if(inventory[34] >= price) then
				DrawWindow("" .. GetPlayerName(requester) .. " wants to free you out of jail", {"Accept offer for ~g~" .. price .. "$"})
				while menuactive do
					Wait(0)
				end
				if(menuresult == 1) then
					RemoveItem(34, price)
					jailtime = 0
					SaveStats()
					SetCharCoordinates(GetPlayerChar(-1), -412.16193, 288.94852, 14.18139) --out of jail
					TriggerServerEvent('sendMoneyToPlayer', requester, target, price)
					TriggerServerEvent('sendMessageToPlayer', requester, "" .. GetPlayerName(target) .. " has accepted your offer.")
					SendMessageToNearbyPlayers("" .. GetPlayerName(requester) .. " has freed " .. GetPlayerName(target) .. " out of jail.", 20)
				else
					TriggerServerEvent('sendMessageToPlayer', requester, "" .. GetPlayerName(target) .. " has declined your offer.")
				end
			else
				TriggerServerEvent('sendMessageToPlayer', requester, "This player does not have enough money to pay for your services.")
			end
		else
			TriggerServerEvent('sendMessageToPlayer', requester, "This player is not imprisoned.")
		end
	end
end)