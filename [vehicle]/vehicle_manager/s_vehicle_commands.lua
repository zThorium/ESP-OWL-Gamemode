local mysql = exports.mysql

armoredCars = { [427]=true, [528]=true, [432]=true, [601]=true, [428]=true } -- Enforcer, FBI Truck, Rhino, SWAT Tank, Securicar
totalTempVehicles = 0
respawnTimer = nil
local bikeCol = createColPolygon(1861.970703125, -1835.9697265625, 1861.97265625, -1854.5107421875, 1883.892578125, -1854.5595703125, 1883.744140625, -1863.375,1901.1484375, -1858.3095703125, 1890.7646484375, -1840.1259765625, 1861.9765625, -1835.958984375)
local wangs1Col = createColPolygon(2110.2470703125, -2124.2861328125, 2160.1142578125, -2141.283203125, 2143.494140625, -2162.3798828125, 2134.7724609375, -2173.365234375, 2111.951171875, -2165.77734375, 2110.306640625, -2124.455078125)
local wangs2Col = createColPolygon(2138.9677734375, -1125.140625, 2138.65234375, -1155.388671875, 2124.37890625, -1155.615234375, 2123.4560546875, -1160.6806640625, 2114.5341796875, -1160.771484375,  2117.6103515625, -1119.68359375, 2138.9677734375, -1125.140625)
local wangs3Col = createColPolygon(563.21484375, -1256.9873046875, 571.3759765625, -1294.1748046875, 511.19921875, -1295.34375, 549.2548828125, -1261.8525390625, 563.1650390625, -1257.6083984375)

-- WORKAROUND ABIT
function getVehicleName(vehicle)
	return exports.global:getVehicleName(vehicle)
end

function respawnTheVehicle(vehicle)
	setElementCollisionsEnabled( vehicle, true )
	respawnVehicle( vehicle )

	if armoredCars[ getElementModel( vehicle ) ] or getElementData(vehicle, "bulletproof") == 1 then
		setVehicleDamageProof(vehicle, true)
	else
		setVehicleDamageProof(vehicle, false)
	end
end
--MAXIME
function reloadVehicleByAdmin(thePlayer, commandName, vehID)
	if exports.integration:isPlayerTrialAdmin( thePlayer ) or exports.integration:isPlayerVehicleConsultant(thePlayer) then
		local veh = false
		if not vehID or not tonumber(vehID) or (tonumber(vehID) % 1 ~= 0 ) then
			veh = getPedOccupiedVehicle(thePlayer) or false
			if veh then
				vehID = getElementData(veh, "dbid") or false
				if not vehID then
					outputChatBox( "Debes estar en un vehículo.", thePlayer, 255, 194, 14)
					outputChatBox("O usa SYNTAX: /"..commandName.." [ID del vehículo]", thePlayer, 255, 194, 14)
					return false
				end
			end
		end

		if not vehID or not tonumber(vehID) or (tonumber(vehID) % 1 ~= 0 ) then
			outputChatBox( "Debes estar en un vehículo.", thePlayer, 255, 194, 14)
			outputChatBox("O usa SYNTAX: /"..commandName.." [ID del vehículo]", thePlayer, 255, 194, 14)
			return false
		end

		--[[
		local vehs = getElementsByType("vehicle")
		for i, v in pairs (vehs) do
			if getElementData(v,"dbid") == tonumber(vehID) then
				destroyElement(theVehicle)
				break
			end
		end
		]]

		exports.vehicle:reloadVehicle(tonumber(vehID))
		outputChatBox("[VEHICLE MANAGER] El vehículo ID#"..vehID.." fue recargado.", thePlayer)

		addVehicleLogs(tonumber(vehID), commandName, thePlayer)
		exports.logs:dbLog(thePlayer, 4, { veh, thePlayer }, commandName)
		return true
	end
end
addCommandHandler("regargarveh", reloadVehicleByAdmin)
addCommandHandler("recargarvehiculo", reloadVehicleByAdmin)


function togVehReg(admin, command, target, status)
	if (exports.integration:isPlayerTrialAdmin(admin)) then
		if not (target) or not (status) then
			outputChatBox("SYNTAX: /" .. command .. " [Veh ID] [0- Apagado, 1- Encendido]", admin, 255, 194, 14)
		else
			local username = getPlayerName(admin):gsub("_"," ")
			local pv = exports.pool:getElement("vehicle", tonumber(target))

			if (pv) then
					local vid = getElementData(pv, "dbid")
					local stat = tonumber(status)
					if isElementAttached(pv) then
					detachElements(pv)
					end
					if (stat == 0) then
						mysql:query_free("UPDATE vehicles SET registered = '0' WHERE id='" .. mysql:escape_string(vid) .. "'")
						exports.anticheat:changeProtectedElementDataEx(pv, "registered", 0)
						outputChatBox("Ha cambiado el registro a no registrado en el vehículo #" .. vid .. ".", admin)

						addVehicleLogs(getElementData(pv, "dbid"), command.." OFF", admin)
						exports.logs:dbLog(admin, 4, { pv, admin }, command.." OFF")
					elseif (stat == 1) then
						mysql:query_free("UPDATE vehicles SET registered = '1' WHERE id='" .. mysql:escape_string(vid) .. "'")
						exports.anticheat:changeProtectedElementDataEx(pv, "registered", 1)
						outputChatBox("Ha cambiado el registro a registrado en el vehículo #" .. vid .. ".", admin)

						addVehicleLogs(getElementData(pv, "dbid"), command.." ON", admin)
						exports.logs:dbLog(admin, 4, { pv, admin }, command.." ON")
					end
				else
					outputChatBox("Ese no es un vehículo.", admin, 255, 194, 14)
				end
			end
		end
	end
addCommandHandler("togreg", togVehReg)

function togVehPlate(admin, command, target, status)
	if (exports.integration:isPlayerTrialAdmin(admin)) then
		if not (target) or not (status) then
			outputChatBox("SYNTAX: /" .. command .. " [Veh ID] [0- Apagado, 1- Encendido]", admin, 255, 194, 14)
		else
			local username = getPlayerName(admin):gsub("_"," ")
			local pv = exports.pool:getElement("vehicle", tonumber(target))

			if (pv) then
					local vid = getElementData(pv, "dbid")
					local stat = tonumber(status)
					if isElementAttached(pv) then
					detachElements(pv)
					end
					if (stat == 0) then
						mysql:query_free("UPDATE vehicles SET show_plate = '0' WHERE id='" .. mysql:escape_string(vid) .. "'")

						exports.anticheat:changeProtectedElementDataEx(pv, "show_plate", 0)

						outputChatBox("Has cambiado las placas a apagado, en el vehículo #" .. vid .. ".", admin)

						addVehicleLogs(getElementData(pv, "dbid"), command.." OFF", admin)
						exports.logs:dbLog(admin, 4, { pv, admin }, command.." OFF")
					elseif (stat == 1) then
						mysql:query_free("UPDATE vehicles SET show_plate = '1' WHERE id='" .. mysql:escape_string(vid) .. "'")
						exports.anticheat:changeProtectedElementDataEx(pv, "show_plate", 1)
						outputChatBox("Ha activado las placas, en el vehículo #" .. vid .. ".", admin)

						addVehicleLogs(getElementData(pv, "dbid"), command.." ON", admin)
						exports.logs:dbLog(admin, 4, { pv, admin }, command.." ON")
					end
				else
					outputChatBox("Ese no es un vehiculo.", admin, 255, 194, 14)
				end
			end
		end
	end
addCommandHandler("togmatricula", togVehPlate)

function togVehVin(admin, command, target, status)
	if (exports.integration:isPlayerTrialAdmin(admin)) then
		if not (target) or not (status) then
			outputChatBox("SYNTAX: /" .. command .. " [Veh ID] [0- Apagado, 1- Encendido]", admin, 255, 194, 14)
		else
			local username = getPlayerName(admin):gsub("_"," ")
			local pv = exports.pool:getElement("vehicle", tonumber(target))

			if (pv) then
					local vid = getElementData(pv, "dbid")
					local stat = tonumber(status)
					if isElementAttached(pv) then
					detachElements(pv)
					end
					if (stat == 0) then
						mysql:query_free("UPDATE vehicles SET show_vin = '0' WHERE id='" .. mysql:escape_string(vid) .. "'")

						exports.anticheat:changeProtectedElementDataEx(pv, "show_vin", 0)

						outputChatBox("Has cambiado el VIN a apagado, en el vehículo #" .. vid .. ".", admin)

						addVehicleLogs(getElementData(pv, "dbid"), command.." OFF", admin)
						exports.logs:dbLog(admin, 4, { pv, admin }, command.." OFF")
					elseif (stat == 1) then
						mysql:query_free("UPDATE vehicles SET show_vin = '1' WHERE id='" .. mysql:escape_string(vid) .. "'")
						exports.anticheat:changeProtectedElementDataEx(pv, "show_vin", 1)

						outputChatBox("Has cambiado el VIN a activado, en vehículo #" .. vid .. ".", admin)

						addVehicleLogs(getElementData(pv, "dbid"), command.." ON", admin)
						exports.logs:dbLog(admin, 4, { pv, admin }, command.." ON")
					end
				else
					outputChatBox("Ese no es un vehículo.", admin, 255, 194, 14)
				end
			end
		end
	end
addCommandHandler("togvin", togVehVin)

function spinCarOut(thePlayer, commandName, targetPlayer, round)
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) then
		if not targetPlayer then
			outputChatBox("SYNTAX: /" .. commandName .. " [ID / Nombre Parcial] [Rondas]", thePlayer, 255, 194, 14)
		else
			if not round or not tonumber(round) or tonumber( round ) % 1 ~= 0 or tonumber( round ) > 100 then
				round = 1
			end
			local targetPlayer = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			local targetVehicle = getPedOccupiedVehicle(targetPlayer)
			if targetVehicle == false then
				outputChatBox("Este jugador no está en un vehículo!", thePlayer, 255, 0, 0)
			else
				outputChatBox("Has girado el vehículo de "..getPlayerName(targetPlayer).." unas "..tostring(round).." ronda(s).", thePlayer)
				local delay = 50
				setTimer(function()
					setElementAngularVelocity ( targetVehicle, 0, 0, 0.2 )
					delay = delay + 50
				end, delay, tonumber(round))
			end
		end
	end
end
-- addCommandHandler("spinout", spinCarOut, false, false)

