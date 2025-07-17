loginform = 1
local registered = 0
local password = -1
local spawn = false
RegisterNetEvent('updPassword')
AddEventHandler('updPassword', function(ppassword)
	password = ppassword
end)

local lastpos = {}
RegisterNetEvent('updLastPos')
AddEventHandler('updLastPos', function(data)
	lastpos[1] = tonumber(data[1])
	lastpos[2] = tonumber(data[2])
	lastpos[3] = tonumber(data[3])
end)

local reg = 0
RegisterNetEvent("login")
AddEventHandler("login", function(entry)
	reg = entry
	loginform = 0
	
	if(reg == 1) then
		cars[19] = 1
		SaveCars()
		inventory[21] = inventory[21] + 10
		inventory[19] = inventory[19] + 10
		inventory[34] = inventory[34] + 5000
		Notify('You have successfully registered!.')
		Notify('You have got your welcome gifts!.')
		::again2::
		DrawWindow("Select gender", {"Male", "Female"})
		while menuactive do
			Wait(0)
		end
		if(menuresult > 0) then
			local tempresult = menuresult
			DrawWindow("Are you sure?", {"Yes", "No"})
			while menuactive do
				Wait(0)
			end
			if(menuresult == 1) then
				gender = tempresult
				SaveStats()
				if(gender == 1) then
					currparts[1] = GetHashKey("M_M_TRAMPBLACK")
				else
					currparts[1] = GetHashKey("f_m_porient_01")
				end
				SaveParts()
				SetPlayerSkin(currparts[1])
			else
				goto again2
			end
		else
			Notify("You must select your gender.")
			goto again2
		end
		
		loginform = 0
		cursor = 0
		SetPlayerControl(GetPlayerId(), true)
		SetCamActive(GetGameCam(), false)
		SetCharInvincible(GetPlayerChar(-1), false)
		FreezeCharPosition(GetPlayerChar(-1), false)
		SetCharVisible(GetPlayerChar(-1), true)
		--tutorial = 1
		
		SetCamActive(camera, false)
		SetCamActive(GetGameCam(), true)
		SetCamPropagate(camera, 0)
		SetCamPropagate(GetGameCam(), 1)
		ActivateScriptedCams(0, 0)
		DestroyCam(camera)
	else
		if(jailtime<=0 and demorgan<=0) then
			spawn = true
			cursor = 1
			if(not HasStreamedTxdLoaded("cursor")) then
				RequestStreamedTxd("cursor")
				while not HasStreamedTxdLoaded("cursor") do
					RequestStreamedTxd("cursor")
					Citizen.Wait(0)
				end
				cur = GetTextureFromStreamedTxd("cursor", "cursor")	
			end
		end
		
		Notify('You have entered the server! Good game!')
		
		if(gender == 0) then
			::again2::
			DrawWindow("Select gender", {"Male", "Female"})
			while menuactive do
				Wait(0)
			end
			if(menuresult > 0) then
				local tempresult = menuresult
				DrawWindow("Are you sure?", {"Yes", "No"})
				while menuactive do
					Wait(0)
				end
				if(menuresult == 1) then
					gender = tempresult
					SaveStats()
					if(gender == 1) then
						currparts[1] = GetHashKey("M_M_TRAMPBLACK")
					else
						currparts[1] = GetHashKey("f_m_porient_01")
					end
					SaveParts()
					SetPlayerSkin(currparts[1])
				else
					goto again2
				end
			else
				Notify("You must select your gender!")
				goto again2
			end
		end
		
		loginform = 0
		SetPlayerControl(GetPlayerId(), true)
		SetCharInvincible(GetPlayerChar(-1), false)
		FreezeCharPosition(GetPlayerChar(-1), false)
		SetCharVisible(GetPlayerChar(-1), true)
		
		SetCamActive(camera, false)
		SetCamActive(GetGameCam(), true)
		SetCamPropagate(camera, 0)
		SetCamPropagate(GetGameCam(), 1)
		ActivateScriptedCams(0, 0)
		DestroyCam(camera)
	end
end)

