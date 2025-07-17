keytext = {
    "ESCAPE", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "MINUS", "EQUAL",
    "BACKSPACE", "TAB", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
    "LEFT SQUARE BRACKET", "RIGHT SQUARE BRACKET", "ENTER", "LEFT CTRL", "A", "S", "D", "F", "G", "H", "J", "K", "L",
    "SEMICOLON", "APOSTROPHE", "GRAVE", "LEFT SHIFT", "BACKSLASH", "Z", "X", "C", "V", "B", "N", "M", "COMMA", "PERIOD",
    "FORWARD SLASH", "RIGHT SHIFT", "ASTERISK", "LEFT ALT", "SPACE", "CAPS LOCK",
    "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10",
    "NUMLOCK", "SCROLL LOCK",
    "NUMPAD 7", "NUMPAD 8", "NUMPAD 9", "NUMPAD MINUS", "NUMPAD 4", "NUMPAD 5", "NUMPAD 6",
    "NUMPAD PLUS", "NUMPAD 1", "NUMPAD 2", "NUMPAD 3", "NUMPAD 0", "NUMPAD PERIOD"
}

Inventorykey = 60
Phone1Key = 59
Phone2Key = 61
VehicleMenu = 13
VoiceChatKey = 56
IntractionKey = 34
FppKey = 48
PlayerListKey = 68
IntractionKey2 = 15
ChatBoxKey = 20
QuickClothsKey = 21
HandsUpKey = 45
CrossHairKey = 50
AnimationKey = 24
JobKey = 45
RegisterNetEvent('OpenKeyBinds')
AddEventHandler('OpenKeyBinds', function()
    KeyBindMenu = true
    cursor = 1
end)
RegisterNetEvent('updKeyBinds')
AddEventHandler('updKeyBinds', function(data)
    Inventorykey = tonumber(data[1])
    Phone1Key = tonumber(data[2])
    Phone2Key = tonumber(data[3])
    VehicleMenu = tonumber(data[4])
    VoiceChatKey = tonumber(data[5])
    IntractionKey = tonumber(data[6])
    FppKey = tonumber(data[7])
    PlayerListKey = tonumber(data[8])
    IntractionKey2 = tonumber(data[9])
    ChatBoxKey = tonumber(data[10])
    QuickClothsKey = tonumber(data[11])
    HandsUpKey = tonumber(data[12])
    CrossHairKey = tonumber(data[13])
    AnimationKey = tonumber(data[14])
    JobKey = tonumber(data[15])
end)

local savechanged = 0
SaveKeyBinds = function()
	if(IsScreenFadedIn()) then
		savechanged = 1
		local data = {}
        data[1] = Inventorykey
        data[2] = Phone1Key 
        data[3] = Phone2Key 
        data[4] = VehicleMenu 
        data[5] = VoiceChatKey
        data[6] = IntractionKey
        data[7] = FppKey 
        data[8] = PlayerListKey 
        data[9] = IntractionKey2
        data[10] = ChatBoxKey
        data[11] = QuickClothsKey
        data[12] = HandsUpKey
        data[13] = CrossHairKey
        data[14] = AnimationKey
        data[15] = JobKey
		
		TriggerServerEvent('saveKeyBinds', data)
	end
end

KeyBindMenu = false

local KeyBinds = {
    Inventorykey, Phone1Key, Phone2Key, VehicleMenu, VoiceChatKey, IntractionKey,
    FppKey, PlayerListKey, IntractionKey2, ChatBoxKey, QuickClothsKey,
    HandsUpKey, CrossHairKey, AnimationKey, JobKey
}

function UpdateDisplayedKeybinds()
    KeyBinds = {
        Inventorykey, Phone1Key, Phone2Key, VehicleMenu, VoiceChatKey, IntractionKey,
        FppKey, PlayerListKey, IntractionKey2, ChatBoxKey, QuickClothsKey,
        HandsUpKey, CrossHairKey, AnimationKey, JobKey
    }
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        if(KeyBindMenu == true) then
            DisplaySprite("keybind", "main", 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
            for i=1,15,1 do
                local iy = 0.0935 + (0.045 + 0.005) * (i - 1)
                
                SetTextScale(0.2500000, 0.4000000)
                SetTextDropshadow(0, 0, 0, 0, 0)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextFont(6)
                SetTextCentre(1)
                DisplayTextWithLiteralString(0.65, iy-0.011, "STRING", keytext[KeyBinds[i]])
                UpdateDisplayedKeybinds()
                if(IsCursorInArea(0.5, iy, 0.45, 0.045)) then
					if(IsMouseButtonJustPressed(1)) then
                        if(i > 0) then
                            KeyChange(i)
                            while keymenuactive do
                                Citizen.Wait(0)
                            end
                        end
                    end
                    DisplaySprite("keybind", i, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
                end
            end
            if(IsGameKeyboardKeyJustPressed(1)) then
                KeyBindMenu = false
                cursor = 0
            end
        end
    end
end)


local keymenuactive = false
--local items = {}
KeyChange = function(key)
	keymenuactive = true
	SetCamActive(GetGameCam(), false)
	SetPlayerControl(GetPlayerId(), false)
	Citizen.CreateThread(function()
		while keymenuactive do
			Citizen.Wait(0)
            SetTextScale(0.3500000,  0.5000000)
            SetTextDropshadow(0, 0, 0, 0, 0)
            SetTextFont(6)
            SetTextCentre(1)
            DisplayTextWithLiteralString(0.5, 0.9, "STRING", "Press any key to set")
            for i=0,83,1 do
                if(IsGameKeyboardKeyJustPressed(i)) then
                    if(key == 1) then
                        Inventorykey = i
                    elseif(key == 2) then
                        Phone1Key = i
                    elseif(key == 3) then
                        Phone2Key = i
                    elseif(key == 4) then
                        VehicleMenu = i 
                    elseif(key == 5) then
                        VoiceChatKey = i
                    elseif(key == 6) then
                        IntractionKey = i
                    elseif(key == 7) then
                        FppKey = i
                    elseif(key == 8) then
                        PlayerListKey = i
                    elseif(key == 9) then
                        IntractionKey2 = i
                    elseif(key == 10) then
                        ChatBoxKey = i
                    elseif(key == 11) then
                        QuickClothsKey = i
                    elseif(key == 12) then
                        HandsUpKey = i
                    elseif(key == 13) then
                        CrossHairKey = i
                    elseif(key == 14) then
                        AnimationKey = i
                    elseif(key == 15) then
                        JobKey = i
                    end
                    keymenuactive = false
                    SetCamActive(GetGameCam(), true)
                    SetPlayerControl(GetPlayerId(), true)
                    SaveKeyBinds()
                    TriggerEvent("noticeme:Info", 'Key changed to ' .. keytext[i])
                end
            end      
        end
    end)
end
