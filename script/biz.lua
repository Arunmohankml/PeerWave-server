bizinfo = {
--{price, coords, name, carpos}
{350000*3, {-1314.11267, 1744.7262, 27.89003, 0.991325616836548, 0}, "Ron #1", {-1312.86841, 1740.24011, 27.82466, 90.1055145263672, 0}},
{300000*3, {-1368.49792, 41.19782, 7.19345, 328.653228759766, 0}, "Globe Oil #1", {-1371.9054, 32.82675, 7.08638, 147.058990478516, 0}},
{400000*3, {-478.23645, -195.08318, 7.86049, 359.325439453125, 0}, "Globe Oil #2", {-486.78665, -188.14839, 7.74897, 178.134155273438, 0}},
{350000*3, {-432.2359, -3.34171, 9.97516, 177.428375244141, 0}, "Ron #2", {-441.32587, 1.25124, 9.86417, 178.296005249023, 0}},
{400000*3, {106.01865, 1120.44116, 14.67003, 181.250534057617, 0}, "Terroil #1", {97.48246, 1127.22083, 14.56008, 358.300964355469, 0}},
{250000*3, {766.91931, 185.50853, 6.15866, 59.8130569458008, 0}, "Ron #3", {769.40015, 194.62506, 6.02585, 192.22737121582, 0}},
{300000*3, {1453.83203, 1727.47424, 16.83681, 1.12096774578094, 0}, "Ron #4", {1435.66589, 1739.23462, 16.85878, 90.2235946655273, 0}},
{350000*3, {1786.68652, 832.88574, 16.58122, 251.278747558594, 0}, "Ron #5", {1785.65442, 813.1759, 16.55353, 73.9330902099609, 0}},
{400000*3, {1135.63586, 327.55161, 29.79166, 78.1914291381836, 0}, "Ron #6", {1138.2334, 309.42755, 29.74364, 84.9149627685547, 0}},
{300000*3, {1141.36987, -359.13895, 19.33291, 89.9745178222656, 0}, "Ron #7", {1136.85486, -366.0322, 19.2827, 358.322875976563, 0}},

{500000*3, {866.34521, -112.00662, 6.0054, 63.0218315124512, -2012314136}, "Brucie's Executive Lifestyle Autos", {863.55865, -121.62287, 5.99725, 88.9238433837891, 0}},
{450000*3, {705.95166, 1511.8031, 14.8426, 44.1091804504395, 0}, "Muscle Mary's", {711.28473, 1498.46313, 14.55765, 179.437957763672, 0}},

{75000*4, {-1002.3996, 1631.52087, 24.319, 98.9360809326172, -165511614}, "Burger Shot #1", {-994.37738, 1620.21191, 24.0177, 178.551300048828, 0}},
{75000*4, {-423.26709, 1190.59692, 13.05202, 356.754638671875, -165511614}, "Burger Shot #2", {-430.49091, 1177.44678, 13.02355, 88.8184967041016, 0}},
{87500*4, {-167.48448, 284.03998, 14.82508, 354.799926757813, -165511614}, "Burger Shot #3", {-177.19148, 270.97125, 14.71548, 88.0109786987305, 0}},
{87500*4, {-621.02399, 128.94705, 4.81617, 273.502746582031, -165511614}, "Burger Shot #4", {-623.59723, 158.9632, 4.66767, 267.220153808594, 0}},
{100000*3, {-121.84099, 78.13895, 14.80811, 16.8169651031494, -934455007}, "Cluckin' Bell #1", {-148.37241, 69.29678, 14.78117, 192.4248046875, 0}},
{100000*3, {1192.57043, 358.28915, 25.10835, 268.940521240234, -934455007}, "Cluckin' Bell #2", {1185.04565, 382.5022, 24.56269, 270.665771484375, 0}},
{87500*4, {1634.35205, 229.61443, 25.21698, 176.857177734375, -165511614}, "Burger Shot #5", {1642.48181, 247.80035, 24.05822, 244.533935546875, 0}},
{75000*4, {877.70789, -487.31384, 15.88778, 1.17020261287689, 1015898343}, "69th Street Diner", {870.68744, -486.33191, 14.66534, 359.043212890625, 0}},

{162500*3, {-280.49792, 1365.63, 25.63731, 186.975952148438, -404609341}, "Modo", {-265.08606, 1361.05518, 25.19991, 180.262268066406, 0}},
{162500*3, {26.36816, 797.12408, 14.76679, 89.0111541748047, -17186734}, "Perseus #1", {7.69119, 812.43604, 14.56762, 357.895141601563, 0}},
{162500*3, {14.91741, -671.62097, 14.86652, 87.3864974975586, -17186734}, "Perseus #2", {10.01414, -650.43732, 14.70845, 267.989166259766, 0}},
{150000*3, {889.24359, -447.26871, 15.84781, 37.217472076416, 2034592312}, "Men & Women Apparel Imported from Russia", {904.703, -442.15915, 15.75388, 178.260238647461, 0}},

{62500*4, {448.39767, 1498.42578, 16.3207, 248.716873168945, -165511614}, "Burger Shot #6", {431.12006, 1497.44385, 14.76613, 26.6473598480225, 0}},
{62500*4, {1110.79541, 1579.6781, 16.91252, 233.259216308594, -165511614}, "Burger Shot #7", {1094.3197, 1599.10266, 16.63784, 313.089569091797, 0}}
}
local bizblip = {}
biz = {}
for i=1,#bizinfo,1 do
	biz[i] = "0"
