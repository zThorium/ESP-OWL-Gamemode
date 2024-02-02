--setElementPosition( localPlayer, 2479.1298828125, -2105.4189453125, 18.198581695557)
setDevelopmentMode(true)
--[[
local repairGarages = {
-- X,Y,Z, Szélessé, Hosszúság



	createColSphere(1578.1584472656, -2150.576171875, 13.546875, 5),
	createColSphere(1585.2587890625, -2146.8901367188, 13.546875, 5),
	createColSphere(1592.412109375, -2144.0927734375, 13.5546875, 5),
	createColSphere(1599.453125, -2140.7727050781, 13.5546875, 5),
	createColSphere(1606.0026855469, -2136.8544921875, 13.5546875, 5),
	createColSphere(1583.7945556641, -2178.822265625, 13.546875, 5),
	createColSphere(1575.9841308594, -2178.2282714844, 13.546875, 5),
	createColSphere(1568.1597900391, -2178.3872070313, 13.546875, 5),	
	createColSphere(1560.3635253906, -2178.4797363281, 13.546875, 5),
	createColSphere(1553.0427246094, -2178.7958984375, 13.546875, 5),
	createColSphere(1544.9797363281, -2178.6528320313, 13.546875, 5),
	createColSphere(1570.8507080078, -2153.9372558594, 13.546875, 5),
	
	
}
local function isElementWithinFixerColshape(element)
	local inside = false
	for k, v in pairs(repairGarages) do
		if isElementWithinColShape(element, v) then
			inside = true
			break
		end
	end
	return inside
end
]]--

local sx, sy = guiGetScreenSize()
scmp = (1/1920)*sx
local repairTimer
local function isInBoxEdited(x, y, xmin, ymin, xsize, ysize)
	 return x >= xmin and x <= xmin+xsize and y >= ymin and y <= ymin+ysize
end
--windscreen
--bump_front
--bump_rear
--bonnet
--door_lf
--door_rf
--wheel_rf
--wheel_lf
--wheel_rb
--wheel_lb
local engineBackVeh = {[451] = true}

local partTable = {{"windscreen_dummy", "Parabrisas"},
{"bump_front_dummy", "Parachoques delantero"},
{"bump_rear_dummy", "Parachoques trasero"},
{"bonnet_dummy", "Capo"},
{"boot_dummy", "Malas"},
{"door_lf_dummy", "Puerta delantera izquierda"},
{"door_rf_dummy", "Puerta delantera derecha"},
{"door_lr_dummy", "Puerta trasera derecha"},
{"door_rr_dummy", "Puerta trasera derecha"},
{"wheel_rf_dummy", "Rueda delantera derecha"},
{"wheel_lf_dummy", "Rueda delantera izquierda"},
{"wheel_rb_dummy", "Rueda trasera derecha"},
{"wheel_lb_dummy", "Rueda trasera izquierda"},
{"wheel_rear", "Rueda trasera"},
{"wheel_front", "Rueda delantera"}}

local function getNameFromPart(part)
	local returnVal = false
	for k, v in pairs(partTable) do
		if v[1] == part then
			returnVal = v[2]
			break
		end
	end
	return returnVal
end
local function hasPartGotProblem(v, part)
	local returnVal = false
	local lf, lb, rf, rb = getVehicleWheelStates(v)
	
	local lfd, rfd, lrd, rrd,bonnet,boot = getVehicleDoorState(v, 2), getVehicleDoorState(v, 3), getVehicleDoorState(v, 4), getVehicleDoorState(v, 5), getVehicleDoorState(v, 0), getVehicleDoorState(v, 1)
	if part == "wheel_rf_dummy" and rf ~= 0 then
		returnVal = true
	elseif part == "wheel_lf_dummy" and lf ~= 0 then
		returnVal = true
	elseif part == "wheel_rb_dummy" and rb ~= 0 then
		returnVal = true
	elseif part == "wheel_lb_dummy" and lb ~= 0 then
		returnVal = true
	elseif part == "door_lf_dummy" and lfd ~= 0 and lfd ~= 1 then
		returnVal = true
	elseif part == "door_rf_dummy" and rfd ~= 0 and rfd ~= 1 then
		returnVal = true
	elseif part == "door_lr_dummy" and lrd ~= 0 and lrd ~= 1 then
		returnVal = true
	elseif part == "door_rr_dummy" and rrd ~= 0 and rrd ~= 1 then
		returnVal = true
	elseif part == "bonnet_dummy" and bonnet ~= 0 and bonnet ~= 1 then
		returnVal = true
	elseif part == "boot_dummy" and boot ~= 0 and boot ~= 1 then
		returnVal = true
	elseif part == "bump_front_dummy" and getVehiclePanelState(v, 5) ~= 0 then
		returnVal = true
	elseif part == "bump_rear_dummy" and getVehiclePanelState(v, 6) ~= 0 then
		returnVal = true
	elseif part == "windscreen_dummy" and getVehiclePanelState(v, 4) ~= 0 then
		returnVal = true
	elseif getNameFromPart(part) == "Roda dianteira" and ((lf ~= 0) or (rf ~= 0)) then
		returnVal = true
	elseif getNameFromPart(part) == "Roda traseira" and ((lb ~= 0) or (rb ~= 0)) then
		returnVal = true
	end
	return returnVal
