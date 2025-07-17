local objActive = 0
local objs = {
"cj_vault_door",
"bm_alarm3",
"gb_hosp_machine01",
"cj_gate_dock",
"csmagicbox",
"bm_shredder",
"bm_vend_fags"
}

local tempmodel = ""
CreateThread(function()
	while true do
		Wait(0)
		--DisplayTextWithLiteralString(0.5, 0.5, "STRING", "Room key: " .. GetKeyForCharInRoom(GetPlayerChar(-1), _i))
		if(objActive == 0) then
			if(IsGameKeyboardKeyJustPressed(50)) then --m
				if(GetPlayerName(GetPlayerId(), _s)=="vlados" or GetPlayerName(GetPlayerId())=="Vlad_Ivanenko") then
					DrawWindow("Select_object", objs)
					while menuactive do
						Wait(0)
					end
					if(menuresult > 0) then
						tempmodel = objs[menuresult]
						local model = GetHashKey(objs[menuresult])
						RequestModel(model)
						while not HasModelLoaded(model) do
							Wait(0)
						end
						local x,y,z = GetCharCoordinates(GetPlayerChar(-1), _f, _f, _f)
						obj = CreateObject(model, x, y, z-1, _i, 1)
						AddObjectToInteriorRoomByKey(obj, GetKeyForCharInRoom(GetPlayerChar(-1), _i))
						SetObjectHeading(obj, GetCharHeading(GetPlayerChar(-1), _f))
						FreezeObjectPosition(obj, true)
						SetObjectAlpha(obj, 100)
						SetObjectCollision(obj, false)
						objActive = 1
						SetPlayerControl(GetPlayerId(), false)
						--phoneblocker = 1
					end
				end
			end
		end
		if(objActive == 1) then
			SetPlayerControl(GetPlayerId(), false)
			if(IsGameKeyboardKeyPressed(200)) then --up
				local ox,oy,oz = GetObjectCoordinates(obj, _f, _f, _f)
				SetObjectCoordinates(obj, ox+0.05*math.cos((GetCharHeading(GetPlayerChar(-1), _f)+90)*math.pi/180), oy+0.05*math.sin((GetCharHeading(GetPlayerChar(-1), _f)+90)*math.pi/180), oz)
			end
			if(IsGameKeyboardKeyPressed(208)) then --down
				local ox,oy,oz = GetObjectCoordinates(obj, _f, _f, _f)
				SetObjectCoordinates(obj, ox-0.05*math.cos((GetCharHeading(GetPlayerChar(-1), _f)+90)*math.pi/180), oy-0.05*math.sin((GetCharHeading(GetPlayerChar(-1), _f)+90)*math.pi/180), oz)
			end
			if(IsGameKeyboardKeyPressed(205)) then --right
				local ox,oy,oz = GetObjectCoordinates(obj, _f, _f, _f)
				SetObjectCoordinates(obj, ox+0.05*math.cos(GetCharHeading(GetPlayerChar(-1), _f)*math.pi/180), oy+0.05*math.sin(GetCharHeading(GetPlayerChar(-1), _f)*math.pi/180), oz)
			end
			if(IsGameKeyboardKeyPressed(203)) then --left
				local ox,oy,oz = GetObjectCoordinates(obj, _f, _f, _f)
				SetObjectCoordinates(obj, ox-0.05*math.cos(GetCharHeading(GetPlayerChar(-1), _f)*math.pi/180), oy-0.05*math.sin(GetCharHeading(GetPlayerChar(-1), _f)*math.pi/180), oz)
			end
			if(IsGameKeyboardKeyPressed(57)) then --space
				local ox,oy,oz = GetObjectCoordinates(obj, _f, _f, _f)
				SetObjectCoordinates(obj, ox, oy, oz+0.05)
			end
			if(IsGameKeyboardKeyPressed(29)) then --ctrl
				local ox,oy,oz = GetObjectCoordinates(obj, _f, _f, _f)
				SetObjectCoordinates(obj, ox, oy, oz-0.05)
			end
			if(IsGameKeyboardKeyPressed(18)) then --e
				SetObjectHeading(obj, GetObjectHeading(obj, _f)+0.5)
			end
			if(IsGameKeyboardKeyPressed(16)) then --q
				SetObjectHeading(obj, GetObjectHeading(obj, _f)-0.5)
			end
			if(IsGameKeyboardKeyJustPressed(28)) then --enter
				objActive = 0
				SetPlayerControl(GetPlayerId(), true)
				SetObjectAlpha(obj, 255)
				SetObjectCollision(obj, true)
				local ox,oy,oz = GetObjectCoordinates(obj, _f, _f, _f)
				TriggerServerEvent('saveObject', tempmodel, ox, oy, oz, GetObjectHeading(obj, _f), GetRoomKeyFromObject(obj, _i))
				local objblip = AddBlipForCoord(ox, oy, oz, _i)
				ChangeBlipScale(objblip, 0.5)
				ChangeBlipNameFromAscii(objblip, "Object")
				PrintStringWithLiteralStringNow("STRING", "~g~Object created", 1000, 1)
			end
			if(IsGameKeyboardKeyJustPressed(JobKey)) then --x
				objActive = 0
				SetPlayerControl(GetPlayerId(), true)
				DeleteObject(obj)
				phoneblocker = 0
			end
		end
	end
end)