end

RegisterNetEvent('updBiz')
AddEventHandler('updBiz', function(data)
	for i=1,#bizinfo,1 do
		if(data[i] == nil) then
			data[i] = "0"
		end
		biz[i] = tostring(data[i])
	end
end)

SaveBiz = function()
	local data = {}
	for i=1,#biz,1 do
		data[i] = biz[i]
	end
	TriggerServerEvent('saveBiz', data)
end
-------------------------------------------
bizcash = {}
for i=1,#bizinfo,1 do
	bizcash[i] = 0
end
RegisterNetEvent('updBizCash')
AddEventHandler('updBizCash', function(name, id, value)
	if(GetPlayerName(GetPlayerId()) == name) then
		bizcash[id] = value
		if(bizcash[id] <= 3) then
			Notify("" .. bizinfo[id][3] .. " business service payment has been increased to " .. math.floor(bizinfo[id][1]/100*bizcash[id]) .. "$. You can pay it at the nearest ATM.")
		else
			Notify("Your " .. bizinfo[id][3] .. " business has been removed from you due to too high business service debt.")
		end
	end
end)
RegisterNetEvent('updBizCash2')
AddEventHandler('updBizCash2', function(data)
	for i=1,#bizinfo,1 do
		if(data[i] == nil) then
			data[i] = 0
		end
		bizcash[i] = tonumber(data[i])
	end
end)

SaveBizCash = function()
	local data = {}
	for i=1,#bizcash,1 do
		data[i] = bizcash[i]
	end
	TriggerServerEvent('saveBizCash', data)
end
-----------------------------------------------
bizincome = {}
for i=1,#bizinfo,1 do
	bizincome[i] = 0
end
RegisterNetEvent('updBizIncome')
AddEventHandler('updBizIncome', function(name, id, value)
	if(GetPlayerName(GetPlayerId()) == name) then
		local oldvalue = bizincome[id]
		bizincome[id] = value
		if(bizincome[id] ~= oldvalue) then
			Notify("" .. bizinfo[id][3] .. " business income has been increased to " .. bizincome[id] .. "$. You can collect it at the business or at the nearest ATM.")
		else
			Notify("" .. bizinfo[id][3] .. " business has received no income due to lack of supplies. Please visit this business and start a supply mission.")
		end
	end
end)
RegisterNetEvent('updBizIncome2')
AddEventHandler('updBizIncome2', function(data)
	for i=1,#bizinfo,1 do
		if(data[i] == nil) then
			data[i] = 0
		end
		bizincome[i] = tonumber(data[i])
	end
end)

SaveBizIncome = function()
	local data = {}
	for i=1,#bizincome,1 do
		data[i] = bizincome[i]
	end
	TriggerServerEvent('saveBizIncome', data)
end
---------------------------------------
local bizstats = {}
for i=1,#bizinfo,1 do
	bizstats[i] = 0
