local clothson = 0
local shirt = 1
local pants = 1
local anim = 0
local glass = 0
local hat = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
       
        if(IsGameKeyboardKeyPressed(QuickClothsKey)) then 
            clothson = 1
            cursor = 1
            
        else
            clothson = 0
            if(clothsoff == 1) then
                clothsoff = 0
                cursor = 0
                SetPlayerControl(GetPlayerId(), true)
                SetCamActive(GetGameCam(), true)
            end
        end
        if(clothson == 1) then
            clothsoff = 1
            SetPlayerControl(GetPlayerId(), false)
            SetCamActive(GetGameCam(), false)
            
            RequestStreamedTxd("cloths")
			while not HasStreamedTxdLoaded("cloths") do
				Citizen.Wait(0)
			end
			local background = GetTextureFromStreamedTxd("cloths", "main")
            local a = GetTextureFromStreamedTxd("cloths", "1")
            local b = GetTextureFromStreamedTxd("cloths", "2")
            local c = GetTextureFromStreamedTxd("cloths", "3")
            local d = GetTextureFromStreamedTxd("cloths", "4")
			DrawSprite(background, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
            if(IsCursorInArea(0.417, 0.247, 0.14, 0.2)) then
                if(IsMouseButtonJustPressed(1)) then
                    if(shirt == 1) then
                        SetCharComponentVariation(GetPlayerChar(-1), 1, 4, 0)
                        shirt = 0
                    else
                        for i=1,6,1 do
                            SetCharComponentVariation(GetPlayerChar(-1), bodyparts2[i-1], currparts[i], currparts[i+7])
                            shirt = 1
                        end 
                    end
                    RequestAnims("clothing")
                    while not HaveAnimsLoaded("clothing") do Citizen.Wait(0) end
                    TaskPlayAnimWithFlags(GetPlayerChar(-1),"brushoff_suit_stand", "clothing", 8.0, 0, 0)
                    anim = 1
                end
                DrawSprite(a, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
            elseif(IsCursorInArea(0.585, 0.247, 0.14, 0.2)) then
                if(IsMouseButtonJustPressed(1)) then
                    if(pants == 1) then
                        SetCharComponentVariation(GetPlayerChar(-1), 1, 4, 0)
                        SetCharComponentVariation(GetPlayerChar(-1), 2, 3, 0)
                        pants = 0
                    else
                        for i=1,6,1 do

                            SetCharComponentVariation(GetPlayerChar(-1), bodyparts2[i-1], currparts[i], currparts[i+7])
                            pants = 1
                        end
                    end
                    RequestAnims("clothing")
					while not HaveAnimsLoaded("clothing") do Citizen.Wait(0) end
                    TaskPlayAnimWithFlags(GetPlayerChar(-1),"reach_low", "clothing", 8.0, 0, 0)
                end
                DrawSprite(b, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
            elseif(IsCursorInArea(0.585, 0.495, 0.14, 0.2)) then
                if(IsMouseButtonJustPressed(1)) then
                    if(hat == 1) then
                        ClearAllCharProps(GetPlayerChar(-1))
                        hat = 0
                    else
                        SetCharPropIndex(GetPlayerChar(-1), 0, currparts[16])
                        hat = 1
                    end
                end
                DrawSprite(d, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
            elseif(IsCursorInArea(0.417, 0.495, 0.14, 0.2)) then
                if(IsMouseButtonJustPressed(1)) then
                    if(glass == 1) then
                        ClearAllCharProps(GetPlayerChar(-1))
                        glass = 0
                    else
                        SetCharPropIndex(GetPlayerChar(-1), 1, currparts[17])
                        glass = 1
                    end
                end
                DrawSprite(c, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        if(anim == 1) then
            Citizen.Wait(2000)
            ClearCharTasksImmediately(GetPlayerChar(-1))
            anim = 0
        end
    end
end)