mysql = exports.mysql

local smallRadius = 5 --units

-- /fingerprint
function fingerprintPlayer(thePlayer, commandName, targetPlayerNick)
	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then
		if exports.factions:isInFactionType(thePlayer, 2) then
			if not (targetPlayerNick) then
				outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick]", thePlayer, 255, 194, 14)
			else
				local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayerNick)

				if targetPlayer then
					local x, y, z = getElementPosition(thePlayer)
					local tx, ty, tz = getElementPosition(targetPlayer)

					local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)

					if (distance<=10) then
						local fingerprint = getElementData(targetPlayer, "fingerprint")
						outputChatBox(targetPlayerName .. " Huella Digital: " .. tostring(fingerprint) .. ".", thePlayer, 255, 194, 14)
					else
						outputChatBox("Estás demasiado lejos de " .. targetPlayerName .. ".", thePlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("fingerprint", fingerprintPlayer, false, false)

function tellNearbyPlayersVehicleStrobesOn()
	for _, nearbyPlayer in ipairs(exports.global:getNearbyElements(source, "player", 300)) do
		triggerClientEvent(nearbyPlayer, "forceElementStreamIn", source)
	end
end
addEvent("forceElementStreamIn", true)
addEventHandler("forceElementStreamIn", getRootElement(), tellNearbyPlayersVehicleStrobesOn)

function theftSystem(thePlayer, commandName, targetPlayer)
	local faction = exports.factions:getCurrentFactionDuty(thePlayer)
	if faction then
		local leader = exports.factions:hasMemberPermissionTo(thePlayer, faction, "respawn_vehs")
		local factionTeam = exports.factions:getFactionFromID(faction)
		local factionType = getElementData(factionTeam, "type")
		if (factionType==2) and (leader) then
			if not (targetPlayer) then
				outputChatBox("SYNTAX: /" .. commandName .. " [Partial Player Nick]", thePlayer, 255, 194, 14)
				return
			end
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			local targetVehicle = getPedOccupiedVehicle(targetPlayer)
			if exports.global:hasItem(targetVehicle, 138) then
				setVehicleEngineState(targetVehicle, false)
				exports.anticheat:changeProtectedElementDataEx(theVehicle, "engine", 0, true)
				setVehicleLocked (targetVehicle, true )
				exports.global:sendLocalDoAction(targetPlayer, "Escucharías un silencio repentino y un ligero chasquido cuando algunos pernos se deslizarían, bloqueando la puerta en su lugar.")
			else
				outputChatBox("Este vehículo no cuenta con el Sistema Antirrobo.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("emp", theftSystem, false, false)
