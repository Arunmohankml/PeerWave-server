local gunid = 0
local index = 0

weight = 0
invopen = 0
tempid = 0
inventory = {}
for i=1,100,1 do
	inventory[i] = 0
end

lootnames = {
    "Baseball_bat",
    "Pool_cue",
    "Knife",
    "Grenade",
    "Fuel Can",
    "Pistol",
    "Deagle",
    "Tazer",
    "Baretta",
    "Micro_SMG",
    "Special_Carbine",
    "AR Mk2",
    "Carbine Rifile",
    "Sniper_Rifle",
    "M40A1",
    "Rocket_Launcher",
    "Energy_bar",
    "Heart_Stooper",
    "Taco",
    "Cola",
    "Milk_shake",
    "Water",
    "Bandage",
    "Fishing_rod",
    "Medkit",
    "Wood",
    "Drill",
    "Dirty money",
    "Fishes",
    "packed wood",
    "Weapon Clip",
    "Weed",
    "Cocaine",
    "Cash",
    "Phone",
	"Driving_lic",
	"ID_Card",
	"Weapon_lic",
	"Washed_Stone",
	"Dirty_Stone",
	"Nokia lumina"
}
lootweight = {
	1,
	1,
	0.5,
	0.9,
	0.5,
	2,
	3,
	5,
	4,
	3,
	3,
	7.10,
	5.7,
	10,
	6,
	15,
	0.2,
	0.6,
	0.1,
	0.24,
	0.36,
	0.22,
	0.1,
	2,
	1,
	1,
	0.6,
	0,
	1,
	1,
	0.4,
	1,
	1,
	0,
	3,
	5,
	5,
	5,
	1,
	1,	
	2,
}

SaveInventory = function()
	local data = {}
	for i=1,#inventory,1 do
		data[i] = inventory[i]
	end
	TriggerServerEvent('saveInv', data)
end

RegisterNetEvent('updInv')
AddEventHandler('updInv', function(data)
	for i=1,#inventory,1 do
		inventory[i] = tonumber(data[i])
	end
end)

AddItem = function(id, amount)
  local addedWeight = lootweight[id] * amount
  if (weight + addedWeight) <= 250 then
    inventory[id] = inventory[id] + amount
    weight = weight + addedWeight
    SaveStats()
    SaveInventory()
    RefreshInventoryUI()
  else
    TriggerEvent("noticeme:Info", "Inventory is full")
  end
end


RemoveItem = function(id, amount)
  inventory[id] = inventory[id] - amount
  weight = weight - lootweight[id] * amount
  SaveStats()
  SaveInventory()
  RefreshInventoryUI()
end

function RefreshInventoryUI()
  if invopen == 1 then
    local data = {}
    for i = 1, #inventory do
      if inventory[i] > 0 then
        data[i] = inventory[i]
      end
    end

    local lootTable = {}
    for i = 1, #lootnames do
      lootTable[i] = lootnames[i]
    end

    exports.inventory:OpenInventory(data,lootTable,weight)

  end
end

function GetPlayerServerId()
	for j=0,31,1 do
		if(IsNetworkPlayerActive(j)) then
			if(GetPlayerChar(-1) == GetPlayerChar(j)) then
				return j
			end
		end
	end
end
lastWeapon = nil
local typingpad = 0
local hold = 0
local itemstring = ""
local tempid = 0
Citizen.CreateThread(function()
	for i = 1, 100 do
		local itemWeight = lootweight[i]
		local itemAmount = inventory[i]
		if itemAmount > 0 then
			weight = weight + itemWeight * itemAmount
		end
	end
	while true do
		Citizen.Wait(0)
		local gw,cw = GetCurrentCharWeapon(GetPlayerChar(-1))
		local bool, currentammo = GetAmmoInClip(GetPlayerChar(-1), cw)
		local clip = GetMaxAmmoInClip(GetPlayerChar(-1), cw)
		
		if(cw >= 7) then
			if(inventory[31] > 0) then -- if weapon clip is more than 0 in inventory
				if(IsGameKeyboardKeyJustPressed(19)) then-- reload gun key
					SetCharAmmo(GetPlayerChar(-1), cw, clip)
					if(currentammo < clip) then
						inventory[31] = inventory[31] - 1
					end
				end
			end
		end
        
        local gw,cw = GetCurrentCharWeapon(GetPlayerChar(-1))
        local ammoLeft = GetAmmoInCharWeapon(GetPlayerChar(-1), cw)
		if(cw >= 7) then
			if(inventory[31] > 0) then
				if lastWeapon ~= cw then
					lastWeapon = cw
				end
		
				if ammoLeft == 1 then
					GiveWeaponToChar(GetPlayerChar(-1), cw, clip-1)
					inventory[31] = inventory[31] - 1
				end
			end
		end

		weight = math.min(math.max(weight, 0), 250)
		if(cuff == false) then
			
			if IsGameKeyboardKeyJustPressed(60) then
        Print("clicked")
				if invopen == 0 then
					invopen = 1
					local data = {}
					for i = 1, #inventory do
						if inventory[i] > 0 then
							data[i] = inventory[i]
						end
					end

					local lootTable = {}
					for i = 1, #lootnames do
					lootTable[i] = lootnames[i]
					end

					exports.inventory:OpenInventory(data,lootTable,weight)
					
				else
					invopen = 0
          exports.inventory:CloseInventory(data,lootTable,weight)
          SetNuiFocus(false, false)
				end
			end
		end
	end
end)

