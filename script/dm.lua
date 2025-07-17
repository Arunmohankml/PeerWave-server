local tpcoords = {
    {-594.54205, -765.66443, 20.64267},
    {-608.69135, -768.74139, 20.64272 },
    {-620.92163, -768.07245, 20.40006 },
    {-622.03851, -754.44562, 20.64268 },
    {-620.7879, -742.16473, 20.46938 },
    {-609.53772, -741.09839, 20.64315 },
    {-589.28998, -735.55475, 16.97077 },
    {-601.88049, -735.49677, 17.47824 },
    {-627.36261, -735.38599, 17.02772},
    {-627.48395, -772.43744, 17.16667},
    {-608.09412, -776.39459, 17.47842 },
    {-589.16028, -774.12659, 17.02703 },
    {-589.15955, -779.89111, 13.07127},
    {-577.39337, -788.60144, 13.07127},
    {-574.71039, -768.00909, 13.07127 },
    {-570.23151, -748.31989, 13.07129 },
    {-586.21045, -725.32446, 13.07129 },
    {-606.0614, -722.74768, 13.07129},
    {-637.42773, -727.31238, 13.07113 },
    {-641.17004, -746.24457, 13.07128 },
    {-638.13177, -784.90546, 13.07134}
}



InVKDM = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        DrawCheckpointWithAlpha(-401.95065, -691.90314, 1.4738-1, 2.0, 255, 0, 0, 100)
		if(not DoesBlipExist(vkdm)) then
			vkdm = AddBlipForCoord(-401.95065, -691.90314, 1.4738)
			ChangeBlipSprite(vkdm, 0)
			ChangeBlipScale(vkdm, 0.7)
			ChangeBlipColour(vkdm, 9)
			ChangeBlipNameFromAscii(vkdm, "Deathmatch")
        end
		if(IsPlayerNearCoords(-401.95065, -691.90314, 1.4738, 2.0)) then
			if IsGameKeyboardKeyJustPressed(18) then
				local randomindex = GenerateRandomIntInRange(1, #tpcoords+1)
				SetCharCoordinates(GetPlayerChar(-1), tpcoords[randomindex][1], tpcoords[randomindex][2], tpcoords[randomindex][3])
			end
		end
		if InVKDM then
			if(not IsPlayerInSafezone(-608.92096, -861.88177, 4.84285, 250.0)) then
				for i=1,6,1 do
					if(i == 1) then
						local model = currparts[1]
						RequestModel(model)
						while not HasModelLoaded(model) do
							Wait(0)
						end
						ChangePlayerModel(GetPlayerId(), model)
						--MarkModelAsNoLongerNeeded(model)
					else
						SetCharComponentVariation(GetPlayerChar(-1), bodyparts2[i-1], currparts[i], currparts[i+5])
					end
				end
				InVKDM = false
			end
		end
		
		if(IsPlayerInSafezone(-608.92096, -861.88177, 4.84285, 250.0)) then
            DrawCheckpointWithAlpha(-608.92096, -861.88177, 4.84285, 500.0, 255, 255, 255, 50)
            DrawCheckpointWithAlpha(-401.95065, -691.90314, 1.4738-1, 2.0, 255, 255, 255, 50)
			SetTextScale(0.150000,  0.3000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			SetTextCentre(1)
			DisplayTextWithLiteralString(0.02, 0.003, "STRING", "OPEN MENU ")
			InVKDM = true
			if(IsGameKeyboardKeyJustPressed(34)) then
				DrawWindow("Weapons", {"M4", "UZI", "SHOTGUN", "PISTOL", "MOLOTOV", "AK47", "MP5", "SNIPER", "BASEBALL BAT", "Quit DM",})
				while menuactive do
					Citizen.Wait(0)
				end
				if(menuresult == 1) then
					GiveWeaponToChar(GetPlayerChar(-1), 15, 500)
					Print(' took weapon frm vkdm')
				elseif(menuresult == 2) then
					GiveWeaponToChar(GetPlayerChar(-1), 12, 500)
					
					Print(' took weapon frm mgcdm menu')
				elseif(menuresult == 3) then
					GiveWeaponToChar(GetPlayerChar(-1), 10, 500)
					
					Print(' took weapon frm mgcdm menu')
				elseif(menuresult == 4) then
					GiveWeaponToChar(GetPlayerChar(-1), 7, 500)
					
					Print(' took weapon frm mgcdm menu')
				elseif(menuresult == 5) then
					GiveWeaponToChar(GetPlayerChar(-1), 5, 500)
					
					Print(' took weapon frm mgcdm menu')
				elseif(menuresult == 6) then
					GiveWeaponToChar(GetPlayerChar(-1), 14, 500)
					
					Print(' took weapon frm mgcdm menu')
				elseif(menuresult == 7) then
					GiveWeaponToChar(GetPlayerChar(-1), 13, 500)
					
					Print(' took weapon frm mgcdm menu')
				elseif(menuresult == 8) then
					GiveWeaponToChar(GetPlayerChar(-1), 16, 500)
					
					Print(' took weapon frm mgcdm menu')
				elseif(menuresult == 9) then
					GiveWeaponToChar(GetPlayerChar(-1), 1, 500)
				
					Print(' took weapon frm mgcdm menu')
				elseif(menuresult == 10) then
					
					SetCharCoordinates(GetPlayerChar(-1), -396.40573, -688.90515, 1.4738)
					Print(' took weapon frm mgcdm menu')
				end 
			end
		end
	end
end)
function IsPlayerInSafezone(x, y, z, radius)
    local pos = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
    for height = 1, 1000 do
        local zz = GetGroundZFor3dCoord(x, y, height + 0.0)
        local dist = GetDistanceBetweenCoords3d(x, y, zz, pos[1], pos[2], pos[3])
    
        if(dist < radius) then return true
        else return false
        end
    end
end
local playerBlip = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(IsPlayerInSafezone(-608.92096, -861.88177, 4.84285, 250.0)) then
			for i=0,31,1 do
				if(DoesBlipExist(playerBlip[i])) then
					RemoveBlip(playerBlip[i])
				end
				if(IsNetworkPlayerActive(i)) then
					playerBlip[i] = AddBlipForChar(GetPlayerChar(i))
					ChangeBlipSprite(playerBlip[i], 0)
					ChangeBlipScale(playerBlip[i], 0.90)
					ChangeBlipPriority(playerBlip[i], 3)
					ChangeBlipColour(playerBlip[i], 1)
					ChangeBlipNameFromAscii(playerBlip[i], GetPlayerName(i))
				end
			end
		end
        if(not IsPlayerInSafezone(-608.92096, -861.88177, 4.84285, 250.0)) then
            for i=0,31,1 do
                if(DoesBlipExist(playerBlip[i])) then
                    RemoveBlip(playerBlip[i])
                end
            end
        end
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(IsPlayerInSafezone(-608.92096, -861.88177, 4.84285, 250.0)) then
			if(IsPlayerDead(GetPlayerId())) then
				Citizen.Wait(5000)
				local pos = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
				local z = GetGroundZFor3dCoord(pos[1], pos[2], pos[3])
				SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1))+100)
				ResurrectNetworkPlayer(GetPlayerId(), pos[1], pos[2], z, 90.0)
                local randomindex = GenerateRandomIntInRange(1, #tpcoords+1)
                SetCharCoordinates(GetPlayerChar(-1), tpcoords[randomindex][1], tpcoords[randomindex][2], tpcoords[randomindex][3])
			end
		end
    end
end)


