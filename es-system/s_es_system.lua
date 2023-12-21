mysql = exports.mysql

function playerDeath(totalAmmo, killer, killerWeapon)
	if getElementData(source, "dbid") then
		if getElementData(source, "adminjailed") then
			--local team = getPlayerTeam(source)
			spawnPlayer(source, 263.821807, 77.848365, 1001.0390625, 270) --, team)

			setElementModel(source,getElementModel(source))
			--setPlayerTeam(source, team)
			setElementInterior(source, 6)
			setElementDimension(source, getElementData(source, "playerid")+65400)

			setCameraInterior(source, 6)
			setCameraTarget(source)
			fadeCamera(source, true)

			exports.logs:dbLog(source, 34, source, "murió en jail administrativo")
		elseif getElementData(source, "jailed") then
			exports["prison-system"]:checkForRelease(source)
			--[[ local x, y, z = getElementPosition(source)
			local int = getElementInterior(source)
			local dim = getElementDimension(source)
			spawnPlayer(source, x, y, z, 270, getElementModel(source), int, dim, getPlayerTeam(source))
			setCameraInterior(source, int)
			setCameraTarget(source)--]]

			exports.logs:dbLog(source, 34, source, "murió en jail policial")
		else
			local affected = { }
			table.insert(affected, source)
			local killstr = ' died'
			if (killer) then
				if getElementType(killer) == "player" then
					if (killerWeapon) then
						killstr = ' fue asesinado por '..getPlayerName(killer):gsub("_", " ").. ' ('..getWeaponNameFromID ( killerWeapon )..')'
					else
						killstr = ' murió'
					end
					table.insert(affected, killer)
				else
				killstr = ' got killed by an unknown source'
				table.insert(affected, "Unknown")
				end
			end
			-- Remove seatbelt if theres one on
			if 	(getElementData(source, "seatbelt") == true) then
				exports.anticheat:changeProtectedElementDataEx(source, "seatbelt", false, true)
			end

			local victimDropItem = false

			-- if killer and (getElementData(killer, "hoursplayed" ) >= 20) then
				-- victimDropItem = true
			-- end
			changeDeathViewTimer = setTimer(changeDeathView, 3000, 1, source, victimDropItem)

			outputChatBox("Si te mataron debido a DM o algo similar, /report para que un administrador te resucite.", source)
			outputChatBox("Si acepta su muerte, puede perder algunos de sus artículos, a menos que sea revivido.", source)

			--outputChatBox("Respawn in 10 seconds.", source)
			--setTimer(respawnPlayer, 10000, 1, source)

			exports.logs:dbLog(source, 34, affected, killstr)
			exports.anticheat:changeProtectedElementDataEx(source, "lastdeath", " [KILL] "..getPlayerName(source):gsub("_", " ") .. killstr, true)
		end
	end
end
addEventHandler("onPlayerWasted", getRootElement(), playerDeath)

function changeDeathView(source, victimDropItem)
	if isElement(source) and isPedDead(source) then
		local x, y, z = getElementPosition(source)
		local rx, ry, rz = getElementRotation(source)
		setCameraMatrix(source, x+6, y+6, z+3, x, y, z)
		triggerClientEvent(source,"es-system:showRespawnButton",source, victimDropItem)
	end
end

function acceptDeath(victimDropItem)
	if isPedDead(client) then
		if victimDropItem then
			local x, y, z = getElementPosition(client)
			for key, item in pairs(exports["item-system"]:getItems(client)) do
				itemID = tonumber(item[1])
				local ammo = false
				if itemID == 116 then
					ammo = exports.global:explode( ":", item[2]  )[2]
				end
				local keepammo = false
				if itemID == 116 or itemID == 115 or itemID == 134 then
					triggerEvent("dropItemOnDead", client, itemID, item[2], x, y, z, ammo, false)
				end
			end
		end

		fadeCamera(client, true)
		outputChatBox("Respawning...", client)
		if isTimer(changeDeathViewTimer) == true then
			killTimer(changeDeathViewTimer)
		end
		respawnPlayer(client, victimDropItem)
		setElementData(client, "canFly", false)
	else
		outputChatBox("You aren't dead!", client, 255, 0, 0)
	end
end
addEvent("es-system:acceptDeath", true)
addEventHandler("es-system:acceptDeath", getRootElement(), acceptDeath)