camactive = false
function SpawnCam(p1, p2, p3)
	camactive = true
	FadeScreen()
	local c1 = CreateCam(14)
	SetCamPropagate(c1, 1)
	SetCamPos(c1, p1, p2, p3+1000)
	SetCamActive(c1, true)
	ActivateScriptedCams(1, 1)
	PointCamAtCoord(c1, p1, p2, p3)
	
	Citizen.Wait(3000)
	FadeScreen()
	DestroyCam(c1)
	local c2 = CreateCam(14)
	SetCamPropagate(c2, 1)
	SetCamPos(c2, p1, p2, p3+90)
	SetCamActive(c1, false)
	SetCamActive(c2, true)
	ActivateScriptedCams(1, 1)
	PointCamAtCoord(c2, p1, p2, p3)

	Citizen.Wait(3000)
	FadeScreen()
	DestroyCam(c2)
	local c3 = CreateCam(14)
	SetCamPropagate(c3, 1)
	SetCamPos(c3, p1, p2, p3+40)
	SetCamActive(c2, false)
	SetCamActive(c3, true)
	ActivateScriptedCams(1, 1)
	PointCamAtCoord(c3, p1, p2, p3)

	Citizen.Wait(2000)
	FadeScreen()
	DestroyCam(c3)
	SetCamActive(c3, false)
	SetCamActive(GetGameCam(), true)
	SetCamPropagate(GetGameCam(), 1)
	ActivateScriptedCams(0, 0)
	camactive = false
end
-------------Spawn
Citizen.CreateThread(function()
	cars[19] = 1
	Citizen.Wait(4000)
	while true do
		Citizen.Wait(0)

		if(spawn == true) then

			RequestStreamedTxd("spawn")
			while not HasStreamedTxdLoaded("spawn") do
				Wait(0)
				RequestStreamedTxd("spawn")
			end

			if(IsCursorInArea(0.1088, 0.4574, 0.059, 0.05)) then--main
				local texture = GetTextureFromStreamedTxd("spawn", "1")
				DrawSprite(texture, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
				if(IsMouseButtonJustPressed(1)) then
					SetCharCoordinates(GetPlayerChar(-1), -590.25049, 487.26523, 21.63802)
					spawn = false
					cursor = 0
					--SpawnCam(-590.25049, 487.26523, 21.63802)
					while camactive do
						Citizen.Wait(0)
					end
				end
			elseif(IsCursorInArea(0.3015, 0.4574, 0.059, 0.05)) then--pd
				local texture = GetTextureFromStreamedTxd("spawn", "2")
				DrawSprite(texture, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
				if(IsMouseButtonJustPressed(1)) then
					SetCharCoordinates(GetPlayerChar(-1), 85.88271, 1241.65247, 15.9231)
					spawn = false
					cursor = 0
					--SpawnCam(85.88271, 1241.65247, 15.9231)
					while camactive do
						Citizen.Wait(0)
					end
				end
			elseif(IsCursorInArea(0.4989, 0.4574, 0.059, 0.05)) then--lp
				local texture = GetTextureFromStreamedTxd("spawn", "3")
				DrawSprite(texture, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
				if(IsMouseButtonJustPressed(1)) then
					SetCharCoordinates(GetPlayerChar(-1), lastpos[1], lastpos[2], lastpos[3])
					spawn = false
					cursor = 0
					--SpawnCam(lastpos[1], lastpos[2], lastpos[3])
					while camactive do
						Citizen.Wait(0)
					end
				end
			elseif(IsCursorInArea(0.7010, 0.4574, 0.059, 0.05)) then--dler
				local texture = GetTextureFromStreamedTxd("spawn", "4")
				DrawSprite(texture, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
				if(IsMouseButtonJustPressed(1)) then
					SetCharCoordinates(GetPlayerChar(-1), 48.97474, 811.15796, 14.647)
					spawn = false
					cursor = 0
					--SpawnCam(48.97474, 811.15796, 14.647)
					while camactive do
						Citizen.Wait(0)
					end
				end
			elseif(IsCursorInArea(0.90208, 0.4574, 0.059, 0.05)) then--town
				local texture = GetTextureFromStreamedTxd("spawn", "5")
				DrawSprite(texture, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
				if(IsMouseButtonJustPressed(1)) then
					SetCharCoordinates(GetPlayerChar(-1), -223.37943, 431.23187, 14.81625)
					spawn = false
					cursor = 0
					--SpawnCam(-223.37943, 431.23187, 14.81625)
					while camactive do
						Citizen.Wait(0)
					end
				end
			else
				local base = GetTextureFromStreamedTxd("spawn", "spawn")
				DrawSprite(base, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
			end
--------------------------------------------------------------------------
			mouseX,mouseY = GetMousePosition(_f, _f)
			if(mouseX>0.99 or mouseY>0.99) then
			
			else
				if(HasStreamedTxdLoaded("cursor")) then
					DrawSprite(cur, mouseX, mouseY, 0.02, 0.04, 0.0, 255, 255, 255, 255)
				else
					DrawRect(mouseX, mouseY, 0.01, 0.02, 255, 255, 255, 255)
				end
			end
-------------------------------------------------------------------------
		end
	end
end)
