
Draw3dMark = function(txt, x, y, z, radius)
	if(IsPlayerNearCoords(x, y, z, 30)) then
		local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
		local dist = GetDistanceBetweenCoords3d(x, y, z, px, py, pz)
		local model = GetHashKey("cj_can_drink_1")
		if(not DoesObjectExist(tempobj)) then
			RequestModel(model)
			while not HasModelLoaded(model) do
				Wait(0)
			end
			tempobj = CreateObject(model, x, y, z, 1)
			SetObjectVisible(tempobj, false)
		end
		if(dist < radius) then
			SetObjectCoordinates(tempobj, x, y, z)
			if(IsObjectOnScreen(tempobj)) then
				local bv,cx,cy = GetViewportPositionOfCoord(x, y, z, GetGameViewportId())
				local sx,sy = GetScreenResolution()
				if(cx>0 and cx<sx) then
					cx = cx/sx
				else
					cx = 0
				end
				if(cy>0 and cy<sy) then
					cy = cy/sy
				else
					cy = 0
				end
				if(cx>0 and cy>0) then
					local mult = radius - dist
					DisplaySprite("interface", txt, cx, cy, 0.025+0.015/radius*mult, 0.05+0.015/radius*mult, 0.0, 255, 255, 255, 255)
				end
			end
		end
	end
end
IsPlayerNearCoords = function(x, y, z, radius, id)
    local tempid = ConvertIntToPlayerindex(GetPlayerId())
	if id then
		tempid = id
	end
	local px,py,pz = GetCharCoordinates(GetPlayerChar(tempid))
	local dist = GetDistanceBetweenCoords3d(px, py, pz, x, y, z)
    if(dist < radius) then
		return true
    else
		return false
    end
end

RegisterNetEvent('setPlayerPos')
AddEventHandler('setPlayerPos', function(id, x, y, z, h)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
	--if(GetPlayerChar(id) == GetPlayerChar(-1)) then
		if(IsCharInAnyCar(GetPlayerChar(-1))) then
			SetCarCoordinates(GetCarCharIsUsing(GetPlayerChar(-1)), x, y, z)
			SetCarHeading(GetCarCharIsUsing(GetPlayerChar(-1)), h)
			SetCarOnGroundProperly(GetCarCharIsUsing(GetPlayerChar(-1)))
		else
			SetCharCoordinates(GetPlayerChar(-1), x, y, z)
			SetCharHeading(GetPlayerChar(-1), h)
		end
	end
end)

--[[SpawnCar = function(model, x, y, z, h)
	RequestModel(model)
	while not HasModelLoaded(model) do 
		Wait(0)
		RequestModel(model)
	end
	RequestCollisionAtPosn(x, y, z)
	local veh = CreateCar(model, x, y, z, true)
	MarkModelAsNoLongerNeeded(model)
	SetCarHeading(veh, h)
	SetCarOnGroundProperly(veh)
	SetVehicleDirtLevel(veh, 0.0)
	WashVehicleTextures(veh, 255)
	SetCarEngineOn(veh, 1, 1)
	SetNetworkIdCanMigrate(GetNetworkIdFromVehicle(veh), false)
	SetCarAsMissionCar(veh, true)
	SetCarExistsOnAllMachines(veh, true)
	SetNetworkIdExistsOnAllMachines(GetNetworkIdFromVehicle(veh), true)
	return veh
end

SpawnPed = function(model, x, y, z, h, k)
	RequestModel(model)
	while not HasModelLoaded(model) do 
		Wait(0)
		RequestModel(model)
	end
	RequestCollisionAtPosn(x, y, z)
	local ped = CreateChar(1, model, x, y, z, true)
	MarkModelAsNoLongerNeeded(model)
	if k then
		ActivateInterior(GetInteriorAtCoords(x, y, z, _i), true)
		LoadSceneForRoomByKey(GetInteriorAtCoords(x, y, z), k)
		SetRoomForCharByKey(ped, k)
	end
	SetCharHeading(ped, h)
	SetNetworkIdCanMigrate(GetNetworkIdFromPed(ped), false)
	SetCharAsMissionChar(ped, true)
	SetPedExistsOnAllMachines(ped, true)
	SetNetworkIdExistsOnAllMachines(GetNetworkIdFromPed(ped), true)
	return ped
end

SpawnObject = function(model, x, y, z, h, k)
	RequestModel(model)
	while not HasModelLoaded(model) do 
		Wait(0)
		RequestModel(model)
	end
	RequestCollisionAtPosn(x, y, z)
	local obj = CreateObjectNoOffset(model, x, y, z, 1)
	MarkModelAsNoLongerNeeded(model)
	if k then
		ActivateInterior(GetInteriorAtCoords(x, y, z, _i), true)
		LoadSceneForRoomByKey(GetInteriorAtCoords(x, y, z), k)
		AddObjectToInteriorRoomByKey(obj, k)
	end
	SetObjectHeading(obj, h)
	SetNetworkIdCanMigrate(GetNetworkIdFromObject(obj), false)
	SetNetworkIdExistsOnAllMachines(GetNetworkIdFromObject(obj), true)
	return obj
end]]


local performance = false
RegisterNetEvent('ShowPerformance')
AddEventHandler('ShowPerformance', function()
	if performance == false then
		performance = true
	else
		performance = false
	end
end)

fps = 0
ping = 0
CreateThread(function()
	while true do
		Wait(1000)
		if(IsNetworkPlayerActive(GetPlayerId())) then
			fps = math.floor(1/GetFrameTime())
			if(IsGameKeyboardKeyPressed(PlayerListKey)) then
				TriggerServerEvent('ping')
			end
		end
	end
end)

