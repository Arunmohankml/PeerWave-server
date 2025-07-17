local show = 0
local RobTimer = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if(not DoesBlipExist(merryblip)) then
			merryblip = AddBlipForCoord(1200.94165, 1439.45264, 30.28511)
			ChangeBlipSprite(merryblip, 26)
			ChangeBlipNameFromAscii(merryblip, "Merryweather Hiest")
			SetBlipAsShortRange(merryblip, true)
			ChangeBlipScale(merryblip, 0.8)
		end
		if(TriggeredMerry == false) then
			if(MerryCooldown == 0) then
				if(RobTimer == 0) then
					DrawCheckpointWithAlpha(1200.94165, 1439.45264, 30.28511-2, 2.5, 255, 0, 0, 50)
					if(IsPlayerNearCoords(1200.94165, 1439.45264, 30.28511, 2.5)) then
						if(show == 0) then
							TriggerEvent("noticeme:Info", "Hold E to start Merryweather robbery")
							show = 1 
						end
						if(IsGameKeyboardKeyJustPressed(18)) then
							TriggerEvent("noticeme:Info", "Merryweather robbery has been started")
							TriggerEvent("noticeme:Info", "Kill the guards and survive")
							RobTimer = 120
							Merryweather = CreateGroup(false, true)
							TriggerServerEvent('TriggeredRobbery', true, "merry")
						end
					else
						show = 0
					end
				end
			else
				Draw3dText(1200.94165, 1439.45264, 30.28511, "Cool_Down_" .. MerryCooldown .. "_Seconds", 5.0)
			end
		else
			Draw3dText(1200.94165, 1439.45264, 30.28511, "Robbery ongoing", 5.0)
		end
		if(RobTimer > 0) then
			PrintStringWithLiteralStringNow("STRING", "Survive here for ".. RobTimer .." seconds, dont leave the zone" , 1000, 1)
		end
		if(RobTimer > 0) then
			if(IsPlayerDead(GetPlayerId())) then
				EndRobbery()
			end
		end
		if(RobTimer == 1) then
			MerryCooldown = 1200
			SaveServerInfo()

			local tempmoney = GenerateRandomIntInRange(9000, 13000)
			TriggerEvent("noticeme:Info", "You Got " .. tempmoney .. ".Rs Blackmoney")
			AddItem(28, tempmoney)
			Print(" got "..tempmoney .. ".Rs Blackmoney from merry wether")
			RobTimer = 0

			ClearAreaOfChars(1200.94165, 1439.45264, 30.28511, 40.0)
			TriggerServerEvent('TriggeredRobbery', false, "merry")
		end
		if RobTimer > 0 then
			if(not IsPlayerNearCoords(1200.94165, 1439.45264, 30.28511, 15)) then
				EndRobbery()
			end
		end
	end
end)

EndRobbery = function()
	MerryCooldown = 1200
	SaveServerInfo()
	RobTimer = 0
	if(DoesCharExist(attacker)) then
		DeleteChar(attacker)
	end
	if(DoesCharExist(attacker2)) then
		DeleteChar(attacker2)
	end
	if(DoesCharExist(attacker3)) then
		DeleteChar(attacker3)
	end
	ClearAreaOfChars(1200.94165, 1439.45264, 30.28511, 40.0)
	TriggerEvent("noticeme:Info", "Merry wether failed")
	Print(" faield merry wether")
	TriggerServerEvent('TriggeredRobbery', false, "merry")
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if RobTimer > 0 then
			RobTimer = RobTimer - 1
			Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if(DoesCharExist(attacker)) then
			SetCharNeverLeavesGroup(attacker, true)
			if(IsCharDead(attacker)) then
				DeleteChar(attacker)
			end
		end
		if(DoesCharExist(attacker2)) then
			SetCharNeverLeavesGroup(attacker2, true)
			if(IsCharDead(attacker2)) then
				DeleteChar(attacker2)
			end
		end
		
		if RobTimer > 0 then
			local model = 800131009
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(0)
			end
			gun = GenerateRandomIntInRange(12, 15)
			attacker = SpawnPed(800131009, 1191.00659, 1439.0647, 25.98555, 0.0)

			SetCharCoordinates(attacker, 1191.00659, 1439.0647, 25.98555)
			SetGroupMember(Merryweather, attacker)
			SetCharNeverLeavesGroup(attacker, true)
			GiveWeaponToChar(attacker, gun, 1000, 1)
			SetCharDropsWeaponsWhenDead(attacker, false)
			TaskCombat(attacker, GetPlayerChar(-1))

			attacker2 = SpawnPed(800131009, 1191.00659, 1439.0647, 25.98555, 0.0)
			SetCharCoordinates(attacker2, 1222.93457, 1463.93542, 26.07572)
			SetGroupMember(Merryweather, attacker2)
			SetCharNeverLeavesGroup(attacker2, true)
			GiveWeaponToChar(attacker2, gun, 1000, 1)
			SetCharDropsWeaponsWhenDead(attacker2, false)
			TaskCombat(attacker2, GetPlayerChar(-1))
			
			Citizen.Wait(7000)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if(DoesCharExist(attacker3)) then
			SetCharNeverLeavesGroup(attacker3, true)
		end

		if RobTimer > 0 then
			Citizen.Wait(60000)
			local model = 800131009
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(0)
			end
			gun = GenerateRandomIntInRange(12, 15)
			attacker3 = SpawnPed(800131009, 1191.00659, 1439.0647, 25.98555, 0.0)
			SetCharCoordinates(attacker3, 1191.00659, 1439.0647, 25.98555)
			SetGroupMember(Merryweather, attacker3)
			SetCharNeverLeavesGroup(attacker3, true)
			GiveWeaponToChar(attacker3, 18, 1000, 1)
			SetCharDropsWeaponsWhenDead(attacker3, false)
			TaskCombat(attacker3, GetPlayerChar(-1))
		end

	end
end)

DrawRectLeftTopCenter = function(x, y, width, height, r, g, b, a)
	DrawRect(x+width/2, y+height/2, width, height, r, g, b, a)
end
DrawCurvedWindowLeftTopCenter = function(x, y, width, height, a)
	DrawCurvedWindow(x+width/2, y+height/2, width, height, a)
end

function IsPlayerNearCoords(x, y, z, radius)
    local pos = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
    local dist = GetDistanceBetweenCoords3d(x, y, z, pos[1], pos[2], pos[3])
    if(dist < radius) then return true
    else return false
    end
end


Draw3dText = function(x, y, z, text, radius)
	local px,py,pz = GetCharCoordinates(GetPlayerChar(-1), _f, _f, _f)
	local dist = GetDistanceBetweenCoords3d(x, y, z, px, py, pz, _f)
	local model = GetHashKey("cj_can_drink_1")
	if(not DoesObjectExist(tempobj)) then
		RequestModel(model)
		while not HasModelLoaded(model) do
			Wait(0)
		end
		tempobj = CreateObject(model, x, y, z, _i, 1)
		SetObjectVisible(tempobj, false)
	end
	if(dist < radius) then
		SetObjectCoordinates(tempobj, x, y, z)
		if(IsObjectOnScreen(tempobj)) then
			local bv,cx,cy = GetViewportPositionOfCoord(x, y, z, GetGameViewportId(_i), _f, _f)
			local sx,sy = GetScreenResolution(_i, _i)
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
				SetTextScale(0.300000/radius*mult, 0.6000000/radius*mult)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextWrap(0.0, cx)
				SetTextCentre(1)
				DisplayTextWithLiteralString(cx, cy, "STRING", "" .. text)
			end
		end
	end
end
