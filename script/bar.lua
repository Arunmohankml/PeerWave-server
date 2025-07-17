local barcoords = {
{-433.4541, 453.08176, 10.39997, 177.758651733398, -1622163388},
{1142.64636, 738.78998, 35.52003, 356.888336181641, -1622163388},
{935.83295, -492.48514, 15.48969, 359.819458007813, 2050280904},
{1468.3916, 57.95676, 25.1908, 91.5105056762695, -86316826}
}
local barblip = {}

drunk = 0
CreateThread(function()
	while true do
		Wait(0)
		if(drunk > 0) then
			Wait(3000)
			if(drunk > 0) then
				drunk = drunk - 1
			end
		end
	end
end)
CreateThread(function()
	while true do
		Wait(0)
		for i=1,#barcoords,1 do
			if(not DoesBlipExist(barblip[i])) then
				barblip[i] = AddBlipForCoord(barcoords[i][1], barcoords[i][2], barcoords[i][3])
				ChangeBlipSprite(barblip[i], 47)
				ChangeBlipScale(barblip[i], 0.7)
				--ChangeBlipColour(barblip[i], 1)
				ChangeBlipNameFromAscii(barblip[i], "Bar")
				SetBlipAsShortRange(barblip[i], true)
			end
			DrawTextAtCoord(barcoords[i][1], barcoords[i][2], barcoords[i][3], "Bar", 20)
			DrawCheckpointWithDist(barcoords[i][1], barcoords[i][2], barcoords[i][3]-1, 1.1, 255, 3, 30, 100)
			if(IsPlayerNearCoords(barcoords[i][1], barcoords[i][2], barcoords[i][3], 1)) then
				PrintStringWithLiteralStringNow("STRING", "Press ~y~E ~w~to ~y~open bar menu", 1000, 1)
				if(IsGameKeyboardKeyJustPressed(18)) then
					::main::
					local drinks = {
					{"Pisswasser", 10, 20, 30},
					{"Cherenkov", 20, 30, 60},
					{"Macbeth", 50, 50, 100}
					}
					local tempitems = {}
					for j=1,#drinks,1 do
						tempitems[j] = drinks[j][1] .. " - " .. drinks[j][2] .. "$"
					end
					DrawWindow("Bar", tempitems)
					while menuactive do
						Wait(0)
					end
					if(menuresult > 0) then
						if(inventory[34] >= drinks[menuresult][2]) then
							AddItem(20, 1)
							RemoveItem(34, drinks[menuresult][2])
							SaveStats()
						else
							Notify("You do not have enough money.")
						end
						goto main
					end
				end
			end
		end
	end
end)
