local vehicleElements = {}

allVeh = {481,509,510}

local pickupTable = {
{2000.3034667969 ,-2275.4794921875 ,14.41695022583},
}

function createPickupOnServerStart ()
    for i, cor in ipairs (pickupTable) do
	    local pickup = createPickup(cor[1], cor[2], cor[3], 3, 1274, 0)
		setElementData(pickup, "pickupArenda", true)
	end
end
addEventHandler("onResourceStart", getResourceRootElement( getThisResource() ), createPickupOnServerStart)

function onResourceStop (veh)
    if isTimer(vehicleElements[veh]) then
        killTimer(vehicleElements[veh])
    end
    --vehicleElements[veh] = destroyElement(veh)
end
addEventHandler("onResourceStop", getResourceRootElement( getThisResource() ), onResourceStop)

function onPickupHit (hit)
    if not getElementData(source, "pickupArenda") or getElementType(hit) ~= "player" and not isPedInVehicle(hit) then return end
    triggerClientEvent(hit, "changeArendaMenuState", hit)
end
addEventHandler("onPickupHit", getRootElement(), onPickupHit)

function onPlayerUseCustomPickup()
	    if exports.global:hasMoney(source,1500) then
	    	local x, y, z = getElementPosition(source)
			local veh = createVehicle(allVeh[math.random(1,#allVeh)],  x, y, z)
			setElementData(veh, "starter_pack", true)
			setElementData(veh, "owner", source)
			warpPedIntoVehicle(source, veh)
			exports.global:takeMoney(source, 1500)
			
			
            outputChatBox("La bicicleta se creo con exito.", source, 0, 255, 0)
		else
		    outputChatBox("Para alquilar una bicicleta debes tener 1.500 pesos.", source, 255, 0, 0)
		end
end
addEvent("onPlayerUseCustomPickup", true)
addEventHandler("onPlayerUseCustomPickup", getRootElement(), onPlayerUseCustomPickup)

function onPlayerVehicleEnter (veh, seat)
    if getElementData(veh, "starter_pack") == true and seat == 0 then
	    if isTimer(vehicleElements[veh]) then
		    killTimer(vehicleElements[veh])
		end
	end
end
addEventHandler("onPlayerVehicleEnter", getRootElement(), onPlayerVehicleEnter)

function onPlayerVehicleExit (veh, seat)
    if getElementData(veh, "starter_pack") == true and seat == 0 then
	    if isTimer(vehicleElements[veh]) then
		    killTimer(vehicleElements[veh])
		end
		vehicleElements[veh] = setTimer(destroyElement, 30000, 1, veh)
	end
end
addEventHandler("onPlayerVehicleExit", getRootElement(), onPlayerVehicleExit)

function onVehicleStartEnter (player, seat)
    if getElementData(source, "starter_pack") == true and seat == 0 then
	    local owner = getElementData(source, "owner")
		if owner ~= player then
		    cancelEvent()
	        outputChatBox("Usted no es el propietario de esta bicicleta, pero puede alquilar otra por solo 1.500 pesos.", player, 255, 0, 0)
		end
	end
end
addEventHandler("onVehicleStartEnter", getRootElement(), onVehicleStartEnter)