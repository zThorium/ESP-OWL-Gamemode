function toggleLaser(thePlayer)
	local laser = getElementData(thePlayer, "laser")

	if not (laser) then
		exports.anticheat:changeProtectedElementDataEx(thePlayer, "laser", true, true)
		triggerClientEvent("addLaser", resourceRoot, thePlayer)
		outputChatBox("El láser de tu arma ahora está ENCENDIDO.",thePlayer, 0, 255, 0)
	else
		exports.anticheat:changeProtectedElementDataEx(thePlayer, "laser", false, true)
		triggerClientEvent("removeLaser", resourceRoot, thePlayer)
		outputChatBox("El láser de tu arma ahora está APAGADO.",thePlayer, 255, 0, 0)
	end
end
addCommandHandler("toglaser", toggleLaser, false)
addCommandHandler("togglelaser", toggleLaser, false)