end
RegisterNetEvent('updBizStats')
AddEventHandler('updBizStats', function(data)
	for i=1,#bizinfo,1 do
		if(data[i] == nil) then
			data[i] = 0
		end
		bizstats[i] = tonumber(data[i])
	end
end)

SaveBizStats = function()
	local data = {}
	for i=1,#bizstats,1 do
		data[i] = bizstats[i]
	end
	local names = {}
	for i=1,#bizinfo,1 do
		names[i] = bizinfo[i][3]
	end
	TriggerServerEvent('saveBizStats', data, names)
end

AddIncomeToBiz = function(name, amount)
	for i=1,#bizinfo,1 do
		if(bizinfo[i][3] == name) then
			if(biz[i] ~= "0") then
				bizincome[i] = bizincome[i] + amount
				SaveBizIncome()
			end
			bizstats[i] = bizstats[i] + amount
			SaveBizStats()
			return
		end
	end
end
-----------------------------------------
bizmis = {}
for i=1,#bizinfo,1 do
	bizmis[i] = 0
end
RegisterNetEvent('updBizMission')
AddEventHandler('updBizMission', function(data)
	for i=1,#bizinfo,1 do
		if(data[i] == nil) then
			data[i] = 0
		end
		bizmis[i] = tonumber(data[i])
	end
end)

SaveBizMission = function()
	local data = {}
	for i=1,#bizmis,1 do
		data[i] = bizmis[i]
	end
	TriggerServerEvent('saveBizMission', data)
end

