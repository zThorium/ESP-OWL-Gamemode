mysql = exports.mysql

function awardPlayer(thePlayer, title, desc, gc)
	if gc and tonumber(gc) and tonumber(gc) >= 0 then
		if dbExec(exports.mysql:getConn("core"), "UPDATE `accounts` SET `credits`=credits+? WHERE `id`=?", gc, getElementData( thePlayer, "account:id") ) then
			local currentCredits = getElementData(thePlayer, "credits")
			setElementData(thePlayer, "credits", currentCredits + gc)
			triggerClientEvent(thePlayer, "displayAchievement", source or thePlayer, title, desc, gc)
			exports.donators:addPurchaseHistory(thePlayer, title or "LOGRO DESBLOQUEADO! "..(desc and ("("..desc..")") or ("")), tonumber(gc))
		else
			outputChatBox("Se suponía que ibas a ser recompensado con "..gc.."GCs.", thePlayer, 255, 0, 0)
			outputChatBox("Pero desafortunadamente, se produjo un error de MySQL y la adición de GC no se completó..", thePlayer, 255, 0, 0)
		end
	end
end
addEvent("awardPlayer", true)
addEventHandler("awardPlayer", root, awardPlayer)

function playSoundFx(thePlayer)
	triggerClientEvent(thePlayer, "playSoundFx", thePlayer)
end