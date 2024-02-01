addEvent("pd:ped:start", true)
function pdPedStart(pedName)
	exports['global']:sendLocalText(client, "Joe McDonald dice: Hola, ¿en qué puedo ayudarte?", 255, 255, 255, 10)
end
addEventHandler("pd:ped:start", getRootElement(), pdPedStart)

addEvent("pd:ped:help", true)
function pdPedHelp(pedName)
	exports['global']:sendLocalText(client,"Joe McDonald dice: Muy bien, notificaré cualquier unidad disponible ahora, espere pacientemente.", 255, 255, 255, 10)
	for key, value in ipairs( exports.factions:getPlayersInFaction(1) ) do
	outputChatBox("[RADIO] Aquí el despacho, tenemos a un civil en el lobby reportando un crimen. ((" .. getPlayerName(client):gsub("_"," ") .. "))", value, 0, 183, 239)
	end
end
addEventHandler("pd:ped:help", getRootElement(), pdPedHelp)

addEvent("pd:ped:appointment", true)
function pdPedAppointment(pedName)
	exports['global']:sendLocalText(client, "Joe McDonald dice: Notificaré a los oficiales disponibles ahora, por favor tomen asiento.", 255, 255, 255, 10)
	for key, value in ipairs( exports.factions:getPlayersInFaction(1) ) do
		outputChatBox("[RADIO] Aquí el despacho, tenemos un civil en el vestíbulo solicitando hablar con un oficial. ((" .. getPlayerName(client):gsub("_"," ") .. "))", value, 0, 183, 239)
	end
end
addEventHandler("pd:ped:appointment", getRootElement(), pdPedAppointment)