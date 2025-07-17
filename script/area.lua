local areainfo = {
--{left bottom point, right top point}
{{499.26578, 1363.65991, 11.87993, 280.887786865234, 0}, {827.98828, 1503.45374, 14.25103, 78.4836273193359, 0}, 400.1, 200.1},
{{496.30908, 1552.62891, 14.02524, 356.040252685547, 0}, {825.38983, 1776.53662, 17.68229, 296.040252685547, 0}, 350.1, 200.1},
{{504.01801, 1806.88159, 28.06696, 181.225845336914, 0}, {785.94287, 1967.33728, 23.45796, 311.225769042969, 0}, 330.1, 200.1},
{{342.65906, 1614.30542, 16.391, 334.497406005859, 0}, {459.77917, 1982.06873, 23.43429, 99.3604125976563, 0}, 150.1, 400.1},
{{877.98138, 1587.70776, 17.05902, 188.47053527832, 0}, {1094.38904, 1943.19067, 13.71497, 258.332733154297, 0}, 250.1, 400.1},
{{1133.00903, 1799.02234, 10.90854, 66.2218017578125, 0}, {1377.00208, 1935.78491, 4.96879, 47.151237487793, 0}, 270.1, 200.1},
{{1292.84375, 1572.14563, 15.25706, 297.225463867188, 0}, {1519.19067, 1750.57312, 14.26886, 4.92110013961792, 0}, 200.1, 200.1}
}
local newareainfo = {}
for i=1,#areainfo,1 do
	local width = areainfo[i][2][1] - areainfo[i][1][1]
	local height = areainfo[i][2][2] - areainfo[i][1][2]
	local x = areainfo[i][1][1] + width/2
	local y = areainfo[i][1][2] + height/2
	newareainfo[i] = {x, y, areainfo[i][3], areainfo[i][4]}
end
areainfo = newareainfo
areaowners = {}
for i=1,#areainfo,1 do
	areaowners[i] = "0"
end

local capturetimer = 0
local capturer = ""
local protector = ""
local areaattacked = 0
local capturerkills = 0
local protectorkills = 0
TriggerServerEvent('registerCommand', "capture")
RegisterNetEvent('performCommand')
AddEventHandler('performCommand', function(command, args)
	if(command == "capture") then
		if(CheckFaction("Spanish Lords") or CheckFaction("Yardies") or CheckFaction("Hustlers")) then
			if(leader == 1) then
				if(capturetimer <= 0) then
					for i=1,#areainfo,1 do
						--[[local width = areainfo[i][2][1] - areainfo[i][1][1]
						local height = areainfo[i][2][2] - areainfo[i][1][2]
						local x = areainfo[i][1][1] + width/2
						local y = areainfo[i][1][2] + height/2
						local z = areainfo[i][1][3] - 50
						if(LocateCharAnyMeans3d(GetPlayerChar(-1), x, y, z, width, height, 100.1, false)) then]]
						if(LocateCharAnyMeans3d(GetPlayerChar(-1), areainfo[i][1], areainfo[i][2], 0.0, areainfo[i][3]/2, areainfo[i][4]/2, 100.1, false)) then
							if(areaowners[i] ~= job) then
								if(areaowners[i] ~= "0") then
									local amount = 0
									for j=0,31,1 do
										if(IsNetworkPlayerActive(j)) then
											if(CheckFaction(areaowners[i], j)) then
												amount = amount + 1
											end
										end
									end
									--if(amount >= 2) then
										TriggerServerEvent('startCapture', job, areaowners[i], i)
										Notify("Territory capture has been started.")
									--else
									--	Notify("There must be at least 2 members of this gang on the server to start capturing.")
									--end
								else
									areaowners[i] = job
									SaveAreas()
									Notify("Area captured.")
								end
							else
								Notify("This is your territory.")
							end
						end
					end
				else
					Notify("Another territory is currently being captured.")
				end
			else
				Notify("Only gang leader can start capturing.")
			end
		else
			Notify("You must be a gang member to do that.")
		end
	end
end)

RegisterNetEvent('updAreas')
AddEventHandler('updAreas', function(data)
	for i=1,#areaowners,1 do
		if(data[i] ~= nil) then
			areaowners[i] = tostring(data[i])
		end
	end
end)
SaveAreas = function()
	local data = {}
	for i=1,#areaowners,1 do
		data[i] = areaowners[i]
	end
	TriggerServerEvent('saveAreas', data)
end