function logMe( message )
	local logMeBuffer = getElementData(getRootElement(), "killog") or { }
	local r = getRealTime()
	exports.global:sendMessageToAdmins(message)
	table.insert(logMeBuffer,"["..("%02d:%02d"):format(r.hour,r.minute).. "] " ..  message)

	if #logMeBuffer > 30 then
		table.remove(logMeBuffer, 1)
	end
	setElementData(getRootElement(), "killog", logMeBuffer)
end

function logMeNoWrn( message )
	local logMeBuffer = getElementData(getRootElement(), "killog") or { }
	local r = getRealTime()
	table.insert(logMeBuffer,"["..("%02d:%02d"):format(r.hour,r.minute).. "] " ..  message)

	if #logMeBuffer > 30 then
		table.remove(logMeBuffer, 1)
	end
	setElementData(getRootElement(), "killog", logMeBuffer)
end

function readLog(thePlayer)
	if exports.integration:isPlayerTrialAdmin(thePlayer) then
		local logMeBuffer = getElementData(getRootElement(), "killog") or { }
		outputChatBox("Lista de muertes recientes:", thePlayer, 205, 201, 165)
		for a, b in ipairs(logMeBuffer) do
			outputChatBox("- "..b, thePlayer, 205, 201, 165, true)
		end
		outputChatBox("  END", thePlayer, 205, 201, 165)
	end
end
addCommandHandler("showkills", readLog)

function fallProtection(intx, inty, intz)
	local int = getElementInterior(client)
	local dim = getElementDimension(client)
	if isPedDead  ( client ) then
		triggerClientEvent(targetPlayer,"es-system:closeRespawnButton",client)
		if isTimer(changeDeathViewTimer) == true then
			killTimer(changeDeathViewTimer)
		end

		setPedHeadless(client, false)
		setCameraInterior(client, int)
		setCameraTarget(client, client)
		spawnPlayer(client, intx, inty, intz, 0)

		local skin = getElementModel(client)
		setElementModel(client,skin)
		triggerEvent("updateLocalGuns", client)
		exports.global:sendMessageToAdmins("AdmCmd: Fall protection revived "..tostring(getPlayerName(client))..".")
		exports.logs:dbLog(client, 4, client, "REVIVED from PK(Fall Protection)")
	else
		setElementPosition(client, intx, inty, intz)
	end
	setElementInterior(client, int)
	setElementDimension(client, dim)
end
addEvent("fallProtectionRespawn", true)
addEventHandler("fallProtectionRespawn", root, fallProtection)