RegisterNUICallback("moveItem", function(data, cb)
  local from = tonumber(data.from)
  local to = tonumber(data.to)
  inventory[to], inventory[from] = inventory[from], inventory[to]
  SaveInventory()
  cb({})
end)

RegisterNUICallback("useItem", function(data, cb)
    local itemId = tonumber(data.id)
    local amount = tonumber(data.amount or 1)
    UseItem(itemId, amount)
    cb({})
end)


function UseItem(itemId, amount)
  local char = GetPlayerChar(-1)
  local gw, cw = GetCurrentCharWeapon(char)

  if inventory[itemId] <= 0 then
    PrintStringWithLiteralStringNow("STRING", "~r~You don't have this item", 1000, 1)
    return
  end

  if itemId == 1 then -- Baseball bat
    GiveWeaponToChar(char, 1, 1, 1)
    gunid = 1

  elseif itemId == 2 then -- Pool cue
    GiveWeaponToChar(char, 2, 1, 1)
    gunid = 2

  elseif itemId == 3 then -- Knife
    GiveWeaponToChar(char, 3, 1, 1)
    gunid = 3

  elseif itemId == 4 then -- Grenade
    GiveWeaponToChar(char, 4, 1, 1)
    gunid = 4

  elseif itemId == 5 then -- Molotov (Fuel Can?)
    GiveWeaponToChar(char, 5, 1, 1)
    gunid = 5

  elseif itemId == 6 then -- Pistol
    GiveWeaponToChar(char, 7, 1, 1)
    SetCharAmmo(char, cw, 0)
    gunid = 7

  elseif itemId == 7 then -- Deagle
    GiveWeaponToChar(char, 9, 1, 1)
    SetCharAmmo(char, cw, 0)
    gunid = 9

  elseif itemId == 8 then -- Tazer
    GiveWeaponToChar(char, 29, 1, 1)
    SetCharAmmo(char, cw, 0)
    gunid = 10

  elseif itemId == 9 then -- Baretta
    GiveWeaponToChar(char, 11, 1, 1)
    SetCharAmmo(char, cw, 0)
    gunid = 11

  elseif itemId == 10 then -- Micro SMG
    GiveWeaponToChar(char, 12, 1, 1)
    SetCharAmmo(char, cw, 0)
    gunid = 12

  elseif itemId == 11 then -- Special Carbine
    GiveWeaponToChar(char, 13, 1, 1)
    SetCharAmmo(char, cw, 0)
    gunid = 13

  elseif itemId == 12 then -- AR Mk2
    GiveWeaponToChar(char, 14, 1, 1)
    SetCharAmmo(char, cw, 0)
    gunid = 14

  elseif itemId == 13 then -- Carbine Rifle
    GiveWeaponToChar(char, 15, 1, 0)
    SetCharAmmo(char, cw, 0)
    gunid = 15

  elseif itemId == 14 then -- Sniper Rifle
    GiveWeaponToChar(char, 16, 1, 1)
    SetCharAmmo(char, cw, 0)
    gunid = 16

  elseif itemId == 15 then -- M40A1
    GiveWeaponToChar(char, 17, 1, 1)
    SetCharAmmo(char, cw, 0)
    gunid = 17

  elseif itemId == 16 then -- Rocket Launcher
    GiveWeaponToChar(char, 18, 1, 1)
    SetCharAmmo(char, cw, 0)
    gunid = 18

  elseif itemId == 17 then -- Energy Bar
    if hunger < 100 then
      hunger = math.min(hunger + 5, 100)
      RemoveItem(itemId, 1)
      RequestAnims("amb@vendor")
      while not HaveAnimsLoaded("amb@vendor") do Citizen.Wait(0) end
      TaskPlayAnimWithFlags(char, "stand_eat_fastfood_2", "amb@vendor", 8.0, 0, 0)
    else
      PrintStringWithLiteralStringNow("STRING", "~r~You don't need food", 1000, 1)
    end

  elseif itemId == 18 then -- Heart Stopper (Burger)
    if hunger < 100 then
      hunger = math.min(hunger + 30, 100)
      RemoveItem(itemId, 1)
      RequestAnims("amb@vendor")
      while not HaveAnimsLoaded("amb@vendor") do Citizen.Wait(0) end
      TaskPlayAnimWithFlags(char, "stand_eat_fastfood_2", "amb@vendor", 8.0, 0, 0)
    else
      PrintStringWithLiteralStringNow("STRING", "~r~You don't need food", 1000, 1)
    end

  elseif itemId == 19 then -- Taco
    if hunger < 100 then
      hunger = math.min(hunger + 15, 100)
      RemoveItem(itemId, 1)
      RequestAnims("amb@vendor")
      while not HaveAnimsLoaded("amb@vendor") do Citizen.Wait(0) end
      TaskPlayAnimWithFlags(char, "stand_eat_fastfood_2", "amb@vendor", 8.0, 0, 0)
    else
      PrintStringWithLiteralStringNow("STRING", "~r~You don't need food", 1000, 1)
    end

  elseif itemId == 20 then -- Cola
    if thirst < 100 then
      thirst = math.min(thirst + 15, 100)
      RemoveItem(itemId, 1)
      RequestAnims("amb@coffee_idle_f")
      while not HaveAnimsLoaded("amb@coffee_idle_f") do Citizen.Wait(0) end
      TaskPlayAnimWithFlags(char, "drink_a", "amb@coffee_idle_f", 8.0, 0, 0)
    else
      PrintStringWithLiteralStringNow("STRING", "~r~You don't need drink", 1000, 1)
    end

  elseif itemId == 21 then -- Milkshake
    if thirst < 100 then
      thirst = math.min(thirst + 30, 100)
      RemoveItem(itemId, 1)
      RequestAnims("amb@coffee_idle_f")
      while not HaveAnimsLoaded("amb@coffee_idle_f") do Citizen.Wait(0) end
      TaskPlayAnimWithFlags(char, "drink_a", "amb@coffee_idle_f", 8.0, 0, 0)
    else
      PrintStringWithLiteralStringNow("STRING", "~r~You don't need drink", 1000, 1)
    end

  elseif itemId == 22 then -- Water
    if thirst < 100 then
      thirst = math.min(thirst + 5, 100)
      RemoveItem(itemId, 1)
      RequestAnims("amb@coffee_idle_f")
      while not HaveAnimsLoaded("amb@coffee_idle_f") do Citizen.Wait(0) end
      TaskPlayAnimWithFlags(char, "drink_a", "amb@coffee_idle_f", 8.0, 0, 0)
    else
      PrintStringWithLiteralStringNow("STRING", "~r~You don't need drink", 1000, 1)
    end

  elseif itemId == 23 then -- Bandage
    if GetCharHealth(char) < 200 then
      SetCharHealth(char, GetCharHealth(char) + 20)
      RemoveItem(itemId, 1)
    else
      PrintStringWithLiteralStringNow("STRING", "~r~You're already healthy", 1000, 1)
    end

  elseif itemId == 25 then -- Medkit
    if GetCharHealth(char) < 200 then
      SetCharHealth(char, 200)
      RemoveItem(itemId, 1)
    else
      PrintStringWithLiteralStringNow("STRING", "~r~You're already healthy", 1000, 1)
    end
  elseif itemId == 26 then -- Wood
    PrintStringWithLiteralStringNow("STRING", "~r~Go to wood packing coords to pack your wood", 1000, 1)

  elseif itemId == 27 then -- Drill
    if IsPlayerNearCoords(-20.37735, -476.1908, 8.91245, 1.5) then
      robberystart = 1
      RemoveItem(itemId, 1)
    else
      PrintStringWithLiteralStringNow("STRING", "~r~You must be near Bank locker", 2000, 1)
    end

  elseif itemId == 28 then -- Dirty Money
    if gang == 0 then
      PrintStringWithLiteralStringNow("STRING", "You are not a gang member or not at money washing location", 2000, 1)
    end

  elseif itemId == 29 then -- Fish (sell at supermarket)
    local price = 1500
    if IsPlayerNearCoords(-332.33859, -254.29092, 12.83515, 0.5) then
      if amount > 0 and inventory[itemId] >= amount then
        RemoveItem(itemId, amount)
        inventory[34] = inventory[34] + amount * price
        SaveInventory()
        TriggerEvent("noticeme:Info", "Sold Fish. You got " .. amount * price)
        Print('Sold ' .. amount .. ' fish and got ' .. amount * price)
      else
        PrintStringWithLiteralStringNow("STRING", "~r~Not enough fish", 3000, 1)
      end
    else
      PrintStringWithLiteralStringNow("STRING", "~r~You must be near supermarket", 3000, 1)
    end

  elseif itemId == 30 then -- Packed Wood (sell at supermarket)
    local price = 2500
    if IsPlayerNearCoords(-332.33859, -254.29092, 12.83515, 0.5) then
      if amount > 0 and inventory[itemId] >= amount then
        RemoveItem(itemId, amount)
        inventory[34] = inventory[34] + amount * price
        SaveInventory()
        TriggerEvent("noticeme:Info", "Sold Wood Pack. You got " .. amount * price)
        Print('Sold ' .. amount .. ' wood and got ' .. amount * price)
      else
        PrintStringWithLiteralStringNow("STRING", "~r~Not enough wood pack", 3000, 1)
      end
    else
      PrintStringWithLiteralStringNow("STRING", "~r~You must be near supermarket to sell wood pack", 3000, 1)
    end

  elseif itemId == 31 then -- Weapon Clip
    if gunid > 0 then
      giveammo()
      RemoveItem(itemId, 1)
    else
      PrintStringWithLiteralStringNow("STRING", "~r~Hold a weapon to use", 2000, 1)
    end

  elseif itemId == 32 or itemId == 33 then -- Weed / Cocaine
    RequestAnims("amb@smoking_spliff")
    while not HaveAnimsLoaded("amb@smoking_spliff") do Citizen.Wait(0) end
    TaskPlayAnimWithFlags(char, "create_spliff", "amb@smoking_spliff", 8.0, 0, 0)
    Citizen.Wait(2000)
    RemoveItem(itemId, 1)
    ClearCharTasksImmediately(char)
    SetCamShake(GetGameCam(), 1, 30)
    SetDrunkCam(GetGameCam(), 0.5, 5000)
    if itemId == 33 then
      AddArmourToChar(char, 200)
    else
      SetCharHealth(char, 200)
    end

  else
    PrintStringWithLiteralStringNow("STRING", "~r~This item can't be used", 1000, 1)
  end

  SaveInventory()
  SaveStats()