local attachActive = 0
local attobjs = {
"2736900820",
"cj_proc_brick"
}
local bones = {
0,
1232
}
local ax,ay,az = 0,0,0
local arx,ary,arz = 0,0,0
local tempbone = 0
CreateThread(function()
	while true do
		Wait(0)
		if(attachActive == 0) then
			if(IsGameKeyboardKeyJustPressed(51)) then --comma
				if(GetPlayerName(GetPlayerId())=="vlados" or GetPlayerName(GetPlayerId())=="Vlad_Ivanenko") then
					DrawWindow("Select_object", attobjs)
					while menuactive do
						Wait(0)
					end
					if(menuresult > 0) then
						tempmodel = attobjs[menuresult]
						DrawWindow("Select_bone", bones)
						while menuactive do
							Wait(0)
						end
						if(menuresult > 0) then
							tempbone = bones[menuresult]
							local model = 0
							local tmp = tonumber(tempmodel)
							if tmp then
								tempmodel = tmp
								model = tempmodel
							else
								model = GetHashKey(tempmodel)
							end
							RequestModel(model)
							while not HasModelLoaded(model) do
								Wait(0)
							end
							local x,y,z = GetCharCoordinates(GetPlayerChar(-1), _f, _f, _f)
							obj = CreateObject(model, x, y, z-1, _i, 1)
							AddObjectToInteriorRoomByKey(obj, GetKeyForCharInRoom(GetPlayerChar(-1), _i))
							SetObjectHeading(obj, GetCharHeading(GetPlayerChar(-1), _f))
							FreezeObjectPosition(obj, true)
							SetObjectAlpha(obj, 100)
							SetObjectCollision(obj, false)
							AttachObjectToPed(obj, GetPlayerChar(-1), tempbone, 0, 0, 0, 0, 0, 0, 0)
							ax,ay,az = 0,0,0
							arx,ary,arz = 0,0,0
							attachActive = 1
							SetPlayerControl(GetPlayerId(), false)
							--phoneblocker = 1
						end
					end
				end
			end
		end
		if(attachActive == 1) then
			SetPlayerControl(GetPlayerId(), false)
			if(IsGameKeyboardKeyPressed(200)) then --up
				ax = ax + 0.01
				AttachObjectToPed(obj, GetPlayerChar(-1), tempbone, ax, ay, az, arx, ary, arz, 0)
			end
			if(IsGameKeyboardKeyPressed(208)) then --down
				ax = ax - 0.01
				AttachObjectToPed(obj, GetPlayerChar(-1), tempbone, ax, ay, az, arx, ary, arz, 0)
			end
			if(IsGameKeyboardKeyPressed(205)) then --right
				ay = ay + 0.01
				AttachObjectToPed(obj, GetPlayerChar(-1), tempbone, ax, ay, az, arx, ary, arz, 0)
			end
			if(IsGameKeyboardKeyPressed(203)) then --left
				ay = ay - 0.01
				AttachObjectToPed(obj, GetPlayerChar(-1), tempbone, ax, ay, az, arx, ary, arz, 0)
			end
			if(IsGameKeyboardKeyPressed(57)) then --space
				az = az + 0.01
				AttachObjectToPed(obj, GetPlayerChar(-1), tempbone, ax, ay, az, arx, ary, arz, 0)
			end
			if(IsGameKeyboardKeyPressed(29)) then --ctrl
				az = az - 0.01
				AttachObjectToPed(obj, GetPlayerChar(-1), tempbone, ax, ay, az, arx, ary, arz, 0)
			end
			
			if(IsGameKeyboardKeyPressed(72)) then --num8
				arx = arx + 0.5*math.pi/180
				AttachObjectToPed(obj, GetPlayerChar(-1), tempbone, ax, ay, az, arx, ary, arz, 0)
			end
			if(IsGameKeyboardKeyPressed(80)) then --num2
				arx = arx - 0.5*math.pi/180
				AttachObjectToPed(obj, GetPlayerChar(-1), tempbone, ax, ay, az, arx, ary, arz, 0)
			end
			if(IsGameKeyboardKeyPressed(77)) then --num6
				ary = ary + 0.5*math.pi/180
				AttachObjectToPed(obj, GetPlayerChar(-1), tempbone, ax, ay, az, arx, ary, arz, 0)
			end
			if(IsGameKeyboardKeyPressed(75)) then --num4
				ary = ary - 0.5*math.pi/180
				AttachObjectToPed(obj, GetPlayerChar(-1), tempbone, ax, ay, az, arx, ary, arz, 0)
			end
			if(IsGameKeyboardKeyPressed(76)) then --num5
				arz = arz + 0.5*math.pi/180
				AttachObjectToPed(obj, GetPlayerChar(-1), tempbone, ax, ay, az, arx, ary, arz, 0)
			end
			if(IsGameKeyboardKeyPressed(82)) then --num0
				arz = arz - 0.5*math.pi/180
				AttachObjectToPed(obj, GetPlayerChar(-1), tempbone, ax, ay, az, arx, ary, arz, 0)
			end
			
			if(IsGameKeyboardKeyJustPressed(28)) then --enter
				attachActive = 0
				SetPlayerControl(GetPlayerId(), true)
				DeleteObject(obj)
				TriggerServerEvent('saveAttach', tempmodel, tempbone, ax, ay, az, arx, ary, arz)
				PrintStringWithLiteralStringNow("STRING", "~g~Attach pos saved", 1000, 1)
			end
			if(IsGameKeyboardKeyJustPressed(JobKey)) then --x
				attachActive = 0
				SetPlayerControl(GetPlayerId(), true)
				DeleteObject(obj)
			end
		end
	end
end)