-- /unflip
function unflipCar(thePlayer, commandName, targetPlayer)
	if exports.integration:isPlayerTrialAdmin(thePlayer) or exports.factions:isPlayerInFaction(thePlayer, 4) or exports.integration:isPlayerSupporter(thePlayer) then
		if not targetPlayer or not exports.integration:isPlayerTrialAdmin(thePlayer) then
			if not (isPedInVehicle(thePlayer)) then
				outputChatBox("No estás en el vehículo.", thePlayer, 255, 0, 0)
			else
				local veh = getPedOccupiedVehicle(thePlayer)
				local rx, ry, rz = getVehicleRotation(veh)
				setVehicleRotation(veh, 0, ry, rz)
				outputChatBox("Su coche fue desvolcado!", thePlayer, 0, 255, 0)
				addVehicleLogs(getElementData(veh, "dbid"), commandName, thePlayer)
			end
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				local username = getPlayerName(thePlayer):gsub("_"," ")

				if (logged==0) then
					outputChatBox("El jugador no ha iniciado sesión.", thePlayer, 255, 0, 0)
				else
					local pveh = getPedOccupiedVehicle(targetPlayer)
					if pveh then
						local rx, ry, rz = getVehicleRotation(pveh)
						setVehicleRotation(pveh, 0, ry, rz)
						if getElementData(thePlayer, "hiddenadmin") == 1 then
							outputChatBox("Su coche fue desinflado por un Admin Oculto.", targetPlayer, 0, 255, 0)
						else
							outputChatBox("Tu coche fue volcado por " .. username .. ".", targetPlayer, 0, 255, 0)
						end
						outputChatBox("Usted desvolcó el vehículo de " .. targetPlayerName:gsub("_"," ") .. ".", thePlayer, 0, 255, 0)

						addVehicleLogs(getElementData(pveh, "dbid"), commandName, thePlayer)
						exports.logs:dbLog(thePlayer, 4, { pveh, thePlayer }, command)
					else
						outputChatBox(targetPlayerName:gsub("_"," ") .. " no está en un vehículo.", thePlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("desvolcar", unflipCar, false, false)

-- /flip
function flipCar(thePlayer, commandName, targetPlayer)
	if exports.integration:isPlayerTrialAdmin(thePlayer) or exports.factions:isPlayerInFaction(thePlayer, 4) or exports.integration:isPlayerSupporter(thePlayer) then -- SFTR, working on motorbikes etc
		if not targetPlayer or not exports.integration:isPlayerTrialAdmin(thePlayer) then
			if not (isPedInVehicle(thePlayer)) then
				outputChatBox("No estas en un vehículo.", thePlayer, 255, 0, 0)
			else
				local veh = getPedOccupiedVehicle(thePlayer)
				local rx, ry, rz = getVehicleRotation(veh)
				setVehicleRotation(veh, 180, ry, rz)
				fixVehicle (veh)
				outputChatBox("Su coche fue volcado!", thePlayer, 0, 255, 0)
				addVehicleLogs(getElementData(veh, "dbid"), commandName, thePlayer)
			end
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				local username = getPlayerName(thePlayer):gsub("_"," ")

				if (logged==0) then
					outputChatBox("El jugador no ha iniciado sesión.", thePlayer, 255, 0, 0)
				else
					local pveh = getPedOccupiedVehicle(targetPlayer)
					if pveh then
						local rx, ry, rz = getVehicleRotation(pveh)
						setVehicleRotation(pveh, 180, ry, rz)
						if getElementData(thePlayer, "hiddenadmin") == 1 then
							outputChatBox("Su coche fue volteado por un Admin oculto.", targetPlayer, 0, 255, 0)
						else
							outputChatBox("Su coche fue volcado por " .. username .. ".", targetPlayer, 0, 255, 0)
						end
						outputChatBox("Usted volcó el vehículo " .. targetPlayerName:gsub("_"," ") .. ".", thePlayer, 0, 255, 0)

						addVehicleLogs(getElementData(pveh, "dbid"), commandName, thePlayer)
						exports.logs:dbLog(thePlayer, 4, { pveh, thePlayer }, command)
					else
						outputChatBox(targetPlayerName:gsub("_"," ") .. " no está en un vehículo.", thePlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("volcar", flipCar, false, false)

-- /unlockcivcars
function unlockAllCivilianCars(thePlayer, commandName)
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) then
		local count = 0
		for key, value in ipairs(exports.pool:getPoolElementsByType("vehicle")) do
			if (isElement(value)) and (getElementType(value)) then
				local id = getElementData(value, "dbid")

				if (id) and (id>=0) then
					local owner = getElementData(value, "owner")
					if (owner==-2) then
						setVehicleLocked(value, false)
						addVehicleLogs(id, commandName, thePlayer)
						count = count + 1
					end
				end
			end
		end
		outputChatBox("Ha abierto " .. count .. " vehículos civiles.", thePlayer, 255, 194, 14)
		--addVehicleLogs(getElementData(pveh, "dbid"), commandName, thePlayer)
		exports.logs:dbLog(thePlayer, 4, { thePlayer }, commandName)
	end
end
addCommandHandler("abrircivvehs", unlockAllCivilianCars, false, false)

-- /veh
local leadplus = { [425] = true, [520] = true, [447] = true, [432] = true, [444] = true, [556] = true, [557] = true, [441] = true, [464] = true, [501] = true, [465] = true, [564] = true, [476] = true }
function createTempVehicle(thePlayer, commandName, vehShopID)
	if exports["integration"]:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerScripter(thePlayer) then
		if not vehShopID or not tonumber(vehShopID) then
			outputChatBox("SYNTAX: /" .. commandName .. " [ID del vehlib] [color1] [color2]", thePlayer, 255, 194, 14)
			outputChatBox("SYNTAX: /vehlib para las IDs.", thePlayer, 255, 194, 14)
			return false
		else
			vehShopID = tonumber(vehShopID)
		end

		local vehShopData = getInfoFromVehShopID(vehShopID)
		if not vehShopData then
			outputDebugString("VEHICLE MANAGER / createTempVehicle / FAILED TO FETCH VEHSHOP DATA")
			outputChatBox("SYNTAX: /" .. commandName .. " [ID del vehlib] [color1] [color2]", thePlayer, 255, 194, 14)
			outputChatBox("SYNTAX: /vehlib para las IDs.", thePlayer, 255, 194, 14)
			return false
		end


		local vehicleID = vehShopData.vehmtamodel
		if not vehicleID or not tonumber(vehicleID) then -- vehicle is specified as name
			outputDebugString("VEHICLE MANAGER / createTempVehicle / FAILED TO FETCH VEHSHOP DATA")
			outputChatBox("Ops..algo salió mal.", thePlayer, 255, 0, 0)
			return false
		else
			vehicleID = tonumber(vehicleID)
		end

		local r = getPedRotation(thePlayer)
		local x, y, z = getElementPosition(thePlayer)
		x = x + ( ( math.cos ( math.rad ( r ) ) ) * 5 )
		y = y + ( ( math.sin ( math.rad ( r ) ) ) * 5 )


		local plate = tostring( getElementData(thePlayer, "account:id") )
		if #plate < 8 then
			plate = " " .. plate
			while #plate < 8 do
				plate = string.char(math.random(string.byte('A'), string.byte('Z'))) .. plate
				if #plate < 8 then
				end
			end
		end

		local veh = createVehicle(vehicleID, x, y, z, 0, 0, r, plate)

		if not (veh) then
			outputDebugString("VEHICLE MANAGER / createTempVehicle / FAILED TO FETCH VEHSHOP DATA")
			outputChatBox("Ops.. algo salió mal.", thePlayer, 255, 0, 0)
			return false
		end

		if (armoredCars[vehicleID]) then
			setVehicleDamageProof(veh, true)
		end

		totalTempVehicles = totalTempVehicles + 1
		local dbid = (-totalTempVehicles)
		exports.pool:allocateElement(veh, dbid)

		--setVehicleColor(veh, col1, col2, col1, col2)

		setElementInterior(veh, getElementInterior(thePlayer))
		setElementDimension(veh, getElementDimension(thePlayer))

		setVehicleOverrideLights(veh, 1)
		setVehicleEngineState(veh, false)
		setVehicleFuelTankExplodable(veh, false)
		setVehicleVariant(veh, exports.vehicle:getRandomVariant(getElementModel(veh)))

		exports.anticheat:changeProtectedElementDataEx(veh, "dbid", dbid)
		exports.anticheat:setEld( veh, "fuel", exports.vehicle_fuel:getMaxFuel(veh) )
		exports.anticheat:setEld(veh, "Impounded", 0, 'all')
		exports.anticheat:changeProtectedElementDataEx(veh, "engine", 0, false)
		exports.anticheat:changeProtectedElementDataEx(veh, "faction", -1)
		exports.anticheat:changeProtectedElementDataEx(veh, "owner", -1, false)
		exports.anticheat:changeProtectedElementDataEx(veh, "job", 0, false)
		exports.anticheat:changeProtectedElementDataEx(veh, "handbrake", 0, true)
		exports['vehicle-interiors']:add( veh )

		--Custom properties
		exports.anticheat:changeProtectedElementDataEx(veh, "brand", vehShopData.vehbrand, true)
		exports.anticheat:changeProtectedElementDataEx(veh, "maximemodel", vehShopData.vehmodel, true)
		exports.anticheat:changeProtectedElementDataEx(veh, "year", vehShopData.vehyear, true)
		exports.anticheat:changeProtectedElementDataEx(veh, "vehicle_shop_id", vehShopData.id, true)
		exports.anticheat:changeProtectedElementDataEx(veh, "vDoorType", vehShopData.doortype, true)

		--Load Handlings
		loadHandlingToVeh(veh, vehShopData.handling)

		exports.logs:dbLog(thePlayer, 6, thePlayer, "VEH ".. vehShopID .. " created with ID " .. dbid)
		outputChatBox(getVehicleName(veh) .. " generado con ID Temporal " .. dbid .. ".", thePlayer, 255, 194, 14)
	end
end
addCommandHandler("veh", createTempVehicle, false, false)

-- /oldcar
function getOldCarID(thePlayer, commandName, targetPlayerName)
	local showPlayer = thePlayer
	if exports.integration:isPlayerTrialAdmin(thePlayer) and targetPlayerName then
		targetPlayer = exports.global:findPlayerByPartialNick(thePlayer, targetPlayerName)
		if targetPlayer then
			if getElementData(targetPlayer, "loggedin") == 1 then
				thePlayer = targetPlayer
			else
				outputChatBox("El jugador no ha iniciado sesión..", thePlayer, 255, 0, 0)
				return
			end
		else
			return
		end
	end

	local oldvehid = getElementData(thePlayer, "lastvehid")

	if not (oldvehid) then
		outputChatBox("Aún no se ha subido a un vehículo.", showPlayer, 255, 0, 0)
	else
		outputChatBox("ID de vehículo anterior: " .. tostring(oldvehid) .. ".", showPlayer, 255, 194, 14)
		exports.anticheat:changeProtectedElementDataEx(showPlayer, "vehicleManager:oldCar", oldvehid, false)
	end
end
addCommandHandler("antveh", getOldCarID, false, false)

-- /thiscar
function getCarID(thePlayer, commandName)
	local veh = getPedOccupiedVehicle(thePlayer)

	if (veh) then
		local dbid = getElementData(veh, "dbid")
		outputChatBox("ID actual del vehículo: " .. dbid, thePlayer, 255, 194, 14)
		exports.anticheat:changeProtectedElementDataEx(showPlayer, "vehicleManager:oldCar", dbid, false)
	else
		outputChatBox("No estás en un vehículo.", thePlayer, 255, 0, 0)
	end
end
addCommandHandler("esteveh", getCarID, false, false)

-- /gotocar
function gotoCar(thePlayer, commandName, id)
	if exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerSupporter(thePlayer) or exports.integration:isPlayerScripter(thePlayer) or exports.integration:isPlayerVehicleConsultant(thePlayer) then
		if not (id) then
			outputChatBox("SYNTAX: /" .. commandName .. " [id]", thePlayer, 255, 194, 14)
		else
			if type(id) == 'string' and id == 'old' then
				id = getElementData(thePlayer, "lastvehid")
			end

			local theVehicle = exports.pool:getElement("vehicle", tonumber(id))
			if theVehicle then
				local rx, ry, rz = getVehicleRotation(theVehicle)
				local x, y, z = getElementPosition(theVehicle)
				x = x + ( ( math.cos ( math.rad ( rz ) ) ) * 5 )
				y = y + ( ( math.sin ( math.rad ( rz ) ) ) * 5 )

				setElementPosition(thePlayer, x, y, z)
				setPedRotation(thePlayer, rz)
				setElementInterior(thePlayer, getElementInterior(theVehicle))
				setElementDimension(thePlayer, getElementDimension(theVehicle))

				exports.logs:dbLog(thePlayer, 6, theVehicle, commandName)

				addVehicleLogs(id, commandName, thePlayer)

				outputChatBox("Te has teletransportado al vehículo " .. id .. ".", thePlayer, 100, 255, 100)
			else
				outputChatBox("ID de vehículo no válida.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("iravehiculo", gotoCar, false, false)
addCommandHandler("iraveh", gotoCar, false, false)

-- /getcar
function getCar(thePlayer, commandName, id)
	if exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerSupporter(thePlayer) or exports.integration:isPlayerScripter(thePlayer) or exports.integration:isPlayerVehicleConsultant(thePlayer) then
		if not (id) then
			outputChatBox("SYNTAX: /" .. commandName .. " [id]", thePlayer, 255, 194, 14)
		else
			if type(id) == 'string' and id == 'old' then
				id = getElementData(thePlayer, "lastvehid")
			end

			local theVehicle = exports.pool:getElement("vehicle", tonumber(id))
			if theVehicle then
				local r = getPedRotation(thePlayer)
				local x, y, z = getElementPosition(thePlayer)
				x = x + ( ( math.cos ( math.rad ( r ) ) ) * 5 )
				y = y + ( ( math.sin ( math.rad ( r ) ) ) * 5 )

				if	(getElementHealth(theVehicle)==0) then
					spawnVehicle(theVehicle, x, y, z, 0, 0, r)
				else
					setElementPosition(theVehicle, x, y, z)
					setVehicleRotation(theVehicle, 0, 0, r)
				end

				setElementInterior(theVehicle, getElementInterior(thePlayer))
				setElementDimension(theVehicle, getElementDimension(thePlayer))

				exports.logs:dbLog(thePlayer, 6, theVehicle, commandName)

				addVehicleLogs(id, commandName, thePlayer)

				outputChatBox("Vehículo " .. id .. " teletransportado a su ubicación.", thePlayer, 100, 255, 100)
			else
				outputChatBox("ID de vehículo no válida.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("traervehiculo", getCar, false, false)
addCommandHandler("traerveh", getCar, false, false)

-- This command teleports the specified vehicle to the specified player, /sendcar
function sendCar(thePlayer, commandName, id, toPlayer)
	if exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerSupporter(thePlayer) or exports.integration:isPlayerVehicleConsultant(thePlayer) then
		if not (id) or not (toPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [ID del vehículo] [ID del jugador]", thePlayer, 255, 194, 14)
		else
			local theVehicle = exports.pool:getElement("vehicle", tonumber(id))
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, toPlayer)
			if theVehicle then
				local r = getPedRotation(targetPlayer)
				local x, y, z = getElementPosition(targetPlayer)
				x = x + ( ( math.cos ( math.rad ( r ) ) ) * 5 )
				y = y + ( ( math.sin ( math.rad ( r ) ) ) * 5 )

				if	(getElementHealth(theVehicle)==0) then
					spawnVehicle(theVehicle, x, y, z, 0, 0, r)
				else
					setElementPosition(theVehicle, x, y, z)
					setVehicleRotation(theVehicle, 0, 0, r)
				end

				setElementInterior(theVehicle, getElementInterior(targetPlayer))
				setElementDimension(theVehicle, getElementDimension(targetPlayer))

				exports.logs:dbLog(thePlayer, 6, theVehicle, commandName.." to "..targetPlayerName)

				addVehicleLogs(id, commandName, thePlayer)

				outputChatBox("Vehículo teletransportado al jugador "..targetPlayerName, thePlayer, 255, 194, 14)
				if getElementData(thePlayer, "hiddenadmin") == 1 then
					outputChatBox("Un Admin Oculto te ha teletransportado un vehículo.", targetPlayer, 255, 194, 14)
				else
					outputChatBox(exports.global:getPlayerFullIdentity(thePlayer).." te ha teletransportado un vehículo.", targetPlayer, 255, 194, 14)
				end
			else
				outputChatBox("ID de vehículo no válida.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("mandarveh", sendCar, false, false)
addCommandHandler("mandarveha", sendCar, false, false)
addCommandHandler("mandarvehiculoa", sendCar, false, false)

function sendPlayerToVehicle(thePlayer, commandName, toPlayer, id)
	if exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerSupporter(thePlayer) then
		if not (id) or not (toPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [ID del jugador] [ID del jugador]", thePlayer, 255, 194, 14)
		else
			local theVehicle = exports.pool:getElement("vehicle", tonumber(id))
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, toPlayer)
			if theVehicle then

				local playerAdmLvl = getElementData( thePlayer, "admin_level" ) or 0
				local targetAdmLvl = getElementData( targetPlayer, "admin_level" ) or 0
				if (playerAdmLvl < targetAdmLvl) then
					outputChatBox("Enviando a "..targetPlayerName.." solicitud de teletransporte ya que son de mayor rango que tú.", thePlayer, 255, 194, 14)
					outputChatBox(getPlayerName(thePlayer):gsub("_", " ").." quiere teletransportarte a ellos. /atp para aceptar, /dtp para denegar.", targetPlayer, 255, 194, 14)
					setElementData(targetPlayer, "teleport:targetPlayer", thePlayer)
					return
				end

				local rx, ry, rz = getVehicleRotation(theVehicle)
				local x, y, z = getElementPosition(theVehicle)
				x = x + ( ( math.cos ( math.rad ( rz ) ) ) * 5 )
				y = y + ( ( math.sin ( math.rad ( rz ) ) ) * 5 )

				setElementPosition(targetPlayer, x, y, z)
				setPedRotation(targetPlayer, rz)
				setElementInterior(targetPlayer, getElementInterior(theVehicle))
				setElementDimension(targetPlayer, getElementDimension(theVehicle))

				exports.logs:dbLog(thePlayer, 6, theVehicle, commandName.." from "..targetPlayerName)

				addVehicleLogs(id, commandName, thePlayer)

				outputChatBox("Jugador "..targetPlayerName.." teletransportado al vehículo.", thePlayer, 255, 194, 14)
				if getElementData(thePlayer, "hiddenadmin") == 1 then
					outputChatBox("Un Admin Oculto te ha teletransportado a un vehículo.", targetPlayer, 255, 194, 14)
				else
					outputChatBox(exports.global:getPlayerFullIdentity(thePlayer).." te ha teletransportado a un vehículo.", targetPlayer, 255, 194, 14)
				end
			else
				outputChatBox("Invalid Vehicle ID.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("mandaraveh", sendPlayerToVehicle, false, false)

function getNearbyVehicles(thePlayer, commandName)
	if exports.integration:isPlayerTrialAdmin(thePlayer) then
		outputChatBox("Vehículo cercanos:", thePlayer, 255, 126, 0)
		local count = 0

		for index, nearbyVehicle in ipairs( exports.global:getNearbyElements(thePlayer, "vehicle") ) do
			local thisvehid = getElementData(nearbyVehicle, "dbid")
			if thisvehid then
				local vehicleID = getElementModel(nearbyVehicle)
				local vehicleName = getVehicleNameFromModel(vehicleID)
				local owner = getElementData(nearbyVehicle, "owner")
				local faction = getElementData(nearbyVehicle, "faction")
				count = count + 1

				local ownerName = ""

				if faction then
					if (faction>0) then
						local theTeam = exports.pool:getElement("team", faction)
						if theTeam then
							ownerName = getTeamName(theTeam)
						end
					elseif (owner==-1) then
						ownerName = "Admin veh temporal"
					elseif (owner>0) then
						ownerName = exports['cache']:getCharacterName(owner, true)
					else
						ownerName = "Civil"
					end
				else
					ownerName = "Concesionaria"
				end

				if (thisvehid) then
					outputChatBox("   " .. vehicleName .. " (" .. vehicleID ..") con ID: " .. thisvehid .. ". Dueño: " .. ownerName, thePlayer, 255, 126, 0)
				end
			end
		end

		if (count==0) then
			outputChatBox("   None.", thePlayer, 255, 126, 0)
		end
	end
end
addCommandHandler("vehiculoscercanos", getNearbyVehicles, false, false)
addCommandHandler("vehcerca", getNearbyVehicles, false, false)

function delNearbyVehicles(thePlayer, commandName)
	if exports.integration:isPlayerAdmin(thePlayer)  then
		outputChatBox("Borrando de vehículos cercanos:", thePlayer, 255, 126, 0)
		local count = 0

		for index, nearbyVehicle in ipairs( exports.global:getNearbyElements(thePlayer, "vehicle") ) do
			local thisvehid = getElementData(nearbyVehicle, "dbid")
			if thisvehid then
				local vehicleID = getElementModel(nearbyVehicle)
				local vehicleName = getVehicleNameFromModel(vehicleID)
				local owner = getElementData(nearbyVehicle, "owner")
				local faction = getElementData(nearbyVehicle, "faction")
				count = count + 1

				local ownerName = ""

				if faction then
					if (faction>0) then
						local theTeam = exports.pool:getElement("team", faction)
						if theTeam then
							ownerName = getTeamName(theTeam)
						end
					elseif (owner==-1) then
						ownerName = "Admin Veh temporal"
					elseif (owner>0) then
						ownerName = exports['cache']:getCharacterName(owner, true)
					else
						ownerName = "Civil"
					end
				else
					ownerName = "Concesionaria"
				end

				if (thisvehid) then
					deleteVehicle(thePlayer, "delveh", thisvehid)
				end
			end
		end

		if (count==0) then
			outputChatBox("   None was deleted.", thePlayer, 255, 126, 0)
		elseif count == 1 then
			outputChatBox("   One vehicle were deleted.", thePlayer, 255, 126, 0)
		else
			outputChatBox("   "..count.." vehicles were deleted.", thePlayer, 255, 126, 0)
		end
	end
end
addCommandHandler("borrarvehiculoscercanos", delNearbyVehicles, false, false)
addCommandHandler("borrarvehcerca", delNearbyVehicles, false, false)

function respawnCmdVehicle(thePlayer, commandName, id)
	if (exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerSupporter(thePlayer) or exports.integration:isPlayerScripter(thePlayer) or exports.integration:isPlayerVehicleConsultant(thePlayer)) then
		if not (id) then
			outputChatBox("SYNTAX: /reaparecerveh [id]", thePlayer, 255, 194, 14)
		else
			local theVehicle = exports.pool:getElement("vehicle", tonumber(id))
			if theVehicle then
				if isElementAttached(theVehicle) then
					detachElements(theVehicle)
					setElementCollisionsEnabled(theVehicle, true) -- Adams
				end
				local dbid = getElementData(theVehicle,"dbid")
				if (dbid<0) then -- TEMP vehicle
					fixVehicle(theVehicle) -- Can't really respawn this, so just repair it
					if armoredCars[ getElementModel( theVehicle ) ] or getElementData(theVehicle, "bulletproof") == 1 then
						setVehicleDamageProof(theVehicle, true)
					else
						setVehicleDamageProof(theVehicle, false)
					end
					setVehicleWheelStates(theVehicle, 0, 0, 0, 0)
					exports.anticheat:changeProtectedElementDataEx(theVehicle, "enginebroke", 0, false)
				else
					exports.logs:dbLog(thePlayer, 6, theVehicle, "RESPAWN")

					addVehicleLogs(id, commandName, thePlayer)

					respawnTheVehicle(theVehicle)
					if getElementData(theVehicle, "owner") == -2 and getElementData(theVehicle,"Impounded") == 0  then
						setVehicleLocked(theVehicle, false)
					end
				end
				outputChatBox("Vehiculo reaparecido.", thePlayer, 255, 194, 14)
			else
				outputChatBox("ID de vehículo no válida.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("reaparecerveh", respawnCmdVehicle, false, false)

function respawnGuiVehicle(theVehicle) --Exciter
	local thePlayer = source
	if (exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerSupporter(thePlayer) or exports.integration:isPlayerScripter(thePlayer) or exports.integration:isPlayerVehicleConsultant(thePlayer)) then
		if isElementAttached(theVehicle) then
			detachElements(theVehicle)
			setElementCollisionsEnabled(theVehicle, true)
		end
		local dbid = getElementData(theVehicle,"dbid")
		if (dbid<0) then -- TEMP vehicle
			fixVehicle(theVehicle) -- Can't really respawn this, so just repair it
			if armoredCars[ getElementModel( theVehicle ) ] or getElementData(theVehicle, "bulletproof") == 1 then
				setVehicleDamageProof(theVehicle, true)
			else
				setVehicleDamageProof(theVehicle, false)
			end
			setVehicleWheelStates(theVehicle, 0, 0, 0, 0)
			exports.anticheat:changeProtectedElementDataEx(theVehicle, "enginebroke", 0, false)
		else
			exports.logs:dbLog(thePlayer, 6, theVehicle, "RESPAWN")

			local id = tonumber(getElementData(theVehicle, "dbid"))
			addVehicleLogs(id, "respawnveh", thePlayer)

			respawnTheVehicle(theVehicle)
			if getElementData(theVehicle, "owner") == -2 and getElementData(theVehicle,"Impounded") == 0  then
				setVehicleLocked(theVehicle, false)
			end
		end
	end
end
addEvent("vehicle-manager:respawn", true)
addEventHandler("vehicle-manager:respawn", getRootElement(), respawnGuiVehicle)

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function respawnAllVehicles(thePlayer, commandName, timeToRespawn)
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) then
		if commandName then
			if isTimer(respawnTimer) then
				outputChatBox("Ya hay un Reaparición de Vehículo activo, /pararrespawn para detenerlo primero.", thePlayer, 255, 0, 0)
			else
				timeToRespawn = tonumber(timeToRespawn) or 30
				timeToRespawn = timeToRespawn < 10 and 10 or timeToRespawn
				for k, arrayPlayer in ipairs(exports.global:getAdmins()) do
					local logged = getElementData(arrayPlayer, "loggedin")
					if (logged) then
						if exports.integration:isPlayerAdmin(arrayPlayer) then
							outputChatBox( "LeadAdmWarn: " .. getPlayerName(thePlayer) .. " ejecutado un respawn de vehículos.", arrayPlayer, 255, 194, 14)
						end
					end
				end

				outputChatBox("*** Todos los vehículos se reaparecerán en "..timeToRespawn.." segundos! ***", getRootElement(), 255, 194, 14)
				outputChatBox("Puedes detenerlo escribiendo /pararrespawn!", thePlayer)
				respawnTimer = setTimer(respawnAllVehicles, timeToRespawn*1000, 1, thePlayer)
			end
			return
		end
		local tick = getTickCount()
		local vehicles = getElementsByType("vehicle")--exports.pool:getPoolElementsByType("vehicle")
		local counter = 0
		local tempcounter = 0
		local tempoccupied = 0
		local radioCounter = 0
		local occupiedcounter = 0
		local unlockedcivs = 0
		local notmoved = 0
		local deleted = 0

		local dimensions = { }
		for k, p in ipairs(getElementsByType("player")) do
			dimensions[ getElementDimension( p ) ] = true
		end

		for k, theVehicle in ipairs(vehicles) do
			if isElement( theVehicle )
				and not getElementData(theVehicle, 'carshop')
				and not getElementData(theVehicle, "auction_vehicle")
				and not getElementData(theVehicle, "auction_vehicle:awaiting_pickup")
			then
				local dbid = getElementData(theVehicle, "dbid")
				if not dbid or dbid<0 then -- TEMP vehicle
					local driver = getVehicleOccupant(theVehicle)
					local pass1 = getVehicleOccupant(theVehicle, 1)
					local pass2 = getVehicleOccupant(theVehicle, 2)
					local pass3 = getVehicleOccupant(theVehicle, 3)

					if (dbid and dimensions[dbid + 20000]) or (pass1) or (pass2) or (pass3) or (driver) or (getVehicleTowingVehicle(theVehicle)) or #getAttachedElements(theVehicle) > 0 then
						tempoccupied = tempoccupied + 1
					else
						destroyElement(theVehicle)
						tempcounter = tempcounter + 1
					end
				else
					local driver = getVehicleOccupant(theVehicle)
					local pass1 = getVehicleOccupant(theVehicle, 1)
					local pass2 = getVehicleOccupant(theVehicle, 2)
					local pass3 = getVehicleOccupant(theVehicle, 3)

					if (dimensions[dbid + 20000]) or (pass1) or (pass2) or (pass3) or (driver) or (getVehicleTowingVehicle(theVehicle)) or #getAttachedElements(theVehicle) > 0 then
						occupiedcounter = occupiedcounter + 1
					else
						if isVehicleBlown(theVehicle) then --or isElementInWater(theVehicle) then
							fixVehicle(theVehicle)
							if armoredCars[ getElementModel( theVehicle ) ] or getElementData(theVehicle, "bulletproof") == 1 then
								setVehicleDamageProof(theVehicle, true)
							else
								setVehicleDamageProof(theVehicle, false)
							end
							for i = 0, 5 do
								setVehicleDoorState(theVehicle, i, 4) -- all kind of stuff missing
							end
							setElementHealth(theVehicle, 300) -- lowest possible health
							exports.anticheat:changeProtectedElementDataEx(theVehicle, "enginebroke", 1, false)
						end

						if getElementData(theVehicle, "owner") == -2 and getElementData(theVehicle,"Impounded") == 0 then
							if isElementAttached(theVehicle) then
								detachElements(theVehicle)
								setElementCollisionsEnabled(theVehicle, true) -- Adams
							end
							respawnVehicle(theVehicle)
							setVehicleLocked(theVehicle, false)
							unlockedcivs = unlockedcivs + 1
						else
							local checkx, checky, checkz = getElementPosition( theVehicle )
							if getElementData(theVehicle, "respawnposition") then
								local x, y, z, rx, ry, rz = unpack(getElementData(theVehicle, "respawnposition"))

								if (round(checkx, 6) == x) and (round(checky, 6) == y) then
									notmoved = notmoved + 1
								else
									if isElementAttached(theVehicle) then
										detachElements(theVehicle)
									end
									setElementCollisionsEnabled(theVehicle, true)
									if getElementData(theVehicle, "vehicle:radio") ~= 0 then
										exports.anticheat:changeProtectedElementDataEx(theVehicle, "vehicle:radio", 0, true)
										radioCounter = radioCounter + 1
									end
									setElementPosition(theVehicle, x, y, z)
									setVehicleRotation(theVehicle, rx, ry, rz)
									setElementInterior(theVehicle, getElementData(theVehicle, "interior"))
									setElementDimension(theVehicle, getElementData(theVehicle, "dimension"))
									exports.realism:turnIndicatorsOff(theVehicle)

									if not getElementData(theVehicle, "carshop") then
										if isElementWithinColShape(theVehicle, wangs1Col) or isElementWithinColShape(theVehicle, wangs2Col) or isElementWithinColShape(theVehicle, wangs3Col) or isElementWithinColShape(theVehicle, bikeCol) then
											mysql:query_free("UPDATE `vehicles` SET `deleted`='1' WHERE `id`='" .. mysql:escape_string(dbid) .. "'")
											call( getResourceFromName( "item-system" ), "deleteAll", 3, dbid )
											call( getResourceFromName( "item-system" ), "clearItems", theVehicle )
											exports.logs:dbLog(thePlayer, 6, { theVehicle }, "CarShop Delete" )
											destroyElement(theVehicle)
											deleted = deleted + 1
										else
											counter = counter + 1
										end
									end
								end
							else
								exports.global:sendMessageToAdmins("[RESPAWN-ALL] Vehicle #" .. dbid .. " has not been /park'ed!")
								mysql:query_free("UPDATE `vehicles` SET `deleted`='1' WHERE `id`='" .. mysql:escape_string(dbid) .. "'")
								call( getResourceFromName( "item-system" ), "deleteAll", 3, dbid )
								call( getResourceFromName( "item-system" ), "clearItems", theVehicle )
								exports.logs:dbLog(thePlayer, 6, { theVehicle }, "CarShop Delete" )
								destroyElement(theVehicle)
								deleted = deleted + 1
							end
						end
						-- fix faction vehicles
						if theVehicle and isElement(theVehicle) then
							if getElementData(theVehicle, "faction") ~= -1 then
								fixVehicle(theVehicle)
								if (getElementData(theVehicle, "Impounded") == 0) then
									exports.anticheat:changeProtectedElementDataEx(theVehicle, "enginebroke", 0, true)
									exports.anticheat:changeProtectedElementDataEx(theVehicle, "handbrake", 1, true)
									setTimer(setElementFrozen, 2000, 1, theVehicle, true)
									if armoredCars[ getElementModel( theVehicle ) ] or getElementData(theVehicle, "bulletproof") == 1 then
										setVehicleDamageProof(theVehicle, true)
									else
										setVehicleDamageProof(theVehicle, false)
									end
								end
							end
							-- turn off lights
							exports.anticheat:setEld(theVehicle, 'lights', 0, 'all')
							setVehicleOverrideLights ( theVehicle, 1 )
						end
					end
				end
			end
		end
		local timeTaken = (getTickCount() - tick)/1000
		outputChatBox(" =-=-=-=-=-=- Todos los vehículos reaparecidos =-=-=-=-=-=-=", getRootElement(), 255, 194, 14)
		outputChatBox("Reaparecidos " .. counter .. "/" .. counter + notmoved .. " vehículos. (" .. occupiedcounter .. " Ocupados) .", thePlayer)
		outputChatBox("Borrado  " .. tempcounter .. " vehículos temporales. (" .. tempoccupied .. " Ocupados).", thePlayer)
		outputChatBox("Reiniciar " .. radioCounter .. " radios de coche.", thePlayer)
		outputChatBox("Desbloqueado y reaparecido " .. unlockedcivs .. " vehículos civiles.", thePlayer)
		outputChatBox("Borrado " .. deleted .. " vehículos estacionados en concesionarios.", thePlayer)
		outputChatBox("Todo eso en " .. timeTaken .." segundos.", thePlayer)
	end
end
addCommandHandler("reaparecervehs", respawnAllVehicles, false, false)

function respawnVehiclesStop(thePlayer, commandName)
	if exports.integration:isPlayerTrialAdmin(thePlayer) and isTimer(respawnTimer) then
		killTimer(respawnTimer)
		respawnTimer = nil
		if commandName then
			local name = getPlayerName(thePlayer):gsub("_", " ")
			if getElementData(thePlayer, "hiddenadmin") == 1 then
				name = "Admin Oculto"
			end
			outputChatBox( "*** " .. name .. " ha cancelado el respawn del vehículo ***", getRootElement(), 255, 194, 14)
		end
	end
end
addCommandHandler("pararrespawn", respawnVehiclesStop, false, false)

function respawnAllCivVehicles(thePlayer, commandName)
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) then
		local counter = 0
		for k, theVehicle in ipairs( exports.pool:getPoolElementsByType("vehicle") ) do
			local dbid = getElementData(theVehicle, "dbid")
			if dbid and dbid > 0 then
				local owner = getElementData(theVehicle, "owner")
				if (owner==-2) then
					local occupants = getVehicleOccupants( theVehicle )
					if ( not occupants or exports.global:countTable( occupants ) < 1 ) and not getVehicleTowingVehicle( theVehicle ) and #getAttachedElements( theVehicle ) == 0 then
						if isElementAttached(theVehicle) then
							detachElements(theVehicle)
						end
						respawnTheVehicle( theVehicle )
						setVehicleLocked(theVehicle, false)
						counter = counter + 1
					end
				end
			else
				if not getElementData( theVehicle, 'carshop' ) then
					destroyElement( theVehicle )
				end
			end
		end
		outputChatBox(" =-=-=-=-=-=- Vehículos civiles reaparecidos =-=-=-=-=-=-=", getRootElement(), 255, 194, 14)
		outputChatBox("Reaparecidos " .. counter .. " vehículos civiles.", thePlayer)
	end
end
addCommandHandler("respawnciv", respawnAllCivVehicles, false, false)

function respawnAllInteriorVehicles(thePlayer, commandName, repair)
	local repair = tonumber( repair ) == 1 and exports.integration:isPlayerTrialAdmin( thePlayer )
	local dimension = getElementDimension(thePlayer)
	if dimension > 0 and exports.integration:isPlayerTrialAdmin(thePlayer) then--and ( exports.global:hasItem(thePlayer, 4, dimension) or exports.global:hasItem(thePlayer, 5, dimension) ) then
		local vehicles = exports.pool:getPoolElementsByType("vehicle")
		local counter = 0

		for k, theVehicle in ipairs(vehicles) do
			if getElementData(theVehicle, "dimension") == dimension then
				local dbid = getElementData(theVehicle, "dbid")
				if dbid and dbid > 0 then
					local driver = getVehicleOccupant(theVehicle)
					local pass1 = getVehicleOccupant(theVehicle, 1)
					local pass2 = getVehicleOccupant(theVehicle, 2)
					local pass3 = getVehicleOccupant(theVehicle, 3)

					if not pass1 and not pass2 and not pass3 and not driver and not getVehicleTowingVehicle(theVehicle) and #getAttachedElements(theVehicle) == 0 then
						local checkx, checky, checkz = getElementPosition( theVehicle )
						if getElementData(theVehicle, "respawnposition") then


							local x, y, z, rx, ry, rz = unpack(getElementData(theVehicle, "respawnposition"))

							if (round(checkx, 6) ~= x) or (round(checky, 6) ~= y) then
								if isElementAttached(theVehicle) then
									detachElements(theVehicle)
								end
								if repair then
									respawnTheVehicle(theVehicle)
								else
									setElementPosition(theVehicle, x, y, z)
									setVehicleRotation(theVehicle, rx, ry, rz)
									setElementInterior(theVehicle, getElementData(theVehicle, "interior"))
									setElementDimension(theVehicle, getElementData(theVehicle, "dimension"))
								end
								counter = counter + 1
							end
						else
							exports.global:sendMessageToAdmins("[Respawn] Algo le pasa al vehículo "..dbid)
						end
					end
				end
			end
		end
		outputChatBox("Reaparecidos " .. counter .. " vehículos de distrito.", thePlayer)
	else
		outputChatBox( "No es tu lugar, ¿verdad?", thePlayer, 255, 0, 0 )
	end
end
addCommandHandler("respawnint", respawnAllInteriorVehicles, false, false)


function respawnDistrictVehicles(thePlayer, commandName)
	if exports.integration:isPlayerTrialAdmin( thePlayer ) then
		local zoneName = exports.global:getElementZoneName(thePlayer)
		local vehicles = exports.pool:getPoolElementsByType("vehicle")
		local counter = 0
		local deleted = 0

		for k, theVehicle in ipairs(vehicles) do
			local vehicleZoneName = exports.global:getElementZoneName(theVehicle)
			if (zoneName == vehicleZoneName) then
				local dbid = getElementData(theVehicle, "dbid")
				if dbid and dbid > 0 then
					local driver = getVehicleOccupant(theVehicle)
					local pass1 = getVehicleOccupant(theVehicle, 1)
					local pass2 = getVehicleOccupant(theVehicle, 2)
					local pass3 = getVehicleOccupant(theVehicle, 3)

					if not pass1 and not pass2 and not pass3 and not driver and not getVehicleTowingVehicle(theVehicle) and #getAttachedElements(theVehicle) == 0 then
						local checkx, checky, checkz = getElementPosition( theVehicle )
						if getElementData(theVehicle, "respawnposition") then
							local x, y, z, rx, ry, rz = unpack(getElementData(theVehicle, "respawnposition"))

							if (round(checkx, 6) ~= x) or (round(checky, 6) ~= y) then
								if isElementAttached(theVehicle) then
									detachElements(theVehicle)
								end
								setElementCollisionsEnabled(theVehicle, true)
								setElementPosition(theVehicle, x, y, z)
								setVehicleRotation(theVehicle, rx, ry, rz)
								setElementInterior(theVehicle, getElementData(theVehicle, "interior"))
								setElementDimension(theVehicle, getElementData(theVehicle, "dimension"))
								exports.anticheat:changeProtectedElementDataEx(theVehicle, "vehicle:radio", 0, true)
								if not getElementData(theVehicle, "carshop") then
									if isElementWithinColShape(theVehicle, wangs1Col) or isElementWithinColShape(theVehicle, wangs2Col) or isElementWithinColShape(theVehicle, wangs3Col) or isElementWithinColShape(theVehicle, bikeCol) then
										mysql:query_free("UPDATE `vehicles` SET `deleted`='1' WHERE id='" .. mysql:escape_string(dbid) .. "'")
										call( getResourceFromName( "item-system" ), "deleteAll", 3, dbid )
										call( getResourceFromName( "item-system" ), "clearItems", theVehicle )
										exports.logs:dbLog(thePlayer, 6, { theVehicle }, "CarShop Delete" )
										destroyElement(theVehicle)
										deleted = deleted + 1
									else
										counter = counter + 1
									end
								end
							end
						else
							mysql:query_free("UPDATE `vehicles` SET `deleted`='1' WHERE `id`='" .. mysql:escape_string(dbid) .. "'")
							call( getResourceFromName( "item-system" ), "deleteAll", 3, dbid )
							call( getResourceFromName( "item-system" ), "clearItems", theVehicle )
							exports.logs:dbLog(thePlayer, 6, { theVehicle }, "CarShop Delete" )
							destroyElement(theVehicle)
							deleted = deleted + 1
						end
					end
				end
			end
		end
		exports.global:sendMessageToAdmins("AdmWrn: ".. getPlayerName(thePlayer) .." a reaparecido " .. counter .. " y eliminado " .. deleted .. "vehículos de distrito en '"..zoneName.."'.", thePlayer)
	end
end
addCommandHandler("respawndistrito", respawnDistrictVehicles, false, false)

function addUpgrade(thePlayer, commandName, target, upgradeID)
	if exports.integration:isPlayerTrialAdmin(thePlayer)  then
		if not (target) or not (upgradeID) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Nombre Parcial del jugador] [ID de mejora]", thePlayer, 255, 194, 14)
		else
			local username = getPlayerName(thePlayer)
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)

			if targetPlayer then
				if not (isPedInVehicle(targetPlayer)) then
					outputChatBox("Ese jugador no está en un vehículo.", thePlayer, 255, 0, 0)
				else
					if upgradeID and tonumber(upgradeID) and exports.npc:getDisabledUpgrades()[tonumber(upgradeID)] then
						outputChatBox("Este elemento está desactivado temporalmente.", thePlayer, 255, 0, 0)
						return false
					end
					local theVehicle = getPedOccupiedVehicle(targetPlayer)
					local success = addVehicleUpgrade(theVehicle, upgradeID)

					if not (success == false) then
						exports.logs:dbLog(thePlayer, 6, { targetPlayer, theVehicle  }, "ADDUPGRADE ".. upgradeID .. " "..	getVehicleUpgradeSlotName(upgradeID))

						addVehicleLogs(getElementData(theVehicle,"dbid"), commandName.." "..upgradeID, thePlayer)

						outputChatBox(getVehicleUpgradeSlotName(upgradeID) .. " mejora añadida al vehículo de  " .. targetPlayerName .. ".", thePlayer)
						outputChatBox("Admin " .. username .. "  añadió la mejora " .. getVehicleUpgradeSlotName(upgradeID) .. "  a su vehículo.", targetPlayer)
						exports.vehicle:saveVehicleMods(theVehicle)
					else
						outputChatBox("ID de actualización no válido o este vehículo no admite esta actualización..", thePlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("agregarmejora", addUpgrade, false, false)
--[[
-- START of Vehicle Customization by Anthony

--suspensionLowerLimits
function setsuspensionLowerLimit(thePlayer, commandName, limit)
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) then
		if (limit) then
			if tonumber(limit) <= 0.1 and tonumber(limit) >= -0.35 then
				local theVehicle = getPedOccupiedVehicle(thePlayer)
				if theVehicle then
				local dbid = getElementData(theVehicle, "dbid")
				exports.mysql:query_free("UPDATE vehicles SET suspensionLowerLimit = '" .. exports.mysql:escape_string( tonumber(limit) ) .. "' WHERE id = '".. exports.mysql:escape_string(dbid) .."'")
				setVehicleHandling(theVehicle, "suspensionLowerLimit", tonumber(limit) or nil)
				outputChatBox("Vehicle suspension lower limit set to: "..tonumber(limit), thePlayer, 0, 255, 0)
				else
				outputChatBox("You are not in a vehicle!", thePlayer, 255, 0, 0)
				end
			else
			outputChatBox("SYNTAX: /" .. commandName .. " [Limit: 0.1 to -0.35]", thePlayer, 255, 194, 14)
			end
		else
		outputChatBox("SYNTAX: /" .. commandName .. " [Limit: 0.1 to -0.35]", thePlayer, 255, 194, 14)
		end
	end
end
addCommandHandler("sll", setsuspensionLowerLimit, false, false)

function getsuspensionLowerLimit(thePlayer)
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) then
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if theVehicle then
		local currentHandling = getVehicleHandling(theVehicle)
		local suspensionHeight = currentHandling["suspensionLowerLimit"]
		outputChatBox("This vehicle's lower suspension limit is: "..tonumber(suspensionHeight), thePlayer, 0, 255, 0)
		else
		outputChatBox("You are not in a vehicle!", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("gsll", getsuspensionLowerLimit, false, false)
addCommandHandler("getsll", getsuspensionLowerLimit, false, false)

function resetsuspensionLowerLimit(thePlayer)
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) then
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if theVehicle then
		local dbid = getElementData(theVehicle, "dbid")
		local model = getElementModel(theVehicle)
		local originalHandling = getOriginalHandling(model)
		local defaultLimit = originalHandling["suspensionLowerLimit"]
		--exports.mysql:query_free("UPDATE vehicles SET suspensionLowerLimit = '" .. exports.mysql:escape_string( tonumber(defaultLimit) ) .. "' WHERE id = '".. exports.mysql:escape_string(dbid) .."'")
		exports.mysql:query_free("UPDATE vehicles SET suspensionLowerLimit = NULL WHERE id = '".. exports.mysql:escape_string(dbid) .."'")
		setVehicleHandling(theVehicle, "suspensionLowerLimit", tonumber(defaultLimit) or nil)
		outputChatBox("Successfully reset the vehicle's lower suspension limit to: "..tonumber(defaultLimit), thePlayer, 0, 255, 0)
		else
		outputChatBox("You are not in a vehicle!", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("resetsll", resetsuspensionLowerLimit, false, false)

--driveTypes
function setdriveType(thePlayer, commandName, driveType)
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) then
		if (driveType) then
			if driveType == "awd" or driveType == "fwd" or driveType == "rwd" then
				local theVehicle = getPedOccupiedVehicle(thePlayer)
				if theVehicle then
				local dbid = getElementData(theVehicle, "dbid")
				exports.mysql:query_free("UPDATE vehicles SET driveType = '" .. exports.mysql:escape_string( tostring(driveType) ) .. "' WHERE id = '".. exports.mysql:escape_string(dbid) .."'")
				setVehicleHandling(theVehicle, "driveType", tostring(driveType) or nil)
				outputChatBox("Vehicle drive type set to: "..tostring(driveType), thePlayer, 0, 255, 0)
				else
				outputChatBox("You are not in a vehicle!", thePlayer, 255, 0, 0)
				end
			else
			outputChatBox("SYNTAX: /" .. commandName .. " [awd/fwd/rwd]", thePlayer, 255, 194, 14)
			end
		else
		outputChatBox("SYNTAX: /" .. commandName .. " [awd/fwd/rwd]", thePlayer, 255, 194, 14)
		end
	end
end
addCommandHandler("sdt", setdriveType, false, false)

function getdriveType(thePlayer)
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) then
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if theVehicle then
		local currentHandling = getVehicleHandling(theVehicle)
		local driveType = currentHandling["driveType"]
		outputChatBox("This vehicle's drive type is: "..tostring(driveType), thePlayer, 0, 255, 0)
		else
		outputChatBox("You are not in a vehicle!", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("gdt", getdriveType, false, false)
addCommandHandler("getsdt", getdriveType, false, false)
addCommandHandler("getdt", getdriveType, false, false)

function resetdriveType(thePlayer)
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) then
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if theVehicle then
		local dbid = getElementData(theVehicle, "dbid")
		local model = getElementModel(theVehicle)
		local originalHandling = getOriginalHandling(model)
		local defaultType = originalHandling["driveType"]
		--exports.mysql:query_free("UPDATE vehicles SET suspensionLowerLimit = '" .. exports.mysql:escape_string( tonumber(defaultLimit) ) .. "' WHERE id = '".. exports.mysql:escape_string(dbid) .."'")
		exports.mysql:query_free("UPDATE vehicles SET driveType = NULL WHERE id = '".. exports.mysql:escape_string(dbid) .."'")
		setVehicleHandling(theVehicle, "driveType", tostring(defaultType) or nil)
		outputChatBox("Successfully reset the vehicle's drive type to: "..tostring(defaultType), thePlayer, 0, 255, 0)
		else
		outputChatBox("You are not in a vehicle!", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("resetdt", resetdriveType, false, false)

-- END of Vehicle Customization by Anthony
]] -- All disabled by Adams, using handling editor now.
function addPaintjob(thePlayer, commandName, target, paintjobID)
	if exports.integration:isPlayerTrialAdmin(thePlayer)  then
		if not (target) or not (paintjobID) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Nombre Parcial del jugador] [Paintjob ID]", thePlayer, 255, 194, 14)
		else
			local username = getPlayerName(thePlayer)
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)

			if targetPlayer then
				if not (isPedInVehicle(targetPlayer)) then
					outputChatBox("Ese jugador no está en un vehículo.", thePlayer, 255, 0, 0)
				else
					local theVehicle = getPedOccupiedVehicle(targetPlayer)
					paintjobID = tonumber(paintjobID)
					if paintjobID == getVehiclePaintjob(theVehicle) then
						outputChatBox("Este vehículo ya tiene este paintjob.", thePlayer, 255, 0, 0)
					else
						local success = setVehiclePaintjob(theVehicle, paintjobID)

						if (success) then

							addVehicleLogs(getElementData(theVehicle,"dbid"), commandName.." "..paintjobID, thePlayer)

							exports.logs:dbLog(thePlayer, 6, { targetPlayer, theVehicle  }, "PAINTJOB ".. paintjobID )
							outputChatBox("Paintjob #" .. paintjobID .. " añadido al vehículo de " .. targetPlayerName .. ".", thePlayer)
							outputChatBox("Admin " .. username .. " ha añadido #" .. paintjobID .. " a tu vehículo.", targetPlayer)
							exports.vehicle:saveVehicleMods(theVehicle)
						else
							outputChatBox("ID de paintjob no válido, o este vehículo no admite este paintjob..", thePlayer, 255, 0, 0)
						end
					end
				end
			end
		end
	end