function respawnPlayer(thePlayer, victimDropItem)
	if (isElement(thePlayer)) then

		if (getElementData(thePlayer, "loggedin") == 0) then
			exports.global:sendMessageToAdmins("AC0x0000004: "..getPlayerName(thePlayer):gsub("_", " ").." murió mientras no estaba en el personaje, lo que provocó un desvanecimiento negro.")
			return
		end
		setPedHeadless(thePlayer, false)

		local cost = math.random(175, 500)
		local tax = exports.global:getTaxAmount()

		exports.global:giveMoney( exports.factions:getFactionFromID(2), math.ceil((1-tax)*cost) )
		exports.global:takeMoney( getTeamFromName("Government of Los Santos"), math.ceil((1-tax)*cost) )

		mysql:query_free("UPDATE characters SET deaths = deaths + 1, health=50 WHERE charactername='" .. mysql:escape_string(getPlayerName(thePlayer)) .. "'")

		setCameraInterior(thePlayer, 0)

		setCameraTarget(thePlayer, thePlayer)

		outputChatBox("You have recieved treatment from Los Santos Fire Department.", thePlayer, 255, 255, 0)

		-- take all drugs
		local count = 0
		for i = 30, 43 do
			while exports.global:hasItem(thePlayer, i) do
				local number = exports['item-system']:countItems(thePlayer, i)
				exports.global:takeItem(thePlayer, i)
				exports.logs:dbLog(thePlayer, 34, thePlayer, "lost "..number.."x item "..tostring(i))
				count = count + 1
			end
		end
		if count > 0 then
			outputChatBox("LSFD Empleado: Entregamos sus drogas al SFPD.", thePlayer, 255, 194, 14)
		end

		-- take guns
		local removedWeapons = nil
		if not victimDropItem then
			local gunlicense = tonumber(getElementData(thePlayer, "license.gun"))
			local gunlicense2 = tonumber(getElementData(thePlayer, "license.gun2"))
			local items = exports['item-system']:getItems( thePlayer ) -- [] [1] = itemID [2] = itemValue

			local formatedWeapons
			local cor = 0
			for itemSlot, itemCheck in ipairs(items) do
				if itemCheck[1] == 115 then -- Weapon
					-- itemCheck[2]: [1] = gta weapon id, [2] = serial number/Amount of bullets, [3] = weapon/ammo name
					local itemCheckExplode = exports.global:explode(":", itemCheck[2])
					local weapon = tonumber(itemCheckExplode[1])
					if (((weapon >= 16 and weapon <= 40 and (gunlicense == 0 and gunlicense2 == 0) or not exports.weapon:isWeaponCCWP(thePlayer, itemCheck[1], itemCheck[2])) or (weapon == 29 or weapon == 30 or weapon == 32 or weapon ==31 or weapon == 34) and (gunlicense2 == 0)) and (not exports.factions:isInFactionType(thePlayer, 2))) or (weapon >= 35 and weapon <= 38) then
						if exports['item-system']:takeItemFromSlot(thePlayer, itemSlot-cor) then
							cor = cor + 1
							exports.logs:dbLog(thePlayer, 34, thePlayer, "perdió un arma (" ..  itemCheck[2] .. ")")
							for k = 1, 12 do
								triggerEvent("createWepObject", thePlayer, thePlayer, k, 0, getSlotFromWeapon(k))
							end

							if (removedWeapons == nil) then
								removedWeapons = itemCheckExplode[3]
								formatedWeapons = itemCheckExplode[3]
							else
								removedWeapons = removedWeapons .. ", " .. itemCheckExplode[3]
								formatedWeapons = formatedWeapons .. "\n" .. itemCheckExplode[3]
							end
						end
					end
				elseif itemCheck[1] == 116 then
					-- itemCheck[2]: [1] = cartridge id [2] = ammo
					local itemCheckExplode = exports.global:explode(":", itemCheck[2])
					local cart_id = tonumber(itemCheckExplode[1])
					local ammountOfAmmo = tonumber(itemCheckExplode[2])
					if cart_id and gunlicense == 0 and gunlicense2 == 0 then
						if exports['item-system']:takeItemFromSlot(thePlayer, itemSlot-cor) then
							cor = cor+1
							local pack = exports.weapon:getAmmo(cart_id)
							exports.logs:dbLog(thePlayer, 34, thePlayer, "perdí un paquete de "..pack.cartridge.." munición. ("..ammountOfAmmo.." rondas)")

							if (removedWeapons == nil) then
								removedWeapons = ammountOfAmmo .. " " .. pack.cartridge
								formatedWeapons = ammountOfAmmo .. " " .. pack.cartridge
							else
								removedWeapons = removedWeapons .. ", " .. ammountOfAmmo .. " rondas de " .. pack.cartridge
								formatedWeapons = formatedWeapons .. "\n" .. ammountOfAmmo .. " rondas de " .. pack.cartridge
							end
						end
					end
				end
			end
		end

		if (removedWeapons~=nil) then
			if gunlicense == 0 and factiontype ~= 2 then
				outputChatBox("Empleado de LSFD: Le hemos quitado armas para las que no tenía licencia. (" .. removedWeapons .. ").", thePlayer, 255, 194, 14)
			else
				outputChatBox("Empleado de LSFD: Le hemos quitado las armas que no puede portar. (" .. removedWeapons .. ").", thePlayer, 255, 194, 14)
			end
		end

		local death = getElementData(thePlayer, "lastdeath")
		if removedWeapons ~= nil then
			logMe(death)
			exports.global:sendMessageToAdmins("/showkills para ver armas perdidas.")
			logMeNoWrn("#FF0033 Armas Perdidas: " .. removedWeapons)
		else
			logMe(death)
		end

		local theSkin = getPedSkin(thePlayer)
		--local theTeam = getPlayerTeam(thePlayer)

		local fat = getPedStat(thePlayer, 21)
		local muscle = getPedStat(thePlayer, 23)

		spawnPlayer(thePlayer, 1176.892578125, -1323.828125, 14.04377746582, 275)--, theTeam)
		setElementModel(thePlayer,theSkin)
		--setPlayerTeam(thePlayer, theTeam)
		setElementInterior(thePlayer, 0)
		setElementDimension(thePlayer, 0)

		setPedStat(thePlayer, 21, fat)
		setPedStat(thePlayer, 23, muscle)

		fadeCamera(thePlayer, true, 6)
		triggerClientEvent(thePlayer, "fadeCameraOnSpawn", thePlayer)
		triggerEvent("updateLocalGuns", thePlayer)
		setElementHealth(thePlayer, 50)
	end