end
local function getPartPosition(element, part)
	local x, y, z = false, nil, nil
	if getElementType(element) == "vehicle" then
		--[[if part == "bump_front_dummy" then
			xw, yw, zw = getVehicleComponentPosition(element, "wheel_rf_dummy", "world")
			x,y,z = getVehicleComponentPosition(element, part, "world")--getMatrixForward(getElementMatrix(element))
			x,y,z = x+(xw-x),y+(yw-y),z
		elseif part == "bump_rear_dummy" then
			xw, yw, zw = getVehicleComponentPosition(element, "wheel_rb_dummy", "world")
			x,y,z = getVehicleComponentPosition(element, part, "world")--getMatrixForward(getElementMatrix(element))
			x,y,z = x-(x-xw),y-(y-yw),z
		else]]
		x, y, z = getVehicleComponentPosition(element, part, "world")
		--end
	end
	return x,y,z
end
local function getPartImage(part)
	local returnVal = false
	part = getNameFromPart(part)
	if part then
		if string.find(part, "Parabrisas") then
			returnVal = "icons/windscreen.png"
		elseif string.find(part, "Puerta") then
			returnVal = "icons/door.png"
		elseif string.find(part, "Malas") then
			returnVal = "icons/trunk.png"
		elseif string.find(part, "Capo") then
			returnVal = "icons/hood.png"
		elseif string.find(part, "Parachoques delantero") then
			returnVal = "icons/frontb.png"
		elseif string.find(part, "Parahoques trasero") then
			returnVal = "icons/backb.png"
		elseif string.find(part, "Ruedas") then
			returnVal = "icons/wheel.png"
		end
	end
	return returnVal
