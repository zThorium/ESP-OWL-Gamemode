function tryLuck(thePlayer, commandName , pa1, pa2)
	local p1, p2, p3 = nil
	p1 = tonumber(pa1)
	p2 = tonumber(pa2)
	if pa1 == nil and pa2 == nil and pa3 == nil then
		exports.global:sendLocalText(thePlayer, "((OOC Luck)) "..getPlayerName(thePlayer):gsub("_", " ").." prueba suerte del 1 al 100 y consigue "..math.random(100)..".", 255, 51, 102, 30, {}, true)
	elseif pa1 ~= nil and p1 ~= nil and pa2 == nil then
		exports.global:sendLocalText(thePlayer, "((OOC Luck)) "..getPlayerName(thePlayer):gsub("_", " ").." prueba suerte del 1 al "..p1.." y consigue "..math.random(p1)..".", 255, 51, 102, 30, {}, true)
	else
		outputChatBox("SYNTAX: /" .. commandName.."                  - Obtener un número aleatorio del 1 al 100", thePlayer, 255, 194, 14)
		outputChatBox("SYNTAX: /" .. commandName.." [max]         - Obtenga un número aleatorio del 1 al [max]", thePlayer, 255, 194, 14)
	end
end
addCommandHandler("luck", tryLuck)

function tryChance(thePlayer, commandName , pa1, pa2)
	local p1, p2, p3 = nil
	p1 = tonumber(pa1)
	p2 = tonumber(pa2)
	if pa1 ~= nil then 
		if pa2 == nil and p1 ~= nil then
			if p1 <= 100 and p1 >=0 then
				if math.random(100) >= p1 then
					exports.global:sendLocalText(thePlayer, "((OOC Oportunidad en "..p1.."%)) "..getPlayerName(thePlayer):gsub("_", " ").." el intento ha fallado.", 255, 51, 102, 30, {}, true)
				else
					exports.global:sendLocalText(thePlayer, "((OOC Oportunidad en "..p1.."%)) "..getPlayerName(thePlayer):gsub("_", " ").." el intento ha tenido éxito.", 255, 51, 102, 30, {}, true)
				end
			else
				outputChatBox("La probabilidad debe oscilar entre 0 y 100%..", thePlayer, 255, 0, 0, true)
			end
		else
			outputChatBox("SYNTAX: /" .. commandName.." [0-100%]                 - Probabilidad de que tengas éxito con una probabilidad de [0-100%]", thePlayer, 255, 194, 14)
		end
	else
		outputChatBox("SYNTAX: /" .. commandName.." [0-100%]                 - Probabilidad de que tengas éxito con una probabilidad de [0-100%]", thePlayer, 255, 194, 14)
	end
end
addCommandHandler("chance", tryChance)

function oocCoin(thePlayer)
	if  math.random( 1, 2 ) == 2 then
		exports.global:sendLocalText(thePlayer, " ((OOC Coin)) " .. getPlayerName(thePlayer):gsub("_", " ") .. " lanza una moneda y aterriza sobre la cola.", 255, 51, 102)
	else
		exports.global:sendLocalText(thePlayer, " ((OOC Coin)) " .. getPlayerName(thePlayer):gsub("_", " ") .. " lanza una moneda y cae de cabeza.", 255, 51, 102)
	end
end
addCommandHandler("flipcoin", oocCoin)