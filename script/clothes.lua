bodyparts2 = {
0,
1,
2,
7,
10,
4,
3
}
local skinnames = {
--[[2274661858, --"M_Y_MULTIPLAYER",
3653091386, --"F_Y_MULTIPLAYER",

2813043386, --"m_y_runner", --"ig_johnnybiker",
2592931069, --"f_y_shopper_05", --"ig_katemc",

357919731, --"m_y_shopasst_01", --"ig_luis",
761763258 --"f_y_villbo_01" --"ig_mallorie"]]
}

currparts = {}
for i=1,17,1 do
	if(i == 1) then
		currparts[i] = GetHashKey("M_M_TRAMPBLACK")
	elseif(i>=2 and i<=15) then
		currparts[i] = 0
	else
		currparts[i] = -1
	end
end

RegisterNetEvent('updParts')
AddEventHandler('updParts', function(data)
	for i=1,#currparts,1 do
		if(data[i] ~= nil) then
			currparts[i] = tonumber(data[i])
		end
	end
end)

SaveParts = function()
	local data = {}
	for i=1,#currparts,1 do
		data[i] = currparts[i]
	end
	TriggerServerEvent('saveParts', data)
end

SetDefaultSkin = function()
	local ap,hp = 200,0
	for i=1,9,1 do
		if(i == 1) then
			local model = currparts[1]
			RequestModel(model)
			while not HasModelLoaded(model) do
				Wait(0)
				RequestModel(model)
			end
			hp = GetCharHealth(GetPlayerChar(-1))
			ap = GetCharArmour(GetPlayerChar(-1))
			ChangePlayerModel(GetPlayerId(), model)
			if(IsInteriorScene() and GetKeyForViewportInRoom(GetGameViewportId())~=0) then
				SetRoomForCharByKey(GetPlayerChar(-1), GetKeyForViewportInRoom(GetGameViewportId()))
			end
		elseif(i>=2 and i<=8) then
			SetCharComponentVariation(GetPlayerChar(-1), bodyparts2[i-1], currparts[i], currparts[i+7])
		else
			SetCharPropIndex(GetPlayerChar(-1), 0, currparts[16])
			SetCharPropIndex(GetPlayerChar(-1), 1, currparts[17])
		end
	end
	SetCharHealth(GetPlayerChar(-1), hp)
	AddArmourToChar(GetPlayerChar(-1), ap)
end

IsDefaultSkin = function()
	--if(GetCharModel(GetPlayerChar(-1)) == currparts[1]) then
	--if(GetStringFromHashKey(GetCharModel(GetPlayerChar(-1))) == GetStringFromHashKey(currparts[1])) then
	if(IsCharModel(GetPlayerChar(-1), currparts[1])) then
		return true
	else
		return false
	end
end

local spawned = 0
RegisterNetEvent('playerSpawned')
AddEventHandler('playerSpawned', function()
	CreateThread(function()
		while not IsDefaultSkin() do
			Wait(0)
			for i=1,9,1 do
				if(i == 1) then
					local model = currparts[1]
					RequestModel(model)
					while not HasModelLoaded(model) do
						Wait(0)
					end
					ChangePlayerModel(GetPlayerId(), model)
					if(IsInteriorScene() and GetKeyForViewportInRoom(GetGameViewportId())~=0) then
						SetRoomForCharByKey(GetPlayerChar(-1), GetKeyForViewportInRoom(GetGameViewportId()))
					end
				elseif(i>=2 and i<=8) then
					SetCharComponentVariation(GetPlayerChar(-1), bodyparts2[i-1], currparts[i], currparts[i+7])
				else
					SetCharPropIndex(GetPlayerChar(-1), 0, currparts[16])
					SetCharPropIndex(GetPlayerChar(-1), 1, currparts[17])
				end
			end
		end
		if(spawned == 0) then
			SetDefaultSkin()
			SetCharHealth(GetPlayerChar(-1), hp)
			AddArmourToChar(GetPlayerChar(-1), ap)
			spawned = 1
		end
	end)
end)

