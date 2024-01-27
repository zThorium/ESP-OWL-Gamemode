-- Set a train (de)railed
addCommandHandler("settrainrailed",
        function(player, cmd, vehicleID, state)
                if exports.integration:isPlayerTrialAdmin(player) then
                        local vehicleID = tonumber(vehicleID)
                        local state = tonumber(state)
                        if vehicleID then
                                local vehicle = exports.pool:getElement("vehicle", vehicleID)
                                if vehicle then
                                        if state == 0 then
                                                setTrainDerailed(vehicle, false)
                                        else
                                                setTrainDerailed(vehicle, true)
                                        end
                                        outputChatBox("Pones un tren (#" .. vehicleID .. ") " .. (state == 0 and "railed" or "derailed") .. ".", player, 0, 255, 0, false)
                                else
                                        outputChatBox("Vehículo no encontrado..", player, 255, 0, 0, false)
                                end
                        else
                                outputChatBox("SYNTAX: /" .. cmd .. " [ID del Vehículo] [0- Encarrilado, 1- Descarrilado]", player, 255, 194, 14, false)
                        end
                end
        end, false, false
)

-- Set a train's direction (clockwise or counterclockwise)
addCommandHandler("settraindirection",
        function(player, cmd, vehicleID, direction)
                if exports.integration:isPlayerTrialAdmin(player) then
                        local vehicleID = tonumber(vehicleID)
                        if vehicleID then
                                local vehicle = exports.pool:getElement("vehicle", vehicleID)
                                if vehicle then
                                        if state == 0 then
                                                setTrainDirection(vehicle, true)
                                        else
                                                setTrainDirection(vehicle, false)
                                        end
                                        outputChatBox("Pones un tren (#" .. vehicleID .. ") " .. (state == 0 and "CW" or "CCW") .. ".", player, 0, 255, 0, false)
                                else
                                        outputChatBox("Vehículo no encontrado.", player, 255, 0, 0, false)
                                end
                        else
                                outputChatBox("SYNTAX: /" .. cmd .. " [ID del Vehículo] [0- Dirección agujas del reloj, 1- Dirección opuesta agujas del reloj]", player, 255, 194, 14, false)
                        end
                end
        end, false, false
)