RegisterNetEvent('ping')
AddEventHandler('ping', function(p)
	ping = p
end)
CreateThread(function()
	while true do
		Wait(0)
		if(performance == true) then
			TriggerServerEvent('ping')
			Wait(5000)
		end
	end
end)
CreateThread(function()
	while true do
		Wait(0)
		if(performance == true) then
			SetTextScale(0.150000,  0.3000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			SetTextCentre(1)
			DisplayTextWithLiteralString(0.02, 0.003, "STRING", "FPS: " .. fps)
			DrawRect(0.01, 0.00, 0.059, 0.05, 0, 0, 0, 200)

			SetTextScale(0.150000,  0.3000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			SetTextCentre(1)
			DisplayTextWithLiteralString(0.068, 0.003, "STRING", "Ping: " .. ping)
			DrawRect(0.01+0.058, 0.00, 0.053, 0.05, 0, 0, 0, 200)
		end
		if(loginform == 0) then
			if(IsGameKeyboardKeyPressed(PlayerListKey)) then
				DrawRectLeftTopCenter(0.4, 0.1, 0.2, 0.03, 0, 0, 0, 100)
				SetTextScale(0.1500000,  0.3000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextFont(6)
				SetTextEdge(1, 0, 0, 0, 255)
				--SetTextRightJustify(1)
				--SetTextWrap(0.0, 0.995)
				--SetTextCentre(1)
				DisplayTextWithLiteralString(0.41, 0.105, "STRING", "Players:_" .. GetNumberOfPlayers() .. "/32")

				SetTextScale(0.1500000,  0.3000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextFont(6)
				SetTextEdge(1, 0, 0, 0, 255)
				DisplayTextWithLiteralString(0.465, 0.07, "STRING", "Police:_" .. coponline .. "__Medic:_" ..emsonline)

				SetTextScale(0.1500000,  0.3000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextFont(6)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextRightJustify(1)
				SetTextWrap(0.0, 0.59)
				DisplayTextWithLiteralString(0.59, 0.105, "STRING", "FPS:_" .. fps .. "_|_Ping:_" .. ping)
				local templist = {}
				for i=0,31,1 do
					if(IsNetworkPlayerActive(i)) then
						templist[#templist+1] = i
					end
				end
				for i=1,#templist,1 do
					DrawRectLeftTopCenter(0.4, 0.1+0.029*i, 0.2, 0.025, 0, 0, 0, 100)
					--local r,g,b = GetPlayerRgbColour(ConvertIntToPlayerindex(templist[i]), _i, _i, _i)
					SetTextScale(0.1500000,  0.3000000)
					SetTextDropshadow(0, 0, 0, 0, 0)
					--SetTextFont(6)
					SetTextEdge(1, 0, 0, 0, 255)
					--SetTextRightJustify(1)
					--SetTextWrap(0.0, 0.995)
					SetTextCentre(1)
					SetTextColour(255, 255, 255, 255)
					DisplayTextWithLiteralString(0.5, 0.005+0.1+0.025*i, "STRING", "" .. GetPlayerName(templist[i]))
				end
			end
		end
	end
end)

DrawRectLeftTopCenter = function(x, y, width, height, r, g, b, a)
	DrawRect(x+width/2, y+height/2, width, height, r, g, b, a)
end

DrawCheckpointWithDist = function(x, y, z, radius, r, g, b, a)
	if(IsPlayerNearCoords(x, y, z, 50)) then
		DrawCheckpointWithAlpha(x, y, z, radius, r, g, b, a)
	end
end

PrintText = function(text, time)
    -- Remove anything between tildes (e.g. ~g~, ~b~, ~ANYTHING~)
    exports.screentext:DisplayText(text)
end


menuactive = false
menuresult = 0
currlist = 1
currbutton = 0
DrawWindow = function(title, items, colors)
	menuactive = true
	menuresult = 0
	--currlist = 1
	currbutton = 0
	cursor = 1
	SetCamActive(GetGameCam(), false)
	SetPlayerControl(GetPlayerId(), false)
	--items[#items+1] = "~r~Cancel"
	CreateThread(function()
		while menuactive do
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
			
			DrawRectLeftTopCenter(0.75, 0.05, 0.2, 0.05, 255, 0, 50, 200)
			--DrawCurvedWindow(0.3, 0.28, 0.4, 0.42, 100)
			--DrawRectLeftTopCenter(0.7, 0.1, 0.2, 0.3, 90, 90, 90, 100)
			currbutton = 0
			if(#items > 0) then
				if(#items > 10) then
					local templist = {}
					local number = #items
					local finalnum = 0
					
					::retry::
					finalnum = finalnum + 1
					number = number - 10
					if(number > 10) then
						goto retry
					else
						finalnum = finalnum + 1
					end
					
					for i=1,finalnum,1 do
						templist[i] = {}
						for j=1,10,1 do
							if(items[10*(i-1)+j] ~= nil) then
								templist[i][j] = items[10*(i-1)+j]
							end
						end
					end
					
					if(currlist > finalnum) then
						currlist = 1
					end
					
					local sep = 10
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
								
								if(colors~=nil and colors[10*(i-1)+j]~=nil) then
									DrawRectLeftTopCenter(0.75, 0.1+0.3/sep*(j-1), 0.2, 0.3/sep, colors[10*(i-1)+j][1], colors[10*(i-1)+j][2], colors[10*(i-1)+j][3], 100)
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
									currbutton = j+10*(i-1)
									if(colors~=nil and colors[10*(i-1)+j]~=nil) then
										DrawRectLeftTopCenter(0.75, 0.1+0.3/sep*(j-1), 0.2, 0.3/sep, colors[10*(i-1)+j][1], colors[10*(i-1)+j][2], colors[10*(i-1)+j][3], 255)
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
										if(10*(i-1)+j ~= "~r~Cancel") then
											menuresult = 10*(i-1)+j
										end
										menuactive = false
										cursor = 0
									end
								end
								if(IsGameKeyboardKeyJustPressed(j+1)) then
									--if(10*(i-1)+j ~= #items) then
										menuresult = 10*(i-1)+j
									--end
									menuactive = false
									cursor = 0
								end
								if(IsMouseButtonJustPressed(2)) then
									menuactive = false
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
					if(#items <= 10) then
						sep = 10
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
									menuresult = i
								end
								menuactive = false
								cursor = 0
							end
						end
						if(IsGameKeyboardKeyJustPressed(i+1)) then
							if(items[i] ~= "~r~Cancel") then
								menuresult = i
							end
							menuactive = false
							cursor = 0
						end
						if(IsMouseButtonJustPressed(2)) then
							menuactive = false
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
					menuactive = false
					cursor = 0
					goto finish
				end
			end
		end
		Wait(1000)
		::finish::
		if not menuactive then
			SetCamActive(GetGameCam(), true)
			SetPlayerControl(GetPlayerId(), true)
			SetGameCameraControlsActive(true)
			--ClearCharTasksImmediately(GetPlayerChar(-1))
		end
	end)
end

WorldToScreen = function(x, y, z)
	if(not DoesObjectExist(tempobj)) then
		local model = GetHashKey("cj_can_drink_1")
		RequestModel(model)
		while not HasModelLoaded(model) do
			Wait(0)
		end
		tempobj = CreateObjectNoOffset(model, x, y, z, _i, 1)
		SetObjectVisible(tempobj, false)
	end
	SetObjectCoordinates(tempobj, x, y, z)
	if(IsObjectOnScreen(tempobj)) then
		local bv,cx,cy = GetViewportPositionOfCoord(x, y, z, GetGameViewportId(_i), _f, _f)
		local sx,sy = GetScreenResolution(_i, _i)
		if(cx>0 and cx<sx) then
			cx = cx/sx
		else
			return false,0,0
		end
		if(cy>0 and cy<sy) then
			cy = cy/sy
		else
			return false,0,0
		end
		return true,cx,cy
	else
		return false,0,0
	end
end

DrawTextAtCoord = function(x, y, z, text, radius)
	local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
	local dist = GetDistanceBetweenCoords3d(x, y, z, px, py, pz)
	if(dist < radius) then
		local bv,cx,cy = WorldToScreen(x, y, z)
		if bv then
			local mult = radius - dist
			SetTextScale(0.300000/radius*mult, 0.6000000/radius*mult)
			SetTextDropshadow(0, 0, 0, 0, 0)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextWrap(0.0, cx)
			SetTextCentre(1)
			DisplayTextWithLiteralString(cx, cy, "STRING", "" .. text)
		end
	end
end

DrawDescription = function(title, text)
	SetTextScale(0.200000,  0.4000000)
	SetTextDropshadow(0, 0, 0, 0, 0)
	SetTextFont(6)
	--SetTextEdge(1, 0, 0, 0, 255)
	--SetTextWrap(0.0, 0.85)
	SetTextCentre(1)
	DisplayTextWithLiteralString(0.5, 0.065, "STRING", "" .. title)
	DrawRectLeftTopCenter(0.3, 0.05, 0.4, 0.05, 0, 0, 100, 255)
	
	for i=1,#text,1 do
		DrawRectLeftTopCenter(0.3, 0.1+0.3/10*(i-1), 0.4, 0.3/10, 0, 0, 0, 100)
		SetTextScale(0.1500000,  0.3000000)
		SetTextDropshadow(0, 0, 0, 0, 0)
		--SetTextFont(6)
		--SetTextEdge(1, 0, 0, 0, 255)
		--SetTextWrap(0.0, 0.3)
		--SetTextCentre(1)
		DisplayTextWithLiteralString(0.3+0.005, 0.1+0.3/10*(i-1)+0.005, "STRING", "" .. text[i])
	end
end

RemoveFromTable = function(t, id)
	local newtable = {}
	for i=1,#t,1 do
		if(i ~= id) then
			newtable[#newtable+1] = t[i]
		end
	end
	return newtable
end

SetPlayerSkin = function(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(0)
		RequestModel(model)
	end
	local hp = GetCharHealth(GetPlayerChar(-1))
	local ap = GetCharArmour(GetPlayerChar(-1))
	ChangePlayerModel(GetPlayerId(), model)
	MarkModelAsNoLongerNeeded(model)
	if(IsInteriorScene() and GetKeyForViewportInRoom(GetGameViewportId())~=0) then
		SetRoomForCharByKey(GetPlayerChar(-1), GetKeyForViewportInRoom(GetGameViewportId()))
	end
	SetCharHealth(GetPlayerChar(-1), hp)
	AddArmourToChar(GetPlayerChar(-1), ap)
end

RegisterNetEvent('sendMessageToPlayer')
AddEventHandler('sendMessageToPlayer', function(id, message)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		Notify(message)
	end
end)
RegisterNetEvent('sendMessageToEveryone')
AddEventHandler('sendMessageToEveryone', function(message)
	Notify(message)
	TriggerServerEvent('SendMessage', "", message, 5, 6)
end)

Notify = function(message, num)
	TriggerEvent('noticeme:Info', message)
end

SendMessageToNearbyPlayers = function(message, radius)
	for i=0,31,1 do
		if(IsNetworkPlayerActive(i)) then
			local px,py,pz = GetCharCoordinates(GetPlayerChar(i))
			if(IsPlayerNearCoords(px, py, pz, radius)) then
				TriggerServerEvent('sendMessageToPlayer', i, message)
			end
		end
	end
end

CheckFaction = function(id, player)
	local ped = GetPlayerChar(-1)
	if(player ~= nil) then
		ped = GetPlayerChar(player)
	end
	local model = GetCharModel(ped)
	if(id == "Police") then
		if(IsCharModel(ped, GetHashKey("M_Y_COP")) or IsCharModel(ped, GetHashKey("M_Y_COP"))) then
			return true
		else
			return false
		end
	elseif(id == "Medic") then
		if(IsCharModel(ped, GetHashKey("M_Y_PMEDIC")) or IsCharModel(ped, GetHashKey("F_Y_NURSE"))) then
			return true
		else
			return false
		end
	elseif(id == "Spanish Lords") then
		if(IsCharModel(ped, GetHashKey("m_y_glat_lo_02")) or IsCharModel(ped, GetHashKey("f_m_platin_02"))) then
			return true
		else
			return false
		end
	elseif(id == "Yardies") then
		if(IsCharModel(ped, GetHashKey("m_m_gjam_hi_01")) or IsCharModel(ped, GetHashKey("f_y_pharbron_01"))) then
			return true
		else
			return false
		end
	elseif(id == "Hustlers") then
		if(IsCharModel(ped, GetHashKey("m_y_gafr_hi_02")) or IsCharModel(ped, GetHashKey("f_y_pbronx_01"))) then
			return true
		else
			return false
		end
	elseif(id == "NOOSE") then
		if(IsCharModel(ped, GetHashKey("M_Y_SWAT")) or IsCharModel(ped, GetHashKey("M_Y_SWAT"))) then
			return true
		else
			return false
		end
	end
end

RegisterNetEvent('sendMoneyToPlayer')
AddEventHandler('sendMoneyToPlayer', function(id, sender, amount)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		AddItem(34, amount)
							
		SaveStats()
		SendMessageToNearbyPlayers("" .. GetPlayerName(sender) .. " has given cash to " .. GetPlayerName(GetPlayerId()) .. ".", 20)
		Notify("You have received " .. amount .. "$ from " .. GetPlayerName(sender) .. ".")
	end
end)
RegisterNetEvent('sendMoneyToPlayer2')
AddEventHandler('sendMoneyToPlayer2', function(id, sender, amount)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		AddItem(34, amount)
							
		SaveStats()
		Notify("You have received " .. amount .. "$ from " .. GetPlayerName(sender) .. " via bank transfer.")
	end
end)
RegisterNetEvent('addMoneyToPlayer')
AddEventHandler('addMoneyToPlayer', function(id, amount)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		AddItem(34, amount)
							
		SaveStats()
	end
end)

GetPlayerSeat = function()
	local player = GetPlayerChar(-1)
	local car = GetCarCharIsUsing(player)
	if(GetDriverOfCar(car) == player) then
		return 0
	else
		for i=0,2,1 do
			if(not IsCarPassengerSeatFree(car, i)) then
				if(GetCharInCarPassengerSeat(car, i) == player) then
					return i+1
				end
			end
		end
	end
end

local fpv = 0
CreateThread(function()
	while true do
		Wait(0)
		if(loginform == 0) then
			if(IsPlayerControlOn(GetPlayerId())) then
				if(IsGameKeyboardKeyJustPressed(FppKey)) then
					if(fpv == 0) then
						--SetCamActive(GetGameCam(), false)
						fpcam = CreateCam(14, _i)
						SetCamPropagate(fpcam, 1)
						SetCamActive(fpcam, true)
						ActivateScriptedCams(1, 1)
						local bp = GetPedBonePosition(GetPlayerChar(-1), 0x4B5, 0, 0, 0)
						SetCamPos(fpcam, bp.x, bp.y, bp.z)
						SetCamRot(fpcam, 0.0, 0.0, GetCharHeading(GetPlayerChar(-1)))
						if(not DoesObjectExist(camobj)) then
							local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
							camobj = SpawnObject(GetHashKey("cj_can_drink_1"), px, py, pz, 0.0)
							SetObjectStopCloning(camobj, true)
						end
						fpcam2 = CreateCam(14, _i)
						fpv = 1
					else
						SetCamActive(fpcam, false)
						--SetCamActive(GetGameCam(), true)
						SetCamPropagate(fpcam, 0)
						SetCamPropagate(GetGameCam(), 1)
						ActivateScriptedCams(0, 0)
						DestroyCam(fpcam)
						
						SetCamActive(fpcam2, false)
						--SetCamActive(GetGameCam(), true)
						SetCamPropagate(fpcam2, 0)
						SetCamPropagate(GetGameCam(), 1)
						ActivateScriptedCams(0, 0)
						DestroyCam(fpcam2)
						fpv = 0
					end
				end
				if(DoesObjectExist(camobj)) then
					SetObjectVisible(camobj, false)
				end
				if(fpv == 1) then
					ActivateScriptedCams(1, 1)
					local cx,cy,cz = GetCamRot(GetGameCam())
					local bp = GetPedBonePosition(GetPlayerChar(-1), 0x4B5, 0, 0, 0)
					local pp = GetPedBonePosition(GetPlayerChar(-1), 0, 0, 0, 0)
					local bx = bp.x - pp.x
					local by = bp.y - pp.y
					local bz = bp.z - pp.z
					--ForceGameTelescopeCam(true)
					SetFollowVehicleCamSubmode(2)
					SetObjectVisible(camobj, false)
					--AttachObjectToPed(camobj, GetPlayerChar(-1), 0x4D0, 0.1, 0, 0.15, 0, 0, 0, 0)
					if(IsMouseButtonPressed(2) or IsButtonPressed(0, 5)) then
						--[[SetCamActive(fpcam, false)
						SetCamPropagate(fpcam, 0)
						
						SetCamPropagate(fpcam2, 1)
						SetCamActive(fpcam2, true)
						AttachCamToObject(fpcam2, camobj)]]
					else
						SetCamActive(fpcam2, false)
						SetCamPropagate(fpcam2, 0)
						
						SetCamPropagate(fpcam, 1)
						SetCamActive(fpcam, true)
						AttachCamToPed(fpcam, GetPlayerChar(-1))
					end
					SetCamAttachOffsetIsRelative(fpcam, 0)
					--local fov = GetCamFov(GetGameCam())
					--SetCamFov(fpcam, fov)
					if(not IsCharInAnyCar(GetPlayerChar(-1))) then
						if(IsMouseButtonPressed(2) or IsButtonPressed(0, 5)) then
							local gw,cw = GetCurrentCharWeapon(GetPlayerChar(-1))
							if(cw < 7) then
								SetCamAttachOffset(fpcam, bx+0.3*math.cos((GetCharHeading(GetPlayerChar(-1))+90)*math.pi/180), by+0.3*math.sin((GetCharHeading(GetPlayerChar(-1))+90)*math.pi/180), bz)
								SetCamRot(fpcam, cx, cy, GetCharHeading(GetPlayerChar(-1)))
							elseif(cw==16 or cw==17 or cw==35) then
								ActivateScriptedCams(0, 0)
							else
								--AttachCamToObject(fpcam, camobj)
								--SetCamAttachOffset(fpcam, bx+0.3*math.cos((GetCharHeading(GetPlayerChar(-1))+90)*math.pi/180), by+0.3*math.sin((GetCharHeading(GetPlayerChar(-1))+90)*math.pi/180), bz)
								AttachObjectToPed(camobj, GetPlayerChar(-1), 0x4D0, 0.1, 0, 0.15, 0, 0, 0, 0)
								SetCamAttachOffset(fpcam2, 0, 0, 0)
								
								SetCamActive(fpcam, false)
								SetCamPropagate(fpcam, 0)
								
								SetCamPropagate(fpcam2, 1)
								SetCamActive(fpcam2, true)
								AttachCamToObject(fpcam2, camobj)
								
								SetCamRot(fpcam2, cx, cy, cz)--GetCharHeading(GetPlayerChar(-1)))
							end
						else
							SetCamAttachOffset(fpcam, bx+0.3*math.cos((cz+90)*math.pi/180), by+0.3*math.sin((cz+90)*math.pi/180), bz)
							SetCamRot(fpcam, cx, cy, cz)
						end
					else
						if(IsMouseButtonPressed(2) or IsButtonPressed(0, 5)) then
							local gw,cw = GetCurrentCharWeapon(GetPlayerChar(-1))
							if(cw == 0) then
								SetCamAttachOffset(fpcam, bx+0.3*math.cos((cz+90)*math.pi/180), by+0.3*math.sin((cz+90)*math.pi/180), bz+0.1)
								SetCamRot(fpcam, cx, cy, cz)
							else
								if(GetPlayerSeat() == 0) then
									if(IsMouseButtonPressed(1)) then
										local model = GetCarModel(GetCarCharIsUsing(GetPlayerChar(-1)))
										if(IsThisModelABoat(model) or IsThisModelAHeli(model)) then
											if(GetPlayerSeat() == 0) then
												AttachObjectToPed(camobj, GetPlayerChar(-1), 0x4C3, -0.1, 0, -0.15, 0, 0, 0, 0)
											else
												AttachObjectToPed(camobj, GetPlayerChar(-1), 0x4D0, 0.1, 0, 0.15, 0, 0, 0, 0)
											end
										elseif(IsThisModelABike(model)) then
											AttachObjectToPed(camobj, GetPlayerChar(-1), 0x4D0, 0.1, 0, 0.15, 0, 0, 0, 0)
										else
											if(GetPlayerSeat()==0 or GetPlayerSeat()==2) then
												AttachObjectToPed(camobj, GetPlayerChar(-1), 0x4C3, -0.1, 0, -0.15, 0, 0, 0, 0)
											else
												AttachObjectToPed(camobj, GetPlayerChar(-1), 0x4D0, 0.1, 0, 0.15, 0, 0, 0, 0)
											end
										end
										SetCamAttachOffset(fpcam2, 0, 0, 0)
										
										SetCamActive(fpcam, false)
										SetCamPropagate(fpcam, 0)
										
										SetCamPropagate(fpcam2, 1)
										SetCamActive(fpcam2, true)
										AttachCamToObject(fpcam2, camobj)
										
										SetCamRot(fpcam2, cx, cy, cz)
									else
										SetCamActive(fpcam2, false)
										SetCamPropagate(fpcam2, 0)
										
										SetCamPropagate(fpcam, 1)
										SetCamActive(fpcam, true)
										AttachCamToPed(fpcam, GetPlayerChar(-1))
										
										SetCamAttachOffset(fpcam, bx+0.3*math.cos((cz+90)*math.pi/180), by+0.3*math.sin((cz+90)*math.pi/180), bz+0.1)
										SetCamRot(fpcam, cx, cy, cz)
									end
								else
									local model = GetCarModel(GetCarCharIsUsing(GetPlayerChar(-1)))
									if(IsThisModelABoat(model) or IsThisModelAHeli(model)) then
										AttachObjectToPed(camobj, GetPlayerChar(-1), 0x4D0, 0.1, 0, 0.15, 0, 0, 0, 0)
									elseif(IsThisModelABike(model)) then
										AttachObjectToPed(camobj, GetPlayerChar(-1), 0x4D0, 0.1, 0, 0.15, 0, 0, 0, 0)
									else
										if(GetPlayerSeat() == 2) then
											AttachObjectToPed(camobj, GetPlayerChar(-1), 0x4C3, -0.1, 0, -0.15, 0, 0, 0, 0)
										else
											AttachObjectToPed(camobj, GetPlayerChar(-1), 0x4D0, 0.1, 0, 0.15, 0, 0, 0, 0)
										end
									end
									SetCamAttachOffset(fpcam2, 0, 0, 0)
									
									SetCamActive(fpcam, false)
									SetCamPropagate(fpcam, 0)
									
									SetCamPropagate(fpcam2, 1)
									SetCamActive(fpcam2, true)
									AttachCamToObject(fpcam2, camobj)
									
									SetCamRot(fpcam2, cx, cy, cz)
								end
							end
						else
							SetCamAttachOffset(fpcam, bx+0.3*math.cos((cz+90)*math.pi/180), by+0.3*math.sin((cz+90)*math.pi/180), bz+0.1)
							SetCamRot(fpcam, cx, cy, cz)
						end
					end
					if(IsMouseButtonPressed(2) or IsButtonPressed(0, 5)) then
						DrawRect(0.5, 0.5, 0.005, 0.01, 255, 255, 255, 100)
					end
				end
			end
		end
	end
end)

--[[local numbers = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}
local letters1 = {"q", "w", "e", "r", "t", "y", "u", "i", "o", "p"}
local letters2 = {"a", "s", "d", "f", "g", "h", "j", "k", "l"}
local letters3 = {"z", "x", "c", "v", "b", "n", "m"}
local letters1c = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"}
local letters2c = {"A", "S", "D", "F", "G", "H", "J", "K", "I"}
local letters3c = {"Z", "X", "C", "V", "B", "N", "M"}
local keys = {12, 13, 26, 27, 39, 40, 41, 51, 52, 53, 55, 57}
local keysresult = {"-", "=", "[", "]", ";", "'", "`", ",", ".", "/", "*", " "}
local keys2 = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 26, 27, 53, 39, 40}
local keysresult2 = {"!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "+", "{", "}", "?", ":", "\""}

local keys = {
{2, "1", "!"}, {3, "2", "@"}, {4, "3", "#"}, {5, "4", "$"}, {6, "5", "%"}, {7, "6", "^"}, {8, "7", "&"}, {9, "8", "*"}, {10, "9", "("}, {11, "0", ")"}, {12, "-", "_"}, {13, "=", "+"},
{16, "q", "Q"}, {17, "w", "W"}, {18, "e", "E"}, {19, "r", "R"}, {20, "t", "T"}, {21, "y", "Y"}, {22, "u", "U"}, {23, "i", "I"}, {24, "o", "O"}, {25, "p", "P"}, {26, "[", "{"}, {27, "]", "}"},
{30, "a", "A"}, {31, "s", "S"}, {32, "d", "D"}, {33, "f", "F"}, {34, "g", "G"}, {35, "h", "H"}, {36, "j", "J"}, {37, "k", "K"}, {38, "l", "L"}, {39, ";", ":"}, {40, "'", "\""}, {41, "`", ""},
{44, "z", "Z"}, {45, "x", "X"}, {46, "c", "C"}, {47, "v", "V"}, {48, "b", "B"}, {49, "n", "N"}, {50, "m", "M"}, {51, ",", "<"}, {52, ".", ">"}, {53, "/", "?"}, {55, "*", ""}, {57, " ", ""}
}
function ActivateInput(title)
	local chatstring = ""
	cursor = 1
	SetCamActive(GetGameCam(), false)
	SetPlayerControl(GetPlayerId(), false)
	while true do
		Wait(0)
		SetPlayerControl(GetPlayerId(), false)
		DrawRectLeftTopCenter(0.3, 0.5, 0.4, 0.05, 0, 0, 0, 100)
		for i=1,#keys,1 do
			if(IsGameKeyboardKeyJustPressed(keys[i][1])) then
				if(not IsGameKeyboardKeyPressed(42)) then
					chatstring = chatstring .. "" .. keys[i][2]
				else
					chatstring = chatstring .. "" .. keys[i][3]
				end
			end
		end
		if(IsGameKeyboardKeyJustPressed(14)) then
			--chatstring = chatstring:sub(1, -1)
			chatstring = chatstring:sub(1, #chatstring - 1)
		end
		if(chatstring ~= "") then
			if(#chatstring <= 100) then
				SetTextScale(0.100000,  0.3000000)
				SetTextEdge(1, 0, 0, 0, 255)
				--SetTextFont(6)
				--SetTextCentre(1)
				DisplayTextWithLiteralString(0.31, 0.515, "STRING", "" .. chatstring)
			else
				chatstring = chatstring:sub(1, #chatstring - 1)
				--TriggerEvent('Notify', '[Server]', {255, 0, 0}, 'Message cannot exceed 100 characters!')
			end
		else
			SetTextScale(0.1000000,  0.3000000)
			SetTextEdge(1, 0, 0, 0, 255)
			--SetTextFont(6)
			--SetTextCentre(1)
			DisplayTextWithLiteralString(0.31, 0.515, "STRING", "" .. title)
		end
		------
		DrawRectLeftTopCenter(0.4-0.1, 0.7, 0.2, 0.1, 0, 0, 0, 100)
		SetTextScale(0.300000,  0.6000000)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextCentre(1)
		SetTextWrap(0.0, 0.5-0.1)
		DisplayTextWithLiteralString(0.5-0.1, 0.73, "STRING", "OK")
		if(IsCursorInAreaLeftTopCenter(0.4-0.1, 0.7, 0.2, 0.1)) then
			DrawRectLeftTopCenter(0.4-0.1, 0.7, 0.2, 0.1, 255, 255, 255, 255)
			if(IsMouseButtonJustPressed(1)) then
				--if(chatstring ~= "") then
					cursor = 0
					SetPlayerControl(GetPlayerId(), true)
					SetCamActive(GetGameCam(), true)
					return chatstring
				--else
				--	TriggerEvent('Notify', '[Message]', {255, 0, 0}, 'Enter text!')
				--end
			end
		end
		DrawRectLeftTopCenter(0.4+0.1, 0.7, 0.2, 0.1, 0, 0, 0, 100)
		SetTextScale(0.300000,  0.6000000)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextCentre(1)
		SetTextWrap(0.0, 0.5+0.1)
		DisplayTextWithLiteralString(0.5+0.1, 0.73, "STRING", "Cancel")
		if(IsCursorInAreaLeftTopCenter(0.4+0.1, 0.7, 0.2, 0.1)) then
			DrawRectLeftTopCenter(0.4+0.1, 0.7, 0.2, 0.1, 255, 255, 255, 255)
			if(IsMouseButtonJustPressed(1)) then
				return ""
			end
		end
	end
end]]

local inputactive = false
local inputresult = ""
AddEventHandler('onDialogResponse', function(dialogID, dialogResponse, dialogListitem, dialogInputtext)
    if(dialogID=="DIALOG_TEST") then
    	if(dialogResponse==0) then
    		inputresult = ""
			inputactive = false
        elseif(dialogResponse==1) then
            inputresult = dialogInputtext
			inputactive = false
        end
    end
end)
ActivateInput = function(title)
	SetPlayerControl(GetPlayerId(), false)
	inputresult = ""
	inputactive = true
	TriggerEvent('showDialog', "DIALOG_TEST", "DIALOG_STYLE_INPUT", "", "" .. title, "OK", "Cancel", true)
	while inputactive do
		Wait(0)
		SetPlayerControl(GetPlayerId(), false)
	end
	Wait(1000)
	SetPlayerControl(GetPlayerId(), true)
	return inputresult
end

GetFurthestCoordFromCoord = function(x, y, z, coords)
	local maxdist = 0
	local resultid = 0
	for i=1,#coords,1 do
		local dist = GetDistanceBetweenCoords3d(x, y, z, coords[i][1], coords[i][2], coords[i][3])
		if(dist > maxdist) then
			maxdist = dist
			resultid = i
		end
	end
	return coords[resultid][1],coords[resultid][2],coords[resultid][3]
end



IsPedInAnyLandVehicle = function(ped)
	if(IsCharInAnyCar(ped)) then
		if(IsCharInAnyBoat(ped)) then
			return false
		elseif(IsCharInAnyHeli(ped)) then
			return false
		elseif(IsCharInAnyPlane(ped)) then
			return false
		elseif(IsCharInAnyTrain(ped)) then
			return false
		else
			return true
		end
	else
		return false
	end
end

GetFactionNameFromCode = function(code)
	if(code == "police") then
		return "Police"
	elseif(code == "medic") then
		return "Medic"
	elseif(code == "grove") then
		return "The Families"
	elseif(code == "ballas") then
		return "Ballas"
	elseif(code == "vagos") then
		return "Vagos"
	elseif(code == "army") then
		return "Army"
	else
		return "None"
	end
end

GetStreetAtCoord = function(x, y, z)
	local s1,s2 = FindStreetNameAtPosition(x, y, z)
	s1 = GetStringFromHashKey(s1)
	s2 = GetStringFromHashKey(s2)
	local streetname = s1
	if(#s2 > 0) then
		streetname = streetname .. ", " .. s2
	end
	return streetname
end

local texttimer = 0
local texttimer2 = 0
local laststreetname = ""
CreateThread(function()
	while true do
		Wait(0)
		if(texttimer > 0) then
			Wait(1000)
			texttimer = texttimer - 1
		end
	end
end)
CreateThread(function()
	while true do
		Wait(0)
		if(texttimer2 > 0) then
			Wait(1000)
			texttimer2 = texttimer2 - 1
		end
	end
end)
AddEventHandler('baseevents:enteredVehicle', function(veh, vehseat, vehname)
	texttimer = 5
end)
CreateThread(function()
	while true do
		Wait(0)
		DisplayAreaName(false)
		if(loginform == 0) then
			if(IsPlayerControlOn(GetPlayerId())) then
				if(IsGameKeyboardKeyJustPressed(20)) then
					texttimer = 5
					texttimer2 = 5
				end
				if(texttimer > 0) then
					local vehname = ""
					if(IsCharInAnyCar(GetPlayerChar(-1))) then
						local vehs = {
						{0x31F0B376, "Western Annihilator, Military"},
						{0x78D70477, "Western Helitours Maverick, Helicopter"},
						{0x9D0450CA, "Western Maverick, Helicopter"},
						{0x1517D4D9, "Western Police Maverick, Helicopter"},
						
						{0x7A61B330, "Vapid Benson, Truck"},
						{0x32B91AE8, "HVY Biff, Truck"},
						{0x898ECCEA, "Brute Boxville, Van"},
						{2948279460, "Declasse Burrito, Van"},
						{0x50B0215A, "MTL Flatbed, Truck"},
						{0xC9E8FF76, "Declasse Laundromat, Van"},
						{0x22C16A2F, "Brute Mr. Tasty, Van"},
						{0x35ED670B, "Maibatsu Mule, Truck"},
						{0x21EEE87D, "MTL Packer, Truck"},
						{0x809AA4CB, "JoBuilt Phantom, Truck"},
						{4175309224, "Brute Pony, Van"},
						{0xCFB3870C, "Vapid Speedo, Van"},
						{0x63FFE6EC, "Vapid Steed, Truck"},
						{0xBE6FF06A, "Vapid Yankee, Truck"},
						
						{1075851868, "Vapid Bobcat, Offroad"},
						{2006918058, "Albany Cavalcade, SUV"},
						{675415136, "Albany Cavalcade FXT, SUV"},
						{2323011842, "Vapid Contender, SUV"},
						{884422927, "Emperor Habanero, SUV"},
						{486987393, "Vapid Huntley Sport, SUV"},
						{1269098716, "Dundreary Landstalker, SUV"},
						{3984502180, "Vapid Minivan, SUV"},
						{525509695, "Declasse Moonbeam, SUV"},
						{3486509883, "Mammoth Patriot, Offroad"},
						{1390084576, "Declasse Rancher, Offroad"},
						{83136452, "Ubermacht Rebla, SUV"},
						
						{3612755468, "Albany Buccaneer, Classic"},
						{723973206, "Imponte Dukes, Muscle"},
						{3609690755, "Albany Emperor, Classic"},
						{0x8FC3AADC, "Albany Emperor, Classic"},
						{4018066781, "Albany Esperanto, Sedan"},
						{2175389151, "Willard Faction, Sedan"},
						{2170765704, "Albany Manana, Classic"},
						{1304597482, "Willard Marbelle, Classic"},
						{1830407356, "Vapid Peyote, Classic"},
						{4067225593, "Imponte Ruiner, Sedan"},
						{3845944409, "Declasse Sabre, Sedan"},
						{0x4B5D021E, "Declasse Sabre, Sedan"},
						{2609945748, "Declasse Sabre GT, Muscle"},
						{1923400478, "Classique Stallion, Classic"},
						{1534326199, "Vapid Uranus, Sedan"},
						{3469130167, "Declasse Vigero, Muscle"},
						{0x973141FC, "Declasse Vigero, Muscle"},
						{3796912450, "Dundreary Virgo, Classic"},
						{2006667053, "Declasse Voodoo, Classic"},
						
						{0x71EF6313, "Brute Enforcer, Emergency"},
						{0x432EA949, "Bravado FIB Buffalo, Emergency"},
						{0x08DE2A8B, "Vapid NOOSE Stanier, Emergency"},
						{0xEB221FC2, "Mammoth NOOSE Patriot, Emergency"},
						{0x79FBB0C5, "Vapid Police Stanier, Emergency"},
						{0x9F05F101, "Declasse Police Merit, Emergency"},
						{0x8EB78F5A, "Brute Police Stockade, Emergency"},
						
						{2464508460, "WMC Freeway, Bike"},
						{2452219115, "Principe Faggio, Motorbike"},
						{584879743, "Hellfury, Bike"},
						{1203311498, "Shitzu NRG 900, Motorcycle"},
						{3385765638, "Shitzu PCJ 600, Motorcycle"},
						{788045382, "Maibatsu Sanchez, Motorcycle"},
						{3724934023, "LCC Zombie, Bike"},
						
						{0x3D961290, "Nagasaki Dinghy, Boat"},
						{0x33581161, "Grotti Jetmax, Boat"},
						{0xC1CE1183, "Dinka Marquis, Boat"},
						{0xE2E7D4AB, "Police Predator, Emergency"},
						{0x68E27CB6, "Reefer, Boat"},
						{0x17DF5EC2, "Grotti Squalo, Boat"},
						{0x1149422F, "Grotti Tropic, Boat"},
						{0x3F724E66, "Buckingham Tug, Boat"},
						
						{1264341792, "Dundreary Admiral, Executive"},
						{2264796000, "Enus Cognoscenti, Executive"},
						{3197138417, "Benefactor Feltzer, Sports"},
						{886934177, "Karin Intruder, Executive"},
						{1348744438, "Ubermacht Oracle, Executive"},
						{131140572, "Annis Pinnacle, Executive"},
						{1376298265, "Schyster PMP 600, Executive"},
						{3144368207, "Albany Primo, Executive"},
						{0x2560B2FC, "Albany Romero, Executive"},
						{3972623423, "Benefactor Schafter, Executive"},
						{2333339779, "Dundreary Stretch, Executive"},
						{1777363799, "Albany Washington, Executive"},
						
						{0x5D0AAC8F, "Airtug, Service"},
						{0x45D56ADA, "Brute Ambulance, Emergency"},
						{0xD577C962, "Brute Bus, Service"},
						{0x705A3E41, "Schyster Cabby, Service"},
						{0x3D285C4A, "Bravado Feroci FlyUS, Service"},
						{0x73920F8E, "MTL Fire Truck, Emergency"},
						{0x58E49664, "HVY Forklift, Service"},
						{0xA1363020, "Dinka Perennial FlyUS, Service"},
						{0xCD935EF9, "HVY Ripley, Service"},
						{0x8CD0264C, "Albany Roman's Taxi, Service"},
						{0x6827CF72, "Brute Securicar, Service"},
						{0x480DAF95, "Declasse Merit Taxi, Service"},
						{0xC703DB5F, "Vapid Stanier Taxi, Service"},
						{0x72435A19, "Brute Trashmaster, Service"},
						{0x8B887FDB, "Subway Car, Service"},
						
						{3253274834, "Bravado Banshee, Sports"},
						{1063483177, "Pfister Comet, Sports"},
						{108773431, "Invetero Coquette, Sports"},
						{418536135, "Pegassi Infernus, Super"},
						{3999278268, "Karin Sultan RS, Sports"},
						{1821991593, "Dewbauchee SuperGT, Super"},
						{2398307655, "Grotti Turismo, Super"},
						
						{3950024287, "Dinka Blista, Compact"},
						{4227685218, "Dinka Chavos, Sedan"},
						{0x09B56631, "Imponte DF8-90, Sedan"},
						{3164157193, "Karin Dilettante, Compact"},
						{974744810, "Bravado Feroci, Sedan"},
						{627033353, "Vapid Fortune, Sedan"},
						{2016857647, "Karin Futo, Sports"},
						{3953074643, "Dinka Hakumai, Sedan"},
						{3005245074, "Vulcar Ingot, Sedan"},
						{4257937240, "Emperor Lokus, Sedan"},
						{3034085758, "Declasse Merit, Sedan"},
						{2217223699, "Dinka Perennial, Sedan"},
						{2411098011, "Declasse Premier, Sedan"},
						{2332896166, "Albany Presidente, Executive"},
						{1349725314, "Ubermacht Sentinel, Coupe"},
						{1344573448, "Willard Solair, Sedan"},
						{1723137093, "Zirconium Stratum, Sedan"},
						{970598228, "Karin Sultan, Sports"},
						{3711685889, "Maibatsu Vincent, Sedan"},
						{1937616578, "Willard, Sedan"},
						
						{562680400, "HVY APC, Military"},
						{4180675781, "Pegassi Bati, Motorcycle"},
						{3403504941, "Pegassi Bati Custom, Motorcycle"},
						{3990165190, "Bravado Buffalo, Sports"},
						{2598821281, "Vapid Bullet GT, Super"},
						{2623969160, "Dinka Double T, Motorcycle"},
						{2535109211, "Dinka Double T Custom, Motorcycle"},
						{1265391242, "Shitzu Hakuchou, Motorcycle"},
						{4039289119, "Shitzu Hakuchou Custom, Motorcycle"},
						{301427732, "LCC Hexer, Bike"},
						{3039514899, "Benefactor Schafter II, Executive"},
						{1337041428, "Benefactor Serrano, SUV"},
						{729783779, "Vapid Slamvan, Van"},
						{1638119866, "Enus Super Drop Diamond, Executive"},
						{972671128, "Declasse Tampa, Muscle"},
						{841808271, "Declasse Rhapsody, Compact"},
						{802082487, "LCS Lycan, Bike"},
						{2688780135, "Western Nightblade, Bike"},
						{3935799761, "Western Revenant, Bike"},
						{3886915065, "Western Diabolus, Bike"},
						{3676349299, "Western Wolfsbane, Bike"},
						{2006142190, "Western Daemon, Bike"},
						{3723957976, "Western Angel, Bike"},
						{4217198264, "Western Wayfarer, Bike"},
						{4280472072, "Dundreary Regina, Classic"},
						{0x2F03547B, "Nagasaki Buzzard, Military"},
						{0xB12314E0, "Vapid Tow Truck, Service"},
						{0x63ABADE7, "Dinka Akuma, Motorcycle"},
						{0xDCBCBE48, "Ocelot F620, Super"},
						{0x0350D1AB, "Principe Faggio Classic, Motorbike"},
						{0xF92AEC4D, "Benefactor Stretch E, Executive"},
						{0xA774B5A6, "Benefactor Schafter II Custom, Executive"},
						{0x3EA948D6, "Benefactor Serrano Custom, SUV"},
						{0xF79A00F7, "Shitzu Vader, Motorcycle"},
						{0xB820ED5E, "Grotti Blade, Boat"},
						{0x98CC6F33, "Grotti Floater, Boat"},
						{0x38527DEC, "Grotti Smuggler, Boat"},
						{0x3E48BF23, "HVY Skylift, Service"},
						{0xEBC24DF2, "Buckingham Swift, Helicopter"},
						
						{0xB2499163, "Cessna, Plane"},
						{0x0B040C5E, "Cub, Plane"},
						{0x7C5561CB, "Gripen, Plane"}
						}
						local vehmodel = GetCarModel(GetCarCharIsUsing(GetPlayerChar(-1)))
						for j=1,#vehs,1 do
							if(vehmodel == vehs[j][1]) then
								vehname = "" .. vehs[j][2]
							end
						end
					end
					local alpha = 0
					if(texttimer > 3) then
						alpha = 255
					elseif(texttimer == 3) then
						alpha = 200
					elseif(texttimer == 2) then
						alpha = 100
					elseif(texttimer == 1) then
						alpha = 50
					end
					if(IsCharInAnyCar(GetPlayerChar(-1))) then
						if(sm == 0) then
							SetTextScale(0.2000000,  0.4000000)
							SetTextDropshadow(0, 0, 0, 0, 0)
							SetTextEdge(1, 255, 255, 255, alpha)
							SetTextRightJustify(1)
							SetTextWrap(0.0, 0.98)
							SetTextColour(200, 0, 0, alpha)
							--SetTextFont(8)
							DisplayTextWithLiteralString(0.98, 0.9, "STRING", "" .. GetStringWithoutSpaces(vehname))
						else
							if(GetDriverOfCar(GetCarCharIsUsing(GetPlayerChar(-1))) == GetPlayerChar(-1)) then
								SetTextScale(0.2000000,  0.4000000)
								SetTextDropshadow(0, 0, 0, 0, 0)
								SetTextEdge(1, 255, 255, 255, alpha)
								SetTextRightJustify(1)
								SetTextWrap(0.0, 0.98)
								SetTextColour(200, 0, 0, alpha)
								--SetTextFont(8)
								DisplayTextWithLiteralString(0.98, 0.8, "STRING", "" .. GetStringWithoutSpaces(vehname))
							else
								SetTextScale(0.2000000,  0.4000000)
								SetTextDropshadow(0, 0, 0, 0, 0)
								SetTextEdge(1, 255, 255, 255, alpha)
								SetTextRightJustify(1)
								SetTextWrap(0.0, 0.98)
								SetTextColour(200, 0, 0, alpha)
								--SetTextFont(8)
								DisplayTextWithLiteralString(0.98, 0.9, "STRING", "" .. GetStringWithoutSpaces(vehname))
							end
						end
					else
						SetTextScale(0.2000000,  0.4000000)
						SetTextDropshadow(0, 0, 0, 0, 0)
						SetTextEdge(1, 255, 255, 255, alpha)
						SetTextRightJustify(1)
						SetTextWrap(0.0, 0.98)
						SetTextColour(200, 0, 0, alpha)
						--SetTextFont(8)
						DisplayTextWithLiteralString(0.98, 0.9, "STRING", "" .. GetStringWithoutSpaces(vehname))
					end
				end
				local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
				local streetname = GetStreetAtCoord(px, py, pz)
				if(streetname ~= laststreetname) then
					laststreetname = streetname
					texttimer2 = 5
				end
				if(texttimer2 > 0) then
					local alpha = 0
					if(texttimer2 > 3) then
						alpha = 255
					elseif(texttimer2 == 3) then
						alpha = 200
					elseif(texttimer2 == 2) then
						alpha = 100
					elseif(texttimer2 == 1) then
						alpha = 50
					end
					if(IsCharInAnyCar(GetPlayerChar(-1))) then
						if(sm == 0) then
							SetTextScale(0.2000000,  0.4000000)
							SetTextDropshadow(0, 0, 0, 0, 0)
							SetTextEdge(1, 255, 255, 255, alpha)
							SetTextRightJustify(1)
							SetTextWrap(0.0, 0.98)
							SetTextColour(200, 0, 0, alpha)
							--SetTextFont(8)
							DisplayTextWithLiteralString(0.98, 0.9, "STRING", "_ " .. GetStringWithoutSpaces(streetname))
						else
							if(GetDriverOfCar(GetCarCharIsUsing(GetPlayerChar(-1))) == GetPlayerChar(-1)) then
								SetTextScale(0.2000000,  0.4000000)
								SetTextDropshadow(0, 0, 0, 0, 0)
								SetTextEdge(1, 255, 255, 255, alpha)
								SetTextRightJustify(1)
								SetTextWrap(0.0, 0.98)
								SetTextColour(200, 0, 0, alpha)
								--SetTextFont(8)
								DisplayTextWithLiteralString(0.98, 0.8, "STRING", "_ " .. GetStringWithoutSpaces(streetname))
							else
								SetTextScale(0.2000000,  0.4000000)
								SetTextDropshadow(0, 0, 0, 0, 0)
								SetTextEdge(1, 255, 255, 255, alpha)
								SetTextRightJustify(1)
								SetTextWrap(0.0, 0.98)
								SetTextColour(200, 0, 0, alpha)
								--SetTextFont(8)
								DisplayTextWithLiteralString(0.98, 0.9, "STRING", "_ " .. GetStringWithoutSpaces(streetname))
							end
						end
					else
						SetTextScale(0.2000000,  0.4000000)
						SetTextDropshadow(0, 0, 0, 0, 0)
						SetTextEdge(1, 255, 255, 255, alpha)
						SetTextRightJustify(1)
						SetTextWrap(0.0, 0.98)
						SetTextColour(200, 0, 0, alpha)
						--SetTextFont(8)
						DisplayTextWithLiteralString(0.98, 0.9, "STRING", "_ " .. GetStringWithoutSpaces(streetname))
					end
				end
			end
		end
	end
end)

local pausestatus = {}
local talkstatus = {}
local typestatus = {}
for i=0,31,1 do
	pausestatus[i] = 0
	talkstatus[i] = 0
	typestatus[i] = 0
end
RegisterNetEvent('updatePauseStatus')
AddEventHandler('updatePauseStatus', function(id, status)
	pausestatus[id] = status
end)
RegisterNetEvent('updateTalkStatus')
AddEventHandler('updateTalkStatus', function(id, status)
	talkstatus[id] = status
end)
RegisterNetEvent('updateTypeStatus')
AddEventHandler('updateTypeStatus', function(id, status)
	typestatus[id] = status
end)
CreateThread(function()
	local pauseblock = 0
	local keyblock = 0
	while true do
		Wait(0)
		for i=0,31,1 do
			if(not IsNetworkPlayerActive(i)) then
				pausestatus[i] = 0
				talkstatus[i] = 0
				typestatus[i] = 0
			end
		end
		if(IsGameKeyboardKeyPressed(VoiceKey)) then
			if(keyblock == 0) then
				keyblock = 1
				TriggerServerEvent('updateTalkStatus', ConvertIntToPlayerindex(GetPlayerId()), 1)
			end
		elseif(IsGameKeyboardKeyPressed(VoiceKey)) then
			if(keyblock == 0) then
				keyblock = 1
				TriggerServerEvent('updateTalkStatus', ConvertIntToPlayerindex(GetPlayerId()), 2)
			end
		else
			if(keyblock == 1) then
				keyblock = 0
				TriggerServerEvent('updateTalkStatus', ConvertIntToPlayerindex(GetPlayerId()), 0)
			end
		end
		if(IsPauseMenuActive()) then
			if(pauseblock == 0) then
				pauseblock = 1
				TriggerServerEvent('updatePauseStatus', ConvertIntToPlayerindex(GetPlayerId()), 1)
			end
		else
			if(pauseblock == 1) then
				pauseblock = 0
				TriggerServerEvent('updatePauseStatus', ConvertIntToPlayerindex(GetPlayerId()), 0)
			end
		end
	end
end)

CreateThread(function()
	while loginform == 1 do
		Wait(0)
	end
	exports.voicechat:SetPlayerChannel(ConvertIntToPlayerindex(GetPlayerId()))
	while true do
		Wait(0)
		local templist = {}
		for i=0,31,1 do
			if(IsNetworkPlayerActive(i)) then
				if(ConvertIntToPlayerindex(i) ~= ConvertIntToPlayerindex(GetPlayerId())) then
					if(talkstatus[i] == 1) then
						if(phonecall[i]==ConvertIntToPlayerindex(GetPlayerId()) or phonecall[ConvertIntToPlayerindex(GetPlayerId())]==i) then
							exports.voicechat:SetPlayerVolume(i, 0.99)
						else
							local radius = 20
							local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
							local ix,iy,iz = GetCharCoordinates(GetPlayerChar(i))
							local dist = GetDistanceBetweenCoords3d(px, py, pz, ix, iy, iz)
							if(dist < radius) then
								local volume = (radius - dist)/radius
								exports.voicechat:SetPlayerVolume(i, volume)
							else
								exports.voicechat:SetPlayerVolume(i, 0.0)
							end
						end
					elseif(talkstatus[i] == 2) then
						if(job ~= "0") then
							if(CheckFaction(job, i)) then
								exports.voicechat:SetPlayerVolume(i, 0.99)
								templist[#templist+1] = i
							end
						end
					else
						exports.voicechat:SetPlayerVolume(i, 0.0)
					end
				end
			end
		end
		if(job ~= "0") then
			if(CheckFaction(job)) then
				if(#templist > 0) then
					local temptext = "Radio:"
					for i=1,#templist,1 do
						temptext = temptext .. " " .. GetStringWithoutSpaces("" .. GetPlayerName(templist[i]))
					end
					SetTextScale(0.1500000, 0.3000000)
					SetTextDropshadow(0, 0, 0, 0, 0)
					SetTextEdge(1, 0, 0, 0, 255)
					SetTextRightJustify(1)
					SetTextWrap(0.0, 0.995)
					DisplayTextWithLiteralString(0.995, 0.3, "STRING", "" .. temptext)
				end
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		DisplayPlayerNames(false)
		for i=0,31,1 do
			if(IsNetworkPlayerActive(i)) then
				SetDisplayPlayerNameAndIcon(i, false)
				if(admin == 1) then
					if(displayNames == true) then
						if(ConvertIntToPlayerindex(i) ~= ConvertIntToPlayerindex(GetPlayerId())) then
							local px,py,pz = GetCharCoordinates(GetPlayerChar(i))
							local bp = GetPedBonePosition(GetPlayerChar(i), 0x4B5, 0, 0, 0)
							px,py,pz = bp.x,bp.y,bp.z+0.5
							if(IsPlayerNearCoords(px, py, pz, 20)) then
								local bv,cx,cy = WorldToScreen(px, py, pz+0.5)
								if bv then
									local temptext = "" .. GetStringWithoutSpaces("" .. GetPlayerName(i))
									if(pausestatus[i] == 1) then
										temptext = temptext .. " Paused"
									end
									if(talkstatus[i] == 1) then
										temptext = temptext .. " Talking..."
									end
									if(typestatus[i] == 1) then
										temptext = temptext .. " Typing..."
									end
									SetTextScale(0.1500000, 0.3000000)
									SetTextDropshadow(0, 0, 0, 0, 0)
									SetTextEdge(1, 0, 0, 0, 255)
									SetTextWrap(0.0, cx)
									SetTextCentre(1)
									SetTextColour(255, 255, 255, 255)
									DisplayTextWithLiteralString(cx, cy, "STRING", "" .. temptext)
								end
							end
						end
					end
				end
			end
		end
	end
end)

GetStringWithoutSpaces = function(text)
	local newstring = ""
	for i=1,#text,1 do
		local tempchar = text:sub(i, i)
		if(tempchar == " ") then
			newstring = "" .. newstring .. "_"
		else
			newstring = "" .. newstring .. "" .. tempchar
		end
	end
	return newstring
end

local signal = false
local signaltime = 0
DrawSignal = function(x, y, z, text, duration)
	signaltime = 0
	if duration then
		signaltime = duration
	else
		signaltime = 1000
	end
	signal = true
	CreateThread(function()
		while signal do
			Wait(0)
			local bv,cx,cy = WorldToScreen(x, y, z)
			if bv then
				SetTextScale(0.1500000, 0.3000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextWrap(0.0, cx)
				SetTextCentre(1)
				DisplayTextWithLiteralString(cx, cy, "STRING", "" .. text)
			end
		end
	end)
end
DrawSignalAttached = function(text, duration)
	signaltime = 0
	if duration then
		signaltime = duration
	else
		signaltime = 1000
	end
	signal = true
	CreateThread(function()
		while signal do
			Wait(0)
			local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
			local bv,cx,cy = WorldToScreen(px, py, pz)
			if bv then
				SetTextScale(0.1500000, 0.3000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextWrap(0.0, cx)
				SetTextCentre(1)
				DisplayTextWithLiteralString(cx, cy, "STRING", "" .. text)
			end
		end
	end)
end
CreateThread(function()
	while true do
		Wait(0)
		if signal then
			Wait(signaltime)
			signal = false
		end
	end
end)

DisplaySprite = function(txd, texture, x, y, sx, sy, rot, r, g, b, a)
	RequestStreamedTxd(txd)
	while not HasStreamedTxdLoaded(txd) do
		Wait(0)
		RequestStreamedTxd(txd)
	end
	local texture = GetTextureFromStreamedTxd(txd, texture)
	DrawSprite(texture, x, y, sx, sy, rot, r, g, b, a)
end

PlayAnim = function(dict, anim, type, skip)
	RequestAnims(dict)
	while not HaveAnimsLoaded(dict) do
		Wait(0)
	end
	if(type==nil or type==0) then
		TaskPlayAnimWithFlags(GetPlayerChar(-1), anim, dict, 8.0, 0, 0)
	elseif(type == 1) then
		TaskPlayAnimWithFlags(GetPlayerChar(-1), anim, dict, 8.0, 3000000, 0)
	elseif(type == 2) then
		TaskPlayAnimWithFlags(GetPlayerChar(-1), anim, dict, 8.0, 0, 0x20)
	elseif(type == 3) then
		TaskPlayAnimWithFlags(GetPlayerChar(-1), anim, dict, 8.0, 3000000, 49)
	elseif(type == 4) then
		TaskPlayAnimNonInterruptable(GetPlayerChar(-1), anim, dict, 9.9, 1, 0, 0, 0, -1)
	end
	if not skip then
		while not HasCharAnimFinished(GetPlayerChar(-1), dict, anim) do
			Wait(0)
		end
	end
end

RegisterNetEvent('restartScript')
AddEventHandler('restartScript', function(script)
	TerminateAllScriptsWithThisName(script)
	RequestScript(script)
	while not HasScriptLoaded(script) do
		Wait(0)
	end
	StartNewScript(script, 1024)
end)

RestartScript = function(script)
	TerminateAllScriptsWithThisName(script)
	RequestScript(script)
	while not HasScriptLoaded(script) do
		Wait(0)
	end
	StartNewScript(script, 1024)
	Wait(1000)
end

local update = false
CreateThread(function()
	while true do
		Wait(0)
		if update then
			::again::
			update = false
			Wait(1000)
			if update then
				goto again
			end
			TriggerServerEvent('restartScript', "cleanup")
		end
	end
end)

SpawnCar = function(model, x, y, z, h)
	update = true
	RequestModel(model)
	while not HasModelLoaded(model) do 
		Wait(0)
		RequestModel(model)
	end
	return exports.cleanup:SpawnCar(model, x, y, z, h)
end

SpawnPed = function(model, x, y, z, h, k)
	update = true
	RequestModel(model)
	while not HasModelLoaded(model) do 
		Wait(0)
		RequestModel(model)
	end
	return exports.cleanup:SpawnPed(model, x, y, z, h, k)
end

SpawnObject = function(model, x, y, z, h, k)
	update = true
	RequestModel(model)
	while not HasModelLoaded(model) do 
		Wait(0)
		RequestModel(model)
	end
	return exports.cleanup:SpawnObject(model, x, y, z, h, k)
end

SpawnRandomPed = function(x, y, z, h, k)
	update = true
	return exports.cleanup:SpawnRandomPed(x, y, z, h, k)
end

GetClosestCoord = function(coords)
	local tempdist = {}
	local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
	for i=1,#coords,1 do
		tempdist[i] = GetDistanceBetweenCoords3d(coords[i][1], coords[i][2], coords[i][3], px, py, pz)
	end
	local closestdist = 100000
	local closestid = 0
	for i=1,#tempdist,1 do
		if(tempdist[i] <= closestdist) then
			closestdist = tempdist[i]
			closestid = i
		end
	end
	return {coords[closestid][1],coords[closestid][2],coords[closestid][3]}
end

GetRandomNodeInRadius = function(radius)
	local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
	local angle = GenerateRandomFloatInRange(0, 360.1)
	local rb,rx,ry,rz,rh = GetNextClosestCarNodeWithHeading(px+radius*math.cos(angle*math.pi/180), py+radius*math.sin(angle*math.pi/180), pz, _f, _f, _f, _f)
	return rx,ry,rz,rh
end

GetRandomWaterNodeInRadius = function(radius)
	local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
	local angle = GenerateRandomFloatInRange(0, 360.1)
	local rb,rv,rh = GetNthClosestWaterNodeWithHeading(px+radius*math.cos(angle*math.pi/180), py+radius*math.sin(angle*math.pi/180), pz, false, false)
	return rv.x,rv.y,rv.z,rh
end

GetFreePassengerSeat = function(veh)
	for i=0,2,1 do
		if(IsCarPassengerSeatFree(veh, i)) then
			return i
		end
	end
	return -1
end

GetPlayerIdFromName = function(name)
	for i=0,31,1 do
		if(IsNetworkPlayerActive(i)) then
			if(GetPlayerName(i) == name) then
				return i
			end
		end
	end
	return -1
end

SpawnCar3 = function(model, x, y, z, h)
	RequestModel(model)
	while not HasModelLoaded(model) do 
		Wait(0)
		RequestModel(model)
	end
	return exports.cleanup2:SpawnCar(model, x, y, z, h)
end

SpawnPed3 = function(model, x, y, z, h, k)
	RequestModel(model)
	while not HasModelLoaded(model) do 
		Wait(0)
		RequestModel(model)
	end
	return exports.cleanup2:SpawnPed(model, x, y, z, h, k)
end

SpawnObject3 = function(model, x, y, z, h, k)
	RequestModel(model)
	while not HasModelLoaded(model) do 
		Wait(0)
		RequestModel(model)
	end
	return exports.cleanup2:SpawnObject(model, x, y, z, h, k)
end