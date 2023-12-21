addEvent("lses:ped:start", true)

function lsesPedStart(pedName)
    exports['global']:sendLocalText(client, pedName .. " dice: ¡Hola, cómo puedo ayudarte hoy?", 255, 255, 255, 10)
end

addEventHandler("lses:ped:start", getRootElement(), lsesPedStart)

addEvent("lses:ped:help", true)

function lsesPedHelp(pedName)
    exports['global']:sendLocalText(client, pedName .. " dice: ¡Realmente! ¡Un momento!", 255, 255, 255, 10)
    exports['global']:sendLocalText(client, pedName .. " [RADIO]: ¡Alguien necesita asistencia en la recepción del hospital!", 255, 255, 255, 10)
    for key, value in ipairs(exports.factions:getPlayersInFaction(164)) do
        outputChatBox("[RADIO] Aquí despacho, tenemos un incidente, finalizando.", value, 0, 183, 239)
        outputChatBox("[RADIO] Situación: ¡Alguien necesita asistencia!, finalizando.  ((" .. getPlayerName(client):gsub("_", " ") .. "))", value, 0, 183, 239)
        outputChatBox("[RADIO] Ubicación: Hospital General All Saints, en la recepción, finalizando.", value, 0, 183, 239)
    end
end

addEventHandler("lses:ped:help", getRootElement(), lsesPedHelp)

addEvent("lses:ped:appointment", true)

function lsesPedAppointment(pedName)
    exports['global']:sendLocalText(client, pedName .. " dice: Notificaré a quien pueda, por favor, toma asiento mientras esperas.", 255, 255, 255, 10)
    for key, value in ipairs(exports.factions:getPlayersInFaction(164)) do
        outputChatBox("[RADIO] Recepción aquí, tenemos a alguien aquí para una cita, finalizando. ((" .. getPlayerName(client):gsub("_", " ") .. "))", value, 0, 183, 239)
        outputChatBox("[RADIO] Ubicación: Hospital General All Saints, en la recepción, finalizando.", value, 0, 183, 239)
    end
end

addEventHandler("lses:ped:appointment", getRootElement(), lsesPedAppointment)

function pedOutputChat(ped, chat, text, theClient, language)
    if not ped then return end
    if not client then client = theClient end
    if not client then return end
    if not tonumber(language) then language = 1 end
    if chat == "me" then
        local name = getElementData(ped, "name") or exports.global:getPlayerName(ped)
        local message = tostring(text)
        exports.global:sendLocalText(client, " *"..string.gsub(name, "_", " ")..(message:sub(1, 1) == "'" and "" or " ")..message, 255, 51, 102)
    elseif chat == "hospitalpa" then
        local name = getElementData(ped, "name") or exports.global:getPlayerName(ped)
        local message = tostring(text)
        exports['chat-system']:radio(ped, -5, message, chat)
    else
        exports['chat-system']:localIC(ped, tostring(text), language)
    end
end

addEvent("lses:ped:outputchat", true)
addEventHandler("lses:ped:outputchat", getResourceRootElement(), pedOutputChat)