end
local overPart = nil
local vehicleRepair = nil
local thePartName = false
addEventHandler("onClientRender", getRootElement(), function()
	--if not isElementWithinFixerColshape(localPlayer) then return end
	

	local vehicleTable = getElementsByType("vehicle", getRootElement(), true)

	if isTimer(repairTimer) then
		remaining, executesRemaining, totalExecutes = getTimerDetails(repairTimer)
		remaining = remaining / 1000
		dxDrawText(remaining,0,0,0,0)
		dxDrawRectangle(sx / 2 - 100,sy - 60,200,30,tocolor(0,0,0,200))
		dxDrawRectangle(sx / 2 - 100,sy - 60,200 - 200 * (remaining/(repairTime/1000)),30,tocolor(255,0,0,200))
		if thePartName then
			dxDrawText(thePartName,sx / 2 - dxGetTextWidth(thePartName,1.5)/2,sy - 60,0,0,tocolor(255,255,255,255),1.5)
		end
	end
	
	local cx, cy = getCursorPosition()
	if cx then
		cx, cy = cx*sx, cy*sy
	end
	overPart = nil
	local xov, yov, zov = nil, nil, nil
	
	if isPedInVehicle(localPlayer) then return end
	if exports.factions:isPlayerInFaction(localPlayer, 3) then
		 
    --if exports.exg_dashboard:isPlayerInFaction(thePlayer, 11) then return end
	local px, py, pz = getElementPosition(localPlayer)

	for kveh, v in pairs(vehicleTable) do
		local engx, engy = 0, 0
		local engrx, engry, engrz = 0, 0
		if getElementData(v, "repairingAlready") ~= true and not isVehicleBlown(v) then --and isElementWithinFixerColshape(v) then
			local components = getVehicleComponents(v)
			for k in pairs(components) do
				if getNameFromPart(k) then
					local x, y, z = getPartPosition(v, k)--getVehicleComponentPosition(v, k, "world")
					if x then
						local scx, scy = getScreenFromWorldPosition(x,y,z,0,false)
						if getNameFromPart(k) == "Capo" and scx and not engineBackVeh[getElementModel(v)] then
							engx, engy = scx, scy+(80*scmp)
							engrx, engry, engrz = x,y,z+0.5
						--elseif getNameFromPart(k) == "Motorháztető" and scx and engineBackVeh[getElementModel(v)] then
						--	engx, engy = scx, scy+(80*scmp)
						end

						if getDistanceBetweenPoints3D(px, py, pz, x,y,z) < 2.3 then
							local scx, scy = getScreenFromWorldPosition(x,y,z,0,false)
							if scx then
								if hasPartGotProblem(v, k) then
									if cx then
										if isInBoxEdited(cx, cy, scx-(30*scmp), scy-(10*scmp), (120*scmp), (dxGetFontHeight(1.2*scmp, "arial")+(40*scmp))) then
											if overPart then
												--if getDistanceBetweenPoints3D(xov, yov, zov, getElementPosition(localPlayer)) > getDistanceBetweenPoints3D(x, y, z, getElementPosition(localPlayer)) then
												--	overPart = k
												--	xov, yov, zov = x,y,z
												--end
											else
												overPart = k
												vehicleRepair = v
												xov, yov, zov = x,y,z
											end
										end
									end
									if cx then
										if isInBoxEdited(cx, cy, scx-(30*scmp), scy-(10*scmp), (120*scmp), (dxGetFontHeight(1.2*scmp, "arial")+(40*scmp))) and overPart == k then
											dxDrawRectangle(scx-(30*scmp), scy-(10*scmp), dxGetTextWidth(getNameFromPart(k), 1.2*scmp, "arial")+(40*scmp), (dxGetFontHeight(1.2*scmp, "arial")+(20*scmp)), tocolor(255,114,0, 230))
											dxDrawText(getNameFromPart(k), scx, scy, scx+dxGetTextWidth(getNameFromPart(k), 1.2*scmp, "arial"), scy+(50*scmp), tocolor(255,255,255), 1.2*scmp, "arial", "center")
										else
											dxDrawRectangle(scx-(30*scmp), scy-(10*scmp), dxGetTextWidth(getNameFromPart(k), 1.2*scmp, "arial")+(40*scmp), (dxGetFontHeight(1.2*scmp, "arial")+(20*scmp)), tocolor(255,114,0, 160))
											dxDrawText(getNameFromPart(k), scx, scy, scx+dxGetTextWidth(getNameFromPart(k), 1.2*scmp, "arial"), scy+(50*scmp), tocolor(255,255,255), 1.2*scmp, "arial", "center")
										end
									else
										dxDrawRectangle(scx-(30*scmp), scy-(10*scmp), dxGetTextWidth(getNameFromPart(k), 1.2*scmp, "arial")+(40*scmp), (dxGetFontHeight(1.2*scmp, "arial")+(20*scmp)), tocolor(255,114,0, 160))
										dxDrawText(getNameFromPart(k), scx, scy, scx+dxGetTextWidth(getNameFromPart(k), 1.2*scmp, "arial"), scy+(50*scmp), tocolor(255,255,255), 1.2*scmp, "arial", "center")
									end
									local r,g,b = 255,255,255
									if getPartImage(k) == "icons/trunk.png" or getPartImage(k) == "icons/door.png" or getPartImage(k) == "icons/hood.png" or getPartImage(k) == "icons/frontb.png" or getPartImage(k) == "icons/backb.png" then
										r,g,b = getVehicleColor(v, true)
									end
									dxDrawImage(scx-(25*scmp), scy, (20*scmp), (20*scmp), getPartImage(k),0,0,0,tocolor(r,g,b,255))
								end
							end
						end
					end
				end
			end
			local vx, vy, vz = getElementPosition(v)
			local m = getElementMatrix(v)
			
			local x, y, z = getPartPosition(v, "bonnet_dummy")
			if x and not engineBackVeh[getElementModel(v)] then
				engx, engy = getScreenFromWorldPosition(x,y,z,0,false)
				if engy then
					 engy = engy  + (80*scmp)
				end
			end
			if (engx == 0 and engy == 0) then
				engx, engy = getScreenFromWorldPosition((-m[2][1])+vx,(-m[2][2])+vy,m[2][3]+vz,0,false)
				engrx, engry, engrz = ((-m[2][1])*2)+vx,((-m[2][2])*2)+vy,((m[2][3])*2)+vz
			end
			if getVehicleType(v) ~= "Automobile" then
				engx, engy = getScreenFromWorldPosition((m[4][1]),(m[4][2]),m[4][3],0,false)
				engrx, engry, engrz = (m[4][1]),(m[4][2]),(m[4][3])
			end
			--if (((getVehicleDoorOpenRatio(v, 0) > 0.7 or getVehicleDoorState(v, 0) == 4) and not engineBackVeh[getElementModel(v)]) or ((getVehicleDoorOpenRatio(v, 1) > 0.7 or getVehicleDoorState(v, 1) == 4) and engineBackVeh[getElementModel(v)])) or getVehicleType(v) ~= "Automobile" then
				if (getElementHealth(v) < 700 or getElementHealth(v) == 0) then
					if engx and engrx and px then
						if getDistanceBetweenPoints3D(px, py, pz, engrx, engry, engrz) < 2.3 then
							if cx then
								if isInBoxEdited(cx, cy, engx-(30*scmp), engy-(10*scmp), dxGetTextWidth("Motor", 1.2*scmp, "arial")+(40*scmp), (dxGetFontHeight(1.2*scmp, "arial")+(20*scmp))) then
									if not overPart then
										overPart = "Motor"
										vehicleRepair = v
									end
									if overPart == "Motor" then
										dxDrawRectangle(engx-(30*scmp), engy-(10*scmp), dxGetTextWidth("Motor", 1.2*scmp, "arial")+(40*scmp), (dxGetFontHeight(1.2*scmp, "arial")+(20*scmp)), tocolor(255,114,0, 230))
										dxDrawText("Motor", engx, engy, engx+dxGetTextWidth("Motor", 1.2*scmp, "arial"), engy+(50*scmp), tocolor(255,255,255), 1.2*scmp, "arial", "center")
									else
										dxDrawRectangle(engx-(30*scmp), engy-(10*scmp), dxGetTextWidth("Motor", 1.2*scmp, "arial")+(40*scmp), (dxGetFontHeight(1.2*scmp, "arial")+(20*scmp)), tocolor(255,114,0, 160))
										dxDrawText("Motor", engx, engy, engx+dxGetTextWidth("Motor", 1.2*scmp, "arial"), engy+(50*scmp), tocolor(255,255,255), 1.2*scmp, "arial", "center")
									end
								else
									dxDrawRectangle(engx-(30*scmp), engy-(10*scmp), dxGetTextWidth("Motor", 1.2*scmp, "arial")+(40*scmp), (dxGetFontHeight(1.2*scmp, "arial")+(20*scmp)), tocolor(255,114,0, 160))
									dxDrawText("Motor", engx, engy, engx+dxGetTextWidth("Motor", 1.2*scmp, "arial"), engy+(50*scmp), tocolor(255,255,255), 1.2*scmp, "arial", "center")
								end
							else
								dxDrawRectangle(engx-(30*scmp), engy-(10*scmp), dxGetTextWidth("Motor", 1.2*scmp, "arial")+(40*scmp), (dxGetFontHeight(1.2*scmp, "arial")+(20*scmp)), tocolor(255,114,0, 160))
								--dxGetTextWidth ( string text, [float scale=1, mixed font="default", bool bColorCoded=false] )
								--dxDrawRectangle(engx-(10*scmp), engy-(10*scmp), (120*scmp), (dxGetFontHeight(1.2*scmp, "arial")+(20*scmp)), tocolor(255,114,0, 160))
								--dxDrawText("Motor", engx, engy, engx+(100*scmp), engy+(50*scmp), tocolor(255,255,255), 1.2*scmp, "arial", "center")
								
								dxDrawText("Motor", engx, engy, engx+dxGetTextWidth("Motor", 1.2*scmp, "arial"), engy+(50*scmp), tocolor(255,255,255), 1.2*scmp, "arial", "center")
								--dxGetTextWidth ( string text, [float scale=1, mixed font="default", bool bColorCoded=false] )
							end
							--dxDrawRectangle((engx+dxGetTextWidth("Motor", 1.2*scmp, "arial"))-(20*scmp), engy, (20*scmp), (20*scmp), tocolor(255,0,0, 255))
							dxDrawImage(engx-(25*scmp), engy, (20*scmp), (20*scmp), "icons/engine.png")
						end
					end
				end
			--end
		end
	end
	end
end)
local repairPart = nil
local vehicleRepairSave = nil