local coords = {
{-1768.84802, 127.674, 11.12675, 104.256980895996, 0},
{-365.09937, -631.8299, 4.79059, 32.1859550476074, 0},
{1210.46692, 1525.02563, 16.67961, 186.857086181641, 0},
{2109.29028, 80.81966, 5.81492, 89.6243438720703, 0},
{-474.035, 1746.43359, 8.70162, 119.052345275879, 0},
{-1364.5083, 1696.45898, 27.82517, 178.996490478516, 0}
}
local bizblip = {}
local jobblip = nil
local truck = nil
local state = 0
local bizid = 0
CreateThread(function()
	while true do
		Wait(0)
		for i=1,#bizinfo,1 do
			--[[if(not DoesBlipExist(bizblip[i])) then
				bizblip[i] = AddBlipForCoord(bizinfo[i][2][1], bizinfo[i][2][2], bizinfo[i][2][3])
				SetBlipSprite(bizblip[i], 110)
				--SetBlipColour(bizblip[i], 1)
				SetBlipName(bizblip[i], bizinfo[i][3])
				SetBlipAsShortRange(bizblip[i], true)
			end]]
			local owner = "None"
			if(biz[i] ~= "0") then
				owner = biz[i]
			end
			DrawTextAtCoord(bizinfo[i][2][1], bizinfo[i][2][2], bizinfo[i][2][3], "" .. GetStringWithoutSpaces(bizinfo[i][3]) .. " Owner:_" .. GetStringWithoutSpaces(owner) .. " Price:_" .. bizinfo[i][1] .. "$", 20)
			if(biz[i] == "0") then
				DrawCheckpointWithDist(bizinfo[i][2][1], bizinfo[i][2][2], bizinfo[i][2][3]-1, 1.1, 255, 255, 255, 100)
			elseif(biz[i] == GetPlayerName(GetPlayerId())) then
				DrawCheckpointWithDist(bizinfo[i][2][1], bizinfo[i][2][2], bizinfo[i][2][3]-1, 1.1, 0, 255, 0, 100)
			else
				DrawCheckpointWithDist(bizinfo[i][2][1], bizinfo[i][2][2], bizinfo[i][2][3]-1, 1.1, 255, 0, 0, 100)
			end
			if(IsPlayerNearCoords(bizinfo[i][2][1], bizinfo[i][2][2], bizinfo[i][2][3], 1)) then
				if(biz[i] == "0") then
					PrintText("Press ~y~E ~w~to purchase ~y~this business ~w~for ~g~" .. bizinfo[i][1] .. "$", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						if(inventory[34] >= bizinfo[i][1]) then
							RemoveItem(34, bizinfo[i][1])
							SaveStats()
							biz[i] = GetPlayerName(GetPlayerId())
							SaveBiz()
							Notify("Business purchased.")
						else
							Notify("You do not have enough money.")
						end
					end
				elseif(biz[i] == GetPlayerName(GetPlayerId())) then
					PrintText("Press ~y~E ~w~to ~y~open business menu", 1)
					if(IsGameKeyboardKeyJustPressed(18)) then
						::main::
						local tempitems = {}
						tempitems[#tempitems+1] = "Collect income - ~g~" .. bizincome[i] .. "$"
						tempitems[#tempitems+1] = "Start supply mission"
						tempitems[#tempitems+1] = "Sell business"
						DrawWindow("Business #" .. i, tempitems)
						while menuactive do
							Wait(0)
						end
						if(menuresult > 0) then
							if(tempitems[menuresult] == "Collect income - ~g~" .. bizincome[i] .. "$") then
								if(bizincome[i] > 0) then
									AddItem(34, bizincome[i])
									SaveStats()
									bizincome[i] = 0
									SaveBizIncome()
									Notify("Income collected.")
								else
									Notify("No income to collect.")
								end
							elseif(tempitems[menuresult] == "Start supply mission") then
								if(bizmis[i] == 0) then
									if(not DoesBlipExist(jobblip)) then
										DeleteCar(truck)
										truck = SpawnCar(GetHashKey("mule"), bizinfo[i][4][1], bizinfo[i][4][2], bizinfo[i][4][3], bizinfo[i][4][4])
										--AllowVeh(truck)
										WarpCharIntoCar(GetPlayerChar(-1), truck)
										local px,py,pz = GetCharCoordinates(GetPlayerChar(-1))
										local fx,fy,fz = GetFurthestCoordFromCoord(px, py, pz, coords)
										jobblip = AddBlipForCoord(fx, fy, fz)
										SetRoute(jobblip, true)
										bizid = i
										state = 0
										Notify("Supply mission started.")
									else
										Notify("Mission in progress.")
									end
								else
									Notify("Supply mission is already completed. Come back another day.")
								end
							elseif(tempitems[menuresult] == "Sell business") then
								if(bizcash[i] == 0) then
									if(bizincome[i] == 0) then
										local tempprice = math.floor(bizinfo[i][1]/2)
										DrawWindow("Are you sure?", {"Sell business for ~g~" .. tempprice .. "$"})
										while menuactive do
											Wait(0)
										end
										if(menuresult == 1) then
											AddItem(34, tempprice)
							
											SaveStats()
											biz[i] = "0"
											SaveBiz()
											Notify("Business sold (+" .. tempprice .. "$).")
										else
											goto main
										end
									else
										Notify("You have to collect all income from this business before selling.")
									end
								else
									Notify("You have to pay all business service debts before selling.")
								end
							end
						end
					end
				end
			end
		end
		if(DoesBlipExist(jobblip)) then
			if(not IsCarDead(truck)) then
				local bp = GetBlipCoords(jobblip)
				DrawCheckpoint(bp.x, bp.y, bp.z-1, 1.1, 255, 3, 30, 100)
				if(IsPlayerNearCoords(bp.x, bp.y, bp.z, 3)) then
					if(IsCharInCar(GetPlayerChar(-1), truck)) then
						if(state == 0) then
							SetPlayerControl(GetPlayerId(), false)
							PrintText("Loading the truck...", 10000)
							Wait(10000)
							SetPlayerControl(GetPlayerId(), true)
							state = 1
							SetBlipCoordinates(jobblip, bizinfo[bizid][4][1], bizinfo[bizid][4][2], bizinfo[bizid][4][3])
							SetRoute(jobblip, true)
						else
							RemoveBlip(jobblip)
							DeleteCar(truck)
							bizmis[bizid] = 1
							SaveBizMission()
							Notify("Supply mission completed.")
						end
					else
						PrintText("~r~You must be in the truck", 1)
					end
				end
				if(IsPlayerDead(GetPlayerId())) then
					RemoveBlip(jobblip)
					--DeleteEntity(bus)
				end
			else
				RemoveBlip(jobblip)
				--DeleteEntity(bus)
			end
		end
	end
end)