end

RegisterNUICallback("giveItem", function(data, cb)
  local itemId = tonumber(data.id)
  local amount = tonumber(data.amount or 1)

  -- Validate item ID and amount
  if not itemId or amount < 1 then
    PrintStringWithLiteralStringNow("STRING", "~r~Invalid item or amount", 1000, 1)
    cb({})
    return
  end

  -- Check if player has enough items
  if inventory[itemId] == nil or inventory[itemId] < amount then
    PrintStringWithLiteralStringNow("STRING", "~r~Not enough items", 1000, 1)
    cb({})
    return
  end

  -- Find nearby players
  local nearbyPlayers = GetNearbyPlayers()
  if #nearbyPlayers == 0 then
    PrintStringWithLiteralStringNow("STRING", "~r~No one nearby to give item", 1000, 1)
    cb({})
    return
  end

  -- Send to server for confirmation
  local receiver = nearbyPlayers[1]
  TriggerServerEvent("requestItemSending", receiver, GetPlayerServerId(), itemId, amount)

  -- Wait for server to confirm (ideally, item should only be removed on confirmation)
  RemoveItem(itemId, amount)

  PrintStringWithLiteralStringNow("STRING", "~g~You gave " .. amount .. " " .. lootnames[itemId], 1000, 1)

  cb({})
end)


