backupBlip = false
backupPlayer = nil

function removeBackup(thePlayer, commandName)
    if (exports.integration:isPlayerTrialAdmin(thePlayer)) or (exports.factions:isInFactionType(thePlayer, 4) and exports.factions:hasMemberPermissionTo(thePlayer, 2, "add_member")) then
        if (backupPlayer ~= nil) then
            for k, v in ipairs(exports.factions:getPlayersInFaction(2)) do
                triggerClientEvent(v, "destroyBackupBlip2", getRootElement())
            end
            removeEventHandler("onPlayerQuit", backupPlayer, destroyBlip)
            removeEventHandler("savePlayer", backupPlayer, destroyBlip)
            backupPlayer = nil
            backupBlip = false
            outputChatBox("¡Sistema de asistencia SFES reiniciado!", thePlayer, 255, 194, 14)
        else
            outputChatBox("El sistema de asistencia SFES no necesitaba reinicio.", thePlayer, 255, 194, 14)
        end
    end
end
addCommandHandler("resetearasistencia", removeBackup, false, false)


function backup(thePlayer, commandName)
    local duty = tonumber(getElementData(thePlayer, "duty"))
    
    if exports.factions:isInFactionType(thePlayer, 4) and (duty > 0) then
        if (backupBlip == true) and (backupPlayer ~= thePlayer) then -- en uso
            outputChatBox("Ya hay una señal de asistencia en uso.", thePlayer, 255, 194, 14)
        elseif (backupBlip == false) then -- crear señal de asistencia
            backupBlip = true
            backupPlayer = thePlayer
            for k, v in ipairs(exports.factions:getPlayersInFaction(2)) do
                local duty = tonumber(getElementData(v, "duty"))
                
                if (duty > 0) then
                    triggerClientEvent(v, "createBackupBlip2", thePlayer)
                    outputChatBox("¡Una unidad necesita asistencia urgente! ¡Responde lo antes posible!", v, 255, 194, 14)
                end
            end

            addEventHandler("onPlayerQuit", thePlayer, destroyBlip)
            addEventHandler("savePlayer", thePlayer, destroyBlip)
            
        elseif (backupBlip == true) and (backupPlayer == thePlayer) then -- en uso por este jugador
            for key, v in ipairs(exports.factions:getPlayersInFaction(2)) do
                local duty = tonumber(getElementData(v, "duty"))
                
                if (duty > 0) then
                    triggerClientEvent(v, "destroyBackupBlip2", getRootElement())
                    outputChatBox("La unidad ya no necesita asistencia.", v, 255, 194, 14)
                end
            end

            removeEventHandler("onPlayerQuit", thePlayer, destroyBlip)
            removeEventHandler("savePlayer", thePlayer, destroyBlip)
            backupPlayer = nil
            backupBlip = false
        end
    end
end
addCommandHandler("asistir", backup, false, false)

function destroyBlip()
	for key, value in ipairs(exports.factions:getPlayersInFaction(2)) do
		outputChatBox("La unidad ya no necesita asistencia.", value, 255, 194, 14)
		triggerClientEvent(value, "destroyBackupBlip2", getRootElement())
	end
	removeEventHandler("onPlayerQuit", source, destroyBlip)
	removeEventHandler("savePlayer", source, destroyBlip)
	backupPlayer = nil
	backupBlip = false
end