end
addCommandHandler("agregarpaintjob", addPaintjob, false, false)

function resetUpgrades(thePlayer, commandName, target)
	if exports.integration:isPlayerTrialAdmin(thePlayer)  then
		if not (target) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Nombre Parcial del jugador]", thePlayer, 255, 194, 14)
		else
			local username = getPlayerName(thePlayer)
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)

			if targetPlayer then
				if not (isPedInVehicle(targetPlayer)) then
					outputChatBox("Ese jugador no está en un vehículo.", thePlayer, 255, 0, 0)
				else
					local theVehicle = getPedOccupiedVehicle(targetPlayer)
					exports.logs:dbLog(thePlayer, 6, { targetPlayer, theVehicle  }, "RESETUPGRADES" )

					addVehicleLogs(getElementData(theVehicle,"dbid"), commandName, thePlayer)

					for key, value in ipairs(getVehicleUpgrades(theVehicle)) do
						removeVehicleUpgrade(theVehicle, value)
					end
					setVehiclePaintjob(theVehicle, 3)
					outputChatBox("Retiradas todas las mejoras del vehículo de " .. targetPlayerName .. ".", thePlayer, 0, 255, 0)
					exports.vehicle:saveVehicleMods(theVehicle)
				end
			end
		end
	end
end
addCommandHandler("restablecermejoras", resetUpgrades, false, false)

