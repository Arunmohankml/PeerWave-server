
local backid = 1
local ringid = 0
local messages = {
--{title, message}
}

RegisterNetEvent('updPhoneMessagesTitles')
AddEventHandler('updPhoneMessagesTitles', function(data)
	for i=1,#data,1 do
		messages[i] = {}
		messages[i][1] = tostring(data[i])
	end
end)

RegisterNetEvent('updPhoneMessages')
AddEventHandler('updPhoneMessages', function(data)
	for i=1,#data,1 do
		messages[i][2] = tostring(data[i])
	end
end)

RegisterNetEvent('updPhoneBack')
AddEventHandler('updPhoneBack', function(bid)
	backid = tonumber(bid)
end)

RegisterNetEvent('updPhoneRing')
AddEventHandler('updPhoneRing', function(rid)
	ringid = tonumber(rid)
end)

CreateThread(function()
	while true do
		Wait(0)
		RequestStreamedTxd("phone")
		while not HasStreamedTxdLoaded("phone") do
			Wait(0)
		end
		local phone = GetTextureFromStreamedTxd("phone", "phone")
		local background = GetTextureFromStreamedTxd("phone", "back" .. backid)
		--[[if(phonemenu == 1) then
			DrawSprite(phone, 0.845, 0.8, 0.2, 0.35, 0.0, 255, 255, 255, 255)
			DrawSprite(background, 0.845, 0.8, 0.09, 0.28, 0.0, 255, 255, 255, 255)
		end]]
	end
end)