CreateThread(function()
	while true do
		Wait(0)
		if(job=="Spanish Lords" or job=="Yardies" or job=="Hustlers") then
			if(CheckFaction("Spanish Lords") or CheckFaction("Yardies") or CheckFaction("Hustlers")) then
				if(capturetimer > 0) then
					if(capturer==job or protector==job) then
						SetTextScale(0.300000,  0.6000000)
						SetTextDropshadow(0, 0, 0, 0, 0)
						--SetTextFont(6)
						SetTextEdge(1, 0, 0, 0, 255)
						SetTextColour(191, 0, 255, 255)
						--SetTextWrap(0.0, 0.3)
						--SetTextCentre(1)
						--SetTextRightJustify(1)
						--SetTextWrap(0.0, 0.89)
						DisplayTextWithLiteralString(0.85, 0.95, "STRING", "" .. capturer .. ": " .. capturerkills)
						SetTextScale(0.300000,  0.6000000)
						SetTextDropshadow(0, 0, 0, 0, 0)
						--SetTextFont(6)
						SetTextEdge(1, 0, 0, 0, 255)
						SetTextColour(0, 255, 0, 255)
						--SetTextWrap(0.0, 0.3)
						--SetTextCentre(1)
						--SetTextRightJustify(1)
						--SetTextWrap(0.0, 0.89)
						DisplayTextWithLiteralString(0.85, 0.9, "STRING", "" .. protector .. ": " .. protectorkills)
						SetTextScale(0.300000,  0.6000000)
						SetTextDropshadow(0, 0, 0, 0, 0)
						--SetTextFont(6)
						SetTextEdge(1, 0, 0, 0, 255)
						SetTextColour(255, 255, 0, 255)
						--SetTextWrap(0.0, 0.3)
						--SetTextCentre(1)
						--SetTextRightJustify(1)
						--SetTextWrap(0.0, 0.89)
						DisplayTextWithLiteralString(0.85, 0.85, "STRING", "Time left: " .. capturetimer)
					end
				end
			end
		end
	end
end)

RegisterNetEvent('startCapture')
AddEventHandler('startCapture', function(attacker, target, area)
	capturetimer = 600
	capturer = attacker
	protector = target
	areaattacked = area
	capturerkills = 0
	protectorkills = 0
	if(job=="Spanish Lords" or job=="Yardies" or job=="Hustlers") then
		Notify("Territory of " .. target .. " got attacked by " .. attacker .. "!")
	end
end)

RegisterNetEvent('finishCapture')
AddEventHandler('finishCapture', function(capturer, protector, win)
	capturetimer = 0
	areaattacked = 0
	capturerkills = 0
	protectorkills = 0
	if(job=="Spanish Lords" or job=="Yardies" or job=="Hustlers") then
		if(win == 1) then
			Notify("Territory of " .. protector .. " has been captured by " .. capturer .. ".")
		else
			Notify("" .. protector .. " have managed to protect their territory from " .. capturer .. ".")
		end
	end
	capturer = 0
	protector = 0
end)

RegisterNetEvent('updCaptureInfo')
AddEventHandler('updCaptureInfo', function(timer, attacker, target, area, attackerkills, targetkills)
	if(timer ~= -1) then
		capturetimer = timer
	end
	if(type(attacker) ~= "number") then
		capturer = attacker
	end
	if(type(target) ~= "number") then
		protector = target
	end
	if(area ~= -1) then
		areaattacked = area
	end
	if(attackerkills ~= -1) then
		capturerkills = attackerkills
	end
	if(targetkills ~= -1) then
		protectorkills = targetkills
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if(capturetimer > 0) then
			if(ConvertIntToPlayerindex(GetPlayerId()) == ConvertIntToPlayerindex(GetHostId())) then
				Wait(500)
				capturetimer = capturetimer - 1
				TriggerServerEvent('updCaptureInfo', capturetimer, capturer, protector, areaattacked, -1, -1)
				Wait(500)
				if(capturetimer <= 0) then
					if(capturerkills > protectorkills) then
						areaowners[areaattacked] = capturer
						SaveAreas()
						TriggerServerEvent('finishCapture', capturer, protector, 1)
					else
						TriggerServerEvent('finishCapture', capturer, protector, 0)
					end
				end
			end
		end
	end
end)

local killblocker = {}
for i=0,31,1 do
	killblocker[i] = 0