function deleteUpgrade(thePlayer, commandName, target, id)
	if exports.integration:isPlayerTrialAdmin(thePlayer)   then
		if not (target) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Nombre Parcial del jugador]", thePlayer, 255, 194, 14)
		else
			local username = getPlayerName(thePlayer)
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)

			if targetPlayer then
				if not (isPedInVehicle(targetPlayer)) then
					outputChatBox("Ese jugador no está en un vehículo.", thePlayer, 255, 0, 0)
				else
					local theVehicle = getPedOccupiedVehicle(targetPlayer)
					exports.logs:dbLog(thePlayer, 6, { targetPlayer, theVehicle  }, "DELETEUPGRADE ".. id )

					addVehicleLogs(getElementData(theVehicle,"dbid"), commandName.." "..id, thePlayer)

					local result = removeVehicleUpgrade(theVehicle, id)
					if result then
						outputChatBox("Mejora eliminada ".. id .." del vehículo de " .. targetPlayerName .. ".", thePlayer, 0, 255, 0)
						exports.vehicle:saveVehicleMods(theVehicle)
					else
						outputChatBox("Algo salió mal al eliminar la mejora ".. id .." del vehículo de " .. targetPlayerName .. ".", thePlayer, 0, 255, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("eliminarmejora", deleteUpgrade, false, false)
addCommandHandler("elimej", deleteUpgrade, false, false)

function setVariant(thePlayer, commandName, id, variant1, variant2)
	if exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerVehicleConsultant(thePlayer) then
		if not tonumber(id) then
			outputChatBox("SYNTAX: /" .. commandName .. " [ID del vehículo] [Variante 1] [Variante 2]", thePlayer, 255, 194, 14)
		else
			for i,c in ipairs(exports.pool:getPoolElementsByType("vehicle")) do
				if (getElementData(c, "dbid") == tonumber(id)) then
					theVehicle = c
					break
				end
			end
			local username = getPlayerName(thePlayer)

			if theVehicle then
				variant1 = tonumber(variant1) or 255
				variant2 = tonumber(variant2) or 255

				if exports.vehicle:isValidVariant(getElementModel(theVehicle), variant1, variant2) then
					local a, b = getVehicleVariant(theVehicle)
					if a == variant1 and b == variant2 then
						outputChatBox("Este Vehículo ya tiene esta variante.", thePlayer, 255, 0, 0)
					else
						local success = setVehicleVariant(theVehicle, variant1, variant2)

						if (success) then
							exports.logs:dbLog(thePlayer, 6, {  theVehicle  }, "VARIANT ".. variant1 .. " " .. variant2 )
							outputChatBox("Variante " .. variant1 .. "/" .. variant2.. " añadido al vehículo ID #" .. getElementData(theVehicle,"dbid") .. ".", thePlayer)
							exports.vehicle:saveVehicleMods(theVehicle)

							addVehicleLogs(getElementData(theVehicle,"dbid"), commandName.." "..variant1 or ""..variant2 or "", thePlayer)
						else
							outputChatBox("ID de variante no válido o este vehículo no admite esta paintjob..", thePlayer, 255, 0, 0)
						end
					end
				else
					outputChatBox(variant1 .. "/" .. variant2 .. " no es una variante válida para este " .. getVehicleName(theVehicle) .. ".", thePlayer, 255, 0, 0)
				end
			else
				outputChatBox("No se encuentra el vehículo. ¿Es un vehículo permanente?", thePlayer, 255, 0, 0)
			end
		end
	end

end
addCommandHandler("establecervariante", setVariant, false, false)

function findVehID(thePlayer, commandName, ...)
	if not (...) then
		outputChatBox("SYNTAX: /" .. commandName .. " [Nombre Parcial]", thePlayer, 255, 194, 14)
	else
		local vehicleName = table.concat({...}, " ")
		local carID = getVehicleModelFromName(vehicleName)

		if (carID) then
			local fullName = getVehicleNameFromModel(carID)
			outputChatBox(fullName .. ": ID " .. carID .. ".", thePlayer)
		else
			outputChatBox("Vehículo no encontrado.", thePlayer, 255, 0 , 0)
		end
	end
end
addCommandHandler("encontrarvehid", findVehID, false, false)

-----------------------------[FIX VEH]---------------------------------
function fixPlayerVehicle(thePlayer, commandName, target)
	if (exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerSupporter(thePlayer) or exports.integration:isPlayerScripter(thePlayer) or exports.integration:isPlayerVehicleConsultant(thePlayer)) then
		if not (target) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Nombre Parcial del jugador]", thePlayer, 255, 194, 14)
		else
			local username = getPlayerName(thePlayer)
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)

			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				if (logged==0) then
					outputChatBox("El jugador no ha iniciado sesión.", thePlayer, 255, 0, 0)
				else
					local veh = getPedOccupiedVehicle(targetPlayer)
					if (veh) then
						fixVehicle(veh)
						if (getElementData(veh, "Impounded") == 0) then
							exports.anticheat:setEld( veh, "enginebroke", 0 )
							exports.anticheat:setEld( veh, "battery", 100 )
							if armoredCars[ getElementModel( veh ) ] or getElementData(veh, "bulletproof") == 1 then
								setVehicleDamageProof(veh, true)
							else
								setVehicleDamageProof(veh, false)
							end
						end
						for i = 0, 5 do
							setVehicleDoorState(veh, i, 0)
						end
						exports.logs:dbLog(thePlayer, 6, { targetPlayer, veh  }, "FIXVEH")

						addVehicleLogs(getElementData(veh,"dbid"), commandName, thePlayer)

						if thePlayer == targetPlayer then
							outputChatBox("Ha reparado su vehículo.", thePlayer, 100, 255, 100)
						else
							outputChatBox("Has reparado el vehículo de " .. targetPlayerName .. ".", thePlayer, 100, 255, 100)
							outputChatBox("Su vehículo fue reparado por Admin " .. username:gsub("_", " ") .. ".", targetPlayer, 100, 255, 100)
						end
					else
						outputChatBox("Ese jugador no está en un vehículo.", thePlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("arreglarveh", fixPlayerVehicle, false, false)

-----------------------------[FIX VEH VIS]---------------------------------
function fixPlayerVehicleVisual(thePlayer, commandName, target)
	if (exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerSupporter(thePlayer)) then
		if not (target) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Nombre Parcial del jugador]", thePlayer, 255, 194, 14)
		else
			local username = getPlayerName(thePlayer)
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)

			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				if (logged==0) then
					outputChatBox("El jugador no ha iniciado sesión.", thePlayer, 255, 0, 0)
				else
					local veh = getPedOccupiedVehicle(targetPlayer)
					if (veh) then
						local health = getElementHealth(veh)
						fixVehicle(veh)
						setElementHealth(veh, health)
						exports.logs:dbLog(thePlayer, 6, { targetPlayer, veh  }, "FIXVEHVIS" )

						if thePlayer == targetPlayer then
							outputChatBox("Ha reparado su vehículo visualmente.", thePlayer, 100, 255, 100)
						else
							outputChatBox("Has reparado el vehículo de " .. targetPlayerName .. " visualmente.", thePlayer, 100, 255, 100)
							outputChatBox("Su vehículo fue reparado visualmente por admin " .. username:gsub("_", " ") .. ".", targetPlayer, 100, 255, 100)
						end

						addVehicleLogs(getElementData(veh,"dbid"), commandName, thePlayer)

					else
						outputChatBox("Ese jugador no está en un vehículo.", thePlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("arreglarvehvis", fixPlayerVehicleVisual, false, false)

-----------------------------[BLOW CAR]---------------------------------
function blowPlayerVehicle(thePlayer, commandName, target)
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) then
		if not (target) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Nombre Parcial del jugador]", thePlayer, 255, 194, 14)
		else
			local username = getPlayerName(thePlayer)
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)

			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				if (logged==0) then
					outputChatBox("El jugador no ha iniciado sesión.", thePlayer, 255, 0, 0)
				else
					local veh = getPedOccupiedVehicle(targetPlayer)
					if (veh) then
						blowVehicle(veh)
						outputChatBox("Hiciste explotar el vehículo de " .. targetPlayerName .. ".", thePlayer)
						exports.logs:dbLog(thePlayer, 6, { targetPlayer, veh  }, "BLOWVEH" )

						addVehicleLogs(getElementData(veh,"dbid"), commandName, thePlayer)

					else
						outputChatBox("Ese jugador no está en un vehículo.", thePlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("explotarveh", blowPlayerVehicle, false, false)

-----------------------------[SET CAR HP]---------------------------------
function setCarHP(thePlayer, commandName, target, hp)
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) then
		if not (target) or not (hp) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Nombre Parcial del jugador] [Vida]", thePlayer, 255, 194, 14)
		else
			local username = getPlayerName(thePlayer)
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)

			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				if (logged==0) then
					outputChatBox("El jugador no ha iniciado sesión.", thePlayer, 255, 0, 0)
				else
					local veh = getPedOccupiedVehicle(targetPlayer)
					if (veh) then
						local sethp = setElementHealth(veh, tonumber(hp))

						if (sethp) then
							outputChatBox("Usted establece la vida del vehículo de " .. targetPlayerName .. " a " .. hp .. ".", thePlayer)
							exports.logs:dbLog(thePlayer, 6, { targetPlayer, veh  }, "SETVEHHP ".. hp )

							addVehicleLogs(getElementData(veh,"dbid"), commandName.." "..hp, thePlayer)
						else
							outputChatBox("Valor de vida no válido.", thePlayer, 255, 0, 0)
						end
					else
						outputChatBox("Ese jugador no está en un vehículo.", thePlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("setvidaveh", setCarHP, false, false)

function fixAllVehicles(thePlayer, commandName)
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) then
		local username = getPlayerName(thePlayer)
		for key, value in ipairs(exports.pool:getPoolElementsByType("vehicle")) do
			fixVehicle(value)
			if (not getElementData(value, "Impounded")) then
				exports.anticheat:changeProtectedElementDataEx(value, "enginebroke", 0, false)
				if armoredCars[ getElementModel( value ) ] or getElementData(value, "bulletproof") == 1 then
					setVehicleDamageProof(value, true)
				else
					setVehicleDamageProof(value, false)
				end
			end
		end
		--outputChatBox("All vehicles repaired by Admin " .. username .. ".")
		executeCommandHandler("ann", thePlayer, "Todos los vehículos reparados por Admin " .. username .. ".")
		exports.logs:dbLog(thePlayer, 6, { targetPlayer }, "FIXALLVEHS")
	end