end

function recoveryPlayer(thePlayer, commandName, targetPlayer, duration)
    if not (targetPlayer) or not tonumber(duration) or (tonumber(duration) or 0) <= 0 then
        outputChatBox("SINTAXIS: /" .. commandName .. " [Nombre/ID parcial del jugador] [Horas]", thePlayer, 255, 194, 14)
    else
        local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
        if targetPlayer then
            local logged = getElementData(thePlayer, "loggedin")

            if (logged == 1) then
                if exports.factions:isInFactionType(thePlayer, 4) or (exports.integration:isPlayerTrialAdmin(thePlayer) == true) then
                    local dimension = getElementDimension(thePlayer)
                    
                    local totaltime = tonumber(duration)
                    if totaltime < 12 then
                        exports.bank:takeBankMoney(targetPlayer, 100 * totaltime, true)
                        exports.global:giveMoney(exports.factions:getFactionFromID(2), 100 * totaltime)

                        local dbid = getElementData(targetPlayer, "dbid")
                        local timeLeft = getRealTime().timestamp + totaltime * 3600
                        mysql:query_free("UPDATE characters SET recovery='1', recoverytime='" .. timeLeft .. "' WHERE id = " .. dbid)

                        setElementFrozen(targetPlayer, true)
                        setElementData(targetPlayer, "recovery", true)
                        outputChatBox("Has puesto exitosamente a " .. targetPlayerName .. " en recuperación durante " .. duration .. " hora(s) y le cobraste $" .. 100 * totaltime .. ".", thePlayer, 255, 0, 0)
                        exports.global:sendMessageToAdmins("AdmAdvert: " .. targetPlayerName .. " fue puesto en recuperación durante " .. duration .. " hora(s) por " .. getPlayerName(thePlayer):gsub("_", " ") .. ".")
                        outputChatBox("Has sido puesto en recuperación por " .. getPlayerName(thePlayer) .. " durante " .. duration .. " hora(s) y te han cobrado $" .. 100 * totaltime .. ".", targetPlayer, 255, 0, 0)
                        exports.logs:dbLog(thePlayer, 4, targetPlayer, "RECUPERACIÓN " .. duration)
                    else
                        outputChatBox("No puedes poner a alguien en recuperación por tanto tiempo.", thePlayer, 255, 0, 0)
                    end
                else
                    outputChatBox("No tienes habilidades médicas básicas, contacta con el personal de Emergencias Sanitarias (ES).", thePlayer, 255, 0, 0)
                end
            else
                outputChatBox("El jugador no ha iniciado sesión.", thePlayer, 255, 0, 0)
            end
        end
    end
end

addCommandHandler("recuperacion", recoveryPlayer)


function scanForRecoveryRelease(player, eventname)
	local tick = getTickCount()
	local counter = 0
	local players = exports.pool:getPoolElementsByType("player")
	for key, value in ipairs(players) do
		local logged = getElementData(value, "loggedin")
		if (logged==1) then -- Check all logged in players.
			local dbid = getElementData(value, "dbid")
			local result = mysql:query_fetch_assoc( "SELECT `recovery`, `recoverytime` FROM `characters` WHERE `id`=" .. mysql:escape_string(dbid) ) -- Check to see if the player is listed as a current recovery patient.
			local inRecovery = tonumber(result["recovery"])
			if (inRecovery == 1) then
				local recoveryEndsAt = tonumber(result["recoverytime"])
				local currentTime = getRealTime().timestamp
				if (recoveryEndsAt <= currentTime) then -- Is the time up? If yes:
					setElementFrozen(value, false)
					setElementData(value, "recovery", false)
					mysql:query_free("UPDATE characters SET recovery='0', recoverytime=NULL WHERE id = " .. dbid) -- Allow them to move, and revert back to recovery type set to 0.
					outputChatBox("¡Ya no estás en recuperación!", value, 0, 255, 0) -- Let them know about it!
				else
					setElementFrozen(value, true) -- If they are still in recovery, then make sure they are frozen (if they login).
					setElementData(value, "recovery", true)
					if (player==value) and (eventname=="accounts:characters:spawn") then
						outputChatBox("Aun estas en recuperacion.", value, 255,0,0)
					end
				end
			end
		end
	end
	local tickend = getTickCount()
