local mysql = exports.mysql

-- GET VEHICLE KEY OR INTERIOR KEY / MAXIME
function getKey(thePlayer, commandName)
	if exports.integration:isPlayerTrialAdmin(thePlayer)	then
		local adminName = getPlayerName(thePlayer):gsub(" ", "_")
		local veh = getPedOccupiedVehicle(thePlayer)
		if veh then
			local vehID = getElementData(veh, "dbid")
			
			givePlayerItem(thePlayer, "giveitem" , adminName, "3" , tostring(vehID))
			
			return true
		else
			local intID = getElementDimension(thePlayer)
			if intID then
				local foundIntID = false
				local keyType = false
				local possibleInteriors = getElementsByType("interior")
				for _, theInterior in pairs (possibleInteriors) do
					if getElementData(theInterior, "dbid") == intID then
						local intType = getElementData(theInterior, "status").type 
						if intType == 0 or intType == 2 or intType == 3 then
							keyType = 4 --Yellow key
						else
							keyType = 5 -- Pink key
						end
						foundIntID = intID
						break
					end
				end
				
				if foundIntID and keyType then
					givePlayerItem(thePlayer, "giveitem" , adminName, tostring(keyType) , tostring(foundIntID))
					
					return true
				else
					outputChatBox(" No estás en ningún vehículo o posible interior.", thePlayer, 255,0 ,0 )
					return false
				end
			end
		end
	end
end
addCommandHandler("getkey", getKey, false, false)

function generateFakeIdentity(player, cmd)
	if exports.integration:isPlayerLeadAdmin(player) then
		if getElementData(player, "fakename") then
			exports.anticheat:changeProtectedElementDataEx(player, "fakename", false, true)
			outputChatBox("Se eliminó la identidad falsa.",player)
			return false
		end
		
		local name = exports.global:createRandomMaleName()
		
		exports.anticheat:changeProtectedElementDataEx(player, "fakename", name, true)
		outputChatBox("Identidad falsa activada.",player)
		triggerEvent("fakemyid", player)
	end
end
addCommandHandler("fakeme", generateFakeIdentity, false, false)

function setSvPassword(thePlayer, commandName, password)
	if exports.integration:isPlayerLeadAdmin(thePlayer) or exports.integration:isPlayerLeadScripter(thePlayer) then
		outputChatBox("SINTAXIS: /" .. commandName .. " [Contraseña sin espacios, vacía para eliminar pw] - Establecer/eliminar la contraseña del servidor", thePlayer, 255, 194, 14)
		if password and string.len(password) > 0 then
			if setServerPassword(password) then
				exports.global:sendMessageToStaff("[SISTEMA] "..exports.global:getPlayerFullIdentity(thePlayer).." ha establecido la contraseña del servidor en '"..password.."'.", true)
			end
		else
			if setServerPassword('') then
				exports.global:sendMessageToStaff("[SISTEMA] "..exports.global:getPlayerFullIdentity(thePlayer).." ha eliminado la contraseña del servidor.", true)
			end
		end
	end
end
addCommandHandler("setserverpassword", setSvPassword, false, false)
addCommandHandler("setserverpw", setSvPassword, false, false)


