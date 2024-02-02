

local Object = createObject(968, 1524.09, -1602, 13.1, 0, 270, 320)
local Col_1 = createMarker(1524.22, -1596.92, 13.38, "cylinder", 4.0, 0, 255, 0, 0)
local Col_2 = createMarker(1518.10, -1602.81, 13.37, "cylinder", 4.0, 0, 255, 0, 0)
local OpenOrClose = false

function Entrance_1(source)
	if OpenOrClose == false then
		moveObject(Object, 1800, 1524.09, -1602, 13.1, 0, 90, 0)
		OpenOrClose = true
		setTimer(function(source)
			moveObject(Object, 1800, 1524.09, -1602, 13.1, 0, -90, 0)
			OpenOrClose = false
		end,7000,1,source)
	end
end
addEventHandler("onMarkerHit", Col_1, Entrance_1)

function Entrance_2(source)
	if OpenOrClose == false then
		moveObject(Object, 1800, 1524.09, -1602, 13.1, 0, 90, 0)
		OpenOrClose = true
		setTimer(function(source)
			moveObject(Object, 1800, 1524.09, -1602, 13.1, 0, -90, 0)
			OpenOrClose = false
		end,7000,1,source)
	end
end
addEventHandler("onMarkerHit", Col_2, Entrance_2)


