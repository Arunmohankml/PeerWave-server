RegisterServerEvent('saveObject')
AddEventHandler('saveObject', function(name, x, y, z, h, key)
	local f,err = io.open("objpos.txt","a")
	if not f then return print(err) end
	f:write("{\"" .. name .. "\", " .. tonumber(x) .. ", " .. tonumber(y) .. ", " .. tonumber(z) .. ", " .. h .. ", " .. key .. "},\n")
	f:close()
end)

RegisterServerEvent('saveAttach')
AddEventHandler('saveAttach', function(model, bone, x, y, z, rx, ry, rz)
	local f,err = io.open("attpos.txt","a")
	if not f then return print(err) end
	f:write("{\"" .. model .. "\", " .. bone .. ", " .. x .. ", " .. y .. ", " .. z .. ", " .. rx .. ", " .. ry .. ", " .. rz .. "},\n")
	f:close()
end)