end
CreateThread(function()
	while true do
		Wait(0)
		if(capturetimer > 0) then
			if(CheckFaction("Spanish Lords") or CheckFaction("Yardies") or CheckFaction("Hustlers")) then
				for i=0,31,1 do
					if(IsNetworkPlayerActive(i)) then
						if(ConvertIntToPlayerindex(i) ~= ConvertIntToPlayerindex(GetPlayerId())) then
							if(CheckFaction("Spanish Lords", i) or CheckFaction("Yardies", i) or CheckFaction("Hustlers", i)) then
								if(IsCharDead(GetPlayerChar(i))) then
									if(killblocker[i] == 0) then
										if(HasCharBeenDamagedByChar(GetPlayerChar(i), GetPlayerChar(-1), false)) then
											if(CheckFaction(capturer)) then
												if(CheckFaction(protector, i)) then
													capturerkills = capturerkills + 1
													TriggerServerEvent('updCaptureInfo', -1, -1, -1, -1, capturerkills, -1)
													ClearCharLastDamageEntity(GetPlayerChar(i))
													killblocker[i] = 1
												end
											elseif(CheckFaction(protector)) then
												if(CheckFaction(capturer, i)) then
													protectorkills = protectorkills + 1
													TriggerServerEvent('updCaptureInfo', -1, -1, -1, -1, -1, protectorkills)
													ClearCharLastDamageEntity(GetPlayerChar(i))
													killblocker[i] = 1
												end
											end
										end
									end
								else
									killblocker[i] = 0
								end
							end
						end
					end
				end
			end
		end
	end
end)
--[[
local areablip = {}
for i=1,#areainfo,1 do
	areablip[i] = {}
end
CreateThread(function()
	while true do
		Wait(0)
		for i=1,#areainfo,1 do]]
			--if(not DoesBlipExist(areablip[i])) then
				--[[local width = areainfo[i][2][1] - areainfo[i][1][1]
				local height = areainfo[i][2][2] - areainfo[i][1][2]
				local x = areainfo[i][1][1]
				local y = areainfo[i][1][2] + height]]
				--[[local x = areainfo[i][1] - areainfo[i][3]/2
				local y = areainfo[i][2] + areainfo[i][4]/2
				areablip[i] = AddBlipForGangTerritory(x, y, areainfo[i][3], areainfo[i][4], 0)]]
			--[[for j=1,40,1 do
				if(not DoesBlipExist(areablip[i][j])) then
					if(j>=1 and j<=10) then
						areablip[i][j] = AddBlipForCoord((areainfo[i][1]-areainfo[i][3]/2)+areainfo[i][3]/10*(j-1), areainfo[i][2]+areainfo[i][4]/2, 0, _i)
					elseif(j>=11 and j<=20) then
						areablip[i][j] = AddBlipForCoord(areainfo[i][1]+areainfo[i][3]/2, (areainfo[i][2]+areainfo[i][4]/2)-areainfo[i][4]/10*(j-11), 0, _i)
					elseif(j>=21 and j<=30) then
						areablip[i][j] = AddBlipForCoord((areainfo[i][1]+areainfo[i][3]/2)-areainfo[i][3]/10*(j-21), areainfo[i][2]-areainfo[i][4]/2, 0, _i)
					elseif(j>=31 and j<=40) then
						areablip[i][j] = AddBlipForCoord(areainfo[i][1]-areainfo[i][3]/2, (areainfo[i][2]-areainfo[i][4]/2)+areainfo[i][4]/10*(j-31), 0, _i)
					end
					ChangeBlipSprite(areablip[i][j], 3)
					ChangeBlipScale(areablip[i][j], 0.2)
					SetBlipAsShortRange(areablip[i][j], true)
				end
				if(areaowners[i] == "Spanish Lords") then
					ChangeBlipColour(areablip[i][j], 19)
					ChangeBlipNameFromAscii(areablip[i][j], "Spanish Lords' territory")
				elseif(areaowners[i] == "Yardies") then
					ChangeBlipColour(areablip[i][j], 2)
					ChangeBlipNameFromAscii(areablip[i][j], "Yardies' territory")
				elseif(areaowners[i] == "Hustlers") then
					ChangeBlipColour(areablip[i][j], 1)
					ChangeBlipNameFromAscii(areablip[i][j], "Hustlers' territory")
				else
					ChangeBlipColour(areablip[i][j], 0)
					ChangeBlipNameFromAscii(areablip[i][j], "Gang territory")
				end
			end
			if(i == areaattacked) then
				Wait(1000)
				for j=1,40,1 do
					ChangeBlipColour(areablip[i][j], 0)
				end
				Wait(1000)
			end
		end
	end
end)]]