end
addCommandHandler("arreglarvehs", fixAllVehicles)

-----------------------------[FUEL VEH]---------------------------------
function fuelPlayerVehicle(thePlayer, commandName, target, amount)
	if exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerSupporter(thePlayer) or exports.integration:isPlayerVehicleConsultant(thePlayer) then
		if not (target) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Partial Player Nick] [Amount in Liters, 0=Full]", thePlayer, 255, 194, 14)
		else
			local username = getPlayerName(thePlayer)
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)
			local amount = math.floor(tonumber(amount) or 0)

			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				else
					local veh = getPedOccupiedVehicle(targetPlayer)
					if (veh) then
						if exports.vehicle_fuel:getMaxFuel(getElementModel(veh))<amount or amount==0 then
							amount = exports.vehicle_fuel:getMaxFuel(getElementModel(veh))
						end
						exports.anticheat:setEld( veh, "fuel", amount )
						triggerClientEvent( targetPlayer, "syncFuel", veh, getElementData( veh, "fuel" ), getElementData( veh, "battery" ) or 100 )
						outputChatBox("Has repostado el vehículo de " .. targetPlayerName .. ".", thePlayer, 100, 255, 100)
						outputChatBox("Your vehicle was refueled by admin " .. username:gsub("_", " ") .. ".", targetPlayer, 100, 255, 100)
						exports.logs:dbLog(thePlayer, 6, { targetPlayer, veh  }, "FUELVEH")

						addVehicleLogs(getElementData(veh,"dbid"), commandName, thePlayer)

					else
						outputChatBox("Ese jugador no está en un vehículo.", thePlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("repostarveh", fuelPlayerVehicle, false, false)

function fuelAllVehicles(thePlayer, commandName)
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) then
		local username = getPlayerName(thePlayer)
		for key, value in ipairs(exports.pool:getPoolElementsByType("vehicle")) do
			exports.anticheat:setEld( value, "fuel", exports.vehicle_fuel:getMaxFuel(getElementModel(value)) )
		end
		--outputChatBox("All vehicles refuelled by Admin " .. username .. ".")
		executeCommandHandler("ann", thePlayer, "Todos los vehículos repostados por Admin " .. username .. ".")
		exports.logs:dbLog(thePlayer, 6, { thePlayer  }, "FUELVEHS" )
	end