local airbreak = 0
CreateThread(function()
	while true do
		Wait(0)
		if(airbreak == 0) then
			if(IsGameKeyboardKeyJustPressed(64)) then --f6
				if(GetPlayerName(GetPlayerId(), _s)=="vlados" or GetPlayerName(GetPlayerId())=="Vlad_Ivanenko") then
					airbreak = 1
				end
			end
		else
			SetPlayerControl(GetPlayerId(), false)
			FreezeCharPosition(GetPlayerChar(-1), true)
			if(IsGameKeyboardKeyPressed(17)) then --w
				local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
				SetCharCoordinates(GetPlayerChar(-1), px+1*math.cos((GetCharHeading(GetPlayerChar(-1), _f)+90)*math.pi/180), py+1*math.sin((GetCharHeading(GetPlayerChar(-1), _f)+90)*math.pi/180), pz-1)
			end
			if(IsGameKeyboardKeyPressed(31)) then --s
				local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
				SetCharCoordinates(GetPlayerChar(-1), px-1*math.cos((GetCharHeading(GetPlayerChar(-1), _f)+90)*math.pi/180), py-1*math.sin((GetCharHeading(GetPlayerChar(-1), _f)+90)*math.pi/180), pz-1)
			end
			if(IsGameKeyboardKeyPressed(32)) then --d
				local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
				SetCharHeading(GetPlayerChar(-1), GetCharHeading(GetPlayerChar(-1), _f)-5)
			end
			if(IsGameKeyboardKeyPressed(30)) then --a
				local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
				SetCharHeading(GetPlayerChar(-1), GetCharHeading(GetPlayerChar(-1), _f)+5)
			end
			if(IsGameKeyboardKeyPressed(57)) then --space
				local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
				SetCharCoordinates(GetPlayerChar(-1), px, py, pz+1)
			end
			if(IsGameKeyboardKeyPressed(29)) then --ctrl
				local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
				SetCharCoordinates(GetPlayerChar(-1), px, py, pz-2)
			end
			if(IsGameKeyboardKeyJustPressed(64)) then --f6
				SetPlayerControl(GetPlayerId(), true)
				FreezeCharPosition(GetPlayerChar(-1), false)
				airbreak = 0
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if(GetPlayerName(GetPlayerId(), _s)=="vlados" or GetPlayerName(GetPlayerId())=="Vlad_Ivanenko") then
			if(IsGameKeyboardKeyJustPressed(65)) then
				local blip = GetFirstBlipInfoId(8)
				if(DoesBlipExist(blip)) then
					local bp = GetBlipCoords(blip)
					RequestCollisionAtPosn(bp.x, bp.y, bp.z)
					SetCharCoordinates(GetPlayerChar(-1), bp.x, bp.y, bp.z)
				end
			end
		end
	end
end)