end
setTimer(scanForRecoveryRelease, 500000, 0) -- Check every 5 minutes.

function checktime(thePlayer)
    local logged = getElementData(thePlayer, "loggedin")
    if (logged == 1) then
        local dbid = getElementData(thePlayer, "dbid")
        local result = mysql:query_fetch_assoc("SELECT `recovery`, `recoverytime` FROM `characters` WHERE `id`=" .. mysql:escape_string(dbid)) -- Verificar si el jugador está registrado como paciente actual en recuperación.
        local inRecovery = tonumber(result["recovery"])
        if (inRecovery == 1) then
            local recoveryEndsAt = tonumber(result["recoverytime"])
            local currentTime = getRealTime().timestamp
            if (recoveryEndsAt <= currentTime) then -- ¿Es el momento? Si sí:
                setElementFrozen(thePlayer, false)
                setElementData(thePlayer, "recovery", false)
                mysql:query_free("UPDATE characters SET recovery='0', recoverytime=NULL WHERE id = " .. dbid) -- Permitirles moverse y volver al tipo de recuperación establecido en 0.
                outputChatBox("¡Ya no estás en recuperación!", thePlayer, 0, 255, 0) -- ¡Avísales!
            else
                recoveryEndsAt = recoveryEndsAt - currentTime
                local hoursLeft = math.floor(recoveryEndsAt / 3600)
                recoveryEndsAt = recoveryEndsAt - 3600 * hoursLeft
                local minutesLeft = math.floor(recoveryEndsAt / 60)
                outputChatBox("Te quedan " .. hoursLeft .. " hora(s) y " .. minutesLeft .. " minuto(s) de recuperación.", thePlayer)
            end
        end
    end
end

addCommandHandler("tiemporecuperacion", checktime)


function scanForRecoveryReleaseF10(player, eventname)
	if source and (not player or not isElement(player) or getElementType(player) ~= 'player') then
		player = source
	end

	local logged = getElementData(player, "loggedin")
	if (logged==1) then
		local dbid = getElementData(player, "dbid")
		local result = mysql:query_fetch_assoc( "SELECT `recovery`, `recoverytime` FROM `characters` WHERE `id`=" .. mysql:escape_string(dbid) ) -- Check to see if the player is listed as a current recovery patient.
		local inRecovery = tonumber(result["recovery"])
		if (inRecovery == 1) then
			local recoveryEndsAt = tonumber(result["recoverytime"])
			local currentTime = getRealTime().timestamp
			if (recoveryEndsAt <= currentTime) then -- Is the time up? If yes:
				setElementFrozen(player, false)
				setElementData(player, "recovery", false)
				mysql:query_free("UPDATE characters SET recovery='0', recoverytime=NULL WHERE id = " .. dbid) -- Allow them to move, and revert back to recovery type set to 0.
				outputChatBox("Ya no estas en recuperacion!", player, 0, 255, 0) -- Let them know about it!
			else
				setElementFrozen(player, true) -- If they are still in recovery, then make sure they are frozen (if they login).
				setElementData(player, "recovery", true)
				outputChatBox("Sigues en recuperacion", player, 255,0,0)
			end
		end
	end
end
addEventHandler("accounts:characters:spawn", getRootElement(), scanForRecoveryReleaseF10)

function prescribe(thePlayer, commandName, ...)
	if exports.factions:isInFactionType(thePlayer, 4) then
		if not (...) then
			outputChatBox("SINTAXIS /" .. nombreComando .. " [valor de la receta]", elJugador, 255, 184, 22)
		else
			local itemValue = table.concat({...}, " ")
			itemValue = tonumber(itemValue) or itemValue
			if not(itemValue=="") then
				exports.global:giveItem( thePlayer, 132, itemValue )
				outputChatBox("La receta '" .. valorReceta .. "' ha sido procesada.", elJugador, 0, 255, 0)
				--exports.global:sendMessageToAdmins(getPlayerName(thePlayer):gsub("_"," ") .. " has made a prescription with the value of: " .. itemValue .. ".")
				exports.logs:dbLog(thePlayer, 4, thePlayer, "RECETA " .. itemValue)
			end
		end
	end
end
addCommandHandler("recetar", prescribe)