end
addCommandHandler("repostarvehs", fuelAllVehicles, false, false)

-----------------------------[SET COLOR]---------------------------------
function setPlayerVehicleColor(thePlayer, commandName, target, ...)
	if (exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerScripter(thePlayer)) then
		if type(target) == 'string' and target == "*" then
			local vehicle = getPedOccupiedVehicle(thePlayer)
			target = getElementData(vehicle, "dbid")
		end

		if not tonumber(target) or not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [ID del vehículo] [Colores ...]", thePlayer, 255, 194, 14)
		else
			local username = getPlayerName(thePlayer)
			for i,c in ipairs(exports.pool:getPoolElementsByType("vehicle")) do
				if (getElementData(c, "dbid") == tonumber(target)) then
					theVehicle = c
					break
				end
			end

			if theVehicle then
				-- parse colors
				local colors = {...}
				local col = {}
				for i = 1, math.min( 4, #colors ) do
					local r, g, b = getColorFromString(#colors[i] == 6 and ("#" .. colors[i]) or colors[i])
					if r and g and b then
						col[i] = {r=r, g=g, b=b}
					elseif tonumber(colors[1]) and tonumber(colors[1]) >= 0 and tonumber(colors[1]) <= 255 then
						col[i] = math.floor(tonumber(colors[i]))
					else
						outputChatBox("Invalid color: " .. colors[i], thePlayer, 255, 0, 0)
						return
					end
				end
				if not col[2] then col[2] = col[1] end
				if not col[3] then col[3] = col[1] end
				if not col[4] then col[4] = col[2] end

				local set = false
				if type( col[1] ) == "number" then
					set = setVehicleColor(theVehicle, col[1], col[2], col[3], col[4])
				else
					set = setVehicleColor(theVehicle, col[1].r, col[1].g, col[1].b, col[2].r, col[2].g, col[2].b, col[3].r, col[3].g, col[3].b, col[4].r, col[4].g, col[4].b)
				end

				if set then
					outputChatBox("El color del vehículo fue establecido.", thePlayer, 0, 255, 0)
					exports.vehicle:saveVehicleMods(theVehicle)
					exports.logs:dbLog(thePlayer, 6, {  theVehicle  }, "SETVEHICLECOLOR ".. table.concat({...}, " ") )

					addVehicleLogs(getElementData(theVehicle,"dbid"), commandName..table.concat({...}, " "), thePlayer)

				else
					outputChatBox("ID de color no válido.", thePlayer, 255, 194, 14)
				end
			else
				outputChatBox("No se encuentra el vehículo. ¿Es un vehículo permanente?", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("setcolor", setPlayerVehicleColor, false, false)
-----------------------------[GET COLOR]---------------------------------
function getAVehicleColor(thePlayer, commandName, carid)
	if (exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerScripter(thePlayer)) then
		if not (carid) then
			outputChatBox("SYNTAX: /" .. commandName .. " [ID del vehículo]", thePlayer, 255, 194, 14)
		else
			local acar = nil
			for i,c in ipairs(getElementsByType("vehicle")) do
				if (getElementData(c, "dbid") == tonumber(carid)) then
					acar = c
				end
			end
			if acar then
				local col =  { getVehicleColor(acar, true) }
				outputChatBox("Los colores del vehículo son:", thePlayer)
				outputChatBox("1. " .. col[1].. "," .. col[2] .. "," .. col[3] .. " = " .. ("#%02X%02X%02X"):format(col[1], col[2], col[3]), thePlayer)
				outputChatBox("2. " .. col[4].. "," .. col[5] .. "," .. col[6] .. " = " .. ("#%02X%02X%02X"):format(col[4], col[5], col[6]), thePlayer)
				outputChatBox("3. " .. col[7].. "," .. col[8] .. "," .. col[9] .. " = " .. ("#%02X%02X%02X"):format(col[7], col[8], col[9]), thePlayer)
				outputChatBox("4. " .. col[10].. "," .. col[11] .. "," .. col[12] .. " = " .. ("#%02X%02X%02X"):format(col[10], col[11], col[12]), thePlayer)
			else
				outputChatBox("Invalid Car ID.", thePlayer, 255, 194, 14)
			end
		end
	end
end
addCommandHandler("obtenercolor", getAVehicleColor, false, false)

local function removeOne( id )
	dbExec( exports.mysql:getConn('mta'), "DELETE FROM vehicles WHERE id=? ", id )
	dbExec( exports.mysql:getConn('mta'), "DELETE FROM vehicle_logs WHERE vehID=? ", id )
	dbExec( exports.mysql:getConn('mta'), "DELETE FROM vehicles_custom WHERE id=? ", id )
	dbExec( exports.mysql:getConn('mta'), "DELETE FROM vehicle_notes WHERE vehid=? ", id )
	dbExec( exports.mysql:getConn('mta'), "DELETE FROM items WHERE type=2 AND owner=? ", id )
	exports['item-system']:deleteAll( 3, id )
	return true
end

function removeVehicle(thePlayer, commandName, id)
	if exports.integration:isPlayerScripter( thePlayer ) then
		local dbid = tonumber(id)
		if not dbid or dbid%1~=0 or dbid <=0 then
			dbid = getElementData(thePlayer, "vehicleManager:deletedVeh") or false
			if not dbid then
				outputChatBox("SYNTAX: /" .. commandName .. " [ID]", thePlayer, 255, 194, 14)
				return false
			end
		end

		if exports.data:load( 'removeVehicle:'..getElementData( thePlayer, 'dbid' ) ) == dbid then
			dbQuery( function( qh, thePlayer, dbid )
				local res, rows, err = dbPoll( qh, 0 )
				if res then
					if rows > 0 then
						if res[1].deleted ~= 0 then
							removeOne( dbid )
							exports.global:sendMessageToAdmins( "[VEHÍCULO] "..exports.global:getPlayerFullIdentity( thePlayer ).." ha eliminado el vehículo ID: #" .. dbid .. " completamente de SQL." )
						else
							outputChatBox("El vehículo sigue en el juego. Por favor, utilice /borrarveh "..dbid.." primero.", thePlayer, 255, 0, 0)
						end
					else
						outputChatBox(" No hay tal vehículo con ID #"..dbid.." encontrado en la base de datos.", thePlayer, 255, 0, 0)
					end
				end
			end, { thePlayer, dbid }, exports.mysql:getConn('mta'), "SELECT deleted FROM vehicles WHERE id=? ", dbid )
		else
			exports.data:save( dbid, 'removeVehicle:'..getElementData( thePlayer, 'dbid' ) )
			outputChatBox(" ¿Está seguro? Escriba /"..commandName.." "..dbid.." de nuevo.", thePlayer )
		end
	end
end
addCommandHandler("removerveh", removeVehicle, false, false)
addCommandHandler("removervehiculo", removeVehicle, false, false)

local threads_remove = { }
local timer_remove
local mult_remove = 1
function removeVehs( p, c )
	if exports.integration:isPlayerScripter( p ) then
		if exports.data:load( 'removeVehs:'..getElementData( p, 'dbid') ) then
			dbQuery( function( qh, p )
				local res, rows, err = dbPoll( qh, 0 )
				if res and rows > 0 then
					exports.global:sendMessageToAdmins( "[VEHÍCULO] "..exports.global:getPlayerFullIdentity( p ).." ha empezado a remover "..exports.global:formatMoney( rows ).." vehículos borrados de SQL. Se hará en aproximadamente "..exports.global:round( rows*50/mult_remove/1000, 2 ).." seconds." )
					threads_remove = { }
					for _, veh in ipairs( res ) do
						local co = coroutine.create( removeOne )
						table.insert( threads_remove, { co, veh.id } )
					end
					timer_remove = setTimer( resumeThreads_remove, 50, 0 )
				else
					outputChatBox( " Nothing to remove.", p, 255, 0, 0 )
				end
			end, { p }, exports.mysql:getConn('mta'), "SELECT id FROM vehicles WHERE deleted!=0 " )
		else
			exports.data:save( true, 'removeVehs:'..getElementData( p, 'dbid') )
			outputChatBox(" ¿Está seguro? Escriba /"..c.." de nuevo.", p )
		end
	end
end
addCommandHandler( 'removervehs', removeVehs, false, false )
addCommandHandler( 'removervehiculos', removeVehs, false, false )

function resumeThreads_remove( )
	for i, co in ipairs( threads_remove ) do
		coroutine.resume( co[1], co[2] )
		table.remove( threads_remove, i )
		if i == mult_remove then
			break
		end
	end

	if #threads_remove <= 0 and timer_remove and isTimer( timer_remove ) then
		killTimer( timer_remove )
		timer_remove = nil
	end
end

function clearVehicleInventory(theVehicle)
	if theVehicle then
		local count = 0
		for key, item in pairs(exports["item-system"]:getItems(theVehicle)) do
			exports.global:takeItem(theVehicle, item[1], item[2])
			count = count + 1
		end
		return count
	else
		outputDebugString("[VEH MANAGER] / vehicle commands / clearVehicleInventory() / element not found.")
		return false
	end
end

function adminClearVehicleInventory(thePlayer, commandName, vehicle)
	if exports.integration:isPlayerTrialAdmin(thePlayer) then
		vehicle = tonumber(vehicle)
		if vehicle and (vehicle%1==0) then
			for _, theVehicle in pairs(getElementsByType("vehicle")) do
				if getElementData(theVehicle, "dbid") == vehicle then
					vehicle = theVehicle
					break
				end
			end
		end

		if not isElement(vehicle) then
			vehicle = getPedOccupiedVehicle(thePlayer) or false
		end

		if not vehicle then
			outputChatBox("SYNTAX: /" .. commandName .. " [ID]     -> Borrar todos los items del inventario de un vehículo.", thePlayer, 255, 194, 14)
			outputChatBox("SYNTAX: /" .. commandName .. "          -> Borrar todos los items del inventario actual del vehículo.", thePlayer, 255, 194, 14)
			return false
		end

		outputChatBox("Eliminado "..(clearVehicleInventory(vehicle) or "0").." item(s) del inventario del vehículo.",thePlayer)

	else
		outputChatBox("Sólo los administradores pueden ejecutar este comando. Operación cancelada.", thePlayer, 255,0,0)
	end
end
addCommandHandler("borrarinvveh", adminClearVehicleInventory, false, false)
addCommandHandler("borrarinventariovehiculo", adminClearVehicleInventory, false, false)

function restoreVehicle(thePlayer, commandName, id)
	if exports.integration:isPlayerTrialAdmin(thePlayer) 	then
		local dbid = tonumber(id)
		if not (dbid) then
			outputChatBox("SYNTAX: /" .. commandName .. " [ID]", thePlayer, 255, 194, 14)
		else
			local theVehicle = exports.pool:getElement("vehicle", dbid)
			local adminUsername = getElementData(thePlayer, "account:username")
			local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
			local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
			local adminID = getElementData(thePlayer, "account:id")
			if not theVehicle then
				if mysql:query_free("UPDATE `vehicles` SET `deleted`='0', `chopped`='0' WHERE `id`='" .. mysql:escape_string(dbid) .. "'") then
					exports.vehicle_load:loadOneVehicle( dbid )
					outputChatBox("   Restoring vehicle ID #"..dbid.."...", thePlayer)
					setTimer(function()
						outputChatBox("   Restoring vehicle ID #"..dbid.."...Done!", thePlayer)
						local theVehicle1 = exports.pool:getElement("vehicle", dbid)
						exports.logs:dbLog(thePlayer, 6, { theVehicle1 }, "RESTOREVEH" )
						addVehicleLogs(dbid, commandName, thePlayer)

						local vehicleID = getElementModel(theVehicle1)
						local vehicleName = getVehicleNameFromModel(vehicleID)
						local owner = getElementData(theVehicle1, "owner")
						local faction = getElementData(theVehicle1, "faction")
						local ownerName = ""
						if faction then
							if (faction>0) then
								local theTeam = exports.pool:getElement("team", faction)
								if theTeam then
									ownerName = getTeamName(theTeam)
								end
							elseif (owner==-1) then
								ownerName = "Admin vehículo temporal"
							elseif (owner>0) then
								ownerName = exports['cache']:getCharacterName(owner, true)
							else
								ownerName = "Civil"
							end
						else
							ownerName = "Concesionaria"
						end

						if hiddenAdmin == 0 then
						exports.global:sendMessageToAdmins("[VEHÍCULO]: "..adminTitle.." ".. getPlayerName(thePlayer):gsub("_", " ").. " ("..adminUsername..") ha restaurado un " .. vehicleName .. " (ID: #" .. dbid .. " - Dueño: " .. ownerName..").")
						else
							exports.global:sendMessageToAdmins("[VEHÍCULO]: Un Admin Oculto ha restaurado un " .. vehicleName .. " (ID: #" .. dbid .. " - Dueño: " .. ownerName..").")
						end
					end, 2000,1)

				else
					outputChatBox(" Error de base de datos!", thePlayer, 255, 0, 0)
				end
			else
				outputChatBox("  Vehículo ID#"..dbid.." existe en el juego, por favor use /borrarveh primero.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("restaurarveh", restoreVehicle, false, false)
addCommandHandler("restaurarvehiculo", restoreVehicle, false, false)

function deleteVehicle(thePlayer, commandName, id)
	if exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerScripter(thePlayer) or exports.integration:isPlayerVehicleConsultant( thePlayer ) then
		local dbid = tonumber(id)
		if not (dbid) then
			outputChatBox("SYNTAX: /" .. commandName .. " [ID]", thePlayer, 255, 194, 14)
		else
			local theVehicle = exports.pool:getElement("vehicle", dbid)
			local adminUsername = getElementData(thePlayer, "account:username")
			local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
			local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
			local adminID = getElementData(thePlayer, "account:id")
			if theVehicle then
				local protected, details = exports.vehicle:isProtected(theVehicle)
	            if protected and not exports.integration.isPlayerLeadAdmin(thePlayer) then
	                outputChatBox("Este vehículo está protegido y no se puede eliminar. Protección restante: "..details..".", thePlayer, 255,0,0)
	                return false
	            end
	            local active, details2, secs = exports.vehicle:isActive(theVehicle)
	            --outputChatBox(exports.data:load(getElementData(thePlayer, "account:id").."/"..commandName))
	            if active and exports.data:load(getElementData(thePlayer, "account:id").."/"..commandName) ~= dbid then
	            	local inactiveText = ""
	                local owner_last_login = getElementData(theVehicle, "owner_last_login")
					if owner_last_login and tonumber(owner_last_login) then
						local owner_last_login_text, owner_last_login_sec = exports.datetime:formatTimeInterval(owner_last_login)
						inactiveText = inactiveText.." Propietario visto por última vez "..owner_last_login_text.." "
					else
						inactiveText = inactiveText.." El último propietario visto es irrelevante, "
					end
	                local lastused = getElementData(theVehicle, "lastused")
					if lastused and tonumber(lastused) then
						local lastusedText, lastusedSeconds = exports.datetime:formatTimeInterval(lastused)
						inactiveText = inactiveText.."Última vez utilizado "..lastusedText..", "
					else
						inactiveText = inactiveText.."El último uso es irrelevante, "
					end
					outputChatBox("Este vehículo sigue activo. "..inactiveText.." Por favor, escriba /"..commandName.." "..dbid.." de nuevo para continuar.", thePlayer, 255, 0, 0)
					exports.data:save(dbid, getElementData(thePlayer, "account:id").."/"..commandName)
					return false
				elseif protected then
					outputChatBox("Este vehículo está protegido ¿Está seguro de que desea eliminarlo? Protección restante: "..details..". Por favor, escriba /"..commandName.." "..dbid.." de nuevo para continuar.", thePlayer, 255,0,0)
					exports.data:save(dbid, getElementData(thePlayer, "account:id").."/"..commandName)
					return false
	            end
				local vehicleID = getElementModel(theVehicle)
				local vehicleName = getVehicleNameFromModel(vehicleID)
				local owner = getElementData(theVehicle, "owner")
				local faction = getElementData(theVehicle, "faction")
				local ownerName = ""
				if faction then
					if (faction>0) then
						local theTeam = exports.pool:getElement("team", faction)
						if theTeam then
							ownerName = getTeamName(theTeam)
						end
					elseif (owner==-1) then
						ownerName = "Admin vehículo temporal"
					elseif (owner>0) then
						ownerName = exports['cache']:getCharacterName(owner, true)
					else
						ownerName = "Civil"
					end
				else
					ownerName = "Concesionaria"
				end

				if (dbid<0) then -- TEMP vehicle
					destroyElement(theVehicle)
				else
					mysql:query_free("UPDATE `vehicles` SET `deleted`='"..tostring(adminID).."', `deletedDate`=NOW() WHERE `id`='" .. mysql:escape_string(dbid) .. "'")
					exports.logs:dbLog(thePlayer, 6, { theVehicle }, "DELVEH" )
					destroyElement(theVehicle)
					
					if exports.global:isResourceRunning("insurance") then -- Remove insurance.
						exports.insurance:cancelPolicy(dbid, thePlayer)
					else
						dbExec(exports.mysql:getConn('mta'), "DELETE FROM `insurance_data` WHERE `vehicleid` = ?", dbid)
					end

					if hiddenAdmin == 0 then
						exports.global:sendMessageToAdmins("[VEHÍCULO]: "..adminTitle.." ".. getPlayerName(thePlayer):gsub("_", " ").. " ("..adminUsername..") ha borrado un " .. vehicleName .. " (ID: #" .. dbid .. " - Dueño: " .. ownerName..").")
					else
						exports.global:sendMessageToAdmins("[VEHÍCULO]: Un Admin Oculto ha borrado un " .. vehicleName .. " (ID: #" .. dbid .. " - Dueño: " .. ownerName..").")
					end
					addVehicleLogs(dbid, commandName, thePlayer)

					call( getResourceFromName( "item-system" ), "deleteAll", 3, dbid )
					call( getResourceFromName( "item-system" ), "clearItems", theVehicle )

					for k, theObject in ipairs(getElementsByType("object", getResourceRootElement(getResourceFromName("item-world")))) do
					local itemID = getElementData(theObject, "itemID")
					local itemValue = getElementData(theObject, "itemValue")
					if itemID == 3 and itemValue == dbid then
						destroyElement(theObject)
						mysql:query_free("DELETE FROM worlditems WHERE itemid='3' AND itemvalue='" .. mysql:escape_string(dbid) .. "'")
					end
				end

					exports.anticheat:changeProtectedElementDataEx(thePlayer, "vehicleManager:deletedVeh", dbid, false)
				end
				outputChatBox("   Borrado a " .. vehicleName .. " (ID: #" .. dbid .. " - Dueño: " .. ownerName..").", thePlayer, 255, 126, 0)
			else
				outputChatBox("No se han encontrado vehículos con ese ID.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("borrarveh", deleteVehicle, false, false)
addCommandHandler("borrarvehiculo", deleteVehicle, false, false)

-- DELTHISVEH
function deleteThisVehicle(thePlayer, commandName)
	local veh = getPedOccupiedVehicle(thePlayer)
	local dbid = getElementData(veh, "dbid")
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) then
		if not (isPedInVehicle(thePlayer)) then
			outputChatBox("Usted no está en un vehículo.", thePlayer, 255, 0, 0)
		else
			deleteVehicle(thePlayer, "delveh", dbid)
		end
	else
		outputChatBox("No tiene permiso para eliminar vehículos permanentes.", thePlayer, 255, 0, 0)
	return
	end
end
addCommandHandler("borraresteveh", deleteThisVehicle, false, false)

function setVehicleFaction(thePlayer, theCommand, vehicleID, factionID)
	if exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerVehicleConsultant(thePlayer) then
		if not (vehicleID) or not (factionID) then
			outputChatBox("SYNTAX: /" .. theCommand .. " [ID del vehículo] [ID facción, -1 para remover]", thePlayer, 255, 194, 14)
		else
			local owner = -1
			local theVehicle = exports.pool:getElement("vehicle", vehicleID)
			local factionElement = exports.pool:getElement("team", factionID)
			if theVehicle then
				if (tonumber(factionID) == -1) then
					owner = getElementData(thePlayer, "account:character:id")
				else
					if not factionElement then
						outputChatBox("No se ha encontrado ninguna facción con esa ID.", thePlayer, 255, 0, 0)
						return
					end
				end

				-- let's check if they have enough vehicle slots.
				
				local qh = dbQuery(exports.mysql:getConn("mta"), "SELECT COUNT(*) AS vehs FROM vehicles WHERE faction = ? AND deleted=0", factionID)
				local result = dbPoll(qh, 1000)
				local vehSlots = getElementData(factionElement, "max_vehicles")
				if result and result[1].vehs >= vehSlots then 
					if not exports.integration:isPlayerLeadAdmin(thePlayer) then
						return outputChatBox("Esta facción ha alcanzado el límite máximo de vehículos, los administradores principales y superiores pueden anularlo..", thePlayer, 255, 0, 0)
					else
						outputChatBox("Esta facción ha alcanzado el límite máximo de vehículos, debido a su rango de administrador el vehículo todavía se añade.", thePlayer, 255, 0, 0)
					end
				else
					dbFree(qh)
				end

				dbExec(exports.mysql:getConn("mta"), "UPDATE `vehicles` SET `owner`= ?, `faction`= ? WHERE id = ?", owner, factionID, vehicleID)

				local x, y, z = getElementPosition(theVehicle)
				local int = getElementInterior(theVehicle)
				local dim = getElementDimension(theVehicle)
				exports.vehicle:reloadVehicle(tonumber(vehicleID))
				outputChatBox("Vehículo ID #"..vehicleID.." se ha asignado a la facción ID #"..factionID, thePlayer)

				exports.logs:dbLog(thePlayer, 4, { pveh, theVehicle }, theCommand.." "..factionID)
				addVehicleLogs(vehicleID, theCommand.." "..factionID, thePlayer)
			else
				outputChatBox("No se ha encontrado ningún vehículo con ese ID.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("asignarfaccionveh", setVehicleFaction)
addCommandHandler("asigfacveh", setVehicleFaction)

local itemsForTint = {
	[186] = true, -- Edge Cutter
	[188] = true, -- Tint Check
	[190] = true, -- Cutter Bucket
	[191] = true, -- Demonstration Lamp
	[192] = true, -- Angled Scraper
	[193] = true -- Hand Sprayer
}

local itemsForTintRemove = {
	[192] = true, -- Angled Scraper
	[260] = true, -- Ammonia
}

--Adding/Removing tint
function setVehTint(admin, command, target, status)
	local job = getElementData(admin, "job")
	if exports.integration:isPlayerTrialAdmin(admin) or (job==5) then
		if not (target) or not (status) then
			outputChatBox("SYNTAX: /" .. command .. " [Jugador] [0- Sin, 1- Con]", admin, 255, 194, 14)
		else
			local username = getPlayerName(admin):gsub("_"," ")
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(admin, target)

			if (targetPlayer) then
				local pv = getPedOccupiedVehicle(targetPlayer)
				if (pv) then

					if (job == 5) and not exports.integration:isPlayerTrialAdmin(admin) then
						if targetPlayer ~= admin then
							outputChatBox("Sólo puedes aplicarte tinte a ti mismo.", admin, 255, 0, 0)
							return
						end
					end

					local vid = getElementData(pv, "dbid")
					local stat = tonumber(status)
					if (stat == 1) then
						if (job == 5) and not exports.integration:isPlayerTrialAdmin(admin) then
							for k,v in pairs(itemsForTint) do
								if not exports["item-system"]:hasItem(admin, k) then
									outputChatBox("Le faltan los objetos necesarios para completar este tinte.", admin, 255, 0, 0)
									return
								end
							end
							for k,v in pairs(itemsForTint) do
								if not exports["item-system"]:takeItem(admin, k) then
									outputChatBox("Se ha producido un error al tomar el objeto. Por favor, informa de este error.", admin, 255, 0, 0)
									return
								end
							end
						end

						mysql:query_free("UPDATE vehicles SET tintedwindows = '1' WHERE id='" .. mysql:escape_string(vid) .. "'")
						for i = 0, getVehicleMaxPassengers(pv) do
							local player = getVehicleOccupant(pv, i)
							if (player) then
								triggerEvent("setTintName", pv, player)
							end
						end

						exports.anticheat:changeProtectedElementDataEx(pv, "tinted", true, true)
						triggerClientEvent("tintWindows", pv)
						outputChatBox("Ha añadido tinte al vehículo #" .. vid .. ".", admin)

						exports.logs:dbLog(admin, 6, {pv, targetPlayer}, "SETVEHTINT 1" )

						addVehicleLogs(vid, command.." on", admin)

					elseif (stat == 0) then
						if (job == 5) and not exports.integration:isPlayerTrialAdmin(admin) then
							for k,v in pairs(itemsForTintRemove) do
								if not exports["item-system"]:hasItem(admin, k) then
									outputChatBox("Le faltan los objetos necesarios para eliminar este tinte.", admin, 255, 0, 0)
									return
								end
							end
							for k,v in pairs(itemsForTintRemove) do
								if not exports["item-system"]:takeItem(admin, k) then
									outputChatBox("Se ha producido un error al tomar el objeto. Por favor, informe de este error.", admin, 255, 0, 0)
									return
								end
							end
						end
						mysql:query_free("UPDATE vehicles SET tintedwindows = '0' WHERE id='" .. mysql:escape_string(vid) .. "'")
						for i = 0, getVehicleMaxPassengers(pv) do
							local player = getVehicleOccupant(pv, i)
							if (player) then
								triggerEvent("resetTintName", pv, player)
							end
						end
						exports.anticheat:changeProtectedElementDataEx(pv, "tinted", false, true)
						triggerClientEvent("tintWindows", pv)
						outputChatBox("Ha quitado el tinte del vehículo #" .. vid .. ".", admin)

						exports.logs:dbLog(admin, 4, {pv, targetPlayer}, "SETVEHTINT 0" )
						addVehicleLogs(vid, command.." off", admin)
					end
				else
					outputChatBox("Jugador que no está en un vehículo.", admin, 255, 194, 14)
				end
			end
		end
	end
end
addCommandHandler("asigtinteveh", setVehTint)
addEvent("setvehtint", true)
addEventHandler("setvehtint", root, setVehTint)

function setVehiclePlate(thePlayer, theCommand, vehicleID, ...)
	if exports.integration:isPlayerTrialAdmin(thePlayer)  then
		if not (vehicleID) or not (...) then
			outputChatBox("SYNTAX: /" .. theCommand .. " [ID del vehículo] [Texto]", thePlayer, 255, 194, 14)
		else
			local theVehicle = exports.pool:getElement("vehicle", vehicleID)
			if theVehicle then
				--if exports.vehicle:hasVehiclePlates(theVehicle) then
					local plateText = table.concat({...}, " ")
					if (exports.vehicleplate:checkPlate(plateText)) then
						local cquery = mysql:query_fetch_assoc("SELECT COUNT(*) as no FROM `vehicles` WHERE `plate`='".. mysql:escape_string(plateText).."'")
						if (tonumber(cquery["no"]) == 0) then
							local insertnplate = mysql:query_free("UPDATE vehicles SET plate='" .. mysql:escape_string(plateText) .. "' WHERE id = '" .. mysql:escape_string(vehicleID) .. "'")
							local x, y, z = getElementPosition(theVehicle)
							local int = getElementInterior(theVehicle)
							local dim = getElementDimension(theVehicle)
							exports.vehicle:reloadVehicle(tonumber(vehicleID))
							local newVehicleElement = exports.pool:getElement("vehicle", vehicleID)
							setElementPosition(newVehicleElement, x, y, z)
							setElementInterior(newVehicleElement, int)
							setElementDimension(newVehicleElement, dim)
							outputChatBox("Done.", thePlayer)

							addVehicleLogs(vehicleID, theCommand.." "..plateText, thePlayer)
						else
							outputChatBox("Esta matrícula ya está en uso.", thePlayer, 255, 0, 0)
						end
					else
						outputChatBox("Texto de matrícula especificado no válido.", thePlayer, 255, 0, 0)
					end
				--else
				--	outputChatBox("This vehicle doesn't have any plates.", thePlayer, 255, 0, 0)
				--end
			else
				outputChatBox("No se han encontrado vehículos con ese ID.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("asignarmatriculaveh", setVehiclePlate)
addCommandHandler("asigmatriveh", setVehiclePlate)

-- /entercar
function warpPedIntoVehicle2(player, car, ...)
	local dimension = getElementDimension(player)
	local interior = getElementInterior(player)

	setElementDimension(player, getElementDimension(car))
	setElementInterior(player, getElementInterior(car))
	if warpPedIntoVehicle(player, car, ...) then
		exports.anticheat:setEld( player, "realinvehicle", 1 )
		return true
	else
		setElementDimension(player, dimension)
		setElementInterior(player, interior)
	end
	return false
end

function enterCar(thePlayer, commandName, targetPlayerName, targetVehicle, seat)
	if exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerSupporter(thePlayer) then
		targetVehicle = tonumber(targetVehicle)
		seat = tonumber(seat)
		if targetPlayerName and targetVehicle then
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayerName)
			if targetPlayer then
				local theVehicle = exports.pool:getElement("vehicle", targetVehicle)
				if theVehicle then
					if (isVehicleLocked(theVehicle)) then
						triggerEvent("lockUnlockOutsideVehicle", thePlayer, theVehicle)
					end

					if seat then
						local occupant = getVehicleOccupant(theVehicle, seat)
						if occupant then
							removePedFromVehicle(occupant)
							outputChatBox("Admin " .. getPlayerName(thePlayer):gsub("_", " ") .. " ha puesto " .. targetPlayerName .. " en tu asiento.", occupant)
							exports.anticheat:changeProtectedElementDataEx(occupant, "realinvehicle", 0, false)
						end

						if warpPedIntoVehicle2(targetPlayer, theVehicle, seat) then

							outputChatBox("Admin " .. getPlayerName(thePlayer):gsub("_", " ") .. " te ha metido en este " .. getVehicleName(theVehicle) .. ".", targetPlayer)
							outputChatBox("Has metido a  " .. targetPlayerName .. " en este  " .. getVehicleName(theVehicle) .. " #" .. targetVehicle .. ".", thePlayer)
						else
							outputChatBox("No se puede meter a " .. targetPlayerName .. " en este " .. getVehicleName(theVehicle) .. " #" .. targetVehicle .. ".", thePlayer, 255, 0, 0)
						end
					else
						local found = false
						local maxseats = getVehicleMaxPassengers(theVehicle) or 2
						for seat = 0, maxseats  do
							local occupant = getVehicleOccupant(theVehicle, seat)
							if not occupant then
								found = true
								if warpPedIntoVehicle2(targetPlayer, theVehicle, seat) then
									outputChatBox("Admin " .. getPlayerName(thePlayer):gsub("_", " ") .. " te ha metido en este " .. getVehicleName(theVehicle) .. ".", targetPlayer)
									outputChatBox("Has metido a " .. targetPlayerName .. " en este " .. getVehicleName(theVehicle) .. " #" .. targetVehicle .. ".", thePlayer)
								else
									outputChatBox("No se puede meter a " .. targetPlayerName .. " en este " .. getVehicleName(theVehicle) .. " #" .. targetVehicle .. ".", thePlayer, 255, 0, 0)
								end
								break
							end
						end

						if not found then
							outputChatBox("No hay asientos libres.", thePlayer, 255, 0, 0)
						end
					end

					addVehicleLogs(targetVehicle, commandName.." "..targetPlayerName, thePlayer)
				else
					outputChatBox("Vehículo no encontrado", thePlayer, 255, 0, 0)
				end
			end
		else
			outputChatBox("SYNTAX: /" .. commandName .. " [Jugador] [ID vehículo] [Asiento]", thePlayer, 255, 194, 14)
		end
	end
end
addCommandHandler("entrarveh", enterCar, false, false)
addCommandHandler("entrarvehiculo", enterCar, false, false)
addCommandHandler("meteraveh", enterCar, false, false)

function switchSeat(thePlayer, commandName, seat)
	if true then
		outputChatBox("Este comando está temporalmente desactivado.", thePlayer, 255, 0, 0)
		return false
	end
	if not tonumber(seat) then
		outputChatBox("SYNTAX: /" .. commandName .. " [Asiento]" ,thePlayer, 255, 194, 14)
	else
		seat = tonumber(seat)
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if theVehicle then

			local maxSeats = getVehicleMaxPassengers(theVehicle)
			if seat <= maxSeats then
				local occupant = getVehicleOccupant(theVehicle, seat)
				if not occupant then
					if seat == 0 then
						if not getElementData(thePlayer, "license.car.cangetin") and getElementData(theVehicle, "owner") == -2 then -- Fixed your script, Maxime. - Adams
							outputChatBox("(( Este coche DoL es sólo para el examen de conducir. ))", thePlayer, 255, 194, 14)
							return false
						end

						local job = getElementData(theVehicle, "job")
						if job ~= 0 then -- Fixed your script, Maxime. - Adams
							outputChatBox("(( Este vehículo es sólo para el sistema de trabajos. ))", thePlayer, 255, 194, 14)
							return false
						end
					end

					warpPedIntoVehicle2(thePlayer, theVehicle, seat)
					outputChatBox("Cambiaste de asiento "..seat..".", thePlayer, 0, 255, 0)
				else
					outputChatBox("No se puede cambiar de asiento.", thePlayer, 255, 0, 0)
				end
			else
				outputChatBox("No se puede cambiar de asiento.", thePlayer, 255, 0, 0)
			end
		else
			outputChatBox("No se puede cambiar de asiento.", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("cambiarasiento", switchSeat, false, false)

function setOdometer(thePlayer, theCommand, vehicleID, odometer)
	if exports.integration:isPlayerSeniorAdmin(thePlayer) or exports.integration:isPlayerScripter(thePlayer) or exports.integration:isPlayerVehicleConsultant(thePlayer) then
		if not tonumber(vehicleID) or not tonumber(odometer) then
			outputChatBox("SYNTAX: /" .. theCommand .. " [ID vehículo] [Cuentakilómetros]", thePlayer, 255, 194, 14)
			--outputChatBox("Remember to add three extra digits at the end. If desired odometer value is 222, write 222000", thePlayer, 255, 194, 14)
		else
			local theVehicle = exports.pool:getElement("vehicle", vehicleID)
			if theVehicle then
				local oldOdometer = tonumber(getElementData(theVehicle, 'odometer'))
				local actualOdometer = tonumber(odometer) * 1000
				if oldOdometer and exports.mysql:query_free("UPDATE vehicles SET odometer='" .. exports.mysql:escape_string(actualOdometer) .. "' WHERE id = '" .. exports.mysql:escape_string(vehicleID) .. "'") then
					addVehicleLogs(tonumber(vehicleID), "setodometer " .. odometer .. " (from " .. math.floor(oldOdometer/1000) .. ")", thePlayer)

					exports.anticheat:changeProtectedElementDataEx(theVehicle, 'odometer', actualOdometer, false )

					outputChatBox("Cuentakilómetros del vehículo puesto en " .. odometer .. ".", thePlayer, 0, 255, 0)
					for _, v in pairs(getVehicleOccupants(theVehicle)) do
						triggerClientEvent(v, "realism:distance", theVehicle, actualOdometer)
					end
				end
			end
		end
	end
end
addCommandHandler("asigcuentkm", setOdometer)
addCommandHandler("asignarcuentakilometros", setOdometer)

function damageproofVehicle(thePlayer, theCommand, theFaggot)
	if exports.integration:isPlayerLeadAdmin(thePlayer) then
		if not (theFaggot) then
			outputChatBox("SYNTAX: /" .. theCommand .. " [Nombre del jugador / ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, theFaggot)
			local targetVehicle = getPedOccupiedVehicle(targetPlayer)
			if not targetVehicle then
				outputChatBox("Este jugador no está en un vehículo.", thePlayer, 255, 0, 0)
				return
			end
			if targetVehicle then
				local vehID = getElementData(targetVehicle, "dbid")
				if isVehicleDamageProof(targetVehicle) then
					exports.mysql:query_free("UPDATE `vehicles` SET `bulletproof`='0' WHERE `id`='"..vehID.."'")
					setVehicleDamageProof(targetVehicle, false)
					exports.anticheat:setEld(targetVehicle, "bulletproof", 0 )
					outputChatBox("Este vehículo ya no es a prueba de daños.", targetPlayer)
					outputChatBox("Vehículo ID " .. vehID .. " ya no es a prueba de daños.", thePlayer)
					exports.logs:dbLog("ac"..tostring(getElementData(thePlayer, "dbid")), 4, "ve"..vehID, " Removed vehicle damage proof ")
				else
					setVehicleDamageProof(targetVehicle, true)
					exports.anticheat:setEld(targetVehicle, "bulletproof", 1 )
					exports.mysql:query_free("UPDATE `vehicles` SET `bulletproof`='1' WHERE `id`='"..vehID.."'")
					outputChatBox("Este vehículo es ahora a prueba de daños.", targetPlayer)
					outputChatBox("Vehículo ID " .. vehID .. " es ahora a prueba de daños.", thePlayer)
					exports.logs:dbLog("ac"..tostring(getElementData(thePlayer, "dbid")), 4, "ve"..vehID, " Enabled vehicle damage proof ")
				end
			end
		end
	end
end
addCommandHandler("asigapruebadaños", damageproofVehicle)
addCommandHandler("asigapruebabalas", damageproofVehicle)
addCommandHandler("aad", damageproofVehicle)
addCommandHandler("aab", damageproofVehicle)

function setVehicleTire(thePlayer, commandName, ...)
	if not exports.integration:isPlayerTrialAdmin(thePlayer) then
		return false
	end

	if not (...) then 
		outputChatBox("SYNTAX: /" .. commandName .. " [ID vehículo] [Rueda 1] [Rueda 2] [Rueda 3] [Rueda 4]", thePlayer, 255, 194, 14)
		outputChatBox("Si no está seguro de cómo utilizar este comando, consulte: https://wiki.multitheftauto.com/wiki/SetVehicleWheelStates", thePlayer, 255, 194, 14)
		return false
	end
		
	local args = {...}	
	local vehicle = exports.pool:getElement("vehicle", args[1])
	if vehicle then 
		setVehicleWheelStates(vehicle, args[2] or -1, args[3] or -1, args[4] or -1, args[5] or -1)
		outputChatBox("Se han establecido los estados de las ruedas para la identificación del vehículo #" .. args[1], thePlayer, 100, 255, 100)
	else
		outputChatBox("Vehículo #"..args[1].."no existe.", thePlayer, 255, 0, 0)
	end
end
addCommandHandler("asigestadoruedas", setVehicleTire)

function setVehicleAsHotwired(thePlayer, commandName, vin)
	if not exports.integration:isPlayerTrialAdmin(thePlayer) then
		return false
	end

	if not tonumber(vin) then 
		return outputChatBox("SYNTAX: /" .. commandName .. " [VIN]", thePlayer, 255, 0, 0)
	end

	local vehicle = exports.pool:getElement("vehicle", vin)
	if not vehicle then 
		return outputChatBox("El vehículo no existe.", thePlayer, 255, 0, 0)
	end

	local hotwiredData = getElementData(vehicle, "hotwired")
	if hotwiredData then 
		outputChatBox("Has hecho que este vehículo ya no sea puenteable", thePlayer, 255, 255, 128)
	else
		outputChatBox("Usted ha hecho este vehículo puenteable", thePlayer, 255, 255, 128)
	end

	setElementData(vehicle, "hotwired", not hotwiredData)
	dbExec(exports.mysql:getConn("mta"), "UPDATE vehicles SET hotwired = ? WHERE id = ?", (hotwiredData and 0 or 1), tonumber(vin))
	addVehicleLogs(vin , "SET TO " .. (hotwiredData and "NO LONGER ALLOW HOTWIRE START." or "ALLOW HOTWIRE START."), thePlayer )
	exports.logs:dbLog(thePlayer, 4, { vehicle, thePlayer } , "SET VEHICLE TO " .. (hotwiredData and "NO LONGER ALLOW HOTWIRE START." or "ALLOW HOTWIRE START."))
end
addCommandHandler("asigpuenteable", setVehicleAsHotwired)