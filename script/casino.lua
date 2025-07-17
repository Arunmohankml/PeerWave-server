DrawCurvedRect = function(x, y, sx, sy, r, g, b, a)
	DisplaySprite("misc", "curvedrect", x, y, sx, sy, 0.0, r, g, b, a)
end

local casinoblip = nil
local objs = {}
local objinfo = {
{"bm_vend_fags", 946.612731933594, -264.933013916016, 18.5586776733398, 89.8863677978516, 1891939768},
{"bm_vend_fags", 946.615295410156, -263.883270263672, 18.5586776733398, 89.8863677978516, 1891939768},
{"bm_vend_fags", 946.617858886719, -262.833526611328, 18.5586776733398, 89.8863677978516, 1891939768},
{"gb_hosp_machine01", 968.000549316406, -262.655670166016, 18.0573253631592, 179.733322143555, 1891939768},
{"gb_hosp_machine01", 968.005310058594, -263.955352783203, 18.0573253631592, 179.2333984375, 1891939768},
{"gb_hosp_machine01", 968.009887695313, -265.205047607422, 18.0573253631592, 178.733428955078, 1891939768},
{"bm_vend_fags", 964.317749023438, -261.363891601563, 18.5579891204834, 0.0165401566773653, 1891939768},
{"bm_vend_fags", 965.317504882813, -261.363891601563, 18.5579891204834, 0.0165401566773653, 1891939768},
{"bm_vend_fags", 966.317260742188, -261.363891601563, 18.5579891204834, 0.0165401566773653, 1891939768}
}
CreateThread(function()
	casinoblip = AddBlipForCoord(957.33752, -269.64719, 18.129)
	ChangeBlipSprite(casinoblip, 52)
	ChangeBlipScale(casinoblip, 0.7)
	ChangeBlipNameFromAscii(casinoblip, "Casino")
	SetBlipAsShortRange(casinoblip, true)
	
	for i=1,#objinfo,1 do
		objs[i] = SpawnObject(GetHashKey(objinfo[i][1]), objinfo[i][2], objinfo[i][3], objinfo[i][4], objinfo[i][5], objinfo[i][6])
		SetObjectStopCloning(objs[i], true)
		FreezeObjectPosition(objs[i], true)
	end
end)

