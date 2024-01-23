function toggleTrafficCam(thePlayer, commandName)
	local isLoggedIn = getElementData(thePlayer, "loggedin") or 0
	if (isLoggedIn == 1) then		
		-- factiontype == law
		if exports.factions:isInFactionType(thePlayer, 2) then
			local resultColshape
			local results = 0
			
			-- get current colshape
			for k, theColshape in ipairs(exports.pool:getPoolElementsByType("colshape")) do
				local isSpeedcam = getElementData(theColshape, "speedcam")
				if (isSpeedcam) then
					if (isElementWithinColShape(thePlayer, theColshape)) then
						resultColshape = theColshape
						results = results + 1
					end
				end
			end
			if (results == 0) then
				outputChatBox("El sistema devuelve un error: No se encontraron radares cercanos.", thePlayer,255,0,0)
			elseif (results > 1) then
				outputChatBox("El sistema devuelve un error: Demasiados radares cerca.", thePlayer, 255,0,0)
			else
				local gender = getElementData(thePlayer, "gender")
				local genderm = "his"
				if (gender == 1) then
					genderm = "her"
				end
			
				exports.global:sendLocalText(thePlayer, " *"..getPlayerName(thePlayer):gsub("_", " ") .." toca algunas teclas " .. genderm .. " computadora de datos móviles.", 255, 51, 102)
				local result = toggleTrafficCam(resultColshape)
				if (result == 0) then
					outputChatBox("Error SPDCM03, por favor informe a la mantis.", thePlayer, 255,0,0)
				elseif (result == 1) then
					outputChatBox("El radar ha sido apagado.", thePlayer, 0,255,0)
				else
					outputChatBox("El radar ha sido encendido.", thePlayer, 0,255,0)
				end
			end
		end
	end
end
addCommandHandler("togglespeedcam", toggleTrafficCam)