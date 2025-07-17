local carshopmenu = 0
local linecs = 0
local tempcar= nil
carinfo = {
		{"BMW M3", 900000, GetHashKey("m3")},
	{"Lamborghini Urus", 600000, GetHashKey("urus")},
	{"Lamborghini Huracan", 2000000, GetHashKey("lambo")},
	{"Tryrant", 999999, GetHashKey("free")},
	{"Rolls Royce Wraith", 800000, GetHashKey("rolls")},
	{"Infiniti Sports", 850000, GetHashKey("infiniti")},
	{"Tony Premium", 999999999, GetHashKey("tony")},
	{"Admiral", 0, 1264341792},
	{"Banshee", 160000-100000, 3253274834},
	{"Blista", 15000, 3950024287},
	{"Bobcat", 25000, 1075851868},
	{"Buccaneer", 18000, 3612755468},
	{"Burrito", 22000, 2948279460},
	{"Cavalcade", 70000, 2006918058},
	{"Chavos", 20000, 4227685218},
	{"Cognoscenti", 90000, 2264796000},
	{"Comet", 500000-100000, 1063483177},
	{"Coquette", 350000-100000, 108773431},
	{"Dilettante", 20000, 3164157193},
	{"Dukes", 22000, 723973206},
	{"Contender", 25000, 2323011842},
	{"Emperor", 25000, 3609690755},
	{"Esperanto", 18000, 4018066781},
	{"Faction", 18000, 2175389151},
	{"Feltzer", 30000, 3197138417},
	{"Feroci", 18000, 974744810},
	{"Fortune", 16000, 627033353},
	{"Futo", 14000, 2016857647},
	{"Cavalcade_FXT", 55000, 675415136},
	{"Habanero", 22000, 884422927},
	{"Hakumai", 15000, 3953074643},
	{"Huntley_Sport", 80000, 486987393},
	{"Infernus", 450000-100000, 418536135},
	{"Ingot", 10000, 3005245074},
	{"Intruder", 25000, 886934177},
	{"Landstalker", 30000, 1269098716},
	{"Lokus", 13000, 4257937240},
	{"Manana", 12000, 2170765704},
	{"Marbella", 15000, 1304597482},
	{"Merit", 18000, 3034085758},
	{"Minivan", 20000, 3984502180},
	{"Moonbeam", 22000, 525509695},
	{"Oracle", 25000, 1348744438},
	{"Patriot", 50000, 3486509883},
	{"Perennial", 20000, 2217223699},
	{"Peyote", 25000, 1830407356},
	{"Pinnacle", 20000, 131140572},
	{"PMP_600", 32000, 1376298265},
	{"Pony", 18000, 4175309224},
	{"Premier", 18000, 2411098011},
	{"Presidente", 25000, 2332896166},
	{"Primo", 18000, 3144368207},
	{"Rancher", 25000, 1390084576},
	{"Rebla", 35000, 83136452},
	{"Ruiner", 19000, 4067225593},
	{"Sabre", 20000, 3845944409},
	{"Sabre_GT", 50000, 2609945748},
	{"Schafter", 25000, 3972623423},
	{"Sentinel", 25000, 1349725314},
	{"Solair", 20000, 1344573448},
	{"Stallion", 22000, 1923400478},
	{"Stratum", 18000, 1723137093},
	{"Sultan", 35000, 970598228},
	{"Sultan_RS", 250000-100000, 3999278268},
	{"Super_GT", 200000-100000, 1821991593},
	{"Turismo", 250000-100000, 2398307655},
	{"Uranus", 15000, 1534326199},
	{"Vigero", 18000, 3469130167},
	{"Vincent", 20000, 3711685889},
	{"Virgo", 18000, 3796912450},
	{"Voodoo", 20000, 2006667053},
	{"Washington", 22000, 1777363799},
	{"Willard", 18000, 1937616578},
	{"Freeway", 20000, 2464508460},
	{"Faggio", 7000, 2452219115},
	{"Hellfury", 25000, 584879743},
	{"NRG_900", 25000, 1203311498},
	{"PCJ_600", 20000, 3385765638},
	{"Sanchez", 12000, 788045382},
	{"Zombie", 25000, 3724934023},
    {"Coming soon", 600000, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon", 600000, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
	{"Coming soon..", 999999, GetHashKey("admiral")},
}
local cshopon= false
cars = {}
for i=1,#carinfo,1 do
	cars[i] = 0
end

RegisterNetEvent('updCars')
AddEventHandler('updCars', function(data)
	for i=1,#data,1 do
		cars[i] = tonumber(data[i])
	end
end)

SaveCars = function()
	local data = {}
	for i=1,#cars,1 do
		data[i] = cars[i]
	end
	TriggerServerEvent('saveCars', data)
end


local carshopcoords = {
{{-1496.90393, 1118.74939, 23.21376, 269.805053710938}, {-1494.98145, 1131.26147, 23.2127, 267.070190429688}, {-1467.68835, 1122.59961, 22.99259, 178.222869873047, 0}},
{{-1088.06372, 1473.52173, 24.79185, 90.0429992675781}, {-1080.53271, 1468.86926, 24.79183, 233.046844482422}, {-1073.13794, 1450.08582, 24.46088, 87.435920715332, 0}},
{{80.17219, 801.10474, 15.16314, 270.032409667969}, {56.95488, 791.07263, 16.70222, 58.7609825134277}, {59.77507, 818.60486, 14.65029, 87.8579788208008, 0}}
}
local carshopblip = {}
local ci=nil
CreateThread(function()
	while true do
		Wait(0)
		for i=1,#carshopcoords,1 do
			if(not DoesBlipExist(carshopblip[i])) then
				carshopblip[i] = AddBlipForCoord(carshopcoords[i][1][1], carshopcoords[i][1][2], carshopcoords[i][1][3], _i)
				ChangeBlipSprite(carshopblip[i], 35)
				ChangeBlipScale(carshopblip[i], 0.7)
				ChangeBlipColour(carshopblip[i], 19)
				ChangeBlipNameFromAscii(carshopblip[i], "Car shop")
				SetBlipAsShortRange(carshopblip[i], true)
			end
			DrawTextAtCoord(carshopcoords[i][1][1], carshopcoords[i][1][2], carshopcoords[i][1][3], "Car_shop_Press[E]", 20)
			
			if(IsPlayerNearCoords(carshopcoords[i][1][1], carshopcoords[i][1][2], carshopcoords[i][1][3], 1)) then
				if(IsGameKeyboardKeyJustPressed(18)) then
					SetPlayerControl(GetPlayerId(), false)
					SetCharVisible(GetPlayerChar(-1), false)
					SetNuiFocus(true, true)
				    OpenCarShop()
					ci=i
					
				end
			end
		end
	end
end)
local carinshowroom = nil

RegisterNUICallback("CarDataChanged", function(data, cb)
	 local carName = data.carName  -- Get the car name from the data
    local carPrice = data.carPrice  -- Get the car price from the data
    local carModel = data.carModel  -- Get the car model from the data
    local carColor = data.carColor
	tempcar = data.carId
	if(DoesVehicleExist(carinshowroom)) then
		DeleteCar(carinshowroom)
	end
	carinshowroom = SpawnCar(carModel, carshopcoords[ci][2][1], carshopcoords[ci][2][2], carshopcoords[ci][2][3], carshopcoords[ci][2][4])
	FreezeCarPosition(carinshowroom, true)
	WarpCharIntoCar(GetPlayerChar(-1), carinshowroom)
	SetCarLivery(carinshowroom, 0)
	
	SetPlayerControl(GetPlayerId(), false)
	SetCharVisible(GetPlayerChar(-1), false)
end)

RegisterNUICallback("BuyCar", function(data, cb)
    local carName = data.carName  -- Get the car name from the data
    local carPrice = tonumber(data.carPrice)  -- Get the car price from the data
    local carModel = data.carModel  -- Get the car model from the data
    local carColor = data.carColor   -- Get the car color from the data
    
    local tempamount = 0
    for j = 1, #cars do
        if cars[j] == 1 then
            tempamount = tempamount + 1
        end
    end

    local tempgarage = 4
    for j = 1, #houses do
        if houses[j] == GetPlayerName(GetPlayerId()) then
            tempgarage = tempgarage + houseinfo[j][4]
        end
    end

    if tempamount < tempgarage then
        if cars[tempcar] == 0 then  -- Check if the car is not already owned
            if inventory[34] >= carPrice then  -- Check if the player has enough money
                RemoveItem(34, carPrice)  -- Remove the price from the inventory
                SaveStats()  -- Save the player's stats
                cars[tempcar] = 1  -- Mark the car as owned
                SaveCars()  -- Save the cars
                Notify("Vehicle purchased.")
				
				
            else
                Notify("You do not have enough money.")
            end
        else
            Notify("You already own this vehicle.")
        end
    else
        if tempgarage > 4 then
            Notify("To be able to purchase more vehicles you must own a house.")
        else
            Notify("Out of garage places.")
        end
    end
end)

RegisterNUICallback("ExitShop", function(data, cb)
	cshopon = false
	SetNuiFocus(false, false)
	SetPlayerControl(GetPlayerId(), true)
	SetCharVisible(GetPlayerChar(-1), true)			
    DeleteCar(carinshowroom)
	SetCharCoordinates(GetPlayerChar(-1), carshopcoords[ci][1][1], carshopcoords[ci][1][2], carshopcoords[ci][1][3]-1)
end)

RegisterNUICallback("TestDrive", function(data, cb)
	local i = ci
	cshopon = false
    local carName = data.carName  -- Get the car name from the data
    local carPrice = data.carPrice  -- Get the car price from the data
    local carmodel = data.carModel  -- Get the car model from the data
    local carColor = data.carColor   -- Get the car color from the data
    
   ExitCarShop()
	if(DoesVehicleExist(carinshowroom)) then
		DeleteCar(carinshowroom)
	end
	carinshowroom = SpawnCar(carmodel, carshopcoords[i][2][1], carshopcoords[i][2][2], carshopcoords[i][2][3], carshopcoords[i][2][4])
	FreezeCarPosition(carinshowroom, false)
	SetPlayerControl(GetPlayerId(), true)
	SetCharVisible(GetPlayerChar(-1), true)
	SetCarCoordinates(carinshowroom, carshopcoords[i][3][1], carshopcoords[i][3][2], carshopcoords[i][3][3])
	SetCarHeading(carinshowroom, carshopcoords[i][3][4])
	WarpCharIntoCar(GetPlayerChar(-1), carinshowroom)
	SetCarOnGroundProperly(carinshowroom)
	Notify("Test drive started. Press F to leave.")

	while not IsControlJustPressed(0, 43) do Wait(0) end

	DeleteCar(carinshowroom)
	SetCharCoordinates(GetPlayerChar(-1), carshopcoords[i][1][1], carshopcoords[i][1][2], carshopcoords[i][1][3]-1)
end)

ExitCarShop = function()
	cshopon = false
	SendNUIMessage({
		action = 'hideUI',
	})
	SetNuiFocus(false, false)		
	SetPlayerControl(GetPlayerId(), true)
    SetCharVisible(GetPlayerChar(-1), true)
end
OpenCarShop = function()
	cshopon = true
	SendNUIMessage({
		action = 'OpenUI',
		action = 'showUI',
	})
end