-- /revive
function revivePlayerFromPK(elJugador, nombreComando, jugadorObjetivo)
	if (exports.integration:isPlayerTrialAdmin(elJugador)) then
		if not (jugadorObjetivo) then
			outputChatBox("SINTAXIS: /" .. nombreComando .. " [Nombre parcial del jugador / ID]", elJugador, 255, 194, 14)
		else
			local jugadorObjetivo, nombreJugadorObjetivo = exports.global:findPlayerByPartialNick(elJugador, jugadorObjetivo)

			if jugadorObjetivo then
				if isPedDead(jugadorObjetivo) then
					triggerClientEvent(jugadorObjetivo, "es-system:closeRespawnButton", jugadorObjetivo)
					if isTimer(changeDeathViewTimer) == true then
						killTimer(changeDeathViewTimer)
					end

					local x, y, z = getElementPosition(jugadorObjetivo)
					local int = getElementInterior(jugadorObjetivo)
					local dim = getElementDimension(jugadorObjetivo)
					local skin = getElementModel(jugadorObjetivo)

					setPedHeadless(jugadorObjetivo, false)
					setCameraInterior(jugadorObjetivo, int)
					setCameraTarget(jugadorObjetivo, jugadorObjetivo)
					spawnPlayer(jugadorObjetivo, x, y, z, 0)

					setElementModel(jugadorObjetivo, skin)
					setElementInterior(jugadorObjetivo, int)
					setElementDimension(jugadorObjetivo, dim)
					triggerEvent("updateLocalGuns", jugadorObjetivo)

					local tituloAdmin = tostring(exports.global:getPlayerAdminTitle(elJugador))
					outputChatBox("Has sido revivido por " .. tituloAdmin .. " " .. tostring(getPlayerName(elJugador):gsub("_", " ")) .. ".", jugadorObjetivo, 0, 255, 0)
					outputChatBox("Has revivido a " .. tostring(getPlayerName(jugadorObjetivo):gsub("_", " ")) .. ".", elJugador, 0, 255, 0)
					exports.global:sendMessageToAdmins("CmdAdm: " .. tituloAdmin .. " " .. getPlayerName(elJugador) .. " revivió a " .. tostring(getPlayerName(jugadorObjetivo)) .. ".")
					exports.logs:dbLog(elJugador, 4, jugadorObjetivo, "REVIVIDO desde PK")
				else
					outputChatBox(tostring(getPlayerName(jugadorObjetivo):gsub("_", " ")) .. " no está muerto.", elJugador, 255, 0, 0)
				end
			end
		end
	end
end

addCommandHandler("revivir", revivePlayerFromPK, false, false)


local medicalBillFactions = {
		[164] = true, --ASH
	}
local medicalBillInsuranceCoverage = 0.95
local medicalBillMinimumSelfCoverage = 500
function medicalBill(thePlayer, commandName, targetPlayer, amount)
	local dutyFaction = exports.factions:getCurrentFactionDuty(thePlayer)
	if medicalBillFactions[dutyFaction] then
		if not (targetPlayer) or not tonumber(amount) or (tonumber(amount) or 0) <= 0 then
			outputChatBox("SINTAXIS: /" .. commandName .. " [Nombre parcial del jugador / ID] [Monto]", thePlayer, 255, 194, 14)
		else
			amount = tonumber(amount)
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			if targetPlayer then
				local logged = getElementData(thePlayer, "loggedin")
				if (logged==1) then
					local insurance = 0
					if amount > medicalBillMinimumSelfCoverage then
						insurance = math.floor(amount * medicalBillInsuranceCoverage)
					end
					local toPay = amount - insurance
					if toPay <= medicalBillMinimumSelfCoverage then
						local diff = medicalBillMinimumSelfCoverage - toPay
						if diff > 0 then
							insurance = insurance - diff
						end
					end
					if insurance < 0 then insurance = 0 end
					local date = getRealTime()

					local rankName
					local rank = exports.factions:getPlayerFactionRank(thePlayer, dutyFaction)
					local team = exports.factions:getFactionFromID(dutyFaction)
					local factionRanks = getElementData(team, "ranks")
					if factionRanks then
						rankName = factionRanks[rank]
					else
						rankName = false
						outputDebugString("medicalBill() failed to get rankName.")
						outputDebugString("rank="..tostring(rank).." faction="..tostring(dutyFaction).." team="..tostring(team).. "ranks="..tostring(factionRanks))
					end

					triggerClientEvent(targetPlayer, "es-system:medicalBillClient", targetPlayer, amount, insurance, dutyFaction, thePlayer, date, rankName)
					outputChatBox("Factura médica enviada a"..tostring(targetPlayerName)..".", thePlayer, 245, 217, 7)
				else
					outputChatBox("El jugador no esta conectado.", thePlayer, 255,0,0)
				end
			else
				outputChatBox("Jugador no encontrado.", thePlayer, 255,0,0)
			end
		end
	end