function ShowText(text, timeout)
    if(timeout == nil) then PrintStringWithLiteralStringNow("STRING", text, 2000, 1)
    else PrintStringWithLiteralStringNow("STRING", text, timeout, 1)
    end
end

RegisterNetEvent('OnPlayerDeath')
AddEventHandler('OnPlayerDeath', function(victim, killer, reason)
    if(IsPlayerInSafezone(-608.92096, -861.88177, 4.84285, 250.0)) then
        local reasonString = 'killed'
        if reason == 0 or reason == 56 or reason == 1 or reason == 2 then
            reasonString = 'meleed'
        elseif reason == 3 then
            reasonString = 'knifed'
        elseif reason == 4 or reason == 6 or reason == 18 or reason == 51 then
            reasonString = 'bombed'
        elseif reason == 5 or reason == 19 then
            reasonString = 'burned'
        elseif reason == 7 or reason == 9 then
            reasonString = 'pistoled'
        elseif reason == 10 or reason == 11 then
            reasonString = 'shotgunned'
        elseif reason == 12 or reason == 13 or reason == 52 then
            reasonString = 'SMGd'
        elseif reason == 14 or reason == 15 or reason == 20 then
            reasonString = 'assaulted'
        elseif reason == 16 or reason == 17 then
            reasonString = 'sniped'
        elseif reason == 49 or reason == 50 then
            reasonString = 'ran over'
        end
        TriggerEvent("noticeme:Info", killer.. " " .. reasonString.. " " ..victim)
    end
end)