local skinshopcoords = {
{-284.48291, 1364.14771, 25.63738, 222.996063232422},
{22.29914, 798.54492, 14.7668, 0.411204695701599},
{10.81859, -670.22687, 14.86652, 359.982604980469},
{880.54913, -446.63824, 15.85833, 311.022064208984}
}
local skinblip = {}
local biznames = {
"Modo",
"Perseus #1",
"Perseus #2",
"Men & Women Apparel Imported from Russia"
}

CreateThread(function()
	while true do
		Wait(0)
		BlockCharAmbientAnims(GetPlayerChar(-1), true)
		CancelCurrentlyPlayingAmbientSpeech(GetPlayerChar(-1))
		if not cuff then
			if(drunk < 50) then
				if(gender == 1) then
					RequestAnims("move_m@multiplyr")
					while not HaveAnimsLoaded("move_m@multiplyr") do
						Wait(0)
					end
					SetAnimGroupForChar(GetPlayerChar(-1), "move_m@multiplyr")
				else
					RequestAnims("move_f@multiplyr")
					while not HaveAnimsLoaded("move_f@multiplyr") do
						Wait(0)
					end
					SetAnimGroupForChar(GetPlayerChar(-1), "move_f@multiplyr")
				end
			else
				RequestAnims("move_m@bum")
				while not HaveAnimsLoaded("move_m@bum") do
					Wait(0)
				end
				SetAnimGroupForChar(GetPlayerChar(-1), "move_m@bum")
			end
		else
			RequestAnims("move_m@h_cuffed")
			while not HaveAnimsLoaded("move_m@h_cuffed") do
				Wait(0)
			end
			SetAnimGroupForChar(GetPlayerChar(-1), "move_m@h_cuffed")
		end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		for i=1,#skinshopcoords,1 do
			if(not DoesBlipExist(skinblip[i])) then
				skinblip[i] = AddBlipForCoord(skinshopcoords[i][1], skinshopcoords[i][2], skinshopcoords[i][3], _i)
				ChangeBlipSprite(skinblip[i], 50)
				ChangeBlipScale(skinblip[i], 0.7)
				--ChangeBlipNameFromAscii(skinblip[i], "Clothes shop")
				SetBlipAsShortRange(skinblip[i], true)
			end
			--DrawTextAtCoord(-766.86694, 203.2243, 6.3086, "Clothes_shop", 20)
			DrawCheckpointWithDist(skinshopcoords[i][1], skinshopcoords[i][2], skinshopcoords[i][3]-1, 1.1, 255, 3, 30, 100)
			if(IsPlayerNearCoords(skinshopcoords[i][1], skinshopcoords[i][2], skinshopcoords[i][3], 1)) then
				PrintText("Press ~y~E ~w~to ~y~open clothes shop menu", 1)
				if(IsGameKeyboardKeyJustPressed(18)) then
					SetCharCoordinates(GetPlayerChar(-1), skinshopcoords[i][1], skinshopcoords[i][2], skinshopcoords[i][3])
					SetCharHeading(GetPlayerChar(-1), skinshopcoords[i][4])
					SetPlayerControl(GetPlayerId(), false)
					::main::
					local clothtempitems = {}
					clothtempitems[#clothtempitems+1] = "Skin"
					clothtempitems[#clothtempitems+1] = "Head"
					clothtempitems[#clothtempitems+1] = "Torso"
					clothtempitems[#clothtempitems+1] = "Legs"
					clothtempitems[#clothtempitems+1] = "Hair"
					clothtempitems[#clothtempitems+1] = "Face"
					clothtempitems[#clothtempitems+1] = "Hands"
					clothtempitems[#clothtempitems+1] = "Misc"
					clothtempitems[#clothtempitems+1] = "Hat"
					clothtempitems[#clothtempitems+1] = "Glasses"
					local amount = 0
					for j=1,#currparts,1 do
						if(j == 1) then
							if(currparts[j] ~= GetCharModel(GetPlayerChar(-1), _i)) then
								amount = amount + 1
							end
						elseif(j>=2 and j<=8) then
							if(currparts[j] ~= GetCharDrawableVariation(GetPlayerChar(-1), bodyparts2[j-1])) then
								amount = amount + 1
							end
						elseif(j>=9 and j<=15) then
							if(currparts[j] ~= GetCharTextureVariation(GetPlayerChar(-1), bodyparts2[j-8])) then
								amount = amount + 1
							end
						elseif(j == 16) then
							if(currparts[j] ~= GetCharPropIndex(GetPlayerChar(-1), 0, _i)) then
								amount = amount + 1
							end
						elseif(j == 17) then
							if(currparts[j] ~= GetCharPropIndex(GetPlayerChar(-1), 1, _i)) then
								amount = amount + 1
							end
						end
					end
					clothtempitems[#clothtempitems+1] = "Purchase ~g~(" .. 200*amount .. "$)"
					DrawClothWindow("Clothes_shop", clothtempitems)
					while clothmenuactive do
						Wait(0)
						SetPlayerControl(GetPlayerId(), false)
						if(IsMouseButtonPressed(1)) then
							SetCamActive(GetGameCam(), true)
						else
							SetCamActive(GetGameCam(), false)
						end
					end
					if(clothmenuresult > 0) then
						if(clothtempitems[clothmenuresult] == "Skin") then
							--[[::gender::
							DrawClothWindow("Gender", {"Male 1", "Female 1", "Male 2", "Female 2", "Male 3", "Female 3"})
							while clothmenuactive do
								Wait(0)
								SetPlayerControl(GetPlayerId(), false)
								if(IsMouseButtonPressed(1)) then
									SetCamActive(GetGameCam(), true)
								else
									SetCamActive(GetGameCam(), false)
								end
							end
							if(clothmenuresult > 0) then]]
								local male = {
								"M_Y_MULTIPLAYER",
								"M_M_BUSINESS_03",
								"M_M_EE_HEAVY_01",
								"M_M_EE_HEAVY_02",
								"M_M_FATMOB_01",
								"M_M_GAYMID",
								"M_M_GENBUM_01",
								"M_M_LOONYWHITE",
								"M_M_MIDTOWN_01",
								"M_M_PBUSINESS_01",
								"M_M_PEASTEURO_01",
								"M_M_PHARBRON_01",
								"M_M_PINDUS_02",
								"M_M_PITALIAN_01",
								"M_M_PITALIAN_02",
								"M_M_PLATIN_01",
								"M_M_PLATIN_02",
								"M_M_PLATIN_03",
								"M_M_PMANHAT_01",
								"M_M_PMANHAT_02",
								"M_M_PORIENT_01",
								"M_M_PRICH_01",
								"M_O_EASTEURO_01",
								"M_O_HASID_01",
								"M_O_MOBSTER",
								"M_O_PEASTEURO_02",
								"M_O_PHARBRON_01",
								"M_O_PJERSEY_01",
								"M_O_STREET_01",
								"M_O_SUITED",
								"M_Y_BOHO_01",
								"M_Y_BOHOGUY_01",
								"M_Y_BRONX_01",
								"M_Y_BUSINESS_01",
								"M_Y_BUSINESS_02",
								"M_Y_CHINATOWN_03",
								"M_Y_CHOPSHOP_01",
								"M_Y_CHOPSHOP_02",
								"M_Y_DODGY_01",
								"M_Y_DORK_02",
								"M_Y_DOWNTOWN_01",
								"M_Y_DOWNTOWN_02",
								"M_Y_DOWNTOWN_03",
								"M_Y_GAYYOUNG",
								"M_Y_GENSTREET_11",
								"M_Y_GENSTREET_16",
								"M_Y_GENSTREET_20",
								"M_Y_GENSTREET_34",
								"M_Y_HARDMAN_01",
								"M_Y_HARLEM_01",
								"M_Y_HARLEM_02",
								"M_Y_HARLEM_04",
								"M_Y_HASID_01",
								"M_Y_LEASTSIDE_01",
								"M_Y_PBRONX_01",
								"M_Y_PCOOL_01",
								"M_Y_PCOOL_02",
								"M_Y_PEASTEURO_01",
								"M_Y_PHARBRON_01",
								"M_Y_PHARLEM_01",
								"M_Y_PJERSEY_01",
								"M_Y_PLATIN_01",
								"M_Y_PLATIN_02",
								"M_Y_PLATIN_03",
								"M_Y_PMANHAT_01",
								"M_Y_PMANHAT_02",
								"M_Y_PORIENT_01",
								"M_Y_PQUEENS_01",
								"M_Y_PRICH_01",
								"M_Y_PVILLBO_01",
								"M_Y_PVILLBO_02",
								"M_Y_PVILLBO_03",
								"M_Y_QUEENSBRIDGE",
								"M_Y_SHADY_02",
								"M_Y_SKATEBIKE_01",
								"M_Y_SOHO_01",
								"M_Y_STREET_01",
								"M_Y_STREET_03",
								"M_Y_STREET_04",
								"M_Y_STREETBLK_02",
								"M_Y_STREETBLK_03",
								"M_Y_STREETPUNK_02",
								"M_Y_STREETPUNK_04",
								"M_Y_STREETPUNK_05",
								"M_Y_TOUGH_05",
								"M_Y_TOURIST_02"
								}
								local female = {
								"F_Y_MULTIPLAYER",
								"F_O_PEASTEURO_02",
								"F_O_PHARBRON_01",
								"F_O_PJERSEY_01",
								"F_O_PORIENT_01",
								"F_O_RICH_01",
								"F_M_BUSINESS_01",
								"F_M_BUSINESS_02",
								"F_M_CHINATOWN",
								"F_M_PBUSINESS",
								"F_M_PEASTEURO_01",
								"F_M_PHARBRON_01",
								"F_M_PJERSEY_01",
								"F_M_PJERSEY_02",
								"F_M_PLATIN_01",
								"F_M_PLATIN_02",
								"F_M_PMANHAT_01",
								"F_M_PMANHAT_02",
								--"F_M_PORIENT_01",
								"F_M_PRICH_01",
								"F_Y_BUSINESS_01",
								"F_Y_CDRESS_01",
								--"F_Y_PBRONX_01",
								"F_Y_PCOOL_01",
								"F_Y_PCOOL_02",
								"F_Y_PEASTEURO_01",
								--"F_Y_PHARBRON_01",
								"F_Y_PHARLEM_01",
								"F_Y_PJERSEY_02",
								"F_Y_PLATIN_01",
								--"F_Y_PLATIN_02",
								"F_Y_PLATIN_03",
								"F_Y_PMANHAT_01",
								"F_Y_PMANHAT_02",
								"F_Y_PMANHAT_03",
								"F_Y_PORIENT_01",
								"F_Y_PQUEENS_01",
								"F_Y_PRICH_01",
								"F_Y_PVILLBO_02",
								"F_Y_SHOP_03",
								"F_Y_SHOP_04",
								"F_Y_SHOPPER_05",
								"F_Y_SOCIALITE",
								"F_Y_STREET_02",
								"F_Y_STREET_05",
								"F_Y_STREET_09",
								"F_Y_STREET_12",
								"F_Y_STREET_30",
								"F_Y_STREET_34",
								"F_Y_TOURIST_01",
								"F_Y_VILLBO_01"
								}
								local tempresult = gender
								::skin::
								local clothtempitems = {}
								if(tempresult == 1) then
									clothtempitems = male
								elseif(tempresult == 2) then
									clothtempitems = female
								end
								DrawClothWindow("Skin", clothtempitems)
								while clothmenuactive do
									Wait(0)
									SetPlayerControl(GetPlayerId(), false)
									if(IsMouseButtonPressed(1)) then
										SetCamActive(GetGameCam(), true)
									else
										SetCamActive(GetGameCam(), false)
									end
								end
								if(clothmenuresult > 0) then
									local model = GetHashKey(clothtempitems[clothmenuresult])
									SetPlayerSkin(model)
									for j=2,8,1 do
										SetCharComponentVariation(GetPlayerChar(-1), bodyparts2[j-1], 0, GetCharTextureVariation(GetPlayerChar(-1), bodyparts2[j-1]))
									end
									ClearCharProp(GetPlayerChar(-1), 0)
									ClearCharProp(GetPlayerChar(-1), 1)
									SetCharCoordinates(GetPlayerChar(-1), skinshopcoords[i][1], skinshopcoords[i][2], skinshopcoords[i][3]-1)
									SetCharHeading(GetPlayerChar(-1), skinshopcoords[i][4])
									SetPlayerControl(GetPlayerId(), false)
									SetRoomForCharByKey(GetPlayerChar(-1), GetKeyForViewportInRoom(GetGameViewportId()))
									goto skin
								else
									goto main
								end
							--else
							--	goto main
							--end
						elseif(clothmenuresult>=2 and clothmenuresult<=8) then
							local comp = clothmenuresult-1
							local tempcomp = clothtempitems[clothmenuresult]
							::comps::
							DrawClothWindow("" .. tempcomp, {"Model", "Variation"})
							while clothmenuactive do
								Wait(0)
								SetPlayerControl(GetPlayerId(), false)
								if(IsMouseButtonPressed(1)) then
									SetCamActive(GetGameCam(), true)
								else
									SetCamActive(GetGameCam(), false)
								end
							end
							if(clothmenuresult > 0) then
								if(clothmenuresult == 1) then
									::comps2::
									local clothtempitems = {}
									for j=0,GetNumberOfCharDrawableVariations(GetPlayerChar(-1), bodyparts2[comp])-1,1 do
										clothtempitems[#clothtempitems+1] = "" .. j
									end
									DrawClothWindow("" .. tempcomp .. "_model", clothtempitems)
									while clothmenuactive do
										Wait(0)
										SetPlayerControl(GetPlayerId(), false)
										if(IsMouseButtonPressed(1)) then
											SetCamActive(GetGameCam(), true)
										else
											SetCamActive(GetGameCam(), false)
										end
									end
									if(clothmenuresult > 0) then
										local tempvar = GetCharTextureVariation(GetPlayerChar(-1), bodyparts2[comp])
										SetCharComponentVariation(GetPlayerChar(-1), bodyparts2[comp], clothmenuresult-1, tempvar)
										goto comps2
									else
										goto comps
									end
								elseif(clothmenuresult == 2) then
									::comps3::
									local clothtempitems = {}
									for j=0,GetNumberOfCharTextureVariations(GetPlayerChar(-1), bodyparts2[comp], GetCharDrawableVariation(GetPlayerChar(-1), bodyparts2[comp]))-1,1 do
										clothtempitems[#clothtempitems+1] = "" .. j
									end
									DrawClothWindow("" .. tempcomp .. "_variation", clothtempitems)
									while clothmenuactive do
										Wait(0)
										SetPlayerControl(GetPlayerId(), false)
										if(IsMouseButtonPressed(1)) then
											SetCamActive(GetGameCam(), true)
										else
											SetCamActive(GetGameCam(), false)
										end
									end
									if(clothmenuresult > 0) then
										local tempvar = GetCharDrawableVariation(GetPlayerChar(-1), bodyparts2[comp])
										SetCharComponentVariation(GetPlayerChar(-1), bodyparts2[comp], tempvar, clothmenuresult-1)
										goto comps3
									else
										goto comps
									end
								end
							else
								goto main
							end
						elseif(clothmenuresult == 9) then
							::hat::
							clothtempitems = {}
							for j=0,7,1 do
								clothtempitems[#clothtempitems+1] = "" .. j
							end
							clothtempitems[#clothtempitems+1] = "No hat"
							DrawClothWindow("Hat", clothtempitems)
							while clothmenuactive do
								Wait(0)
								SetPlayerControl(GetPlayerId(), false)
								if(IsMouseButtonPressed(1)) then
									SetCamActive(GetGameCam(), true)
								else
									SetCamActive(GetGameCam(), false)
								end
							end
							if(clothmenuresult > 0) then
								if(clothmenuresult ~= #clothtempitems) then
									ClearCharProp(GetPlayerChar(-1), 0)
									SetCharPropIndex(GetPlayerChar(-1), 0, clothmenuresult-1)
								else
									ClearCharProp(GetPlayerChar(-1), 0)
								end
								goto hat
							else
								goto main
							end
						elseif(clothmenuresult == 10) then
							::glasses::
							clothtempitems = {}
							for j=0,7,1 do
								clothtempitems[#clothtempitems+1] = "" .. j
							end
							clothtempitems[#clothtempitems+1] = "No glasses"
							DrawClothWindow("Glasses", clothtempitems)
							while clothmenuactive do
								Wait(0)
								SetPlayerControl(GetPlayerId(), false)
								if(IsMouseButtonPressed(1)) then
									SetCamActive(GetGameCam(), true)
								else
									SetCamActive(GetGameCam(), false)
								end
							end
							if(clothmenuresult > 0) then
								if(clothmenuresult ~= #clothtempitems) then
									ClearCharProp(GetPlayerChar(-1), 1)
									SetCharPropIndex(GetPlayerChar(-1), 1, clothmenuresult-1)
								else
									ClearCharProp(GetPlayerChar(-1), 1)
								end
								goto glasses
							else
								goto main
							end
						elseif(clothtempitems[clothmenuresult] == "Purchase ~g~(" .. 200*amount .. "$)") then
							if(inventory[34] >= 200*amount) then
								RemoveItem(34, 200*amount )
								SaveStats()
								for j=1,#currparts,1 do
									if(j == 1) then
										currparts[j] = GetCharModel(GetPlayerChar(-1), _i)
									elseif(j>=2 and j<=8) then
										currparts[j] = GetCharDrawableVariation(GetPlayerChar(-1), bodyparts2[j-1])
									elseif(j>=9 and j<=15) then
										currparts[j] = GetCharTextureVariation(GetPlayerChar(-1), bodyparts2[j-8])
									else
										currparts[16] = GetCharPropIndex(GetPlayerChar(-1), 0)
										currparts[17] = GetCharPropIndex(GetPlayerChar(-1), 1)
									end
								end
								SaveParts()
								AddIncomeToBiz(biznames[i], 200*amount)
								Notify('Purchase is successful.')
								goto main
							else
								Notify('You do not have enough money.')
								goto main
							end
						end
					else
						SetCamActive(GetGameCam(), true)
						SetPlayerControl(GetPlayerId(), true)
						--[[for i=1,9,1 do
							if(i == 1) then
								local model = currparts[1]
								RequestModel(model)
								while not HasModelLoaded(model) do
									Wait(0)
								end
								ChangePlayerModel(GetPlayerId(), model)
								--MarkModelAsNoLongerNeeded(model)
							elseif(i>=2 and i<=8) then
								SetCharComponentVariation(GetPlayerChar(-1), bodyparts2[i-1], currparts[i], currparts[i+7])
							else
								SetCharPropIndex(GetPlayerChar(-1), 0, currparts[16])
								SetCharPropIndex(GetPlayerChar(-1), 1, currparts[17])
							end
						end
						--SetRoomForCharByKey(GetPlayerChar(-1), GetKeyForCharInRoom(GetPlayerChar(-1), _i))
						SetRoomForCharByKey(GetPlayerChar(-1), GetKeyForViewportInRoom(GetGameViewportId()))
						for i=1,8,1 do
							GiveWeaponToChar(GetPlayerChar(-1), weps[i][1], weps[i][2], 1)
						end]]
						SetDefaultSkin()
					end
				end
			end
		end
	end
end)

clothmenuactive = false
clothmenuresult = 0
currlist = 1
currbutton = 0
DrawClothWindow = function(title, items, colors)
	clothmenuactive = true
	clothmenuresult = 0
	--currlist = 1
	currbutton = 0
	cursor = 1
	SetCamActive(GetGameCam(), false)
	SetPlayerControl(GetPlayerId(), false)
	--items[#items+1] = "~r~Cancel"
	CreateThread(function()
		while clothmenuactive do
			Wait(0)
			SetPlayerControl(GetPlayerId(), false)
			local tempcancel = 0
			for i=1,#items,1 do
				if(items[i] == "~r~Cancel") then
					tempcancel = tempcancel + 1
					if(tempcancel > 1) then
						items[i] = nil
					end
				end
			end
			
			SetTextScale(0.200000,  0.4000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			SetTextFont(6)
			--SetTextEdge(1, 0, 0, 0, 255)
			SetTextWrap(0.0, 0.85)
			SetTextCentre(1)
			DisplayTextWithLiteralString(0.85, 0.065, "STRING", GetStringWithoutSpaces("" .. title))
			
			DrawRectLeftTopCenter(0.75, 0.05, 0.2, 0.05, 0, 0, 100, 255)
			--DrawCurvedWindow(0.3, 0.28, 0.4, 0.42, 100)
			--DrawRectLeftTopCenter(0.7, 0.1, 0.2, 0.3, 90, 90, 90, 100)
			currbutton = 0
			if(#items > 0) then
				if(#items > 11) then
					local templist = {}
					local number = #items
					local finalnum = 0
					
					::retry::
					finalnum = finalnum + 1
					number = number - 11
					if(number > 11) then
						goto retry
					else
						finalnum = finalnum + 1
					end
					
					for i=1,finalnum,1 do
						templist[i] = {}
						for j=1,11,1 do
							if(items[11*(i-1)+j] ~= nil) then
								templist[i][j] = items[11*(i-1)+j]
							end
						end
					end
					
					if(currlist > finalnum) then
						currlist = 1
					end
					
					local sep = 11
					for i=1,#templist,1 do
						if(currlist == i) then
							for j=1,#templist[i],1 do
								SetTextScale(0.1500000,  0.3000000)
								SetTextDropshadow(0, 0, 0, 0, 0)
								SetTextFont(6)
								SetTextEdge(1, 0, 0, 0, 255)
								SetTextWrap(0.0, 0.85)
								SetTextCentre(1)
								DisplayTextWithLiteralString(0.85, 0.41, "STRING", "Page:_" .. currlist .. "/" .. #templist .. "_|_LMB_-_Select_/_RMB_-_Cancel_/_Wheel_-_Scroll")
								
								if(colors~=nil and colors[11*(i-1)+j]~=nil) then
									DrawRectLeftTopCenter(0.75, 0.1+0.3/sep*(j-1), 0.2, 0.3/sep, colors[11*(i-1)+j][1], colors[11*(i-1)+j][2], colors[11*(i-1)+j][3], 100)
								else
									DrawRectLeftTopCenter(0.75, 0.1+0.3/sep*(j-1), 0.2, 0.3/sep, 0, 0, 0, 100)
								end
								SetTextScale(0.1500000,  0.3000000)
								SetTextDropshadow(0, 0, 0, 0, 0)
								--SetTextFont(6)
								--SetTextEdge(1, 0, 0, 0, 255)
								--SetTextWrap(0.0, 0.3)
								--SetTextCentre(1)
								DisplayTextWithLiteralString(0.75+0.005, 0.1+0.3/sep*(j-1)+0.005, "STRING", "" .. templist[i][j])
								if(IsCursorInAreaLeftTopCenter(0.75, 0.1+0.3/sep*(j-1), 0.2, 0.3/sep)) then
									currbutton = j+11*(i-1)
									if(colors~=nil and colors[11*(i-1)+j]~=nil) then
										DrawRectLeftTopCenter(0.75, 0.1+0.3/sep*(j-1), 0.2, 0.3/sep, colors[11*(i-1)+j][1], colors[11*(i-1)+j][2], colors[11*(i-1)+j][3], 255)
									else
										DrawRectLeftTopCenter(0.75, 0.1+0.3/sep*(j-1), 0.2, 0.3/sep, 255, 255, 255, 255)
									end
									SetTextScale(0.1500000,  0.3000000)
									SetTextDropshadow(0, 0, 0, 0, 0)
									--SetTextFont(6)
									--SetTextEdge(1, 0, 0, 0, 255)
									--SetTextWrap(0.0, 0.3)
									--SetTextCentre(1)
									SetTextColour(0, 0, 0, 255)
									DisplayTextWithLiteralString(0.75+0.005, 0.1+0.3/sep*(j-1)+0.005, "STRING", "" .. templist[i][j])
									if(IsMouseButtonJustPressed(1)) then
										if(11*(i-1)+j ~= "~r~Cancel") then
											clothmenuresult = 11*(i-1)+j
										end
										clothmenuactive = false
										cursor = 0
									end
								end
								if(IsGameKeyboardKeyJustPressed(j+1)) then
									--if(10*(i-1)+j ~= #items) then
										clothmenuresult = 11*(i-1)+j
									--end
									clothmenuactive = false
									cursor = 0
								end
								if(IsMouseButtonJustPressed(2)) then
									clothmenuactive = false
									cursor = 0
									goto finish
								end
							end
						end
					end
					if(GetMouseWheel(_i) ~= 0) then
						if(GetMouseWheel(_i) == 127) then
							if(currlist < #templist) then
								currlist = currlist + 1
							end
						else
							if(currlist > 1) then
								currlist = currlist - 1
							end
						end
					end
				else
					local sep = 0
					if(#items <= 11) then
						sep = 11
					else
						sep = #items
					end
					for i=1,#items,1 do
						SetTextScale(0.1500000,  0.3000000)
						SetTextDropshadow(0, 0, 0, 0, 0)
						SetTextFont(6)
						SetTextEdge(1, 0, 0, 0, 255)
						SetTextWrap(0.0, 0.85)
						SetTextCentre(1)
						DisplayTextWithLiteralString(0.85, 0.1+0.3/sep*#items+0.01, "STRING", "LMB_-_Select_/_RMB_-_Cancel")
						
						if(colors~=nil and colors[i]~=nil) then
							DrawRectLeftTopCenter(0.75, 0.1+0.3/sep*(i-1), 0.2, 0.3/sep, colors[i][1], colors[i][2], colors[i][3], 100)
						else
							DrawRectLeftTopCenter(0.75, 0.1+0.3/sep*(i-1), 0.2, 0.3/sep, 0, 0, 0, 100)
						end
						SetTextScale(0.1500000,  0.3000000)
						SetTextDropshadow(0, 0, 0, 0, 0)
						--SetTextFont(6)
						--SetTextEdge(1, 0, 0, 0, 255)
						--SetTextWrap(0.0, 0.3)
						--SetTextCentre(1)
						DisplayTextWithLiteralString(0.75+0.005, 0.1+0.3/sep*(i-1)+0.005, "STRING", "" .. items[i])
						if(IsCursorInAreaLeftTopCenter(0.75, 0.1+0.3/sep*(i-1), 0.2, 0.3/sep)) then
							currbutton = i
							if(colors~=nil and colors[i]~=nil) then
								DrawRectLeftTopCenter(0.75, 0.1+0.3/sep*(i-1), 0.2, 0.3/sep, colors[i][1], colors[i][2], colors[i][3], 255)
							else
								DrawRectLeftTopCenter(0.75, 0.1+0.3/sep*(i-1), 0.2, 0.3/sep, 255, 255, 255, 255)
							end
							SetTextScale(0.1500000,  0.3000000)
							SetTextDropshadow(0, 0, 0, 0, 0)
							--SetTextFont(6)
							--SetTextEdge(1, 0, 0, 0, 255)
							--SetTextWrap(0.0, 0.3)
							--SetTextCentre(1)
							SetTextColour(0, 0, 0, 255)
							DisplayTextWithLiteralString(0.75+0.005, 0.1+0.3/sep*(i-1)+0.005, "STRING", "" .. items[i])
							if(IsMouseButtonJustPressed(1)) then
								--if(i ~= #items) then
								if(items[i] ~= "~r~Cancel") then
									clothmenuresult = i
								end
								clothmenuactive = false
								cursor = 0
							end
						end
						if(IsGameKeyboardKeyJustPressed(i+1)) then
							if(items[i] ~= "~r~Cancel") then
								clothmenuresult = i
							end
							clothmenuactive = false
							cursor = 0
						end
						if(IsMouseButtonJustPressed(2)) then
							clothmenuactive = false
							cursor = 0
							goto finish
						end
					end
				end
			else
				SetTextScale(0.1500000,  0.3000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextFont(6)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextWrap(0.0, 0.85)
				SetTextCentre(1)
				DisplayTextWithLiteralString(0.85, 0.1+0.01, "STRING", "RMB_-_Cancel")
				
				if(IsMouseButtonJustPressed(2)) then
					clothmenuactive = false
					cursor = 0
					goto finish
				end
			end
		end
		Wait(1000)
		::finish::
		if not clothmenuactive then
			SetCamActive(GetGameCam(), true)
			SetPlayerControl(GetPlayerId(), true)
			SetGameCameraControlsActive(true)
			--ClearCharTasksImmediately(GetPlayerChar(-1))
		end
	end)
end