function teste(x,y,z)
			local soundEffect = playSound3D("repair.mp3",x,y,z,false)
			setSoundVolume(soundEffect,0.2)
end
addEvent("repairCar3", true)
addEventHandler("repairCar3", getRootElement(), teste)


addEventHandler("onClientClick", root, function(button, state)
	if state ~= "down" or repairPart or not overPart then return end
	if isPedInVehicle(localPlayer) then return end

	--if exports.exg_dashboard:isPlayerInFaction(thePlayer, 11) then return end
		if exports.factions:isPlayerInFaction(localPlayer, 3) then
		if 0==1 then
		outputChatBox("#FF0000[ERROR Mecanico] #FFFFFFTu maleta está demasiado lejos para reparar el vehículo.", 255,255,255, true)
		else
	if overPart then
		local cost = defPrice
		local partTableID = {["windscreen_dummy"] = 4, ["bump_front_dummy"] = 5, ["bump_rear_dummy"] = 6, ["bonnet_dummy"] = 0, ["boot_dummy"] = 1, ["door_lf_dummy"] = 2, ["door_rf_dummy"] = 3, ["door_lr_dummy"] = 4, ["door_rr_dummy"] = 5}
		
		
		if string.find(overPart, "windscreen") or string.find(overPart, "bump") then
			local partDam = getVehiclePanelState(vehicleRepair, partTableID[overPart])
			cost = priceTable[overPart][partDam]
		elseif string.find(overPart, "wheel") then
			local fl, rl, fr, rr = getVehicleWheelStates(vehicleRepair)
			if string.find(overPart, "rf") then--jobb első
				cost = priceTable[overPart][fr]
			elseif string.find(overPart, "lf") then--bal első
				cost = priceTable[overPart][fl]
			elseif string.find(overPart, "rb") then--jobb hátsó
				cost = priceTable[overPart][rr]
			elseif string.find(overPart, "lb") then--bal hátsó
				cost = priceTable[overPart][rl]
			elseif string.find(overPart, "front") then--első
				cost = priceTable[overPart][fl]
			elseif string.find(overPart, "rear") then--hátsó
				cost = priceTable[overPart][rl]
			end
			--front left, rear left, front right, rear right)
		elseif overPart == "Motor" then
			if getElementHealth(vehicleRepair) < 1000 and getElementHealth(vehicleRepair) > 749 then
				cost = priceTable["Motor"][1]
			elseif getElementHealth(vehicleRepair) < 750 and getElementHealth(vehicleRepair) > 499 then
				cost = priceTable["Motor"][2]
			elseif getElementHealth(vehicleRepair) < 500 and getElementHealth(vehicleRepair) > 249 then
				cost = priceTable["Motor"][3]
			elseif getElementHealth(vehicleRepair) < 250 and getElementHealth(vehicleRepair) > 0 then
				cost = priceTable["Motor"][4]
			else
				cost = priceTable["Motor"][5]
			end
		else
			local partDam = getVehicleDoorState(vehicleRepair, partTableID[overPart])
			cost = priceTable[overPart][partDam]
		end
		--[[
		if tonumber(getElementData(localPlayer, "char:money")) < cost then
			outputChatBox("No tienes suficiente dinero para arreglarlo. necesario: $"..tostring(cost))
			return
		end]]--
	
		repairPart = overPart
		thePartName = getNameFromPart(overPart) or overPart
		vehicleRepairSave = vehicleRepair
		--setElementData(localPlayer, "playerAnimation", true)


		setElementData(vehicleRepairSave, "repairingAlready", true)

			triggerServerEvent("repairCar2", localPlayer)
		repairTimer = setTimer(function()
			--stopSound(soundEffect)
			
			triggerServerEvent("repairCar", localPlayer, repairPart, vehicleRepairSave, cost)
			

	
			repairPart = nil
			setTimer(function()
				setElementData(vehicleRepairSave, "repairingAlready", false)
			end, 1000, 1)
		end, repairTime, 1)
	end
	end
	end
end)

--[[
addEventHandler("onClientElementDataChange", getRootElement(), function(dataName)
	if getElementType(source) == "player" and (dataName == "playerAnimation" and getElementData(source, dataName) == true) then
		if source == localPlayer then
			setElementFrozen(localPlayer, true)
		end
		setPedAnimation(source, "BOMBER","BOM_Plant_Loop", repairTime, true, false, false)
		--exports['evrpsound-system']:playElementSound(source, repairSoundPath, false,0,12,1)
		setTimer(function(elementEdited)
			if elementEdited == localPlayer then
				setElementFrozen(localPlayer, false)
			end
			setPedAnimation(elementEdited, "BOMBER","BOM_Plant_2Idle", -1, false, false, true)
			setElementData(elementEdited, "playerAnimation", false)
			setTimer(function(elementEdited)
				setPedAnimation(elementEdited)
			end, 1000, 1, elementEdited)
		end, repairTime, 1, source)
	end
end)]]--