RegisterNUICallback("closeInventory", function(_, cb)
  SetNuiFocus(false, false)
  invopen = 0
  cb({})
end)

function GetNearbyPlayers()
  local players = {}
  for i = 0, 31 do
    if IsNetworkPlayerActive(i) and GetPlayerChar(i) ~= GetPlayerChar(-1) then
      local x, y, z = table.unpack(GetCharCoordinates(GetPlayerChar(i)))
      local myX, myY, myZ = table.unpack(GetCharCoordinates(GetPlayerChar(-1)))
      local dist = GetDistanceBetweenCoords3d(x, y, z, myX, myY, myZ)
      if dist < 5.0 then
        table.insert(players, i)
      end
    end
  end
  return players
end

function giveammo()
	local char = GetPlayerChar(-1)
	GiveWeaponToChar(char, gunid, 30, 1)
	PrintStringWithLiteralStringNow("STRING", "Ammo + 30", 5000, 1)
end

RegisterNetEvent('sendItem')
AddEventHandler('sendItem', function(receiver, sender, item, amount)
	if(GetPlayerChar(-1) == GetPlayerChar(receiver)) then
		AddItem(item, tonumber(amount))
		TriggerEvent("noticeme:Info", "You have received ".. amount.. " ".. lootnames[item] .. " from " .. GetPlayerName(sender))
	end
end)

function IsPlayerNearCoords(x, y, z, radius)
    local pos = table.pack(GetCharCoordinates(GetPlayerChar(-1)))
    local dist = GetDistanceBetweenCoords3d(x, y, z, pos[1], pos[2], pos[3]);
	if dist < radius then 
		return true
	else 
		return false
    end
end
