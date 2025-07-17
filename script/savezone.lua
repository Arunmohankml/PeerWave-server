
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(IsPlayerInSafezone(-675.98035, 472.35159, 21.6383, 95.0/2) or 
		IsPlayerInSafezone(-601.69202, 471.65567, 21.63803, 95.0/2) or 
		IsPlayerInSafezone(71.51704, 1229.08374, 15.92673-1, 95.0/2) or
		IsPlayerInSafezone(-1339.74963, 1256.77112, 22.37043-1, 95.0/2)) then
                SetTextScale(0.3,  0.6)
                SetTextFont(6)
                SetTextColour(255, 255, 255, 255)
                SetTextCentre(1)
                SetTextWrap(0.0, 0.8)
			    DisplayTextWithLiteralString(0.5, 0.05, "STRING", "SafeZone")
                SetCharHealth(GetPlayerChar(-1), GetCharHealth(GetPlayerChar(-1)))
                SetCharInvincible(GetPlayerChar(-1), true)
                SetCharNeverTargetted(GetPlayerChar(-1), true)
			if(IsCharInAnyCar(GetPlayerChar(-1))) then
                local vehicle = GetCarCharIsUsing(GetPlayerChar(-1))
                local speed = GetCarSpeed(GetCarCharIsUsing(GetPlayerChar(-1)))
                if(GetCarSpeed(GetCarCharIsUsing(GetPlayerChar(-1))) > 16) then
                    SetCarForwardSpeed(vehicle, speed - 1)
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