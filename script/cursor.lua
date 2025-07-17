cursor = 0
local mouseX = 0
local mouseY = 0

CreateThread(function()
	while true do
		Wait(0)
		--if(loginform == 0) then
			if(not HasStreamedTxdLoaded("cursor")) then
				RequestStreamedTxd("cursor")
				while not HasStreamedTxdLoaded("cursor") do
					RequestStreamedTxd("cursor")
					--[[DrawRect(0.5, 0.5, 1.0, 1.0, 0, 0, 0, 255)
					SetTextScale(0.500000,  0.8000000)
					SetTextDropshadow(0, 0, 0, 0, 0)
					SetTextFont(6)
					--SetTextEdge(1, 0, 0, 0, 255)
					--SetTextWrap(0.0, 0.5-0.7/4)
					SetTextCentre(1)
					DisplayTextWithLiteralString(0.5, 0.5, "STRING", "Loading...")]]
					Wait(0)
				end
				cur = GetTextureFromStreamedTxd("cursor", "cursor")
			end
		--end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if(cursor == 1) then
			mouseX,mouseY = GetMousePosition()
			if(mouseX>0.99 or mouseY>0.99) then
			
			else
				if(HasStreamedTxdLoaded("cursor")) then
					DrawSprite(cur, mouseX, mouseY, 0.02, 0.04, 0.0, 255, 255, 255, 255)
				else
					DrawRect(mouseX, mouseY, 0.01, 0.02, 255, 255, 255, 255)
				end
			end
		end
	end
end)

IsCursorInArea = function(x, y, width, height)
	local point1x = x - width/2
	local point1y = y - height/2
	local point2x = x + width/2
	local point2y = y + height/2
	if(mouseX>=point1x and mouseX<=point2x and mouseY>=point1y and mouseY<=point2y) then
		return true
	else
		return false
	end
end

IsCursorInAreaLeftTopCenter = function(x, y, width, height)
	local point1x = x
	local point1y = y
	local point2x = x + width
	local point2y = y + height
	if(mouseX>=point1x and mouseX<=point2x and mouseY>=point1y and mouseY<=point2y) then
		return true
	else
		return false
	end
end