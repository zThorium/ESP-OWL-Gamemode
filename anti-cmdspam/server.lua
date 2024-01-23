local spam = {}
local uTimers = {}
local antispamCooldown = 5000
local LOG_COMMANDS = false
local resourceCache = false

function onCmd( commandName )
	if LOG_COMMANDS and not resourceCache then
		resourceCache = {}
		--store/sort commands in the table where key is resource and value is table with commands
		for _, subtable in pairs( getCommandHandlers() ) do
			local commandName = subtable[1]
			local theResource = subtable[2]
					
			resourceCache[commandName] = getResourceName(theResource)
		end
	end

	if not getElementData(source, "cmdDisabled") and commandName ~= 'Next' and commandName ~= 'Previous' then
		spam[source] = tonumber(spam[source] or 0) + 1
		local playerName = getPlayerName( source ):gsub('_', ' ')
		if spam[source] == 25 then
			outputChatBox('   Intente no enviar demasiado spam o sus comandos estarán deshabilitados..', source, 255,0,0)
			exports.global:sendMessageToAdmins("[ANTI-CMDSPAM] Jugador detectado '" .. playerName .. "' por posible spam "..tonumber(spam[source]).." comandos / "..(antispamCooldown/1000).." segundos. ('/"..commandName.."').")
		elseif spam[source] > 50 then
			exports.global:sendMessageToAdmins("[ANTI-CMDSPAM] Jugador '" .. playerName .. "' se le han desactivado los comandos spam "..tonumber(spam[source]).." comandos / "..(antispamCooldown/1000).." segundos. ('/"..commandName.."').")
			outputChatBox('   Su uso de comandos ha sido deshabilitado.', source, 255,0,0)
			exports.anticheat:changeProtectedElementDataEx(source, "cmdDisabled", true)
			spam[source] = 0
		end
	
		if isTimer(uTimers[source]) then
			killTimer(uTimers[source])
		end
	
		uTimers[source] = setTimer(	function (source)
			spam[source] = 0
			
			if isElement(source) and getElementData(source, "cmdDisabled") then
				exports.anticheat:changeProtectedElementDataEx(source, "cmdDisabled", false)
			end
		end, antispamCooldown, 1, source)
		if LOG_COMMANDS then
			theResource = "Unknown"
			if resourceCache[commandName] ~= nil then
				theResource = resourceCache[commandName]
			end
			outputServerLog('[CMD] '.. playerName ..' comando ejecutado /'.. commandName ..' por ' .. theResource)
			outputDebugString('[CMD] '.. playerName ..' comando ejecutado /'.. commandName ..' por ' .. theResource)
		end
	else
		cancelEvent()
	end
end
addEventHandler('onPlayerCommand', root, onCmd)

function quitPlayer()
	spam[source] = nil
end
addEventHandler("onPlayerQuit", root, quitPlayer)