end
addCommandHandler("factura", medicalBill)

function pagarFacturaMedica(cliente, doctor, faccion, monto, seguro, accion)
	if not client then client = cliente end
	local aPagar = monto - seguro
	if accion == 1 then --pagar en efectivo
		if exports.global:takeMoney(client, aPagar) then
			local elEquipo = exports.factions:getFactionFromID(faccion)
			if exports.global:giveMoney(elEquipo, monto) then
				local nombre = exports.global:getPlayerName(client):gsub("_", " ")
				mysql:query_free("INSERT INTO wiretransfers (`from`, `to`, `amount`, `reason`, `type`) VALUES (0, " .. mysql:escape_string(-getElementData(elEquipo, "id")) .. ", " .. mysql:escape_string(monto) .. ", 'Factura médica para "..nombre.."', 13)" )
				outputChatBox("Pagaste tu factura médica ($"..tostring(exports.global:formatMoney(monto))..").", client, 0, 250, 0)
				outputChatBox(nombre.." pagó su factura médica ($"..tostring(exports.global:formatMoney(monto))..").", doctor, 0, 250, 0)
			end
		else
			outputChatBox("No tienes suficiente efectivo para pagar la factura. Se tomará del banco en su lugar.", client, 255, 0, 0)
			pagarFacturaMedica(client, doctor, faccion, monto, seguro, 2)

			local nombre = exports.global:getPlayerName(client):gsub("_", " ")
			outputChatBox(nombre.." no pudo pagar la factura médica.", doctor, 255, 0, 0)
		end
	elseif accion == 2 then --pagar desde el banco
		if exports.bank:hasBankMoney(client, aPagar) then
			if exports.bank:takeBankMoney(client, aPagar) then
				local elEquipo = exports.factions:getFactionFromID(faccion)
				if exports.global:giveMoney(elEquipo, monto) then
					local nombre = exports.global:getPlayerName(client):gsub("_", " ")
					if seguro > 0 then
						mysql:query_free("INSERT INTO wiretransfers (`from`, `to`, `amount`, `reason`, `type`) VALUES (0, " .. mysql:escape_string(getElementData(client, "dbid")) .. ", " .. mysql:escape_string(seguro) .. ", 'Reclamo de seguro para factura médica', 3)" )
					end
					mysql:query_free("INSERT INTO wiretransfers (`from`, `to`, `amount`, `reason`, `type`) VALUES (" .. mysql:escape_string(getElementData(client, "dbid")) .. ", " .. mysql:escape_string(-getElementData(elEquipo, "id")) .. ", " .. mysql:escape_string(monto) .. ", 'Factura médica', 13)" )
					outputChatBox("Pagaste tu factura médica ($"..tostring(exports.global:formatMoney(monto))..").", client, 0, 250, 0)
					outputChatBox(nombre.." pagó su factura médica ($"..tostring(exports.global:formatMoney(monto))..").", doctor, 0, 250, 0)
				end
			else
				outputChatBox("Ocurrió un error en la transacción. La factura médica no se pagó.", client, 255, 0, 0)
				local nombre = exports.global:getPlayerName(client):gsub("_", " ")
				outputChatBox(nombre.." no pudo pagar la factura médica debido a un error en la transacción.", doctor, 255, 0, 0)
			end
		else
			outputChatBox("No puedes pagar la factura médica.", client, 255, 0, 0)
			local nombre = exports.global:getPlayerName(client):gsub("_", " ")
			outputChatBox(nombre.." no pudo pagar la factura médica.", doctor, 255, 0, 0)
		end
	elseif accion == 3 then --negarse a pagar
		local nombre = exports.global:getPlayerName(client):gsub("_", " ")
		outputChatBox(nombre.." se negó a pagar la factura médica.", doctor, 255, 0, 0)
	end
end
addEvent("es-system:payMedicalBill", true)
addEventHandler("es-system:payMedicalBill", getResourceRootElement(), pagarFacturaMedica)