local phonemenuactive = false
local phonemenuresult = 0
local phonecurrlist = 1
local currbutton = 0
local function DrawPhoneItems(title, items)
	phonemenuactive = true
	phonemenuresult = 0
	phonecurrlist = 1
	currbutton = 0
	cursor = 1
	SetCamActive(GetGameCam(), false)
	SetPlayerControl(GetPlayerId(), false)
	--items[#items+1] = "~r~Cancel"
	CreateThread(function()
		while phonemenuactive do
			Wait(0)
			SetPlayerControl(GetPlayerId(), false)
			
			RequestStreamedTxd("phone")
			while not HasStreamedTxdLoaded("phone") do
				Wait(0)
			end
			local phone = GetTextureFromStreamedTxd("phone", "phone")
			local background = GetTextureFromStreamedTxd("phone", "back" .. backid)
			DrawSprite(phone, 0.845, 0.8, 0.2, 0.35, 0.0, 255, 255, 255, 255)
			DrawSprite(background, 0.845, 0.8, 0.09, 0.28, 0.0, 255, 255, 255, 255)
			
			SetTextScale(0.200000,  0.4000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			SetTextFont(6)
			--SetTextEdge(1, 0, 0, 0, 255)
			SetTextWrap(0.0, 0.8+0.09/2)
			SetTextCentre(1)
			DisplayTextWithLiteralString(0.8+0.09/2, 0.8-0.28/2+0.005, "STRING", "" .. title)
			
			DrawRectLeftTopCenter(0.8, 0.8-0.28/2, 0.09, 0.03, 0, 0, 100, 255)
			--DrawCurvedWindow(0.3, 0.28, 0.4, 0.42, 100)
			--DrawRectLeftTopCenter(0.7, 0.1, 0.2, 0.3, 90, 90, 90, 100)
			currbutton = 0
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
				
				if(phonecurrlist > finalnum) then
					phonecurrlist = 1
				end
				
				local sep = 10
				for i=1,#templist,1 do
					if(phonecurrlist == i) then
						for j=1,#templist[i],1 do
							DrawRectLeftTopCenter(0.8, 0.8-0.28/2+0.03+0.22/sep*(j-1), 0.09, 0.22/sep, 0, 0, 0, 100)
							SetTextScale(0.100000,  0.3000000)
							SetTextDropshadow(0, 0, 0, 0, 0)
							--SetTextFont(6)
							--SetTextEdge(1, 0, 0, 0, 255)
							--SetTextWrap(0.0, 0.3)
							--SetTextCentre(1)
							DisplayTextWithLiteralString(0.8+0.0025, 0.8-0.28/2+0.03+0.22/sep*(j-1)+0.0025, "STRING", "" .. templist[i][j])
							if(IsCursorInAreaLeftTopCenter(0.8, 0.8-0.28/2+0.03+0.22/sep*(j-1), 0.09, 0.22/sep)) then
								currbutton = j+10*(i-1)
								DrawRectLeftTopCenter(0.8, 0.8-0.28/2+0.03+0.22/sep*(j-1), 0.09, 0.22/sep, 255, 255, 255, 255)
								SetTextScale(0.100000,  0.3000000)
								SetTextDropshadow(0, 0, 0, 0, 0)
								--SetTextFont(6)
								--SetTextEdge(1, 0, 0, 0, 255)
								--SetTextWrap(0.0, 0.3)
								--SetTextCentre(1)
								SetTextColour(0, 0, 0, 255)
								DisplayTextWithLiteralString(0.8+0.0025, 0.8-0.28/2+0.03+0.22/sep*(j-1)+0.0025, "STRING", "" .. templist[i][j])
								if(IsMouseButtonJustPressed(1)) then
									--if(10*(i-1)+j ~= #items) then
										phonemenuresult = 10*(i-1)+j
									--end
									phonemenuactive = false
									cursor = 0
								end
							end
							DrawRectLeftTopCenter(0.89-0.005, 0.8-0.28/2+0.03+0.22/#templist*(phonecurrlist-1), 0.005, 0.22/#templist, 255, 255, 0, 255)
						end
					end
				end
				if(GetMouseWheel(_i) ~= 0) then
					if(GetMouseWheel(_i) == 127) then
						if(phonecurrlist < #templist) then
							phonecurrlist = phonecurrlist + 1
						end
					else
						if(phonecurrlist > 1) then
							phonecurrlist = phonecurrlist - 1
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
					DrawRectLeftTopCenter(0.8, 0.8-0.28/2+0.03+0.22/sep*(i-1), 0.09, 0.22/sep, 0, 0, 0, 100)
					SetTextScale(0.100000,  0.3000000)
					SetTextDropshadow(0, 0, 0, 0, 0)
					--SetTextFont(6)
					--SetTextEdge(1, 0, 0, 0, 255)
					--SetTextWrap(0.0, 0.3)
					--SetTextCentre(1)
					DisplayTextWithLiteralString(0.8+0.0025, 0.8-0.28/2+0.03+0.22/sep*(i-1)+0.0025, "STRING", "" .. items[i])
					if(IsCursorInAreaLeftTopCenter(0.8, 0.8-0.28/2+0.03+0.22/sep*(i-1), 0.09, 0.22/sep)) then
						currbutton = i
						DrawRectLeftTopCenter(0.8, 0.8-0.28/2+0.03+0.22/sep*(i-1), 0.09, 0.22/sep, 255, 255, 255, 255)
						SetTextScale(0.100000,  0.3000000)
						SetTextDropshadow(0, 0, 0, 0, 0)
						--SetTextFont(6)
						--SetTextEdge(1, 0, 0, 0, 255)
						--SetTextWrap(0.0, 0.3)
						--SetTextCentre(1)
						SetTextColour(0, 0, 0, 255)
						DisplayTextWithLiteralString(0.8+0.0025, 0.8-0.28/2+0.03+0.22/sep*(i-1)+0.0025, "STRING", "" .. items[i])
						if(IsMouseButtonJustPressed(1)) then
							--if(i ~= #items) then
							if(items[i] ~= "~r~Cancel") then
								phonemenuresult = i
							end
							phonemenuactive = false
							cursor = 0
						end
					end
				end
			end
			if(IsMouseButtonJustPressed(2)) then
				phonemenuactive = false
				cursor = 0

			end
			
			SetTextScale(0.100000,  0.3000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			--SetTextFont(6)
			SetTextEdge(1, 0, 0, 0, 255)
			--SetTextWrap(0.0, 0.3)
			--SetTextCentre(1)
			SetTextColour(0, 255, 0, 255)
			DisplayTextWithLiteralString(0.8+0.0025, 0.8+0.28/2-0.03+0.005, "STRING", "Select (LMB)")
			
			SetTextScale(0.100000,  0.3000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			--SetTextFont(6)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextWrap(0.0, 0.89-0.005)
			--SetTextCentre(1)
			SetTextRightJustify(1)
			SetTextColour(191, 0, 255, 255)
			DisplayTextWithLiteralString(0.89-0.0025, 0.8+0.28/2-0.03+0.005, "STRING", "(RMB)_Back")
		end
		Wait(200)
		SetCamActive(GetGameCam(), true)
		SetPlayerControl(GetPlayerId(), true)
		SetGameCameraControlsActive(true)
	end)
end

local signal = false
local signaltime = 0
local function DrawPhoneSignal(text, duration)
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
			SetTextScale(0.1500000, 0.3000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			SetTextEdge(1, 0, 0, 0, 255)
			--SetTextWrap(0.0, cx)
			--SetTextCentre(1)
			DisplayTextWithLiteralString(0.05, 0.7, "STRING", "" .. text)
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

RegisterNetEvent('sendPhoneMessage')
AddEventHandler('sendPhoneMessage', function(id, title, msg)
	if(ConvertIntToPlayerindex(id) == ConvertIntToPlayerindex(GetPlayerId())) then
		messages[#messages+1] = {title, msg}
		TriggerServerEvent('savePhoneMessages', messages)
		DrawPhoneSignal("New message received", 10000)
	end
end)

local phonemessageactive = false
local phonemessageresult = 0
local function DrawPhoneMessage(text, additional)
	phonemessageactive = true
	phonemessageresult = 0
	cursor = 1
	SetCamActive(GetGameCam(), false)
	SetPlayerControl(GetPlayerId(), false)
	
	local temptext = text
	local textlines = {}
	::again::
	textlines[#textlines+1] = temptext:sub(1, 25)
	temptext = temptext:sub(26, #temptext)
	if(#temptext > 0) then
		goto again
	end
	
	CreateThread(function()
		while phonemessageactive do
			Wait(0)
			SetPlayerControl(GetPlayerId(), false)
			
			RequestStreamedTxd("phone")
			while not HasStreamedTxdLoaded("phone") do
				Wait(0)
			end
			local phone = GetTextureFromStreamedTxd("phone", "phone")
			local background = GetTextureFromStreamedTxd("phone", "back" .. backid)
			DrawSprite(phone, 0.845, 0.8, 0.2, 0.35, 0.0, 255, 255, 255, 255)
			DrawSprite(background, 0.845, 0.8, 0.09, 0.28, 0.0, 255, 255, 255, 255)
			
			DrawRectLeftTopCenter(0.8, 0.8-0.28/2, 0.09, 0.25, 0, 0, 0, 100)
			for i=1,#textlines,1 do
				SetTextScale(0.100000,  0.3000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				--SetTextFont(6)
				--SetTextEdge(1, 0, 0, 0, 255)
				--SetTextWrap(0.0, 0.3)
				--SetTextCentre(1)
				DisplayTextWithLiteralString(0.8+0.0025, 0.8-0.28/2+0.25/10*(i-1)+0.0025, "STRING", "" .. textlines[i])
			end
			
			if(additional ~= nil) then
				SetTextScale(0.100000,  0.3000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				--SetTextFont(6)
				SetTextEdge(1, 0, 0, 0, 255)
				--SetTextWrap(0.0, 0.3)
				--SetTextCentre(1)
				SetTextColour(0, 255, 0, 255)
				DisplayTextWithLiteralString(0.8+0.0025, 0.8+0.28/2-0.03+0.005, "STRING", additional .. " (LMB)")
				
				if(IsMouseButtonJustPressed(1)) then
					phonemessageresult = 1
					phonemessageactive = false
					cursor = 0
				end
			end
			
			SetTextScale(0.100000,  0.3000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			--SetTextFont(6)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextWrap(0.0, 0.89-0.005)
			--SetTextCentre(1)
			SetTextRightJustify(1)
			SetTextColour(191, 0, 255, 255)
			DisplayTextWithLiteralString(0.89-0.0025, 0.8+0.28/2-0.03+0.005, "STRING", "(RMB)_Back")
			
			if(IsMouseButtonJustPressed(2)) then
				phonemessageactive = false
				cursor = 0
			end
		end
		Wait(200)
		SetCamActive(GetGameCam(), true)
		SetPlayerControl(GetPlayerId(), true)
		SetGameCameraControlsActive(true)
	end)
end

phonecall = {}
for i=0,31,1 do
	phonecall[i] = i
end
RegisterNetEvent('updateCall')
AddEventHandler('updateCall', function(id, state)
	phonecall[id] = state
end)
RegisterNetEvent('callPlayer')
AddEventHandler('callPlayer', function(target, caller)
	if(ConvertIntToPlayerindex(target) == ConvertIntToPlayerindex(GetPlayerId())) then
		if(IsPlayerControlOn(GetPlayerId())) then
			phonemenuresult = 1000
			phonemenuactive = false
			phonemessageactive = false
			cursor = 0
			StartCustomMobilePhoneRinging(ringid)
			DrawPhoneItems("Incoming_call", {"Answer to " .. GetPlayerName(caller)})
			while phonemenuactive do
				Wait(0)
				SetPlayerControl(GetPlayerId(), true)
				SetCamBehindPed(GetPlayerChar(-1))
				SetGameCameraControlsActive(false)
			end
			if(phonemenuresult > 0) then
				StopMobilePhoneRinging()
				if(phonemenuresult == 1) then
					TriggerServerEvent('returnCallResult', caller, 1)
					--exports.voicechat:SetPlayerChannel(target)
					TriggerServerEvent('updateCall', target, target)
					DrawPhoneMessage("Hold N to talk")
					while phonemessageactive do
						Wait(0)
						SetPlayerControl(GetPlayerId(), true)
						SetCamBehindPed(GetPlayerChar(-1))
						SetGameCameraControlsActive(false)
					end
					--exports.voicechat:SetPlayerChannel(target)
					TriggerServerEvent('updateCall', target, target)
					TriggerServerEvent('finishCall', caller)
				end
			else
				StopMobilePhoneRinging()
				TriggerServerEvent('returnCallResult', caller, 0)
			end
		end
	end
end)
RegisterNetEvent('cancelCall')
AddEventHandler('cancelCall', function(target)
	if(ConvertIntToPlayerindex(target) == ConvertIntToPlayerindex(GetPlayerId())) then
		phonemenuresult = 1000
		phonemenuactive = false
		cursor = 0
		StopMobilePhoneRinging()
	end
end)
RegisterNetEvent('finishCall')
AddEventHandler('finishCall', function(target)
	if(ConvertIntToPlayerindex(target) == ConvertIntToPlayerindex(GetPlayerId())) then
		--exports.voicechat:SetPlayerChannel(target)
		TriggerServerEvent('updateCall', target, target)
		phonemessageactive = false
		cursor = 0
	end
end)
callresult = nil
RegisterNetEvent('returnCallResult')
AddEventHandler('returnCallResult', function(target, result)
	if(ConvertIntToPlayerindex(target) == ConvertIntToPlayerindex(GetPlayerId())) then
		callresult = result
	end
end)

local numbers = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}
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

local function ActivateInput(buttonname)
	local chatstring = ""
	cursor = 1
	SetCamActive(GetGameCam(), false)
	SetPlayerControl(GetPlayerId(), false)
	while true do
		Wait(0)
		SetPlayerControl(GetPlayerId(), false)
		DrawRectLeftTopCenter(0.3, 0.5, 0.4, 0.05, 0, 0, 0, 100)
		if(not IsGameKeyboardKeyPressed(42)) then --letters
			for i=1,10,1 do
				if(IsGameKeyboardKeyJustPressed(i+15)) then
					chatstring = "" .. chatstring .. "" .. letters1[i]
				end
			end
			for i=1,9,1 do
				if(IsGameKeyboardKeyJustPressed(i+29)) then
					chatstring = "" .. chatstring .. "" .. letters2[i]
				end
			end
			for i=1,7,1 do
				if(IsGameKeyboardKeyJustPressed(i+43)) then
					chatstring = "" .. chatstring .. "" .. letters3[i]
				end
			end
		else --letters with shift
			for i=1,10,1 do
				if(IsGameKeyboardKeyJustPressed(i+15)) then
					chatstring = "" .. chatstring .. "" .. letters1c[i]
				end
			end
			for i=1,9,1 do
				if(IsGameKeyboardKeyJustPressed(i+29)) then
					chatstring = "" .. chatstring .. "" .. letters2c[i]
				end
			end
			for i=1,7,1 do
				if(IsGameKeyboardKeyJustPressed(i+43)) then
					chatstring = "" .. chatstring .. "" .. letters3c[i]
				end
			end
		end
		if(not IsGameKeyboardKeyPressed(42)) then --additional symbols
			for i=1,10,1 do --numbers
				if(IsGameKeyboardKeyJustPressed(i+1)) then
					chatstring = "" .. chatstring .. "" .. numbers[i]
				end
			end
			for i=1,12,1 do --additional symbols 1
				if(IsGameKeyboardKeyJustPressed(keys[i])) then
					chatstring = "" .. chatstring .. "" .. keysresult[i]
				end
			end
		else
			for i=1,17,1 do --additional symbols 2 (with shift)
				if(IsGameKeyboardKeyJustPressed(keys2[i])) then
					chatstring = "" .. chatstring .. "" .. keysresult2[i]
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
				Notify('Message cannot exceed 100 characters!')
			end
		else
			SetTextScale(0.1000000,  0.3000000)
			SetTextEdge(1, 0, 0, 0, 255)
			--SetTextFont(6)
			--SetTextCentre(1)
			DisplayTextWithLiteralString(0.31, 0.515, "STRING", "Enter message")
		end
		------
		local temptext = "Send"
		if(buttonname ~= nil) then
			temptext = "" .. buttonname
		end
		DrawRectLeftTopCenter(0.4-0.1, 0.7, 0.2, 0.1, 0, 0, 0, 100)
		SetTextScale(0.300000,  0.6000000)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextCentre(1)
		SetTextWrap(0.0, 0.5-0.1)
		DisplayTextWithLiteralString(0.5-0.1, 0.73, "STRING", "" .. temptext)
		if(IsCursorInAreaLeftTopCenter(0.4-0.1, 0.7, 0.2, 0.1)) then
			DrawRectLeftTopCenter(0.4-0.1, 0.7, 0.2, 0.1, 255, 255, 255, 255)
			if(IsMouseButtonJustPressed(1)) then
				if(chatstring ~= "") then
					cursor = 0
					SetPlayerControl(GetPlayerId(), true)
					SetCamActive(GetGameCam(), true)
					return chatstring
				else
					Notify('Enter text!')
				end
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
end

local waypoint = {}
CreateThread(function()
	while true do
		Wait(0)
		if(#waypoint > 0) then
			if(not DoesBlipExist(wayblip)) then
				wayblip = AddBlipForCoord(waypoint[1], waypoint[2], waypoint[3])
				ChangeBlipNameFromAscii(wayblip, "Waypoint")
				ChangeBlipSprite(wayblip, 8)
				SetRoute(wayblip, true)
			else
				if(IsPlayerNearCoords(waypoint[1], waypoint[2], waypoint[3], 10)) then
					waypoint = {}
				end
			end
		else
			RemoveBlip(wayblip)
		end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if(IsGameKeyboardKeyJustPressed(Phone2Key)) then
			if(inventory[41] == 1)then
				--[[if(not DoesObjectExist(nokia)) then
					local x,y,z = GetCharCoordinates(GetPlayerChar(-1))
					local nokia = SpawnObject(GetHashKey("amb_mobile_2"), x,y,z)
					FreezeObjectPosition(nokia, true)
					SetObjectAsStealable(nokia, 1)
					SetObjectDynamic(nokia, 1)
					GivePedPickupObject(GetPlayerChar(-1), nokia, 1)
					SetObjectRecordsCollisions(nokia, 1)
				end]]
                usingphone = 2
				if(IsPlayerControlOn(GetPlayerId())) then
					::main::
					local tempday = GetCurrentDayOfWeek()
					local days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
					days[0] = "Sunday"
					local day = days[tempday]
					if(day == nil) then
						day = ""
					end
					local h,m = GetTimeOfDay()
					if(h < 10) then
						h = "0" .. h
					else
						h = "" .. h
					end
					if(m < 10) then
						m = "0" .. m
					else
						m = "" .. m
					end
					local tempitems = {}
					tempitems[#tempitems+1] = "Phonebook"
					tempitems[#tempitems+1] = "Messages"
					tempitems[#tempitems+1] = "GPS"
					tempitems[#tempitems+1] = "MP3 player"
					tempitems[#tempitems+1] = "Settings"
					--tempitems[#tempitems+1] = "Change background"
					DrawPhoneItems("" .. day .. "_" .. h .. ":" .. m, tempitems)
					while phonemenuactive do
						Wait(0)
						SetPlayerControl(GetPlayerId(), true)
						SetCamBehindPed(GetPlayerChar(-1))
						SetGameCameraControlsActive(false)
					end
					if(phonemenuresult > 0) then
						if(tempitems[phonemenuresult] == "Phonebook") then
							::phonebookmain::
							local tempitems = {}
							tempitems[#tempitems+1] = "Players"
							tempitems[#tempitems+1] = "Services"
							DrawPhoneItems("Phonebook", tempitems)
							while phonemenuactive do
								Wait(0)
								SetPlayerControl(GetPlayerId(), true)
								SetCamBehindPed(GetPlayerChar(-1))
								SetGameCameraControlsActive(false)
							end
							if(phonemenuresult > 0) then
								if(tempitems[phonemenuresult] == "Players") then
									::phonebook::
									local tempplayers = {}
									for i=0,31,1 do
										if(IsNetworkPlayerActive(i)) then
											if(ConvertIntToPlayerindex(i) ~= ConvertIntToPlayerindex(GetPlayerId())) then
												tempplayers[#tempplayers+1] = i
											end
										end
									end
									local tempitems = {}
									for i=1,#tempplayers,1 do
										tempitems[#tempitems+1] = "" .. GetPlayerName(tempplayers[i])
									end
									DrawPhoneItems("Phonebook", tempitems)
									while phonemenuactive do
										Wait(0)
										SetPlayerControl(GetPlayerId(), true)
										SetCamBehindPed(GetPlayerChar(-1))
										SetGameCameraControlsActive(false)
									end
									if(phonemenuresult > 0) then
										local currplayer = tempplayers[phonemenuresult]
										local tempitems = {}
										tempitems[#tempitems+1] = "Send message"
										tempitems[#tempitems+1] = "Call"
										DrawPhoneItems("" .. GetStringWithoutSpaces("" .. GetPlayerName(currplayer)), tempitems)
										while phonemenuactive do
											Wait(0)
											SetPlayerControl(GetPlayerId(), true)
											SetCamBehindPed(GetPlayerChar(-1))
											SetGameCameraControlsActive(false)
										end
										if(phonemenuresult > 0) then
											if(tempitems[phonemenuresult] == "Send message") then
												local message = ActivateInput()
												if(message ~= "") then
													TriggerServerEvent('sendPhoneMessage', currplayer, "Message from " .. GetPlayerName(GetPlayerId()), message)
												end
												goto phonebook
											elseif(tempitems[phonemenuresult] == "Call") then
												if(phonecall[currplayer] == currplayer) then
													TriggerServerEvent('callPlayer', currplayer, ConvertIntToPlayerindex(GetPlayerId()))
													DrawPhoneMessage("Calling to " .. GetPlayerName(currplayer) .. "...")
													while phonemessageactive do
														Wait(0)
														SetPlayerControl(GetPlayerId(), true)
														SetCamBehindPed(GetPlayerChar(-1))
														SetGameCameraControlsActive(false)
														if(callresult ~= nil) then
															if(callresult == 0) then
																callresult = nil
																cursor = 0
																phonemessageactive = false
																Wait(100)
																DrawPhoneMessage("The call was rejected.")
																while phonemessageactive do
																	Wait(0)
																	SetPlayerControl(GetPlayerId(), true)
																	SetCamBehindPed(GetPlayerChar(-1))
																	SetGameCameraControlsActive(false)
																end
																goto finish4
															else
																callresult = nil
																cursor = 0
																phonemessageactive = false
																Wait(100)
																--exports.voicechat:SetPlayerChannel(currplayer)
																TriggerServerEvent('updateCall', ConvertIntToPlayerindex(GetPlayerId()), currplayer)
																DrawPhoneMessage("Hold N to talk")
																while phonemessageactive do
																	Wait(0)
																	SetPlayerControl(GetPlayerId(), true)
																	SetCamBehindPed(GetPlayerChar(-1))
																	SetGameCameraControlsActive(false)
																end
																--exports.voicechat:SetPlayerChannel(ConvertIntToPlayerindex(GetPlayerId()))
																TriggerServerEvent('updateCall', ConvertIntToPlayerindex(GetPlayerId()), ConvertIntToPlayerindex(GetPlayerId()))
																TriggerServerEvent('finishCall', currplayer)
																goto finish4
															end
														end
													end
													TriggerServerEvent('cancelCall', currplayer)
													::finish4::
												else
													DrawPhoneMessage("This player is currently talking.")
													while phonemessageactive do
														Wait(0)
														SetPlayerControl(GetPlayerId(), true)
														SetCamBehindPed(GetPlayerChar(-1))
														SetGameCameraControlsActive(false)
													end
												end
											end
										else
											goto phonebook
										end
									else
										goto main
									end
								elseif(tempitems[phonemenuresult] == "Services") then
									local tempitems = {}
									tempitems[#tempitems+1] = "Taxi"
									tempitems[#tempitems+1] = "Mechanic"
									tempitems[#tempitems+1] = "Police"
									tempitems[#tempitems+1] = "Ambulance"
									tempitems[#tempitems+1] = "Hooker"
									DrawPhoneItems("Services", tempitems)
									while phonemenuactive do
										Wait(0)
										SetPlayerControl(GetPlayerId(), true)
										SetCamBehindPed(GetPlayerChar(-1))
										SetGameCameraControlsActive(false)
									end
									if(phonemenuresult > 0) then
										local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
										if(tempitems[phonemenuresult] == "Taxi") then
											TriggerServerEvent('addTaxiOrder', ConvertIntToPlayerindex(GetPlayerId()), px, py, pz)
											Notify("Taxi has been ordered.")
										elseif(tempitems[phonemenuresult] == "Mechanic") then
											TriggerServerEvent('addMechOrder', ConvertIntToPlayerindex(GetPlayerId()), px, py, pz)
											Notify("Mechanic has been ordered.")
										elseif(tempitems[phonemenuresult] == "Police") then
											TriggerServerEvent('addPoliceOrder', ConvertIntToPlayerindex(GetPlayerId()), px, py, pz)
											Notify("Police has been requested.")
										elseif(tempitems[phonemenuresult] == "Ambulance") then
											TriggerServerEvent('addMedicOrder', ConvertIntToPlayerindex(GetPlayerId()), px, py, pz)
											Notify("Ambulance has been requested.")
										elseif(tempitems[phonemenuresult] == "Hooker") then
											TriggerServerEvent('addHookerOrder', ConvertIntToPlayerindex(GetPlayerId()), px, py, pz)
											Notify("Hooker has been requested.")
										end
									else
										goto phonebookmain
									end
								end
							else
								goto main
							end
						elseif(tempitems[phonemenuresult] == "Messages") then
							::messages::
							local tempitems = {}
							for i=1,#messages,1 do
								tempitems[i] = "" .. messages[i][1]
							end
							DrawPhoneItems("Messages", tempitems)
							while phonemenuactive do
								Wait(0)
								SetPlayerControl(GetPlayerId(), true)
								SetCamBehindPed(GetPlayerChar(-1))
								SetGameCameraControlsActive(false)
							end
							if(phonemenuresult > 0) then
								local currmessage = phonemenuresult
								DrawPhoneMessage("" .. messages[phonemenuresult][2], "Options")
								while phonemessageactive do
									Wait(0)
									SetPlayerControl(GetPlayerId(), true)
									SetCamBehindPed(GetPlayerChar(-1))
									SetGameCameraControlsActive(false)
								end
								if(phonemessageresult > 0) then
									local tempitems = {}
									tempitems[#tempitems+1] = "Delete"
									DrawPhoneItems("Options", tempitems)
									while phonemenuactive do
										Wait(0)
										SetPlayerControl(GetPlayerId(), true)
										SetCamBehindPed(GetPlayerChar(-1))
										SetGameCameraControlsActive(false)
									end
									if(phonemenuresult > 0) then
										if(tempitems[phonemenuresult] == "Delete") then
											local newmessages = {}
											for i=1,#messages,1 do
												if(messages[i] ~= messages[currmessage]) then
													table.insert(newmessages, messages[i])
												end
											end
											messages = newmessages
											TriggerServerEvent('savePhoneMessages', messages)
											goto messages
										end
									else
										goto messages
									end
								end
								goto messages
							else
								goto main
							end
						elseif(tempitems[phonemenuresult] == "GPS") then
							::navigation::
							local tempitems = {}
							tempitems[#tempitems+1] = "Important places"
							tempitems[#tempitems+1] = "Jobs"
							tempitems[#tempitems+1] = "Factions"
							tempitems[#tempitems+1] = "Houses"
							tempitems[#tempitems+1] = "Businesses"
							tempitems[#tempitems+1] = "Remove waypoint"
							DrawPhoneItems("GPS", tempitems)
							while phonemenuactive do
								Wait(0)
								SetPlayerControl(GetPlayerId(), true)
								SetCamBehindPed(GetPlayerChar(-1))
								SetGameCameraControlsActive(false)
							end
							if(phonemenuresult > 0) then
								if(tempitems[phonemenuresult] == "Important places") then
									local tempitems = {}
									tempitems[#tempitems+1] = "Closest shop"
									tempitems[#tempitems+1] = "Closest clothes shop"
									tempitems[#tempitems+1] = "Closest gun shop"
									tempitems[#tempitems+1] = "Closest tuning shop"
									tempitems[#tempitems+1] = "Closest parking"
									tempitems[#tempitems+1] = "Driving school"
									tempitems[#tempitems+1] = "Closest car shop"
									--tempitems[#tempitems+1] = "Hunting shop"
									DrawPhoneItems("Important places", tempitems)
									while phonemenuactive do
										Wait(0)
										SetPlayerControl(GetPlayerId(), true)
										SetCamBehindPed(GetPlayerChar(-1))
										SetGameCameraControlsActive(false)
									end
									if(phonemenuresult > 0) then
										if(tempitems[phonemenuresult] == "Closest shop") then
											local tempcoord = GetClosestCoord({
											{-1007.28687, 1625.54504, 24.319, 0.0141445221379399, -1455049321},
											{-429.26251, 1195.4093, 13.05202, 271.072387695313, -1455049321},
											{-173.48801, 288.77267, 14.82508, 268.388519287109, -1455049321},
											{-616.34607, 135.0834, 4.81617, 180.562149047852, -1455049321},
											{-123.68917, 69.92794, 14.80807, 284.135955810547, -111107426},
											{1184.99438, 362.21744, 25.1083, 181.052612304688, -111107426},
											{1640.53381, 224.86064, 25.21699, 89.3413696289063, -1455049321},
											{884.86017, -485.32562, 15.88777, 181.32063293457, 1015898343}
											})
											waypoint = {tempcoord[1], tempcoord[2], tempcoord[3]}
										elseif(tempitems[phonemenuresult] == "Closest clothes shop") then
											local tempcoord = GetClosestCoord({
											{-284.48291, 1364.14771, 25.63738, 222.996063232422},
											{22.29914, 798.54492, 14.7668, 0.411204695701599},
											{10.81859, -670.22687, 14.86652, 359.982604980469},
											{880.54913, -446.63824, 15.85833, 311.022064208984}
											})
											waypoint = {tempcoord[1], tempcoord[2], tempcoord[3]}
										elseif(tempitems[phonemenuresult] == "Closest gun shop") then
											local tempcoord = GetClosestCoord({
											{1067.31335, 87.11202, 34.25125, 178.692932128906},
											{82.20334, -342.00589, 11.18179, 178.316635131836},
											{-1333.16357, 318.77249, 14.62244, 276.131530761719}
											})
											waypoint = {tempcoord[1], tempcoord[2], tempcoord[3]}
										elseif(tempitems[phonemenuresult] == "Closest tuning shop") then
											local tempcoord = GetClosestCoord({
											{876.49695, -115.73891, 6.02284, 154.089828491211, -2012314136},
											{711.28668, 1506.01782, 14.84259, 179.616546630859, 0}
											})
											waypoint = {tempcoord[1], tempcoord[2], tempcoord[3]}
										elseif(tempitems[phonemenuresult] == "Closest parking") then
											local tempcoord = GetClosestCoord({
											{77.81879, 1136.23767, 2.91673, 180.148788452148, 0},
											{-611.03168, 488.26328, 4.94424, 178.994079589844, 0},
											{-987.90167, 1405.23193, 25.68967, 359.592956542969, 0},
											{2255.20044, 377.797, 7.49959, 269.999328613281, 0},
											{1139.75403, 138.98798, 32.93008, 89.5817260742188, 0},
											{1135.30762, 566.11456, 32.45714, 271.084716796875, 0},
											{1760.18433, 405.69009, 25.41919, 89.9305038452148, 0},
											{460.47888, 1738.85339, 15.80869, 233.583480834961, 0},
											{1.39831, -191.8354, 14.53183, 0.116277135908604, 0},
											{-533.2251, 1127.85449, 9.98309, 358.571685791016, 0},
											{-594.87897, -97.80893, 6.43994, 177.629516601563, 0},
											{185.79355, 175.86176, 14.76956, 179.677947998047, 0},
											{-1424.78125, 621.49609, 19.57296, 106.875793457031, 0},
											{-1865.62903, 158.94798, 15.01166, 277.306518554688, 0}
											})
											waypoint = {tempcoord[1], tempcoord[2], tempcoord[3]}
										elseif(tempitems[phonemenuresult] == "Driving school") then
											waypoint = {-406.60873, 282.16464, 13.24742}
										elseif(tempitems[phonemenuresult] == "Closest car shop") then
											local tempcoord = GetClosestCoord({
											{-1496.90393, 1118.74939, 23.21376},
											{-1088.06372, 1473.52173, 24.79185, 90.0429992675781},
											{80.17219, 801.10474, 15.16314, 270.032409667969}
											})
											waypoint = {tempcoord[1], tempcoord[2], tempcoord[3]}
										--elseif(tempitems[phonemenuresult] == "Hunting shop") then
										--	waypoint = {}
										end
										goto navigation
									else
										goto navigation
									end
								elseif(tempitems[phonemenuresult] == "Jobs") then
									local tempitems = {}
									tempitems[#tempitems+1] = "Loader"
									tempitems[#tempitems+1] = "Forklift loader"
									tempitems[#tempitems+1] = "Builder"
									tempitems[#tempitems+1] = "Supplier"
									tempitems[#tempitems+1] = "Bus driver"
									tempitems[#tempitems+1] = "Taxi"
									tempitems[#tempitems+1] = "Mechanic"
									tempitems[#tempitems+1] = "Trucker"
									tempitems[#tempitems+1] = "Fisher"
									DrawPhoneItems("Jobs", tempitems)
									while phonemenuactive do
										Wait(0)
										SetPlayerControl(GetPlayerId(), true)
										SetCamBehindPed(GetPlayerChar(-1))
										SetGameCameraControlsActive(false)
									end
									if(phonemenuresult > 0) then
										if(tempitems[phonemenuresult] == "Loader") then
											waypoint = {785.62482, -175.39842, 6.09623}
										elseif(tempitems[phonemenuresult] == "Forklift loader") then
											waypoint = {709.78094, -361.49918, 6.33745}
										elseif(tempitems[phonemenuresult] == "Builder") then
											waypoint = {123.9094, -857.36517, 5.25695}
										elseif(tempitems[phonemenuresult] == "Supplier") then
											waypoint = {-59.09336, -922.64478, 5.49466}
										elseif(tempitems[phonemenuresult] == "Bus driver") then
											waypoint = {1034.09448, 298.09409, 32.03739}
										elseif(tempitems[phonemenuresult] == "Taxi") then
											waypoint = {820.24219, -265.84424, 15.34273}
										elseif(tempitems[phonemenuresult] == "Mechanic") then
											waypoint = {1790.28601, 192.92586, 21.09238}
										elseif(tempitems[phonemenuresult] == "Trucker") then
											waypoint = {-945.29657, 317.75858, 4.50798}
										elseif(tempitems[phonemenuresult] == "Fisher") then
											waypoint = {461.75272, 1109.80493, 3.06511}
										elseif(tempitems[phonemenuresult] == "Lawyer") then
											waypoint = {77.17374, -708.09344, 5.00153}
										end
										goto navigation
									else
										goto navigation
									end
								elseif(tempitems[phonemenuresult] == "Factions") then
									local tempitems = {}
									tempitems[#tempitems+1] = "Police"
									tempitems[#tempitems+1] = "Medic"
									tempitems[#tempitems+1] = "NOOSE"
									tempitems[#tempitems+1] = "Spanish Lords"
									tempitems[#tempitems+1] = "Yardies"
									tempitems[#tempitems+1] = "Hustlers"
									DrawPhoneItems("Factions", tempitems)
									while phonemenuactive do
										Wait(0)
										SetPlayerControl(GetPlayerId(), true)
										SetCamBehindPed(GetPlayerChar(-1))
										SetGameCameraControlsActive(false)
									end
									if(phonemenuresult > 0) then
										if(tempitems[phonemenuresult] == "Police") then
											waypoint = {93.60903, 1211.40063, 14.73794}
										elseif(tempitems[phonemenuresult] == "Medic") then
											waypoint = {1206.43445, 187.60365, 33.55356}
										elseif(tempitems[phonemenuresult] == "NOOSE") then
											waypoint = {-1081.22754, -354.88205, 7.4039}
										elseif(tempitems[phonemenuresult] == "Spanish Lords") then
											waypoint = {1199.33301, 1695.49939, 17.72684}
										elseif(tempitems[phonemenuresult] == "Yardies") then
											waypoint = {1189.44751, 1442.5769, 30.28511}
										elseif(tempitems[phonemenuresult] == "Hustlers") then
											waypoint = {402.94717, 1473.53015, 11.83429}
										end
										goto navigation
									else
										goto navigation
									end
								elseif(tempitems[phonemenuresult] == "Houses") then
									local tempitems = {}
									for i=1,#houseinfo,1 do
										tempitems[i] = "House #" .. i .. " (" .. houseinfo[i][1] .. "$)"
									end
									DrawPhoneItems("Houses", tempitems)
									while phonemenuactive do
										Wait(0)
										SetPlayerControl(GetPlayerId(), true)
										SetCamBehindPed(GetPlayerChar(-1))
										SetGameCameraControlsActive(false)
									end
									if(phonemenuresult > 0) then
										waypoint = {houseinfo[phonemenuresult][2][1], houseinfo[phonemenuresult][2][2], houseinfo[phonemenuresult][2][3]}
										goto navigation
									else
										goto navigation
									end
								elseif(tempitems[phonemenuresult] == "Businesses") then
									local tempitems = {}
									for i=1,#bizinfo,1 do
										tempitems[i] = "" .. bizinfo[i][3] .. " (" .. bizinfo[i][1] .. "$)"
									end
									DrawPhoneItems("Businesses", tempitems)
									while phonemenuactive do
										Wait(0)
										SetPlayerControl(GetPlayerId(), true)
										SetCamBehindPed(GetPlayerChar(-1))
										SetGameCameraControlsActive(false)
									end
									if(phonemenuresult > 0) then
										waypoint = {bizinfo[phonemenuresult][2][1], bizinfo[phonemenuresult][2][2], bizinfo[phonemenuresult][2][3]}
										goto navigation
									else
										goto navigation
									end
								elseif(tempitems[phonemenuresult] == "Remove waypoint") then
									waypoint = {}
									goto navigation
								end
							else
								goto main
							end
						elseif(tempitems[phonemenuresult] == "MP3 player") then
							::radio::
							local tempitems = {}
							tempitems[#tempitems+1] = "Radio Off"
							tempitems[#tempitems+1] = "The Vibe"
							tempitems[#tempitems+1] = "Liberty Rock Radio"
							tempitems[#tempitems+1] = "Jazz Nation Radio"
							tempitems[#tempitems+1] = "Massive B"
							tempitems[#tempitems+1] = "K 109"
							tempitems[#tempitems+1] = "WKTT"
							tempitems[#tempitems+1] = "LCHC"
							tempitems[#tempitems+1] = "The Journey"
							tempitems[#tempitems+1] = "Fusion FM"
							tempitems[#tempitems+1] = "The Beat 102.7"
							tempitems[#tempitems+1] = "Radio Broker"
							tempitems[#tempitems+1] = "Vladivostok FM"
							tempitems[#tempitems+1] = "PLR"
							tempitems[#tempitems+1] = "San Juan Sounds"
							tempitems[#tempitems+1] = "Electro-choc"
							tempitems[#tempitems+1] = "The Classics"
							tempitems[#tempitems+1] = "IF 99"
							tempitems[#tempitems+1] = "Tuff Gong"
							tempitems[#tempitems+1] = "Independence FM"
							tempitems[#tempitems+1] = "Integrity 2.0"
							DrawPhoneItems("MP3_player", tempitems)
							while phonemenuactive do
								Wait(0)
								SetPlayerControl(GetPlayerId(), true)
								SetCamBehindPed(GetPlayerChar(-1))
								SetGameCameraControlsActive(false)
							end
							if(phonemenuresult > 0) then
								if(phonemenuresult == 1) then
									RetuneRadioToStationIndex(255)
									SetMobilePhoneRadioState(0)
									SetMobileRadioEnabledDuringGameplay(0)
								else
									SetMobilePhoneRadioState(1)
									SetMobileRadioEnabledDuringGameplay(1)
									RetuneRadioToStationIndex(phonemenuresult-2)
								end
								goto radio
							else
								goto main
							end
						elseif(tempitems[phonemenuresult] == "Settings") then
							::settings::
							local tempitems = {}
							tempitems[#tempitems+1] = "Background"
							tempitems[#tempitems+1] = "Ringtone"
							DrawPhoneItems("Settings", tempitems)
							while phonemenuactive do
								Wait(0)
								SetPlayerControl(GetPlayerId(), true)
								SetCamBehindPed(GetPlayerChar(-1))
								SetGameCameraControlsActive(false)
							end
							if(phonemenuresult > 0) then
								if(tempitems[phonemenuresult] == "Background") then
									if(backid < 8) then
										backid = backid + 1
									else
										backid = 1
									end
									TriggerServerEvent('saveBack', backid)
									goto settings
								elseif(tempitems[phonemenuresult] == "Ringtone") then
									::ringtone::
									local tempring = {
									{"Standard", 0},
									{"Ringing 1", 1},
									{"Ringing 2", 2},
									{"Countryside", 3},
									{"Fox", 4},
									{"High Seas", 5},
									{"Malfunction", 6},
									{"Pager", 7},
									{"Spy", 8},
									{"Teeker", 9},
									{"Text", 10},
									{"Cool Room", 11},
									{"Katja's Waltz", 12},
									{"Laidback", 13},
									{"Solo", 14},
									{"Swing It", 15},
									{"109", 16},
									{"Bassmatic", 17},
									{"Credit Check", 18},
									{"Drive", 19},
									{"Funk In Time", 20},
									{"Get Down", 21},
									{"Into Something", 22},
									{"Mine Until Monday", 23},
									{"Take The Pain", 24},
									{"The One For Me", 25},
									{"Tonight", 26},
									{"Beheading", 27},
									{"Champagne", 28},
									{"Diamonds", 29},
									{"Flat Line", 30},
									{"Hooker", 31},
									{"Jet", 32},
									{"Lesbians", 33},
									{"Money Counter", 34},
									{"Old Bitch", 35},
									{"St. Thomas", 37},
									{"Dragon Brain", 60},
									{"Science of Crime", 61}
									}
									local tempitems = {}
									for i=1,#tempring,1 do
										if(tempring[i][2] == ringid) then
											tempitems[i] = "~y~" .. tempring[i][1]
										else
											tempitems[i] = tempring[i][1]
										end
									end
									local prevring = 0
									DrawPhoneItems("Ringtone", tempitems)
									while phonemenuactive do
										Wait(0)
										SetPlayerControl(GetPlayerId(), true)
										SetCamBehindPed(GetPlayerChar(-1))
										SetGameCameraControlsActive(false)
										if(currbutton ~= prevring) then
											prevring = currbutton
											if(currbutton > 0) then
												PreviewRingtone(tempring[currbutton][2])
											else
												StopPreviewRingtone()
											end
										end
									end
									if(phonemenuresult > 0) then
										ringid = tempring[phonemenuresult][2]
										TriggerServerEvent('saveRing', ringid)
										goto ringtone
									else
										StopPreviewRingtone()
										goto settings
									end
								end
							else
								goto main
							end
						elseif(tempitems[phonemenuresult] == "Change background") then
							if(backid < 8) then
								backid = backid + 1
							else
								backid = 1
							end
							TriggerServerEvent('saveBack', backid)
							goto main
						end
					end
				end
			end
		end
	end
end)