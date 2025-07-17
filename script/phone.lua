phonemenu = 0
backid = 1
coverid = 1
usingphone = 0

RegisterNetEvent("updback")
AddEventHandler("updback", function(pback)
	backid = tonumber(pback)
end)

RegisterNetEvent("updcover")
AddEventHandler("updcover", function(pcover)
	coverid = tonumber(pcover)
end)

function GetVoiceKey()
	return VoiceChatKey
end
function GetCrossHairKey()
	return CrossHairKey
end
function GetChatBoxKey()
	return ChatBoxKey
end
function GetVmenuKey()
	return VehicleMenu
end

local menuitem = {
	"Settings",
	"Contacts(Soon..)",
	"Twitter",
	"Google pay",
	"Whatsapp",
	"Vale",
	"Spotify"
}
Citizen.CreateThread(function() --apps 
	while true do
        Citizen.Wait(0)

		if(IsGameKeyboardKeyJustPressed(Phone1Key)) then
			if(cuff == false) then
				if(not IsCharDead(GetPlayerChar(-1))) then
					if(inventory[35] == 1)then
						if(phonemenu == 0) then
							if(cursor == 0) then
								if(IsPlayerControlOn(GetPlayerId())) then
									phonemenu = 1
									cursor = 1
									SetCamActive(GetGameCam(), false)
									SetPlayerControl(GetPlayerId(), false)
									usingphone = 1
								end
							end
						else 
							phonemenu = 0
							cursor = 0
							SetCamActive(GetGameCam(), true)
							SetPlayerControl(GetPlayerId(), true)
							usingphone = 0
						end
					else
						Notify("You dont have a phone. You can buy it from an electronic shop")
					end
				end
			end
		end
		if(phonemenu == 1) then
			DisplaySprite("phonenew", coverid, 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			DisplaySprite("phonenew", "w" .. backid , 0.86, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			DisplaySprite("phonenew", "notch", 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)

			for i=1,#menuitem,1 do
				local ix = 0
				local iy = 0
				if(i==1 or i==2 or i==3 or i==4) then
					ix = 0.828-0.03+0.04*(i-1)
					iy = 0.5-0.1
				elseif(i==5 or i==6 or i==7 or i==8) then
					ix = 0.828-0.03+0.04*(i-5)
					iy = 0.5-0.1+0.09
				end
				DisplaySprite("phonenew", "icon" .. i, ix, iy, 0.0315, 0.057, 0.0, 255, 255, 255, 255)
				if(IsCursorInArea(ix, iy, 0.0315, 0.057)) then
					SetTextScale(0.1500000,  0.3000000)
					if(IsMouseButtonJustPressed(1)) then
						if(menuitem[i] == "Settings") then
							Settings = 1
							cursor = 1
						elseif(menuitem[i] == "Contacts(Soon..)") then
							--[[phonemenu = 0
							cursor = 1
							contact = 1
							uiactive = false
							cshow = 1]]
						elseif(menuitem[i] == "Twitter") then
							TriggerEvent('OpenTwitter')
							cursor = 0
							phonemenu = 0
						elseif(menuitem[i] == "Spotify") then
							spotify = 1
							cursor = 1
							phonemenu = 0
						elseif(menuitem[i] == "Google pay") then
							gpay = 1
							phonemenu = 0
							cursor = 1
						elseif(menuitem[i] == "Vale") then
							phonemenu = 0
							cursor = 1
							show = 1
							vale = 1
						elseif(menuitem[i] == "Whatsapp") then
							phonemenu = 0
							cursor = 1
							whatsapp = 1
							wshow = 1
							uiactive = false
						end
					end
				end
			end
		end
	end
end)


RegisterNetEvent('CloseTwitter')
AddEventHandler('CloseTwitter', function()
    phonemenu = 1
	cursor = 1
end)


------------------------------------------------------------------------------------------


local settingsmenu = {
"Walpapper",
"Cover",
"Voicechat",
"Cinematic",
"Fps",
}

local walpappermenu = {
"Previous",
"Next",
}

local covermenu = {
"Previous",
"Next",
}
Citizen.CreateThread(function() 
	while true do
        Citizen.Wait(0)
		if(Settings == 1) then
			 
			phonemenu = 0
			DisplaySprite("phonenew", coverid, 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			DisplaySprite("phonenew", "sbackground" , 0.86, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			DisplaySprite("phonenew", "notch", 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			
			for i=1,#settingsmenu,1 do
				local ix = 0
				local iy = 0
				if(i==1) then
					ix = 0.86-0.03*(i-1)
					iy = 0.42
				elseif(i==2) then
					ix = 0.86-0.03*(i-2)
					iy = 0.42+0.050
				elseif(i==3) then
					ix = 0.86-0.03*(i-3)
					iy = 0.42+0.050+0.050
				elseif(i==4) then
					ix = 0.86-0.03*(i-4)
					iy = 0.42+0.050+0.050+0.050
				elseif(i==5) then
					ix = 0.86-0.03*(i-5)
					iy = 0.42+0.050+0.050+0.050+0.050
				end
				DisplaySprite("phonenew", "settingsbutton" .. i, ix, iy, 0.18, 0.045, 0.0, 255, 255, 255, 255)

				if(IsCursorInArea(ix, iy, 0.18, 0.045)) then
					if(IsMouseButtonJustPressed(1)) then
						if(settingsmenu[i] == "Walpapper") then
							walpapperchanger = 1
							Settings = 0
						elseif(settingsmenu[i] == "Cover") then
							coverchanger = 1
							Settings = 0
						elseif(settingsmenu[i] == "Voicechat") then
							Citizen.Wait(1)

							SetPlayerControl(GetPlayerId(), false)
						elseif(settingsmenu[i] == "Cinematic") then
							if (CinematicMode == false) then
								CinematicMode = true
								DisplayRadar(false)
							else
								CinematicMode = false
								DisplayRadar(true)
							end
						elseif(settingsmenu[i] == "Fps") then
							if(fpson == false) then
								fpson = true
							else
								fpson = false
							end
						end
					end
				end

			end
		end
		if(CinematicMode == true) then
			DisplayRadar(false)
			DrawRect(0.5, 0.0, 1.0, 0.20, 0, 0, 0, 255)
			DrawRect(0.5, 1.0, 1.0, 0.20, 0, 0, 0, 255)
		end
		if(fpson == true) then
			SetTextScale(0.150000,  0.3000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			SetTextCentre(1)
			DisplayTextWithLiteralString(0.02, 0.003, "STRING", "FPS: " .. fps)
			DrawRect(0.01, 0.00, 0.059, 0.05, 0, 0, 0, 200)
		end
	end
end)


Citizen.CreateThread(function() 
	while true do
        Citizen.Wait(0)
		if(coverchanger == 1) then
			phonemenu = 0

			DisplaySprite("phonenew", coverid, 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			DisplaySprite("phonenew","w" .. backid , 0.86, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			DisplaySprite("phonenew", "notch", 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)

			for i=1,#covermenu,1 do
				local ix = 0
				local iy = 0
				if(i==1 or i==2 or i==3 or i==4) then
					ix = 0.86-0.03+0.05*(i-1)
					iy = 0.8
				end
				DisplaySprite("phonenew", "baicon" .. i, ix, iy, 0.028+0.015, 0.056+0.017, 0.0, 255, 255, 255, 255)
				if(IsCursorInArea(ix, iy, 0.028+0.015, 0.056+0.017)) then
					SetTextScale(0.1500000,  0.3000000)
					SetTextDropshadow(0, 0, 0, 0, 0)
					SetTextFont(6)
					SetTextEdge(1, 0, 0, 0, 255)
					SetTextCentre(1)
					SetTextWrap(0.0, 0.9)
					DisplayTextWithLiteralString(0.9, 0.8+0.14-0.03, "STRING", "" .. covermenu[i])
					if(IsMouseButtonJustPressed(1)) then
						if(covermenu[i] == "Previous") then
							coverchanger = 1
							if(coverid < 14 and coverid > 1) then
								coverid = coverid - 1
							else
								coverid = 14
							end
							TriggerServerEvent('savecover', coverid)
						elseif(covermenu[i] == "Next") then
							coverchanger = 1
							if(coverid < 14 and coverid > 1) then
								coverid = coverid + 1
							else
								coverid = 1
							end
							TriggerServerEvent('savecover', coverid)
						end
					end
				end 
			end
		end
	end
end)


Citizen.CreateThread(function() 
	while true do
        Citizen.Wait(0)
		if(walpapperchanger == 1) then
			phonemenu = 0
			DisplaySprite("phonenew", coverid, 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			DisplaySprite("phonenew","w" .. backid , 0.86, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			DisplaySprite("phonenew", "notch", 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			for i=1,#walpappermenu,1 do
				local ix = 0
				local iy = 0
				if(i==1 or i==2 or i==3 or i==4) then
					ix = 0.86-0.03+0.05*(i-1)
					iy = 0.8
				end
				DisplaySprite("phonenew", "baicon" .. i, ix, iy, 0.028+0.015, 0.056+0.017, 0.0, 255, 255, 255, 255)
				if(IsCursorInArea(ix, iy, 0.028+0.015, 0.056+0.017)) then
					SetTextScale(0.1500000,  0.3000000)
					SetTextDropshadow(0, 0, 0, 0, 0)
					SetTextFont(6)
					SetTextEdge(1, 0, 0, 0, 255)
					SetTextCentre(1)
					SetTextWrap(0.0, 0.9)
					DisplayTextWithLiteralString(0.9, 0.8+0.14-0.03, "STRING", "" .. walpappermenu[i])
					if(IsMouseButtonJustPressed(1)) then
						if(walpappermenu[i] == "Previous") then
							walpapperchanger = 1
							if(backid < 13 and backid > 1) then
								backid = backid - 1
							else
								backid = 13
							end
							TriggerServerEvent('saveback', backid)
						elseif(walpappermenu[i] == "Next") then
							walpapperchanger = 1
							if(backid < 13 and backid > 1) then
								backid = backid + 1
							else
								backid = 1
							end
							TriggerServerEvent('saveback', backid)
						end
					end
				end
			end
		end
	end
end)

local tmenu = {
	"Tweet",
}

Citizen.CreateThread(function() --contacts
	while true do
        Citizen.Wait(0)
		if(twitter == 1) then
			phonemenu = 0
			DisplaySprite("phonenew", coverid, 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			DisplaySprite("phonenew","tbackground" , 0.86, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			DisplaySprite("phonenew", "notch", 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)

			for i=1,#tmenu,1 do
				local ix = 0
				local iy = 0
				if(i==1) then
					ix = 0.92
					iy = 0.86
				end
				DisplaySprite("phonenew", "ticon", ix, iy, 0.028+0.015, 0.056+0.017, 0.0, 255, 255, 255, 255)
				if(IsCursorInArea(ix, iy, 0.028+0.015, 0.056+0.017)) then
					SetTextScale(0.1500000,  0.3000000)
					SetTextDropshadow(0, 0, 0, 0, 0)
					SetTextFont(6)
					SetTextEdge(1, 0, 0, 0, 255)
					SetTextCentre(1)
					SetTextWrap(0.0, 0.9)
					DisplayTextWithLiteralString(0.9, 0.8+0.14-0.03, "STRING", "" .. tmenu[i])
					if(IsMouseButtonJustPressed(1)) then
						if(tmenu[i] == "Tweet") then
							cursor = 0
							TwitterInput()
						end
					end
				end
			end
		end
	end
end)


RegisterNetEvent('onDialogResponse')
AddEventHandler('onDialogResponse', function(dialogID, dialogResponse, dialogListitem, dialogInputtext)
	if(dialogID == "DIALOG_TWITTER") then
		if(dialogResponse == 0) then
			SetUIFocus(false)
			SetPlayerControl(GetPlayerId(),false)
		 elseif(dialogResponse == 1) then
			 Citizen.CreateThread(function()
				 cursor = 1
				 h,m = GetTimeOfDay()
				 TriggerServerEvent('SendMessage', GetPlayerName(GetPlayerId(), _s), dialogInputtext, h..":"..m, 1)
			 end)
		end
	end
end)

function TwitterInput()
	TriggerEvent('showDialog', "DIALOG_TWITTER", "DIALOG_STYLE_INPUT", "TWITTER", "enter your message", "Tweet", "Exit","", true)
end

local cur = 60
local spmenu = {
	"Play song",
}
Citizen.CreateThread(function() --contacts
	while true do
        Citizen.Wait(0)
		if(spotify == 1) then
			phonemenu = 0

			for i=1,#spmenu,1 do

				DisplaySprite("phonenew", coverid, 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
				DisplaySprite("phonenew","spbackground" , 0.86, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
				DisplaySprite("phonenew", "notch", 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)

				if(IsGameKeyboardKeyJustPressed(18)) then
					if(spmenu[i] == "Play song") then
						cursor = 0
						SpotifyInput()
					end
				end
				if(IsCursorInArea(0.86, 0.92, 0.03, 0.04)) then-- stop
					if(IsMouseButtonJustPressed(1)) then
						TriggerEvent('stop_music')
					end
				end
				if(IsCursorInArea(0.81, 0.92, 0.03, 0.04)) then-- +
					if(IsMouseButtonPressed(1)) then
						if(cur < 100) then
							cur = cur + 1
							TriggerEvent('setVolume', cur)
						end
					end
				end
				if(IsCursorInArea(0.91, 0.92, 0.03, 0.04)) then-- -
					if(IsMouseButtonPressed(1)) then
						if(cur > 0 ) then
							cur = cur - 1
							TriggerEvent('setVolume', cur)
						end
					end
				end
			end
		end
	end
end)


RegisterNetEvent('onDialogResponse')
AddEventHandler('onDialogResponse', function(dialogID, dialogResponse, dialogListitem, dialogInputtext)
	   if(dialogID == "DIALOG_SPOTIFY") then
		if(dialogResponse == 0) then
			SetUIFocus(false)
			SetPlayerControl(GetPlayerId(),false)
			cursor = 1
		 elseif(dialogResponse == 1) then
			 Citizen.CreateThread(function()
				 cursor = 1
				 TriggerEvent('play_music', dialogInputtext)
			 end)
		end
	end
end)

function SpotifyInput()
	TriggerEvent('showDialog', "DIALOG_SPOTIFY", "DIALOG_STYLE_INPUT", "Spotify Lite", "Enter music id", "Play", "Exit","", true)
end

--------------------------googlepay -----------------------------

local idinput = ""
local amountinput = ""
local bankmoney = 1000
local canid = 0
local canamount =0

local gpaymenu = {
"Money Transfer",
}

Citizen.CreateThread(function() 
	while true do
        Citizen.Wait(0)
		if(gpay == 1) then
			phonemenu = 0

			DisplaySprite("phonenew", coverid, 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			DisplaySprite("phonenew","gbackground" , 0.86, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			DisplaySprite("phonenew", "notch", 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			
			for i=1,#gpaymenu,1 do
				SetTextScale(0.350000,  0.5500000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextFont(6)
				SetTextEdge(0 , 0, 0, 0, 255)
				SetTextCentre(1)
				SetTextWrap(0.0, 0.9)
				SetTextColour(0,0,0,200)
				DisplayTextWithLiteralString(0.86, 0.5, "STRING", "Bank_Balance "..bankmoney)
				local ix=0
				local iy=0

				if(IsCursorInArea(0.86, 0.63, 0.04, 0.03)) then
					if(IsMouseButtonJustPressed(1)) then
						canid = 1
						canamount = 0
					end
					DrawRect(0.86, 0.63, 0.04, 0.03, 0, 0, 0, 200)
				end
				if(IsCursorInArea(0.86, 0.74, 0.16, 0.03)) then
					if(IsMouseButtonJustPressed(1)) then
						canid = 0
						canamount = 1
					end
					DrawRect(0.86, 0.74, 0.16, 0.03, 0, 0, 0, 200)
				end

				if(IsGameKeyboardKeyJustPressed(28)) then
					if(idinput ~= "") then
						if(amountinput ~= "") then
							if(IsNetworkPlayerActive(tonumber(idinput))) then
								TriggerEvent("noticeme:Info", "You have sent " .. amountinput ..".rs to " ..GetPlayerName(idinput))
								TriggerServerEvent('sendMoney', tonumber(idinput), GetPlayerServerId(), tonumber(amountinput))
								inventory[34] = inventory[34] - tonumber(amountinput)
								SaveInventory()
							else
								TriggerEvent("noticeme:Info", "Player not online")
							end
						else
							TriggerEvent("noticeme:Info", "Enter the amount")
						end
					else
						TriggerEvent("noticeme:Info", "Enter the ID")
					end
				end
			end

			DrawRect(0.86, 0.63, 0.04, 0.03, 0, 0, 0, 100)
			SetTextScale(0.300000,  0.4000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			SetTextFont(6)
			SetTextEdge(0 , 0, 0, 0, 255)
			SetTextCentre(1)
			SetTextColour(0,0,0,200)
			DisplayTextWithLiteralString(0.86, 0.58, "STRING", "Type ID of the player")

			if(idinput ~= "") then
				SetTextScale(0.200000,  0.3000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextFont(6)
				SetTextCentre(1)
				DisplayTextWithLiteralString(0.86, 0.62, "STRING", "" .. idinput)
			else
				SetTextScale(0.200000,  0.3000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextFont(6)
				SetTextCentre(1)
				DisplayTextWithLiteralString(0.86, 0.62, "STRING", "0")
			end
			
			for i=1,10,1 do --numbers
				if(canid == 1) then
					DrawRect(0.86, 0.63, 0.04, 0.03, 0, 0, 0, 200)
					if(IsGameKeyboardKeyJustPressed(i+1)) then
						if(i ~= 10) then
							idinput = "" .. idinput .. "" .. i
						else
							idinput = "" .. idinput .. "0"
						end
					end
				end
			end

			if(IsGameKeyboardKeyJustPressed(14)) then --backspace
				idinput = idinput:sub(1, #idinput - 1)
			end
			
			DrawRect(0.86, 0.74, 0.16, 0.03, 0, 0, 0, 100) -- amount
			SetTextScale(0.300000,  0.4000000)
			SetTextDropshadow(0, 0, 0, 0, 0)
			SetTextFont(6)
			SetTextEdge(0 , 0, 0, 0, 255)
			SetTextCentre(1)
			SetTextColour(0,0,0,200)
			DisplayTextWithLiteralString(0.86, 0.69, "STRING", "Type Amount to send")

			if(amountinput ~= "") then
				SetTextScale(0.200000,  0.3000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextFont(6)
				SetTextCentre(1)
				DisplayTextWithLiteralString(0.86, 0.73, "STRING", "" .. amountinput)
			else
				SetTextScale(0.200000,  0.3000000)
				SetTextDropshadow(0, 0, 0, 0, 0)
				SetTextFont(6)
				SetTextCentre(1)
				DisplayTextWithLiteralString(0.86, 0.73, "STRING", "0")
			end
			
			if(canamount == 1) then
				DrawRect(0.86, 0.74, 0.16, 0.03, 0, 0, 0, 200)
				for i=1,10,1 do --numbers
					if(IsGameKeyboardKeyJustPressed(i+1)) then
						if(i ~= 10) then
							amountinput = "" .. amountinput .. "" .. i
						else
							amountinput = "" .. amountinput .. "0"
						end
					end
				end
				if(IsGameKeyboardKeyJustPressed(14)) then --backspace
					amountinput = amountinput:sub(1, #amountinput - 1)
				end
			end

		end
	end
end)


-------------whatsapp----------------------

local wmenu = {
"Send Message",
}

Citizen.CreateThread(function() 
	while true do
        Citizen.Wait(0)
		if(whatsapp == 1) then
			phonemenu = 0
			
			DisplaySprite("phonenew", coverid, 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			DisplaySprite("phonenew","wbackground" , 0.86, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
			DisplaySprite("phonenew", "notch", 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)

			for i=1,#wmenu,1 do
				if(wshow == 1) then
					local moneystring = ""
					local tempitems = {}
					for i=0,31,1 do
						if(IsNetworkPlayerActive(i)) then
							if(GetPlayerChar(-1) ~= GetPlayerChar(i)) then
								tempitems[#tempitems+1] = GetPlayerName(i, _s)
							end
						end
					end
					DrawUI(whatsapp, tempitems)
					while uiactive do
						Citizen.Wait(0)
					end
					if(uiresult > 0) then
						WhatsappInput()
						cursor = 0
						tempid = GetPlayerServerIdFromName(tempitems[uiresult])
					end
				    wshow = 0
				end
			end
			
		end
	end
end)


RegisterNetEvent('onDialogResponse')
AddEventHandler('onDialogResponse', function(dialogID, dialogResponse, dialogListitem, dialogInputtext)
	   if(dialogID == "DIALOG_WA") then
		if(dialogResponse == 0) then
			SetUIFocus(false)
			SetPlayerControl(GetPlayerId(),false)
			cursor = 1
		 elseif(dialogResponse == 1) then
			 Citizen.CreateThread(function()
				 cursor = 1
				 TriggerServerEvent('sendMSG', tempid, GetPlayerServerId(), dialogInputtext)
				 TriggerEvent('sms', '[Sent]', GetPlayerName(GetPlayerId()), dialogInputtext)
			 end)
		end
	end
end)

function WhatsappInput()
	TriggerEvent('showDialog', "DIALOG_WA", "DIALOG_STYLE_INPUT", "WHATSAPP", "enter your message", "send", "Exit","", true)
end

local locationsender = ""
RegisterNetEvent('sendMSG')
AddEventHandler('sendMSG', function(receiver, sender, msg)
	if(GetPlayerChar(-1) == GetPlayerChar(receiver)) then
		if(msg == "loc") then
			local x,y,z = GetCharCoordinates(GetPlayerChar(sender))
			if(not DoesBlipExist(locblip)) then
				RemoveBlip(locblip)
			end
			location = {x,y,z}
			Notify(GetPlayerName(sender).. " has sent you their location, Waypont marked")
			locationsender = GetPlayerName(sender)
		else
			TriggerEvent('sms', '[RECIVED]', GetPlayerName(sender), msg)
		end
	end
end)

location = {}
CreateThread(function()
	while true do
		Wait(0)
		if(#location > 0) then
			if(not DoesBlipExist(locblip)) then
				locblip = AddBlipForCoord(location[1], location[2], location[3])
				ChangeBlipSprite(locblip, 1)
				ChangeBlipNameFromAscii(locblip, locationsender.." location")
				SetRoute(locblip, true)
			else
				if(IsPlayerNearCoords(location[1], location[2], location[3], 10)) then
					location = {}
				end
			end
		else
			RemoveBlip(locblip)
		end
	end
end)
--------------------------vale -----------------------------
local mechPed = nil
local valeactive = false
local selectedCarModel = nil  -- Added variable to store the selected car model
local spawnedCars = {} -- Added list to track spawned cars
local valemenu = {
    "Deliver Car"
}
local valeactive = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if (vale == 1) then
            phonemenu = 0
            DisplaySprite("phonenew", coverid, 0.861, 0.6, 0.20, 0.70, 0.0, 255, 255, 255, 255)
            DisplaySprite("phonenew", "vbackground", 0.86, 0.6, 0.20, 0.70, 0.0, 255, 255, 255, 255)
            DisplaySprite("phonenew", "notch", 0.861, 0.6, 0.20, 0.70, 0.0, 255, 255, 255, 255)
            for i = 1, #valemenu, 1 do
                if (show == 1) then
                    local tempitems = {}
                    for j = 1, #cars, 1 do
                        if (cars[j] == 1) then
                            tempitems[#tempitems + 1] = "" .. carinfo[j][1]
                        end
                    end
                    DrawUI(vale, tempitems)
                    while uiactive do
                        Citizen.Wait(0)
                    end
                    if (uiresult > 0) then
                        if (valeactive == false) then
                            local tempcarid = 0
                            for j = 1, #carinfo, 1 do
                                if (carinfo[j][1] == tempitems[uiresult]) then
                                    tempcarid = j
                                end
                            end

                            if selectedCarModel == nil or selectedCarModel ~= carinfo[tempcarid][3] then
                                -- Check if the car has already been spawned
                                local carAlreadySpawned = false
                                for k, spawnedCar in ipairs(spawnedCars) do
                                    if spawnedCar == carinfo[tempcarid][3] then
                                        carAlreadySpawned = true
                                        break
                                    end
                                end

                                if not carAlreadySpawned then
                                    vale = 0
                                    phonemenu = 0
                                    SetPlayerControl(GetPlayerId(), false)
                                    SetCamActive(GetGameCam(), true)
                                    usingphone = 0
                                    cursor = 0

                                    local vx, vy, vz, vh = GetRandomNodeInRadius(30)

                                    if (not DoesVehicleExist(carinfo[tempcarid][3])) then
                                        car = SpawnCar(carinfo[tempcarid][3], vx, vy, vz, 0.0)
                                        SetVehicleTuning(car)
                                        SetCarAsMissionCar(car)
                                        MarkCarAsNoLongerNeeded(car)
                                        SetCarCollision(car, true)

                                        local model = GetHashKey("m_m_hporter_01")
                                        RequestModel(model)
                                        while not HasModelLoaded(model) do
                                            Citizen.Wait(0)
                                        end
                                        mechPed = SpawnPed(GetHashKey("m_m_hporter_01"), vx, vy, vz + 10, 0.0)
                                        WarpCharIntoCar(mechPed, car)
                                        TaskCarMissionPedTarget(mechPed, car, GetPlayerChar(-1), 2, 10.0, 3, 4, 10)
                                        valeactive = true
                                        carblip = AddBlipForCar(car)
                                        ChangeBlipNameFromAscii(carblip, "Your " .. carinfo[tempcarid][1])

                                        -- Update the selected car model
                                        selectedCarModel = carinfo[tempcarid][3]

                                        -- Add the spawned car to the list
                                        table.insert(spawnedCars, selectedCarModel)
                                    end
                                else
                                    TriggerEvent("noticeme:Info", "This car has already been spawned")
                                end
                            else
                                TriggerEvent("noticeme:Info", "You can only use one service at one time")
                            end
                        else
                            TriggerEvent("noticeme:Info", "You can only use one service at one time")
                        end
                    end
                end
            end
        end
    end
end)


Citizen.CreateThread(function() 
	while true do
        Citizen.Wait(0)
		if(valeactive == true) then
			Citizen.Wait(60000)
			if(valeactive == true) then
				valeactive = false
			end
		end
	end
end)

Citizen.CreateThread(function() 
	while true do
        Citizen.Wait(0)

		if(not IsCharDead(mechPed)) then
			if(IsPedNearPlayer(mechPed, GetPlayerChar(-1), 8)) then
				TaskLeaveAnyCar(mechPed)
				
				Citizen.Wait(5000)
				valeactive = false
				
				DeleteChar(mechPed)
				if(DoesBlipExist(carblip)) then
					RemoveBlip(carblip)
				end
			end
		end

	end
end)

Citizen.CreateThread(function() --back 
	while true do
        Citizen.Wait(0)
		if(contact == 1) then
			if(IsMouseButtonJustPressed(2)) then
				contact = 0
				cursor = 1
				phonemenu = 1
				uiactive = false
			end
		end
		if(twitter == 1) then
			if(IsMouseButtonJustPressed(2)) then
				twitter = 0
				cursor = 1
				phonemenu = 1
			end
		end
		if(spotify == 1) then
			if(IsMouseButtonJustPressed(2)) then
				spotify = 0
				cursor = 1
				phonemenu = 1
			end
		end
		if(gpay == 1) then
			if(IsMouseButtonJustPressed(2)) then
				gpay = 0
				cursor = 1
				phonemenu = 1
			end
		end
		if(vale == 1) then
			if(IsMouseButtonJustPressed(2)) then
				vale = 0
				cursor = 1
				phonemenu = 1
				uiactive = false
			end
		end
		if(Settings == 1) then
			if(IsMouseButtonJustPressed(2)) then
				Settings = 0
				cursor = 1
				phonemenu = 1
			end
		end
		if(walpapperchanger == 1) then
			if(IsMouseButtonJustPressed(2)) then
				walpapperchanger = 0
				cursor = 1
				Settings = 1
				phonemenu = 0
			end
		end
		if(coverchanger == 1) then
			if(IsMouseButtonJustPressed(2)) then
				coverchanger = 0
				cursor = 1
				Settings = 1
				phonemenu = 0
			end
		end
		if(whatsapp == 1) then
			if(IsMouseButtonJustPressed(2)) then
				whatsapp = 0
				cursor = 1
				phonemenu = 1
				uiactive = false
			end
		end
		if(usingphone == 1) then
			SetPlayerControl(GetPlayerId(), false)
			SetCamActive(GetGameCam(), false)
		end
	end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

		if(not DoesBlipExist(Electronicsblip)) then
			Electronicsblip = AddBlipForCoord(971.54187, -172.46872, 24.19872)
			ChangeBlipSprite(Electronicsblip, 24)
			ChangeBlipNameFromAscii(Electronicsblip, "Electronics shop")
			SetBlipAsShortRange(Electronicsblip, true)
			ChangeBlipScale(Electronicsblip, 0.8)
		end

		DrawCheckpointWithAlpha(971.54187, -172.46872, 23.19872, 1.1, 191, 0, 255, 150)
		if(IsPlayerNearCoords(971.54187, -172.46872, 24.19872, 1.5)) then
			if(IsGameKeyboardKeyJustPressed(18)) then
				DrawWindow("Menu", {"Iphone 15 pro max (10000$)", "Nokia lumia (500$)"})
				while menuactive do
					Citizen.Wait(0)
				end
				if(menuresult > 0) then
					if(menuresult == 1) then
						if(inventory[34] >=10000) then
							inventory[34] = inventory[34] - 10000
							SaveInventory()
							AddItem(35, 1)
							AddExp(3)
							SaveStats()
							TriggerEvent("noticeme:Info", "You have purchased iphone")
							TriggerEvent("noticeme:Info", "Press [F1] to access mobile phone")
						else
							TriggerEvent("noticeme:Info", "You dont have enough money")
						end
					elseif(menuresult == 2) then
						if(inventory[34] >= 500) then
							inventory[34] = inventory[34] - 500
							SaveInventory()
							AddItem(41, 1)
							AddExp(1)
							SaveStats()
							TriggerEvent("noticeme:Info", "You have purchased Nokia")
							TriggerEvent("noticeme:Info", "Press [F3] to access mobile phone")
						else
							TriggerEvent("noticeme:Info", "You dont have enough money")
						end
					end
				end
			end
		end
	end
end)


function driveToWaypoint()
    local blipsa = GetFirstBlipInfoId(8)

    if (DoesBlipExist(blipsa)) then
        local waypoint = GetBlipCoords(blipsa)

        --Load map/collision ? : 
        RequestCollisionAtPosn(waypoint.x, waypoint.y, 0.0)
        LoadAllObjectsNow()

        for height = 1, 1000 do
            local pGroundZ, integer = GetGroundZFor3dCoord(waypoint.x, waypoint.y, height + 0.0)

            if pGroundZ > 0.0 then 
                SetCharCoordinates(config.localPlayer, waypoint.x, waypoint.y, pGroundZ)
				local model = GetHashKey("m_m_busdriver")
				RequestModel(model)
				while not HasModelLoaded(model) do
					Citizen.Wait(0)
				end
				RequestCollisionAtPosn(waypoint.x, waypoint.y, pGroundZ)
				tempped = CreateChar(1, model, waypoint.x, waypoint.y, pGroundZ, true)
				SetCharVisible(tempped, false)
				TaskCarMissionPedTarget(taxiped, taxicar, tempped, 2, 10.0, 3, 4, 10)
                break
            end
        end
    else
        Citizen.Trace("Waypoint not found!\n")
		PrintStringWithLiteralStringNow("STRING", "~r~Mark a destination", 10000, 1)
    end
end

DrawRectLeftTopCenter = function(x, y, width, height, r, g, b, a)
	DrawRect(x+width/2, y+height/2, width, height, r, g, b, a)
end
DrawCurvedWindowLeftTopCenter = function(x, y, width, height, a)
	DrawCurvedWindow(x+width/2, y+height/2, width, height, a)
end

uiactive = false
uiresult = 0
--local items = {}
DrawUI = function(curmenu, items)
	uiactive = true
	uiresult = 0
	currlist = 1
	cursor = 1
	SetCamActive(GetGameCam(), false)
	SetPlayerControl(GetPlayerId(), false)
	Citizen.CreateThread(function()
		while uiactive do
			Citizen.Wait(0)
			local y = 0
			local tempcancel = 0
			if(curmenu == vale) then
				DisplaySprite("phonenew", coverid, 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
				DisplaySprite("phonenew","vbackground" , 0.86, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
				DisplaySprite("phonenew", "notch", 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
				y = 0.4
			end
			if(curmenu == whatsapp) then
				DisplaySprite("phonenew", coverid, 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
				DisplaySprite("phonenew","wbackground" , 0.86, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
				DisplaySprite("phonenew", "notch", 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
				y = 0.447
			end
			if(curmenu == contacts) then
				DisplaySprite("phonenew", coverid, 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
				DisplaySprite("phonenew","cbackground" , 0.86, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
				DisplaySprite("phonenew", "notch", 0.861, 0.6,  0.20, 0.70, 0.0, 255, 255, 255, 255)
				y = 0.447
			end
			if(#items > 16) then
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
				
				local sep = 10
				for i=1,#templist,1 do
					if(currlist == i) then
						for j=1,#templist[i],1 do
							SetTextScale(0.1500000,  0.3000000)
							SetTextDropshadow(0, 0, 0, 0, 0)
							SetTextColour(0, 0, 0, 255)
							DisplayTextWithLiteralString(0.783, y+0.36/sep*(j-1)+0.01, "STRING", "" .. templist[i][j]) --items text
							if(IsCursorInAreaLeftTopCenter(0.78, y+0.36/sep*(j-1), 0.158, 0.36/sep)) then
								DrawRectLeftTopCenter(0.78, y+0.36/sep*(j-1), 0.163, 0.36/sep, 0, 0, 0, 100) -- items il touch chyyumbo ulla colour
								if(IsMouseButtonJustPressed(1)) then
									if(10*(i-1)+j ~= #items) then
										uiresult = 10*(i-1)+j
									end
									uiactive = false
									cursor = 0
								end
							end
						end
					end
				end
				if(GetMouseWheel() ~= 0) then
					if(GetMouseWheel() ~= 127) then
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
					SetTextColour(0, 0, 0, 255)
					DisplayTextWithLiteralString(0.783, y+0.36/sep*(i-1)+0.01, "STRING", "" .. items[i])
					if(IsCursorInAreaLeftTopCenter(0.78, y+0.36/sep*(i-1), 0.158, 0.36/sep)) then
						DrawRectLeftTopCenter(0.769, y+0.36/sep*(i-1), 0.182, 0.36/sep, 0, 0, 0, 100)
						if(IsMouseButtonJustPressed(1)) then
							uiresult = i
							uiactive = false
							cursor = 0
							
						end
					end
				end
			end
		end
		Citizen.Wait(100)
		SetCamActive(GetGameCam(), true)
		SetPlayerControl(GetPlayerId(), true)
	end)
end

function IsPedNearPlayer(ped, pp, radius)
    local pos1 = table.pack(GetCharCoordinates(ped, _f, _f, _f))
	local pos2 = table.pack(GetCharCoordinates(pp, _f, _f, _f))
    local dist = GetDistanceBetweenCoords3d(pos2[1], pos2[2], pos2[3], pos1[1], pos1[2], pos1[3], _f);
    if(dist < radius) then return true
    else return false
    end
end