local slotcoords = {
{967.1333, -264.00842, 18.26995, 268.965301513672, 1891939768}
}
local slotm = {}
CreateThread(function()
	while true do
		Wait(0)
		if(IsPlayerControlOn(GetPlayerId())) then
			for i=1,#slotcoords,1 do
				--DrawTextAtCoord(slotcoords[i][1], slotcoords[i][2], slotcoords[i][3], "Slot_machine", 20)
				DrawCheckpointWithDist(slotcoords[i][1], slotcoords[i][2], slotcoords[i][3]-1, 1.1, 0, 255, 0, 100)
				if(IsPlayerNearCoords(slotcoords[i][1], slotcoords[i][2], slotcoords[i][3], 0.5)) then
					PrintText("Press ~y~E ~w~to ~y~start slot machine ~w~for ~g~100$", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						if(inventory[34] >= 100) then
							RemoveItem(34, 100)
							SaveStats()
							StartSlotMachine()
						else
							Notify("You do not have enough money.")
						end
					end
				end
			end
		end
	end
end)

local text1 = ""
local text2 = ""
local text3 = ""
local textf = ""
StartSlotMachine = function()
	SetPlayerControl(GetPlayerId(), false)
	SetCamActive(GetGameCam(), false)
	local rnd1 = 0
	local rnd2 = 0
	local rnd3 = 0
	for i=1,10,1 do
		rnd1 = GenerateRandomIntInRange(1, 10)
		rnd2 = GenerateRandomIntInRange(1, 10)
		rnd3 = GenerateRandomIntInRange(1, 10)
		text1 = "" .. rnd1
		text2 = "" .. rnd2
		text3 = "" .. rnd3
		Wait(500)
	end
	if(rnd1==rnd2 and rnd2==rnd3) then
		AddItem(34, 8000)
							--money = money + 5000
		SaveStats()
		textf = "~y~Jackpot! You won 6000$"
	elseif(rnd1==rnd2 or rnd1==rnd3 or rnd2==rnd3) then
		AddItem(34, 4000)
							--money = money + 1000
		SaveStats()
		textf = "~g~You won 2000$"
	else
		textf = "~r~Try again"
	end
	Wait(5000)
	text1 = ""
	text2 = ""
	text3 = ""
	textf = ""
	SetPlayerControl(GetPlayerId(), true)
	SetCamActive(GetGameCam(), true)
end

CreateThread(function()
	while true do
		Wait(0)
		if(textf ~= "") then
			SetTextScale(0.300000,  0.5000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextCentre(1)
			DisplayTextWithLiteralString(0.5, 0.35, "STRING", "" .. textf)
		end
		if(text1 ~= "") then
			DrawCurvedRect(0.4, 0.5, 0.09, 0.18, 0, 0, 0, 100)
			DisplaySprite("casino", "slot" .. text1, 0.4, 0.5, 0.08, 0.16, 0.0, 255, 255, 255, 255)
		end
		if(text2 ~= "") then
			DrawCurvedRect(0.5, 0.5, 0.09, 0.18, 0, 0, 0, 100)
			DisplaySprite("casino", "slot" .. text2, 0.5, 0.5, 0.08, 0.16, 0.0, 255, 255, 255, 255)
		end
		if(text3 ~= "") then
			DrawCurvedRect(0.6, 0.5, 0.09, 0.18, 0, 0, 0, 100)
			DisplaySprite("casino", "slot" .. text3, 0.6, 0.5, 0.08, 0.16, 0.0, 255, 255, 255, 255)
		end
	end
end)

local mlcoords = {
{965.34393, -262.11005, 18.27071, 0.884489595890045, 1891939768}
}
CreateThread(function()
	while true do
		Wait(0)
		if(IsPlayerControlOn(GetPlayerId())) then
			for i=1,#mlcoords,1 do
				--DrawTextAtCoord(mlcoords[i][1], mlcoords[i][2], mlcoords[i][3], "Slot_machine", 20)
				DrawCheckpointWithDist(mlcoords[i][1], mlcoords[i][2], mlcoords[i][3]-1, 1.1, 255, 3, 30, 100)
				if(IsPlayerNearCoords(mlcoords[i][1], mlcoords[i][2], mlcoords[i][3], 0.5)) then
					PrintText("Press ~y~E ~w~to play ~y~More or Less", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						local bet = ActivateInput("Enter your bet")
						if(bet ~= "") then
							bet = tonumber(bet)
							if bet then
								if(inventory[34] >= bet) then
									RemoveItem(34, bet)
									SaveStats()
									local mult = 1
									local num = GenerateRandomIntInRange(3, 8)
									cursor = 1
									SetPlayerControl(GetPlayerId(), false)
									SetCamActive(GetGameCam(), false)
									while true do
										Wait(0)
										DrawCurvedRect(0.5, 0.5, 0.1, 0.2, 100, 100, 100, 255)
										DrawRect(0.5, 0.5, 0.08, 0.16, 0, 0, 0, 100)
										SetTextScale(0.500000,  1.000000)
										SetTextDropshadow(0, 0, 0, 0, 0)
										SetTextEdge(1, 0, 0, 0, 255)
										SetTextCentre(1)
										SetTextFont(6)
										DisplayTextWithLiteralString(0.5, 0.47, "STRING", "" .. num)
										SetTextScale(0.500000,  1.000000)
										SetTextDropshadow(0, 0, 0, 0, 0)
										SetTextEdge(1, 0, 0, 0, 255)
										SetTextCentre(1)
										SetTextFont(6)
										DisplayTextWithLiteralString(0.5, 0.62, "STRING", "~y~Multiplier: " .. mult .. " ~g~Take: " .. math.floor(bet*mult) .. "$")
										
										DrawCurvedRect(0.3, 0.5, 0.08, 0.1, 255, 100, 100, 255)
										SetTextScale(0.500000,  1.000000)
										SetTextDropshadow(0, 0, 0, 0, 0)
										SetTextEdge(1, 0, 0, 0, 255)
										SetTextCentre(1)
										SetTextFont(6)
										DisplayTextWithLiteralString(0.3, 0.47, "STRING", "Less")
										if(IsCursorInArea(0.3, 0.5, 0.08, 0.1)) then
											DrawCurvedRect(0.3, 0.5, 0.08, 0.1, 255, 255, 255, 255)
											if(IsMouseButtonJustPressed(1)) then
												local rnd = GenerateRandomIntInRange(1, 11)
												while rnd==num do
													rnd = GenerateRandomIntInRange(1, 11)
												end
												if(rnd < num) then
													mult = mult + 0.1
													local check = true
													CreateThread(function()
														Wait(1000)
														check = false
													end)
													while check do
														Wait(0)
														DrawCurvedRect(0.5, 0.5, 0.1, 0.2, 255, 100, 100, 255)
														DrawRect(0.5, 0.5, 0.08, 0.16, 0, 0, 0, 100)
														SetTextScale(0.500000,  1.000000)
														SetTextDropshadow(0, 0, 0, 0, 0)
														SetTextEdge(1, 0, 0, 0, 255)
														SetTextCentre(1)
														SetTextFont(6)
														SetTextColour(0, 255, 0, 255)
														DisplayTextWithLiteralString(0.5, 0.47, "STRING", "" .. rnd)
														SetTextScale(0.500000,  1.000000)
														SetTextDropshadow(0, 0, 0, 0, 0)
														SetTextEdge(1, 0, 0, 0, 255)
														SetTextCentre(1)
														SetTextFont(6)
														DisplayTextWithLiteralString(0.5, 0.65, "STRING", "~g~Nice one!")
													end
													local newnum = GenerateRandomIntInRange(3, 8)
													while newnum==num do
														newnum = GenerateRandomIntInRange(3, 8)
													end
													num = newnum
												else
													while true do
														Wait(0)
														DrawCurvedRect(0.5, 0.5, 0.1, 0.2, 255, 100, 100, 255)
														DrawRect(0.5, 0.5, 0.08, 0.16, 0, 0, 0, 100)
														SetTextScale(0.500000,  1.000000)
														SetTextDropshadow(0, 0, 0, 0, 0)
														SetTextEdge(1, 0, 0, 0, 255)
														SetTextCentre(1)
														SetTextFont(6)
														SetTextColour(191, 0, 255, 255)
														DisplayTextWithLiteralString(0.5, 0.47, "STRING", "" .. rnd)
														SetTextScale(0.500000,  1.000000)
														SetTextDropshadow(0, 0, 0, 0, 0)
														SetTextEdge(1, 0, 0, 0, 255)
														SetTextCentre(1)
														SetTextFont(6)
														DisplayTextWithLiteralString(0.5, 0.65, "STRING", "~r~You lost!")
														
														PrintText("Press ~y~E ~w~to leave", 1)
														if(IsGameKeyboardKeyJustPressed(18)) then
															goto out
														end
													end
												end
											end
										end
										
										DrawCurvedRect(0.7, 0.5, 0.08, 0.1, 100, 255, 100, 255)
										SetTextScale(0.500000,  1.000000)
										SetTextDropshadow(0, 0, 0, 0, 0)
										SetTextEdge(1, 0, 0, 0, 255)
										SetTextCentre(1)
										SetTextFont(6)
										DisplayTextWithLiteralString(0.7, 0.47, "STRING", "More")
										if(IsCursorInArea(0.7, 0.5, 0.08, 0.1)) then
											DrawCurvedRect(0.7, 0.5, 0.08, 0.1, 255, 255, 255, 255)
											if(IsMouseButtonJustPressed(1)) then
												local rnd = GenerateRandomIntInRange(1, 11)
												while rnd==num do
													rnd = GenerateRandomIntInRange(1, 11)
												end
												if(rnd > num) then
													mult = mult + 0.1
													local check = true
													CreateThread(function()
														Wait(1000)
														check = false
													end)
													while check do
														Wait(0)
														DrawCurvedRect(0.5, 0.5, 0.1, 0.2, 255, 100, 100, 255)
														DrawRect(0.5, 0.5, 0.08, 0.16, 0, 0, 0, 100)
														SetTextScale(0.500000,  1.000000)
														SetTextDropshadow(0, 0, 0, 0, 0)
														SetTextEdge(1, 0, 0, 0, 255)
														SetTextCentre(1)
														SetTextFont(6)
														SetTextColour(0, 255, 0, 255)
														DisplayTextWithLiteralString(0.5, 0.47, "STRING", "" .. rnd)
														SetTextScale(0.500000,  1.000000)
														SetTextDropshadow(0, 0, 0, 0, 0)
														SetTextEdge(1, 0, 0, 0, 255)
														SetTextCentre(1)
														SetTextFont(6)
														DisplayTextWithLiteralString(0.5, 0.65, "STRING", "~g~Nice one!")
													end
													local newnum = GenerateRandomIntInRange(3, 8)
													while newnum==num do
														newnum = GenerateRandomIntInRange(3, 8)
													end
													num = newnum
												else
													while true do
														Wait(0)
														DrawCurvedRect(0.5, 0.5, 0.1, 0.2, 255, 100, 100, 255)
														DrawRect(0.5, 0.5, 0.08, 0.16, 0, 0, 0, 100)
														SetTextScale(0.500000,  1.000000)
														SetTextDropshadow(0, 0, 0, 0, 0)
														SetTextEdge(1, 0, 0, 0, 255)
														SetTextCentre(1)
														SetTextFont(6)
														SetTextColour(191, 0, 255, 255)
														DisplayTextWithLiteralString(0.5, 0.47, "STRING", "" .. rnd)
														SetTextScale(0.500000,  1.000000)
														SetTextDropshadow(0, 0, 0, 0, 0)
														SetTextEdge(1, 0, 0, 0, 255)
														SetTextCentre(1)
														SetTextFont(6)
														DisplayTextWithLiteralString(0.5, 0.65, "STRING", "~r~You lost!")
														
														PrintText("Press ~y~E ~w~to leave", 1)
														if(IsGameKeyboardKeyJustPressed(18)) then
															goto out
														end
													end
												end
											end
										end
										
										DrawCurvedRect(0.5, 0.78, 0.15, 0.07, 100, 255, 100, 255)
										SetTextScale(0.500000,  1.000000)
										SetTextDropshadow(0, 0, 0, 0, 0)
										SetTextEdge(1, 0, 0, 0, 255)
										SetTextCentre(1)
										SetTextFont(6)
										DisplayTextWithLiteralString(0.5, 0.75, "STRING", "Take cash")
										if(IsCursorInArea(0.5, 0.78, 0.15, 0.07)) then
											DrawCurvedRect(0.5, 0.78, 0.15, 0.07, 255, 255, 255, 255)
											if(IsMouseButtonJustPressed(1)) then
												AddItem(34, math.floor(bet*mult))
							
												SaveStats()
												goto out
											end
										end
									end
									::out::
									cursor = 0
									SetPlayerControl(GetPlayerId(), true)
									SetCamActive(GetGameCam(), true)
								else
									Notify("You do not have this amount of money.")
								end
							end
						end
					end
				end
			end
		end
	end
end)

local ccoords = {
{947.2995, -263.86389, 18.27155, 89.8649139404297, 1891939768}
}
CreateThread(function()
	while true do
		Wait(0)
		if(IsPlayerControlOn(GetPlayerId())) then
			for i=1,#ccoords,1 do
				--DrawTextAtCoord(ccoords[i][1], ccoords[i][2], ccoords[i][3], "Slot_machine", 20)
				DrawCheckpointWithDist(ccoords[i][1], ccoords[i][2], ccoords[i][3]-1, 1.1, 0, 0, 255, 100)
				if(IsPlayerNearCoords(ccoords[i][1], ccoords[i][2], ccoords[i][3], 0.5)) then
					PrintText("Press ~y~E ~w~to play ~y~Crash", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						local bet = ActivateInput("Enter your bet")
						if(bet ~= "") then
							bet = tonumber(bet)
							if bet then
								if(inventory[34] >= bet) then
									RemoveItem(34, bet)
									SaveStats()
									local mult = 1
									cursor = 1
									SetPlayerControl(GetPlayerId(), false)
									SetCamActive(GetGameCam(), false)
									while true do
										Wait(0)
										DrawCurvedRect(0.5, 0.5, 0.1, 0.2, 255, 100, 100, 255)
										DrawRect(0.5, 0.5, 0.08, 0.16, 0, 0, 0, 100)
										SetTextScale(0.500000,  1.000000)
										SetTextDropshadow(0, 0, 0, 0, 0)
										SetTextEdge(1, 0, 0, 0, 255)
										SetTextCentre(1)
										SetTextFont(6)
										DisplayTextWithLiteralString(0.5, 0.47, "STRING", "x" .. math.floor(mult*100)/100)
										
										DrawCurvedRect(0.5, 0.78, 0.15, 0.07, 100, 255, 100, 255)
										SetTextScale(0.500000,  1.000000)
										SetTextDropshadow(0, 0, 0, 0, 0)
										SetTextEdge(1, 0, 0, 0, 255)
										SetTextCentre(1)
										SetTextFont(6)
										DisplayTextWithLiteralString(0.5, 0.75, "STRING", "Take cash")
										if(IsCursorInArea(0.5, 0.78, 0.15, 0.07)) then
											DrawCurvedRect(0.5, 0.78, 0.15, 0.07, 255, 255, 255, 255)
											if(IsMouseButtonJustPressed(1)) then
												AddItem(34, math.floor(bet*mult))
							
												SaveStats()
												goto out
											end
										end
										
										mult = mult + 0.01
										local rnd = GenerateRandomIntInRange(1, 101)
										if(rnd == 1) then
											while true do
												Wait(0)
												DrawCurvedRect(0.5, 0.5, 0.1, 0.2, 255, 100, 100, 255)
												DrawRect(0.5, 0.5, 0.08, 0.16, 0, 0, 0, 100)
												SetTextScale(0.500000,  1.000000)
												SetTextDropshadow(0, 0, 0, 0, 0)
												SetTextEdge(1, 0, 0, 0, 255)
												SetTextCentre(1)
												SetTextFont(6)
												SetTextColour(191, 0, 255, 255)
												DisplayTextWithLiteralString(0.5, 0.47, "STRING", "x" .. math.floor(mult*100)/100)
												SetTextScale(0.500000,  1.000000)
												SetTextDropshadow(0, 0, 0, 0, 0)
												SetTextEdge(1, 0, 0, 0, 255)
												SetTextCentre(1)
												SetTextFont(6)
												DisplayTextWithLiteralString(0.5, 0.65, "STRING", "~r~Crash! You lost!")
												
												PrintText("Press ~y~E ~w~to leave", 1)
												if(IsGameKeyboardKeyJustPressed(18)) then
													goto out
												end
											end
										end
									end
									::out::
									cursor = 0
									SetPlayerControl(GetPlayerId(), true)
									SetCamActive(GetGameCam(), true)
								else
									Notify("You do not have this amount of money.")
								end
							end
						end
					end
				end
			end
		end
	end
end)